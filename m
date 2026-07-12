Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089EB35C197
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783883798; cv=none; b=jdAbJ5m0jCnmWM36jhTs3fOfwhJR6Lr80EFy54gykcbQ5Dej5i8IiQKgDMFFEct4Yxu/Gm1iRmVPFiCYjFenyz9LzFVj7l/bokHZ+s3Iw1kQ4vjL4PIKa6EiJ7S7fkxKEqvXxVo4HeNDKExiWV4g40alAmDzwTjlZF2C6ND/jAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783883798; c=relaxed/simple;
	bh=JrTPNvQ0flhd1tFp7KOKk0TjVPFOh/+u3dYBiZMQES0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdqKwdXOVSaH6Ncze/BMDoBi1FK+B5l3pkbg3xpWLD8AUiGT96bG3i5FjcuTD0KF/rQICTQewZKNqJlY0UNS55I8OXF3m67YG6ZgTUiNVFVxt9e6AfIDhwh/LagIRMFmkAWo6k0FFWsIZbLYAA9gxM/HTuEVGVYaUo8/sJsdjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlJZBupE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlJZBupE"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8487b7b4066so2025444b3a.1
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783883796; x=1784488596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXvw9tkS7HVFrKwqha0vwk13jo9XOAWNQkd/wZQoS/A=;
        b=TlJZBupEcB85gkE4FEmh1x97+bEAqphFEC59x3y4lA5rQYmayN/qbipR03gUO1xSlu
         oo3K8eJvnfWOnWndCUOlyGBesW9GZ/MTl3U3GsaeH2jPx6vSO79DCkKB9FTrQ24jQheX
         7dyztGkKo9ae8MM1Gr1x9gasWBzkKRUYHJPJ6gb9WFufkqsyKByG6cO+tNU0wHdAru9O
         T6sr1aRg0rOScgZOogKSx4cBKDZq08JThbPlaD90XAgN/SXpWkruAod83N+0hHaU+KSb
         mVc3CtdRDpC35aGMJrNKE8477cakk5J4hd02uE6DtN6n/HgMM0IPu1u6E6uoZWSpQ2PG
         XFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783883796; x=1784488596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MXvw9tkS7HVFrKwqha0vwk13jo9XOAWNQkd/wZQoS/A=;
        b=GxOLzVBryvQGAHZ6yvfwK1FzrcpLziRUWfOnuK77YkNfxHWDOgCZZk7CMYEDqflyQY
         Ewp8dqlSZjH6EajE1fEJDxqA8/YQaaiQxLnsnTca+cNOhoiFCgQISiYYjQPBAC7P42MR
         t96aZazxK6jcpnlfeSjJKdOswzPUzFk4niJhZm+5zDDO4JY8MbX0nVM4CiT7h0DHQZuL
         1Vkeu0OMd6Kx04Y/L+YJOh38Ht4WvuHRVdIplsYHs0N4uwWxHClH2L1he6DCSngXgqlu
         a6fh9eZ9hYVCdBmqpbi8V6Hx+4q7bsfjHkYtx9DEgmlQDaWLvpORpx7fjA9VUwq4Vrqk
         eROw==
X-Gm-Message-State: AOJu0Yy00U5xt86v5OkWqMKAiRWmTyWz6Jn4ucgZb2k+i7uZzchyxcwZ
	nrlpk45k14lnv3WW+m8V0XtAvulPNqpaXdrhwwkd8j5rdX3giE4J9lnJtZNmadCd
X-Gm-Gg: AfdE7cnHjlw+bmcxm7GwKpAlv2Xoq664lHKjJBGmdO9Y3rWAS3ARkUhDxJaen5Hiyv5
	FzX6ZLXV9OwqUPSPXB6ORTWtBzcLzMt3pQEXczjkPGjH84Y70Jujt/VY0gb9A+wiDr+Njrx7F35
	25VsPHTQbuc2zglJwPbhBJ2FNQqQXJtXucsZVglrwogoTMCrky7FOA5UqN03oqz1+o3YmCdZ1Th
	jgvZfc50J10BaGbALtuFzPTI4VOaEJvq+5iwAx6qK07KixOhfbpMq/SBVIw1MMlSOp9URI5fn/h
	/5Sz+XWuFrvJHszYZRFwq4q9ZdUfTQ+Vt/pT9fLCXpn8cXjrm1ugttJqfnP31rCIkZmWsvyIHtI
	dg/W6p2+4cADnlJHLaQA2DUA9lDwCir6If6c/w+mEyaGQ3dLXJRj6JwjdxzYhnDNUGOoFbMN4PD
	uq/K2AYrAWFyWUB43w0SRhJijnXOqQinU0mk9dzoDXsTPedekLlRwFjX17
X-Received: by 2002:a05:6a00:18a0:b0:842:2ae0:968d with SMTP id d2e1a72fcca58-84889625055mr5396777b3a.32.1783883796276;
        Sun, 12 Jul 2026 12:16:36 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm13079371b3a.60.2026.07.12.12.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 12:16:35 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Ma <jack4it@gmail.com>
