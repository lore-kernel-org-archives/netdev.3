Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773977;
	b=jkret2VujSvhH4mNL5DxdY+PHlITOGfM4wCaDQG7bkUQX8srMnSvz1HRZVFACXkMP5WK
	 UoWE595DVMRYHOZo84FK/DkPSjJ6sq+K3E2kBl0mAGFHXkq4NfkOYVLYgk+b3pDPvm+Z5
	 vi1K2SjTb4GvaJdYwD0ORyE1Zxarcrdv53uHmNjkghLHUQmcl1cN+6z4wfETF0CMOl5e+
	 L/cm3htKNczJBkOTT2d+PexPHNJSMeSCQRpB0ykIqLMskKEug08NYURs6CujX3g4OlIKE
	 yHrNfvnHH+RW3oH7WnjZjlOoSr5UkuBgf+FTejswdUqsLEEunCnkUJ3/abDYBGFVC9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3aaNxA+Y80f5W2oIEWGHyfzyjcTvu4C9UEPW1tV6LQE=;
	b=ptwbvfH1oxfOPJeFEKkEiJw70ZEHn8LPS52IajGUUA8SwTPjmlxutdQLqJ4JFgSlN2k7
	 hy+h5TzIWzY4ao+cMrfhq/ZTWZ1huOiuq98KRqpVwidNyAk3gqRafIoeL8mTjb+v31iFp
	 meoHF2EFxdej820dqxW2hhH1McrL3ZVKH6YRinKfmM2mfKvDDN42r1FxyFnODFai5thp3
	 +8Q11dpk+/xfSmtotRTskZcTKwVVyJDaWZLJgptOAlYD2Q/KIEdCdAfV9J6Kl6JL+dJ+D
	 HGOkzn+WOnqho6v5xELcEfPsbEEiO0DAURg9FF67WIxvPkw7WMpQVtOcgm38BsxS8Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ox44oH8m;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534F606A32F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C534F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ox44oH8m
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso216795a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773976; x=1794378776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aaNxA+Y80f5W2oIEWGHyfzyjcTvu4C9UEPW1tV6LQE=;
        b=ox44oH8mr058i0miWerj3EmnZjHQtouQjtG/I2FLwO27N5lEpBV2MNi850DLMHzvoh
         Ln0uwPXCoEHhGW/db4tWmAa4FhQUaMg7WLyM0JzW11IfELPrvxa5gg81vYXHNSw93ZuV
         3NmrD5TyL/i1ptZ5Jc3/4eBx4Y7szq+jeDndIMTkhdwMn6OYVdc76+U8N6d35QOMgRqW
         ZgF8lZGyb3ObO/eMf91JRd/9b6Dlmxx2Mqc1A9I+Xy9qeVSrSYYlZduxkeX0WckNrOYu
         DwS0bTgNbjNcRJWONoT089aJcBL414fGZOwTwncYVr6MDVyj3FooJGV82E++YrV57lHM
         a3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773976; x=1794378776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3aaNxA+Y80f5W2oIEWGHyfzyjcTvu4C9UEPW1tV6LQE=;
        b=Bs7IAfaT4I+MX/8QoW9e5VZ8ngM7C+Swu+KRqck2py2PpnV0oKh4peUMJj64aMHIi6
         VDlim8Wuf6m92GchYq30rfHoZVYAyaF5KHbBfT+/DTgsooftQnOEVqtyxn3zJOfdNUPE
         YZ+/oBcCj9goYA9OHUMeLyLMpKCAlQuvFqgWqHwslW90qkgBSl+cu4qhgfK9WBxGV0ex
         8efpTmAOu0sVdUzmh0GUMo8NKp18o2ADYjuT2yW7OZLG5CpUaN0m+bP8Jlx81OwZtj8f
         cGPc1JX3VkGDQBVh2kbv0D4NQOMriUTejrrT1TOA/abxrr/dhImyFfzopC8ZP1OBf75H
         t/2A==
X-Gm-Message-State: APuU4Z9vxU6XWt1p5ZhcorGlLBnRyS5Q11NEJXJxGAMwIpU0wbyZonR3
	BKHLJaBgXL250fwIcHxDCjE+obRFIClzDZOyIs/L6bdAHhIdqlOjhy3B
