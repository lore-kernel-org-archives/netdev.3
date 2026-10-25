Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896323;
	b=5QiAQ1XRpJZ6WJfx1w9HaWfK4jqcdYOzq0SjUvXVvsV23L5CeHBmBdAtCuR3cDng+typ
	 O+EMc+Qgb+eQ6Uc7EB0vFiDy4vLAPsdu2JwQ6DHNsi4D31rJ3z51jD41/lSt+TU/yOIrI
	 mjBuaMc4AC8N0HbG1Om5YZJPtr9gGJ3V0yOf6m0Bnb0z4tv+TD1IS8bD3k6+KrQxbNHqj
	 k5fJmjUPCt+9lfu++1b5FdcD+k+W5zg9756fWsh0dJZxyppqfgRNDoBUh7PLfI+EaWmfr
	 HDNn5PJMf/WDzvYmIbPpsBu7Uo0ebexnCX+WxIMxjb5mXaQj+wRmNAiMcyAcqOz3cfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WpjUZLKhw/tvYFR10QM0neivX8YIU0hqUruPnucpBLM=;
	b=aWoCljNLHAfGTliV3crOLHQplTTsSzvcOF7gtcnfDynfF+Y9uRZjvbKPXqWZbYnE415S
	 bYOdvYckqFY4dqu+oZAVgl8TDyM42J11uM92hgL2dL8ryoTvNLnFnRyXLisNcIreOAFQt
	 tPSx9FAV4VQ0QzV2VmqnPnXP8+7BQrMaeIqzG4mq9QVDn+kpseFpOf7KFBiYTf5KWLjSK
	 kWUBqyKn2nd5uVlf5aJ/fumXGoteb3aZe8L1W8AV2hM9xQcqn2IvVgAP821Kbb5zJg1OU
	 5td+egP/iWld0zcKW53j+fn0tCzy7d17GqEk3j2LYOU2dajH3qcCyGmmNuHMbKVqiZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=UH3J3HMQ;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C06606A31E
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 02:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12C06606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=UH3J3HMQ
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5331833eec.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792896321; x=1793501121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WpjUZLKhw/tvYFR10QM0neivX8YIU0hqUruPnucpBLM=;
        b=UH3J3HMQv99pAPAW9zP0r0Dle71wXTqYA9LOtYNu0eUbeqCEGlT8pKDCXzawBl7P5G
         IvcwqAEAosh51YDiFpDB0St7pHDQVo97VhQBGwz6HxRmphyNwdD1fIeFs25qAYqt1hgb
         QoY/41OqHxEt82dTDER6IvhEGxwcXxbHJGrwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896321; x=1793501121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WpjUZLKhw/tvYFR10QM0neivX8YIU0hqUruPnucpBLM=;
        b=slHwqBb8KhN+yFO1O+SdWG2rcZdGru/34WxBcqKeiV9tuSiScZOOOkLY78L0pYeH9P
         2ctehmUCigbjhkDajH3KLASZFN6RLwthJeyZSlpiYYSWeLsm27kSvBh00yubm04dQUVh
         zNiyox+feifgpDJURAK8RD9WXH4jA+9EIOwjsH6AeCZyjvuLj1ceIKh2beBSIAxXzaU+
         59GT6MMjhGpiMIxJYJsXqHaLV4M8pH0EyVLC6xjVeJNj3jZ/QU0gGmGP/hy09IV3bNu6
         Z0hDgBVDozZ/8mmH9i2vTIV84s0S3NH4tBddmCSQuiTx6wTRarno9/rT2SXZXgoKGQ5I
         9McA==
X-Forwarded-Encrypted: i=1; AKwUvBxaCyO3LC6iOWRsAH4Z3YL2b214+V43VlKBgLSHh0TRq6FhMpX+d7+fQClQJiLkJRCyp6zAbZc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQGux4r9dJzpxDtVN2ns0NXX2HrypscnBlZRe0WT8v9/0bob9d
	FpwSl/pxb10cr2e755YBF8WurohyG7TU9FbhK0L+9NZMeNx1Kq6oVyttQCD/uktI8oI=
