Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88356E555
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666389; cv=pass; b=er5Vu0CSnHNlFKVScX0dwAiBFAYSgHv5YkmhYvj536eLkEd4it8T3F6pNdnN+xkcclBoz0MSovN4BKfWgRJjTUo3pfvgerLx3p8Q0LGZtXUHPAAuH3kSRJ1H22vXQ+o+tbx3KJ2mivl256bAcsqnM1KVH6a6YXSJC6EvV0xt11I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666389; c=relaxed/simple;
	bh=CRn3obYKuQ7TqQS5rgKofmsDVm88WEONY8vqkQA5Rzs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eNVt3PZdZ0R/mgNmXVFpafVTAO8Tp2kbaxiCbnKV9x6HQnalphOWjwF8z0v0pM7VN4LsydtNYhpTsx2gNTQ0sNAZB/NRoreJ0nKDeuG6Jv72wSdxigg4jODa2K/PH74f8ZDPF2ueLLqh6WNSdN1pkuDWlhSsK+0DuzcvdAfWkYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZN8rMWo6; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN8rMWo6"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c149c5722so2499391cf.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786666387; cv=none;
        d=google.com; s=arc-20260327;
        b=W+HEWKjOXemTFTChdtawe/PLAjdLXwDaO3ZONqWA8IayFNYa7fcMlc38yP8383fe0V
         k0SY6zKEyfSjTSJLoVFhqM5SqhSyl4mmXnG2m1076q+k701Jv6iZMB8F1atFrCMNm1Iq
         tCqyN79yETvsUUsMEn6dMy7dLbCz9cDLnLM/eHGoRfp/zGANhBhLHfZaf8ZI6vq+sm6H
         SoRchgcoN/MXE4XKsVOtdhXreBOC7h6h2+Yq9pIYlswR3/oiSCEFAAW8BqBAzuONP+Xu
         p5zK7HX9wnYGAg7824rwrQpl//lSx9bFunLTFyTvgN3JSYjsDlQfgDXBK6aP+wwNJmyV
         0xXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=T3/VGRsOicBTcIUzbabnHRceFUkQOtrwwZA33wWGPK8=;
        fh=vue9XBQUeZH2jJiV/1XIKv60ZCg/8KjObm4+OCf6WyA=;
        b=kTrILLC+X5zImqWf+aWRqzo9xxhk9nWz3Gj6/nTCwS2WBAwpzk89PL9aaN4x9Q9E69
         p1GRqGGCu85bEIeVCcrjveHT/Q0KRWs/JInUimdUR3EgLgT7yUWW8taw7gKaKsx4Tzyd
         vMe5+FrrZAy0FTQVrc8SHW7P5DsAiAZ3Nk3ykLYLnxji1j2W9v6b93nJ1e266DkrJlu+
         gmmHua/mOiysqvCqOg+/rDpTokRf57kAoSvZj6FA5gqo93RdvRZ++ap7+EUCvTzlJOnD
         HLY0ih/EkmMK/5f4APZEwmXX+wFa0IvYKU6c01nHbdHcCnB7+up/bQOYcgfRqktoEzyI
         o6Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786666387; x=1787271187; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3/VGRsOicBTcIUzbabnHRceFUkQOtrwwZA33wWGPK8=;
        b=ZN8rMWo6AIML0KLpmlpHs2pbihYh7iCJ7pld/Tupewn7Tc1zVVwd8z/LmiNQEao45P
         B9z16bVjlCqJQ9RZPeGRgOu5I9Yq53Mk6grRPe5qCTIcyBds2hGHLXVjqKXOCxL2HUrG
         bsHNzqnhxcpd77MmPkeBI/DzHqUuGtpHXZ4F2o6q/IiPpqXWkO4tXJ7o/6q3IPhRCECa
         MzJIUQ8QdW9LsRT77CuhMhRu1jDnf6QfzVVg27UlM5DaPP30OKfvUC5MljtzVY4SlMOH
         raoL8yDFUMQOCy4bAphJIB9+EIB8cn0mqQFumLplt6TQeXifmQv3D6zC9Yn6Tvu5hmvh
         mthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786666387; x=1787271187;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T3/VGRsOicBTcIUzbabnHRceFUkQOtrwwZA33wWGPK8=;
        b=HNAslHuoFRxUeyFYmznbQwkJOSuNS4MPRD7XV8J2BFZb6Wv9Z8GF4iK238ASHubEgk
         sRcRSqr3Qwee1eZzCX0GRpFUCsesENpwUcH9RJ7QJT98IFsJSarRIp+9gXJFKwtpjqts
         VKYFWzzaEalCZkN7YsLdG9L5xlh4tFreK3ZXxSA5Ss8YOJ28CNbKu5rDdG7BJOCLON3I
         LTET/J7W3PCNHApWIvo+DdVY/JBeufYMacOhrncpIz92Qeiwpfjr8Ol3pFYEEDR/fACC
         QMoo5umBKtD6KHicl/x03J+nUdMDI9ecAP/21Z1Y65NLHZt5BTMQmBXOFpZuiITGlrsy
         YrEQ==
