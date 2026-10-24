Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792831581;
	b=e6Gq2CVBlWhDyc1cYbnfZUSaZrtIjQOJVYOkQZQ2sRYF8nsqW1mnAvvji4ysQD30NSRr
	 hV5n/f3+mjNgCTwYGRPz0cDt/Hoyml/+KPmd5E+c4KK2N++YTX+FtjSPOXC7sjcQzXo2y
	 FIhfneR1ZTvZlQVPfRlzsoCvDKFR+/7jm7iOW9uvEMuUoqzUPQGNhsF7INuwnxN4gTEo0
	 8c2M1vh6kBgdJcpZ8+rp5pPuDdZg3HXbqapID4SavDzv0gtIxJID9Z1QHGYWM2adykRPt
	 NQC33IO9GTGI09FGpgtJTiiTXipVivuUBInUD2+70Nd5OmVybzR/bAv0dtHhChS6X/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792831581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VcwFgC5lVsHSbW/ej+cAGy1X0tEOwMBM8cSBGLupnzo=;
	b=VWnbIsXPl3i63MOAsUgmtZqf8R3B1iRiH4t6iLNcXwpLkAI9hcB9AXcQMMYo2QC78Hwj
	 CigL5jKu7wfSQ5uqHPoi4xFNqyvWd8fJcmo/NvJqUuFlyzwEe7VqHNrFKZIHjcAuRduQ8
	 fRZf9ogOa15AMUegcZ5AiWKJ0rjpVt8eh3H0PYfoaKnPWC8rLVnXmiYgHX1MO3cemdvdN
	 99ufZIS1K2swOibMybAYnu7n3Mwg59GtSoIqE4KfdcPQUHvseYvV1yDSPeBMiDJKN3qnZ
	 Oav6jilnoVi6880V2R4f5xqsPjr7utSeoGk7bsVi+qICyuJ6+qegx0GJNAl7ni3p/3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iv+cuac4;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5E606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA5E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iv+cuac4
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e10a70540so912960f8f.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792831578; x=1793436378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VcwFgC5lVsHSbW/ej+cAGy1X0tEOwMBM8cSBGLupnzo=;
        b=iv+cuac4Mpwnskit760iQ7AyyUCigTOtw7zZS+Fudv+NRmIVyuZrpMyyKV0EwEaZxG
         p8/ibiwHkQxMuf/cRLJ5wME3cMEQBJoXNXyzQ+frGnuEdHad9y0Byv+nSqDCcYHXXwUv
         /qRI09AEirEvKH1aHUg4TbzbopxvNv9AB5rs2qwjR3ao3Urc7BUUGFRmyH0cH5PzJcQr
         LXM4GeDA3mgPrsMcvURsqjeGseJI42LDEa4p7IMrtyoz/2v78hh0j2Rw8TG5MoZdXp0o
         aJGEheWhTK5VQQz8UBQQAPAj2at+bgOXUZxlXiQysyWWIj+yYIudNB6HsHfhgiOqXrTG
         vowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792831578; x=1793436378;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VcwFgC5lVsHSbW/ej+cAGy1X0tEOwMBM8cSBGLupnzo=;
        b=NP9PWtjkL659jWQWOFHC0CqvzwdUcsnz/4zngXdPqGWZtaJSJnUzWMm9eDXNB8Uw9+
         aiTdNQT5+bbRcBwPUdD4yaNht2YFRh2AX9vvwAIN2gPG13LkgEWmaCh4B4/DmQId1iDS
         MwePCxWqYmR8OsyZPs4Tddpev/bPtD9IPE2TyR0tIZuWASdm0GOr7/CQ6Utp5V6J+ntz
         KKO4rXFHBaKxiFof3iDIUvsyO6e2NLAAJ5KMWOe33T2BAZQDxfN4Y2N0QmL1SkVQ+Uee
         if82L6BF8pOeKmlnoeG31t9AHUzi2MAr1Z7jZuwaE/ixIIlQ9e+dmQmW2jPWWDOiQJsd
         34VQ==
