Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3338A73C
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445815; cv=none; b=XTpi/2sd3EMR8WMZpYQHe/UWax7H0TDDv+FXzMCPoHU/BN3HT7GdTTuY4cJWuWO+ALkRsVSdPgU/ryAxfyx30Jkdfm6s9QRgy1IL+UbUTlyEAV3CUSuHny36Q4pvzawgXUS1T2Rbry0iVTQV2Ph/pSUOdHLWztDmMoROP6zgZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445815; c=relaxed/simple;
	bh=72dIvc55DqXnfyia3hT+4yO21jn/lFVEvUSrpZ7OGns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=O+FHLq1Dhl/NQLRSlkUmAtr6nVaO9bL4pIvY/BTRMkI6IhvR6Fyxi3BrqRro6Xdxa5P3btbmuZU1rRDgcCU+M4MB9ihS8mJzS84F5ZPkpC02UqocUHq0w3x2sl0UqwAJIAf6o/KKY8VkFobDc3VCStIh/mCWj/4aOh2GZuup6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gabCnxjM; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gabCnxjM"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5f63c54eso39708885a.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790445813; x=1791050613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QzHU1omESwbRBxMBALJrtdPIobNR8TVwk+skZRB/P5g=;
        b=gabCnxjMEkMIJ6SVzUHXSLUoHdcAOYnr6zdqF85sLWJhWngmLn6IcTzNZkF2pdSUV+
         fEWoJje8OhJML1IBUwtE3cJQPjD3TsNhO+EBZ+NWyXK9KgBXAGpDmbj7BZW1EWrTg0k6
         k/OdjT76KqA2JW4+FX3PvtKBpBamc/lgw8flc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790445813; x=1791050613;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QzHU1omESwbRBxMBALJrtdPIobNR8TVwk+skZRB/P5g=;
        b=AT7y3POmWkRhhRZWk52+jpgI2d62+HMgRfcpQFBdNXnprT01fJxJGLXEZk3ovog3n8
         UaU6EX2f2yCWklYJAgCOb+fYHV1NKfDlKK/xuMQfP1oG+k7HL+9RbWUrR05Ld74oSbjP
         aaNZ7k7pAyS0+3PqXGADZQqn++31FpOE91I3Fp+2lw37YSVybQ2S2FWVY6MriGFlKZGz
         iJ8zaILv93mIDuBsIVaZkGRNBamAbqXcG6pgeNa8KphuRz9Q3yW2JdYNcVek/StkO9Ew
         6m90UVSz15pze1T2LZWJJhN/pdXVj7r9Emp3pawG8GZ2k6C7HWUSycilglz5zAWfibyn
         RLyQ==
X-Gm-Message-State: AFuF++mPkJFYMsqX+6c4RtVUR6GC4yt8/ukNtkte9ADs0BkkM0BXvoTf
	zA+942yFey6G0Zw9xo0PDxhaWUm2Lwvm8QAKmgKQwecYh85mVjpqKziAYcHSMdPt5hAkzXH6GAE
	IV60kwA==
X-Gm-Gg: AYBFou2Ou4u2txK0M5CjI8Rdb9yuuKHQ5n3ZAnWRj0Dl87AdBqIKbp5Ievn89EJrq2y
	d7Sv/R93Pz56GPmOvkYyuShdmk83HZlJ432fPvKqNQKgl4C7xf0qxBwI1R9U85fk6NTM6lHznaU
	eIaxWb3qSMyBzFy/oGOVU1RQ4EQ3zlRD0EWRXAd/NfG2pFt0S8SuIrFD58ZUah5FrXLmbSyqn9s
	btJJFu+tassZ7fegqTX+xVePiOkSVp4US3TgyC0Tgdzl27F+Bu/o+SOesgN7zJuRwTr1+ka9yM4
	J43JNlJIFvyKxXvlE6APKW3V7vJDFOHM8DwU2qjEJ+nQ5P4KlEV1j3g/i90W7unF+B8TC4zEpk4
	fRd9yuFhbti7POq/pZjdV8laL68zl6tCmA/Qvm/PhPfVB03zYfbtaa4oib/u5NM2PxmqMouGD9a
	bSONIRKKyQRYzjN65lwBhG/75dAQDOthmgkKGe3SLIhm6fuVlvJo96LOjigppXVBwQUZc3u8Bew
	JQYnwKN7AHQOdCFdcjpkM+JtGzI2etwExBjpY+gpvuO294TIGwizV8Ew50Bnb1wA7mFbXsc
X-Received: by 2002:a05:620a:1b99:b0:93a:3d71:c9ec with SMTP id af79cd13be357-93c43b7ee3dmr1086963285a.7.1790445812618;
        Sat, 26 Sep 2026 11:03:32 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4499c06csm459288885a.46.2026.09.26.11.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:03:32 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	hybris@mojatatu.ai,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 1/2] net/sched: fq_codel: match the no-drop threshold to the packet size
Date: Sat, 26 Sep 2026 14:03:27 -0400
Message-Id: <QDISC-34MS.v1.20260925165535@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit d9ebd8f9aa8b ("net/sched: fq_codel: clamp default quantum and mtu")
clamped both q->quantum and q->cparams.mtu to [256, FQ_CODEL_QUANTUM_MAX].
The two fields mean different things: quantum is a DRR credit that wants
the 256 floor, but cparams.mtu is the CoDel no-drop threshold
(codel_impl.h "*backlog <= params->mtu"). On a link whose maximum
transmitted packet size is below 256, the floor extends CoDel's
minimum-backlog exemption beyond one packet and delays drop or mark
eligibility by several small packets.

Split the clamp. quantum keeps [256, FQ_CODEL_QUANTUM_MAX]; cparams.mtu
tracks psched_mtu() (the device MTU plus its hard-header length) with
only the upper bound that guards the original overflow (psched_mtu()
wrapping to ~2 GiB on a huge-MTU device).

Conditions to recreate the bug: attach an fq_codel qdisc on a link
whose MTU plus hard_header_len is below 256 (e.g. a CAN interface). At
that MTU the no-drop threshold must equal the device MTU plus its
hard-header length; before this patch it was forced to 256.
Basic Testing done: with dev->mtu=100 and hard_header_len=14, a
return probe on fq_codel_init() observed cparams.mtu change from 256 to 114

Fixes: d9ebd8f9aa8b ("net/sched: fq_codel: clamp default quantum and mtu")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260819143136.57350-1-jhs@mojatatu.com
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq_codel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 969b2510b0b8..e6c87a32950f 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -517,8 +517,8 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
 	q->flows_cnt = 1024;
 	q->memory_limit = 32 << 20; /* 32 MBytes */
 	q->drop_batch_size = 64;
-	mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, FQ_CODEL_QUANTUM_MAX);
-	q->quantum = mtu;
+	mtu = min_t(u32, psched_mtu(qdisc_dev(sch)), FQ_CODEL_QUANTUM_MAX);
+	q->quantum = clamp_t(u32, mtu, 256, FQ_CODEL_QUANTUM_MAX);
 	INIT_LIST_HEAD(&q->new_flows);
 	INIT_LIST_HEAD(&q->old_flows);
 	codel_params_init(&q->cparams);
-- 
2.43.0