X-Gm-Gg: AYBFou2eUEFfiXS9TKIBnx4MLdsnC0K5h8FGU61xvOTWe6+fM+ID/zFYPeu2XsyEeyk
	GEEEACxojKIZTaVYGQvHRR02HJYlylOyWP5YWggZKI8noTSz2LpnFue+b40PKiU/qBNy4WYkbc0
	b2z8pyQlYmCoWIOyMaFyHAMlLVsMHSbwTT4iEnAmhD8yiwCMJz+9JKIEDCiA3xmklOVosdXls/x
	EwJWHiN2ztZ8OVTninc4+1GduOYMGuqqfin4hOC0tzNguLvdPg3c+zB4trQhz0QxZz03AKOA51D
	ZPbuEu1Ls7ypRgRmJeWmbui+NRkOnqHSZBWueV5XA5DYmKWMkCiHSdRDnGEIuqZLaNCR7q6T2oP
	6MH7L13P2uBr/2qNJMGzj25KhDIZI6X0CLUuVHbkJJ3fl5RswWHd1rE0LFytTm7/DdAYSrRQX3r
	9DOjfH532zTXmlVk72z0zS0zELLb6D7r9X9IySYyEvZItXl1cDVdbieQiCrhRlKxVL3O9yohO/Q
	0eg6EHail5el6dHe7VebD9CtEwz1IRAcxMlGUoZAKnn7gcxjLcO9oDkbAwt04Syd5t1T0AWSeC+
	JkEdlH/nUHkeUPJ3WxWyfgfUjq7BqklodLZ7xMNvn81P99NLeeOn2inz
X-Received: by 2002:a17:90b:1b08:b0:3ab:884b:65ab with SMTP id 98e67ed59e1d1-3ae89857dadmr12874069a91.55.1793773976084;
        Tue, 03 Nov 2026 22:32:56 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm2583207a91.17.2026.11.03.22.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:32:55 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Snook <chris.snook@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/3] net: atl1: disable work before freeing the netdev
Date: Wed,  4 Nov 2026 14:32:43 +0800
Message-ID: <20261104063245.23402-2-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104063245.23402-1-0xbeac@gmail.com>
References: <20261104063245.23402-1-0xbeac@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atl1_remove() frees the netdev without disabling reset_dev_task or
link_chg_task.  reset_dev_task is queued from the interrupt handler for
link-down and DMA errors and from atlx_tx_timeout(); link_chg_task is
queued from the interrupt handler when ISR_GPHY reports a link event.
Both callbacks dereference the adapter and the netdev, so a work that is
still pending or running after free_netdev() touches freed memory.

The original driver never cancelled these works, and the current
reset_dev_task was introduced when the two reset tasks were merged in
03662e41c7cf ("atl1: fix kernel panic in case of DMA errors").

Disable both works synchronously before unregistering the interface,
then delete the PHY configuration timer.  disable_work_sync() drains a
queued or running instance and rejects a later queue_work(), which a
plain cancel_work_sync() would not.  Deleting the timer after the works
have stopped also prevents a running link work from rearming it.
atl2_remove() cancels both works and deletes the timer before
unregistering for the same reason.

Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
Cc: Chris Snook <chris.snook@gmail.com>
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 2883e9462f..2bd35c3cfc 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -3132,6 +3132,18 @@ static void atl1_remove(struct pci_dev *pdev)
 
 	adapter = netdev_priv(netdev);
 
+	/*
+	 * reset_dev_task is queued from the interrupt handler and from the
+	 * tx watchdog; link_chg_task is queued from the interrupt handler
+	 * when ISR_GPHY reports a link event.  Disable both before
+	 * unregistering the interface so that neither a pending nor a late
+	 * queue attempt can run after free_netdev().
+	 */
+	disable_work_sync(&adapter->reset_dev_task);
+	disable_work_sync(&adapter->link_chg_task);
+	timer_delete_sync(&adapter->phy_config_timer);
+	adapter->phy_timer_pending = false;
+
 	/*
 	 * Some atl1 boards lack persistent storage for their MAC, and get it
 	 * from the BIOS during POST.  If we've been messing with the MAC
-- 
2.43.0

