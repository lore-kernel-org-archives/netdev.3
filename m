Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408272;
	b=hJbbB469tDT5deDMW/jJlYN0TABV8sCKqbgFhdHfbSbwlxlCF9ObxKiHuNXxh7HzK29r
	 qsBfxE9dkfrO5AGFll5BjjT3dykckUzeZUjVjPJgGYUFmIgYfqsd4R1axXZDeNJgRSmsn
	 bEVA3PxgeB0i4WiD3JDn5QimUxElt751RF8YPlk08fiSJM1DWWtuFazmKFfp3fyxydzO9
	 p4yFTeD5SJwZVt+Z7rjv2B+i2HXW4BB+KLtmmyX7520AzKPY8PyuQEfvuO7v92KUV5hW7
	 gg2uLA9I5BXUweWabASRP2aWNj2LfEpzkryzr+gemve5Ya+AzxjjG+UDrB4g7k/eDQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dr/c6inyZfcsokKdZljfnN0MuHP4f675XnQJYTzje7k=;
	b=1nemkNzlEK85h8/3j/lsin945PwCuTbYoK2fv5oorQyN1ATgY0vLX7K5OXF4rodIYoJn
	 ab9n1JOTn2nR7HeXMseRm4ullRAh6rZlUjLvUUhHfGl8rCOZcFbvNmkT6/9NuW3JO5bak
	 qJiD9G3RCq6UL1ZSrecl5RkIYByWdNN4ydYxCK8juXb97p0Sizz2ZUjEooHlErTPmY10L
	 JGLSURdxzhpnR+/2LQjiBoCjOMM5iDS8z4Wq/kqNrRCCl92kJMiRVnDBfP2pgbwbwfw3b
	 T+Hr9fXJCX9zh8LgiA8+XL2fAEKbuCdu+OrPtwSSjMXtHohrPi6IstNIGNTZ2A5XdxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VcsgH8HM;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0556E606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0556E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VcsgH8HM
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so32746305e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408269; x=1795013069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dr/c6inyZfcsokKdZljfnN0MuHP4f675XnQJYTzje7k=;
        b=VcsgH8HMjHh6IbbGvxMNETPS9g8apuKNu5eJ5iW0JHzhfFRLyj3NgajkhFNAEktPCH
         Tcxkxens/u5o9tOI+SgiHKSYztMgHT+ABtnAa/EAIdKklMdVcpK/v+qBjQ3JgYAoAv0G
         A9u/9sqv+BXhyVzbudCWvmcPV77gPHc2wZ0H38yV0/1VK7iOn3oNH2rTeh57ASrPNQvt
         GpJtOGRaKmmxu3k94Y0w8XyI6IjWqm4UuXTIwEOYbo1fe/1UaHehatmslLRrbI803Tr9
         3b6AW5APnF0RV//L+nunU1R1VTFuVOtQUv0FnhGENHp8O7W6phoFeNWzKEF2RVFBnyIG
         ZUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408269; x=1795013069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dr/c6inyZfcsokKdZljfnN0MuHP4f675XnQJYTzje7k=;
        b=Bwl4SykRw/aGBh7tiqZGTcM1iQjkoSZe0fJhQ627A67BI4FWrSOrjtMy+7gWmJdbHh
         rzkdnvN1+BedWZySNu7PKIHiBipdScGMIQx4HP/7MwzeyWAIUIysl3vw83dZTR/g5Vjg
         XxnpJPxpU+t3xEn2V2JJU0AXwxAE4+033dAKPiU4gby0HrfPrWyq1rrYuXhldECLJtLf
         CKebc3RXIKw45TAceRXdWFNPXFGyScj2+dsEk8c3/dvDtsO28F9O2oyGz28l7Ey39Mhl
         Dhupcw3iip8Xo0hsjMNvbM/3DR3AtCLBa3NuLbyCI9MmGIk4wO2wJ+XeFAM5BJzbE3Mo
         6gLA==
X-Forwarded-Encrypted: i=1; AL+hErHW+VP9JPVve0DN7JYzSOaULft886uZqEnw1gSvkKJeY8wBEbCus6PTRckc+oxyga7y3k56jTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qkNtrLgQwPzuOwqNU6XWu+WwQELGQTjZQlO4d7Rs20QoN5YlQ
	3VsUJrAbUgXPhg5BF+v9MuE3HVvfA7peyEtwgLWH5xAFRC/btowRBydB
X-Gm-Gg: AYBFou2LCN4lzU8ZQzNmLET7c5E9/Om+fboLnb3VcIKDER02MIUnQMqlEYtW8xKQTFB
	4SL4V2VI0ez9wy7CnvcqBhfCWjAqOkqMuVBmKKvP1ysknLkkpFxqjPZTqnKda5FiHEzqFkQMV5o
	NqTpspzyhGqHYO44S2QL7ZLpTfKzybCIRPRgt/khIbl8yqDT7LZbMpw/lcQ+42yJv0Xsyn+1O2P
	DNJlHNbfP3xOIPIGO6jNkWQSfgGdKbq439LZqg8tj6T8Fu3+XUAlwD4ytOeWgU9+fpJsnIzCnSG
	SKfYH82SpzzYHk+BnGmbnAWRIdFHKwalLbs2uuYoFboGaVSrYEw/EBvYhH/dgs0D7H43PzxoX2v
	1pAGJQnSDC/E/h5a51ANl5cKwrbES0TZFb1azg4eONzLfmYetcaf4m2uiVVXK/vqdin+7OqwFOq
	zoykKS74Cx8r98hdYU5MGWiT7oVEuHMXIxT1LddVBsJsZTDkH+u67oOc6RoPmGnJDouZ0/YM3cK
	kQNCHGgNtLrtfc9vTA+JpWdQMxp7huF+pYskYu6XnotiTYNgr+OZ4vr24bQyuCFvYEXhDrLier/
	ZDriJikPWp/8iq9CsvELjAy1rYeye1se5J4=
