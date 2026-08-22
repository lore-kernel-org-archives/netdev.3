Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6636826B
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428535; cv=none; b=NYe/fpO9Mzd8CyNSlJxgfi8md3rBVdVeYYPyl7viO7RZhzzp0ou+yIrVRbTMsDU97eKJSws8oqrwEWMF22MWKlANs2LEoVAFyVCLaTUZVpGMRIx2P3h1RJT/AZF0blhoemkprSp+UNqsOKoTOfmG2Xa3TXh+MjbUiS19cznjYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428535; c=relaxed/simple;
	bh=+jlwYghC4ExY3ERsnA0RO1DbLAH1xLhGCcjcB80hAqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fui1ClpF5Dvm/aPybHFhkptAVTnQMXEB6ngCmhRXCaGLIxETIP8VlfLFV19FDts7+KlFNzjycU/ejKALIPn9yMuSgRh3HjnBWqPK3lY2f5JNxvS2oqiWMSEvLN+4cILdtSEBduG8h5H3WHuigrfH+/6Sw09MinnY9nF2HiMdDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=TEEnlxS6; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="TEEnlxS6"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92ed3993c1eso109732985a.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428533; x=1788033333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zlRU7IbJKL/9+tg8sRrGYCHYJbXO8RJqk3wUbHTfj0Q=;
        b=TEEnlxS6eLGCPxxO8Ir5J+8h2lzy4XMvQpPf3Ts9dW4UaZM7J7BFifGpihoAqnrYIn
         4MPK/F8+KEx51exo2DgyNLEPzUSh2XtX1yaVanSL/ClvhB/VaEMrQOx3XEsWsknlh3Lt
         FG6es8SrS0qzVn5+FwppOTSXvi6d1bCm65q0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428533; x=1788033333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zlRU7IbJKL/9+tg8sRrGYCHYJbXO8RJqk3wUbHTfj0Q=;
        b=j6xe8/s8BZfiSKBxX4876mhgC2QhWw1fhx4WbHc55TBaDY55W+UgEBFRr3qbsf2rwz
         toEaTJ3NQslROEeBtfwZWKTnBHwuGMFDJJB7a69AO15NwVvomTynJ38AqgtBrHmixIyc
         pPo9vlo04uxW1bRONh/VWZx+DlsdGNATqUgWf8QvX5YCwO1uwn5Q9F/84EQXvZrvzt0Y
         bF+1IJO+Nbzat635aRjOQQovzliKaYQ8QWushOmLEuSu53Jw/gqJ9qJJOVuLvnY7tx2V
         tW32fAANUnuEPIB8UZ1SsLbXPFrkeGDeCb66S5N6uiUz45FSkxR8hS8CGGehYAy+2HFV
         m2Qg==
X-Gm-Message-State: AFuF++mEzUfwohEWFrOzeLepaFS8UIgeHOZ3yUUExCjVH0aWcUFHrX45
	PSIvYKaXfL7Jp0brnHHFIRgj1Credx54j7cxW/hczRSGDg8143TGCL1qCq9pg+Fa75PeJtCJoOO
	d5S+4HQ==
X-Gm-Gg: AR+sD10pjLXEFAIAurXpJmPW2Kgt3w2sQvXK4WAv9IwpF1sc8trgyxtzzss5zBy08/V
	fX2TTCUCir1CNQEHEPNk6AyR+IZp4IFFkRc260Bm0DJeWeZ3JpoBZdmEyPFSCtrt2hD4fwYAauT
	Dq2uTFd9JCQvsm1O0G0ltY+ZeMmo5kQehIOmGs8Yc8y/psSTd3RJMtwY0xu59SExN+rCCKcD+Gs
	ZiDyPOoPANLrRjVCOZHeV9N6DZlj8joqd2U4n53feTRZg+brzjm5XTHj38Ey2kcZKZ3zW9KUNOj
	c1PNc1vYRNK+ghI1LZMnqODtTO2g/rf+SkrKg0HS7wgNRbqUpp1UHwvvude9yDWoA7KWnAGq0sD
	MqAktARPUo5kJ9L1lJwdt2mdbJ6k2WIgchyxSQBRzks31O/6XiYeD1hr48kxJRJmrkyl00rFTS/
	KBBA3QkkPuJWSTVOAQexNr2cDU/1uepj7LwFhmjBTDBay0ZY7JXiaXUQfKGkXtbcU=
X-Received: by 2002:a05:620a:44d6:b0:92e:6c8a:2a39 with SMTP id af79cd13be357-937394750cfmr1369602785a.13.1787428532875;
        Sat, 22 Aug 2026 12:55:32 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:31 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 3/6] net/sched: sch_codel: clamp default mtu to avoid disabling CoDel
Date: Sat, 22 Aug 2026 15:55:06 -0400
Message-Id: <20260822195509.112717-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822195509.112717-1-jhs@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codel_init() sets q->params.mtu = psched_mtu(qdisc_dev(sch)) without
clamping. A device with a huge MTU (e.g. dummy with max_mtu == 0
accepting MTU 2147483634) makes psched_mtu() return 0x80000000. In
codel_should_drop() the test "*backlog <= params->mtu" then compares
the backlog against ~2 GiB; with the default sch->limit of
DEFAULT_CODEL_LIMIT (1000) packets the backlog can never reach it, so
the test is always true and CoDel is silently and completely disabled
i.e no drops, no ECN marking, codel degrades to a tail-drop FIFO.
codel_change() never updates params.mtu, so the init path is the only
place to clamp it. Constrain to [256, 1 << 20], matching the fq_codel
bound; 256 is a sane floor that only makes CoDel slightly more willing
to act on very small queues, which is the safe direction.

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
device with max_mtu == 0 accepting MTU 2147483634). Requires
CAP_NET_ADMIN in a user namespace.

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_codel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index cacf5244958e..6aa5829d6961 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -205,7 +205,7 @@ static int codel_init(struct Qdisc *sch, struct nlattr *opt,
 	codel_params_init(&q->params);
 	codel_vars_init(&q->vars);
 	codel_stats_init(&q->stats);
-	q->params.mtu = psched_mtu(qdisc_dev(sch));
+	q->params.mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 
 	if (opt) {
 		int err = codel_change(sch, opt, extack);
-- 
2.43.0

