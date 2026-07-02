Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87973463
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950935; cv=none; b=f7ZyUvbAApLN7S1RvwMx3iwszZ/U5CuunGQIz7R99f97yT1zFITsBgTvGLcrXfJSl7irzk0CeCvK0+CBivbegBee5EGGENKDaBSAbMMkVMHj2lF0zPa5H0iR755wEaP/bkkAVMOJfC4xZDheczNjQRcwzmEbeSkhj6VPY0T2R+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950935; c=relaxed/simple;
	bh=5RAkGAO4xDoQj10Cr5SKmISeeEGKMnLGXAAFJEra/5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAzlEMqMWsFX+TJpjUedJ3BE/Am93lmxeBOf0wCiz7DJUGvUdkyJm3S92zAR4jhgVOjHVd5+mKH2xbCt7CYW+NLT5xSOrh2HCkYh5xW0Np6jdV72WnXvHOEiomtH7c26WMA1L+RecHwiiydG80uMr0fQjeWeMW5XxugwK6duIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=N4sKMH+O; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="N4sKMH+O"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2c8f43aaso3959071cf.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782950933; x=1783555733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuxDLRMlHGpmhBCSI7O3vt6aIkiR+j43OrPR52n2sNY=;
        b=N4sKMH+Oh8ga8qcSIQAIL2vxBlrzPiYyWnl6b3Zq3TUQE07YCCPOBDkmfE4qmfh7Hi
         rL8YSg7X0Nue6A1F6Oovwn48oHu0RaQGN2vbb1vr7fdX5wUkkTliskPywxMA5Om9wqvS
         yZIT9WL0AfVJNgXR9StRWZmujHrpNl0sIQ6xC0PqFA8y33EBS9Z/+dPuZBD6lU0wM3QV
         AYC73eDNKvvRcxaoyr6yVe7Ppow1DCDTBQg2IipyBb/f7tgeAbRokaSQd1CqdgokNE8R
         kmFq83gbUrKudi84+0RthN/z32pY2ks046ITuNTIdG04obNOx9E+GAjz+4Zd0gqOHwAk
         eTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950933; x=1783555733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuxDLRMlHGpmhBCSI7O3vt6aIkiR+j43OrPR52n2sNY=;
        b=VN4YSAGECQue1PwipnywnFk3n4eer5BrT2ad1+sxaQmSOVoUotMeOQ48zYCJHMXbK9
         sC+FTGSqWOzAxA1g9Vt1kK/ss1bxECQsTVTDi0PhtDxugXkarzcFp+6MbC9O8KAOi+wW
         7Xkj/hAkz6fs8rwCqsrZnJK9ZGMZeuDuEZBMEGRNDagYhozE4fMTH/vPtRNMO+cfgAM7
         An/Ii6AZ+XnG5+ToJ+r0hua+xyUNFdmeFVqkoV4M3V9xiIMNLLRwRKzBpxkcU0M0Nhg1
         1nLVX1zIAvmeqgdYOc5rW+OxCjikoVsBnio9WDx5UTbyRl8+xm/T6H08C1DGAZXV0yoC
         fxjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+t9CbrQRmAlQfuRc5oZOD0we2ckh2D8wT0z6eiK1xFFqlbHFW2ln+qJLgzLQsDys++4Oa60Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBigY3H6Q1bl+YPzzm4YEpCoyTcj/n4txfV0A7cj0YeyyYvqe+
	qpfb21R+RfMmbqIb4xVqPpGtkvAOHsIfr2VIQ+Xfrmeb+feY8q2I4x7ovGp/c5ZiD80=
X-Gm-Gg: AfdE7clAQdFh4TNbAE0xHaRxn9FAzmmop5bKx+Xc9zXcXXBaayahXju0d/4kuASsfXm
	09l/ElVUmrLvUINOdLR4TDdodUuFE6UMmEWDQeJf7fbEjVXGvS81KpFQvDHcEeEzmR403z9cQPk
	6FAFb6k5zz0XnYsA6aJOrUrwAKcccjcUMWT5pjruTLTfnqjXDg1AqfzsjKlzIJSNbK20R4443hO
	lmz9vS4dzQTmjK7zxDr9/DIoF1ZKGDtnWllma9ecqN81W58q7M10a/slL/YExFvtGEkyKr+ma7r
	BPQ4OwISOF6lldmPYqOe/mubmQj5jS2pYlKZklVU+SD7V+LtjCyzelGJsz4uaHesGTQiuSmshIu
	TxVvCyokwFJhV6nsnZYmlFPsrpd1nmcrbyB4oVrv1ERvwtrqCe3Ic/JuQLAiuRSxiMD6Mju3wVU
	dlz1yI9/05YGkZGn1g
X-Received: by 2002:a05:622a:558d:b0:51c:478:32a1 with SMTP id d75a77b69052e-51c26a61f79mr48748921cf.18.1782950932695;
        Wed, 01 Jul 2026 17:08:52 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51c30b130d0sm3628021cf.9.2026.07.01.17.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 17:08:51 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net (moderated list:CAKE QDISC),
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] net/sched: cake: reject overhead values that underflow length
Date: Thu,  2 Jul 2026 00:07:59 +0000
Message-ID: <20260702000758.297407.e5c888d9d99d.cake-overhead-underflow@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAKE accepts signed overhead values and stores them in an s16, but the
adjusted packet length calculation uses unsigned arithmetic.  A negative
effective length can therefore wrap to a large value.

Such configurations make rate accounting depend on integer wraparound
rather than on the packet size userspace intended to model.  A static
netlink lower bound is not enough because packets reaching CAKE can be
smaller than any reasonable manual-overhead allowance.

Fold the signed overhead adjustment into the existing datapath MPU clamp
so negative adjusted lengths are clamped before link-layer framing
adjustments.

Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the rate shaper")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v3:
  - Adjust how check is performed
  - Resend with v3 suffix
Changes in v2:
  - Add fixes tag

 net/sched/sch_cake.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a3c185505afc..f78f8e950776 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1389,10 +1389,7 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
 	if (qd->min_netlen > len)
 		WRITE_ONCE(qd->min_netlen, len);
 
-	len += q->rate_overhead;
-
-	if (len < q->rate_mpu)
-		len = q->rate_mpu;
+	len = max((s32)len + q->rate_overhead, (s32)q->rate_mpu);
 
 	if (q->atm_mode == CAKE_ATM_ATM) {
 		len += 47;
-- 
2.43.0

