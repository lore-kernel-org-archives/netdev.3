Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565879;
	b=zxfA6AnULWJ7hTIWTik6dKXXxUcc+bmS4EvIFuXv6wOsq+sGG31y8vzNEAFqB7hCetbF
	 dIb59Sb/hTi6S/j1iePFhiDmWCeuzn/dGgDk4X+5+ScG1ZmLcSIuOPl3w5xSQa3hJfluz
	 B5AhC/Fhymb0Nve18R9WNyYjESjCShQNZNKk/z5gn2uaTFsjCBCRvzWYda7IVzdPmGtgb
	 bFLEbSsH/VPEPpTuguBm7b5tcm0JKdDdnHcHuRrSbjcbBJRPU3aB2Z6CgTWYowGvAzNl1
	 rQOXAL1ifOp8Pbgjc8Y4k5lTgKPkmodlYdJ691umRwHspwZVlc4ZEWkyItUNx05Knag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e2nqfpyXfJR53yAw3YRwGK6gvdGsh0en4mbKV0oOf+o=;
	b=duIjMbpHKgyiz/cPGy7WMiavQHWPXFTTIRKYScVlPyLJqG4iD4l7IUkTskrwEUocqm0V
	 RlfvrwZ52xttXr6gcD5yP4fssljNgzxN3rUVJQ6cSMkCq0n58ZBZMQDG84Aoz8QMSiUZN
	 KyzpqZcvqsVm5bQdV0cPraUCxyHHAFBcmFeo9Ua5+jLJiTrsCKRTPz+9T0SLM4/Tg5scF
	 qBaxv+A/aCuhhVKCJj0xFGFDt3oIfvnRo444iwiTWLXFbf7/ZAwCYkSts9Y+ea+21rIPv
	 XpjCPuivdznrZvX5HSUFAxtXqAF+9yG2gmij1s1GYncjLzTOEGNMo6AXtcf8N3pqHgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V18Ap8EZ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5558606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5558606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V18Ap8EZ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35b2c599f43so830744eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792565878; x=1793170678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e2nqfpyXfJR53yAw3YRwGK6gvdGsh0en4mbKV0oOf+o=;
        b=V18Ap8EZvxLEHfDo9rRyXAXLgI/iH4CAqIguoR9KG2hQNicwlE4xG14qmtAIOOrJk1
         nhSmhm7VcmYVAXA8a330g8j6qsK3LIgKqkDd/dZ++6ag4s0hw9OKffWNGjz4D/S/ng1M
         pZ3GHFmyCeBQIJD0aJNFAjjRHc3yFljclDz5XfmXlNntj+Q/2LuhYZtvUds4PX6oBlMt
         OB8zlbU/bhjemznFVa6bT6zCkQTm2qvR6iM74efiMd/JGOqipHbA6UQRjjEOPE0APH3H
         LDtRsY1Ij8rLIeo1mDqsvSh48LyWi6VU372ar92W3xPh2+1IqgW8BT1drdSDAEKLrX58
         g6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565878; x=1793170678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2nqfpyXfJR53yAw3YRwGK6gvdGsh0en4mbKV0oOf+o=;
        b=gWab4/PvOzwq+UTaTo+81iLxizFY/ZBX8gLYi2jbzJUPm16CIggwkioTUZS1oumJLn
         Yf/5tSCcmo5iw8bg+nTAFvg9rHTTkYjBpRJeCJ8piloYioA/GlQRGIF8IhantzIFuIkW
         AWgigHT7sQ5CtYo6iiexUYjEBpLut+qJ9Nh2gw/EWCFfEQH9TGHmUzuuUmXcz9kbGZ4r
         Rd/GHVs8QAphs+y47jufCbJQtnN3CdgSYFfwbmlptfRiy1FcxUMRkqMjalbEXx5Kt40J
         ujgr+jdsHcki3Al481xewNJWS2YWxPYah4olybmANUtuRq0OH9aPcvWM6HxLQqf2IvK4
         oY8g==
