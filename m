Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34D3AD53D
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270746; cv=none; b=bL8Cs0xLvjMUOBQDwM1GA81w1SMyR8KAyvr/lZhExl9fXV68svXQDuUTc/luw5zzlavD8EzH4KPRvrpGt/4U9rDU4/cLAYbt2MMNs5cjkAQMENeAiw+SqV08F0N/t81QUIdiQazaBWyKKYhjeUa9PrkmIf4dEQ/x558QnXofCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270746; c=relaxed/simple;
	bh=sl8mscsoPTPSyi+19hbwFh+F3vzBp+hyHWcG3uotCtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKBCzhqNvK8Vyy6H5c2KC40dUFPg86EJHvnwGHzulZA3uA3bQhjS9H/iBjcR/9QliwM8CKkXTUzL5ZkHmdFz7+4eVKus060cTMAYgLTVGV8OpyshEFel8fzscmTUjxUIrj0HBAqLRTMJNsuaJFxyYP6pNj/m3UwjJo4o5DKqviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLsmSDRA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLsmSDRA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485ef63b68so6960189b3a.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784270726; x=1784875526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eHqB+0XtN75taQRaVYwBwvw8FBQBWfUPu65PH2IoQnQ=;
        b=YLsmSDRAsprxiUQKmPwTnu/74GufZrN1wqK8+HDkoZ+/5ht+a0y0JMso5paTn8kubr
         XkUCi1DiNi5gtGoUemA8Cut6maC1ZLmNo8G+omcoG/kYUuE0Shb0S1/8XGagZF+vl/Tk
         /bDEjNH+HtSCS2sGNpaykDHEfv6Sdc5AIr7qUVLj2Z1NMt57yOM+pZabpQCTad1UTOWS
         7uR3gmUUMl1RJdKyJENYeIcLIcvOz3ShACXz0D411ITpA0ugUX2E0tsw/tSPetgyC/ec
         tIvw+k2P2g8D7JsO9zMpeyK7x8pdGm8XD24e4T9uPAnrt0dASgUE9aiiSF5J+aQ4v0L1
         K5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784270726; x=1784875526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHqB+0XtN75taQRaVYwBwvw8FBQBWfUPu65PH2IoQnQ=;
        b=DFJxX/Ei6Rxf233S75PzFcGJs9Di7p+nUeGK3AQ8Hn1NdovYiCWURs1iz3k1HGtbcd
         QfYEHk+QUIe2OYqQK80YwpPkFaE4NP+ipvhfvmc4AQQtiqw4sSlCNAEWq/D80HjpiGxp
         ACTWNX8OlOmyFbNQ9JluOdO1X/52bIWC0rBVDl+slcjI8GIe2MwIYY1bnMzjOy6yA8Hb
         //PZReGlnH2McS8TiFKonSaMMMPAwhqsOIc0TeeBElvW4ko2A3W1a7/EuYuTT0lsMK2n
         D7mgFC/HewlwHxbSwfu/21x4BA47u411p3u1KdZtvrIZxXWu1OWcm3hypx6jxXnjzULa
         AJ8A==
X-Gm-Message-State: AOJu0YyB676e9YTPICque5lr6a4/SwTCtwevcEu7sFeDXer6ouADz1DX
	yooNSq6jklXdYFya1OsQIs/ROMTlR3EhyERM8zHOoiAi/nD9lWH/yCxj
X-Gm-Gg: AfdE7cms9XL1o/0dsxvYZbjmSHHp6ZHMDGfZHLAAJvgSiJQXgmAaptLjaZ3Q2XOw6AR
	kw3Jexv1aY4xqT0ob/Npmge09AOa4oowmtqBESi5+kkaYft+VwdJOaQMzAIfrmZ/nvEACSc8n2J
	13ofDrgxFkYtMeQbW6VakSuSxcz/aEnVwdOegNFLDdMze1vC6OE7YyKdPUkfwvJbRQWipgtKQ/u
	Gw69ieimP/pXv1YLj+o2Z0gXZbmmCoQo9pWBV08/2R2pupjjhwNeth8Cm+k5dcitIfhppSyZ8Gi
	NZ91eX4chvqIeMmYbqXK2/Ukgv95oXaiTPISyt7fbHWpeL6y0XJukFQfqk+7VmpCAwNv8/5S6B9
	DHj9zpvPiXE7XS5F7tHKdvRtyID/AMXC05h5u73DRLTRoUpKxu0gdhXfDWxXIXOMPJ0ym/EXe+1
	TPgW/E5UOMt6S3Lyv2TtVPDRg1jA==
X-Received: by 2002:a05:6a00:3c8a:b0:847:973b:3cf6 with SMTP id d2e1a72fcca58-84c290c3bd0mr1280242b3a.0.1784270725719;
        Thu, 16 Jul 2026 23:45:25 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.localdomain ([70.37.26.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8855fsm430531b3a.12.2026.07.16.23.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:45:25 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
Date: Fri, 17 Jul 2026 06:45:16 +0000
Subject: [PATCH net-next v2 1/3] net: nexthop: add NHA_FDB_PORT for fdb
 nexthops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-b4-vxlan-fdb-port-v2-1-f4862e8fe867@gmail.com>
References: <20260717-b4-vxlan-fdb-port-v2-0-f4862e8fe867@gmail.com>
In-Reply-To: <20260717-b4-vxlan-fdb-port-v2-0-f4862e8fe867@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jack Ma <jack4it@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784270724; l=4085;
 i=jack4it@gmail.com; s=20260712; h=from:subject:message-id;
 bh=sl8mscsoPTPSyi+19hbwFh+F3vzBp+hyHWcG3uotCtE=;
 b=sc8SDB/wC4m7QG+mGDlCeq1eYouPQl1BtyZZ/UqB+9s4ZrHKBorsmm5oDEUMw0T1p6lSkpH3D
 eUWbyx9x1DyBJmgDaQcB/LN2Atpwq6gNlkJxRET/2nHg4/c2VeCFdkB
X-Developer-Key: i=jack4it@gmail.com; a=ed25519;
 pk=x8xh2Md9yNDil0xBOA9WA/oqC3O4Eg4rdlIul4YUktU=

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

