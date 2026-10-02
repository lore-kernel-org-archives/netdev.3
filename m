Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637D33260B
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905618; cv=none; b=eJlMCCdmRCQm3tLeiR9jjw8RGXZAfzdbJ5OZr5XsOk2QG54kVKDl28k0+mePu68k3QaCTsDSbCyzVagJqwyNCLXDwnN+GATvEIC+vEIl5rMLSxnJg4C3hOTGdfH56KhPRMzzrqSYMH6kUeG7iLySyebuQGDySRNwiEky8+K6m1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905618; c=relaxed/simple;
	bh=+LmznV4vqKZKlzaALnt13HVXmJnjozQyZpMusn1fuJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXqf+HxYRkDozjV+BP9C6XHQvwnGl5+p4z7GQJr6tA96vIlZqu6CVFlIOmR37v5yFpAv2eRYuWf16KedlYv6P1WXRAvNdxGH9KrC7nBt95FOp4/G25jnSt1QRHX0wK8SDGo2+p9pSgbkdFL0nsmAq37jj2S0BvOBzi1NbRgvB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCAbVkI3; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCAbVkI3"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f38so32668845ad.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 18:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790905617; x=1791510417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3tFfU5pIfaYR6a5rnUAElWbpWv0wF5OoVzykxSyz4sc=;
        b=BCAbVkI3ZW8FnTYkj5KuF5FHW4hTOiPWQ9epZMSKQn1ChrJ5gFpBjoKcQHcPISeFvu
         4xjSIC3Xr4A1QziHB0i5HgOoEVSkrpoSRRlwUHPKHSc1WFX/tFQavKkPNmG0grN5z+kz
         otdgEWJfnzyGYBsfilEhQBYPejS/8r5jpJeoW45QNiHsA5kzDpLwEZTEcVeue60+rcGS
         MoB+EMGdaQWA+DQ1t3slSR3X0yj9Cbarzsle4WmRKXOGeSipfQIQwd366+hz1uiTAQtq
         4rftgixlFTM6+1BHtTyjzfx5LAYYpPLocwfdm/XaC1cLB+qfGYwda8w4aYoyb8noK4Ds
         a6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790905617; x=1791510417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3tFfU5pIfaYR6a5rnUAElWbpWv0wF5OoVzykxSyz4sc=;
        b=mV+PxfeNl1IYLvtWyPvwHLGC5lLksOdzmJHgBGCpitxKumAieV2NG0QW+IRgwZFwh5
         YHgYfC+p8eMi+cKqIHABRdWGrwuIW0LVZZw8MwBVwjFr5s6tpWiGXGDANXJqTjLMVgK9
         4i5isa8ikKl3oTgbkrX68d95b55R1CqNDno1TcoBx8W34z92ubKUlIOvl+Q6C7DrXSce
         kVhKqfqDE2qzm/uPDyLgLwWOYd9k5z9dUL8QB88fkmQpdibgj8N4tSk68sIlz7S97O78
         F2Zk/NSmmJd+dDHFd/1Yi61J5fWRnOA6QJt391WXz+YPurGVLlbZEuZe1ekELLkdjS6g
         y2bA==
X-Gm-Message-State: AFq9FYLqTjNbQYdaMbCuuroOzX7Be75M8kh0t70kwbLPoi0VEG33rCdN
	gECu3oXgwOCc66i3U5cxvfdb1PS2aqboHMUy5+OmAGQQzhOSdRvEVgj9qPxtYa8l
X-Gm-Gg: AYBFou29MutRMTjUGlXGoUn9zBlu0bmhxNJlsIdf14OpzI/jYLv55HeZ14dBjNcEsB6
	g3f+tsIVUtMSyQ6+FaHC0HTSbKEuNFVN3lTVUYNuOLn7HzFi3C18xZUyiW4W6Ulllc4XeRqbrnB
	ec/MLGVXYGIOmV6Oju+hm8IfxR1974W7QA5ZZoeK7YqqNmgtkIA9kdv4NiE6cvTlOxNI0QuFHBH
	+8/wbrLq/ySyI41coy3S4C/eLIZ8NTp8ioptS75HUD2DKaFXkizMePuDr/KurtOzmzGivMgqudE
	5TL2IaGa19qbdQxKAmQrzwG74wsJqxJLp7Bn224WO0JrD9f6iOOvMVCWg1dYvq1cJsU61iUXr6O
	hME6OeULPWmUmIIBpR3+1b22IvGG8r3qWX8sjyufvaVK/cRvWCoIn92YRi6loRGHwjcCbiqjEE/
	8LgoB4/uKoQLWM+Gp1ULZiJu6MKa/Jld/tIlhVMfVYwEaNemPqf86bq8Tl+hlcX+tTmVGaWzBEx
	b28FWhAz2rbHqP8JBU/cVGjMebKKLA=
