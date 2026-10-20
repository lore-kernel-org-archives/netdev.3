Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510276;
	b=qKgVZAVFcZMLyYQgYqmXu+rbOW2Xxeghu4ds1XLsbAZL6dN6RMJ9vRzprUEEUISrKpt5
	 i7g5g7R2Vdqr6IkW02HwUmyk9chqmTmpckbFCxvA51gfuTlO/BBG6MyGFU5oC08LieHRm
	 2IiQL4gf0iz7ByW19N0MFz5q2p7dUmdF5vmGr056olKIbVwWFEZBT1lOgKXCdlo8P7RIE
	 ja56gX3s72wRh856vusqvC3XMEC0z183fyB+SiDPdelyfw48Ypq0iAUoxViMQ2uJ7hwZ6
	 nBJKZ974VbBPURBXf4frIfnuv6QkPFx/RYHfBqTQnYbq3BWJ4Krc+sMvRR+tw5aVUWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qsoSLYus+M1tCAzqI/ZNpAHRrLwoOIcxK2qsa3BkpZs=;
	b=GpoFbiEaynoGojYRLeMapizSRtDk/6NBtHc6kpc+45Lnp0p5Ru49CP1QyWVXheRyHOg5
	 qjNFss5oRb3qDDi2Cu7j5wihp1z1BNBR0rRdsVn/nu8OljfiIvda4H+swsMr/vXDhs2hW
	 9sda5MBg2jvMNor0giK2Px+TCRGTcV66/znJVbv3aFyYPf4mEtoXCao2PidiSeWcYi4dB
	 fnN8EaD/E/CE/cN5/xknxOnnkktcP1y8KgKWkkHiQkz1pKnQuoSTOTG4H3tExNCA0Dc9M
	 N0Ar79lhaLXOe+7X1Xr/iquUtnf2jKxgd3mI751ivZeQai1wXjQuQXwN1O8OYJBacOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p9V+we3v;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C3606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E85C3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p9V+we3v
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so9760935e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510274; x=1793115074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qsoSLYus+M1tCAzqI/ZNpAHRrLwoOIcxK2qsa3BkpZs=;
        b=p9V+we3v1bSecIybHxsxM454TeWmuCMmdqKwv724cigxeNMU3C48odpzjFjJVRTeuL
         FdahkGhmGg8Vk3aMjbUQmF2HnnyNM2EqVvVCpp2HqJ/gO+vzYMtAOXAedCsninSfZ/18
         S2phVMfDFEDnoktgmtMqyo2/jQqZ3p1FRPKIUOP/iB6dn2ND8eSsQ8SXotGJUM/GKjah
         UnQoE2JoO+FdD7A9g7At9H5ZIKELCyCPHnJp1/NIN2/CMQn9INRy1FSs450in2BRz0Zj
         MG0qOD1Fx2YHBke7goite6W1MayeX+DniL0xoCuKveN4maA3IMZaFfaU/8U74tH7GTjv
         1Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510274; x=1793115074;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qsoSLYus+M1tCAzqI/ZNpAHRrLwoOIcxK2qsa3BkpZs=;
        b=Bd4V2ZG/m12dN0J9HAJOeyJCMu6LEr6wjuQad+FdWqjlYj5WVh/f0R5ImdrhebLGpg
         jrwLPYDPWun/kVwe2C0G9h1WBWJJrtnF8co54MxeLp9W3acdtA/6wjy+f00yyuWU9AG2
         Pq9Kl72X9uZNAvHJHV3J8b6PjFIoCkzD+e9VRS0zdBamrE/OcJJa2anV5OHDwJ41W2rP
         VY0oMbBtI9GX2Sd3bCNO5YsjYSN8fNJKiM+ncky4m0XbpQMYpvqKcmdXL0uo37BIYK3G
         tUYVoIzEe0NxI8i3j5YqmzYnCofo+Mlrz4z4v3iLyC1wF895oA+8DyWci0jknRvNVH0o
         OM8A==
X-Gm-Message-State: AFq9FYImCrvO4kDJl+c3Zy1HqS018KdUdW5P/PlEGsUgiPOAOxPIyRUv
	XuQkcOehpkD6+KTgAiRG33psCSeg0rtn/MQm9oQdqBKthCS11suQ34g8sjyxhpeX
