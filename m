Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977356;
	b=LXqXN/6pak9Ny2s8+HnbA8UYcO/iaF2yUvGoIOOGw4Uk7vPz2kAuxWvloMtiU+QQEnHr
	 GP4VBKJiGQMd+V7iJPMG6TFPe8HeAZGYIkTsi/gJjSDYBMw2Mev4mZQuR/6UX+bKJoY8V
	 GADM0z0MKeGO3HyiIitxZEG7GBA9EY7GHdcm7WuW60M7JZgIFlfxdwc/EjsdDxcmZc0Bb
	 LSPZ3If8jJdTJCPR2kx08QbAy+Zhz+AItFe7O9R7lLedkLG2xf0Pg5ZA7VTpQn1ISfU6z
	 IY89aOmz2ggAi0T4DxrBpWXnb8oFDpDD/AmZgpxbbjVjHh0NYE+IjiHE5QU9zhY+q7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ndSzg4JkQBQJHn4jazHUqZ66cUlM0M5E75MVJxa0ep8=;
	b=mnlhp7IL7dlGuE2vm99js/d1JK9C9AQBVSNkyhpux7K1jh/QuRagd87oDGDTNL9PNUXc
	 U/oayRUO90Q1qe0xEQsYPFcTzK6y2JlGiPmZjuX73UrZc6kmWlYLTn4TIphi4fkXOBenN
	 Zsvw45IvJUd3vfrBN5N8V6rOhdS88suCegOOkDtOGagBdE4xR4ZibWQZA0OJM+jbIgsfB
	 UGtL1nDomovJv0Oq7+vsKe3nkLBUG4XBZFaOnzskgLxbo8XdEu3Dh76QBN99qSFwdydXU
	 KjgdbdLuJO98gAQgM6tzlbzuQEz+tGIUh/hXZD9oCeU60/FxRKxfVxHW/lc8YjhAZFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYidPhog;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DF6082BE1
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687DF6082BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYidPhog
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c40f29667e6so109588566b.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977354; x=1794582154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndSzg4JkQBQJHn4jazHUqZ66cUlM0M5E75MVJxa0ep8=;
        b=QYidPhog6nppHZEI57WaydtJhx8ECZ1KP55FAge9utvKt/RtiQzjX8/DS/Goo2XC3y
         KRhpyeUTL3xXeOAXx5a57xwUzt/+rhw2wZohl/4n5iSArmZObreZl2j9oMX9ENKVDr76
         QMK9s1D9mRsn3mjeyEHOEjK2ix41BuHVK+cOXXLC9znUR+YyMBIi3aNE20HuHC2Y+Kv0
         ln4ywMxFbrGRreWT6Oabk1G9Vno5jqAyvVb1G2LLdBVUMVkir+eV8m/7euoipYPT/81K
         7v6hWybYSXyARLdQRwMiUm0155iFsNhHl31UvF25EUD2tHcz8hhAMOnYx5mB0hazs8F0
         gPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977354; x=1794582154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ndSzg4JkQBQJHn4jazHUqZ66cUlM0M5E75MVJxa0ep8=;
        b=LQ6JcvZkfISh6DR03cxzax3ENO4sktTmvUXqTywLijZUdbbA4gN1ZQEuvnuW0BYlMD
         ibZb+84R15kHuyHFwGriT4hz38GMmuag8kOVfWgoD3wtxSmrxPLwtEdPYHf1LBtE3zqB
         ImWlKyfunOwTzZTFkKXA2EIuj+QAFdsuCIWYiQF8eajEAyue7D84+mbmkLE7lZeQDYfL
         PN3yj3+g0ckDAdGBpQaY5ZsF/AprqmpOeikyxsRgEugtNMlqy2zN2OCGmttT3d4dyFpZ
         cuYC+8fiU4CYwYQVXtQ6JXfXXJadmSQWHqVA50Lub+nQ+FCneT+hfUbOPqx0FxbzOpER
         6orQ==
X-Gm-Message-State: APuU4Z/AdMS9UJy+/1cUP28AgYwM7vJcG6pg5AJcREF4EtNVQJ+gkBgm
	yguVRyqeUkjeaRHUlkXmprR0sXEYDzpPG7Pzex7t2CNaVWL5naNFUJNfg1jOyS/U
