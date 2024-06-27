
#!/bin/bash


# Assign arguments to variables
REPOSITORY=Archfx/bsp
TAG="$(date +v%Y.%m.%d)"
RELEASE_TITLE="$(date +v%Y.%m.%d)- "
FOLDER_PATH=output
NOTE="
The Broadcom Set Top Box PCIe controller signals an Asynchronous SError
Interrupt and thus causes a kernel panic when non-posted transactions
time out.  This differs from most other PCIe controllers which return a
fabricated 'all ones' response instead.

To avoid gratuitous kernel panics, the driver reads the link status from
a proprietary PCIE_MISC_PCIE_STATUS register and skips downstream
accesses if the link is down.

However the bits in the proprietary register may purport that the link
is up even though link training is still in progress (as indicated by
the Link Training bit in the Link Status register).

This has been observed with various PCIe switches attached to a BCM2711
(Raspberry Pi CM4):  The issue is most pronounced with the Pericom
PI7C9X2G404SV, but has also occasionally been witnessed with the Pericom
PI7C9X2G404SL and ASMedia ASM1184e.

Check the Link Training bit in addition to the PCIE_MISC_PCIE_STATUS
register before performing downstream accesses."

# Check if gh CLI is installed
if ! command -v gh &> /dev/null
then
    echo "gh CLI could not be found, please install it first."
    exit 1
fi

# Create a new release
gh release create $TAG $FOLDER_PATH/* --repo $REPOSITORY --title "$RELEASE_TITLE" --notes "Release $RELEASE_TITLE $NOTE"

# Check if the release was created successfully
if [ $? -eq 0 ]; then
  echo "Release created successfully."
else
  echo "Failed to create release."
  exit 1
fi