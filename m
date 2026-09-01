Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1D36B91D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264472; cv=none; b=Ldu0buvwxXHF5yOUwVd9U1yN3Sm7h/vamoES2BlIWZMFoKQRF5zjIigqyIUa0F6j8oMls1Q+yfG8yr57ZtjD1PxiqK9XjfKky+VVCuvUL7L8JXOyJHxEevtccvkLPudUfU7mw/mJyfNgcgLoBQOnOk3wfVolAjtYFnbDL+i7V3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264472; c=relaxed/simple;
	bh=w14NQGUpkvlFQCiflKIsxCzYZ1NbuTyJ6r2h4/Ei098=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/d/fXY8RohZKAXyai9wfi8gVVUlZ1h7JVWwjN6vPWclXDzUxYldlnolfjfNemPX8s5ALdL1QMxCmX6mKNvjNlD3bNZFMVKyr+U2UqyJAum4bJ550v+e0PmrtM7BJT4haMbHfeSOEkLD4330MdzsQXmW0B3A0/m3SJyJp5FVZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bubnzi93; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bubnzi93"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4843e397f74so892165f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264469; x=1788869269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U/aTEnKjA69JOD+I1au9uLwwmHbzGmgWlhznTgaQ+Ps=;
        b=bubnzi93MtO7GohWQFCsbwOLq5MSWspTykOix2yk7+G3ixm7/a8DOMR8GxFAYXNzPp
         gJZvkjzrODHh0CjkILCA+ABnZf/rTF085vEQseq5Evp8BzYqItZy6TJpISOHQDkrQlw8
         BDwjjds23UTgBu3sz/kLCXMKKtVg+RRYR7zypk1//pnJ84s0N0cKdT0JHnT/sfVmKxAS
         prIXZcqiIdhZobOy+DtibYECcOywUZYIgYS99gnavfZtiWDygcnlB3u63QDjLBjou1SE
         G592lj4BaBiXOQVxWh004vCCgnMPmHqB9OD0aoze0MiY5Y0Z7H6RXEFZssgJbvbjeiuH
         qrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264469; x=1788869269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U/aTEnKjA69JOD+I1au9uLwwmHbzGmgWlhznTgaQ+Ps=;
        b=EQubPBvJq9EldmhRiJaMqC5a2nwyIBznjRouuuz3SFC//t+5z8OGc7Lo2hhlFil6lD
         BsXDosI6psYsYl2tIR9MF58mM2Qkk5nrULrdNAlkhFEH4haG/tAz4s7ue8Kqs2MuF6Wx
         sY8Nj3lqSbHzeWnU1fdoU7BnSCUql4iv4y1fElgwxkT3QFhbeesgTl2ROwDqpMeMLqHG
         PWwzrCnoprkqnFIkJXQhvBjFjjkJvKQq0ziKy7t4PK6lIxuWqaxED+MUzz1XX/wTHI1E
         4UiePFIDt7EhLINBpgAnWTcQ0Nh1Zwm2KG+I3UBzK7O3lEh+JZ3sCdAxUJsKmQcZb8Q1
         yDcA==
X-Gm-Message-State: AFuF++m64QQEldi/sp9vIBM35aCLj8DjI3B01jauwtCqYaxn6hhAho2g
	HvD7cnVroCB7+OVW0NZX0UUZDTanzkcat2RzMdPh8yknG/9e53SD6HYKwSX2NdazAyX15S7Iu0c
	1t/sXimP76g==
X-Gm-Gg: AYBFou2v6SUOgBCIxqh3b4HLQNrgwJR3RBdGm0olHsqkk//dOjPzHxiEW4W8jxBOmo+
	Hbn4REgyaIpl8gXStxyZ/LqPe3rVqK7kHy06QuUTCfTQ+z3w/HDO3Gok2Kggt9RTvO7pyFOAahL
	bQaZIHttC8Gx0nM9w910bGpgqHW9lh+fkD8DJGJ/GXHzC9FL0GkGYDrkQ5chZG1AugbEMpuOTzA
	Wz04nQjGmhEfwJ8rmaaMLVV5byoYHmZKwzM8n6hKFT0LYSGoduwy2Dp5Xqr+cEMQ+frkYR83gAp
	wr6yB8CDi1dO4PO4Rmy2/XgnxG7OtgppI0kgjiiBiqkz6JDRH81azmouSIS/or5aoJil6KmDQ2Q
	Pzq9rWvBvek/S6piNwIV4/CfZpHljHlJHLYqoYAJLrNozpPjnLFe1ghLb1mgkofFD7WxPvafwvU
	rNYz9JjAJpJK/NbGv7RXvr2lihbnwhB48Lj34gnDo+5mkcASC0V4ZN7oAUFiNiYt8pcoIyNALsz
	T4mSNFf70g=