X-Gm-Message-State: AFq9FYJFxrpeZ7M++nj0E3R4dvYXYKkA6RaxOtatker8o0+eZDjLdij9
	jzm+fPzx1DFUvmkKK5Q7iX4VCoU7SzL5TAWLS514J2A/hi8zoIAhGFvuX2lWZvo+
X-Gm-Gg: AYBFou1QDWMrxkYS6fTj4uLpXOTQUE8/zS+u+QlOMObALkAMiuF7SBbL8WiHeHRehNh
	hKBID30DpjnPIcYImudvza4FWTPn+cW1XHbeoV4jOJblk9pTDoJlAiQFuImAItWi2aEcj2Qqe4C
	tjz929YQw+AFUTj9Y4WGtlFV5T6z9mo8nL45qe+wBr6yP6EHHtcYRvGpFULjBf04rLMHkfKRJj1
	jyGxwsEWv1uvpZ4K56LJabJhK9l5LCSmThZviXZMTGC2eJYSoVmyvfbh4d3c4rO7Bw6R9Z71MF0
	049zyCjNDGimHNJSf6TVq0Bea3zlCeWHD4Q6/0cXiOvHPny+aRAVufWpbMNyffGQbGehSDYvOOl
	ksI01d/ASgGQ1pYPtKI9NxUikq5il95ETuGI/Q6IRVDkee/P1pAJe0C3hbta3QswlHpOoTJXadM
	BPkBUGRZc4Z5lPyyr+29k6OnmhXgA5dw/DX84p/FAYMGOc2IFdbZFU2auOJru0QSyhX/ru3f31k
	nuoT6GUumNaMwoeR0AaRXqAzrzzSwEWPJ6Zy0fh6o5BO3LBgrxxdQ==
X-Received: by 2002:a05:6000:2a85:b0:48e:476:99fb with SMTP id ffacd0b85a97d-48e3eb7f435mr1278544f8f.22.1792831578058;
        Sat, 24 Oct 2026 01:46:18 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3662sm3481217f8f.40.2026.10.24.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 01:46:17 -0700 (PDT)
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
Subject: [PATCH net v5] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
Date: Sat, 24 Oct 2026 11:42:08 +0300
Message-ID: <20261024084538.256596-1-omermetekaya0@gmail.com>
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
dequeue operations with rxq_pause.lock. In usbnet_resume_rx() splice
the paused queue into a local queue under the lock, then drain the
local queue lock-free. In usbnet_skb_return() use a double-check
pattern under rxq_pause.lock on the slow path, keeping the normal
RX fast path lock-free. Use spin_lock_irqsave() to match the lockdep
class shared with other sk_buff_head locks taken from hardirq context
in defer_bh().

Discovered by Sashiko, not triggered, not tested on real hardware.

Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>

---
v5: Splice rxq_pause into a local queue under the lock and drain
    lock-free, avoiding lock drop/reacquire per iteration, as
    suggested by Jakub Kicinski; fix reverse xmas tree ordering.

 drivers/net/usb/usbnet.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 84f97f448b2d..97a30dd22c54 100644
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
@@ -698,13 +703,20 @@ EXPORT_SYMBOL_GPL(usbnet_pause_rx);

 void usbnet_resume_rx(struct usbnet *dev)
 {
+	struct sk_buff_head q;
 	struct sk_buff *skb;
+	unsigned long flags;
 	int num = 0;

+	__skb_queue_head_init(&q);
+
 	local_bh_disable();
+	spin_lock_irqsave(&dev->rxq_pause.lock, flags);
 	clear_bit(EVENT_RX_PAUSED, &dev->flags);
+	skb_queue_splice_init(&dev->rxq_pause, &q);
+	spin_unlock_irqrestore(&dev->rxq_pause.lock, flags);

-	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
+	while ((skb = __skb_dequeue(&q))) {
 		usbnet_skb_return(dev, skb);
 		num++;
 	}
--
2.56.0