X-Gm-Gg: AYBFou1DloqAsGoiJlSvjxFT+LTjcuJl+fSwFwAdUkBL4fXfp1I/Dk8pda3+dBm6jau
	YRbsNM8X00Timq6Ftp1BNXvyPBwczKwcpcVJK20Pe6u9oQE+Iv4UQOiuJE9gI2VtNZ0jKb9rpqO
	sgReARty8dZDqv7ZEXZurdF+Nd5zVOc/s/NsRFrs2LY3bHQtmi2P9yvhZDZymDB1AE7mcKbZ65J
	aCVgdzsPdN9vp8KAOQqFSg0asRbRIpkoxXH+8S88ILtvkul7adjDFfArvs8+0pJI2f0IQXwDFZ/
	FejFn70bNT2HVitoBTR5yyggnluYGCLGE/WVqiUzQmHf6Cj3X1enqHKKW7Mt00sMnTyyzm27KT8
	Fe9itoQAn2YE9KDy9Fw/gOsAUbPgDATaFPo3gdnU3WFEgIqnjgeSri0I8mbNt2M7M+xWetl+x1+
	iF6Lx+/VEnRVNT4+tKd0kkEf9EI+grSo4o/ZMUwH7CkfYFy6Ai19LxbJfkLl5I70xS8eHK2wi1c
	vkxYAnJUcxYZ0TTQEG2G933kxWS6PJcp0d2jnYN7Ovwz9xNM8ccCWrOxwcd+rtx9Wpd44d5O5W+
	q/iFZb5wkENc1XxY0mgc6Uthdg8iaIf7ey7P2TOOGKo3TGmy13BXxagAOYCaujonBWXXQyIante
	7Sa2BxS3rwPpzwixIc8N5lZR0Y/EgNA+vSE38RqbKlDUPrItvwS/gbozPXK1ePmA7yOInW+Cj/3
	HY
X-Received: by 2002:a17:907:2d26:b0:c2d:bf61:24d1 with SMTP id a640c23a62f3a-c4d35261e03mr240008666b.1.1793977353602;
        Fri, 06 Nov 2026 07:02:33 -0800 (PST)
Received: from desktop.home.arpa (2a02-1810-1e16-ac80-898e-1938-27eb-b890.ip6.access.telenet.be. [2a02:1810:1e16:ac80:898e:1938:27eb:b890])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356a2ee4sm84905766b.60.2026.11.06.07.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:02:33 -0800 (PST)
From: Stijn Cleynhens <stijncleynhens@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] net: dsa: realtek: rtl8365mb: keep the neutral PVID in VLAN-unaware bridges
Date: Fri,  6 Nov 2026 16:02:25 +0100
Message-ID: <20261106150225.3700205-3-stijncleynhens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106150225.3700205-1-stijncleynhens@gmail.com>
References: <20261106150225.3700205-1-stijncleynhens@gmail.com>
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

The switch looks up its forwarding database by the VLAN that it
classifies a frame to, and untagged frames are classified to the port
PVID. With configure_vlan_while_not_filtering, the bridge PVID is
programmed into the port also while the bridge is VLAN-unaware, so
untagged frames of such a bridge are looked up in VLAN 1. DSA however
installs the FDB and MDB entries of a VLAN-unaware bridge with VID 0,
so these entries never match a lookup.

This breaks assisted learning on the CPU port: when a station that was
first learned behind a user port moves behind the CPU port (e.g. a
wireless client roaming between access points), the static entry that
DSA installs for it on the CPU port does not override the learned one,
and unicast to the station is dropped as a hairpin until the learned
entry ages out. Clients that need a DHCP reply in that window do not
get one.

Keep the PVID requested by the bridge per port and only program it
while the port filters VLANs. Otherwise keep the neutral PVID (VLANMC
index 0, VID 0) that standalone ports already use, so that untagged
frames are classified to VID 0, the VID that DSA uses for the FDB and
MDB entries of a VLAN-unaware bridge. The per-bridge EFID keeps these
lookups local to the bridge.

The PVID and the accepted frame types now both follow from the bridge
PVID and the filtering state. Replace rtl8365mb_vlan_pvid_port_set() and
rtl8365mb_vlan_pvid_port_clear() with rtl8365mb_vlan_pvid_port_commit(),
which programs both, and call it whenever either input changes. The
filtering state is passed in, as DSA still reports the old one while
VLAN filtering is being toggled.

This only covers untagged frames. Tagged frames in a VLAN-unaware bridge
are still classified by their tag, so a tagged station that roams keeps
hitting the stale learned entry until it ages out, as before. Fixing
that would need the switch to ignore the C-tag on ingress of these
ports, which is left for a separate change.