X-Forwarded-Encrypted: i=1; AKwUvBw7IPhJdfylQuI5WnQ9usz2hes+JHE5/OgwFq5WIi3cILM8ZxWzizDUp9CU+NJr2AZR5oXiS58=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmQKpk7cD8yFaOsWpWufSnwg2M0ssyuJ3iUdHGxvjNvFBpeEhd
	6B0id+2Nu12VdnsLBq66DbuqfzRwtIcBJv1obLeiZFBRvfKjl8TYrDgK
X-Gm-Gg: AYBFou1LASLxQhYyeJIuLRFiQbcc28+FaEA7xmumq0+QSyDbUYJlTtp2A0Dghv+8Tph
	q90LE2PgCWPzeaEfw02YPgIf0mfV+rnWvecT/OjUiH/i1UxEQT+Hs46E1nktFY5piMtt6LFiUTI
	+Vsy98Wouk4yHL5qNNNMdWeNCVe/v2gNaCnyzuzmApreeQQWyDr8lVJoklGKqeZkh2a80kCDlRQ
	J6+97Su7kmrtAjCK+pCWilUbKCH3Ble1irEQ1TBeHP/u4NdacfZ0iwNpjIrxA2gHQYJ2qVpoWXP
	mL6BWqXPwA9PYC3gSLd1QsnnqDeCmMfjOzC8qfyR1hNrNRx5D4FBWlfK+cqrR1GT1wi86wBzBwe
	xmQdPAtLD4norlIFSh/NUn+x49bwg5fAgP+TMkh6M4sxGSWMpj61ADKbj7Bbcr5s7SS3ByrNJcf
	rMUYicyLr9PouiFEolAFeKlJzhBcWexQCmekPdkSjMz9heHSjbeIVcsBf1H3RXLoR9QUuzMPHVP
	b6qVhwbWAzqCNqFyHGSySzi+qCt37F4SArWDfODgHd3fvUV5m3YDuib3N/rwynKdoy1F+7C9R/z
	4x8GuFDWJHaLhf+jcjEFfarJwuU9l5skXi5BEZ00Vn75p4SsAMvPs+F3H2OT8YBtdiVNZR0SKoA
	ZBoxMveNDLmJ1oqBlIZ3b3wYV
X-Received: by 2002:a05:693c:60dc:b0:362:fa87:2aa6 with SMTP id 5a478bee46e88-367487699e9mr2317177eec.0.1792565877638;
        Tue, 20 Oct 2026 23:57:57 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411b4145sm5165118eec.15.2026.10.20.23.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:57:57 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net] gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group
Date: Wed, 21 Oct 2026 06:57:50 +0000
Message-Id: <20261021065750.2069795-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The gtp generic netlink family sends notifications on its "gtp"
multicast group when a PDP context is added or deleted, and for GTP-U
echo responses. They carry the same attributes as a GETPDP reply: the
MS and peer addresses, and the TEIDs, or the TID and the flow label.

GETPDP requires CAP_NET_ADMIN, but generic netlink lets any user join a
multicast group by default, so an unprivileged user in the network
namespace of the gtp device can read all of this.

Fix by marking the group with GENL_MCAST_CAP_NET_ADMIN, like the psample
"packets" group. Only users with CAP_NET_ADMIN in the user namespace
owning the network namespace can then join it.

Tested by joining the group as root, as root without CAP_NET_ADMIN, and
as an unprivileged user:

Before:
  root: joined
  root without CAP_NET_ADMIN: joined
  nobody: joined

After:
  root: joined
  root without CAP_NET_ADMIN: EPERM
  nobody: EPERM

Fixes: 50aba46c234e ("gtp: add notification mechanism")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 drivers/net/gtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 69fe5717846b..e5ff1621ed62 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -118,7 +118,8 @@ enum gtp_multicast_groups {
 };
 
 static const struct genl_multicast_group gtp_genl_mcgrps[] = {
-	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME },
+	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME,
+			     .flags = GENL_MCAST_CAP_NET_ADMIN, },
 };
 
 static void pdp_context_delete(struct pdp_ctx *pctx);
-- 
2.25.1

