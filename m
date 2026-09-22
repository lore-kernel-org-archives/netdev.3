Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13B35A3BF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041573; cv=none; b=iJJFuVbotr+8LcmJyIqaNUVSFiasHODGcm0cNDdcc1dxXBLGvol5XgTVl4ES0kKoEKmeyK+uGuyEduxuES3zTlzwQ+O8DxvRHrEmh+YP+/GfLW7D3GoCaSvqd2cfPxQcAfHzs6xZoXMM58/XKHCQzwAXfTHZ4DrdCAVwnLTpsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041573; c=relaxed/simple;
	bh=y+XAD1bzLlPmvSg9e/3OC75RDcM7A3CrfnaE1zi3yj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flUmuNvS6RM3Ss32y/udA7xKhykEJt65fbP50v5vCDGtmV+3LzI3Cds5Dro3T1Tbt0EqxZFg3Lk9ht3rSE2vMYkJS8FyaHWUxc9uZ9AQknBvd8QZxo62rshJ4Qj0fVCNeYIKIXdYsJXT1gk8rpdUTtY2SYoKI3w1hz4Va3zNPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwNHhgDL; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwNHhgDL"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso32043516d6.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790041570; x=1790646370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8xPShnnQq1RRm8SZPF19MXAMPQrqUo2Z2vKGdJI+3o=;
        b=NwNHhgDL4rP/C/q35BW5E+4t4rw7psMkxYpIWrRf7Rtw2yYmiE82xVbc7x9E69lbgL
         ccBJ6OPJkKusO0h8nCldSxZwLhojVaYSsXxJ5jf6JRHSk45SlmTy53ncHVocjs2pXq9e
         ji//CEeZUuuSUtYufvXJ4IVhufQN6gA6Z5jRHqZ6nS8atrvq1Zf/yCmeVbThH2PSobvG
         TMQS7qBTvmSJpMEZqfkudm1R5GpPeubd/iL0Gkzl6KFr/BAdbX/+YrLtfX37x7Afgf4f
         XdtRwkyY7O1UjXwHGT5CoK2lvrgXIP+17QaR27EcEuMtfiw3ql8KpKDbsCf9jy4dMoI7
         Us5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790041570; x=1790646370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8xPShnnQq1RRm8SZPF19MXAMPQrqUo2Z2vKGdJI+3o=;
        b=P93wj2/x7I5+A9jTW6pOIEJaLNPpBvPwz/n7OOLm8+4cweplEAXE/ckeD41Uz0RCxm
         /n7EdTBbFZcDYQQ67ifB0h4VIrWgzUuEFeHmV8PF7CTqXCrEgK/xjO81gRdq9ZCHjZV/
         82dLXWPmMtzbt+FZV/WC4O5MqHmzlu8X2AQpZXfgp+T4JXx2mmzs5mDh4J1EnUhRWPY8
         AH9PNXiHKmCmI738YNGmmlRM8cocNmGxUA0hw6dVJn/kANVvAUtQY9DFOspUCs2eec04
         xdm5KeyRIULP8jJFqlijABzAvhgl7FRNMnUg7JnHsFAm2fUDSSzO/bYzT+FWcTnTO52t
         mU1w==
X-Forwarded-Encrypted: i=1; AKwUvBxrx0mYBDavtU0GTrXDK3CKCkw2OHxc0CBJItp54sAGlS3Q+QB0Nf9+VCL+XmaPUjP0UuyPeiY=@vger.kernel.org
X-Gm-Message-State: AFuF++mDU3ZUMeqVK1mWnVbs4R4x1xMgfoJv76M2VWL7nCU7kd9oOVzJ
	xiFJsjjFgc1+9rtB8xvM76YbY0IcdSIztp0u9khHgqZcjLNE9OXfyKY=
