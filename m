Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF6393DCD
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428407; cv=none; b=k94nwfcGtkOb8zACNtu2oRBkwVSi52vH7ew9q/jxvNCKy9QwWS8icKBjOBtan3bLdTruRn9itb9aBXK25PtaFZQTqA6nUPNCrfXpaK+WDPWWrQ6yjkeEd5DxqFceSI9BKOffDUvfd4WD+mEfOfvV4m891LIHlQZ62q2p1RJ9TSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428407; c=relaxed/simple;
	bh=wz4keuX0h1t4uesVF64NbRSyPXsVWi/lr7DkR/S5oT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jYZAcl0xZTHdsE8wjx/PdLN9em0ZNEqVLBM3gVdX0DFKzmtE/zAPR5xsg2DPOb2ujfV7YqBosaWx9cVI28gu0KFk9rojgWJF479SAj+mKbFnxtDaGEX5SdNrpC25bG7SsIPqOGnsFutVsD6vs2k3W+kJ69wV8JeQ+28zKkjQR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=c/BpILMN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="c/BpILMN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so21452885e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788428404; x=1789033204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNVK+ncMXTVlIksAK/ckFMkJgOdGgxwOoFQ9vZoAv8s=;
        b=c/BpILMNwlAhcbxJ8se1pt4fwU0remyrPJtHs7zIV4wD9ZvYGtj0Ln0BGKpJUewJGo
         7iW49Al54VVsWDJ/MjbOuDtR+xRlekOD9LUqKr6CUcnwog6Gn9nz0hh2RHvEo5zZ7I9J
         +xA0VaVNEcxJLmbCYVG9fJXsgEl6J2X2wxGQg11Z8HcAeEWC3TvTJonNi7XZMglzT0lC
         b42PBTPGO6Yia1SOLa5KfbWfiUyr211Pp3myiHBqkENI3O3vrv8wAdYOJ+ve3+1oxUrC
         x9vEDxQwL5TGbIdGW3iLWoUTgmSGbVh127ZeHh1oos8F1mzpeeIYpNUoJqOACy9THZnP
         l4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428404; x=1789033204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNVK+ncMXTVlIksAK/ckFMkJgOdGgxwOoFQ9vZoAv8s=;
        b=RVIBPrJcWvgC1Das49gjeGOFZRB1pqrb04ZtSskSiAaLvhDpTLKgj9/UM+lRYYpBXE
         sdLTdBamI/+FqpUgKsxFMkalFOg6ZgLBkPtKwDl0/gmUHDMV6Osl4SnatmN5gQ/fApI5
         zSVKaonLqHWj3S2C/HHyZ9z01TNcHnYFirRsVBR16Mz7PB+1QSIdRpyb91O7sL3xbXAm
         qbsUZxOEyF9gXnxXZYmGxPLbVFWnF23UCVCGy/iQmpqxsLy/Y/B17bJEZE2tvyLe3Iz1
         PRLP7CuAXiAGMczPL8KLSc86Gh12RDK9O+cAYl95tOwSu+FZgB3fvXEB3Fr5o2gYwXZJ
         SCTA==
X-Gm-Message-State: AFuF++ntfM66KgfXnZEJj0LVefu3IGM7hbaTS4HtRmyfrSm8EKizRQ0M
	f/9oo+qsbSdEhpdeFiq9rNhTDSpKBUb84pT3GZaLo3dOS0j3pkJ03d8j9Zd0vLXJmxVhFOpJKCO
	2ydaJ2PU=
