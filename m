Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD592FC881
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291149; cv=none; b=kRpeM998dE2sqBo1ofDNohjXVW3R60dKjsmB9NaIkJZtBnaKN0WtxuNg/Jk5N/lynXuPeawnGDlp66qmcHM8sG73CwiUonTzUXAhpb+YuoCtu1eb+yLDOn6TIujYXVBPrxzD8x00pA7F6USxQHP4HYPMaulRr6I3R6kQL6M07Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291149; c=relaxed/simple;
	bh=4WtChQ/QU+gA3V13D+0Xu72gZs69AnOhMz4s0cRfWH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBGZN9YGH6YnswinPliABLjS/HeQXc5r/yGwe92DxqfK5njPHHFzGoZD+3lsY9GoOKLkdW6wWtHrOtcD1gsjr2gW0OHIj5EtaSIoT+5EsugZ1klKv+sDnIY3KDSad7zryh3jsmB/up6LwnvF+BhqF5mbZZ8/+dpqvCBmP7qeeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=HMozXIB2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="HMozXIB2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab077e3f32so14341065ad.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291145; x=1774895945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLwGXFLtuJ9cDWhdalbhm3etGoACm7cTjmdKCjTFcmc=;
        b=HMozXIB2rChSL3/4svtSTsXf6wj9KKcCkh2E4Q9iGDkgVEvMpWpXjBMAamrWTz4bfL
         wXvYuEfetx+web0T5SVv2vi0XLirYf0Y/NhGAMqX+Wk97s05mTyoT0WrtqZJ3Xoasikh
         3wcLhmdYbQIJtvBc3XcHM8rRn46llCOfnxSynQqr8x9zXreNh8AVRaElLVL96ZsO2vSA
         tX2nnCs5yDFIoE+zkdfNe+z0QEB0/GeXdzRDnNW3DmIfLwTB1CKT+USvzYNF7SK2itv0
         j3Bq/97xOTeB1aIy/mLXDJsS9mPfVZbxXvM8DLDa6Mww7p4WimLhyc14wtdbJV4QFnuW
         Q2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291145; x=1774895945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLwGXFLtuJ9cDWhdalbhm3etGoACm7cTjmdKCjTFcmc=;
        b=fmhBqT5stOvJe3x0NQD0gEtTQs/oJUwx7biq2RzenmjEDXDCfQLSgWocFQtJi5gJsC
         Fygnd52qChRa6J1CIIenppYkpmZjDMhrlzqb7mr3mzRuiRnioTG35GTNFtMQSFs69Z6b
         PQhzJCuL4/jUy6grte22/E2CzyFWsEcBErYv0g9p7/lOCj/nAGzqOdF4DDuxYXvNjwi8
         zv9sOaPWgow5hRkH9Yosd+l2/DjaspA+yV923V5o7TVEDnookonKpPgAf2ViJya5dx8k
         JxKh5lY8typ3GNuurlPxEcLXDqYJeqG+q88VPPW4apKzLK4+Awn6e2EiJB3M2ySViUpi
         mj/w==
X-Gm-Message-State: AOJu0YyPTh0X9YVBrr4XVPq9/LW5wUD6L8mjmvOn7CIYhiEzbwl2Hm6F
	QKL4sZ2bxEFz+c2T8H7m3tt2RpOa4NYFv8BSXGHz3gZjkVJYe6u2CZ7h5J2sACD+fJpqN42RBBI
	h00oBY74=
X-Gm-Gg: ATEYQzw4shNnd9UddonbFSmq3Q19zOd3kWyRire1N+EYDfVxZ41BH4kP+izuALkj3Kh
	wkgdt4vhC0Tfxvct14xIH2LWYvAA73re7v+PoWNwgtZS6f+oX5OfL5+5Yn4/gMysLml6vh+XpZ0
	aZ+6qdG0p/3Ap6aoKaNiPjgHhorAukG3n6AikcAjjNmZTbkqYXfrF7Qups8JcLAKww+1CaZS285
	uBDd3tlHrzC4e2xQiK6ET/ViSv1PGEN6HjXzDEJ6CIPt279a8fMMEiI8g6/GTN6KoTRrHYyeobF
	8K3oAVdO0gnZ3l8z5aQVLURUR2llR2hI+U/SlLOUD2P1P6TTW0voLfQg8damTW+BXcSrwyT5GOc
	IgwiKCWEq887TZOyz6oxkLJRs8aJb599MN3a/l7ms3V/B56H0WLMpt4/pGpRYrIFt93XW9dcdlE
	KoNnDv
X-Received: by 2002:a17:903:1b6b:b0:2ae:bf92:5acc with SMTP id d9443c01a7336-2b0826ff359mr123141045ad.3.1774291145183;
        Mon, 23 Mar 2026 11:39:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083527f90sm114602505ad.19.2026.03.23.11.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:04 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v5 03/12] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Mon, 23 Mar 2026 11:38:28 -0700
Message-ID: <20260323183844.3146982-4-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export bnxt_xmit_get_cfa_action so that it can be used in future commits
which add software USO support to bnxt.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 604966a398f5..7793ba59bcfc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -447,7 +447,7 @@ const u16 bnxt_lhint_arr[] = {
 	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
 };
 
-static u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
 {
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index dd0f6743acf5..d82b0899b33d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2950,6 +2950,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
-- 
2.52.0

