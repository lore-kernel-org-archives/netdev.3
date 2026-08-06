Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25A2777F3
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001501; cv=none; b=ZxC/dSW8g1su6Zit5MobWk4ekIw6IKCRem4PbC50PsilG0vZFLxL2n3hDxlQ05d0/efmcAG/i0G+8wEdebjZAZG1k0zBdf/Aaw7feHmZbLCpqYu6CCx1X3Fo6YiumP9VgH9i8NY8c+aXdNNYbRjB2cDO8SM7DTVxHb6kzOSl/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001501; c=relaxed/simple;
	bh=WJigues5/Zq//oA8yEj8xZ7mbFeDzXspYLRD/AhetSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6BhWmxH1fmGa5R3uFweFjScsJlxj6sp/I3rqOyNK2D/PBJseOkU++r/YpaGDhMKyG3snJv2Y30PArOR7g0AIEp4i8s40wS93cl3sIPmJqjsPZSFoH5WEi5AVDkYat/Ague7UND5PuQYzUDb1Pk6ugD6Hj2GNxGwCe56Nt407Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+IT+WPv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+IT+WPv"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-496b7622a83so14953365e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786001494; x=1786606294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uDqsWTzMDLL3yPNgURcpCw3SFq7morA76M8ptW4qhcg=;
        b=h+IT+WPvNsuwJ+crYFIV7Pz0nganmmtizLw4MIPYyQBDPQ33GYNiTuc4vBNLTbNQwb
         76/CPaiITobzc7xWkSB2IwGqk2yq4bHUoCBw9q03U6mhmJ9E0dPDk5+HCgvnKVH7879l
         0Oag2jjUXkgrYAmHddWxWKfsgqHtM16r8NIo9XZbTCV9MIEKo9CWv0b/58ROfbfkMWvc
         GTeFduTDal+bIH3FfSstLNc+QP4zC5U8g12dWMAZjdxKIaUYYcH4aXtMP9RDLBXEFw0g
         gZT4bCh8PaY5bnGG1Wm3Ha1A1NYLGs658Zx53E/I2NFxXuaogd0F3K/qlEEoZ+YvZcCj
         RUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786001494; x=1786606294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDqsWTzMDLL3yPNgURcpCw3SFq7morA76M8ptW4qhcg=;
        b=GzhZnzYjV3tX2O/o+8FrMbeSfTXt0d2UnZ3nSEFf5G9LPST4ZOQmzx1mDKXs83x8I2
         Dy/VFuLCta15WrabEmfsSMp/+DPF4mRFKausPS1JoDocYs92rMpikZWlEvw/SOkWgv0W
         u4br5AYD/ZdtjKdwCeGO4Vd+w73H5fBBgbL4AeVzjTdbhd+kavgzSdv1EMS85GqIxxfH
         wR+GnMulkuigI/YH+bydUiUauMHzIl+WTkK3KGwSYOX3fnzeSM+nl6vi3NtMTEyKDsvH
         FvBq2lqRfa4BV8mOhJiPmi4tYHNalanw1l1zithPjTvDIKwkrbhvCOCf/uP6CirMrdY6
         scMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2sURxdMuP3/B0urOYaloshdxmJv6kWQVHGCOqhjsLa9hSi9jl6KjHrQ2abPhrrEMCIW5JEQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1Y8X9AmxgojRsnHOCh1aryiY+AuTt/KNAwWDJuQiJoMGzxSZ
	oAe8GFCyn9cEeSvZxMy99BifcokuutYCON5m9wrW1EQQPFOJmWcKskjX
