Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9C227B94
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055218; cv=none; b=qZqZnMDR33yM6oV1RmlUi6u5tZWdrY4m7w6JM/HgvAlt075I3HMLCHE888ZQdoPoD8aufOgSU7SHaKZpVxKgnNxp4sNtUoMclPJ0ddmq4pj2ffZlVb39qu8SET+Yn0xczy/LlsPrfE4rPSVnw0UhwQ/bo79bnSVHCha7Kq0YafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055218; c=relaxed/simple;
	bh=lKzeBvyaSw7c+gtT4JKPnLcp5jJDvsFJpoYqOf2fIec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKDCqpg2KzMlZ3Ni/IC6ENh6LAMiQMLti0GU8lUJunpqIz1O8fos+DnKcUSEEu7c8DvWELy99Std5Fca/dpomkFK1Ej8JoYoELnSauyX0QvttR6NtsQht70BIdTTibPK6ZQWys8pHWrohDXRIQf9HKT/aYQ0f0R6PoHLWl/+gAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=pW0giTOU; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pW0giTOU"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso6281138eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775055216; x=1775660016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/O9dumWTpZUE7TGTbAhnOcGj3bC+/R6cvUA+Tzt7Rc=;
        b=pW0giTOU/+xnaj+LaNEtAkBwlhCUalbGMsAPWwP4MgIzg6Wmo1mjImxxXcQMf4gJTa
         bGxS22kRobfUFRIjv99QAX03VlaBD3Nxxf6RpWBna51Gp5vUicq6Bownwx9epv151TCK
         cIaEiwUp2aY9cBrlXvMGLPGAd7/nQVeG836qtM+pf08I93chrfN0MY4fU1zi+Iwkz7qV
         tbppXgnrqvFVctzFAzM6wVZ86i/METZTlfzi52tTSMEp2h5eyTHcyt6UGc3CRuZw4Lxx
         rLfeCQsXYJYAgxsyMfXwvX/hm2TQ7e4fJ4XQj+cYrd07MBqGNFuYMvTymFPvptoAeni4
         q0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055216; x=1775660016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/O9dumWTpZUE7TGTbAhnOcGj3bC+/R6cvUA+Tzt7Rc=;
        b=LX8YN5wYW6O+OcGhUXJglLl7wMvPeWDCfhiX8LZIzFEyActQFR19ntGS9lOORQRPdA
         3C4k8UIRlzeQYcOWE1IArBAR7q+h+jR9sRRzEmMftGwaqXOzpuTRmd3z09LGYUjUb0EB
         mnu8rlovS4e+DGFNuYlBg8TWPKcYsH5w8bGC+OQhwNVxeBDVCg6SuX9vU2R8mB7eqFbJ
         IWLAiYASJ+2qaHi8ild03KpNlNlEKfPX2IWyRbux5pyHWFD+ZR3m0+pPbhzMQwGsJe0E
         DbDB4QVysHSW+DMQFsH+owAYvIvJgX5QpNO4jEgO8iKUz+z99HeoW3hjOGWimNACM9A5
         cquQ==
X-Gm-Message-State: AOJu0YwvDXR/iewMwQNQF2Zd2WhfQHg9kkiYmgpu8JbYVdpSSbCX9DMG
	lgUVGee515AXRVYbeNgwh438ysANQgfUohScUT3dyLKt+V2+0ibw8lU8xfpBGvRW55m7HRMX+yE
	XeSBh
X-Gm-Gg: ATEYQzwdq1rxHwQJtlqEgcxZfQn5Ywl2uaq6Ie4lM24Q5RSf18ChfXL69Zj1n5XhhAF
	RR2kBeGy/VKu0zz9Z5/me5evBNKy1y4vHV1OVI4hlpaR5qaUhS23mF1Hj99IgJz2quEL6SsYG04
	nqpqYJjqXh9zjxIWVp1t4FNYbGsklKE+/t5d6+LN1MK80C9fl3/fh6RmtQFBNum7U+tN14k994b
	Fra5iq+wavHKcdTvbT2h5dhA896NGx1JzVCb2LLsC1f6j1sp5ztvwU7pIEXxOVHegrKg8qa6tuf
	CZ7FlT1zjee8sCCAGCQtnIhj/b/CsWkGeNcfLd/1+Vth4IXDTtLIM/B7RSZcDT9t1ujNLM/IgEX
	CNClEGh4qXwG6R9qyAhYvUg3WwOpKQQO4zBD2DWmT35Mw9QKDVhsWnglgv73y/u/2I1Fdr2+qOG
	iHuDvcGK2oT6q/fPIu66LLMzgg5uYVukh/
X-Received: by 2002:a05:7301:fa0d:b0:2bd:fe5a:b861 with SMTP id 5a478bee46e88-2c92da55f7emr2145101eec.0.1775055216139;
        Wed, 01 Apr 2026 07:53:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm12804830eec.6.2026.04.01.07.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:53:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 1/7] net/sched: netem: fix probability gaps in 4-state loss model
Date: Wed,  1 Apr 2026 07:51:53 -0700
Message-ID: <20260401145332.78285-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401145332.78285-1-stephen@networkplumber.org>
References: <20260401145332.78285-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 4-state Markov chain in loss_4state() has gaps at the boundaries
between transition probability ranges. The comparisons use:

  if (rnd < a4)
  else if (a4 < rnd && rnd < a1 + a4)

When rnd equals a boundary value exactly, neither branch matches and
no state transition occurs. The redundant lower-bound check (a4 < rnd)
is already implied by being in the else branch.

Remove the unnecessary lower-bound comparisons so the ranges are
contiguous and every random value produces a transition, matching
the GI (General and Intuitive) loss model specification.

This bug goes back to original implementation of this model.

Fixes: 661b79725fea ("netem: revised correlated loss generator")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 5de1c932944a..2cc3acaa4068 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -227,10 +227,10 @@ static bool loss_4state(struct netem_sched_data *q)
 		if (rnd < clg->a4) {
 			clg->state = LOST_IN_GAP_PERIOD;
 			return true;
-		} else if (clg->a4 < rnd && rnd < clg->a1 + clg->a4) {
+		} else if (rnd < clg->a1 + clg->a4) {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
-		} else if (clg->a1 + clg->a4 < rnd) {
+		} else {
 			clg->state = TX_IN_GAP_PERIOD;
 		}
 
@@ -247,9 +247,9 @@ static bool loss_4state(struct netem_sched_data *q)
 	case LOST_IN_BURST_PERIOD:
 		if (rnd < clg->a3)
 			clg->state = TX_IN_BURST_PERIOD;
-		else if (clg->a3 < rnd && rnd < clg->a2 + clg->a3) {
+		else if (rnd < clg->a2 + clg->a3) {
 			clg->state = TX_IN_GAP_PERIOD;
-		} else if (clg->a2 + clg->a3 < rnd) {
+		} else {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
 		}
-- 
2.53.0

