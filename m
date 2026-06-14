Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643FF3CE0B7;
	Sun, 14 Jun 2026 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456466; cv=none; b=VSBER45mgFEvokOp3OGXTkAAeF5/IVMU6fjPWonA9a9ZwPg5/xYonLD6znw+Ber9aTFz8CItefvZ/FAfO66LySf0/oOXVeciHAMlsTtWg838DhGrS02CXU520/4srj9S095FvJf6Z0aq6+oq6Dr9q6lB9NxHFEZQs5Gn6EY5nEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456466; c=relaxed/simple;
	bh=haRD3iWh8lEkBDoMO8u4q8c5sktBz24gX9ZpQmQ3ZuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3G2M0feCO59gHOjwjJxOtJGHYgSQu/+KazaylRcjFmcx5EmC0GahcJ2SeMlaiGUCd6Bi/R+FSE/Tmly7mgDzozrEZMce969llFJh12Xvf39ppz4EFMkF1oA+UhzYaewxodaEFGlpk5Em9GPA+Fz2DlYyFasmqIWz6IEQGMPCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeimB15z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeimB15z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44CF3C4AF63;
	Sun, 14 Jun 2026 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781456466;
	bh=haRD3iWh8lEkBDoMO8u4q8c5sktBz24gX9ZpQmQ3ZuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GeimB15zmKVZiWW+EPn3j2kmbyC51Z42GCa9RoCvQcsVGguZNME/+9iALPwLJIAlF
	 NWtS/hIBg+n1EePKDM1NNtasov/DpOGF4EJfKwM2rga6C4dUUYVuL0kgg1k8EIiM+P
	 iPTEPSTKuJZbsD+W0wENLmSKQ/TM5exwZ0sBUalTcUGkq2ODUFtVfVI81B1woBgVzC
	 b224CKieKOspgxCeD0XYOyOaDN4Dg8Lr+832S4RuA+h3mEzn4EzOch7kVBhYQJlcD+
	 ILvKwK37KhnY8eh0ATMwa3JUa/IdEGmWQHPY9LL941WhoLVBRCA3jucybNb+l1D6Li
	 folVm92sQf61w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913BCD98C5;
	Sun, 14 Jun 2026 17:01:06 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Sun, 14 Jun 2026 10:00:31 -0700
Subject: [PATCH net-next v5 15/15] Documentation: networking: Add timestamp
 related APIs to OA TC6 framework
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-s2500-mac-phy-support-v5-15-89874b72f725@onsemi.com>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
In-Reply-To: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781456463; l=5374;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=hgvCtdXBO6qNFB6GKYRybc5EVqfwJkm2Gr5Ztb9GTVE=;
 b=CNA0jMAaNWq1ffyVwbBtT4TTNlA7lbUBsbcpsdLQzeSFetL1zey1VVsb86NecKFUIYVrsTjC+
 xcYP7hLs3b9Dbj5qaCgRXTOw9XGL6cPvGOkoijuQhRPG0pGxWa30qTd
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Added new APIs to support hardware timestamp feature as defined in
OPEN Alliance 10BASE-T1x MAC-PHY serial interface specification.

Expanded read/write APIs to take new mms parameter to avoid
bit manipulation before calling regular read/write APIs

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v5
  - Fixed "no blank line" issues in four places
changes in v4
  - Added information for new APIs in OA TC6 framework
changes in v3
  - Added more information for documentation
changes in v2
  - Removed the changes to the existing API
  - Updated information about newly added APIs
changes in v1
  - Added changes to an existing API
  - Added documentation to new hardware timestamp related APIs
---
 Documentation/networking/oa-tc6-framework.rst | 80 +++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
index fe2aabde923a..325d299d1a7d 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -153,6 +153,10 @@ OPEN Alliance TC6 Framework
 - Forwards the received Ethernet frame from 10Base-T1x MAC-PHY to n/w
   subsystem.
 
+- If supported by the hardware and enabled, updates hardware timestamp
+  in skb, when indicated by one of the three timestamp capture registers
+  through TSC fields of the header.
+
 Data Transaction
 ~~~~~~~~~~~~~~~~
 
@@ -495,3 +499,79 @@ the MAC-PHY.
 Zero align receive frame feature can be enabled to align all receive ethernet
 frames data to start at the beginning of any receive data chunk payload with a
 start word offset (SWO) of zero.
+
+.. c:function:: int oa_tc6_ptp_register(struct oa_tc6 *tc6, \
+                                        struct ptp_clock_info *info);
+
+Registers the PTP hardware clock related functions with the kernel.
+This API simply registers. Initialization of the fields in the
+ptp_clock_info structure are left to the vendor as programming hardware
+timer is expected to be vendor dependent. The fields max_adj, owner,
+and all the functions for the clock operations, like adjfine, gettimex64,
+settime64, adjtime are expected to be initialized in the structure before
+calling the registering the hardware clock.
+
+.. c:function:: void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
+
+Unregisters the PTP hardware clock related callbacks.
+
+.. c:function:: int oa_tc6_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, \
+                                 int cmd);
+
+ioctl interface to handle hardware timestamp and PHY related commands.
+
+.. c:function:: int oa_tc6_get_ts_info(struct oa_tc6 *tc6, \
+                                       struct kernel_ethtool_ts_info *info);
+
+Provides timestamp related settings that are supported to ethtool.
+
+.. c:function:: void oa_tc6_hwtstamp_get(struct oa_tc6 *tc6, \
+                                         struct kernel_hwtstamp_config *cfg);
+
+Returns hardware timestamp configuration. Part of net_device_ops callbacks.
+
+.. c:function:: void oa_tc6_get_ts_stats(struct oa_tc6 *tc6, \
+                                         struct ethtool_ts_stats *ts_stats);
+
+Provides hardware timestamp related traffic statistics for ethtool.
+
+.. c:function:: int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6, \
+                                         struct kernel_hwtstamp_config *cfg);
+
+Helper to set hardware timestamp configuration. Part of net_device_ops
+callbacks.
+
+.. c:function:: void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
+
+Helper to map MDIO_MMD_VEND1 command to vendor specific Memory Map Select
+(MMS) value. This function offers flexibility for vendors that may have
+used any MMS value between 10 and 15 as allowed by the specification.
+MDIO_MMD_VEND2 is already mapped to MMS4 in the OA TC6 frame work code.
+
+.. c:function:: int oa_tc6_write_registers_mms(struct oa_tc6 *tc6, \
+                                               u16 address, u16 mms, \
+                                               u32 value[], u8 length);
+
+Writing multiple consecutive registers starting from @address for the
+given @mms memory map selector in the MAC-PHY. Maximum of 128 consecutive
+registers can be written starting at @address.
+
+.. c:function:: int oa_tc6_write_register_mms(struct oa_tc6 *tc6, \
+                                              u16 address, u16 mms, \
+                                              u32 value);
+
+Write a single register addressed by @address and @mms in the MAC-PHY.
+
+.. c:function:: int oa_tc6_read_registers_mms(struct oa_tc6 *tc6, \
+                                              u16 address, u16 mms, \
+                                              u32 value[], u8 length);
+
+Reading multiple consecutive registers starting from @address for the
+given @mms memory map selector value, in the MAC-PHY. Maximum of 128
+consecutive registers can be read starting at @address.
+
+.. c:function:: int oa_tc6_read_register_mms(struct oa_tc6 *tc6, \
+                                             u16 address, u16 mms, \
+                                             u32 *value);
+
+Read a single register addressed by @address and @mms in the MAC-PHY.

-- 
2.43.0


