Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB340E8CD
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121237; cv=none; b=LI4l8Rx/vsi8WlE7Hou+QcvTRPkYiXHpbcXJ8B7+/xo13TEp6lRrnuBwh5q2Z8wAHACDU2AoyNfz0T8cmjzwPoud2oULVbWMLcFOtx4uwB+9jN1ud0NheybNUkejd0GaTymbbczU/Ur2siQQ1cdxKU+q4YNM3EgR1eOI3a9YGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121237; c=relaxed/simple;
	bh=V8NxLrR85R4hMEuCvuq7hPTTUg2W2ANSVj2I+B9IfgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/Q7XH30LKn9f0ub6q8NstsdlavATRinmSKh8Ssmii/5petVewCQ20B3zmo/V2n46d28NIAmXmg8p/atss3S5drWnLxxRamoWisdoL81yPhJZfnrKcQFwOzkL70RxhcWXwmZ6DeJUmHVwrWqNAh4hFbgohuO+Nj+ectnJWQqx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ihaelvU/; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ihaelvU/"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso5765265e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789121231; x=1789726031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXcgPnmTgj5AcgZzHmbEG6784aYNLo1awnsyC/8jJWs=;
        b=ihaelvU/8h/I1x9FruiGSeI+CvYopzBIa8uDWPXN7KNLwZqTAjnF9Ldb6IBDChiqmt
         RPxedZmotdhlPCNyJz8ix43VeiNuYAJr1GGcKE0B37+npw6dZYpY+34bTDoiY3rQ4EOQ
         vm7PRAycVooDz8ZcoJQ8O5p5KeQzkGTB/GwBbpENh1YYy/HE2c61fuA1TRHZck6oYmQd
         JbqJE5x2cym32qVHT1oGDOFaz7Uj/QyVqL4X6KB4LfGpKA6c4AJDxHTpEPSLqmQKPlD1
         R9okZN1e/jLsLydWmp4DOH6gNcqfFxRvd/hZXPfQtudrztrbFcDz+5vbrdQZj8DeIcmF
         PkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789121231; x=1789726031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kXcgPnmTgj5AcgZzHmbEG6784aYNLo1awnsyC/8jJWs=;
        b=GxfjY97tqidy6hQZmO6wOI56YllI0oF5YuQbwPOXuMzZ3l5ANkiop7x0IAvCDf8HBG
         GBwkGV9cpOBoOAmUkegjMP+/qztf3h+EzhlojwR75P5JhWD/zhoQaB3Hc3vT8PubaiCr
         ZIDihKG0r6+zVtGolejA8RekdLUvqAjam0kl3AM1+jpGxOT2GaxGsoxsvFb1oibqcqxN
         T6Pnpl4fCHKd2Vh1r/Eu5/Dh2qz0Sh57afpLvg1P17IOvcHxk+UyDqUEPRtK4fMY/DFm
         Wdq4lXqfq4e7vic2HSei5mCytV8pIJ+VRwFvH1bmNJ88EQtcFwrJ3bFyZIXdXI36uLra
         pGoA==
X-Gm-Message-State: AFuF++mjJUxPghRVe6H7aIBGZsvxZ/9PaljnWk5+8m9GL9Z35Eu8HolP
	Aoba2mi53LxkjLC1R9TJlds429ih6mIlCTmXPk/j/Mz/Aboj9NU34du+rIlFq/Sw2ugFdcMiNQl
	vTgFdiAg=
X-Gm-Gg: AYBFou0ytqbYH7SmYk+JsTQmS1EBShHW+pXZdOznKrTUCTKT0JcrIn7y1ReN5GnKFs5
	hY7jf7VdAXPBaykqSIy1ZJt5vqDFhrMHNWsKVIM0PyqDqgxuL0XxbLPjIPV55nHswkX/77Gax/v
	EYN3BS5Y+ENOqXXguwB0vuVY4qtacnZ8ol5XZCs0LiJ+XTzPky3/l7oez+4Gi5d5JSD4w55v4nN
	2BKZN3nJDoBHNFJ9ZFm6BAmNNKaj0JynHdsg4Pd+C1P13Zf8yZzax7hBgay0igB4OC6FXGbv1UW
	AXYla235nsZ3qaAFOpVPkv+MfSja5alc4A7jUbRrSTxooE9qCD+oVa5GDtiXalTdKa8qnnq/q1m
	y8eYzf8m0jn7N+NcQlFKTJTFDRRc1lYlmRedjN62Uq5I3Bfg4XfGeI+ns2lzCn+BQjyteCxiHcp
	vHDoLFf8CoGcpRhdTgYjUM1OghDnN0pyj9PR6AJu+BgEiHPvUj1z/8vEqtY1N0tfCGfWzer+FtR
	YJTIS1yu6oqkgtEpCGfYg==
