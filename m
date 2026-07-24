Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBCB35C69F;
	Fri, 24 Jul 2026 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878611; cv=none; b=Fl5a+ktD2hvmSlBE9ubqj89v4ZoYVXmlJ602cRANtIKKPp7cwLAiMYsk8hc1xnnOt87JucwthB1NXH0fBBScWDIMEnhvXYJiJ4OuR+NG6dmzFKAc+tODJLI37Chx2YRpmpTGIEb0cRtCHhSdBSeD7hsBydDjrQjT8x95m4sbjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878611; c=relaxed/simple;
	bh=0diy6qlRXuxFGZ27mChpVFYPLzDkwrnmHPicVhg7ai4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P6j6uUuAKrcC5dZaHSny5uFE3KTCSu/5QOjNyS7bT5oAcgcj0UUc5nnfIsC7HEmthg6PJMKRPES+YRGkywhhSLdcGcVxvWAaferMQ8dpT/PZn03S0aZgCRPiLryybY+Djg267/QUifzXF9eZCfFrDUjbSw/MH/J9OIhS3Fh2s94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DyNqk5is; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=FCk1B2cQ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DyNqk5is";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="FCk1B2cQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878607;
	bh=0diy6qlRXuxFGZ27mChpVFYPLzDkwrnmHPicVhg7ai4=;
	h=From:Subject:Date:To:Cc:From;
	b=DyNqk5istaG8XQtZGQchgw6nrbbeJZju7Eg8EzYsp0gqEtoA5TYkq2jQ7RobmwJI3
	 /PABQyYkcTx4CPTSudAs4GcVa9QAnH7lBC1FLd9RiMF+1P9nl1AM6r/kysmXMTttz0
	 2mYUC3gaE9Td4ncrCJwf8Dn4xUkPp7fPbUfyQkKD6mwomwXv3taX1xk9JkRgZYS5sc
	 tIuBf/e19Vr4NXnuJJYExjH/2/T9C2txtLI+l/OLpV7mRedHuf2pzAKF7eBiB7XHBR
	 65T8RKfwfiVqzVMFyajs50qZoO4j4MoaXfnHMjNWvBJlbKxm93ea9QYbsx8oGtA341
	 fJVScttpmgSNw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B280D49369; Fri, 24 Jul 2026 07:36:47 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878606;
	bh=0diy6qlRXuxFGZ27mChpVFYPLzDkwrnmHPicVhg7ai4=;
	h=From:Subject:Date:To:Cc:From;
	b=FCk1B2cQClfM4nDfvDdKVX3xrL00CkRx5Mui7O/CmPiwO/enItvwVGnFpR/WfN7nU
	 /ffkLBfL01f7j2u7poF79y8xAnD+WNx+F59FoQp00jVTxiwcj9XQF4IKoPmcmRnMss
	 kROOK4Gz+rNcKPa7gURxi5RFQHb/W3KF95rzNL6vM8TkjhluduVtNxeB4ARlobPXGS
	 08g4Pes2yEKPm/GmIUcj8pVMsJ2pnU4NI6kZBN/hX5McZtEyZD0reMv6ksv+rZxrCj
	 p8w4qlrtucc03mM03G6+xOyMI/cLlgh3clkIZikkuJvapEG5P5PaPqVPXEXpuRtetI
	 sOWfgwXrmOoEA==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7DEA448EFC;
	Fri, 24 Jul 2026 07:36:46 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v3 00/13] ax88179_178a: Add support for
 AX88179A-based chips
Date: Fri, 24 Jul 2026 09:36:43 +0200
Message-Id: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsWY2oC/23NwQ6CMBAE0F8he7Zmtw1t9eR/GA9gt9BoiimEo
 IR/t+lFDh4nM3mzwsgp8AjnaoXEcxjDEHNQhwrufRM7FsHlDBKlRq1QNIu1ZE6NaMjZk2dJRiH
 k+SuxD0uhrhB5EpGXCW656cM4DeldPmYqfeEM0o+bSaAgpW3tvDY11Zc2pI6TeAztM0yfo+OCz
 XIP2B0gM4AW0bNrJZP+B2zb9gUdZ7nO8wAAAA==
X-Change-ID: 20260630-ax88179a-a1d89fe21730
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

This adds support for the current generation of ASIX network adapter chips,
which are based on the AX88179A. This includes the AX88179A/B (1GBit-PHY),
AX88772D/E (100MBit) and AX88279 (2.5GBit).

The AX179A-based chips all provide both a CDC-NCM compatible USB interface,
and a proprietary vendor interface with more features. By default, the
proprietary vendor interface is not active and Linux will load the CDC-NCM
driver to support the devices. If the ax88179_178a module is configured by
the OS to have precedence over CDC-NCM, then this driver will switch the
device to use the vendor interface, and the device will be controlled by
the ax88179_178a driver when the device is probed again after an automatic
reset of the device bringing up the vendor interface.

The following hardware was tested:
Delock 66046 2.5GBit adapter (AX88279, FW: 1.2.0.0)
TP-Link UE306 1GBit adapter (AX88179B, FW: 1.3.0.0)
Renkforce RF-4708614 1GBit adapter (AX88179A, FW: 1.0.4.0)
UGREEN CR110 100MBit adapter (AX88722E, FW: 1.3.0.0)

The driver supports the following features
- EEE
- TCP segmentation offload
- VLAN filtering/tagging offload 
  (NETIF_F_HW_VLAN_CTAG_FILTER, NETIF_F_HW_VLAN_CTAG_RX/TX)
- RX/TX checksum offload
- FC/Pause configuration
- EEPROM read access

The code is based on the ASIX 4.1.0 out-of-tree driver published under
the GPL,, the aqc111 driver which provides support for the AX88279A,
and some tracing of USB-transfers of the Windows-driver.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
Changes in v3:
- Add PHY drivers for the PHYs of the AX88179A-based controllers
- Use phylink for the AX88179A-based chips
- Link to v2: https://lore.kernel.org/r/20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de

Changes in v2:
- Correctly use net-next prefix
- Fix compilation issue in HW support patch
- Split MMD support patch into patches for EEE/new chip support
- Do not use ADVERTISE_RESV but private flag definition
- Fix pause configuration to keep track of settings when autoneg disabled
- Fix issue with unitialized variable reported by kernel test robot <lkp@intel.com>
- Avoid white-space changes

- Link to v1: https://lore.kernel.org/r/20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de

---
Birger Koblitz (13):
      ax88179_178a: Fix endianness of pause watermark register
      ax88179_178a: Add HW support for AX179A-based chips
      ax88179_178a: Use MMD accessor functions for AX88179A
      ax88179_178a: Add EEE HW configuration support for AX88179A
      ax88179_178a: Use phylink in get/set_link_ksettings
      ax88179_178a: EEE setup for AX88179A-based chips
      ax88179_178a: Obtain speed and duplex from Interrupt URB
      ax88179_178a: Add support for ethtool pause parameter configuration
      ax88179_178a: Add VLAN offload support for AX88179A
      ax88179_178a: Add ethtool get_drvinfo
      ax88179_178a: Add support for AX88179A/772D/279 EEPROM access
      ax88179_178a: Add AX179A/AX279 multicast configuration
      ax88796b: Add support for AX88772D, AX88179A and AX88279

 drivers/net/phy/ax88796b.c     |  194 +++++
 drivers/net/usb/ax88179_178a.c | 1596 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 1630 insertions(+), 160 deletions(-)
---
base-commit: 1a9edf8be190decb17227e3cba540513d93ebb85
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

