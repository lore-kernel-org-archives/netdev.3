Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E848A8DB
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832371; cv=none; b=XYSJhjm+fjIKW/ZkNrO2Nh9NzTnxROJ3tVSDtlbiL+LFM0aCHIUKJykpRdK6fja+yxaeN6wfzcQyJIYFlwBiyMGTCRIFR1SIEqxlZchE8VppISSnkjMGFEax1sU40cmULIGKHMAObxQlMOO2J+TDFcIx+J0AvTzt7KQEgMdyG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832371; c=relaxed/simple;
	bh=PPpYtX1bCmCOUQqG3jMTyzpSC2XUlQ7hOUx+Jcf23Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amopdCYUTy11nmmAJKMbB2zRisVt7YUoEnXn2SDYx/N3UgqmUL9MRtl6Mlzsqbm3VW56h7foeJvNwcDz9flJKWqNVIC8/LkFMc736gE5fhNz8Nz6y9YmrDYGjT5RfuiWuD9BggZwgDo2oFW1bN11+qNHkMpBLRQI4eCFamzMj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt5aTg2f; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt5aTg2f"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e347638adso1157978a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832364; x=1785437164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qd/dKHIuRS/CtItZlX4/17nIeCWsz+xndXH+6leeAfQ=;
        b=Qt5aTg2fZjAiaCo5pfz6Bq8V2sYGUXk4abs7mwh67/UKJYelMhxpOvS4NIL1CEnOZT
         /kwUVLPP0WSNPKLD0aNjXniTbUA5WHPuSjDaddPUlBfpJDv6oPRb97qhKzoiaccpRnpQ
         2v0QsR7CW5TR3xkzQ7HOBq/ZvDHH8r2PUQPvpvm/aft6rYABPfVBIKy6etGzuX+NF/e0
         O0639itUhSiv+/1Wyx1UiCIJ7jkVaeBs1kHPS0Tar+wf+bsrW3Tm911VNCAmeZaCsIMl
         LXZmC6Vcjt7GD8mwDTxowMaYigE0OBWvJMkjCIoYhXNh6KWjddojpWbdCKao5LekgV6I
         YnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832364; x=1785437164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qd/dKHIuRS/CtItZlX4/17nIeCWsz+xndXH+6leeAfQ=;
        b=MFZmktqwGKRarpAFueA9MX0LavPFX7wG//GxAY8/4prhOJCHNig/TW6go0CsOkxoWp
         EkXXeRLOy/DzvADTiq1Psva+wbJwKeQTpqyMF2Qga93Ak/d6SHpEICDlzryKipv+Ku3r
         Kmv1llKQ637tZuQDbrhpdKuZy/o3iO1RNLKy6wXdx9GkTUHShgJH2yw4yc9e96m1cWY+
         6JfvGIF+/+l4FT8bmCWioQGmeNvzwTQtpPbfUWcP/CVlnQ+QHH/LQNOxwmgCA16ORS4/
         Ww3vDFzpmBExDF3M5gnqjPl6fMFT1BE+Gy7MRPdsu1wn/fF3JUPAG1rz0GFTzJYvGh2H
         APHw==
X-Forwarded-Encrypted: i=1; AHgh+RoCecNuKxMbOnvqM9viVJa1VXlp68xRfgWUML66VCrpOKjZl0DdCqEVuQGJrDbIHWMePWG4H50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51c7Xn0DfSJMoG2CxAnPgsqWdHWTkhzgIH9ZJvySJhpeDq9uj
	5Alzc15yuIFaj4yUgbdLmlO4b+qsWYDqnDUPaSm1ZUsvQfTE6hNHBs4/
X-Gm-Gg: AR+sD13M+IC+aMllY9lHptN6o2N34fV15oOWoHYr7aL8Twr7ei0UDILvDkspmGOfpB+
	CAwH/p7VetOjbxj3pPliW+K2CrDDzKgVIJrqqmMcfcLCquSSFAPSjoRue4NKkgzcPw8zIJb3IV4
	w9zS1KieEy/7CJndTxpBSR+uF2tddFGiSr6gnGbh3GiIx1OYpUzhnVtJGqnUPOGCZQPGso3Zkrz
	T12cxzHstLwXDrjVewLOVpfyLxoyuomLoWekyMXjJx3bhKFJJCvKoXZOpezrtCVuDReLJIxUe+T
	HBhNamzb8gJW1fjkIT6OSEQCcCMFz+aeyZuaM8bjhMaaGPrExb1EZ8hqcNeN+3xBoIOFjoviPEN
	K3TOzD+vFvuSwpnEazxoLRcbJZkBDnb38do5Pt9cnth4zOyf/XtSMpNif9KFfdoiICYkDSG39kS
	cayJSwkyk=
X-Received: by 2002:a17:90b:57e4:b0:38e:79f:76ad with SMTP id 98e67ed59e1d1-38ec6566203mr4405122a91.23.1784832364154;
        Thu, 23 Jul 2026 11:46:04 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:03 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 04/36] dpll: zl3073x: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:06 +0900
Message-ID: <20260723184538.3888637-5-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
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