X-Gm-Gg: AYBFou27fRiNazC55KMLCk4dbXOkG0ghmHY4Z5+OlQzKVxr5km5d3YBJEKDSZq0cqj7
	O4QgR2Up6HA4VcSmOD5ycoNt/OiCeXUoFFvF+0Gh97v9pv/WJbdKmugF55pW3RNhNdLNXV1QcWK
	+uhsS7BhgDtPy8rsq/szrUGIhrZmtFfe5pcxtuv4yqPEUH0eHELMr0ZqyMhadC8kNizgZauD+pL
	GSKbLc2vFuvLvfNwj/ZecpNbm97MDPASU01f7/FjjqKxpzUQaa2nWcL+xIwKVo+lYjmg6h/vHDp
	Qjf3w973eZVs0dzEGY0ZqCeegog9Y2wGzjmyozeFdaTNLFJpv1q7rIZjTJffbIQUI0Cc73HFL71
	1wVW+IZ9ji22gW7Sp8Anw5g93B4v+xJ6WRpSCM6FzZvFjfdIhMDmU0NCkSp5RkgRJ/eMX0wmVOa
	qrwmxDKOwK21HVKVVE67E/T0hcoTPC8URfedymMb3QAvJelhoaIHw8RwEis5NliQE4V5AACNBuO
	SHlwNJvadgaMtjxmjYY2atr89n+/LdXZ5LoMQ/rVyWFABghFOImQn6fKD4morFrblSXBMDBG+t9
	QlAf9wiqYzrF/CDL7M72OUqLZLgm
X-Received: by 2002:a05:622a:1cc5:b0:532:c925:c31e with SMTP id d75a77b69052e-532d8d34820mr37916871cf.16.1790041570399;
        Mon, 21 Sep 2026 18:46:10 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e17123casm1228641cf.3.2026.09.21.18.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:46:09 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: GR-Linux-NIC-Dev@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] bna: prevent IOC timer rearm during teardown
Date: Mon, 21 Sep 2026 21:46:05 -0400
Message-ID: <20260922014605.588040-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bna: prevent IOC timer rearm during teardown

bnad_pci_remove() and the probe disable_ioceth path call
timer_delete_sync() for ioc_timer, sem_timer and hb_timer, but not for
iocpf_timer.  bnad_iocpf_timeout() then takes bnad->bna_lock after
free_netdev() has freed the struct bnad.

Deleting iocpf_timer last does not fix this.  sem_timer and
iocpf_timer rearm each other: bnad_iocpf_sem_timeout() can arm
iocpf_timer, and bnad_iocpf_timeout() arms sem_timer from
bfa_ioc_hw_sem_get() when the semaphore is busy.
timer_delete_sync() only waits out its own callback.
bnad_ioceth_disable() can time out and leave that callback live.

Shut all four IOC timers down with timer_shutdown_sync() on both
paths, so a later mod_timer() is ignored.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1d32f7696286 ("bna: IOC failure auto recovery fix")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/brocade/bna/bnad.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index 8b75004ba7c9..55dfd4896785 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -2571,6 +2571,22 @@ bnad_ioceth_disable(struct bnad *bnad)
 	return err;
 }
 
+/*
+ * The IOC timers rearm one another, so deleting one cannot stop a
+ * sibling callback from arming it again.  Shut them down so a later
+ * mod_timer() is ignored.
+ */
+static void
+bnad_ioc_timers_shutdown(struct bnad *bnad)
+{
+	struct bfa_ioc *ioc = &bnad->bna.ioceth.ioc;
+
+	timer_shutdown_sync(&ioc->ioc_timer);
+	timer_shutdown_sync(&ioc->sem_timer);
+	timer_shutdown_sync(&ioc->hb_timer);
+	timer_shutdown_sync(&ioc->iocpf_timer);
+}
+
 static int
 bnad_ioceth_enable(struct bnad *bnad)
 {
@@ -3727,9 +3743,7 @@ bnad_pci_probe(struct pci_dev *pdev,
 	bnad_res_free(bnad, &bnad->mod_res_info[0], BNA_MOD_RES_T_MAX);
 disable_ioceth:
 	bnad_ioceth_disable(bnad);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	bnad_ioc_timers_shutdown(bnad);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
@@ -3770,9 +3784,7 @@ bnad_pci_remove(struct pci_dev *pdev)
 
 	mutex_lock(&bnad->conf_mutex);
 	bnad_ioceth_disable(bnad);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	bnad_ioc_timers_shutdown(bnad);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