X-Gm-Gg: AYBFou2rYc5coP0HsmAVaMH74mu+lufVTG6yPBK2sxM9nAfJJUFcNOH9naVI2tmdZ4l
	s19S3Qww0QLPsURJY04oKc0DPCsT1piKpE+25T5Z53DxkofgS5KGYhDC08K9XJc/e+6vax9shwn
	3Qk2Ia44WHMj9zSRg32fXsHbUjo4C2h8UxC1QdJnC2y0tehIIkI42toeVy2/bdyt7dJBZLNW7kg
	ZMJpMCoMCQLe7U+G1WLKvAC7KpK0oTHPfXWVtP7UH74To5r4LdBIXLwDBgj4Po2Evg/BmCyN1jf
	COCygon7K937mO0fy9T27YuTyThsW24YeLBVlGFhbnATRntI+W401Op/V9Bo2XyHAmeNFrxIs+a
	Tb+kodFXdmXhIP5YvL0fYVkh7ALyzB3d+9TciIg40vVFH3KVIr1mSJpW6sDAhhZxQNNsxEvrdMA
	bQwix1Eg+r8JHPwOtf+drbc6JL6+hzhGjle0Yc62Jx0RUvB6fepbjyn87Q6SrNm8RiikaU
X-Received: by 2002:a05:600c:8b2b:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a1f4c80374mr69433495e9.6.1792510273908;
        Tue, 20 Oct 2026 08:31:13 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d818c59sm7271629f8f.30.2026.10.20.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:31:13 -0700 (PDT)
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
Subject: [PATCH net v4] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
Date: Tue, 20 Oct 2026 18:29:09 +0300
Message-ID: <20261020153044.18828-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On SMP, usbnet_skb_return() can observe EVENT_RX_PAUSED as set on CPU0
while usbnet_resume_rx() clears the flag and drains rxq_pause on CPU1.
The skb can then be queued after the drain has completed and remain
stranded until the next MTU change or device stop.

Synchronize the EVENT_RX_PAUSED state transition and paused-queue
dequeue operations with rxq_pause.lock, dropping the lock around each
usbnet_skb_return() call to avoid lock inversion. In usbnet_skb_return()
use a double-check pattern under rxq_pause.lock on the slow path,
keeping the normal RX fast path lock-free. Use spin_lock_irqsave() to
match the lockdep class shared with other sk_buff_head locks taken from
hardirq context in defer_bh().

Discovered by Sashiko, not triggered, not runtime-tested.

Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>

---
v4: Use spin_lock_irqsave()/spin_unlock_irqrestore() to match lockdep
    class shared with other sk_buff_head locks taken from hardirq
    context in defer_bh(); restore local_bh_disable()/local_bh_enable()
    around drain loop to preserve BH context.

 drivers/net/usb/usbnet.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 84f97f448b2d..9c4a23d8cb86 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -329,9 +329,14 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 	unsigned long flags;
 	int	status;

-	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
-		skb_queue_tail(&dev->rxq_pause, skb);
-		return;
+	if (unlikely(test_bit(EVENT_RX_PAUSED, &dev->flags))) {
+		spin_lock_irqsave(&dev->rxq_pause.lock, flags);
+		if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
+			__skb_queue_tail(&dev->rxq_pause, skb);
+			spin_unlock_irqrestore(&dev->rxq_pause.lock, flags);
+			return;
+		}
+		spin_unlock_irqrestore(&dev->rxq_pause.lock, flags);
 	}

 	/* only update if unset to allow minidriver rx_fixup override */
@@ -700,15 +705,18 @@ void usbnet_resume_rx(struct usbnet *dev)
 {
 	struct sk_buff *skb;
 	int num = 0;
+	unsigned long flags;

 	local_bh_disable();
+	spin_lock_irqsave(&dev->rxq_pause.lock, flags);
 	clear_bit(EVENT_RX_PAUSED, &dev->flags);
-
-	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
+	while ((skb = __skb_dequeue(&dev->rxq_pause)) != NULL) {
+		spin_unlock_irqrestore(&dev->rxq_pause.lock, flags);
 		usbnet_skb_return(dev, skb);
+		spin_lock_irqsave(&dev->rxq_pause.lock, flags);
 		num++;
 	}
-
+	spin_unlock_irqrestore(&dev->rxq_pause.lock, flags);
 	queue_work(system_bh_wq, &dev->bh_work);
 	local_bh_enable();

--
2.56.0

