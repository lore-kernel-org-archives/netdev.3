Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262578;
	b=xQZ8QkfJLdDbSkVOxAe5U89tAL5n7Lysi8vI4HmjV40EzwfHXRviv00r9oIY8h5IwW/I
	 qv2egWiVtRiOZyYtmwE9DHK0lWxv8rh5N34cEtxQ3sUiNuFjYmQNu7tGsBrFFpWWqIw52
	 DRFIR4nkgtKzGrLpr+B7xu/FpsR3V/Bz5bE0nat2GEe3l19uhUiDOWgiygQJCweN3V+C0
	 5iISg1xwnkygJ/Obw8ieaUsp3byNheYO0H57E82Q6r1F/oPLeFLvO/zDfMCIdHnvb0P5T
	 jJ+IBMqJf0v1vsNEB8MkrAR0oubFbbJu6nwZF63DkhrrZvZ3N3GuZQWZABnFDeyJrVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jOkt8eUrlOmCTGKi+IBj1g+BGAtzeO5q15Ol0c8Hric=;
	b=k04HOEQ5FcV/nzluI5136wGI2Zv07vxs+YaC+Y/h9Oi8ux0qoKl1xWg5lumcaheTsmRd
	 UwK3NjbmN2I+QHcQ/X97v6DUIFUH/qHYzMNYO+wldRJIj+DeKUiAMSVeJzfA0SuWh4GZ9
	 F6gAMUT4dUebRDFQj15iZxba4wvuvjNXhRF1uxrpJRnqqD2VThn47EHN1B0e5Lkuha+Hz
	 At/+lZijG64k2MBMpbyKB9CTPlGk0sgyvevUdcszwJhuoeWekrmsqasaFT3d8PGWImuaX
	 z15t56D04PZRiaLmIkuWrh/YzAL/TBNGLSyQlOwLHxyc3wpNK5iUP3W1cO9MWi5GJRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TxH2Nv9w;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C1606A324
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A06C1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TxH2Nv9w
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a7a3b29c11so2029565e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793262576; x=1793867376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jOkt8eUrlOmCTGKi+IBj1g+BGAtzeO5q15Ol0c8Hric=;
        b=TxH2Nv9wX4NId0No6LBCGfNvUZ2HHK0eY3XNMVsu1O+tTEDpVxoaU49a4T9NHpEg0w
         tYscu3LoXDs+XsYbGgxclZiq1cfwRkWIXGyP5/F/8RsOcgW0Po0kDwvZE+7nRiikRyov
         YBEdvhCfweiTytMstcule7eL2jqFC0pyE0hn1L0ZfcHLjr6AA8Ys/kbfbiCm+V7YWLPp
         oSPeiGoHzkL0sxeTyan88jTN4c3NXVutjRC3uSHknp+U/VjfLhBRcM7nP/LngerK58pB
         fu3Z9fBcgyRDx0Ho7D1XrlOw5r2mWdD8C3KWkM6bN0IOdScpZL05c92AgIYNw3XF0L/z
         8UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793262576; x=1793867376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jOkt8eUrlOmCTGKi+IBj1g+BGAtzeO5q15Ol0c8Hric=;
        b=R/TiJZO+2aatqhh2JcPYfY4S/OgWgVnOyU5v8Iy74sgQFv78843C2aLdknLbW0CPbt
         ONEh4zUSrBUpHVXEmCYYRYuzdMsBUNL0KUXPbY7hKpugBXfNgHRJ/eNKCQgnUe9tqfG0
         aBmN/nQ4XUAN+kbtADJKNs2/gHCTx4va4gQfNRV4dvlMmBc76itYLqOTGpG7GwtqX1Oq
         5CVwrr+Gbc+/1A3evCbT0NAnjP8pw5m1s5hpTFch7hhyVY07XtTLGiT97j250bkGEtpS
         2ubbEMEM4ZC+LczM9x7IiOKRn36kRLjmqH1skFgQD+VyxraLKoT1JwtdZ+THOYBvQkYU
         hCiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcN7mA1NGPn9ClwrN42ABd8M8K80N2mPxt1EsmmU8b/9dU2bxVCA4izKtgSLyPsdm2ASmCp0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvcn7mtmf2DgtqZnLyTneS7gXTPMSgcX2eU4jSPA03lxJKCR9p
	UI0CKpW/itzt679pt7mtpgNrznXopIPZpMwNE5KOlj1p38WOIkXJyRZJ
