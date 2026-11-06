Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007137;
	b=qDOZlfbxQq8kwbufteO1IItnA/oXQClKarFUs4fTKX7/sVapCZ3dDYl5GDaAKVW+Fh18
	 JbhYd7uE5pwRAjwlmqz3iKsQJcu0sXxS1P8dJn2gaaf9r59OOrzBO5cwiI2QuB9POxboh
	 w3O8SCI64VeM9gHlAOOBrQEiVErC44irywQMIiesIGz8WoTrpJpy0RG0ENdhcMPiCJHgz
	 BjWAXQ47/bpEOgOUVG6JQ19XNZz8js1KE7RlfsXRChT9bWiiwCMmwJI/0BJqyCarZ5tVy
	 IHI+omTKMXKubfn3isf35zUGSETb92g84GQ+5WTOc4O+1+R7wGeJP3VjvQ02mv8osIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007137;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gEdNJ0jr/S+uoVMQc1990sja3kz7rJbT28ZTYcXrXp8=;
	b=elv+7bPPK3tAXdqQ6SM1iIu/ClrZ1OoMX4aFsZdJvk9NQciMzEnsoJ3F+R/2ckXD8BQn
	 VCH4rDLUoDENywvBeovNdM7uyokpem7XqDI/I2LC4D1AJFD3Np6XKG0Acxlrk5tTH3Hnx
	 qyKlH4mGkpOfmC6umfTH2pZwWvZ3xO7r5p1I38PHf41Kl9LVT4ZnMswwuF7Kgi/Buz+UD
	 XSrs9spseWse1kXwNqmx2Xp5Z1p4aP0gEY9LpeHlFw4PhhUDg3Ti8vZEuEuQFMD0EJu/P
	 rq4s7C4dTe3DVQ4S4dfG6eZ6wRtmXWP2wxd1j9+sdUczPmz64MtNUUJKTFj7V8V9Gzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZhcLF5w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB6606A331;
	Fri,  6 Nov 2026 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZhcLF5w
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794007136;
	b=MKrxg0oJKNUtt82cPQuO69YegtDq1mVts+32Yt9UgjfTRTTL5Cr973EGyRPy2+iUryDa
	 fYxQ86UGq9RFXSO+erMu94xCY+B9K1+SBxJyn3AA9+cgUBJK9b1Cui8YxvS+M2JLLP2/k
	 YjgKjoovbP1EpvT8ctAVfYML7YfngaiIvHysk1yBZunQLr0cHlYrVUWOHVt+lRswbHSWE
	 VrYmTlqkHyVg39ufYTCYt2fj4/C8fLQKMoXN1DQidHYQUam3+hXUnGQ92EHMWUovdW+FJ
	 fS3sq7ZLKBQ5VU7qPL5n7s80rL4CjNDCZFuGcCdWCULF8L75rRhZQ+xvyt73PvVka1A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007136;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gEdNJ0jr/S+uoVMQc1990sja3kz7rJbT28ZTYcXrXp8=;
	b=ZfJ9IEU2jiFh0vMWESMxRJqiGBQpazmH/urcwn4gFDZv69rgHQwb+NI1tl17fQ0G2PdJ
	 Nt9I3oM9xp9IMCAj9N2CopO7hR4lnBi2cwWOUeJy6uOZ1oqu9vgz83gYr//Y94GVnukQ0
	 rZbd2UjWBLaaTsUTw6zguyzANUZ8+4kPNs3mny3fW2jM6D5n0Un5AMsisOHGkf9N1nMLw
	 C/ZS8CEacnp4FG9hDokFWXhtwENSYmP/g+ftviwIAYHV2DaSvGRPJmnWqQdVKVZ1rtYVH
	 SRp1pU67ltxcMIgueL+h8LVq03NFuB917rHFHKMvMYYtl+bQgGyAUjlmI1NTBPnk2VA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6F5C81F008A4;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007136;
	bh=gEdNJ0jr/S+uoVMQc1990sja3kz7rJbT28ZTYcXrXp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aZhcLF5wakRsFz4L7mQwrGXDa8oIvuMHcvcJNUDKahY4/xnp4fsZDrcDWtxh3AmtD
	 7Y0elnmGQ0VkbWWKjucs50cBhkyZRnnFwuorCL8K7Dpns7nr7JTyXfp/0BClhew/N/
	 H04ISLNnFIDv0ZdK0GB+iI+Ej08Rh557mY2ggj8c9AQCy169pUZ1bkpSzmJzNoYmkW
	 HXH9xTn6b2IjDp2A4d7omJVNHJ+ugnZy82qRvoz5NgdNVmgaFU7nJzJw6yv7gqAvmt
	 bxUeqxUqidag4p2BE8ao5gH/CR6nebJZtg0Ebpqi4PaDadrZRUi47uNwI7g+fXKUky
	 bi7s2uwlPmq9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E8E93478E0;
	Fri,  6 Nov 2026 23:18:54 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 06 Nov 2026 15:18:48 -0800
Subject: [PATCH net-next v10 02/11] Documentation: networking: Add
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
Message-Id: <20261106-s2500-mac-phy-support-v10-2-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794007133; l=4371;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=TQj40MeAfK84m72QQS7RSa38NlrNMy9ApV5T0s5visI=;
 b=4OYGPPSqrERH6DAaH2muaEdqBSZ3FYtlooNSuR+kO8QC5WYL7AvDWfE6Z3XWsbjnJV12l5n02
 kliUxLsXHbmBKceHUqairhkPf0mnr9HwixzMubSpUgL1USoh/cNjEj/
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Added new APIs to support hardware timestamp feature as defined in
OPEN Alliance 10BASE-T1x MAC-PHY serial interface specification.

Added the newer read/write APIs that takes MMS as one of its parameters
as these were not documented so far.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v10
  - Added new API oa_tc6_tx_credit_threshold_set
  - Vendor introduced APIs to vendor support patch
changes in v9
  - Added Reviewed tag
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
 Documentation/networking/oa-tc6-framework.rst | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
index 2545ef694016..23856c4bfd69 100644
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
 
@@ -496,3 +500,51 @@ the MAC-PHY.
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


