Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF745199A
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764559; cv=none; b=c7wlE9HdX0IBCxUJj5U6NHxBXfFlmAW6sak00wvMQsI+a7tsGtSJYGH2VPuxav8wChdtGRE/EGZUln5zE5Sw5U3X1PqJD5nHoFkMmfvFttQlFw/7ZiwQMUKeZAtTl5ZZVukxXBC7n6UTu5hAH8VgMUFAIUWXHfjJ0DTGSseq6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764559; c=relaxed/simple;
	bh=pwsgYrDpy9ZexXWLtuZmq8gOTDyG1/qZ/0ZlSBjEGxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diRoUUgAUvsKIcWImnoc5vKoPDndkF2vUeS3qM2LqtbhZPqoS+y35d+k/nnIW2hBRGU1fecrfEJXzJ14KLu0jTI+CUzrIZQKayKqVUCiJS9pHB0XGJ/Gn1KZAgW+MkqNCrKt7bcIrcAiIoWGXwX+wzPuwRU8fIR+N26ZeKLn044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1iyiKeq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1iyiKeq"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so1658234a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764544; x=1788369344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JyI5hBi5ftf8/FYl9kZbAH7A9/KzD99zs6pnA2dDwA=;
        b=J1iyiKeqi9h8ThtZND/aD816PK4cQLBgXlwNUgZr8J+fwYijzOC49Ide0mBNgc5JFS
         jpRzXkMaBIZKS1YeoLGxFbFMUmP6SRVeeyP6qg9MX5ZPf8kyivf0qnzWa9czsXf74/U/
         gMFS8HDynQt3PxAISyQ4rVwywl5dwo7I4gxbU/XOOHrr5Nk5Nu5zjqmGxYp9VVRjNi8M
         /XoUelbumuExguPAuyjqiK/cFaNmNEKoToq6WjzaSzhDlww1LZDR+r0/eydwawRAYBuA
         NzxFKsf7HN7Z15bnzY5i2QVB5qvgdrOIFDKnlp4MUmSz/u5Ef6aQD5AZTAt3d8/63eXb
         KpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764544; x=1788369344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JyI5hBi5ftf8/FYl9kZbAH7A9/KzD99zs6pnA2dDwA=;
        b=nDLcuaTEFgFwPl/d845RlEuHcP+1m3eYQewLo6MonaRBWTJ/jWhMMkCjBv9CGAmV7L
         p8sbMq0eI/Y6tXXUVDVFFc/1ickJIobKRJjjb5UDGB8uoD8PIMiS/l454wZy72H8L0Qj
         gkPLNoGzfVvaAQIhaFESGOfh1G0p/VHzeDxwM38sy4TpkJUXyotJmCFs/y1Mwiy4azVE
         7AhkBaZEmZiNfmSJ4s14bB0CZaCBduuGSGF5C0EOUs0PUBPwWCkgbi/tI+P5UIi3kFyr
         u9kqMRpBr0oFoCFz7xHwMjroBBBPnhV8c/1Bk6f3ALNpaXbx7a5bWNrZ69CiiwPStF00
         eHOw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6spenTyAJ6cpMuBk6jMj2cTLo6+DTVWg+RvDDZZZNunHx0mjShMuu5/DfiSq08yz2VDzpALk=@vger.kernel.org
X-Gm-Message-State: AFuF++laxfFyK5XDej/mws+v1IzahpM+6xw7Th27QxjVXzQ89c1/gBZ+
	m5aYRNQic3NNczNOiFEps6vAkXPWhm8h9yw0HYtkmchtHUvd9/6oFPi+
X-Gm-Gg: AR+sD12H9ztgogmfSGz5YMJVuAYBBmTJVRU9DFsl2LfCzVfUvonsAiJEonZtA5ITToN
	dTxWB3rSnkGhNdGVxdx/AWaH+mGAOrmraRQT2HYJH+9ZKhgml+t/NnZ7a0I5bP0W+NOGFIEJv69
	7AjUvUw0WEfdHxFvXT62g2AcA4TOVZZ9pI3KalMRFMlrwiyTXFYTK3rXt0sW0dLwnKU7pm9zmF5
	mCLYLToU0DLnhsaiUf6KoWXgq1UWCggVvRb8XZQoJK+7yiQH7HKndSp25puh+zawjii/V2ct6jJ
	gMLHy+0ST2cT8TsLz3Um/Oj6sPA1QcTTvyp/IgHyDonZIZnOx1vKP1cxQLihA6xktg4kRUPBXTy
	trWEyYCjDqce1TEIggyAvtV4v8gMEdhrmqg7wBkb9o9eTqd1zk8r0gxxls66P4RDV2b7yKxmbg5
	hlRQSsnjSV2D/Oqr+aqecKXe3ITPQ3ANHwL1ItFnhwpP30tD7+M4nnq3MTOv8k3ZVb8gXRt1SoV
	Q==
X-Received: by 2002:a05:6402:52ca:b0:6a0:9776:cb5b with SMTP id 4fb4d7f45d1cf-6a5df670b76mr10287550a12.13.1787764544192;
        Wed, 26 Aug 2026 10:15:44 -0700 (PDT)
Received: from SVR.localdomain ([185.179.67.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8b5e5esm4244556a12.4.2026.08.26.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:15:43 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] net: dsa: b53: offload 8021q uppers on standalone ports
Date: Wed, 26 Aug 2026 20:15:26 +0300
Message-ID: <20260826171526.391-3-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826171526.391-1-strst.gs@gmail.com>
References: <20260826171526.391-1-strst.gs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

b53 keeps the hardware VID lookup enabled at all times:
b53_switch_alloc() sets dev->vlan_enabled and nothing ever clears it. On
bcm5301x switches, a tagged frame whose VID is absent from the VLAN
table is forwarded only toward the IMP0 management port, which the
in-tree topology leaves disabled, so it never reaches the CPU. Jonas
Gorski reports that other family members still deliver such frames,
older BCM5325/5365 by flooding them and BCM63268/BCM53115 to the CPU
only, and the entries this patch programs are correct there as well.
Disabling the lookup is not an option either, because that moves the ARL
to shared VLAN learning, where ARL operations force VID 0 and the
hardware table drifts away from the bridge fdb.

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
establishes. The breakage reached users when OpenWrt 23.05 shipped
v5.15 and is still reproducible.

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
VLAN learning. The PPPoE session establishes.

Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
Cc: stable@vger.kernel.org
Signed-off-by: Semih Baskan <strst.gs@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 118 ++++++++++++++++++++++++++-----
 1 file changed, 100 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..c4c8513ae486 100644
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
-- 
2.53.0.windows.1

