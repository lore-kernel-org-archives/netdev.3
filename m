Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B5502D5A;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634324; cv=none; b=qogPKrpbjzzOG38+qZjmvw2iNQfPJT/eqklTkMj5kOaqdjlPnTZ/bERxj68DF6T2KCQwBAMvzGQBRnrsGmGWxE23PlomeJ7d6xhjD4pagKKliQuZNAiWOmFhaM/Egk3LNbEG4NX5TJhN+xU6/t5U+h2Eh6h5Vf+lFxm/uljY56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634324; c=relaxed/simple;
	bh=SfifI8TQpgUZexAhVD3NGks7syaRBvoFyfKlLs0zn/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojWx/PsOgJmzK3hhNNwoWtGlxnAYf9/wXllOfjRECFx64xOjo9+7HEVAqgOHZDWXSh5ewvZxrkqxdw8c8oTQ4ghCXGsypTkJM/0r9aX863Iy/aXVKVqJ4VRv4Q9VFEskS7H/IoLAsACsWfIGQFVtXNyQGHnh1bo5gRQLsI03FA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPpoWmMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPpoWmMK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 520C6C4AF0B;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790634324;
	bh=SfifI8TQpgUZexAhVD3NGks7syaRBvoFyfKlLs0zn/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FPpoWmMKkvVk3FJ1qcGgR/PVMDTrOvK8RhjK9x6ALiHV89YhGVr6vXYfCZTyQPGnq
	 M0D73OIqXa8IOtTMGC9EyI4WOXlX31KgDzf2GRNQa70mnRqQVwNCabh2086+xhkjs0
	 dMhXN9gZuzdJqWoLMKP2QB4fFuwdOsQmxemLiI3rY2TEKslLJrgjdwzAFIKP6yIrwr
	 rQZuL42N6lRDxFRzWHHxJoZdkHeIBrG1F4GdAyYaVu2CPjGezQ59oVo8YAodopVf/3
	 NG6QSQFrEZg7aGncENBCIXRyThzgFXCbP1B2vV7NK3QVFYcME47i22Gl4tXvJBJxkH
	 QaLFjU3wsOWxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31925CA5FAB;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 28 Sep 2026 15:25:09 -0700
Subject: [PATCH net-next v8 02/11] Documentation: networking: Add timestamp
 related APIs to OA TC6 framework
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-s2500-mac-phy-support-v8-2-7e011aacc309@onsemi.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
In-Reply-To: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790634319; l=4547;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=Gmvv6Ti63vpPjCFKBovXvgYEOjZncBV6qOW2BKbcfl4=;
 b=MIpSr7dU1SurNcOhAAhIsrbD5h2LJ4LNPagCzdnHEM2PhnlVRJ34xZpY3Hj9SGnC3bd/8aYeN
 MlJ051tttgfARI243IHRvXSh5z2lHHVIx2cB1S3349Fzw9vKMV3P+GB
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Added new APIs to support hardware timestamp feature as defined in
OPEN Alliance 10BASE-T1x MAC-PHY serial interface specification.

Added the newer read/write APIs that takes MMS as one of its parameters
as these were not documented so far.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v8
  - Updated the the order of the parameters in oa_tc6_read_register_mms
    and oa_tc6_write_register_mms apis.
  - Removed the reference to ioctl
changes in v7
  - No change
changes in v6
  - No change
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
 Documentation/networking/oa-tc6-framework.rst | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
index 0feda2f9d840..5bcc194be7ea 100644
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
 
@@ -496,3 +500,58 @@ the MAC-PHY.
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
+                                        struct kernel_hwtstamp_config *cfg);
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
+.. c:function:: int oa_tc6_write_register_mms(struct oa_tc6 *tc6, \
+                                              u8 mms, u16 address, \
+                                              u32 value);
+
+Write a single register addressed by @mms and @address in the MAC-PHY.
+
+.. c:function:: int oa_tc6_read_register_mms(struct oa_tc6 *tc6, \
+                                             u8 mms, u16 address, \
+                                             u32 *value);
+
+Read a single register addressed by @mms and @address in the MAC-PHY.

-- 
2.43.0


