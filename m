Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794120582;
	b=QvGM/J+hRylPLsBQXi3gHMVa5ktZPASUSpWzbA6F+g0oKCc6pUP4trqRziIPod1VsCHJ
	 lUACQrlrz28DEzwMVvZUqqnpsbPvj2VetzZqRONjQeNFucWEww8Wg3foUqhLIq0Krgukt
	 nEYUk1n3mywm/6kUko60ZMYs2Urfq0qFwAQNa4qTu/lDyP7ox+sg3u+uQURyLQ2wDC8Bp
	 8ZX3zzeE0SGKSGHWLfUKSMSLLjdctE8T+ip19S+AB9UxJgBf01eWO/sLl+8Dzqqq7YGBD
	 /8b6r++0Dw2CA0BknEa8WwkQa7+5y5mJbreKWeARv8to1rH5BP7UUUrz8OHfwDFE8BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794120582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x7Z+RUwPNkJfYSyvADI+2XwTh8BlG6SdiyklPwWIP7I=;
	b=kdhon3RjIqkHOj+HXsPZoe8uyyUJAFQr6mBzn0JMN8Beoraqke2rPeWzsUBJ8vwKP5mQ
	 tu/79n47F4qNHQlWfrTcRQjxiN3SvQRA21vjrctRzgXW9ruZqz94EFraKu32Rg/oXm2Gf
	 T/N9Zx9Q0ey/kJSm8u9mS7r2scq1AvvwxtnYNhYzXWFyi59u8NnnPYeHH97lghJGCk/5H
	 cPvuIbpQpOmd3SAIyDZS9GgTMjwhc7SQPj4VqU8bgs7MBsjO4BuJcedK5F7VzDy980vm1
	 HRUWJvs47hBeaUFb1dI3hGSghj7lWmjM4EmsnslnwdZn+FMIR2S/eqedeuNZTkLKMow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ6EVQFZ;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E9606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 06:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ6EVQFZ
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso1123735e9.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794120580; x=1794725380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7Z+RUwPNkJfYSyvADI+2XwTh8BlG6SdiyklPwWIP7I=;
        b=iJ6EVQFZqUc1JCULdiEBgNJ84P54mp7p0pzC8E12y44CcymFXp95DeiwtpJutyDQks
         djQPxTSogG61m8a/JgFTnpVeM/4lTbS9gfuxk06kfcT0DBMiBvLa8W7MCcCEtJ553TDU
         q2SmlgloURYCXaAiwAtgrUV8e+Efjvh1PBAxlFtLf8ZD3owfPIgDc2gGL8RUhjzl3Czj
         XTzv06fF3xab+Dx2oGntk1Fc4Qfw/rVua8BT0hGWjTBkdarjSWKcVyX7Vhp1tN6eOLmS
         WzD38G4NnWMmjOLhWLJM+tHoeuacn3xcC71IiBCX/w0fd/U3O5Hmxh/F5LrYUNfICGiH
         3tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794120580; x=1794725380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7Z+RUwPNkJfYSyvADI+2XwTh8BlG6SdiyklPwWIP7I=;
        b=2RpRfC9AtSCseW5ZY4c13y8FNwSs2kK5c8a6b3D2rbc8HFIr3vUa4Zlv0dmMQJJA4I
         McaxaWLNkhTgARjeMtpN7DSs9bed06di4aRIffRLoPBmJVx2MFSKli/CeCMTkvxEsf2Q
         z5eFGqIAoCl3ZvilKZ88E6OoE6PaIVAty7T64IVAS8U0De+IQJARhgpzkgEup17Qbpv2
         NmgmrSSKEAook222C0JROHST1C/EZVKbfmQFoCyRRyhSzcA2ZPHusDHm8t/mN6JjJWFa
         UvD8epFSofbiQMv7ejza4ZS/l9RTwB1dMUVpUq2MzmksO9J8w0a3C1ZjVBsP81ZwjpdJ
         0k8g==
X-Forwarded-Encrypted: i=1; AKwUvBwo2JmlhSIxPIYa1rtWXCkTOpsKpD3FSd8UYSou9tBexAc6wvEQP6N3ECMs+8pMbBQ+aibv2jc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UEXyMt0OsvtcjOZlBQIEsdhmC5YQ0cEEDqWfiFFaU7aTxX7G/
	4WTVOrR/bjVYkJZ9CleGWEIERFrfOxCf6BB3tB5ln8J0Lb9yUlFhr0kN
