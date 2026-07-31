Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53047DD7C
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525046; cv=none; b=PHmK0olP2QGqg/diya/tz3GSn1sBqZuxIZqHOKjx2XVVOCUTz883KfhjBo1Jp9Hcs/n3ZB0qhNriU+lkWIgSf1+Fq4i9S1Lfzffl51GSbk0AwTDBRB8Au3XUOLZnrfK7E/r2Fr0ySbTCtxpaHSq+gTkU4wCejoiqTrqLKmxlwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525046; c=relaxed/simple;
	bh=ZGa1l8Ns9j4zKmAs0sI3eL1iQ1JySALi8kksmqNZFec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN/M0rpNLVUA6zRyhGYX2h8qwgwJZECYcop3kZ2RCGe3a7DdmqihsYLHybjaM6Msu2FOlUGMsxWUHLk06PkZuu92XZH+g/+xkF09an9GKkibbiomk2kk7pVv1F4h1wm6lOuZoghnyLvT0pSOrTC0SOWQuAd55gDBxBAjzr78vLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e7VCH6/e; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e7VCH6/e"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2cc61541f8cso26060595ad.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525044; x=1786129844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctX5/PlGpnsSqXnuJWEkPuJVtc0OEcWMRB+axFw7igI=;
        b=hJSrtfHY4SpfDng9m0O25MbwZPgyVKK0w8VbAb/bF3c4H5DThSGZwwTGnlebZpprgG
         6dn4rLVEVz841+wousX08Zdbc2HgDUcEKVtFbT85vklv9mPHEHTJKyGqZoQlQh3wi6r2
         8k5BYEvdLRAWITCG0DHI3H+HLQGtUVeoKCQBUrjGHc8weEraB3lLJPweSzsr5xr3tR4X
         bfXHA8IsiZL3Vx6vql7Zosuva8Mm4UuI9GCxILhIbNrQheICRTwoVyR4Q59/nnqDdt8a
         IJBL7WYsMnbYGCiF6CA2znVwqkUbd1kvT3WhDueOKadQ7mWy2ONWxNsVjWms9r9+OXKC
         NmZA==
X-Gm-Message-State: AOJu0YxChhgp4cjkbL1TkNiL4OOV0jIpTZVqHtAZS0mDHLPoEWZLx1tA
	5FI1sar9iVN56r0Qke6m4GthDWolSWsZYMcevKFZC4Ig3pQ+B849sHgPLBJKf2ejLDOdnOHsWLM
	0yJ028Sqd8DfKOYqdhHkSdDZfMbwQA27A0CMERUHabazULIGLAOEEGJHWHBW34agGyljyLRBUhF
	2z1Z37N1BFo+RIBMpEmS1hfce1vT64tnbe6wTkjBIIdxUogJidy39GNkDv8GCjHewW8jU1S0RAP
	BDDY9Df5I0=
X-Gm-Gg: AR+sD12MqU1akc+c22+/LhBUG0J/kOJftQFiFrjeUPclGLs71JfBqxl9tHAUugN2VFt
	/vBIuYsh89x/sWCL9O6rD8xBVQtpWddSUqb2MMSiECEWsdroMuq26E6oQjGHPzYIIlg+hYZtdTS
	hZ78rYEf3G0F/m9ALx15RJYxg9tOAbC+RBVEYIEIPZW2j0mtFXD5/uE28zw9Ghk7wHpeR+/hhXb
	BEpd0cYC6hXWebzBKQ2TmuSAqUylOPs9i60ivvFstJlwHfY5GoYaGn6sovDiX2vfaWqy6Pn8T7r
	RO+oWud5iJ5SE3rv1nVDdq2OYmBxU+uDGswT+kJ3MNyYS/JEexX0ewc0Ae5qKgzSigchobQVT8s
	V0vJllING8gxhsZPjEhfX8iPghSxMCfDBxrmNzW7ZJDeRLMXtI0hVHDGAcAHwNxl3WiBoXAEx8a
	x6FUU5FR/5FO/UfMJBcJUlK2bqfZVHM25rhh0=
X-Received: by 2002:a17:903:2c0d:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2d0535b3b1amr6778865ad.7.1785525043987;
        Fri, 31 Jul 2026 12:10:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d04aecd727sm1776365ad.23.2026.07.31.12.10.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 12:10:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so2281982a91.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785525042; x=1786129842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ctX5/PlGpnsSqXnuJWEkPuJVtc0OEcWMRB+axFw7igI=;
        b=e7VCH6/eGkF3zMPLmnucRP6dCFLKlg5PPSpSP8M7LwaiTSBHQlAw21xv3uk6Sy/Ehb
         +f6YvzYrtc+zF2owrtbgpf/Ba7q0szoqpixcqh0my32/gVXH7rNlmI8q8OgwFcV2txCv
         tClCH2NHSkYMO8UNP/nYkDFHIF1BPjhKCwLC8=
X-Received: by 2002:a17:90b:17c5:b0:385:39ac:fe4b with SMTP id 98e67ed59e1d1-38fb263d5admr3120660a91.17.1785525041908;
        Fri, 31 Jul 2026 12:10:41 -0700 (PDT)
X-Received: by 2002:a17:90b:17c5:b0:385:39ac:fe4b with SMTP id 98e67ed59e1d1-38fb263d5admr3120628a91.17.1785525041449;
        Fri, 31 Jul 2026 12:10:41 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8667714eec.10.2026.07.31.12.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:10:40 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	Keegan Freyhof <keegan.freyhof@broadcom.com>
Subject: [PATCH net 5/5] bnxt_en: Fix PTP PPS setting bug
Date: Fri, 31 Jul 2026 12:09:37 -0700
Message-ID: <20260731190937.807270-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731190937.807270-1-michael.chan@broadcom.com>
References: <20260731190937.807270-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

The existing driver logic is always turning on PTP_CLK_REQ_PPS
regardless of the "on" parameter passed to bnxt_ptp_enable().
During shutdown, PTP_CLK_REQ_PPS may be turned off and this
bug will do the opposite and may trigger a PCIe PTM request TLP.
On some systems this can trigger a PCIe AER.

Fix it by properly configuring PTP_CLK_REQ_PPS based on the "on"
parameter.

Fixes: 9e518f25802c ("bnxt_en: 1PPS functions to configure TSIO pins")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 5d41dc1bc782..b89293dfd2d1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -495,12 +495,15 @@ static int bnxt_ptp_enable(struct ptp_clock_info *ptp_info,
 		return rc;
 	case PTP_CLK_REQ_PPS:
 		/* Configure PHC PPS IN */
-		rc = bnxt_ptp_cfg_pin(bp, 0, BNXT_PPS_PIN_PPS_IN);
+		pin_id = 0;
+		if (!on)
+			break;
+		rc = bnxt_ptp_cfg_pin(bp, pin_id, BNXT_PPS_PIN_PPS_IN);
 		if (rc)
 			return rc;
 		rc = bnxt_ptp_cfg_event(bp, BNXT_PPS_EVENT_INTERNAL);
 		if (!rc)
-			ptp->pps_info.pins[0].event = BNXT_PPS_EVENT_INTERNAL;
+			ptp->pps_info.pins[pin_id].event = BNXT_PPS_EVENT_INTERNAL;
 		return rc;
 	default:
 		netdev_err(ptp->bp->dev, "Unrecognized PIN function\n");
-- 
2.51.0