Fixes: 336e3e4a1ab3 ("net: dsa: realtek: rtl8365mb: add FDB support")
Signed-off-by: Stijn Cleynhens <stijncleynhens@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 149 +++++++++--------
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 202 ++++++++---------------
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |   6 +-
 3 files changed, 151 insertions(+), 206 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index b90e46c16..4f0e0ab7f 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -838,6 +838,8 @@ struct rtl8365mb_cpu {
  *         access via rtl8365mb_get_stats64
  * @stats_lock: protect the stats structure during read/update
  * @mib_work: delayed work for polling MIB counters
+ * @bridge_pvid: PVID requested by the bridge, 0 if none. Only programmed
+ *               while the port filters VLANs. Protected by vlan_lock.
  */
 struct rtl8365mb_port {
 	struct realtek_priv *priv;
@@ -845,6 +847,7 @@ struct rtl8365mb_port {
 	struct rtnl_link_stats64 stats;
 	spinlock_t stats_lock;
 	struct delayed_work mib_work;
+	u16 bridge_pvid;
 };
 
 /**
@@ -2004,42 +2007,44 @@ rtl8365mb_port_set_vlan_egress_mode(struct realtek_priv *priv, int port,
 			RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, val);
 }
 
+/* Program the PVID that the port should use for untagged frames: the PVID of
+ * the bridge while the port filters VLANs, and the neutral PVID (VID 0)
+ * otherwise. A VLAN-unaware bridge, like a standalone port, gets its FDB and
+ * MDB entries with VID 0 from DSA. As the switch looks up its forwarding
+ * database by the VLAN that it classifies a frame to, a bridge PVID would make
+ * those entries miss every lookup.
+ */
+static int rtl8365mb_port_commit_pvid(struct dsa_switch *ds, int port,
+				      bool vlan_filtering,
+				      struct netlink_ext_ack *extack)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+	u16 pvid;
+
+	if (vlan_filtering)
+		pvid = mb->ports[port].bridge_pvid;
+	else
+		pvid = 0;
+
+	return rtl8365mb_vlan_pvid_port_commit(ds, port, pvid, vlan_filtering,
+					       extack);
+}
+
 static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
 					 bool vlan_filtering,
 					 struct netlink_ext_ack *extack)
 {
-	enum rtl8365mb_frame_ingress accepted_frame, prev_accepted_frame;
 	enum rtl8365mb_vlan_egress_mode mode;
 	struct realtek_priv *priv = ds->priv;
 	u32 configured_ports = 0;
 	struct dsa_port *dp;
-	u16 pvid_vid;
 	int ret;
 
 	dev_dbg(priv->dev, "port %d: %s VLAN filtering\n", port,
 		vlan_filtering ? "enable" : "disable");
 
-	ret = rtl8365mb_vlan_port_get_framefilter(priv, port,
-						  &prev_accepted_frame);
-	if (ret) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Failed to get current framefilter");
-		return ret;
-	}
-
-	/* While filtering, only accepts untagged frames if PVID is enabled */
-	if (vlan_filtering) {
-		ret = rtl8365mb_vlan_port_get_pvid(priv, port, &pvid_vid);
-		if (ret)
-			return ret;
-
-		if (pvid_vid)
-			accepted_frame = RTL8365MB_FRAME_TYPE_ANY_FRAME;
-		else
-			accepted_frame = RTL8365MB_FRAME_TYPE_TAGGED_ONLY;
-	} else {
-		accepted_frame = RTL8365MB_FRAME_TYPE_ANY_FRAME;
-	}
+	mutex_lock(&priv->vlan_lock);
 
 	/* When vlan filter is enable/disabled in a bridge, this function is
 	 * called for all member ports. We need to enable/disable ingress
@@ -2047,7 +2052,7 @@ static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
 	 */
 	ret = rtl8365mb_port_set_ingress_filtering(priv, port, vlan_filtering);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	/* However, we also enable/disable egress filtering because the switch
 	 * still consider the egress interface VLAN membership to forward the
@@ -2064,15 +2069,12 @@ static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
 		configured_ports |= BIT(dp->index);
 	}
 
-	if (accepted_frame != prev_accepted_frame) {
-		ret = rtl8365mb_vlan_port_set_framefilter(priv, port,
-							  accepted_frame);
-		if (ret) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Failed to set port framefilter");
-			goto undo_transparent;
-		}
-	}
+	/* Also sets which frames the port accepts: while filtering, untagged
+	 * frames are only accepted if the bridge gave the port a PVID.
+	 */
+	ret = rtl8365mb_port_commit_pvid(ds, port, vlan_filtering, extack);
+	if (ret)
+		goto undo_transparent;
 
 	/* When VLAN filtering is disabled, preserve frames exactly as received.
 	 * Otherwise, the VLAN egress pipeline may still alter tag state
@@ -2085,14 +2087,12 @@ static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
 
 	ret = rtl8365mb_port_set_vlan_egress_mode(priv, port, mode);
 	if (ret)
-		goto undo_set_framefilter;
+		goto undo_commit_pvid;
 
-	return ret;
+	goto out_unlock;
 
-undo_set_framefilter:
-	if (prev_accepted_frame != accepted_frame)
-		rtl8365mb_vlan_port_set_framefilter(priv, port,
-						    prev_accepted_frame);
+undo_commit_pvid:
+	(void)rtl8365mb_port_commit_pvid(ds, port, !vlan_filtering, NULL);
 undo_transparent:
 	/* The DSA core guarantees this callback is only invoked on an actual
 	 * state transition, ensuring the previous hardware state was the
@@ -2111,6 +2111,8 @@ static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
 
 	rtl8365mb_port_set_ingress_filtering(priv, port, !vlan_filtering);
 
+out_unlock:
+	mutex_unlock(&priv->vlan_lock);
 	return ret;
 }
 
@@ -2120,8 +2122,11 @@ static int rtl8365mb_port_vlan_add(struct dsa_switch *ds, int port,
 {
 	bool untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
 	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
-	u16 pvid_vid;
 	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+	u16 prev_bridge_pvid;
+	u16 *bridge_pvid;
+	bool vlan_filtering;
 	int ret;
 
 	dev_dbg(priv->dev, "add VLAN %d on port %d, %s, %s\n",
@@ -2137,41 +2142,33 @@ static int rtl8365mb_port_vlan_add(struct dsa_switch *ds, int port,
 
 	mutex_lock(&priv->vlan_lock);
 
-	ret = rtl8365mb_vlan_port_get_pvid(priv, port, &pvid_vid);
-	if (ret)
-		goto out_unlock;
+	vlan_filtering = dsa_port_is_vlan_filtering(dsa_to_port(ds, port));
+	bridge_pvid = &mb->ports[port].bridge_pvid;
 
-	/* Set PVID if needed */
-	if (pvid) {
-		ret = rtl8365mb_vlan_pvid_port_set(ds, port, vlan->vid,
-						   extack);
-		if (ret)
-			goto out_unlock;
-	} else {
-		/* or try to unset it if not */
-		ret = rtl8365mb_vlan_pvid_port_clear(ds, port, vlan->vid);
-		if (ret)
-			goto out_unlock;
-	}
+	/* Set PVID if needed, or unset it if this VLAN was the PVID */
+	prev_bridge_pvid = *bridge_pvid;
+	if (pvid)
+		*bridge_pvid = vlan->vid;
+	else if (*bridge_pvid == vlan->vid)
+		*bridge_pvid = 0;
+
+	ret = rtl8365mb_port_commit_pvid(ds, port, vlan_filtering, extack);
+	if (ret)
+		goto undo_bridge_pvid;
 
 	/* add port to vlan4k. It knows nothing about PVID */
 	ret = rtl8365mb_vlan_4k_port_add(ds, port, vlan, extack);
 	if (ret)
