Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589171;
	b=xjsHKjMwmAUnkFxId2cP5VjcPBOzZL4zR16cOVxZFEOL7FfMxpttbVCUVLUzvfYOxHR7
	 Hh3xHvDJdP5y8SFCmfb7FCUa3tgCtfnygJ5xIlbVmjpMEqs48Dq9rkJPM3xIJvbhGvcox
	 +jrLsgB4AUkD47rFXnm90ZbjRvm0xar8rQRDitfkmoGt/7gK0T2vD8ckpqpcdRYDr5IfJ
	 cO+DswqDo3MlWbG44usMuDEmjd9lsRUqAXgUCTBwRNhJL/tdbD9b7jRljtuO0QsW1h07r
	 IxPB3NxM86ZE40iNEta7nCsoAFWFNUv0zXP6ijB7V6UNPWvKg5dWEGEpIqAJU1b7sKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589171;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4pypqGcSNUdVRRoCdiUFE8PmlB65Xyq0aKv0ce+rZUI=;
	b=AaeWAsGjnvbbWlbe1JvddLiaNeSF5s0z3jurjiAUFiaoF71tMMViH99nkwYvhfHK1+cO
	 ZNCcHIWnJsKRcne6e4/prLs/r8sCvX4+eUND0EifilhHF9LT404Dbo9k3E9yKUj332EWc
	 8f+1Cd218OYclSSccynmVd07jwSquoyZXhqTtct3aUZKZjjFMKhEwzXOqgezdzVApXqlT
	 Ovtwn+O6x5XX9+VeErh2alR4Kgo92Mm3mP+2LLLNwZDesPOHE8Jj6RbB1P+T8b2gEw718
	 sUKlDIcQo90VPI6aMGTM9X3yMBNQSLnuhnnMcwf4z/uOBnQpjsjpHFBsTyHRpyRm8Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjzJWBLn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A410606A891;
	Fri, 13 Nov 2026 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjzJWBLn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589171;
	b=KtMlrnz1mrFhUayQ5IuFUwPak9Gojsw9/7BeRV6qCzP2jATm23rqN3z7lZihFfF23zl9
	 SUazCnc9nbcdhc29OtcKLrikrxnWhFc80+YuwGX+v+FaFo8WENg/bv4Fvs68uFNKTJ/ZK
	 dsfdIN15PMLvmYalasSKKT3NfbpqHNwWZqaRlH00qyq+EXCrwScNHAAmMnR5bR5Sgr/z4
	 wtaNlkwZQd2W5zajE+eBmpyvmZ/Z3Ix50beNkWeO9Sj+Cs7tNKuRlUVYedtTnBzYUyj24
	 kKH6qkXJr15AT6rEHEK9qfGz/QM+BRLvPTcDMfl7W4xMq8RlyKosdKXyS1jbq4l3Eow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589171;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4pypqGcSNUdVRRoCdiUFE8PmlB65Xyq0aKv0ce+rZUI=;
	b=fBhDVC+LzY5pC4kqLC98Q2/CSaGF2D6f5NDPTehW8iUyE9shg4QvcDCrO6ZI56bwJ2Nd
	 LlkFtXlzicUPnnjmGcOsZQcTMVqLXwT0E4/0nl8g+JnXRvvV0Tq9NOiLfh8lMuf7zo83O
	 8awb22S2m0zoo1JnZxABCrCzD5Dwp5vh8tHfpsVORr48cPIgXENk9nrcSIPDkS9ITzBGg
	 2tfgvhg23jMEGg46dF5xETGkQ08Xk3rFBMwNQZnfQqkA1sBK926uqXrwRE251/E3o2xtl
	 CeCMMO32ePtZDaG/KRHCNrCbK0MNh4GqXRGax/j3uKbnYSoqAQlQ9aqXKNfip0IPf7g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 91B641F000C5;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589171;
	bh=4pypqGcSNUdVRRoCdiUFE8PmlB65Xyq0aKv0ce+rZUI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FjzJWBLnGbhFcn7BGl6By9aWMZzUxEsfhl2sPWiPa05WrqhUDpY231SQVNWYryO5B
	 c1YGGi7Va2tnV2DOuD0t46r7vu+mYMJlsXD+KBm7f3ycBGsCinvGH4TlTP6TL6Cixq
	 COCShunP0c5CbD9UI0hebbEjjut/0NNQCkYK6VYXzP/CBndaBiSMGASTfwZtRSzoMv
	 cE4Ufc4WNyf5pLQm9UmlM0CdcD9ojAtFY0BafGCN3V+OAwEh0nt/PI3B7dX+l965Dj
	 zmCtGd6NhOeIfPOGsfINobl+ofw+Hia3jXxADCqr9UZQYl3s408WUyicb0UfdCh/nh
	 zDhHp4J+biS+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 194A249A13;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:21 -0800