X-Gm-Gg: AYBFou1zWfcNvearPuzmo4m7Us0AdXuG+A3iRh2tEMeFBBoxYaNyWqOC6QtTMH+K00p
	tV9ckapZ6aJdsBYZYgQHLs1Pu9WPhG5uC4JDFtOqApUoX8g/xB85oz91dP+2VD+LfsirA1vqlmP
	lOV3jg4Nzu1TPNzvxIW5olBXfR8KQTmL+xTcjGUwoaN3D/jeM0cxkJld5xcVsa7GRxs6iSqs5b7
	iqo9L/harhW2zkYtszY5UQsVWMJ/f2HOjDMo3BhyCDZoIRMnm/bc5HYBeMpEsH2cvAB9OColgrk
	+HYy9GHOSb609xiYNd5PKgvL8YfhYvraI/PkCm9Hy5bsiN2197npY07KnpFp5Vk0Fm0uDfTUCJ0
	60g8nCG+rQJhmaw+BrcqNGS8W6NuFKFrd2nDPR7HB1istx5oTY2l7+ZZZgIXiOfvhdhxgcTC9vV
	c55XsBXGJO6XRfqXlpsbPCkBhM7AqjKw4KFklGJa/1urmmNLNOTQVKempStHo9pZEmsm05iFkGB
	v9va+PrjAy3YomL3zDoEGAIfW56a0tTfKj8nJBnCiwx0cmRqFIxCzVzjPAF/RjXLU39BsZp8tyy
	SmmSXNYOyjjtrifz98Ej9y7MFCy/rOMjbiXyXZFCnvLVAfm7F5U=
X-Received: by 2002:a05:600c:c3cc:20b0:4a0:1f9e:5f78 with SMTP id 5b1f17b1804b1-4a96179c9d9mr77845395e9.0.1793262575720;
        Thu, 29 Oct 2026 01:29:35 -0700 (PDT)
Received: from thomas-precision3591 ([2a04:cec0:10c7:3c2b:5f0f:ba7f:8641:d1f0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f4cdbsm55170455e9.7.2026.10.29.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:29:35 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Alex Elder <elder@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:QCOM IPA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net,v2] net: ipa: Fix double free of the interrupt structure on  config error
Date: Thu, 29 Oct 2026 09:20:55 +0100
Message-ID: <20261029082100.17722-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Since ipa_interrupt_init() allocates struct ipa_interrupt in ipa_probe(),
the structure is owned by ipa_probe() and released with
ipa_interrupt_exit() on its error paths and in ipa_remove().  The error
path of ipa_interrupt_config() still frees it with kfree().  If
ipa_interrupt_config() fails (called from ipa_config() via ipa_setup()),
ipa_probe() unwinds through err_interrupt_exit, which frees the same
structure again.

Drop the kfree() from ipa_interrupt_config(); it should only undo what it
set up itself. Drop the leftover initialization and cleanup of
ipa->interrupt now managed in ipa_proble() and ipa_remove() of ipa_main.c.

Fixes: ad1be80d7582 ("net: ipa: introduce ipa_interrupt_init()")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - Drop ipa->interrupt initialization and cleanup.

 drivers/net/ipa/ipa_interrupt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 131b9cc94201..766b094eb069 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -260,10 +260,8 @@ int ipa_interrupt_config(struct ipa *ipa)
 	interrupt->enabled = 0;
 	interrupt->suspend_enabled = bitmap_zalloc(ipa->endpoint_count,
 						   GFP_KERNEL);
-	if (!interrupt->suspend_enabled) {
-		ret = -ENOMEM;
-		goto err_kfree;
-	}
+	if (!interrupt->suspend_enabled)
+		return -ENOMEM;
 
 	/* Disable IPA interrupt types */
 	reg = ipa_reg(ipa, IPA_IRQ_EN);
@@ -289,8 +287,6 @@ int ipa_interrupt_config(struct ipa *ipa)
 		goto err_disable_wakeup;
 	}
 
-	ipa->interrupt = interrupt;
-
 	return 0;
 
 err_disable_wakeup:
@@ -299,8 +295,6 @@ int ipa_interrupt_config(struct ipa *ipa)
 	free_irq(interrupt->irq, interrupt);
 err_free_bitmap:
 	bitmap_free(interrupt->suspend_enabled);
-err_kfree:
-	kfree(interrupt);
 
 	return ret;
 }
@@ -311,8 +305,6 @@ void ipa_interrupt_deconfig(struct ipa *ipa)
 	struct ipa_interrupt *interrupt = ipa->interrupt;
 	struct device *dev = ipa->dev;
 
-	ipa->interrupt = NULL;
-
 	dev_pm_clear_wake_irq(dev);
 	(void)device_init_wakeup(dev, false);
 	free_irq(interrupt->irq, interrupt);
-- 
2.53.0