-		goto undo_set_pvid;
+		goto undo_commit_pvid;
 
-	ret = 0;
 	goto out_unlock;
 
-undo_set_pvid:
-	/* undo the pvid definition */
-	if (pvid != (pvid_vid == vlan->vid)) {
-		if (pvid_vid)
-			(void)rtl8365mb_vlan_pvid_port_set(ds, port, pvid_vid,
-							   NULL);
-		else
-			(void)rtl8365mb_vlan_pvid_port_clear(ds, port,
-							     vlan->vid);
-	}
+undo_commit_pvid:
+	*bridge_pvid = prev_bridge_pvid;
+	(void)rtl8365mb_port_commit_pvid(ds, port, vlan_filtering, NULL);
+	goto out_unlock;
+undo_bridge_pvid:
+	*bridge_pvid = prev_bridge_pvid;
 out_unlock:
 	mutex_unlock(&priv->vlan_lock);
 	return ret;
@@ -2183,6 +2180,10 @@ static int rtl8365mb_port_vlan_del(struct dsa_switch *ds, int port,
 	bool untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
 	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
 	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+	u16 prev_bridge_pvid;
+	u16 *bridge_pvid;
+	bool vlan_filtering;
 	int ret;
 
 	dev_dbg(priv->dev, "del VLAN %d on port %d, %s, %s\n",
@@ -2193,10 +2194,20 @@ static int rtl8365mb_port_vlan_del(struct dsa_switch *ds, int port,
 	if (vlan->vid == 0)
 		return -EOPNOTSUPP;
 
+	vlan_filtering = dsa_port_is_vlan_filtering(dsa_to_port(ds, port));
+	bridge_pvid = &mb->ports[port].bridge_pvid;
+
 	mutex_lock(&priv->vlan_lock);
-	ret = rtl8365mb_vlan_pvid_port_clear(ds, port, vlan->vid);
-	if (ret)
+	prev_bridge_pvid = *bridge_pvid;
+	if (*bridge_pvid == vlan->vid)
+		*bridge_pvid = 0;
+
+	ret = rtl8365mb_port_commit_pvid(ds, port, vlan_filtering, NULL);
+	if (ret) {
+		/* keep the state in line with the PVID still in hardware */
+		*bridge_pvid = prev_bridge_pvid;
 		goto out_unlock;
+	}
 
 	ret = rtl8365mb_vlan_4k_port_del(ds, port, vlan);
 	/* There is little incentive to try to undo the removal of PVID (if it
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 58948e76f..64acd762e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -42,7 +42,8 @@
  *    may be useful for ACL rules which specify alternative forwarding
  *    decisions.
  *
- * VLANMC index 0 is reserved as a neutral PVID, used for standalone ports.
+ * VLANMC index 0 is reserved as a neutral PVID, used for standalone ports and
+ * for the ports of a VLAN-unaware bridge.
  *
  */
 
@@ -780,35 +781,41 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
 }
 
 /*
- * rtl8365mb_vlan_pvid_port_set() - Configure a port's PVID and associated
- * VLANMC entry
+ * rtl8365mb_vlan_pvid_port_commit() - Program a port's PVID and frame filter
  * @ds: dsa switch instance
  * @port: port index
- * @vid: target VID
+ * @vid: VID to use as PVID, or 0 for the neutral PVID (VLANMC index 0)
+ * @vlan_filtering: whether the port filters VLANs
  * @extack: netlink extended ACK for error reporting
  *
- * Allocates or reuses a hardware VLANMC entry to map the given port to its new
- * PVID. Gracefully unwinds and restores previous configuration if a hardware
- * write operation fails during execution.
+ * Points the port at the VLANMC entry of @vid, allocating it if needed, and
+ * drops the port from the VLANMC entry of its previous PVID, which is freed
+ * once no port uses it anymore. Untagged frames are accepted unless the port
+ * filters VLANs and has no PVID. Restores the previous configuration if a
+ * write fails.
  *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
  */
-int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
-				 struct netlink_ext_ack *extack)
+int rtl8365mb_vlan_pvid_port_commit(struct dsa_switch *ds, int port, u16 vid,
+				    bool vlan_filtering,
+				    struct netlink_ext_ack *extack)
 {
 	enum rtl8365mb_frame_ingress accepted_frame, prev_accepted_frame;
 	struct realtek_priv *priv = ds->priv;
-	struct rtl8365mb_vlanmc prev_vlanmc = {0};
+	struct rtl8365mb_vlanmc prev_vlanmc;
 	u8 _unused_first_free_idx;
+	u8 vlanmc_idx = 0;
 	u8 prev_vlanmc_idx;
-	u8 vlanmc_idx;
+	bool vid_changed;
 	int ret;
 
 	lockdep_assert_held(&priv->vlan_lock);
 
-	/* Read the old PVID exclusively to undo in case of error */
+	/* The VLANMC entry of a PVID always has a non-zero VID, so the previous
+	 * VID reads as 0 if the port used the neutral PVID.
+	 */
 	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &prev_vlanmc_idx,
 					 &prev_vlanmc);
 	if (ret) {
@@ -823,153 +830,80 @@ int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
 		return ret;
 	}
 
-	/* Find or allocate a new vlan MC and add port to members,
-	 * although members are not checked by the HW in vlan MC.
-	 */
-	ret = rtl8365mb_vlan_mc_port_set(ds, port, vid, true, extack, true);
-	if (ret)
-		return ret;
-
-	/* look for existing entry */
-	ret = rtl8365mb_vlan_mc_find(priv, vid, &vlanmc_idx,
-				     &_unused_first_free_idx);
-	if (ret) {
-		dev_err(priv->dev, "Failed to find a VLAN MC table index\n");
-		goto undo_vlan_mc_port_set;
-	}
-
-	if (!vlanmc_idx) {
-		dev_err(priv->dev, "VLAN should already exist in VLAN MC\n");
-		ret = -ENOENT;
-		goto undo_vlan_mc_port_set;
-	}
-
-	ret = rtl8365mb_vlan_port_set_pvid(priv, port, vlanmc_idx);
-	if (ret) {
-		dev_err(priv->dev, "Failed to set port PVID\n");
-		goto undo_vlan_mc_port_set;
-	}
+	vid_changed = vid != prev_vlanmc.evid;
 
-	/* Changing accept frame is what enables PVID (if not enabled before) */
-	accepted_frame = RTL8365MB_FRAME_TYPE_ANY_FRAME;
-	ret = rtl8365mb_vlan_port_set_framefilter(priv, port, accepted_frame);
-	if (ret) {
-		dev_err(priv->dev, "Failed to set port frame filter\n");
-		goto undo_vlan_port_set_pvid;
-	}
+	if (vid_changed && vid) {
+		/* Find or allocate a VLANMC entry and add the port to its
+		 * members, which only serve as a reference count.
+		 */
+		ret = rtl8365mb_vlan_mc_port_set(ds, port, vid, true, extack,
+						 true);
+		if (ret)
+			return ret;
 
-	/* A VLAN can be added with PVID without removing from the old
-	 * PVID VLAN. Clear PVID from the old VLAN MC (if needed).
-	 */
-	if (prev_vlanmc_idx && (prev_vlanmc.evid != vid)) {
-		ret = rtl8365mb_vlan_mc_port_set(ds, port, prev_vlanmc.evid,
-						 false, NULL, false);
+		ret = rtl8365mb_vlan_mc_find(priv, vid, &vlanmc_idx,
+					     &_unused_first_free_idx);
 		if (ret) {
-			dev_err(priv->dev, "Failed to clear old VLAN MC\n");
-			goto undo_set_framefilter;
+			dev_err(priv->dev,
+				"Failed to find a VLAN MC table index\n");
+			goto undo_vlan_mc_port_set;
 		}
-	}
-
-	return 0;
-
-undo_set_framefilter:
-	(void)rtl8365mb_vlan_port_set_framefilter(priv, port,
-						  prev_accepted_frame);
-
-undo_vlan_port_set_pvid:
-	(void)rtl8365mb_vlan_port_set_pvid(priv, port, prev_vlanmc_idx);
 
-undo_vlan_mc_port_set:
-	if (prev_vlanmc.evid != vid)
-		(void)rtl8365mb_vlan_mc_port_set(ds, port, vid, false, NULL,
-						 false);
-
-	return ret;
-}
-
-/*
- * rtl8365mb_vlan_pvid_port_clear() - Remove a port's PVID configuration
- * @ds: dsa switch instance
- * @port: port index
- * @vid:  VLAN VID for PVID
- *
- * Resets the target port's hardware PVID allocation to 0. Cleans up and frees
- * the associated VLANMC entry if no other ports are referencing it.
- *
- * Context: Can sleep. Must be called with &priv->vlan_lock held.
- * Takes and releases &priv->map_lock.
- * Return: 0 on success, or a negative error code on failure.
- */
-int rtl8365mb_vlan_pvid_port_clear(struct dsa_switch *ds, int port, u16 vid)
-{
-	enum rtl8365mb_frame_ingress accepted_frame, prev_accepted_frame;
-	struct realtek_priv *priv = ds->priv;
-	struct rtl8365mb_vlanmc vlanmc = {0};
-	u8 vlanmc_idx;
-	int ret;
-
-	lockdep_assert_held(&priv->vlan_lock);
-
-	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx,
-					 &vlanmc);
-	if (ret) {
-		dev_err(priv->dev, "Failed to read current VLAN MC\n");
-		return ret;
+		if (!vlanmc_idx) {
+			dev_err(priv->dev,
+				"VLAN should already exist in VLAN MC\n");
+			ret = -ENOENT;
+			goto undo_vlan_mc_port_set;
+		}
 	}
 
-	/* Port is not using PVID. Nothing to remove. */
-	if (!vlanmc_idx)
-		return 0;
-
-	/* We are leaving a non PVID vlan, Nothing to remove. */
-	if (vlanmc.evid != vid)
-		return 0;
-
-	ret = rtl8365mb_vlan_port_get_framefilter(priv, port,
-						  &prev_accepted_frame);
-	if (ret) {
-		dev_err(priv->dev, "Failed to get current framefilter\n");
-		return ret;
+	if (vid_changed) {
+		ret = rtl8365mb_vlan_port_set_pvid(priv, port, vlanmc_idx);
+		if (ret) {
+			dev_err(priv->dev, "Failed to set port PVID\n");
+			goto undo_vlan_mc_port_set;
+		}
 	}
 
-	/* Changing accept frame is what really removes PVID. But only do
-	 * that if we are filtering vlan
-	 */
-	if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port))) {
+	if (vlan_filtering && !vid)
 		accepted_frame = RTL8365MB_FRAME_TYPE_TAGGED_ONLY;
+	else
+		accepted_frame = RTL8365MB_FRAME_TYPE_ANY_FRAME;
 
+	if (accepted_frame != prev_accepted_frame) {
 		ret = rtl8365mb_vlan_port_set_framefilter(priv, port,
 							  accepted_frame);
 		if (ret) {
 			dev_err(priv->dev, "Failed to set port frame filter\n");
-			return ret;
+			goto undo_vlan_port_set_pvid;
 		}
-	} else {
-		/* skip undo_set_framefilter */
-		accepted_frame = prev_accepted_frame;
 	}
 
-	ret = rtl8365mb_vlan_port_set_pvid(priv, port, 0);
-	if (ret) {
-		dev_err(priv->dev, "Failed to set port PVID to 0\n");
-		goto undo_set_framefilter;
+	/* Drop the port from the VLANMC entry of its previous PVID */
+	if (vid_changed && prev_vlanmc_idx) {
+		ret = rtl8365mb_vlan_mc_port_set(ds, port, prev_vlanmc.evid,
+						 false, NULL, false);
+		if (ret) {
+			dev_err(priv->dev, "Failed to clear old VLAN MC\n");
+			goto undo_set_framefilter;
+		}
 	}
 
-	/* Clears the VLAN MC membership and maybe VLAN MC entry if empty */
-	ret = rtl8365mb_vlan_mc_port_set(ds, port, vlanmc.evid,
-					 false, NULL, false);
-	if (ret)
-		goto undo_port_set_pvid;
-
 	return 0;
 
-undo_port_set_pvid:
-	(void)rtl8365mb_vlan_port_set_pvid(priv, port, vlanmc_idx);
-
 undo_set_framefilter:
-	if (prev_accepted_frame != accepted_frame)
+	if (accepted_frame != prev_accepted_frame)
 		(void)rtl8365mb_vlan_port_set_framefilter(priv, port,
 							  prev_accepted_frame);
 
+undo_vlan_port_set_pvid:
+	if (vid_changed)
+		(void)rtl8365mb_vlan_port_set_pvid(priv, port, prev_vlanmc_idx);
+
+undo_vlan_mc_port_set:
+	if (vid_changed && vid)
+		(void)rtl8365mb_vlan_mc_port_set(ds, port, vid, false, NULL,
+						 false);
+
 	return ret;
 }
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
index 809034009..4c83c9475 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
@@ -34,7 +34,7 @@ int rtl8365mb_vlan_4k_port_add(struct dsa_switch *ds, int port,
 			       struct netlink_ext_ack *extack);
 int rtl8365mb_vlan_4k_port_del(struct dsa_switch *ds, int port,
 			       const struct switchdev_obj_port_vlan *vlan);
-int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
-				 struct netlink_ext_ack *extack);
-int rtl8365mb_vlan_pvid_port_clear(struct dsa_switch *ds, int port, u16 vid);
+int rtl8365mb_vlan_pvid_port_commit(struct dsa_switch *ds, int port, u16 vid,
+				    bool vlan_filtering,
+				    struct netlink_ext_ack *extack);
 #endif /* _REALTEK_RTL8365MB_VLAN_H */
-- 
2.56.0