X-Gm-Gg: AYBFou3pN130OkMvQab9LPniGyOkvhB8Vh9nJgpVSgNOCXSzeBFLYIwHNVlw1QAmSlE
	PeGCy6t2iU08UG68XBdeMXc0uzmUELWGTbcQxPDvaZTIhflWxfE1Au1sImotPnwGygAgu5+W9Ge
	w++eP9CU3YPhtGM7wexHimyyBVRDS5zrVuGCCH17LTy8eJSl8jWpeXdfRfw0FVInORKy6uQ08Pv
	BtsbGz6op5MnyNO3hV+t/SlJ0tVpDXgL4JtbXYXR7/aAvm3JbzW6Uf/33md55LFXe3Ct86mGDL0
	1RPxQsqimRYVKhw2M76UFhnDG0hYR1gIqcrDsVsIaAccIZgiwKtqa54vW9BDQWxck/PzRrOD/6L
	0LYoYp+/7XY+03PIq0mlRg/Zj/vm8TAMpIjoes2hNPzPfs5Q89ntyH5KD3k+PO/f8vS2SPF+eBo
	jhQmIxA4jvtz8Uemv4nP+Oh/rPF47Av0+Z8uW8MHYuG7fdqnabuItJOtq1kFpsqNf1REkN4b7Zw
	bHrgwVawUsUmmZQgj4rOZWa5NoqjZQO+g3ZWf5hVMdb3RtcMjZiT6uwmIdtXpH/9QSOyy1wZ5rN
	JhRdyUMQFv2jSgCc8g3oMpI0/Lqttmr1ZTm8SD3j5L0OQQ==
X-Received: by 2002:a05:600c:8712:b0:4b3:6900:280c with SMTP id 5b1f17b1804b1-4b963c7d013mr12738155e9.19.1794120579685;
        Sat, 07 Nov 2026 22:49:39 -0800 (PST)
Received: from localhost.localdomain ([2a06:c701:475e:f800:9c3f:1631:3855:dec8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b8fdda3358sm37582945e9.0.2026.11.07.22.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 22:49:39 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: richardcochran@gmail.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	arnd@arndb.de,
	john.stultz@linaro.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net v2] ptp: Report clock removal to poll waiters
Date: Sun,  8 Nov 2026 08:49:29 +0200
Message-ID: <20261108064928.1931917-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ptp_clock_unregister() marks the clock defunct and wakes timestamp
waiters before posix_clock_unregister() marks it a zombie. A poll
waiter can consume the removal wakeup while the event queue is empty,
return no events, and remain blocked until timeout after device
removal.

Using netdevsim's mock PTP clock in an x86_64 QEMU/KVM guest,
the unpatched kernel missed all eight epoll removal notifications.
The four poll waits returned POLLERR only at timeout. With this
patch, all 12 poll and epoll waits reported clock removal promptly.

Check the defunct state after registering the poll wait queue and
return EPOLLERR when the clock is being removed. Use READ_ONCE() for
the lockless defunct checks and WRITE_ONCE() for the unregister store.

Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---

v2:
  - ddress Sashiko's v1 review, forwarded by Simon Horman, by pairing
    the new READ_ONCE() with WRITE_ONCE() in ptp_clock_unregister() and
    using READ_ONCE() for both ptp_read() checks
  - the v1 poll fix already addressed the observed removal scenario,
    these changes are really just to make the lockless accesses consistent

v1: https://lore.kernel.org/r/20261102122340.1160733-1-thnkslprpt@gmail.com/
 drivers/ptp/ptp_chardev.c | 8 ++++++--
 drivers/ptp/ptp_clock.c   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index f63b45f5ee6a..dc5865e95f77 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -593,6 +593,9 @@ __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
 
 	poll_wait(fp, &ptp->tsev_wq, wait);
 
+	if (READ_ONCE(ptp->defunct))
+		return EPOLLERR;
+
 	return queue_cnt(queue) ? EPOLLIN : 0;
 }
 
@@ -616,10 +619,11 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 	if (cnt > EXTTS_BUFSIZE)
 		cnt = EXTTS_BUFSIZE;
 
-	if (wait_event_interruptible(ptp->tsev_wq, ptp->defunct || queue_cnt(queue)))
+	if (wait_event_interruptible(ptp->tsev_wq,
+				     READ_ONCE(ptp->defunct) || queue_cnt(queue)))
 		return -ERESTARTSYS;
 
-	if (ptp->defunct)
+	if (READ_ONCE(ptp->defunct))
 		return -ENODEV;
 
 	event = kmalloc(EXTTS_BUFSIZE, GFP_KERNEL);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 4111342d64f0..d2640325abf7 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -518,7 +518,7 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 	get_device(&ptp->dev);
 
 	/* Wake up any userspace waiting for an event. */
-	ptp->defunct = 1;
+	WRITE_ONCE(ptp->defunct, 1);
 	wake_up_interruptible(&ptp->tsev_wq);
 
 	/* Tear down the POSIX clock, which removes the user interface. */
-- 
2.43.0

