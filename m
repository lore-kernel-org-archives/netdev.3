Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964D3921D6;
	Wed,  1 Jul 2026 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885127; cv=none; b=dMt7fngXDjYrFxXtEuAVNIh+wFOl4SvPzrKOMSoApd+iKxDjnwgQBq4vDmuhf7MVorIwI9E6AM8nydlGwpAgq0hfJ6vabgE/wwoRps4ZqgpNKqa5hAhBq4uJxnGI4GrAxP0yH9smfU3lXOtVkSX801R+vSX3o4rTHqIUI2l6gEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885127; c=relaxed/simple;
	bh=cSIHKqQqQSVkZghhQZKooSuo/Mnsh22EsKizDxAoKOM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IFxgCGCBgy2i80O1Ih6C2Yv4v+LGZrCI8TCJoBmojkamAmKiVGA6JdUeRU0Q3UXQVO+I//7xFjEa36FKASLTMku1bf0xpuakWi2Y8znAION4C29FDsDHcCvsRDx4qqu1el9HKWNz8we2o3Xe836Do79TGSuHmTtwAxfdHc01kVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=S6K+GKXR; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=so7O4hok; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="S6K+GKXR";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="so7O4hok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884571;
	bh=cSIHKqQqQSVkZghhQZKooSuo/Mnsh22EsKizDxAoKOM=;
	h=From:Subject:Date:To:Cc:From;
	b=S6K+GKXRzZAZD6oYqdcwcq6K3VGWuy9eIzTKYaJNTL5ItZg7UAIK79sKrhc7Zvy7Q
	 eOGj1hXro1QyPlkV+IoaeHmOAn3EnCtDmeM8BEqd17ihHjQPgMENvEpsowhH/dBE9k
	 uLoAk2aN/uOGsZzynV2jEaasdOVKL90X6zDrRVRMhzPZSelMUTuCPnkc91Qq0r1G1f
	 TPQoxWbYUkqXAQWO6Jz4df5V68ws82I4vsc0Agyqgerb9A70zuevzoC6LfmB3JzxTK
	 UREoAx6n5QMGC0xCFlulLMyHSRSWn4Xd3S1uYfvoxJOFRTygpqyRQw5EbNlNFOsqpB
	 RPkw9aE0zAMWQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 19CDC49348; Wed,  1 Jul 2026 05:42:51 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884570;
	bh=cSIHKqQqQSVkZghhQZKooSuo/Mnsh22EsKizDxAoKOM=;
	h=From:Subject:Date:To:Cc:From;
	b=so7O4hokVzf1N3eXBaw/LgjQ0jocYYbhv8VkiBPb5hQUyeastvruFCzSWtxekmk8X
	 lWmkLqMYc8COsIOq+prebrWUzVrIC9SP2zjOJVmKhyMP1hU+XUQ40l9YTGlJJMxIyV
	 xJU/4L7OLiW7oZKmjnQIpjnJLD3zs1O/3oBP6bgPwStzs7MKEGokpWD9B2mtdVQflR
	 zIaERDBr9BTyP2kpXRqAxxeFKn6VD6SA6O2mqclLxsN/Nm6D32P9lKntRReNGoiiKt
	 h14E6/req0aJZxHpEsCGBqhJtmdI/XJi5GMompntiey5+T+RM7JV8j91aytr6sjxzd
	 i6cSfZ1DNVp6Q==
Received: from DebianDesktop.lan (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5CA27492B4;
	Wed,  1 Jul 2026 05:42:50 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH 0/9] ax88179_178a: Add support for AX88179A-based chips
Date: Wed, 01 Jul 2026 07:42:46 +0200
Message-Id: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANaoRGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM2MD3cQKCwtDc8tE3UTDFAvLtFQjQ3NjAyWg8oKi1LTMCrBR0bG1tQC
 WNmD7WgAAAA==
X-Change-ID: 20260630-ax88179a-a1d89fe21730
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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
Birger Koblitz (9):
      ax88179_178a: Fix endianness of pause watermark register
      ax88179_178a: Add HW support for AX179A-based chips
      ax88179_178a: Add support for AX88179A MMD access
      ax88179_178a: Obtain speed and duplex from Interrupt URB
      ax88179_178a: Add support for ethtool pause parameter configuration
      ax88179_178a: Add VLAN offload support for AX88179A
      ax88179_178a: Add ethtool get_drvinfo
      ax88179_178a: Add support for AX88179A/772D/279 EEPROM access
      ax88179_178a: Add AX179A/AX279 multicast configuration

 drivers/net/usb/ax88179_178a.c | 1459 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 1316 insertions(+), 143 deletions(-)
---
base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