X-Gm-Gg: AYBFou2lQLlo8cBynM0QvhImO6VuuJu0B4udiU/tkVJ4I5vRGuHatcKgxEYkmBHyx+v
	zMOq7RmawErU9fuW7tWtv5TdkNilwMjGHGIVA6Ha19Uuz8qJnUWOcti9eU4tzMcjB1wAdjU1uWl
	DnBvWJHBWctyJFiYAV/jG6mTxQ2CBoux1y39pakqy2QP8uarqbLPy8z4nSxmGh09n1+pQI4/dmA
	STUQUbcBaaotqmNj8kQbllyDGZQzQ41sOhpyo0Qncq/hFcaD/2a8z20/GI/UNbvFBHHh991mDAU
	OcRNw9RhHQX4n7DIJom3HkFRgLYTMKViFVBVbN0DLK7RVd/nMYyKavMQ7Q7OZd/o7KHg1swO5rK
	nfOY44J/FOrSZ0KLap1HCbl4ArRhphgDWb9vWVKjiPTKpPMdQXIxo/mu2MslBFruuUG/Ic2HK9p
	vcS8/hR3yWCsLtjeL1MWtbvewBd2d3QBgL2L1mGOX9qHlBYz0w1revpaSSmMrcgLaxIE8TshqMH
	3m5i8L597gv4ofl4jNsnNPU2dreeLeOCyfHVRKZJcK00Xr5H37BcVOBs70J0EqXXPZbJdL1kURa
	HOjFqWQvTFFnluUFAG4=
X-Received: by 2002:a05:7300:2442:b0:358:2e30:8e5 with SMTP id 5a478bee46e88-369e836b382mr5953999eec.1.1792896320943;
        Sat, 24 Oct 2026 19:45:20 -0700 (PDT)
Received: from shiro (p1469046-ipxg00b01sizuokaden.shizuoka.ocn.ne.jp. [153.223.97.46])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm23813952eec.23.2026.10.24.19.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:45:20 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Daniel Palmer <daniel@0x0f.com>,
	Denis Ahrens <denis@h3q.com>
Subject: [PATCH] net: i825xx: 82596: use MMIO accessors for the MVME16x PORT/CA registers
Date: Sun, 25 Oct 2026 11:45:14 +0900
Message-ID: <20261025024514.802862-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
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

On the MVME16x the two port registers need to be written in order to latch
the correct 32bit value.

The way the code is currently written means that modern GCC can decide to
optimize the writes and break that latching.

Convert the MVME16x specific register accesses to use the proper io
accessors to restore the latching and make the driver functional again.

Reported-by: Denis Ahrens <denis@h3q.com>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---

Denis emailed me with his fix for this issue which added volatile to
the struct members to stop the compiler getting too clever. This is
my version of the fix. Dennis, please test it actually works :).

Also, this driver is old and does need to be converted over to being
a platform driver etc. I have a set of patches to do this. I'd like
to just fix the driver first so it works again so the conversion to
a platform driver is working against a working driver.

 drivers/net/ethernet/i825xx/82596.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/i825xx/82596.c b/drivers/net/ethernet/i825xx/82596.c
index 773d7aa29ef5..bb8798b0d3ae 100644
--- a/drivers/net/ethernet/i825xx/82596.c
+++ b/drivers/net/ethernet/i825xx/82596.c
@@ -196,11 +196,10 @@ enum commands {
 #define TX_TIMEOUT	(HZ/20)
 
 
-struct i596_reg {
-	unsigned short porthi;
-	unsigned short portlo;
-	unsigned long ca;
-};
+/* MVME16x: the 82596 PORT and CA registers */
+#define MVME_I596_PORT_HI	0x00
+#define MVME_I596_PORT_LO	0x02
+#define MVME_I596_CA		0x04
 
 #define EOF		0x8000
 #define SIZE_MASK	0x3fff
@@ -375,7 +374,9 @@ static inline void CA(struct net_device *dev)
 {
 #ifdef ENABLE_MVME16x_NET
 	if (MACH_IS_MVME16x) {
-		((struct i596_reg *) dev->base_addr)->ca = 1;
+		void __iomem *regs = (void __iomem *)dev->base_addr;
+
+		__raw_writel(1, regs + MVME_I596_CA);
 	}
 #endif
 #ifdef ENABLE_BVME6000_NET
@@ -392,9 +393,15 @@ static inline void MPU_PORT(struct net_device *dev, int c, volatile void *x)
 {
 #ifdef ENABLE_MVME16x_NET
 	if (MACH_IS_MVME16x) {
-		struct i596_reg *p = (struct i596_reg *) (dev->base_addr);
-		p->porthi = ((c) | (u32) (x)) & 0xffff;
-		p->portlo = ((c) | (u32) (x)) >> 16;
+		void __iomem *regs = (void __iomem *)dev->base_addr;
+		u32 v = (u32)c | (u32)x;
+
+		/*
+		 * The 32bit value is latched on the write of the lo register,
+		 * so the 16bit writes must happen in this order.
+		 */
+		__raw_writew(v & 0xffff, regs + MVME_I596_PORT_HI);
+		__raw_writew(v >> 16, regs + MVME_I596_PORT_LO);
 	}
 #endif
 #ifdef ENABLE_BVME6000_NET
-- 
2.55.0

