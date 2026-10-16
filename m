Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B1380FD8
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162902; cv=none; b=tV5iZQ1iRuSIDIY3ebEpuR8ThvwJnRKMwE5OD15ZVEdX6eQTEn3wMRPskzMdO40CF6w1F4nCQdPnHpRXmzPEojajDiL+tpldnTLuMSrqulNnrTPripajMLWpj7fULnm4CMW5qSvIB7huvEcruCg/B2B1S7xjflQv0Rax0z+/n04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162902; c=relaxed/simple;
	bh=pvohegabuBj5eTTWNotWQSLtJioMovHzOJdZ5mt1v1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEyOU+SOIApgBSLJTDvrfPt9TNBeHvr5DUb4BQvqv/Z1AwxpFoqFeX0ciHzwwQGy7N1lFjtf/mc/in3LOyiruWreW4fn6SnEo8SJn+gm9Ch9xtO3XEU8nDjMkzX+ve/q/7cYxyg+A8MWpv6drpgoGJX4wV2T6kyXeVp1J+iSdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=oWLvZSQ+; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="oWLvZSQ+"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-451a49abd8aso70339fac.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792162900; x=1792767700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bPFpShE31DFsBY6WFUeD5aKN1mR/pM7EoNnfe4+19WQ=;
        b=oWLvZSQ+/5I2to3rHmVueiSK8mcMnfnUL9fw8d9Wrfa3c5ZktAMbDRFCb2NcEd4Qcn
         yCiOL9Mnt+hb7pwzIhbb33r1Hiy9tKBJGdSZW6WhCQO7H+kOnQQi3eSWcjN7qssp8Dzc
         cdPUYoX7Ws5JlR+fxvD/mkH8dGi5D61lVtgWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162900; x=1792767700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bPFpShE31DFsBY6WFUeD5aKN1mR/pM7EoNnfe4+19WQ=;
        b=JTF4RnjewsW76jwkIm29wh2BihMhkWcnKmYMid8AKZ+3UTl/m+H3aTw7t9C3KPWSy+
         Dj7pO0BT7lmvSECRshfQSg9Y1JGALAXzYq0LyznI1ZftVrHBecSYlCNFPsZhLUCiQGoW
         iQszdo+BFZLX/Fi8pn40bJa0zAtGuUlOdPdb8mNh7CtYMsdtjYHz09LFNElyJJTOY8Cm
         hWAGmW0/0WJ/rQaOpTu+n7E71mUza04MJcTxqhwHGTfCLyenLqyKe9EdqbM+yWyml3hq
         PwTFUMJxIzYWDZplDTG6eZrBNR1ylxdNDd1oRD+W4J6gmOLAYE3Glmn9gXbXGuF/gX+e
         e3Jw==
X-Forwarded-Encrypted: i=1; AKwUvBwFIDwQqDwitDrqnAlUpF9mF9RykcjXEcSxgWcIyQEiWprAGz2/MyOiqq+qIE7i3Eq7uYqka7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2KFYQq4MWGhVrmXxca4VIpZHvzX/ma2Wv90z097xD+3zdP7R6
	2Po9wKACx8PUDTOVtcOCn72w6y8r839jqxAQyTY8096Kzn1BGDr0gNnvMarC9CEQyw==
X-Gm-Gg: AYBFou1slWfzdwMTs92V32WbDx94PVwDxhy428f/p+FL5FoTaNZQ12YKVi1g1bBvGHz
	UJ8fp9xxMA0TPU1VyLMKMNLoL3YVLcTsYHCAehgrp8hIEVqb23Jqa723310/sOInOK6jWUmaEEA
	jTdfa3mR6CfvLeR9NOKOM96xn5l04MR21EJDGVmLnTYVBsr1dvO8EFxtEyVyPzLbHKOBH9EPAkh
	TX/DjIrpY6AG1CUsmoOVfFkvEfncaoRcZjLH/Vh7wyRJ6ybv+eL4dXhg2yMQT9V0q1YslUnkPm2
	8h431uKuX0bshwxCjCknywiIzWHHeP1epzCswQSamr/W0d8VvvxF7fMY1X9lDgMrQmaKiRoaRLp
	mDJdkYFX+CZ8O1XGeWg+54EL+k8v/KGLM0X83hbjAPJf/gFeG0cAFOUwopUdQiPI9+sCLWPsbCR
	sF+V/JAUsEAV31M7nTNRDVXx6vnG0Wl4AFvQKMRNrqlTdD3wdz9Q81KC4ejJbM3nHgVy7oTvn23
	uRj
X-Received: by 2002:a05:6870:241b:b0:491:520f:e6d0 with SMTP id 586e51a60fabf-4a7575c5a5fmr207409fac.4.1792162899300;
        Fri, 16 Oct 2026 08:01:39 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b5b4291sm1746650fac.5.2026.10.16.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:01:38 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next] net/sched: em_text: pad the text pattern in the ematch dump
Date: Fri, 16 Oct 2026 12:01:28 -0300
Message-ID: <QDISC-7SHE.v1.r0.20261016101330-1@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to commit 9c572a83037a ("net/sched: fix potential
stack infoleak in em_text_dump()"), which zero-initialised the dump-side
struct.  Sashiko separately pointed at the unaligned pattern tail on the
same dump path.

em_text_dump() appends the text pattern with nla_append(), which is a bare
skb_put_data() and does not pad the attribute to a 4-byte boundary.  When
pattern_len is not a multiple of four the skb tail is left unaligned.

tcf_em_tree_dump() records the raw span as the ematch entry's nla_len and
then writes the next ematch's nlattr header at that unaligned tail.
Userspace walks the list with RTA_NEXT()/NLA_NEXT(), which rounds each
attribute length up to four bytes, so it looks for the next entry at an
aligned offset the kernel did not write.  The ematch list is therefore
misparsed as soon as a text ematch has a pattern length that is not a
multiple of four.

Append the pattern with nla_put_nohdr(), which reserves NLA_ALIGN(attrlen)
bytes and zero-fills the padding, so the following ematch stays aligned.
The emitted ematch entry then carries the padding in its nla_len, which is
what NLA_NEXT() already assumes.  em_text_change() only checks that len
covers the struct and the pattern, so a dump replayed as a request is still
accepted.  This also removes the last variable-length nla_append() caller
(sch_gred's is a fixed-size, already aligned struct).

Conditions to recreate the bug:
- CAP_NET_ADMIN on the target netns (namespace-local via unshare -Urn is
  enough)
- add a basic filter with two text ematches whose pattern_len is not a
  multiple of 4 (e.g. 1 and 2), then dump it with RTM_GETTFILTER
- the first ematch entry comes back with an unaligned nla_len and the next
  entry's nlattr header is written at that raw offset, while RTA_NEXT()
  reads an aligned offset three bytes later

Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260918133953.12494-1-bernard.ladenthin%40gmail.com
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/em_text.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 4132f8c3c5fc..fbf78d61f109 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -125,8 +125,8 @@ static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
 
 	if (nla_put_nohdr(skb, sizeof(conf), &conf) < 0)
 		goto nla_put_failure;
-	if (nla_append(skb, conf.pattern_len,
-		       textsearch_get_pattern(tm->config)) < 0)
+	if (nla_put_nohdr(skb, conf.pattern_len,
+			  textsearch_get_pattern(tm->config)) < 0)
 		goto nla_put_failure;
 	return 0;
 
-- 
2.43.0

