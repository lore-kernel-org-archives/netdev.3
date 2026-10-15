Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715A175A85
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792106312; cv=none; b=tAGiIRh+mRLDRx4Q2wUZQC2I1Xqq02eOb2Pea5+LdY8x0WLT/SnbC85f91jTkmwIFB6pwuET1FjiGrVkRiOEL+hqyIj47O0YrDhBaBS8hGqDD0r2XkLYcMDwIpNAla8k8uMuIbnLvgz46VXuORfypOm50mzLo0/uH1KFNbjhmu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792106312; c=relaxed/simple;
	bh=jaIYdqzVuhTxtuYM0QVnLqomqTzWxcVIW3tpECilNlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G65NLlnkH9CCAXWqtSleJNGalzQ8Rbrc5gpUmVnvQrEelD6lenRCiYDCab0CktAP64L8GhDrs7u908S4VSMZwGkaP9UK/lg1PnoXb18QWaUhqoIYYMflxWv4ROoi1GZ113fjVmoy5RfBzRijccQIWhQ8nZeEznfkEhY82JKV3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=CB0vr0Ws; arc=none smtp.client-ip=74.125.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="CB0vr0Ws"
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35cd538de29so1153075eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792106309; x=1792711109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lskd2+aikpAUTY4xnAC2INKipXbwuFvd8XpYslDuZFM=;
        b=CB0vr0Wsj9oi0QtzmOxGbu0vf4cyZNV4Nj/6tqU0pUeXcQkSL7VBOJ4LfEfulYmLOk
         IZYdvqOj6WYAkFsW6FJkZHxm/ckJ6eBGOf0eS5fl9fYLbzsFGDoKU/1GBIEZ7dBQeWAQ
         SGGy2wilro5tiEvhtHfHSzsPQqJ+5JWuakEORdJo34j56xTCE9jNRDnQX58SWlJPNWWX
         wY+oRnP3IHzzS6pGzkpL6awLYj5EXUuh3TKXIXQdlQMkeLjYGcpnbJXn+rNyAJEw9o7J
         /NFg33DMGBvDK/ArF/2eTH/ngP+HGsnYaqp7mJzspRSs5BPXyfiu1XIw4KmIguJxkWuV
         OExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792106309; x=1792711109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lskd2+aikpAUTY4xnAC2INKipXbwuFvd8XpYslDuZFM=;
        b=WSP9/EurhzmMQp338j0540aAIMmEOZ66Orj6LBmgxwmjwEZzjWsojozpr+QZ88VVDV
         foaVwBYZan+4s6XXe6eFsfNgQ65lhkzu14JpDnmU7ytxIMzH8RIlMm1g03FNDpBhYS81
         SKqV0fUSKXzMACtW13RW1JGsqArBsh9KqRjOLf0YUuG/aIE7vI2xur3maWvE3S2/PLb3
         KKrNWejj8uKZEe8vZHEvPzldNKmqjcLhEJ/hueWfM0Yidod0ljC7UpLvGC3buDZeO+6l
         DeN9bR6KkB3hg//7wTS/YM9q0jyOihhTYVYWZ7sKUHO7NVqTUQj3bfVaJZ6sPTcO1h3S
         YZIQ==
X-Gm-Message-State: AFq9FYI7V2oyreRugE6t23o3nK4R/N45HA67SA6lADhVwZB6NPyJgQxy
	oEp2mhjMOewSfMH7ibE4qjvHpEShJLdj9HVZ9mw5ak5kgxtcRtSWdzdNraW8z6VtVj0zjhklSia
	+t6P6DBuV7HKGOB38BQ==
X-Gm-Gg: AYBFou2s4Iv1q9WEW/YsbKML3R9cl2XhZY0fIV6kG8E3nMsWKN8oYfhatyKXA1UysGR
	H6MoA1bjotqFJ9fYFygyP6FpWGOlP73sbhrAn6VoBhy40BuDPCpAsJv+UMEAWU4unz+2A2cvOKf
	M95k72uPZ/rrYDV+llwt9rosHLHLd/GnVUQnxRjprALm0JA18l+n0Imskz2VrXESlmZSaPz2WKY
	IaHt3q2DqJPaWpX8ZNWv02pF3gtIQdTYanE6H7vvPYajySEH/H5tyfhg/+Lc2EMYBbylT942HY8
	n1DNbNPt55A8lXoUGOqrTYJ8sEsRHZ1MPr6trfYjMJ0hZr9siVhiYQVaVEZKeGcsJuKcpVfYKk0
	dE2hMnYPPw0iMH3rqQH1dbIgoYGHgNVEhVsLfg5hUeMiWfPXwGJrrp95Uwha1oBCnRGqOsroqoN
	mc6qTC3ZyNDp+cqPplewfscdti92tK28y3mztR/nuJXaN5wf+dHa2yZtZ6Zmn1FDeiGRwj0J7y0
	A1IPH/BYe/bhKRuC1kGXQmC3SckqptYv0YhbHWR
