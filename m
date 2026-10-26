Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005652;
	b=F3ipsMW0u4IGF/J+n8xiD0Rv+z3zl7sucr07eMoZ3RORekmN16EroTkg5+cJ92szrjcn
	 gwWx/7xa/adHBomh4KWotUgOCI1MwTLHdbgWMV4O1/60FJcHS9K8TCwIMEAbFDITfYj1X
	 u09ssA6nrvd8NP1TOJaxcGHw16FL42ORajOBrX1pSQLzIf08xsXZfUlWme4K+uhiEuLR4
	 tHAQNTWYJoQJDujqY9pjevBdkeTL7HNvwAGY/7DLkUiPpvKBL5IEW9DSzwK4DBvImPqC3
	 0wqtaB9AGl69IgJF71/L7iVsAieXgALD89KVYJNtOnSHaFHbw9s98EOyzYaczTOSbtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005652;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qeZo3aTQyFqqm5M8QqVIXOla+jk6l2IoqS0l3bNa1Gg=;
	b=vvgCBL59NnfNY8ZcPZlBLZC6kLe4JN7B0l1vxuRlpEikOl9KwTmN9rh/XobVUoi4OQz6
	 uQ3ZpIjxsKHJ6VhgBiPZJKuslXTCXM3Dj6F2lT/05mNK/qpjAKnoMtzyDUW8sGu5+MoCs
	 yH2oDXHfUlHZs1vjlA4YGSnR7v7ngUy+zjTazRWZhw46aM7Al87ltH5ZYajXQhpPjc4PG
	 N+uf68hnZpiLaoclrFCupGhXw2mJN6Yue6AqvuluhT5QK99S3bICEavgDW9PUCWv8bRaU
	 ihaFBkanDWprfWvvayD50tkBygAzpBP4KQw4GOezxaRuoVLI/FMcB3Qga2nkmJw6v0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=bzD0zoL0;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784D606A31A;
	Mon, 26 Oct 2026 09:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E784D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=bzD0zoL0
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793005640; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qeZo3aTQyFqqm5M8QqVIXOla+jk6l2IoqS0l3bNa1Gg=;
	b=bzD0zoL05ln47H/nSWnrYzzkhqTgRk0RPEscXsYRbN413C0sVJihe/e/bm9ZwRZg3TdkdSGDHaJhr9ut7VDuDQUfjz1ibMFD/vBHrxLDP+R/oAedD2b3e/9pIyG6hT+a4m3pMvfTdutzBnRwDkbgKipdK8Td83vi/CPBISvqiDA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0638272|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0207607-0.0361182-0.943121;FP=12593454570873118666|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jpnE.N7_1793005637;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jpnE.N7_1793005637 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 17:07:19 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	eyal.birger@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com
Subject: [PATCH] net: sched: em_ipt: validate hook value from netlink
Date: Mon, 26 Oct 2026 17:07:17 +0800
Message-ID: <20261026090717.41597-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

em_ipt_change() accepts the user-provided TCA_EM_IPT_HOOK value
without validating its range.

The value is later used in check_match() as "1 << im->hook".  A hook
value of 32 or greater causes undefined behavior and may undermine the
xt match hook-mask validation.  The value is also passed to
nf_hook_state_init() as a hook index.

Reject hook values outside the supported IPv4/IPv6 Netfilter hook
range after checking the required attributes, before loading the xt
match or allocating the match state.

Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 net/sched/em_ipt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_ipt.c b/net/sched/em_ipt.c
index 3650117da..e4a8c1f0a 100644
--- a/net/sched/em_ipt.c
+++ b/net/sched/em_ipt.c
@@ -142,6 +142,9 @@ static int em_ipt_change(struct net *net, void *data, int data_len,
 	    !tb[TCA_EM_IPT_MATCH_DATA] || !tb[TCA_EM_IPT_NFPROTO])
 		return -EINVAL;
 
+	if (nla_get_u32(tb[TCA_EM_IPT_HOOK]) >= NF_INET_NUMHOOKS)
+		return -EINVAL;
+
 	nfproto = nla_get_u8(tb[TCA_EM_IPT_NFPROTO]);
 	switch (nfproto) {
 	case NFPROTO_IPV4:
-- 
2.50.1
