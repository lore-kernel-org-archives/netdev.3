Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7865581FD
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087327; cv=none; b=rFCdwAuChLhHutYiE4EAVpt4ccyRbbRidpB3DoZRbUgdS4ghdFlxdocYOoZx4oMhr+li9MKLpnFZecXDIVAS/qSzP0+os+CJN6ZL53nQvhU4C1Ybua41UNOZgNKYp4ul0IMQngwRTqIqjSx9GDFF9NaLJMwcZDa1MWGN+bxPFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087327; c=relaxed/simple;
	bh=xIgy530ICC4m3NkKuadi/zzirqDT04Q8w/kPC5TSRsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/PZyNo0yWxIrkavo5SSP79UITV5b7H/AkmgehQFOcXd1so5gqXgJ55mEe/XYAo/MbA8VpIysFH7LIgAOZjBxm/ElQaeRpL7bvInvPeesPIWwhsfw8Y31RrYyQK2Qx+gYIQG7YpRmoxdLJiwJUxb5FeeU9EBowjLafIRMoq4mHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAhbLqQ0; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAhbLqQ0"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b76668f4ddso1536718e87.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087324; x=1790692124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Qx6sfb6upNLcj5IsqKTL87bc3YDUS09h8egDr62oaQ=;
        b=WAhbLqQ0L0Lm2DdQD8jamZaGUYd4uJJ+iAyP6l4/XSjA7qxCRLIm4joOjNbhKRojx0
         2EccsASsw8d33gwRDvxXsFj3VnPP988EOM6nGS9p5bIwZ4kdNziuv/fGZXXD+BDVFSYO
         1yw7MvB1oVHdymO+dcNC0vesmJE9V3jvXMoUNvPBM4oB2ZKBdfuHjwVAlkKBgU8w6p0D
         zIsgIh7AUHcZE5TItwMxKMJa1AaaZmJPI0k9Ycahcgf1f4UXoVgmmBus78nJqP7fGvzB
         xYvYCgGrrYgaVyG4f8ydWm575BBzu9ftL0pLEl2mEc9MpmmbFvNu6JCdRJ1AbDF5lBZz
         Rqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087324; x=1790692124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Qx6sfb6upNLcj5IsqKTL87bc3YDUS09h8egDr62oaQ=;
        b=NXDp+DrVTUYznK/j7U410BMc9/Bi77xXB4LMm3ey3L/q6Pt2da1k+6+LZZXUKiSUUP
         XAKGZbtE0itGj/hdtgbRJPNWjrKC9/Vb+a8dL2EM0V/yuobYedY2JmWY60VBVmFKErq0
         bG3tG7r48ZZ7W0iWFn1O0h+xccdebqGzn9Q7Zjn2JkVR6a4cZSm8A97vTolewRCq4iXA
         QLJRVJL9JwlaF0A9GLq46uqSeUsayIq8I4Y74v5zpjB4CmMfMZOuUWrf2z4WnidZNqZj
         EwbQp8w5BLPhOk+/8D8YVTyiqzHTtSlz/ZJAKQNw7K+kE4o0nXTflKN469dfD/JzVPAQ
         WIjw==
X-Forwarded-Encrypted: i=1; AKwUvBxgQZVXhMW7ZG0VrACKTZSY+gTTJ8OtN+67PxriDKqZQGuwm28nJtXwsW3YG7JUwzsi9r1lxms=@vger.kernel.org
X-Gm-Message-State: AFuF++mVeOZl1zY0uxDhYzULawcFSeSRpHa3blRGFMxeEDmevVJYulxY
	iW1LmtJG+ryjgIX//ELZjB0qleqI/hMe++mIfJgqjE7umYCSEqk7ycYs
X-Gm-Gg: AYBFou2Py+HAX87EGh/TNPzTxklw76c9zVdrTFn6ScfGdCDnc0v7obpFrlvbNpCra1q
	pB+VrdgyxGRdZ6AgeJWN6LJe5c4/ASfaiTXFbSmhIDCnjvzrIvqV9302t+XTW2H8ySofUkue1/i
	y+6v/lwsImOSUugd7zsm7avF2AAZXceZOfN+HVd/B/4CSAgZXgGkbPS2LpSe+/OQsnUWkU9xAzj
	OdAua0xtJuPWP2OVyEZXLDxisv1EKjbn7m7TNvY0KPQ2bQv0bKvJxQKbV2ZMWEX6iS2oe6vSlQu
	sOmOwCmFLNkjLUAyPESfcBlUY4maSFR0ioKEtrbkUpBMK+p5cPFfH8BbBHGCd8oajfo3yfKYxAU
	c+NRHWQQm7BGvS0uC2wEinbr0xWokLSdIe7bwgjjD+Lml0OTeu3tOpzjSq+pTrNMjPXXwxIfwVP
	56TQHQrm8GPU7Bkuej3ntC50vk1ima9aP8gwodMOMmC0YxOK/UC25wirXpj4TvetQHkJKfEmgGM
	o0N5fsW7uJdRGcG+ZQsoVDeqvn6IvyfWX1cCaWnqw==
