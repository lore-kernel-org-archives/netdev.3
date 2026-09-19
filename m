Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E337CD20
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853343; cv=none; b=Scpi4xMN0ZbNfFdf0VTV0g7LQA57vNQc259pNLi+XXIuD83/dkmhCC0AJIc+YalnVe+qD/BqLcobhZ26illkTILsrVn87XdEnIIstk8t4P7S7cSdM50qHbY2Dszt91z/Q+3RiAhVM0l6D93VwhNf+qNySrxhxdktiu/uQzJidfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853343; c=relaxed/simple;
	bh=KcQIxrjjYKOPt7VPc3GR8Ypvb9JGlM8cc1l2/4kyu9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSCJh+mCOvLEo7rGJ2UbN+Hu1JqL6QMk0jJqwtpOoj1sVmt2SzHD+s7O7yTlrOSDlCGvOccMsj6weOui+826ikJjZBhbmjbPu5VdG/cRri8hZjLjupDeMeAIGEYdFlTGK29oONZ1NtKl7rqfqgwIZ8Y+NrVv70USQAnJPmakdgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZaOoANm; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZaOoANm"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso1440927a91.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853338; x=1790458138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yGJIKW1WUZIXfYGv7StzLwvHtFQ/N+sc5vtFtFfdCwo=;
        b=eZaOoANmYxN02/Ll3CCd7mzVhr9nww8WmS0ZZ75M1wzB1ltuDQa1AFBFAmo5J6RQET
         w1EATVXGQ2ny0UWhc7BGp4WEvzWRdIDgtRF4jBjkN2+BVtyg7GF6jUESvHVq7zC/uraa
         hlMYtNFQUrFV8WFiaen0CHuFzDW5nVDmyiZ2c3QIpcazPJqKB+Squ+uCG+hJzP6DCtrB
         8AaJFOqM6CaXhUunTA4FL/pSfpITuGja+lB84TVAPDv+q97/Axlu89H9VGLzpLOQxRvk
         69GZ4H6mRCPZCuyTLiCbS96C/hZlpYMVwrzOk4kAMpFJ+oQtQW3oq/L9C+Q+WG2ag+L3
         u2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853338; x=1790458138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yGJIKW1WUZIXfYGv7StzLwvHtFQ/N+sc5vtFtFfdCwo=;
        b=fhThOxjqyQQr0I3Rp3iVdLSsx6zJZcdyd9VLBGxpdzz94Zevs9XrP+4sPqzsIhJGmh
         W9rYXUqfyuSp6tQbyDP2SFXJe2NzrqtAoKpCgkggO2feUARLn+9od2h+FFxiJpUdrTza
         JjdYpvhuLuEIgmvk61Dag//k7i3kYinp2QP2FCNVjtlJYev9uOe5I2YGc/SoLErDOQ3T
         l1Yy8xPgWi2reLUVqCk43P11nUolqKC3VIO8nAEGniG8X5quYjCpik3sMZxxGt2kZWto
         7ypwb2jpKnbz3kS3ZmwleOmxnT1b174Jkth4/EtpHergm4/I36/ZCBQ0nbpJeNy4Fmrj
         BZQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyQz4WrFYOINQf20yrqZr3XapLQ+EuUTJg1odEXVVTCmSPOb0fSGunK4gS2mMtVxiK5YQhllM=@vger.kernel.org
X-Gm-Message-State: AFuF++m6JjuhPaFYQGiTkdTkQHsTVWiEOEXz4ZF0jGhu39iDi0rnXznZ
	ozi2qT2T5O4S5pjNLfyMdQpoEy5cK/cEeLWk8Zoxps7HsDm5DH07ZOqX
X-Gm-Gg: AYBFou1oW6Ukk7fPJ8Sc8Qqg7YyqfLe8l8BRo5JmtHtPTxwtcziHkBje1nPKMKLmd8W
	fGemdl0zd+CV8rl4lKasW5kUttJHQmlLk68UbxJprCxEGUEKc8asB0hCO/7/PbOKsTh2IjOzVbF
	TzdFv16B8qLZyKGXsfp7uZTVs5OD+cNUhXrCWSZdMdErcGgGtwoj6o+mWnUhb751tTonAaEBo6K
	rCUPs1AndHAp0SBAVUWS0wFyeKLu1fz/vZWEiLCGs5qNlPPcj6mKUmwQzI68nnGS2FNW9YXUz4T
	6imn2Uft9LljSltWswcaxVyYSu3k8b4ayiC7/T0VmxCoQDQ5uBkbWqGPbqB3gTATTUurwUQaKP4
	1NHNmj8LlOsFWFjPsQmg0rlcjzWReGLYzmDjah0nSjJgMBtGlt6INijPSJk6r1mUrne1K5nJG/C
	WJYu7R5d2/PCFj9xObCKukROx6o1sqX1DJt6NUJWyMeQX5ZZwUUPoypzkZRK1a1TT1wAYnHH1Yv
	nY+jGQYUq0ecnYvVZMuv6bAjfqz2EsP5L+IL0bYQ1FRKt7Wg0/tz/Yl4ufl1kzZ6l8+yMfXtijn
	g9+JX8vEpg==
