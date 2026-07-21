Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B5384244
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642970; cv=none; b=LdqWeCFYxmi3MgkwRt+Z4PC3lvyS1vYWWiQdBmmF8nxqQ/zcbbnIzAKe4TYpPP6UQPrSakBg5p9DQEDjrSubK7MD2DSq1Nb9mm1g29unEYitaEa+p09Bf8zKnOpxB9NiUarCnzjZ2T3cwsvfGEUA1qi52M8Z8gkbCBnljQO46Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642970; c=relaxed/simple;
	bh=Fn+8gl65km4dr4U2bzehxJ91qeoxgZnZt8JL0WXZSJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRaBq9XFdTa/p6LEWNFZOtCP0AHSY5bZpw3JjFrHHqnaQE9DU/iJvEmRubUOGZ0aG7J5yqsweS3QcWF2BRVjsxAnPyo/zLjINQ1b0+C81Zl4F7M3qmKgwdjBzIHREaeiPJjgkba2tMXS5RnE6rcIi86W3oPofh7aP7gXij3k+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GagEug+v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GagEug+v"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso26153635e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784642967; x=1785247767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bV8sKewn/Iiw+wxDCFC7KDgjO9zhL+uosB6vYvMCN/o=;
        b=GagEug+vPxv0twNC9i9HutqMTlBq6uXI6xNhrUJ5ONSqGwqOFyHKg5CUaYBCvrI5r5
         g5w66ju0m6uLHikZgUnOqv4tJL/pqwUirAfjXS05vu1NQC9dc5LkH799lSPwkertql3F
         X5regAzP5cZFSIZ37D3EKenpZ7Na69uKnIb8GW+xgQgqBaWc8VGDbll12O+Y2bnLy/EX
         fEiWLjo99J/SdGZFYXtpuF0Z1ybTA31t96geoOGIyJejzleBGF/BcxNKeXgS2sohVtsp
         Jl77Abb5bKpwuYvTdQuHgNe+v9LxjK5b9lZylUWYRkdF8NVHLYq+KZ21U3v6DKFzl733
         XPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642967; x=1785247767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bV8sKewn/Iiw+wxDCFC7KDgjO9zhL+uosB6vYvMCN/o=;
        b=H42L+YRJXpLtZWPXCLMW13Lishy9h9yiFlD4oLgF0ERSs7j3p8iOkCpIgg8E1wxWwD
         WJgOlNGfgQ2U+XQ7R8MXALeBFOocRFcuCYNdF7nYAgEW3LQwpQv49QXvOowm4gPS6ICc
         +uNkJxR86lrH1Sv8cbeTboqpSHwGOkfaQjaxce8cTOiLoFTIf9VeRyyoHMxjOr3xW5Ss
         fobGKD2eRL+hBotbG0BcH7EX3g0mOqRRBr+luU1+HF8Oc78SU2yL5qqXoq8rsm0HtnwE
         O40aSQ/2WlEMQcPU79bXlHmXxe2mpMMLucJ7bnIfIRZzXRblcWabxNU+r2h3Cn9FuCRc
         V3uw==
X-Gm-Message-State: AOJu0YwDwBWbJJ9eT1O0VUutOsOCY6DxUlguTh48yXD67EPYwLvOglmw
	kwho1GQ9/Vp5APX7m1nzFtzdVEJj8lZ2GiI96ijsk9ZcRHcXHcADRs+fZ0JSfc7jJlMo9OAzP8Z
	14Tb96Ig=
X-Gm-Gg: AfdE7cnIylt0cGtap1OHVERWOf3dFqXKxCJ4MrPFAvaJ6ymqS1EUP56ed8dMv3I3QlZ
	0Go1cIsm6+I/or6xr1JiJFcZFCaT3rleCp1+VxN+Cj2EaAWdb17bVlfOr9aYL/UsP5mM9JqWxhv
	gM37lMc1tWT9XQarjxpk4+hb4eDmn62HuPeNwmALf5r+YK7js02kPW3QKYENP6KM+oKyimuc8Zv
	uu3gF5PzV3xU4K4PpYKSDgqnmC9kZaTo4BAUPNq0QgPVeIq66GKSCjbEDAeZwlZiYKO+KGoPATn
	eb0eqzVPp4Zpv+feqSEIHua4nOGS17n/z1RU1AVVFpki6NlbZDRssFxQLxNNDBFilw/LRcdn5cY
	Mcm8vBIC0RZrSFzP9Pe/Wq7UfKOnifhbslT9opkxc7oRDt82tzZvczVacBrN3+aviRhTgUla7s4
	ApQhMvN2c4fizCksJlBq+yOL0X
X-Received: by 2002:a05:600c:285:b0:494:596e:e8c4 with SMTP id 5b1f17b1804b1-4954a3fd583mr145856345e9.17.1784642967240;
        Tue, 21 Jul 2026 07:09:27 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63ed1911sm42139358f8f.22.2026.07.21.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:09:26 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 1/2] net: bridge: vlan: fix vlan range dumps starting with pvid
