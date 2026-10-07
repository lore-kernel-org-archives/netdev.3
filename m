Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C232D2381
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410610; cv=none; b=ftI27mXSbs7GAmpHTJ+bDFJsghH8Ps9bSVP4QGbZUKHejpb0againmKEjR+PqmomVP4HXduuKZ0xnTraLMu7slhQl4FjwINrs6xLXjFeJAbd6Vd3xL3mpXzIRJDp583GOyVqNcFf0c49bUSa7Y1vJpNHKWjZEG/ePi5U7djMFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410610; c=relaxed/simple;
	bh=tke7slPNWOX+7ELjRSDZ8oPCXNvkKtFXU3e3mtWBRDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HQMx68H1mn5Z4KkeOqKd9gFOYH64m11MB9KH37D32p90LpfSzRsDf0OXLdHzG2NsbAacdgXWKRrKS0m2WzZcJnrrp8tIzgpY3s3CKGodarNKDDFnLDUQ3RZlAcJV7FQw98JFN/GzX5NmqzjBy2KW4sIT/iXT+yaShoreHVJ3C+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2TjBLq+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2TjBLq+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so11622275e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410608; x=1792015408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3vc2Iva4KZFpZlvP0+4NbjFh7c9GdaXKEPiQjjCtn0=;
        b=n2TjBLq+HnVXJfrTRgNaGdBF7+GWtHebwUzYdETmnVxyzf8jrbmMkwpTUZ4tE16o5w
         QRjdiPS1Sp4qUEzxBXnQKt8VNornqq97QKbI91dn3R5ApSYEWVBVIiul+XuuMNyOc0Fk
         Xn7hBSnp7zuWvQg5TIhKBXSNIMYByjUJCl9c0TZocO3f1fKMzxNVucRg/0qM4JFmVg4n
         iZRsP0SyC8ShZG3IDc0TE7VO0MbaVpQJXnIhJ4w3U5wXVfa992FAE3PzFUZsDWQ0C5Rv
         xKS0xE4b7Iy+jkjSi9fwDn510TKCBCj1Ezdi0ObzJR9sd6T1jJof/g/XkqdVyaLlxfnR
         R+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410608; x=1792015408;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u3vc2Iva4KZFpZlvP0+4NbjFh7c9GdaXKEPiQjjCtn0=;
        b=KwAQwat1eyNdVtS1QwumcopANaW0QFVbc3VwsBN2KkUVPc9VWn2uGAFi6iPkh75gAT
         jZDrf5oPViWobSHNFWza7DierugkN12Fb2g0iZA17mso0Ab133SD3IesNdYuKusHWllX
         xUbbbTJdDw9W28cr0Y+sgRhuWdZEOCwzD3avwDMjPqvRdb+sKv6oxSKjmPxo5I/xNysU
         09D2ZI+g/XAJzUebVNJsEC5SX2lqHHs53dTSqCVgoPT0oQC0CBrNSV3cEhUz3jATiGda
         W560j89GyQbemSTo5KIvqllGBTXbMRhNle89iFyuwICVwemmkawzmyuH+AztbK55uTC1
         rX8A==
X-Gm-Message-State: AFuF++mLG8qC6A6ncPjIjhzDsO7FM7IiF75qzhQdK0Kb3vYTh87nWwT/
	EWKDj/7CbNLT8QT3SEqGY1nrxv7RBwkpAY3P7wPiIUJqnuY05NFLj8KQ1ilYwroG
X-Gm-Gg: AYBFou0MywATwizwh31ku8hWD3izhtVZ/y5FE0ChMO+x/3Tm6OeR3RvPfjpxXSkNxs3
	ihaiT51gFq6k+1G2o8qIZwqPPk4NAjXDcXWqy+VM0dTQ9MdZceIHSl2AVuRrFUVxDU19t+f5Tvy
	5Tr+brc6KW23qLj+VU5oxcB664vDtzZMTNqFV7aKmMw9W3hgePEqPy1hDnDUzW/Lbb+HDzr/q8b
	ywWkUagI9FvR7mC79vaGjakIwKS0ZmAIWW6YzR1TofKc9v2af1txvx8V0MVty7o3H3b6MG980Uz
	fuz8swTIAbrJ+hbBF7fzwIwr9wFe+V+12bCzzXK4ljlnws7NFoN54aR6SfujUzHTIzVbCaHzTvA
	U+pSmooEzduNgc5lPlikUnVgLVgALnl8NOBpq1nMhCVE2heWxu4EZJolZaEiGYD3OOtd9syxSsf
	UNB9MmPl/CS7HPeCVm25EFVfBmqSH4FZeVMQeBZqdRxM8Jp9AAgbtr5V3JuiVC0n1XerxA
X-Received: by 2002:a05:600c:4fcb:b0:49f:bd3c:bc1b with SMTP id 5b1f17b1804b1-4a1804557f1mr54545795e9.22.1791410605701;
        Wed, 07 Oct 2026 15:03:25 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f493761sm144404405e9.2.2026.10.07.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:03:25 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: netdev@vger.kernel.org
Cc: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH net v3] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
Date: Thu,  8 Oct 2026 01:01:00 +0300
Message-ID: <20261007220311.113827-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On SMP, usbnet_skb_return() can pass the test_bit(EVENT_RX_PAUSED) check
on CPU0 while usbnet_resume_rx() clears the flag and drains rxq_pause on
CPU1, leaving the skb stranded until the next MTU change or device stop.

Protect the flag check and enqueue with a double-check pattern under
rxq_pause.lock on the slow path, keeping the normal RX fast path
lock-free. Wrap clear_bit() in usbnet_resume_rx() under the same lock.

Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>

---
v3: Use spin_lock() inside existing local_bh_disable() section in
    usbnet_resume_rx() instead of spin_lock_bh(); move local_bh_enable()
    before queue_work() to restore BH context correctly.

 drivers/net/usb/usbnet.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 84f97f448b2d..d138d353fd98 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -329,9 +329,14 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 	unsigned long flags;
 	int	status;

-	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
-		skb_queue_tail(&dev->rxq_pause, skb);
-		return;
+	if (unlikely(test_bit(EVENT_RX_PAUSED, &dev->flags))) {
+		spin_lock_bh(&dev->rxq_pause.lock);
+		if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
+			__skb_queue_tail(&dev->rxq_pause, skb);
+			spin_unlock_bh(&dev->rxq_pause.lock);
+			return;
+		}
+		spin_unlock_bh(&dev->rxq_pause.lock);
 	}

 	/* only update if unset to allow minidriver rx_fixup override */
@@ -702,15 +707,16 @@ void usbnet_resume_rx(struct usbnet *dev)
 	int num = 0;

 	local_bh_disable();
+	spin_lock(&dev->rxq_pause.lock);
 	clear_bit(EVENT_RX_PAUSED, &dev->flags);
-
+	spin_unlock(&dev->rxq_pause.lock);
 	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
 		usbnet_skb_return(dev, skb);
 		num++;
 	}

-	queue_work(system_bh_wq, &dev->bh_work);
 	local_bh_enable();
+	queue_work(system_bh_wq, &dev->bh_work);

 	netif_dbg(dev, rx_status, dev->net,
 		  "paused rx queue disabled, %d skbs requeued\n", num);
--
2.56.0