X-Received: by 2002:a17:90b:56c5:b0:39d:f247:bab with SMTP id 98e67ed59e1d1-39e54b66f85mr12104378a91.6.1789853337992;
        Sat, 19 Sep 2026 14:28:57 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6caefa5esm6021149a91.12.2026.09.19.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:28:57 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jmaloy@redhat.com,
	tung.quang.nguyen@est.tech,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tipc: fix TLV out-of-bounds read in tipc_nl_compat_net_set() and depth mask
Date: Sat, 19 Sep 2026 21:28:57 +0000
Message-ID: <20260919212857.3241483-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two validation flaws in `net/tipc/netlink_compat.c`:

1. `tipc_nl_compat_net_set()` (`TIPC_CMD_SET_NETID` /
   `TIPC_CMD_SET_NODE_ADDR`) unconditionally dereferences `*(__be32
   *)TLV_DATA(msg->req)` without verifying that
   `TLV_GET_DATA_LEN(msg->req) >= sizeof(__be32)` (4 bytes), reading 4
   bytes past the end of a 0-byte TLV payload (`tlv_len == 4`).
2. In `tipc_nl_compat_name_table_dump_header()` and
   `tipc_nl_compat_name_table_dump()`, `ntq->depth` can contain the high
   flag bit `TIPC_NTQ_ALLTYPES` (`0x80000000`).
   `tipc_nl_compat_name_table_dump_header()` compares `depth > 4`
   without masking off `TIPC_NTQ_ALLTYPES` first (always clamping
   `depth` to 4 whenever `TIPC_NTQ_ALLTYPES` is set, even if the low
   depth bits are `1`), and `tipc_nl_compat_name_table_dump()` checks
   `depth > 1` and `depth > 2` with `TIPC_NTQ_ALLTYPES` still set in
   `depth`. Mask off `TIPC_NTQ_ALLTYPES` after testing it.

Fixes: d7cc75d3cb6b ("tipc: convert legacy nl node addr set to nl compat")
Fixes: 44a8ae94fd55 ("tipc: convert legacy nl name table dump to nl compat")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/tipc/netlink_compat.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index d9a4f94ea2d4..9b2d93704e23 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -881,7 +881,7 @@ static int tipc_nl_compat_name_table_dump_header(struct tipc_nl_compat_msg *msg)
 	if (TLV_GET_DATA_LEN(msg->req) < (int)sizeof(struct tipc_name_table_query))
 		return -EINVAL;
 
-	depth = ntohl(ntq->depth);
+	depth = ntohl(ntq->depth) & ~TIPC_NTQ_ALLTYPES;
 
 	if (depth > 4)
 		depth = 4;
@@ -932,6 +932,7 @@ static int tipc_nl_compat_name_table_dump(struct tipc_nl_compat_msg *msg,
 	if (!(depth & TIPC_NTQ_ALLTYPES) &&
 	    (type != nla_get_u32(publ[TIPC_NLA_PUBL_TYPE])))
 		return 0;
+	depth &= ~TIPC_NTQ_ALLTYPES;
 	if (lowbound && (lowbound > nla_get_u32(publ[TIPC_NLA_PUBL_UPPER])))
 		return 0;
 	if (upbound && (upbound < nla_get_u32(publ[TIPC_NLA_PUBL_LOWER])))
@@ -1139,6 +1140,9 @@ static int tipc_nl_compat_net_set(struct tipc_nl_compat_cmd_doit *cmd,
 	u32 val;
 	struct nlattr *net;
 
+	if (TLV_GET_DATA_LEN(msg->req) < (int)sizeof(__be32))
+		return -EINVAL;
+
 	val = ntohl(*(__be32 *)TLV_DATA(msg->req));
 
 	net = nla_nest_start_noflag(skb, TIPC_NLA_NET);
-- 
2.55.0.1082.g2b9226bbc0-goog

