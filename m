Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076F43636F
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604617; cv=none; b=DPpojuJCX2eHxoPys+pMXuch0DSZXluk/ir9hvbZRde595Z4tWB8elc68fOaYLT/UPNN/qTdFidpwDjEB6vfT1N9cBhweB9fjiwicT6ENFb/IQTuaBzzBk+tw4M7fgv4LCuw61dU19MJ11Q2mtiakGXLD8XxPWN/ZJQr3A3sQG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604617; c=relaxed/simple;
	bh=uzXYv5SaMaQDxMG6VgWPySzJIVbasUl5XEm2P8yHpGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U28i5xBK+thq+KWFi+8nm3gqjur9jOAfkigAj/fYFNpZsT8pBrEdiTHLaGTU5orzXi8aKgl7O9cP6fNCgn0zqlSTalJ/BCeDlUveRHWvvKy9IpKDTnBT4SqVY+yRERNxpYbxNYFliolXlnGM10m/4hDXtzU6p3wNIZSuKctkCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lawd5phv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lawd5phv"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-842848fd613so3794758b3a.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781604615; x=1782209415; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rgXck3qhvoJPxsaGkk1pMrxcKj77tOWzD/6bHjBzG1I=;
        b=Lawd5phvUBOUpFePSkG6DFAMetQgCPnSpla+UOAoX5G4/M5TbNF+7gw+2gIQ3aWXRd
         eW/4UmBRXJuuwzK1C/MbHHyLMzY211hetqaKtY8uYLxzXfmiO/juBTHFhkZaSXPigW8Z
         vqz9EE/nGCw2Gru6qNSkJ1/v6ym/gjvEBML8hCYvKMue0IL13Yy2rCs/a7GrzQ5sYV7b
         i68tUqqPYq9yPv2l43J1yqBeef1wLXYWG5aLI8W8TUK90KK5ApaghWIJiNaFyZGetGMd
         +Sla7car0KFqxIPPV1x763CFKCEspYF/eVeMmW+at7Fqg4v7JlbYTbs24ym2lUbZopAc
         ZHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604615; x=1782209415;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgXck3qhvoJPxsaGkk1pMrxcKj77tOWzD/6bHjBzG1I=;
        b=aXtaqeL49s3KHagafRjG9Kkslps/HhUDv8N2op1nrqQDB5/jtv86+mk6DLPLJ34nzp
         xKN9EVcpMK4VCxURYG/1pN1kjWh928c9Fx6rldhFRy9kGINRsmMuOZmetaFKq1cmgr4c
         PSvLvXTU3YjK556Wcjerrppx/cx5XjZnigsuRuZFX8KPu2Yz94v2mNbEFJrGGjGritzj
         zjlb3Dtnq913tDyAadVFJt2dJlH/rOFhFXTotmJkium6yKpxOnJrFxq/pWrvAeYIEgwZ
         AGDWXW+sqf2rdNGQjlRqLD1qL3xnstdwG/4YmFNwAODRZUryeCggiw9XNtEuhfPTC14V
         yi4A==
X-Gm-Message-State: AOJu0YxcfaktD7o3BPG4PPv0bt1qG5rAo7A772meWSL9ho30hH5/n9fS
	DljpvD2/DE9HilGBfiEIWNv0XLc/YjVbDJIvDLN/5GB61KyJ5a2qeBUhbmpUruK/iBFb+Q==
X-Gm-Gg: Acq92OFyOsoLy2MaeUrxuHTcHoSAlCHRF/qTmrGfrlnTv9/+omckdjSRTjGpEMcg8hE
	qIW20FDwA+B+vFRn/TJmylUHxplJlXLeEXCvgSKFBkphOYzu2vLCbk2kA0qPpyrv/VCt1YKBnTM
	PPwW7+gKL18UPQUON3mMFp+2R5O26fIvpZ6FE207FHKjAJD204KwXwgDEsxbT87sWzMtHShNAAf
	AVGEg0B2cRK3NswBoSRaYGqGT/XKTfN8KqdZaUW/i5XkSDejIKhSDuzFgAD/z6OM7IpumrpQH76
	XIEfr9Rl3VVAtHIO5VUetgJA3BH3CqTdTsVAL9Z6f4HgRZYHS607J+jqKzimTH83I9dHJE2IOIi
	M8sGbcvTQ2y0k42w6rPM8w0l7pckRoFWgQfJxEFv/VVcXZyq53cPiW1DoLdsuFG+Zb/OXDE2+dl
	/mimeHlT0v777wfqHJ
X-Received: by 2002:a05:6a00:1151:b0:842:6fac:bd3 with SMTP id d2e1a72fcca58-84515556183mr2848320b3a.28.1781604615062;
        Tue, 16 Jun 2026 03:10:15 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm12396943b3a.24.2026.06.16.03.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:10:14 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] net: airoha: fix foe_check_time allocation size
Date: Tue, 16 Jun 2026 17:49:03 +0800
Message-ID: <178160461057.2154221.15886112443159132305@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

foe_check_time is declared as u16 pointer but was allocated with
only ppe_num_entries bytes instead of ppe_num_entries * sizeof(u16).

When airoha_ppe_foe_verify_entry() is called with hash >= ppe_num_entries/2,
it writes beyond the allocated buffer, causing heap buffer overflow and
potential kernel crash.

Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 5c9dff6bcc..8fb8ecf909 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1578,7 +1578,8 @@ int airoha_ppe_init(struct airoha_eth *eth)
 			return -ENOMEM;
 	}
 
-	ppe->foe_check_time = devm_kzalloc(eth->dev, ppe_num_entries,
+	ppe->foe_check_time = devm_kzalloc(eth->dev,
+					   ppe_num_entries * sizeof(*ppe->foe_check_time),
 					   GFP_KERNEL);
 	if (!ppe->foe_check_time)
 		return -ENOMEM;
-- 
2.51.0