Subject: [PATCH net-next v11 02/14] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-s2500-mac-phy-support-v11-2-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=4611;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=xLdBSJ9hFuyUdf3dNQON5EpLXynKnlUGzimRNIU+R1o=;
 b=+7nG5t3gQxiDacdX9/lrKvBWWH/v/7RhVFW7b71tO3z8FTPj5ERm+jsJuBuIb8XltSdg8a3Zy
 7p7A5ayWk50BCqQJPzaGnhTDp0e//GYT5V0Z3miUen33pH3Rt+qshkx
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add new APIs to support hardware timestamp feature as defined in
OPEN Alliance 10BASE-T1x MAC-PHY serial interface specification.

Add the newer read/write APIs that take MMS as one of its parameters
as these were not documented so far.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Changed the wording of timestamp support to make it more clear
changes in v10
  - Added new API oa_tc6_tx_credit_threshold_set
  - Vendor introduced APIs to vendor support patch
changes in v9
  - Added Reviewed tag
changes in v8
  - Updated the order of the parameters in oa_tc6_read_register_mms
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
 Documentation/networking/oa-tc6-framework.rst | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
index 2545ef694016..111583609933 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -153,6 +153,11 @@ OPEN Alliance TC6 Framework
 - Forwards the received Ethernet frame from 10Base-T1x MAC-PHY to n/w
   subsystem.
 
+- If supported and enabled, timestamps are stored in the skb. Transmit
+  timestamps are requested via the TSC header field and read from
+  timestamp capture register A, B or C. Receive timestamps are
+  prepended to the frame when the RTSA footer bit is set.
+
 Data Transaction
 ~~~~~~~~~~~~~~~~
 
@@ -496,3 +501,52 @@ the MAC-PHY.
 Zero align receive frame feature can be enabled to align all receive ethernet
 frames data to start at the beginning of any receive data chunk payload with a
 start word offset (SWO) of zero.
+
+.. c:function:: int oa_tc6_ptp_register(struct oa_tc6 *tc6, \
+                                        struct ptp_clock_info *info);
+
+Registers the PTP hardware clock (PHC) with the kernel. Returns 0 immediately
+when the MAC-PHY does not support hardware timestamp. Otherwise it sets the
+name field of ptp_clock_info and registers the clock. Initialization of the
+other fields in the ptp_clock_info structure is left to the vendor as the
+PHC registers and their programming are vendor specific. The fields max_adj,
+owner, and all the functions for the clock operations, like adjfine,
+gettimex64, settime64, adjtime are expected to be initialized in the
+structure before registering the hardware clock.
+
+.. c:function:: void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
+
+Unregisters the PTP hardware clock.
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
+                                         struct ethtool_ts_stats *stats);
+
+Provides hardware timestamp related traffic statistics for ethtool.
+
+.. c:function:: int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6, \
+                                        struct kernel_hwtstamp_config *cfg);
+
+Helper to set hardware timestamp configuration. Part of net_device_ops
+callbacks.
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