X-Received: by 2002:a05:6512:23a9:b0:5b4:ac27:8f76 with SMTP id 2adb3069b0e04-5b8d28fe7e6mr1013908e87.7.1790087323448;
        Tue, 22 Sep 2026 07:28:43 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46d2064sm589691e87.24.2026.09.22.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:28:43 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next 4/9] ptp: ocp: forget a CPLD i2c adapter number that no longer resolves
Date: Tue, 22 Sep 2026 17:28:24 +0300
Message-ID: <20260922142829.57740-5-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260922142829.57740-1-maimon.sagi@gmail.com>
References: <20260922142829.57740-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adva_x1_bus_claim() returned -ENODEV when i2c_get_adapter() found nothing
for the cached number but left the number in place, so
adva_x1_cache_i2c_adap() kept bailing out on its first test and never
resolved the adapter again.  The comment on the parent check claimed a bad
number is forgotten and looked up again on the next sweep; that only held
for a mismatched adapter, not for one that had gone away.

Factor the invalidation out and use it on both paths.

Re-arm the one-shot identification when a new adapter is cached as well: a
different adapter may answer where the previous one did not, and leaving
cpld_id_tried set kept cpld.id absent for the rest of the binding.

Fixes: 3b815e29966f ("ptp: ocp: add TAP CPLD access for ADVA TimeCard X1")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index feb61355078a..45313143b6f7 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4574,6 +4574,19 @@ static int adva_x1_i2c_adap_match(struct device *dev, const void *data)
  * both the notifier and a single lookup here can miss the same adapter.
  * Retrying costs a short klist walk per tick until one of them succeeds.
  */
+/*
+ * Forget the cached adapter number so the next sweep resolves it again.
+ * @nr < 0 forgets whatever is cached; otherwise only that number, so a
+ * caller that raced the notifier cannot clear a newer one.
+ */
+static void adva_x1_forget_i2c_adap(struct ptp_ocp *bp, int nr)
+{
+	scoped_guard(spinlock, &bp->cpld_adap_lock) {
+		if (nr < 0 || bp->cpld_i2c_adap_nr == nr)
+			bp->cpld_i2c_adap_nr = -1;
+	}
+}
+
 static void adva_x1_cache_i2c_adap(struct ptp_ocp *bp)
 {
 	struct device *child;
@@ -4598,6 +4611,15 @@ static void adva_x1_cache_i2c_adap(struct ptp_ocp *bp)
 			bp->cpld_i2c_adap_nr = i2c_verify_adapter(child)->nr;
 	}
 
+	/* A different adapter may answer differently, so let the one-shot
+	 * identification run again rather than leaving cpld.id absent for
+	 * the rest of the binding.
+	 */
+	scoped_guard(mutex, &bp->cpld_lock) {
+		bp->cpld_id_tried = false;
+		bp->cpld_id_attempts = 0;
+	}
+
 	put_device(child);
 }
 
@@ -4614,8 +4636,14 @@ static int adva_x1_bus_claim(struct ptp_ocp *bp)
 	lockdep_assert_held(&bp->cpld_lock);
 
 	adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));
-	if (!adap)
+	if (!adap) {
+		/* The adapter behind the cached number is gone.  Forget it,
+		 * or adva_x1_cache_i2c_adap() keeps bailing out on its first
+		 * test and never resolves the adapter again.
+		 */
+		adva_x1_forget_i2c_adap(bp, -1);
 		return -ENODEV;
+	}
 
 	/* The number is freed before the notifier clears it, so it can
 	 * already be another adapter's.  Check this is still ours, and drop
@@ -4623,10 +4651,7 @@ static int adva_x1_bus_claim(struct ptp_ocp *bp)
 	 * way, where forgetting it lets the worker look the adapter up again.
 	 */
 	if (!bp->i2c_ctrl || adap->dev.parent != &bp->i2c_ctrl->dev) {
-		scoped_guard(spinlock, &bp->cpld_adap_lock) {
-			if (bp->cpld_i2c_adap_nr == adap->nr)
-				bp->cpld_i2c_adap_nr = -1;
-		}
+		adva_x1_forget_i2c_adap(bp, adap->nr);
 		i2c_put_adapter(adap);
 		return -ENODEV;
 	}
-- 
2.47.0