X-Received: by 2002:a17:902:e5c4:b0:2dd:ad73:5b6b with SMTP id d9443c01a7336-2e49b6808f6mr11142355ad.27.1790905616570;
        Thu, 01 Oct 2026 18:46:56 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ceaedsm2675645ad.49.2026.10.01.18.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 18:46:55 -0700 (PDT)
From: Tim JH Chen <tim770802@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johannes@sipsolutions.net,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	chandrashekar.devegowda@intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	linux-kernel@vger.kernel.org,
	tim.jh.chen@wnc.com.tw,
	Chih.Hung.Huang@wnc.com.tw,
	Tim JH Chen <tim770802@gmail.com>
Subject: [PATCH net v6 1/4] net: wwan: t7xx: fix runtime PM usage count underflow on -EACCES
Date: Fri,  2 Oct 2026 09:46:35 +0800
Message-ID: <20261002014638.47981-2-tim770802@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002014638.47981-1-tim770802@gmail.com>
References: <20261002014638.47981-1-tim770802@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t7xx_dpmaif_tx_hw_push_thread(), t7xx_dpmaif_tx_done() and
t7xx_dpmaif_bat_release_work() treat -EACCES from
pm_runtime_resume_and_get() as success and proceed to access the
hardware. That is intentional, but pm_runtime_resume_and_get() has
already dropped the usage count it took before returning -EACCES, so the
unconditional pm_runtime_put_autosuspend() at the end of each context
drops a reference that was never held and drives the usage count
negative.

Only balance the reference when it was actually taken.

Fixes: 46e8f49ed7b3 ("net: wwan: t7xx: Introduce power management")
Signed-off-by: Tim JH Chen <tim770802@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  3 ++-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 5af90ca6e063..0e1174ee611d 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -1082,7 +1082,8 @@ static void t7xx_dpmaif_bat_release_work(struct work_struct *work)
 	}
 
 	t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
-	pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
+	if (ret != -EACCES)
+		pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 }
 
 int t7xx_dpmaif_bat_rel_wq_alloc(struct dpmaif_ctrl *dpmaif_ctrl)
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 236d632cf591..bd6116a8c541 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -160,12 +160,16 @@ static void t7xx_dpmaif_tx_done(struct work_struct *work)
 	struct dpmaif_tx_queue *txq = container_of(work, struct dpmaif_tx_queue, dpmaif_tx_work);
 	struct dpmaif_ctrl *dpmaif_ctrl = txq->dpmaif_ctrl;
 	struct dpmaif_hw_info *hw_info;
+	bool pm_ref;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
 	if (ret < 0 && ret != -EACCES)
 		return;
 
+	/* -EACCES means no reference was taken; only balance a real one. */
+	pm_ref = !ret;
+
 	/* The device may be in low power state. Disable sleep if needed */
 	t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
 	if (t7xx_pci_sleep_disable_complete(dpmaif_ctrl->t7xx_dev)) {
@@ -185,7 +189,8 @@ static void t7xx_dpmaif_tx_done(struct work_struct *work)
 	}
 
 	t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
-	pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
+	if (pm_ref)
+		pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 }
 
 static void t7xx_setup_msg_drb(struct dpmaif_ctrl *dpmaif_ctrl, unsigned int q_num,
@@ -467,7 +472,8 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 		t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
 		t7xx_do_tx_hw_push(dpmaif_ctrl);
 		t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
-		pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
+		if (ret != -EACCES)
+			pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 	}
 
 	return 0;
-- 
2.43.0