X-Received: by 2002:a05:7022:170c:b0:16b:fa6d:b121 with SMTP id a92af1059eb24-16bfa7cf6c4mr22192842c88.0.1792106308749;
        Thu, 15 Oct 2026 16:18:28 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm642623c88.5.2026.10.15.16.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:18:27 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2] amt: make the per-tunnel group and source limits configurable
Date: Thu, 15 Oct 2026 23:18:24 +0000
Message-ID: <20261015231825.2852054-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A relay caps the state one gateway tunnel can hold at AMT_MAX_GROUP (32)
group records and AMT_MAX_SOURCE (128) source records, counted across
all of the tunnel's groups. Both are compile-time constants. An SSM
receiver uses a source record for every (S,G) it joins, so a gateway that
needs more than 32 groups or 128 channels through one tunnel has the
excess joins dropped, and the relay operator cannot raise either limit.

Add IFLA_AMT_MAX_GROUPS and IFLA_AMT_MAX_SOURCES, read when the link is
created, like IFLA_AMT_MAX_TUNNELS. Zero or an absent attribute keeps the
current defaults. Gateways drive these allocations, so the policy caps
them at 1024 groups and 4096 sources per tunnel, and strict_start_type
has it validate them, and any attribute added after them, strictly.
Report both limits in amt_fill_info().

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
v2:
- No code change. Rebased on net-next 518bf436318e.
- The amt_policy[] hunk now carries one line of context. In v1 that
  context included the IFLA_AMT_DISCOVERY_IP entry, which patch 3 of
  the pending net series [1] rewrites, so v1 did not apply to NIPA's
  combined net + net-next branch. This version applies to net-next
  with or without that series; with it, the result matches a 3-way
  merge of the two.
- v1: https://lore.kernel.org/netdev/20261014221334.2443184-1-omar@blockcast.net/

[1] https://lore.kernel.org/netdev/20261015220648.1545576-1-omar@blockcast.net/

Notes:
- At the policy ceilings, with 256 source buckets per group, one tunnel
  can hold up to 1024 * 4 KiB group records (176 bytes plus 2 KiB of
  buckets, a kmalloc-4k object) and 4096 * 192 bytes of source records,
  about 4.75 MiB. At the defaults it is about 152 KiB.
- The IPv6 outer transport series ("amt: add an IPv6 outer transport",
  posted 2026-10-09) also appends attributes after IFLA_AMT_MAX_TUNNELS
  and sets strict_start_type at its first one. Whichever is applied
  second will be renumbered after the other and drop its own
  strict_start_type line.
- Tested on net-next 518bf436318e, alone and with the net series [1]
  applied, in an x86_64 KVM guest with the iproute2 companion patch,
  which follows once this is applied. The defaults read back as 32 and
  128, 1024 and 4096 round-trip in text and JSON output, zero keeps the
  defaults, and 1025 or 4097 is rejected by the policy without creating
  a device. An 8-byte IFLA_AMT_MAX_GROUPS is rejected as an invalid
  attribute length, and the same request with 4 bytes creates the link.
  tools/testing/selftests/net/amt.sh passes 6/6. W=1 builds with IPV6=y
  and =n, sparse, and kernel-doc report nothing new.

 drivers/net/amt.c        | 15 +++++++++++++--
 include/net/amt.h        |  5 +++++
 include/uapi/linux/amt.h |  8 ++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 81d26ef82..30cff8de4 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3162,6 +3162,7 @@ static void amt_link_setup(struct net_device *dev)
 }
 
 static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
+	[IFLA_AMT_UNSPEC]	= { .strict_start_type = IFLA_AMT_MAX_GROUPS },
 	[IFLA_AMT_MODE]		= { .type = NLA_U32 },
 	[IFLA_AMT_RELAY_PORT]	= { .type = NLA_U16 },
 	[IFLA_AMT_GATEWAY_PORT]	= { .type = NLA_U16 },
@@ -3172,2 +3173,4 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
 	[IFLA_AMT_MAX_TUNNELS]	= { .type = NLA_U32 },
