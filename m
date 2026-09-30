Received: from mail-wr2-f24.google.com (mail-wr2-f24.google.com [74.125.225.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53813B27C3
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752517; cv=none; b=u9isCDD4ljCpSsijdm9sDNTluiJik3CemRyPN4y5JnzSdA2nMJ+rLo4lTG7zLL6YSPuwVUPta8cUK2XkFQ58+PygWzh/WYlARx0qzNPeY6LwkrE6cr80bx4VXJAjj271CGBrXlV7DyG5esnH91zhIPhrkPEuUQ9F6Z4L+jYRKag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752517; c=relaxed/simple;
	bh=gSR1Rvdfvw09fwQj2QshgiIthi46vO9rQZdK9fkGmIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK7C2bxsdYwb+CxghT6qD4MF+xOM7ri1Ozvj3CiGr0Ghw58ZdzFszFzW47cmY0qrFM+ab1851mjRJ7TLNhie/fhhxhxPavWyVNFL4LL9fWeawvNcNzhoaGtgFDgpNEDDPaQ1YQyrXc8zcbe4WeJZGiZ0ewY7sSyQd5xZfTEwb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GqKSHkFy; arc=none smtp.client-ip=74.125.225.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GqKSHkFy"
Received: by mail-wr2-f24.google.com with SMTP id ffacd0b85a97d-482f63546c3so3900470f8f.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752508; x=1791357308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrGkj+VE3xyyrtndMSCCNDGNBlpXd+mjCqInZjhVUQ8=;
        b=GqKSHkFyuqW06pbTbUcirIqVpeLWRVfSUYFbS3WhFcouWUXv0nUoptFXHQEd2W/r7t
         Zsj4Cy3jMZ16Yf4TNZYKG0mhvYZqbVBStbse5ZLnMv7YupKv4RKq3nFONCuenQwqqvg8
         kEsdMdTdQw1Kk5ZfRM51CnEFxIW9dErCPTLR429X/sl7ENTYTDiw5J7CsyJrxTRYClz0
         7up1ZYBuFcs3kajFsh/9BFZnKYf7El4Zqft/kxqV0WoY6b2/wABnf8EUY5t2/jh+BkPH
         XFGDcBmNWsH6KKlzQcJALjd83oux/N1+K63vSnzCWoNISVKpnjf+rLQsuw6pvvmdOiiZ
         3MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752508; x=1791357308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrGkj+VE3xyyrtndMSCCNDGNBlpXd+mjCqInZjhVUQ8=;
        b=m8mx9LLQw87boaxr8rz5fnFfaeT832wRKjQ+AYqz8simR342rSkNwgYCLIo3WvPXPT
         efvjlqB9ZVpTsOWHXNDkjihyEJHRprkOxZLk8v+KcTBcYFMkNbNVPZC9q0MF51ofYTVG
         HjnV1AQP+CpXsLWEGfsSyERPA+Ywa2u1AE1iIARB5izfIDVgU8IZU2cEIm7fvsHCwvC2
         hGBA7hyBh2TvTX9zQe5YFkeF3UpxHx4lbRsUl7+XNBBq8iER6hkSxyqafLq2pawrdM/G
         k+6VTKW4BCaX0eZ0WbKhBxdDblcEOoz2jIW5QHanFb2QERhwpLbsazFUDfGZmmDnBF/U
         0wpA==
X-Gm-Message-State: AFuF++mLxDeh1gjXujQsgJsyjGbrpn7FX/gfVB2DKOI3FWRJHAXSyVcB
	o7PtWLJMT1NqB0RoU4FsCKSVgTlqnPoOi9vLnGy7iqrkZd34Ty5stkKjx/QeudMvdm364vZVs98
	D/4fO
X-Gm-Gg: AYBFou3gyqkClKcnElF+Y2A6nsurcMw3fZevw4c17uzZCIOO4wnwtu3HFxyZZ6SpPRs
	VCfTy8NfH+qrBcfz66V6SNOxayelNol8d6MgU1mYUXIDZ3HyhPLt5qP+LOavBaR6lDHGFSQjQKT
	Q1mqOqUv6Wg+vN2jd1c+qpkIJfZAQ6WncUv/1kOTbdZgXNg4Ax3pfgE+5mVLyY2Ztbch9kvvSfA
	oVuaLv8j4Aej0il/dElhx4nmIFdoEad6cl8OrLDKHWey43QIEaTzj1bCHc7klM301slKg/OrkKY
	ceiPvKgB/Qgb3nwZMKjCtHEr+tYoN7vJ0+3PpU+vRPh0fJMvJmdQE2b7hEM7ghBH88mx/t+svrz
	6c+BB1w6VNKm4hLz7P9l3BSwgSUhfJmMAu3hacglM8uQ6bCyBLY2c+SBAvDdKhrqBZkvX2OY1j5
	2gtFC/OVojtMOh9ts2X5GvL/XDfbfWXq0LMDlXn7K/hFaIrvgup3R7qaODS3F0SaktSplkJgHhw
	b0Hcw==
X-Received: by 2002:a05:600c:8411:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-4a01affe5camr6305205e9.6.1790752508427;
        Wed, 30 Sep 2026 00:15:08 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a019740c34sm18723525e9.9.2026.09.30.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:07 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 07/12] net: bridge: vlan: split unpublishing from deletion
Date: Wed, 30 Sep 2026 10:14:06 +0300
Message-ID: <20260930071411.2786201-8-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930071411.2786201-1-razor@blackwall.org>
References: <20260930071411.2786201-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split removal of a VLAN from its lookup and flood structures from object
destruction. Pass the VLAN group explicitly to __vlan_del() and call both
operations consecutively for now. This prepares deletion paths to quiesce
readers after making an entry unreachable and before freeing it.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 45 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 7ba6e57b18fa..8a914e249767 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -429,22 +429,34 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 	goto out;
 }
 
