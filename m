Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472741B8F7
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224525; cv=none; b=lWJaooE/EU4NKiLNb/V9UYUWnyRhVI3PTiwn/HQZ8lERxgIL7AWmk6Q1wJevy2096MVWSR64Wl8H9HVQenN5s97wTWNsZkjE/snYQXlR9zIe60qHH+3GMUKn3FA0FVB3aWwO6SKKZi2hq7cTcIuBvuSpzvJV3EsngBky6/e8mrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224525; c=relaxed/simple;
	bh=3uDE4EBPIrEu/wlRDQMGu8LdJv+K8TTLdEoIbXB62jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cV+0Cifoyqtc0v4l+EjVNAaECIeaFKYYjXB7gcB//hD67SAYmYVVHVlpPN9dAtca0kWB8Hq6pu/dS2s32r3Ygkim2yi6ggSB5+ehNC4tdT0P4fayGgZC8OBFnFgHJndr+fO06an+Fr7KrYztPhS3GOI9pq1/beDhOo9Y183tfYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qedqFoz3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qedqFoz3"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca88130e09aso1060556a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224523; x=1787829323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BpV7OrLLJSmZ27VksgMp3lb1FLdxWSw9DXcxUIDAfzY=;
        b=qedqFoz3rN62rk457GrvMTkSFB4v2rMlmJQ7igPidq5l9IL5b4woOq5+/e7zSjW91c
         GYWkHAe3+XmPZ1xEmJhLhRnDy1dZNCyvdw4qiCuVdrj1+OsYF1kzfoQC3hx4D7j3UwJc
         t8Kmkh1XEiF5grSS5TQU4AnHvSEMayWJN29WaPH23ksr4b9RxZGLLApbRKYShNquf+zG
         89uEX4A0txhntiPhjbBxOa8HoE3zj5CMbFiP6o6sKiOmiE4q3TAqjZGJECOHqVFKiCtF
         su3Qnml0Ce2EoQYcwNFJDqwH0p7xwS+wvJIBnrmbD10FaEbZ2obzDOHYGNPZBzAUNyc8
         X3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224523; x=1787829323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BpV7OrLLJSmZ27VksgMp3lb1FLdxWSw9DXcxUIDAfzY=;
        b=pOwNDmGYMqxiA5U2CYwQD9Tdgr2sPRZZ9tBtDjTlH5ZLuuUia2/440+GFxSzhIBt4r
         OLSwF6qhMyMX+NGEs2LxVDjuL8LCCfnWlUALhnpH/3S1yzt+AuWA2euzEoLnkx7MykNo
         rmydKNnxM4zhyEjoZfCV/dekW43008jK4BNfvJ5qbi2N2+Ct1CCrSlrmTKkFRc/D9w6h
         tai9B5podsQcMTeL+h07X9JslieuoufwblUB5PzTio3wYsmMNvRKU0G2rrqobXGTPFtM
         6iLhxh9TYMoZyVNkpltoGMuly5MOXXoF9i/xKVt5bsTSRiHxULGPkT4kGUJhc+oRkNo7
         OAmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqU77IUXtXpB0pze2s3EteXIdE9PDSep9oQ2U7AFNQdn3410LUchAbI1OkKuH5+h7fLafEBrpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2Cdv91N2Wp2suiYi4CEJ/2wlvCNlk1T2KmJt1K56sDX1pcoV
	I9rOWccCUAE1TyDIe7U6AOMjCsuhmLIpC9N5gLFExP6jBSL8AIvqS/Ww
X-Gm-Gg: AR+sD11w4sDU0fWHbRQs17gNF+KLzEYob9QSWhR6HPiR+TSplUGhCyY+cAd6TD2FcyP
	cPtfa495GMi7ganGZprkTqFFlhZO+F8ufdgcerlOChwkekwbY/nfC0mUo8+PO3vp1jRno0sdN+u
	skj19FN1GgvrXi4+0Pt0SwHUZThVYRYy2UZCTYsXCoSr4Zw3uiVusNmpBaiGHfM4LDeLaWgMxgq
	Q/fnZYVvcTlv2w1VRhsSWjqg6hHt4ZlDTIXIi8IK2D4BtlH0EiALVODG3rzeRVl1CqzTURmXcXU
	AWtnyyWrIph9OqV+cwtjp9r2WY8kMFXU7hMfiO39eOzzUVgnI3PSMQIMRzWoAFvY6jIFXoFeD8S
	McEWfBi0Q93VeBwyKMZpmI4/bcjoIQhupS4wrj+WFPLXNKs0HnC6IuwSRnh5yxenyBdQZPbWyIS
	MYKmBJjz5ErPKSX9V455JeqWSs5CvGKCUUf/C/TjUoaTAk/9o88IVtcINUJwLQdoBMcHiJMDWtc
	JLMAQfibY1gdG9PIS2B52H/2mGMOgxdXYKMCizeZ9dcVp29duENJ8E2hEiOEgw8b/LIT79Li8gY
	Aij3EXg2yA==
X-Received: by 2002:a05:6a20:2446:b0:3c3:b57b:6459 with SMTP id adf61e73a8af0-3cd0107f1eamr23055896637.7.1787224522634;
        Thu, 20 Aug 2026 04:15:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15568c722sm1676503a12.24.2026.08.20.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:15:22 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/4] net: bcmasp: Use platform_get_irq() for IRQ lookup
Date: Thu, 20 Aug 2026 18:14:53 +0700
Message-ID: <20260820111456.97947-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820111456.97947-1-phucduc.bui@gmail.com>
References: <20260820111456.97947-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The platform_get_irq_optional() function currently returns all negative
error values without distinguishing between the case where no IRQ is
available and actual errors occurring during the IRQ lookup.

Use platform_get_irq() instead, as it matches the existing error handling
by propagating any error encountered during the IRQ lookup.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 972474893a6b..d66a8bbd6e38 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1094,7 +1094,7 @@ static int bcmasp_get_and_request_irq(struct bcmasp_priv *priv, int i)
 	struct platform_device *pdev = priv->pdev;
 	int irq, ret;
 
-	irq = platform_get_irq_optional(pdev, i);
+	irq = platform_get_irq(pdev, i);
 	if (irq < 0)
 		return irq;
 
-- 
2.43.0

