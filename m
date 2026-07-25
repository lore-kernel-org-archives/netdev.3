Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5CA31A07B
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992273; cv=none; b=nv/gLBuu3ysS54LKStwa60MxJl3QX8PTrg2YslB2f/MrM3lggHNID1lddUTFX5PukTQMYpz1TNY9petWJvL1Ub3Jd2VCHADfRO7XXRumhJDLC2gp0zfBg5cZwXYqpfB0GjkArGmrcWtrmpoBB3wQqFRID2mqDG8jIR1+qH67/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992273; c=relaxed/simple;
	bh=PPpYtX1bCmCOUQqG3jMTyzpSC2XUlQ7hOUx+Jcf23Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmHk6zfPOK60Okth9ryJq1tPnD4X0pVZvUd2e0zGaAKFn2khdH1vXRV77x+FE369STkk7kiWHg0GBQVUmeVm003qGqp7Ii9mVjSVUXl3qi/dm06xcJwFCM+j+Sm9WnWZtvZYxkJs5vCUMA1/VVTrHIXPqkzq9Dk8Acp8E4jrM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL1A7bdF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL1A7bdF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1468577a91.2
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784992271; x=1785597071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qd/dKHIuRS/CtItZlX4/17nIeCWsz+xndXH+6leeAfQ=;
        b=FL1A7bdFymnK166iyxUeYPTmy+4LwNUt6AiRAki4pVefKvVTEDjk3ukfQ/Qe8pecn8
         PcMgUP9J8HVnqxUi1GsSFF5xoNAfK3IcjrPiFXeDFrWhi5P6wrN7eeU+4OOkyETt6lnJ
         yzzQcRIF9jerK7yf+OJaEeJWy5TM4DHY2quddBIGr6SYSf7IQptvFNCazU6CKMqdrhg1
         O4dWGUES1/JpJijR2C0knEbPKO0XqIj4Sp/CW9mahpz0kSJ9lWRwncYxLdFiY7KsB9mM
         RRfOaorhp8P4oE0i7IGZ2paJ94O9jvsH5T4CjwoPyEjsrpXcmdydoZA8P0lvBapgKaJp
         4mGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784992271; x=1785597071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qd/dKHIuRS/CtItZlX4/17nIeCWsz+xndXH+6leeAfQ=;
        b=IGZQTu52CScbXFKc2MUpQzYbmHjVbPOrhw2+TSTAyzX68kKnpG4M5Ladp/tqRloOTL
         g3yAFgULvoZSG5IL+ii7q2O/PXFADn2Oua6Z8zyTb94tQMGo/Vici9wEEzpOPejcCaCy
         MRjafv/HW6swVMalFECdHWLnj56mK8//Iw8xIZ4E6lbVxI7lccK7WylRQUtotUNsdf5p
         d7PQKJC6loDFSO0GNS8rfMQQfaCZohND9LIiyjhMOdNYksMzLIuUt9fXCkJ0hZURkh0i
         pZgRB7ezH6Cb5t/gNHyPGse3Q0llM0DaVhbcptEcteiT06z3ukjH6L/gvYU3LRtO/d5H
         UeWw==
X-Forwarded-Encrypted: i=1; AHgh+Rq80at9OBOe2XC4dSAUpDWU1Uq4z34cVWkv18rAHOHwukRoY7bPvyo7esbDO4Xawi9gWBSDYzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2HuofZ6BgQunKVsAbNZsYtyJmkprO9U8NNQqMJBB5f0XPN0v6
	BBd9CBguBEfWSe0WCTkeeUWrmURdVUVIJbEldOpfedc55XTHXq053PYP
X-Gm-Gg: AR+sD10YJKK1fRCcZqycCaSJGCHbM3wTalJYUOQgnzC13YR57vwlMsz9xptgmDU1PFB
	rb33LG5/ifAYShbfJ6E4EICfgYg1CJODGg2DyLjFFT3YcEvBRG1v3LqQaKAhPjgR870uwrFiOvD
	v6qmhl/6iQRr5MReytUpAOXuPEXJBDb9vNJ6uU1F5EeOfEtLkgIwNJp09wmu2AkvXePQY195QmE
	smLgJZ5nk3y6/AWWM18YzpY8mO+2buqDk1Wuj7mvQuL1UGoBp3YUWCWKazXNSMkJ+2QGWv/KqJX
	9DfdHUTnqbbzfQBffablN2hRY6cr3nWVccrBjI08BVmsqFUd2ywtc8/UYR/3xVf0hkiwYhRVr0z
	GwJmh3l8xkP2u/Mrt5tQtPIVtIRkyqvc/zDSRkrjHqMHtwdy/gHqRfXxY/w0XPoDS/ZqrkkR+
X-Received: by 2002:a17:90b:55c3:b0:38c:e9e9:e7ce with SMTP id 98e67ed59e1d1-38f293cfbbcmr2529181a91.3.1784992270583;
        Sat, 25 Jul 2026 08:11:10 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f031d1d6csm2907665a91.0.2026.07.25.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 08:11:10 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: kuba@kernel.org,
	Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/4] dpll: zl3073x: remove conditional return with no effect
Date: Sun, 26 Jul 2026 00:08:49 +0900
Message-ID: <20260725150852.859188-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725150852.859188-1-ekffu200098@gmail.com>
References: <20260725150852.859188-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/dpll/zl3073x/dpll.c | 6 +-----
 drivers/dpll/zl3073x/out.c  | 8 ++------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index a2a641b8358f..0488ae6ac486 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -2272,11 +2272,7 @@ zl3073x_dpll_init_fine_phase_adjust(struct zl3073x_dev *zldev)
 	if (rc)
 		return rc;
 
-	rc = zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_CTRL, 0x01);
-	if (rc)
-		return rc;
-
-	return rc;
+	return zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_CTRL, 0x01);
 }
 
 /**
diff --git a/drivers/dpll/zl3073x/out.c b/drivers/dpll/zl3073x/out.c
index eb5628aebcee..410d15b96d0b 100644
--- a/drivers/dpll/zl3073x/out.c
+++ b/drivers/dpll/zl3073x/out.c
@@ -85,12 +85,8 @@ int zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	if (rc)
 		return rc;
 
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
-			      &out->phase_comp);
-	if (rc)
-		return rc;
-
-	return rc;
+	return zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
+				&out->phase_comp);
 }
 
 /**
-- 
2.43.0