-static void __vlan_del(struct net_bridge_vlan *v)
+static void __vlan_unpublish(struct net_bridge_vlan_group *vg,
+			     struct net_bridge_vlan *v)
+{
+	__vlan_delete_pvid(vg, v);
+	if (!br_vlan_is_master(v)) {
+		struct net_bridge_vlan *masterv = v->brvlan;
+
+		rhashtable_remove_fast(&vg->vlan_hash, &v->vnode,
+				       br_vlan_rht_params);
+		__vlan_del_list(v);
+		/* -1 because br_vlan_put_master() is called later */
+		br_vlan_rebuild_port_array(masterv,
+					   br_vlan_num_ports(masterv) - 1);
+	}
+}
+
+static void __vlan_del(struct net_bridge_vlan_group *vg,
+		       struct net_bridge_vlan *v)
 {
 	struct net_bridge_vlan *masterv = v;
-	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
 	int err;
 
-	if (br_vlan_is_master(v)) {
-		vg = br_vlan_group(v->br);
-	} else {
+	if (!br_vlan_is_master(v)) {
 		p = v->port;
-		vg = nbp_vlan_group(v->port);
 		masterv = v->brvlan;
 	}
 
-	__vlan_delete_pvid(vg, v);
 	if (p) {
 		err = __vlan_vid_del(p->dev, p->br, v);
 		if (err)
@@ -467,12 +479,6 @@ static void __vlan_del(struct net_bridge_vlan *v)
 
 	if (masterv != v) {
 		vlan_tunnel_info_del(vg, v);
-		rhashtable_remove_fast(&vg->vlan_hash, &v->vnode,
-				       br_vlan_rht_params);
-		__vlan_del_list(v);
-		/* -1 because br_vlan_put_master() is called later */
-		br_vlan_rebuild_port_array(masterv,
-					   br_vlan_num_ports(masterv) - 1);
 		nbp_vlan_set_vlan_dev_state(p, v->vid);
 		br_multicast_toggle_one_vlan(v, false);
 		br_multicast_port_ctx_deinit(&v->port_mcast_ctx);
@@ -509,7 +515,8 @@ static void __vlan_flush(const struct net_bridge *br,
 		}
 		v_end = vlan->vid;
 
-		__vlan_del(vlan);
+		__vlan_unpublish(vg, vlan);
+		__vlan_del(vg, vlan);
 	}
 
 	/* notify about the last/whole vlan range */
@@ -873,7 +880,8 @@ int br_vlan_delete(struct net_bridge *br, u16 vid)
 	br_fdb_cleanup_by_dst(br, br_port_to_dst(NULL), vid, 0);
 
 	vlan_tunnel_info_del(vg, v);
-	__vlan_del(v);
+	__vlan_unpublish(vg, v);
+	__vlan_del(vg, v);
 
 	return 0;
 }
@@ -1389,15 +1397,18 @@ int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
  */
 int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 {
+	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
 
 	ASSERT_RTNL();
 
-	v = br_vlan_find(nbp_vlan_group(port), vid);
+	vg = nbp_vlan_group(port);
+	v = br_vlan_find(vg, vid);
 	if (!v)
 		return -ENOENT;
 	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
-	__vlan_del(v);
+	__vlan_unpublish(vg, v);
+	__vlan_del(vg, v);
 
 	return 0;
 }
-- 
2.47.3

