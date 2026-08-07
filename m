Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC843F4D7
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108805; cv=none; b=S+28qFSiser1XAXoIL25atTwLWMLGiWcAfuP4MsKAhCIRjW5EAbg1OHGWEEncPwbXI7x4a0QseNTcBCxGzV2C/Io0q+fzgbq3DGM4iW2h+Krzux9CDc4BqELNX8lWJgKoAzSMdwNZ4/dy316+Jv76rhhwESLy6ha2LreTgJOpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108805; c=relaxed/simple;
	bh=eZMUEFA0rX54d5beGnGjUkLok5GlX2v5NIYJ6oiOeVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9m2KXYBEcIJfmVLf1i2U4vYkDK1mWOBnSZRc6Y87q7tP2bRA7ShyUjG2GF8FfW33pdd27O+QR6MQEsiBgPXvb9QfHyy6SOwTAjp1UwkqG06Ta2gxaamAxLHTvBYrKD7fHNfQyEhm/SrKIwSwpMd4WISqeEJVN6828TOddXKK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcoM22KM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcoM22KM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495590dde14so38622275e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108798; x=1786713598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzLGjA7u0zhw1WnwUzRFcfnBmJn3wgjeP4QSjX1ei3Y=;
        b=PcoM22KMQk1LaAi9PlWFAbAFRX5zkoB6an5Q2JwG4698HKg0Q1HEXf7FqgEBS/Ohk6
         XPzJ+Amk74Lcd2i2Huz045z9JOa66hndfBZTGhwToRIIFeCm9yu6o7R3y8XkeQ+qf+tY
         nif2CBsdSa/HiBqfayr4636pU9Tt89WDaSD4v1STtvMhfQSb/59xdAij8hUruRg/lrFJ
         IGoVFz1ZN9hRuUfDvSc/Tc1fhUj28nRHRp+mrp+z8yiZESEzS5VMLs0wKNLIROz7FW6q
         jmWqlM5VA+vtGFMxbcfgXo0Fc/twLABR6m+3p4enhItuzQbj9Tf8ulFzGjGM3JJoI4UM
         kMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108798; x=1786713598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LzLGjA7u0zhw1WnwUzRFcfnBmJn3wgjeP4QSjX1ei3Y=;
        b=mcoD9MDVu9jWVfb6klBALkrjs5C7Du8Rm1Fhr9K4Z3qc1kUSlAbOzOe/a3XV7QZi+y
         wzkBKkCejR7BppOJgnCijj6D2y0i5dqgRchwn8glWrMftc/Awiq8jw5gRxuYsrxLKl+k
         7DRYVMzwHevLwqPXqfBifbGtoozE7BqLK6XjwHLNRj5fD1jMKinccl2RlVbKkSCBQYDc
         xAVMnWrGK9otp2FhTiGLf8JJxUxRkhTN8LcVyAhL6/eGcAoFDs68kqyXl5orPhyeB9DG
         GoNDt4AhsD1FJjV6L5IV28+XyyOQpyyDtq6DgL4GxpFrVyc2zcVgS3EkMgPww/wmvO8h
         b8wg==
X-Forwarded-Encrypted: i=1; AHgh+RpL9zN21ezgBvnATF8rlFrTJ8Ejsof4P8JGoCPa+yBeebe42V5t9lYIKeEvkQJ+QpIE/HnkRxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoUx9DDbHbMAI79KpVfqowDFPTtaB6pXYjvdYfcVIiUG8nuZl
	WaymxRgxuunGsbMDWSAyhB5KTrCB51Apxzmq0oXPZe+2mmKFQoXJP+YBGINi5ZOt
X-Gm-Gg: AR+sD10Tqx+iHfFomgnwphydN+Yh0nd1u1eq7SrpT7Zk9k21kNqrlmZQnJtiNPzZyZD
	CMImqQ8Dcvm5YwS1HRwFycbPWG0U2r+EN2X8uYxdUkmBKjwofmhT9juoPHWhGT27sYoOFGHQNiH
	LAPcL4LKcCOqTTkeQz7gbmWj41ObVDMSn1kuuEZC4igIOtqpmxL7whXeEw/DQxDGcP2B7n1QB+5
	9xc35Y91xBDnHzZBv71O2VdX5bRJs9TrrMYzzr7SmjtwPK5JTfVB7Hhr+0fyceO9wYCVoz5AZHt
	OA7XiNdZg7nrAMZy7KhjDFT2r0aGRSeMJACCAWo8B9L+ORwKsPBIQC6vy2zCuVDg0nIbCf1ABfj
	EVbiEvJiCWWwS8lnaS2933npDGeVRPXCaEfZC0Fx77lxUXN+0E0hzRQVF1NIQ3vNmgcPl0z6aaP
	Sxm8QwywEqXg6wRbKjdCskpuoqkRsGZDnz3oKi6xN7JvtNRNYBwlXxviJasdDHmro36bbgDPOeJ
	rA7WokHK3aQf/iv1v/eRKUTg58j1bGMjmnOnXjytDPwUX92Hgiao/rLlFkLQqj91w==
X-Received: by 2002:a05:600c:e549:10b0:495:6934:414c with SMTP id 5b1f17b1804b1-4994e7df489mr249006735e9.19.1786108797482;
        Fri, 07 Aug 2026 06:19:57 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:56 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 12/16] io_uring/zcrx: unmap under netdev lock
Date: Fri,  7 Aug 2026 14:19:30 +0100
Message-ID: <1c41f349f8bcbcaafb17a9c81d4157aa9d30de93.1786108672.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786108672.git.asml.silence@gmail.com>
References: <cover.1786108672.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure we unmap areas while closing a queue.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 91d0d823f482..be3560739bbc 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -311,6 +311,9 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 {
 	int i;
 
+	if (!area)
+		return;
+
 	guard(mutex)(&ifq->pp_lock);
 	if (!area->is_mapped)
 		return;
@@ -437,7 +440,8 @@ static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
 			      struct io_zcrx_area *area)
 {
-	io_zcrx_unmap_area(ifq, area);
+	if (WARN_ON_ONCE(area->is_mapped))
+		return;
 	io_release_area_mem(&area->mem);
 
 	if (area->mem.account_pages)
@@ -544,8 +548,10 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	if (!ret)
 		return 0;
 err:
-	if (area)
+	if (area) {
+		io_zcrx_unmap_area(ifq, area);
 		io_zcrx_free_area(ifq, area);
+	}
 	return ret;
 }
 
@@ -599,11 +605,12 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 	}
 
 	if (netdev) {
-		if (ifq->if_rxq != -1) {
-			netdev_lock(netdev);
+		netdev_lock(netdev);
+		if (ifq->if_rxq != -1)
 			netif_mp_close_rxq(netdev, ifq->if_rxq, &p);
-			netdev_unlock(netdev);
-		}
+
+		io_zcrx_unmap_area(ifq, ifq->area);
+		netdev_unlock(netdev);
 		netdev_put(netdev, &netdev_tracker);
 	}
 	ifq->if_rxq = -1;
@@ -1397,8 +1404,7 @@ static void io_pp_uninstall(void *mp_priv, struct netdev_rx_queue *rxq)
 	struct io_zcrx_ifq *ifq = mp_priv;
 
 	io_zcrx_drop_netdev(ifq);
-	if (ifq->area)
-		io_zcrx_unmap_area(ifq, ifq->area);
+	io_zcrx_unmap_area(ifq, ifq->area);
 
 	p->mp_ops = NULL;
 	p->mp_priv = NULL;
-- 
2.54.0