X-Gm-Gg: AYBFou3x5KadPloHFi77U4HDyTHmV9pG3IeKgrfPt/xfVLJcsRbXMJu//PAUG7pDMGv
	h09WINcAog/bx6qmxroiVTOAArJh078B95wUAwpr9HcFF+VL5z47s94LIbfbpSMRq4OP6BB2doK
	evPKquzQUM/xRg4qF7dDfX8LiYuIl2iEgAzVlXj/ZpcOVFEvEULBG2T4LlIIJXDqIXRKs8jdJxd
	Cl8vjY6pTjUU5W+9GRYKdqYwiFic9Khf8VOEPuroIPIqImsbPFo3hVuFurH/QsckOsH6SJmUiWr
	P0qCaZ7U5Vr9tNmgEtajIEbuAGi0riAsYvvAkRT5P2jykTweoum0JZ/JpgCsuik8jq2yTN0XKF6
	4SY+k4li8XN7qSKeZE3LsVcAd51ncZHnaWsay28KtibU4ASmi0s340aEJLPs/YTwQvmIF28azNx
	B8PZp4HhcSEM51KfrvR39jH2Wbw45kFzjYDsjQ0f1fJ1yu/0BmfIgQr5NpGLgG44RA1J+Yxtl/F
	xTIct0UXnY=
X-Received: by 2002:a05:600c:608c:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49ce5826c6amr221601125e9.16.1788428404306;
        Thu, 03 Sep 2026 02:40:04 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49ce58da3acsm235767525e9.0.2026.09.03.02.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:40:03 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linus.luessing@c0d3.blue,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v3] net: bridge: mcast: properly convert mglist to rcu
Date: Thu,  3 Sep 2026 12:38:51 +0300
Message-ID: <20260903093851.1494297-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported a bug [1] that br_multicast_del_port_group unlists the
port group not using proper rcu helper that preserves the next pointer and
after that immediately frees the port group without waiting for rcu grace
period. The only rcu walker of mglist is br_multicast_list_adjacent() and
it turns out that function has always been buggy because mglist was never
properly converted to RCU. Fix it by converting it to rcu and moving its
initialization after eth_addr's. Initializing p->next can use
RCU_INIT_POINTER because we have a barrier from the hlist_add_head_rcu call
later, besides we're initializing an unpublished structure anyway.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com

Fixes: 07f8ac4a1e26 ("bridge: add export of multicast database adjacent to net_dev")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v3: a new patch, it converts mglist to rcu and moves the publishing after
    all struct initializations
v2: https://lore.kernel.org/netdev/20260901074046.316190-1-razor@blackwall.org/T/#m62e08b85f208b1c438e2fda2d5d8eaacf0e96c6f
v1: https://lore.kernel.org/netdev/20260828100642.2664347-1-razor@blackwall.org/

 net/bridge/br_multicast.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3e9b10f8abf1..2f9bb30e1a1f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1441,16 +1441,17 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 		goto free_out;
 	}
 
-	rcu_assign_pointer(p->next, next);
 	timer_setup(&p->timer, br_multicast_port_group_expired, 0);
 	timer_setup(&p->rexmit_timer, br_multicast_port_group_rexmit, 0);
-	hlist_add_head(&p->mglist, &port->mglist);
 
 	if (src)
 		memcpy(p->eth_addr, src, ETH_ALEN);
 	else
 		eth_broadcast_addr(p->eth_addr);
 
+	RCU_INIT_POINTER(p->next, next);
+	hlist_add_head_rcu(&p->mglist, &port->mglist);
+
 	return p;
 
 free_out:
@@ -1465,11 +1466,11 @@ void br_multicast_del_port_group(struct net_bridge_port_group *p)
 	struct net_bridge_port *port = p->key.port;
 	__u16 vid = p->key.addr.vid;
 
-	hlist_del_init(&p->mglist);
+	hlist_del_init_rcu(&p->mglist);
 	if (!br_multicast_is_star_g(&p->key.addr))
 		rhashtable_remove_fast(&port->br->sg_port_tbl, &p->rhnode,
 				       br_sg_port_rht_params);
-	kfree(p);
+	kfree_rcu(p, rcu);
 	br_multicast_port_ngroups_dec(port, vid);
 }
 
-- 
2.47.3