+	[IFLA_AMT_MAX_GROUPS]	= NLA_POLICY_MAX(NLA_U32, AMT_MAX_GROUP_LIMIT),
+	[IFLA_AMT_MAX_SOURCES]	= NLA_POLICY_MAX(NLA_U32, AMT_MAX_SOURCE_LIMIT),
 };
@@ -3235,8 +3238,10 @@ static int amt_newlink(struct net_device *dev,
 		amt->max_tunnels = AMT_MAX_TUNNELS;
 
 	spin_lock_init(&amt->lock);
-	amt->max_groups = AMT_MAX_GROUP;
-	amt->max_sources = AMT_MAX_SOURCE;
+	amt->max_groups = nla_get_u32_default(data[IFLA_AMT_MAX_GROUPS], 0) ?:
+			  AMT_MAX_GROUP;
+	amt->max_sources = nla_get_u32_default(data[IFLA_AMT_MAX_SOURCES], 0) ?:
+			   AMT_MAX_SOURCE;
 	amt->hash_buckets = AMT_HSIZE;
 	amt->nr_tunnels = 0;
 	get_random_bytes(&amt->hash_seed, sizeof(amt->hash_seed));
@@ -3352,6 +3357,8 @@ static size_t amt_get_size(const struct net_device *dev)
 	       nla_total_size(sizeof(__u16)) + /* IFLA_AMT_GATEWAY_PORT */
 	       nla_total_size(sizeof(__u32)) + /* IFLA_AMT_LINK */
 	       nla_total_size(sizeof(__u32)) + /* IFLA_MAX_TUNNELS */
+	       nla_total_size(sizeof(__u32)) + /* IFLA_AMT_MAX_GROUPS */
+	       nla_total_size(sizeof(__u32)) + /* IFLA_AMT_MAX_SOURCES */
 	       nla_total_size(sizeof(__be32)) + /* IFLA_AMT_DISCOVERY_IP */
 	       nla_total_size(sizeof(__be32)) + /* IFLA_AMT_REMOTE_IP */
 	       nla_total_size(sizeof(__be32)); /* IFLA_AMT_LOCAL_IP */
@@ -3382,6 +3389,10 @@ static int amt_fill_info(struct sk_buff *skb, const struct net_device *dev)
 			goto nla_put_failure;
 	if (nla_put_u32(skb, IFLA_AMT_MAX_TUNNELS, amt->max_tunnels))
 		goto nla_put_failure;
+	if (nla_put_u32(skb, IFLA_AMT_MAX_GROUPS, amt->max_groups))
+		goto nla_put_failure;
+	if (nla_put_u32(skb, IFLA_AMT_MAX_SOURCES, amt->max_sources))
+		goto nla_put_failure;
 
 	rcu_read_unlock();
 	return 0;
diff --git a/include/net/amt.h b/include/net/amt.h
index 2846dde0c..18379ff7a 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -372,6 +372,11 @@ struct amt_dev {
 #define AMT_GC_INTERVAL		(30 * 1000)
 #define AMT_MAX_GROUP		32
 #define AMT_MAX_SOURCE		128
+/* Upper bounds for IFLA_AMT_MAX_GROUPS and IFLA_AMT_MAX_SOURCES. Gateways
+ * drive these allocations, so keep one tunnel's worst case to a few MiB.
+ */
+#define AMT_MAX_GROUP_LIMIT	1024
+#define AMT_MAX_SOURCE_LIMIT	4096
 #define AMT_HSIZE_SHIFT		8
 #define AMT_HSIZE		(1 << AMT_HSIZE_SHIFT)
 
diff --git a/include/uapi/linux/amt.h b/include/uapi/linux/amt.h
index 2dccff417..a106d7a07 100644
--- a/include/uapi/linux/amt.h
+++ b/include/uapi/linux/amt.h
@@ -54,6 +54,14 @@ enum {
 	IFLA_AMT_DISCOVERY_IP,
 	/* This attribute specify number of maximum tunnel. */
 	IFLA_AMT_MAX_TUNNELS,
+	/* Maximum number of group records one tunnel may hold.
+	 * Zero or absent means the default of 32.
+	 */
+	IFLA_AMT_MAX_GROUPS,
+	/* Maximum number of source records one tunnel may hold, counted
+	 * across all of its groups. Zero or absent means the default of 128.
+	 */
+	IFLA_AMT_MAX_SOURCES,
 	__IFLA_AMT_MAX,
 };
 
-- 
2.43.0

