Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9714F3D411B
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166365; cv=none; b=PkuEml+sQqNlq9uezWdCAT22BOUOcBt4IbSgv2KTmn/V7dZXT/jFdZMgJA8XCvzkC5tWMUVaAA1gqIx0hfXLqapmBzi0zDamkixl+O33tCzdJccz1kSFMAwkpoch1Isva1u9ZeiZ250VWiWlPXnHCPba1wy8UIHU8UITmv7Dtdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166365; c=relaxed/simple;
	bh=7OoavN0jjEp5vlSvlLaV2gsBP9dR4yCX4OyLvdsj3Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4AM8tco/rFW9CcVmaoxiBC7YmxX7gFLZckGlY9pNKTw2NGJ3f25f5iWcAsq6MNe+n6Ebtyt3O7BsfuPY2nLanfUTczL+BSMptbJ3M8okbM8PPfmlL/cYRHLoaHVw2UIMenE5fs9P2QlwfuQebWdj0edIhJyiIm+38uNoUOkS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/b+y5a4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/b+y5a4"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48433fad54aso789933f8f.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788166361; x=1788771161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dJw3jrgZrFFiWj2Vn921uZhc33JcuGGDxQ3rYF99UdI=;
        b=p/b+y5a4tClvgLnfsvOeJwTJaxGqMyHhjTAQFl7H1Igu01stUHf9aFLxvJTmbj9jsL
         drxT5iNgDKF9cRrjI5Jzm/AR1ATYKBY28QexKj12wLZueKaFIwHT0+OTtjNLE5aBXlLk
         0jqd6/rENltVOiKLXXOfSc4xC5unc4+Zvsuw45Vh7wnpODoPZMz/uWwNSYlObAo5TRqz
         Zk2kb4Lv8sux5zSCpVMpWpZsUTO49oPUSoqKPnd8jYlgjiEyZxczBlcriYIgNIgcCTUp
         ua2uP6fj9tebYovvPtjw7+0Kt8hUQSSaqSJeJcFIhamenMq9JIFr3JTufhDYWqNRnQPo
         FGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788166361; x=1788771161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dJw3jrgZrFFiWj2Vn921uZhc33JcuGGDxQ3rYF99UdI=;
        b=XyNUaSgix5JdyzewfLzcsH9vy9jOm9DyK0vJxkzx+5RmwrEwC0ATkZ+sBY8WUsRM+v
         9xa0Pw2rUbY/YSzqPdjKTybPrzWInNYpZKsfXgLcfHKE/1tukQ+jNPFMOXsNgq3C+D0o
         OEK3UH+ugtPRllLnycVkb594fzskRQlSaX/ynZ6+C74OmRYrZ+K5MK9PLgP7oR7o2f4C
         cYbRfdOoioPB1k7m03w0em/yjPeVsUtimIx58YA1hHwVOrkptyP39NSXxP8xeS6rB02R
         zElDnjwfHB9h5zWezaMlTaKpn/LbcSWduYAkjh+eSufBgKhiXf1IZvPD3e9ksFMwJiab
         2CGg==
X-Forwarded-Encrypted: i=1; AKwUvByDsdQfPZ38QZOqwnFWfnwIAa0j2eXP7xYD5oNrT5r4ffnTX0dCo/3w4ubeqjVnppzS6O0z12c=@vger.kernel.org
X-Gm-Message-State: AFuF++ksxt4O9lF8Vrb7swxhba0QGi1eYSk80/6qwGzWhSf855+9gCy2
	YJ35Hi7IkayGF4H2tblYEwsO5IDujnI4TWw5FPPX3JKqBtylvQ4g7Cst
X-Gm-Gg: AYBFou117m1jSgUGNBB0mNrcjCTCy35ImC3OXZw7q3OgxPPMxjuKiprn3gE5us04udE
	hLQT+iluTU/w1wTEHx66k7TtjWWq5sT9bHf8rN9rzPSuOCx2uHaJ06cFLoRAG+rgAvavmmaYLtl
	7S7eNWZodaKdI359JVUSAKnPKQBUGQv+M8pMW55kpW3PtXBUhuwzglVrQA9Fgg5hpUTZgGDGyAs
	v9SJmv8bvrdQaxFBX1ATz2P7mFcny7IrVAEdFIOodjXakfimyPP18P4Fl7Abhywx5gQHj/MmYui
	ML/7ruFYCo1WpZCyRPD/GJpoGjQB6odH5Q5uWtrZ96YhRWUQJ/nPuV6RkJ+ItThBd5gBjZanC6f
	PRz8MWqPsU1Cszjr3g+ExtGxuY1aUxVR1nDzNFKcdHyEiCiQHjMRCTOOUkY+IfR6T6dufCyPOep
	tp5i/QxOX+z9Du/jcbpf9lPhmxSkYwt/rxY4fBJVyFByx60ZvdXt7qhRRb9CGJne4=
X-Received: by 2002:a05:6000:2284:b0:482:fc30:a1b4 with SMTP id ffacd0b85a97d-4843efa9d62mr2681887f8f.5.1788166360562;
        Mon, 31 Aug 2026 01:52:40 -0700 (PDT)
Received: from SVR.localdomain ([185.179.67.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484397f33fesm7786600f8f.15.2026.08.31.01.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:52:40 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] net: dsa: b53: offload 8021q uppers on standalone ports
Date: Mon, 31 Aug 2026 11:52:17 +0300
Message-ID: <20260831085217.391-3-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831085217.391-1-strst.gs@gmail.com>
References: <20260831085217.391-1-strst.gs@gmail.com>
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
older BCM5325/5365 by forwarding them and BCM63268/BCM53115 to the CPU
only, and the entries this patch programs are correct on BCM63268 and
BCM53115 as well. Disabling the lookup is not an option either, because
that moves the ARL to shared VLAN learning, where ARL operations force
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

BCM5325 and BCM5365 stay out of the opt-in, which is why the flag is
set after chip detection rather than in b53_switch_alloc(). Both
forward a table miss, so a standalone port there already receives its
uppers' traffic with no entry. Their tables also hold only 16 and 256
VLANs, and with the feature bit back on b53_vlan_prepare() would refuse
any upper whose VID lies beyond the table, an interface that works
today.

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

A tagged upper on BCM7278 port 7 now fails at creation:
b53_vlan_prepare() rejects tagged VLANs on that port, which cannot
receive tagged frames. Previously the ndo was never called, so the
upper was silently created broken.

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
 drivers/net/dsa/b53/b53_common.c | 119 ++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..b57c0bdacb27 100644
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
+
+		b53_set_vlan_entry(dev, vid, &hw);
+		b53_fast_age_vlan(dev, vid);
+	}
 
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
 
@@ -3172,6 +3253,8 @@ static int b53_switch_init(struct b53_device *dev)
 	if (!dev->vlans)
 		return -ENOMEM;
 
+	dev->ds->needs_standalone_vlan_offload = !is5325(dev) && !is5365(dev);
+
 	dev->reset_gpio = b53_switch_get_reset_gpio(dev);
 
 	if (PTR_ERR(dev->reset_gpio) == -EPROBE_DEFER)
-- 
2.53.0.windows.1