X-Received: by 2002:a05:600c:8b38:b0:49d:272d:74b4 with SMTP id 5b1f17b1804b1-49e619a1e56mr80755865e9.2.1789121230555;
        Fri, 11 Sep 2026 03:07:10 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49e6576122bsm41061755e9.2.2026.09.11.03.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:07:10 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@mellanox.com,
	vladimir.oltean@nxp.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 1/2] net: bridge: vlan: fix leaks on switchdev deletion errors
Date: Fri, 11 Sep 2026 13:06:44 +0300
Message-ID: <20260911100645.1360386-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911100645.1360386-1-razor@blackwall.org>
References: <20260911100645.1360386-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vlan_del() stops the software deletion when the switchdev operation
fails which is ok for an explicit VLAN deletion because the VLAN remains
configured but not ok when its VLAN group is being destroyed and everything
is being freed. __vlan_flush() always destroys the VLAN group after walking
it regardless of individual deletion errors, so aborting the software vlan
delete leaks the VLAN object's memory (and potentially its master VLAN, due
to references).

Allow teardown callers to finish the software deletion while preserving
error for reporting. Save the VLAN id before deleting because the VLAN
object can already be freed (queued for freeing by call_rcu).

Fixes: 2594e9064a57 ("bridge: vlan: add per-vlan struct and move to rhashtables")
Fixes: 9c86ce2c1ae3 ("net: bridge: Notify about bridge VLANs")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1e0e436629ec..1748ea1fc202 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -387,7 +387,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 	goto out;
 }
 
-static int __vlan_del(struct net_bridge_vlan *v)
+static int __vlan_del(struct net_bridge_vlan *v, bool teardown)
 {
 	struct net_bridge_vlan *masterv = v;
 	struct net_bridge_vlan_group *vg;
@@ -405,13 +405,14 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	__vlan_delete_pvid(vg, v->vid);
 	if (p) {
 		err = __vlan_vid_del(p->dev, p->br, v);
-		if (err)
+		if (err && !teardown)
 			goto out;
 	} else {
 		err = br_switchdev_port_vlan_del(v->br->dev, v->vid);
-		if (err && err != -EOPNOTSUPP)
+		if (err == -EOPNOTSUPP)
+			err = 0;
+		else if (err && !teardown)
 			goto out;
-		err = 0;
 	}
 
 	if (br_vlan_should_use(v)) {
@@ -448,7 +449,7 @@ static void __vlan_flush(const struct net_bridge *br,
 			 struct net_bridge_vlan_group *vg)
 {
 	struct net_bridge_vlan *vlan, *tmp;
-	u16 v_start = 0, v_end = 0;
+	u16 v_start = 0, v_end = 0, vid;
 	int err;
 
 	__vlan_delete_pvid(vg, vg->pvid);
@@ -463,12 +464,13 @@ static void __vlan_flush(const struct net_bridge *br,
 		}
 		v_end = vlan->vid;
 
-		err = __vlan_del(vlan);
+		vid = vlan->vid;
+		err = __vlan_del(vlan, true);
 		if (err) {
 			br_err(br,
 			       "port %u(%s) failed to delete vlan %d: %pe\n",
 			       (unsigned int) p->port_no, p->dev->name,
-			       vlan->vid, ERR_PTR(err));
+			       vid, ERR_PTR(err));
 		}
 	}
 
@@ -838,7 +840,7 @@ int br_vlan_delete(struct net_bridge *br, u16 vid)
 
 	vlan_tunnel_info_del(vg, v);
 
-	return __vlan_del(v);
+	return __vlan_del(v, false);
 }
 
 void br_vlan_flush(struct net_bridge *br)
@@ -1369,7 +1371,7 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 	br_fdb_find_delete_local(port->br, port, port->dev->dev_addr, vid);
 	br_fdb_delete_by_port(port->br, port, vid, 0);
 
-	return __vlan_del(v);
+	return __vlan_del(v, false);
 }
 
 void nbp_vlan_flush(struct net_bridge_port *port)
-- 
2.47.3