X-Gm-Gg: AR+sD10A+MhMXKXlZmmszYcqZ8FIBLQJnIAgFcompf/DSID/9jH3D5qjFSrDYp/idyB
	2EIiLfUURqzC42N8vcXMKmqSU5LSeRkQ37VISgefMCXZevyYemhctY+3FFeswqkbLHUXPlKxtmN
	V5g+faJqN1DE+8CyRveDIXfUY+GKkOBjnYcGG20vhJPPP5PRy9SJAQ+sJVL0y6Y8OieACc/SlgK
	ghdqRz+rLZP0lDtlP+NWS6fuW3Pg84iGq+1yqsRpoXa9HzyzPUMh/xIjrtCfP5oye6YkZaaXHpL
	OGEN7sfaD853n/eRAsqv6NiCFBVFPNwjIxe3RLy6u6WVqzO2ZU8HyqQe/U610lrLcVZxRaFT/wk
	XQ9eKkRlerrb5EOKRNiQCDZKNLj37p1TRgIuv1fMLIvTrifAYhk9EoAbnpY1xSFGO8nO8YkY4dS
	bYhnh7P9ds55olZSm3RfNvjEqjVoqxVHaggqV3eUUv48MEanBBIqmTFFpvIDzVMg==
X-Received: by 2002:a05:600d:4448:20b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-4994e7d21fdmr145198385e9.16.1786001493858;
        Thu, 06 Aug 2026 00:31:33 -0700 (PDT)