X-Received: by 2002:a05:600c:3b01:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4ba09344326mr47001535e9.3.1794408269178;
        Wed, 11 Nov 2026 06:44:29 -0800 (PST)
Received: from dev.Default ([86.127.229.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08de826asm46656495e9.0.2026.11.11.06.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:44:28 -0800 (PST)
From: Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
To: Navid Ghahremani <ghahramani.navid@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Junyang Han <han.junyang@zte.com.cn>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 0/5] net: ethernet: zte: zx279128s: offload flows to and from WLAN interfaces
Date: Wed, 11 Nov 2026 15:44:21 +0100
Message-Id: <20261111144426.1321237-1-isasmendi.agus@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series lets the ZX279128S switch driver offload flows whose ingress
or egress is a mac80211 AP interface, so that WiFi <-> WAN NAT traffic
no longer goes through the CPU's forwarding path.  It is based on Navid
Ghahremani's v2 platform series, which adds the SoC and the driver:

  https://lore.kernel.org/r/20261014072109.1759502-1-ghahramani.navid@gmail.com

The switch fabric has a second DMA engine (a ring pair the vendor
firmware uses for exactly this) and 16 "WLAN logical ports" that a
classifier entry can name as ingress or egress.  Patch 3 adds the ring
and the ports; patch 4 binds a mac80211 interface to a port on first
use and accepts flows from the flowtable in both directions; patch 5
adds debugfs testing aids.  Patches 1 and 2 describe the engine's
interrupt.  The WLAN drivers are not touched: the frames the fabric
forwards are handed to the interface's normal transmit path, and the
frames of offloaded flows are picked up on the interface's ingress hook
and injected into the ring.  Any mac80211 driver works.

This is not a WED-like path: the SoC has no block that chains the two
DMA engines, so the CPU still runs the WLAN driver's own transmit and
receive paths for these frames and moves the buffers between the rings
(no copies on the forwarded path).  What it no longer does is the
bridge, routing, conntrack and NAT work, which is where the CPU time
went: CPU0 drops from 54 % to 13-25 % at the rates below.  This is also
how the vendor firmware uses the engine.

Sent as RFC because:

- the base series is not merged yet, so this cannot be applied as is;
- a mac80211 AP interface cannot be put in an offload-enabled flowtable
  today, since mac80211 answers -EOPNOTSUPP to TC_SETUP_FT and
  nf_tables rejects the device.  This series was tested with Felix
  Fietkau's OpenWrt patch that ignores -EOPNOTSUPP there
  (target/linux/generic/pending-6.18/
  701-netfilter-nf_tables-ignore-EOPNOTSUPP-on-flowtable-d.patch).
  Felix, do you plan to send that upstream?  Without it, or something
  like it, this feature cannot be enabled on mainline;
- design: binding a WLAN interface to a switch port from the ethernet
  driver, through the interface's regular paths, keeps the WLAN drivers
  out of it.  I would like to know whether that is acceptable or
  whether this should go through something closer to the mediatek WED
  model.

The SoC has an unrelated problem under WiFi traffic: a PCIe read on one
CPU deadlocks against L2C-310 maintenance on the other, discussed in

  https://lore.kernel.org/r/20261110153522.1620088-1-isasmendi.agus@gmail.com

This series was tested with both workarounds under discussion (a lock
around the PCIe reads, and the L2 cache off through the device tree)
with the same results.

Results on a ZTE ZXHN H3600 (MT7915 as AP, a phone as client, flowtable
with lan, wan and the AP interface, NAT on wan):

  WAN -> WiFi download     393 Mbps offloaded, 109 Mbps on the CPU path
  WiFi -> WAN upload       186 Mbps (capped by the upload server), 60
  30 min soak              111 transfers, none failed, ring counters
                           consistent, kernel log clean
  cold / warm boot gate    17/17 and 5/5 boots, offloaded traffic on
                           each, no hang

IPv6 flows are not offloaded, as in the base driver.  The register
sequence and descriptor layout were reverse engineered from the
vendor's GPL kernel.  Builds without warnings with W=1 (board config
and multi_v7_defconfig); checkpatch --strict, dt_binding_check and
dtbs_check are clean.

Agustin Santiago Isasmendi (5):
  dt-bindings: net: zte,zx279128s-gmac: add the WLAN DMA interrupt
  ARM: dts: zte: zx279128s: add the WLAN DMA interrupt
  net: ethernet: zte: zx279128s: WLAN DMA ring and logical ports
  net: ethernet: zte: zx279128s: offload flows to and from WLAN ports
  net: ethernet: zte: zx279128s: debugfs knobs for the WLAN ring

 .../bindings/net/zte,zx279128s-gmac.yaml      |  20 +-
 arch/arm/boot/dts/zte/zx279128s.dtsi          |   4 +-
 drivers/net/ethernet/zte/Kconfig              |   5 +-
 drivers/net/ethernet/zte/Makefile             |   3 +-
 drivers/net/ethernet/zte/zx279128s-eth.h      | 124 ++-
 drivers/net/ethernet/zte/zx279128s-main.c     |  18 +-
 drivers/net/ethernet/zte/zx279128s-ppe.c      |  92 +-
 drivers/net/ethernet/zte/zx279128s-wlan.c     | 874 ++++++++++++++++++
 8 files changed, 1114 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/ethernet/zte/zx279128s-wlan.c


base-commit: 96b4b72978e9fcfdd74f809c159f26813995631b
-- 
2.30.2

