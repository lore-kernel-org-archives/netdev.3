Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACB83C1966
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536691; cv=none; b=g4lU4cqGkJj5gMAguY+L4iL7HZU55TTKLt6v5TrEnI8g/9Gfm7VsIe6lDfLoapOpa6V2ugXH5xASUObtFWXbs3eKmnv+YjK8YcuWpjkpbtp5AsTi2KRjmtFVxkqG26HoYQOHodvuIIJurBAEDsQCLD34Fuok56Y7sDidrax6HbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536691; c=relaxed/simple;
	bh=l4i84PKR2XfXpPetEwc9C5l680POO9YxAJH41F03t0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDFdxjBYz0LLu/hffp0oqPTCB3tADQryV+ZwNbDPOQcTaVaYHXgmdBTpeMEqtGElP65H4T05V5UtK9nxMh4Ig1g/pfA5F39w5+j7Ls7o1x2k08x2l0U2hC/uFGFBvl/aHesyhxIpMAOPF2W4AK1bUVp8fjItF71bfMCXx/7fEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMHGLY1s; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMHGLY1s"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so402051a91.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789536688; x=1790141488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIE08YFw4kaft37+7mxF/frk9TC2//zqhyYMu0YvGkI=;
        b=AMHGLY1sTO1OvpAgVJo8euKs4P1A957RqR6Q+rWrU7Jh8aVBmHCFm2q4zrvEvWc/5m
         dFExyh+6hvjNQyk2bLH42ckYhgFRiG0blMWelH74ujeiy2wASffZpPmTQhXb1eDI1p/Q
         YLb7YLjbuqO2TCLinrZ73VmRXqxw99FvQJ8I6P5+AFND/92B3+HofcKgNGTYSF7maESH
         s9+6QdNATx/F37qJ3baVk8CrTu3Pw6wxa9MO54MfY8G0U9jlsplq10fe3pCQXzxAJOiA
         75SLTlisoQK+cEcMHX5qcSQ8pcY3EREgxXa7FPDegQ+6kFHt76tOYmx+TzntCZJscn38
         bpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789536688; x=1790141488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIE08YFw4kaft37+7mxF/frk9TC2//zqhyYMu0YvGkI=;
        b=UBEMPwv/iHG9HIi9rXEF1IcGqzTP5bPIrSBBZv2yctgSOrVINbT1vmeWSV6vJMua/n
         HvfAZtQS0wNSGZZUQqJHaRebtylDxw4FlvIUvGtmDSfeKWFNMiJPXIZF1h8jc/8KDHtd
         zYx23jEmHHyPSrWGb9hH6wgmtClTNqkCkZv860mm8uaEqgcAq6G0eVAFlLB68Z692F7a
         X1ObyR0/fsHDLopW5JlBg4v7lDET70/97/gAfU90wx5q9scB87bWlcqn6FyydX22JB8c
         6+xtavmPWiz+Iwa7jsWM2E8GK84gAhkJ2CMwkSDr55X7mN3Ws6dle0CVwADzK9HmRQFO
         TCXA==
X-Forwarded-Encrypted: i=1; AKwUvByw+6M/yhYOzKUCDqNFGnX5PfizR3c4uT4F2lvQJW37xpkQEM9ao90B6XRumy5u8qe+Pg4xfK8=@vger.kernel.org
X-Gm-Message-State: AFuF++nkq6InR36iRfZWIW3Wl7b8LecQuOhY/1SEEcL4O8u2/3wCiluL
	Eu5YV8PFPnilN9NJA1lCztok0xc1345XxHac7Sd1REEm73mADYTQF61Z
X-Gm-Gg: AYBFou3bEh7/FUcZ0S5datxm0d+2bnz49c2YkMAQSmifMuLxmhltlmJO4iPElUfRf72
	nVqNb3QTkSWyNjY5rHcUBgd21RoVbPnVbl2YeFgJOCF7I/MIdWNgwt7gTxuYTrV6OT7+8+qVPTb
	5TM23txJESV2Dq/iWdOHFHHSISz1iA392G12kTCXtWPK33DgwXSeJv04E+RWtgOPavsSBDhxO5L
	ifh1azWT7pEnODX3ZFStxA7UlLQQokWozx9MD2wW6Vx/1WeNdTEm4oLBZYh+O+YUSJWwluNVPpj
	HrY3fNnWFBqbvrXZPdNHu/ZimAvU+xB9XFXc4yvhz368MeJFSgLuAE0MKKQxsGtFSqBQUm5sFHq
	FvYMrY/9fjP9XcuVdwxWxtIf1WOe842gyKMuZ8GXATBYz7KWPfeR9mXGwrj7uLvZAPtu3Eb1aPQ
	983+0qWT9FLXWe6Onxvt0fSd3m0IvDdN9GKaRKXG8T9DouDEu9umTvXg==
X-Received: by 2002:a17:90b:280a:b0:39d:f60b:8121 with SMTP id 98e67ed59e1d1-39e1e4d39damr3369964a91.17.1789536688567;
        Tue, 15 Sep 2026 22:31:28 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2504124a91.11.2026.09.15.22.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:31:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Shannon Nelson <sln@onemain.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] net: ionic: free VF resources on remove
Date: Wed, 16 Sep 2026 13:31:17 +0800
Message-ID: <20260916053117.2906446-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ionic_probe() allocates VF tracking data and maps a statistics buffer
for each already enabled VF with ionic_vf_alloc().

The probe failure path releases these resources with
ionic_vf_dealloc(). However, after a successful probe, ionic_remove()
tears down the LIF and device without releasing the VF resources.

This leaves the VF tracking allocation and statistics DMA mappings
behind when the PF driver is removed.

Call ionic_vf_dealloc() before deinitializing the LIF so the VF
statistics addresses can be cleared and the associated DMA mappings
and tracking data released.

This issue was found by manual code inspection.

Fixes: fbb39807e9ae ("ionic: support sr-iov operations")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 05f19489ec5c..666efe972de7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -424,6 +424,7 @@ static void ionic_remove(struct pci_dev *pdev)
 		ionic_auxbus_unregister(ionic->lif);
 		ionic_lif_unregister(ionic->lif);
 		ionic_devlink_unregister(ionic);
+		ionic_vf_dealloc(ionic);
 		ionic_lif_deinit(ionic->lif);
 		ionic_lif_free(ionic->lif);
 		ionic->lif = NULL;
-- 
2.43.0