X-Gm-Message-State: AOJu0Yx5DHRkoUktItArfZ5feKYejOd0dIHhdAuOe3rCMbbz4PFxnPRp
	mhojHNYeDddtPMbn5/b0umccu2KtzK1smAz6m6d5YMh8dKt6GbFG66bObn8vHH3E6HxQuvu/LEu
	Rn9PFPCDhmVUnCTRqm30vjAv0yW39na8taw==
X-Gm-Gg: AR+sD11d3T6CRSCleIDYLWAjSDFCSKZVflKsAKnVTmPSBP5crW3TctkkDmpz7GksU++
	mla16she/v9xPcEP3dwnm3dLKyimcuzEXDd3Z8agklZeisSCtnX0aiELIUEocWrfpbZhV1ukbma
	3VcDnJrjXTkCWfU2MS2Jl5TMSFa1Wj8QIw4JepbeAoJtfNX1KtbJSSl31iJMsIXZtX1iEqdp+a5
	5/tWii4tI/JJvFdlcDe0VkK4t8UKozkIRW8k1KFYFAHVxBfcBhMooqFjiqPZEgaT5HMHVdnkYpP
	7mHOsKznw2FnCq+Um+UreUX+RnFxvRWUOoJBWl2v8x4=
X-Received: by 2002:ac8:5913:0:b0:527:69ad:fceb with SMTP id
 d75a77b69052e-52d84c3f2afmr25232171cf.0.1786666387214; Thu, 13 Aug 2026
 17:13:07 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Aug 2026 17:13:06 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Aug 2026 17:13:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: diegomancera.dev@gmail.com
Date: Thu, 13 Aug 2026 17:13:06 -0700
X-Gm-Features: AUfX_mx1q2Bzoj_9xMHM06Gm8slt5pFufWk96DaC48MKtpO2vQdGiVE2atQI8yI
Message-ID: <CALruWrXs490+d7tx82mLG3rmH_H-svkwA=zXggr0qOeEhG3GmA@mail.gmail.com>
Subject: [PATCH] net: txgbe: use vector 0 for misc interrupts without MSI-X
To: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In non-MSI-X mode, queue and miscellaneous interrupts share vector 0.
TXGBE_INTR_MISC(wx) instead selects the MSI-X-only miscellaneous vector,
leaving vector 0 masked after it is serviced. Use BIT(0) for the
non-MSI-X fallback at each miscellaneous interrupt unmask site.

Fixes: e37546ad1f9b ("net: wangxun: revert the adjustment of the IRQ
vector sequence")
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 8746318ad3bc..6b5542cb2161 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -31,7 +31,10 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
 	wr32(wx, WX_PX_MISC_IEN, misc_ien);

 	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	if (wx->pdev->msix_enabled)
+		wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	else
+		wx_intr_enable(wx, BIT(0));
 	if (queues)
 		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
 }
@@ -183,7 +186,10 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int
irq, void *data)
 		nhandled++;
 	}

-	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	if (wx->pdev->msix_enabled)
+		wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	else
+		wx_intr_enable(wx, BIT(0));
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
-- 
2.54.0.windows.1