Date: Tue, 21 Jul 2026 17:09:21 +0300
Message-ID: <20260721140922.682265-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721140922.682265-1-razor@blackwall.org>
References: <20260721140922.682265-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug in all range dumps that rely on br_vlan_can_enter_range()
when the PVID is a range starting VLAN, all following VLANs that match
its flags can enter the range, but when the range is filled in only the
PVID VLAN is dumped and the rest of the range is discarded because
br_vlan_fill_vids() checks for the PVID flag. Since the PVID VLAN can
be only one, we need to break ranges around it, the best way to do that
consistently for all is to alter br_vlan_can_enter_range() to take into
account the PVID and return false to break the range when it's matched.

Before the fix:
$ ip l add br0 type bridge vlan_filtering 1
$ ip l add dumdum type dummy
$ ip l set dumdum master br0
$ ip l set br0 up
$ ip l set dumdum up
$ bridge vlan add dev dumdum vid 1 pvid untagged master
$ bridge vlan add dev dumdum vid 2 untagged master
$ bridge vlan show dev dumdum # use legacy dump to show all vlans
port              vlan-id
dumdum            1 PVID Egress Untagged
                  2 Egress Untagged

$ bridge -d vlan show dev dumdum # use the new dump (RTM_GETVLAN)
port              vlan-id
dumdum            1 PVID Egress Untagged
                    state forwarding mcast_router 1

VLAN 2 is missing, and if there are more matching VLANs afterwards
they'd be missing too.

After the fix:
[ same setup steps ]
$ bridge vlan show dev dumdum
port              vlan-id
dumdum            1 PVID Egress Untagged
                  2 Egress Untagged
$ bridge -d vlan show dev dumdum # use the new dump (RTM_GETVLAN)
port              vlan-id
dumdum            1 PVID Egress Untagged
                    state forwarding mcast_router 1
                  2 Egress Untagged
                    state forwarding mcast_router 1

Fixes: 0ab558795184 ("net: bridge: vlan: add rtm range support")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
The change for the tunnel should add a separate notification for a PVID
VLAN which is fine because br_vlan_notify will properly fill in the pvid
flag for that VLAN.

 net/bridge/br_netlink_tunnel.c |  3 ++-
 net/bridge/br_private.h        |  6 ++++--
 net/bridge/br_vlan.c           | 10 ++++++----
 net/bridge/br_vlan_options.c   |  3 +--
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 71a12da30004..a713668ea34f 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -271,7 +271,8 @@ static void __vlan_tunnel_handle_range(const struct net_bridge_port *p,
 	if (!*v_start)
 		goto out_init;
 
-	if (v && curr_change && br_vlan_can_enter_range(v, *v_end)) {
+	if (v && curr_change &&
+	    br_vlan_can_enter_range(v, *v_end, br_get_pvid(vg))) {
 		*v_end = v;
 		return;
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d55ea9516e3e..d3880f31edc4 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1627,7 +1627,8 @@ void br_vlan_notify(const struct net_bridge *br,
 		    u16 vid, u16 vid_range,
 		    int cmd);
 bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
-			     const struct net_bridge_vlan *range_end);
+			     const struct net_bridge_vlan *range_end,
+			     u16 pvid);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 				    struct net_device_path_ctx *ctx,
@@ -1874,7 +1875,8 @@ static inline void br_vlan_notify(const struct net_bridge *br,
 }
 
 static inline bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
-					   const struct net_bridge_vlan *range_end)
+					   const struct net_bridge_vlan *range_end,
+					   u16 pvid)
 {
 	return true;
 }
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 5560afcaaca3..31c1b2cf75d9 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1982,9 +1982,11 @@ void br_vlan_notify(const struct net_bridge *br,
 
 /* check if v_curr can enter a range ending in range_end */
 bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
-			     const struct net_bridge_vlan *range_end)
+			     const struct net_bridge_vlan *range_end,
+			     u16 pvid)
 {
-	return v_curr->vid - range_end->vid == 1 &&
+	return v_curr->vid != pvid && range_end->vid != pvid &&
+	       v_curr->vid - range_end->vid == 1 &&
 	       range_end->flags == v_curr->flags &&
 	       br_vlan_opts_eq_range(v_curr, range_end);
 }
@@ -2066,8 +2068,8 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 			idx += range_end->vid - range_start->vid + 1;
 
 			range_start = v;
-		} else if (dump_stats || v->vid == pvid ||
-			   !br_vlan_can_enter_range(v, range_end)) {
+		} else if (dump_stats ||
+			   !br_vlan_can_enter_range(v, range_end, pvid)) {
 			u16 vlan_flags = br_vlan_flags(range_start, pvid);
 
 			if (!br_vlan_fill_vids(skb, range_start->vid,
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index fcc200c3e3da..cb0f556ff40d 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -350,8 +350,7 @@ int br_vlan_process_options(const struct net_bridge *br,
 				continue;
 			}
 
-			if (v->vid == pvid ||
-			    !br_vlan_can_enter_range(v, curr_end)) {
+			if (!br_vlan_can_enter_range(v, curr_end, pvid)) {
 				br_vlan_notify(br, p, curr_start->vid,
 					       curr_end->vid, RTM_NEWVLAN);
 				curr_start = v;
-- 
2.47.3

