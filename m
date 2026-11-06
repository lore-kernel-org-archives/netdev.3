Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947329;
	b=Cmz2L+UriXqdw5K4hiXgAF3pwcna0O9O3WjDKueFY75Lh5/BgwF9qtwq5rrZ9LBtD1Tj
	 OO7/BrnMsYl3BtoSmOaWyCyZWk9qECS4H3uuCdhaP0gVHrDBsB2AiXMyO2hZk87GwEhVd
	 Y81UjxFqXmW2N4++74SeCMZNgw/yrpl2kU4GG2L03IfZa2Ber5B1E8daMp/xFayRstmmN
	 Ld5qXSTP8CkF6MA4fcVP0BDi8UC1hX9cDFFcsQmyI2XreHqb9AsR/wkaSg+HzOfpsM2Eg
	 rIpqErnaJn4U6iRrUL3lAYNPpiGbUlXb0jrPNtpCw7gw1eVMAZ2HEomYGcpI8i0TScQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947329;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=KL5V+v3cUK42avBygg/NokDd0cEzHSdupAtDovHJxz0=;
	b=h3OvxF4zrjAUmUUQVwXNSZcm0ZdbpvVob0JXcWT24FXbO/91Lj6h3FZDm4Y9IZ8Ij9+U
	 VDX76/gy454ff/u2+jXx0N+crcmAsszdL+md/v4JZk1mo9OS1zWS5oEbCX5CmE4Wf8AYI
	 CUeUr/Q5tMdHkoijMF8yFrNFMWCZpPERv4J9/64CW0fBTfmqOUHszQSponybdYnZqUKpu
	 Xmd39lTRg3HgAkVclU0vDQDfHCOJwhXzvww62nWsKt8ZMJuadSphxZRU3HPmIk/Jyn14I
	 ukDdvib8cIg3Fbq7Tv5qoykOVDX92vnw+yoEr3slwoPJWuVun8u8d7FTvMESrYvWaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=fGhQ7jXb;
	arc=none smtp.remote-ip=220.197.31.8
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03640606A335;
	Fri,  6 Nov 2026 06:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03640606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=fGhQ7jXb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KL
	5V+v3cUK42avBygg/NokDd0cEzHSdupAtDovHJxz0=; b=fGhQ7jXbQHVw0UGkPC
	ssOlfF5LBueH95TOQYsjOaGHMMpbXCISFsP/+Z7tqQCM0fgbDDDo8ZpQOhnC8reB
	w/LlG8i5BSQAXfGBUQk0nDJGO/5BJWBoGsbEyOVk539RR2Vjy2g5c/9srhtCG2XY
	TCWIGy+qmQE2+mYYgUPSnrnsw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnR+uMdu1qZ7kzCw--.3170S3;
	Fri, 06 Nov 2026 14:41:19 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net-next 1/3] net/sched: act_gact: size TCA_GACT_PROB unconditionally
Date: Fri,  6 Nov 2026 14:41:12 +0800
Message-Id: <20261106064114.3592670-2-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261106064114.3592670-1-xiaolinkui@126.com>
References: <20261106064114.3592670-1-xiaolinkui@126.com>
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
X-CM-TRANSID:_____wDnR+uMdu1qZ7kzCw--.3170S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWkZFWfGrWDWFWrXrWUJwb_yoW5tFWkpF
	Z8WayDCr1ktry7Xw48uw4xZa4S93s5CF4UWryakw1Fkr4kWwnxtFyrK3y3Cry7Grs3G3s5
	Zr1qqr17GF9ruaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9AwsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqA-WrWrtdo924QAA31

From: Linkui Xiao <xiaolinkui@kylinos.cn>

tcf_gact_get_fill_size() reads tcfg_ptype with neither tcfg_lock nor
READ_ONCE(), and budgets TCA_GACT_PROB only when that read happens to be
non-zero.  Both halves are wrong.

The bare read is a data race.  tcf_gact_init() writes tcfg_ptype under
spin_lock_bh(&gact->tcf_lock) when an action is replaced,
tcf_gact_dump() re-reads it under the same lock, and tcf_gact_act()
reads it with READ_ONCE().  get_fill_size() is the only accessor of the
field with neither.  act_bpf hit the same problem and solved it by
taking tcf_lock in tcf_bpf_get_fill_size(), with a comment explaining
why.

The conditional budget breaks the rule that commit 4ba61bfd4998
("net/sched: add get_fill_size() to the five actions that lack one")
spells out: "Size every optional attribute
unconditionally: reading the current flags to size it conditionally
would race a concurrent replace, which can flip the attributes between
sizing and dumping."  A replace that turns tcfg_ptype from zero into
non-zero between the two calls leaves tcf_gact_dump() writing a
TCA_GACT_PROB attribute -- nla_total_size(sizeof(struct tc_gact_p)) ==
12 bytes -- that was never budgeted.

Size TCA_GACT_PROB unconditionally.  The budget becomes an upper bound
again and the bare read goes away, so unlike act_bpf this needs no lock.

Nothing overflows today, so this is locking hygiene plus conformance to
the rule above rather than a live bug.  All four consumers of the value
-- tcf_get_notify(), tcf_del_notify_msg(), tcf_add_notify_msg() and
tcf_reoffload_del_notify_msg() -- allocate at least
max(attr_size, NLMSG_GOODSIZE), and the delete and add paths add
tcf_action_warn_attr_size(extack) on top.  NLMSG_GOODSIZE is
SKB_WITH_OVERHEAD(PAGE_SIZE), so a batch has to carry enough actions for
attr_size to grow past roughly 3.7 KiB before a 12-byte shortfall
matters -- which is the failure mode that commit 8e2efb3f45a5
("net/sched: add get_fill_size callbacks for actions missing them")
fixed for other actions.  A replace cannot interleave between sizing and
dumping either: RTM_NEWACTION, RTM_DELACTION and RTM_GETACTION all take
rtnl, and the classifier path, which can run without rtnl, computes
attr_size in tcf_exts_validate_ex() and discards it.

Tested by building with CONFIG_GACT_PROB=y so that the code being
changed is actually compiled; net/sched builds with W=1 and no new
warnings.  Patch 3 adds TDC cases for the gact dump and get paths.

Fixes: 9c5c9c573700 ("net sched actions: implement get_fill_size routine in act_gact")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/sched/act_gact.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 565860cccba6..ec9a65dfc442 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -233,9 +233,10 @@ static size_t tcf_gact_get_fill_size(const struct tc_action *act)
 	size_t sz = nla_total_size(sizeof(struct tc_gact)); /* TCA_GACT_PARMS */
 
 #ifdef CONFIG_GACT_PROB
-	if (to_gact(act)->tcfg_ptype)
-		/* TCA_GACT_PROB */
-		sz += nla_total_size(sizeof(struct tc_gact_p));
+	/* tcfg_ptype may be set by a concurrent replace after this budget has
+	 * been computed, so account for TCA_GACT_PROB unconditionally.
+	 */
+	sz += nla_total_size(sizeof(struct tc_gact_p));
 #endif
 
 	return sz;
-- 
2.25.1