Subject: [PATCH net-next 1/3] net: nexthop: add NHA_FDB_PORT for fdb nexthops
Date: Sun, 12 Jul 2026 19:12:16 +0000
Message-ID: <20260712191218.236-2-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712191218.236-1-jack4it@gmail.com>
References: <20260712191218.236-1-jack4it@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries") lets a
single inner MAC be reached through a group of remote VTEPs, with the
kernel flow-hashing across the group members.  Each member carries its
own remote IP, but the UDP destination port is always taken from the
VXLAN device (vxlan->cfg.dst_port) and cannot be set per member.

Some deployments pack several receivers behind one underlay IP and tell
them apart by UDP port, so they need a per-nexthop destination port to
spread flows across (IP, port) tuples rather than IP alone.

Add a netlink attribute NHA_FDB_PORT (__be16, mirroring NDA_PORT) that
carries an optional UDP destination port on an fdb nexthop.  It is only
accepted together with NHA_FDB and NHA_GATEWAY; it is stored in struct
nh_info and echoed back on dump.  This patch is control-plane plumbing
only; the VXLAN datapath is wired up in a follow-up patch, so behaviour
is unchanged for now.

Signed-off-by: Jack Ma <jack4it@gmail.com>
---
 include/net/nexthop.h        |  2 ++
 include/uapi/linux/nexthop.h |  3 +++
 net/ipv4/nexthop.c           | 20 +++++++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 572e69cda..9c8227996 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -28,6 +28,7 @@ struct nh_config {
 	u8		nh_protocol;
 	u8		nh_blackhole;
 	u8		nh_fdb;
+	__be16		nh_fdb_port;
 	u32		nh_flags;
 
 	int		nh_ifindex;
@@ -63,6 +64,7 @@ struct nh_info {
 	u8			family;
 	bool			reject_nh;
 	bool			fdb_nh;
+	__be16			fdb_port;
 
 	union {
 		struct fib_nh_common	fib_nhc;
diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index bc49baf4a..e587bbf3b 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -83,6 +83,9 @@ enum {
 	/* u32; read-only; whether any driver collects HW stats */
 	NHA_HW_STATS_USED,
 
+	/* be16; UDP destination port for an fdb nexthop (e.g. VXLAN) */
+	NHA_FDB_PORT,
+
 	__NHA_MAX,
 };
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6205bd57a..5b27cc9a9 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -39,6 +39,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 	[NHA_ENCAP_TYPE]	= { .type = NLA_U16 },
 	[NHA_ENCAP]		= { .type = NLA_NESTED },
 	[NHA_FDB]		= { .type = NLA_FLAG },
+	[NHA_FDB_PORT]		= { .type = NLA_U16 },
 	[NHA_RES_GROUP]		= { .type = NLA_NESTED },
 	[NHA_HW_STATS_ENABLE]	= NLA_POLICY_MAX(NLA_U32, true),
 };
@@ -956,6 +957,9 @@ static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
 	} else if (nhi->fdb_nh) {
 		if (nla_put_flag(skb, NHA_FDB))
 			goto nla_put_failure;
+		if (nhi->fdb_port &&
+		    nla_put_be16(skb, NHA_FDB_PORT, nhi->fdb_port))
+			goto nla_put_failure;
 	} else {
 		const struct net_device *dev;
 
@@ -1055,6 +1059,9 @@ static size_t nh_nlmsg_size_single(struct nexthop *nh)
 		break;
 	}
 
+	if (nhi->fdb_nh)
+		sz += nla_total_size(2);	/* NHA_FDB_PORT */
+
 	if (nhi->fib_nhc.nhc_lwtstate) {
 		sz += lwtunnel_get_encap_size(nhi->fib_nhc.nhc_lwtstate);
 		sz += nla_total_size(2);  /* NHA_ENCAP_TYPE */
@@ -2956,8 +2963,10 @@ static struct nexthop *nexthop_create(struct net *net, struct nh_config *cfg,
 	nhi->family = cfg->nh_family;
 	nhi->fib_nhc.nhc_scope = RT_SCOPE_LINK;
 
-	if (cfg->nh_fdb)
+	if (cfg->nh_fdb) {
 		nhi->fdb_nh = 1;
+		nhi->fdb_port = cfg->nh_fdb_port;
+	}
 
 	if (cfg->nh_blackhole) {
 		nhi->reject_nh = 1;
@@ -3147,6 +3156,15 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 		cfg->nh_fdb = nla_get_flag(tb[NHA_FDB]);
 	}
 
+	if (tb[NHA_FDB_PORT]) {
+		if (!tb[NHA_FDB] || !tb[NHA_GATEWAY]) {
+			NL_SET_ERR_MSG(extack,
+				       "FDB port can only be set on fdb nexthops that have a gateway");
+			goto out;
+		}
+		cfg->nh_fdb_port = nla_get_be16(tb[NHA_FDB_PORT]);
+	}
+
 	if (tb[NHA_GROUP]) {
 		if (nhm->nh_family != AF_UNSPEC) {
 			NL_SET_ERR_MSG(extack, "Invalid family for group");
-- 
2.43.0