Received: from SVR.localdomain ([86.106.74.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e52d819sm79075085e9.1.2026.08.06.00.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:31:32 -0700 (PDT)
Sender: Semih Baskan <strstgs@gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
To: florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: dsa: b53: offload 8021q uppers on standalone ports
Date: Thu,  6 Aug 2026 10:31:19 +0300
Message-ID: <20260806073119.387-3-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806073119.387-1-strst.gs@gmail.com>
References: <20260806073119.387-1-strst.gs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

b53 keeps the hardware VID lookup enabled at all times:
b53_switch_alloc() sets dev->vlan_enabled and nothing ever clears it.
A VID that is absent from the VLAN table resolves to an empty member
set, so a tagged frame carrying it is discarded instead of reaching
the CPU. Disabling the lookup is not an option either, because that
moves the ARL to shared VLAN learning, where ARL operations force
VID 0 and the hardware table drifts away from the bridge fdb.

Commit 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when
not needed") stopped advertising NETIF_F_HW_VLAN_CTAG_FILTER on ports
that do not offload a VLAN-aware bridge, so creating an 8021q upper on
a standalone port no longer reaches .ndo_vlan_rx_add_vid and the VID
is never offloaded. Commit f089652b6b16 ("net: dsa: b53: do not
program vlans when vlan filtering is off") then made .port_vlan_add
skip the hardware write while dev->vlan_filtering is false, which it
is for a standalone port. Together they leave standalone ports unable
to receive their own tagged traffic.

This breaks a common configuration, a VLAN-tagged WAN for a PPPoE ISP.
The PADI leaves the port correctly tagged, the concentrator answers,
and the switch discards the tagged PADO, so the session never
establishes. Reported on an Asus RT-N18U in 2023 and still
reproducible.

Take the new needs_standalone_vlan_offload opt-in so DSA reports upper
VIDs again, and program VLAN entries that carry a standalone port even
while not filtering. Only the standalone members and the CPU port are
written to such an entry. A VID used by both an 8021q upper and a
bridge VLAN therefore does not gain the bridged ports as members, so
bridge VLANs keep having no effect while filtering is off, which is
what Documentation/networking/switchdev.rst requires and what that
commit implements. The PVID register writes stay gated on
vlan_filtering for the same reason.

b53_configure_vlan() used to restore entries only while filtering, so
restore the standalone ones there as well, otherwise the next
b53_apply_config() wipes them. Bridge join and leave rewrite the
entries of the moved port, because its standalone state is part of the
masking decision: joining removes the port from its uppers' entries,
and leaving adds it back, including uppers that were created while the
port was still bridged. When the last standalone member leaves a VID,
the entry is written back empty, so deleting an upper or bridging its
port returns the hardware to the state it had before the upper
existed.

Creating an upper whose VID the hardware cannot serve now fails
loudly instead of producing an interface that cannot receive:
b53_vlan_prepare() rejects VIDs beyond the VLAN table size on
BCM5325/BCM5365, and any tagged VLAN on BCM7278 port 7, which
cannot receive tagged frames. Previously the ndo was never called,
so such uppers were silently created broken.

Measured on an Asus RT-N18U (BCM53011 rev 5) against a peer device. A
probe over an 8021q upper on the standalone WAN port received 0 frames
before and 7 of 7 after, with the outbound direction as a positive
control and vlan_filtering staying 0 throughout. A static fdb entry
with VID 100 survived a vlan_filtering 1->0 toggle in hardware, since
dev->vlan_enabled is never touched and the ARL keeps using independent
VLAN learning. The PPPoE session from the report establishes.

Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
Cc: stable@vger.kernel.org
Signed-off-by: Semih Baskan <strst.gs@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 118 ++++++++++++++++++++++++++-----
 1 file changed, 100 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3f5b9592794d..ba1266cd70c3 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -898,10 +898,52 @@ static bool b53_vlan_port_may_join_untagged(struct dsa_switch *ds, int port)
 	return dp->bridge == NULL;
 }
 
+static bool b53_vlan_hw_entry(struct dsa_switch *ds, const struct b53_vlan *vl,
+			      struct b53_vlan *hw)
+{
+	struct b53_device *dev = ds->priv;
+	bool standalone = false;
+	struct dsa_port *dp;
+	unsigned int port;
+
+	*hw = *vl;
+
+	if (dev->vlan_filtering)
+		return true;
+
+	hw->members = 0;
+	hw->untag = 0;
+
+	b53_for_each_port(dev, port) {
+		if (!(vl->members & BIT(port)))
+			continue;
+
+		dp = dsa_to_port(ds, port);
+
+		if (!dsa_port_is_cpu(dp)) {
+			if (dp->bridge)
+				continue;
+
+			standalone = true;
+		}
+
+		hw->members |= BIT(port);
+		hw->untag |= vl->untag & BIT(port);
+	}
+
+	if (!standalone) {
+		hw->members = 0;
+		hw->untag = 0;
+	}
+
+	return standalone;
+}
+
 int b53_configure_vlan(struct dsa_switch *ds)
 {
 	struct b53_device *dev = ds->priv;
 	struct b53_vlan vl = { 0 };
+	struct b53_vlan hw;
 	struct b53_vlan *v;
 	int i, def_vid;
 	u16 vid;
@@ -937,20 +979,23 @@ int b53_configure_vlan(struct dsa_switch *ds)
 	}
 	b53_set_vlan_entry(dev, def_vid, &vl);
 
-	if (dev->vlan_filtering) {
-		/* Upon initial call we have not set-up any VLANs, but upon
-		 * system resume, we need to restore all VLAN entries.
-		 */
-		for (vid = def_vid + 1; vid < dev->num_vlans; vid++) {
-			v = &dev->vlans[vid];
+	/* Upon initial call we have not set-up any VLANs, but upon
+	 * system resume, we need to restore all VLAN entries.
+	 */
+	for (vid = def_vid + 1; vid < dev->num_vlans; vid++) {
+		v = &dev->vlans[vid];
 
-			if (!v->members)
-				continue;
+		if (!v->members)
+			continue;
 
-			b53_set_vlan_entry(dev, vid, v);
-			b53_fast_age_vlan(dev, vid);
-		}
+		if (!b53_vlan_hw_entry(ds, v, &hw))
+			continue;
 
+		b53_set_vlan_entry(dev, vid, &hw);
+		b53_fast_age_vlan(dev, vid);
+	}
+
+	if (dev->vlan_filtering) {
 		b53_for_each_port(dev, i) {
 			if (!dsa_is_cpu_port(ds, i))
 				b53_write16(dev, B53_VLAN_PAGE,
@@ -1720,6 +1765,7 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	struct b53_device *dev = ds->priv;
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	struct b53_vlan hw;
 	struct b53_vlan *vl;
 	u16 old_pvid, new_pvid;
 	int err;
@@ -1751,13 +1797,14 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	else
 		vl->untag &= ~BIT(port);
 
-	if (!dev->vlan_filtering)
+	if (!b53_vlan_hw_entry(ds, vl, &hw))
 		return 0;
 
-	b53_set_vlan_entry(dev, vlan->vid, vl);
+	b53_set_vlan_entry(dev, vlan->vid, &hw);
 	b53_fast_age_vlan(dev, vlan->vid);
 
-	if (!dsa_is_cpu_port(ds, port) && new_pvid != old_pvid) {
+	if (dev->vlan_filtering &&
+	    !dsa_is_cpu_port(ds, port) && new_pvid != old_pvid) {
 		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port),
 			    new_pvid);
 		b53_fast_age_vlan(dev, old_pvid);
@@ -1772,7 +1819,9 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 {
 	struct b53_device *dev = ds->priv;
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	struct b53_vlan hw;
 	struct b53_vlan *vl;
+	bool needs_hw;
 	u16 pvid;
 
 	if (vlan->vid == 0)
@@ -1782,6 +1831,8 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 
 	vl = &dev->vlans[vlan->vid];
 
+	needs_hw = b53_vlan_hw_entry(ds, vl, &hw);
+
 	vl->members &= ~BIT(port);
 
 	if (pvid == vlan->vid)
@@ -1791,14 +1842,18 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
 		vl->untag &= ~(BIT(port));
 
-	if (!dev->vlan_filtering)
+	if (!needs_hw)
 		return 0;
 
-	b53_set_vlan_entry(dev, vlan->vid, vl);
+	b53_vlan_hw_entry(ds, vl, &hw);
+	b53_set_vlan_entry(dev, vlan->vid, &hw);
 	b53_fast_age_vlan(dev, vlan->vid);
 
-	b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), pvid);
-	b53_fast_age_vlan(dev, pvid);
+	if (dev->vlan_filtering) {
+		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port),
+			    pvid);
+		b53_fast_age_vlan(dev, pvid);
+	}
 
 	return 0;
 }
@@ -2261,6 +2316,28 @@ int b53_mdb_del(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_mdb_del);
 
+static void b53_standalone_vlan_resync(struct dsa_switch *ds, int port)
+{
+	struct b53_device *dev = ds->priv;
+	struct b53_vlan hw;
+	struct b53_vlan *vl;
+	u16 vid;
+
+	if (dev->vlan_filtering)
+		return;
+
+	for (vid = b53_default_pvid(dev) + 1; vid < dev->num_vlans; vid++) {
+		vl = &dev->vlans[vid];
+
+		if (!(vl->members & BIT(port)))
+			continue;
+
+		b53_vlan_hw_entry(ds, vl, &hw);
+		b53_set_vlan_entry(dev, vid, &hw);
+		b53_fast_age_vlan(dev, vid);
+	}
+}
+
 int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 		bool *tx_fwd_offload, struct netlink_ext_ack *extack)
 {
@@ -2324,6 +2401,8 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 	b53_write16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), pvlan);
 	dev->ports[port].vlan_ctl_mask = pvlan;
 
+	b53_standalone_vlan_resync(ds, port);
+
 	return 0;
 }
 EXPORT_SYMBOL(b53_br_join);
@@ -2376,6 +2455,8 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 		vl->members |= BIT(port);
 		b53_set_vlan_entry(dev, pvid, vl);
 	}
+
+	b53_standalone_vlan_resync(ds, port);
 }
 EXPORT_SYMBOL(b53_br_leave);
 
@@ -3213,6 +3294,7 @@ struct b53_device *b53_switch_alloc(struct device *base,
 	 * devices. (not hardware supported)
 	 */
 	ds->vlan_filtering_is_global = true;
+	ds->needs_standalone_vlan_offload = true;
 
 	mutex_init(&dev->reg_mutex);
 	mutex_init(&dev->stats_mutex);