X-Received: by 2002:adf:e00f:0:10b0:484:42c1:41bc with SMTP id ffacd0b85a97d-48442c142aamr6299098f8f.5.1788264469283;
        Tue, 01 Sep 2026 05:07:49 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d781bcsm4241292f8f.26.2026.09.01.05.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:48 -0700 (PDT)
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
Subject: [PATCH net-next 8/9] net: bridge: vlan: add missing tinfo.tunnel_id annotations
Date: Tue,  1 Sep 2026 15:07:20 +0300
Message-ID: <20260901120721.747908-9-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I annotated data races around tinfo.tunnel_id before, I missed a few
places (e.g. bridge notifications, rhashtable compare), so add them now.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_netlink_tunnel.c | 12 ++++++------
 net/bridge/br_vlan_tunnel.c    |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index e7eceab5b515..58ec7bf1d8f5 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -29,8 +29,8 @@ static size_t __get_vlan_tinfo_size(void)
 bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
 			const struct net_bridge_vlan *v_last)
 {
-	__be32 tunid_curr = tunnel_id_to_key32(v_curr->tinfo.tunnel_id);
-	__be32 tunid_last = tunnel_id_to_key32(v_last->tinfo.tunnel_id);
+	__be32 tunid_curr = tunnel_id_to_key32(READ_ONCE(v_curr->tinfo.tunnel_id));
+	__be32 tunid_last = tunnel_id_to_key32(READ_ONCE(v_last->tinfo.tunnel_id));
 
 	return (be32_to_cpu(tunid_curr) - be32_to_cpu(tunid_last)) == 1;
 }
@@ -43,7 +43,7 @@ static int __get_num_vlan_tunnel_infos(struct net_bridge_vlan_group *vg)
 	/* Count number of vlan infos */
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		/* only a context, bridge vlan not activated */
-		if (!br_vlan_should_use(v) || !v->tinfo.tunnel_id)
+		if (!br_vlan_should_use(v) || !READ_ONCE(v->tinfo.tunnel_id))
 			continue;
 
 		if (!vtbegin) {
@@ -124,19 +124,19 @@ static int br_fill_vlan_tinfo_range(struct sk_buff *skb,
 	if (vtend && (vtend->vid - vtbegin->vid) > 0) {
 		/* add range to skb */
 		err = br_fill_vlan_tinfo(skb, vtbegin->vid,
-					 vtbegin->tinfo.tunnel_id,
+					 READ_ONCE(vtbegin->tinfo.tunnel_id),
 					 BRIDGE_VLAN_INFO_RANGE_BEGIN);
 		if (err)
 			return err;
 
 		err = br_fill_vlan_tinfo(skb, vtend->vid,
-					 vtend->tinfo.tunnel_id,
+					 READ_ONCE(vtend->tinfo.tunnel_id),
 					 BRIDGE_VLAN_INFO_RANGE_END);
 		if (err)
 			return err;
 	} else {
 		err = br_fill_vlan_tinfo(skb, vtbegin->vid,
-					 vtbegin->tinfo.tunnel_id,
+					 READ_ONCE(vtbegin->tinfo.tunnel_id),
 					 0);
 		if (err)
 			return err;
diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 257cae9f1569..04751f15d708 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -22,7 +22,7 @@ static inline int br_vlan_tunid_cmp(struct rhashtable_compare_arg *arg,
 	const struct net_bridge_vlan *vle = ptr;
 	__be64 tunid = *(__be64 *)arg->key;
 
-	return vle->tinfo.tunnel_id != tunid;
+	return READ_ONCE(vle->tinfo.tunnel_id) != tunid;
 }
 
 static const struct rhashtable_params br_vlan_tunnel_rht_params = {
-- 
2.47.3

