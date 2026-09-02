Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC30249EB
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328895; cv=none; b=YuK5MXdIeutiI9C6T5Ia5nYcqVqGQosSRva7iLhawCgFY50Ry0nSIHk2+phttsY75cyYBdrkzhoYwykQ9TAbZl2lKwJSSP3Y8Aw4S0RVyD89B6H2yrIRvAx1NrZ7u9S5HAonnmyg44v6xtbK3kkHM3VEx5tspu9YyyWEXAAAKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328895; c=relaxed/simple;
	bh=yYJkD9mqW5bqZ88BxOeJ6Hi++gOW0jBDcsthzHZC4aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPZqLqxeMSidjvZzqbYEy2XhQcPD7hWZE76qt0ZifeTpgIEyr8S5sw2254k2il5fDs4qgpx6QTHYizcr7drGWnmWA8eMVdbElPVPrzl/5ZVsIGXHESINFNhZWyfPPdkDVPA7O1+lmUiPat4ZUAZ1Ir+YWbZLbdsIjtmok+x5iag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6LNHMS4; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6LNHMS4"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ceb5a39c48so1764495ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 23:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788328894; x=1788933694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XWX0Z0XhP6kZ3ued+eAJhd1QUL93rSNRpXL2eH5Zlds=;
        b=k6LNHMS4+0valRP6IJDcW2gJQcqp4RcpWYyx4lVlNzrrRPcNYArOSR16l5pvPHBp/T
         rUuUHVX2I5CQjJCvxMYdbyUTxZ3+8WVP+UT2CKscee7AU5JSnrTiInTGpqncnxaLoqMO
         rKgspI8O9rcVhZSYqDbE2pBMDUrQKrqp5T0wWf/6RGO+uJ5zNHkNF+SHt9aS2EZzE3y3
         7FVoFdoSf8oKrxNHCyG6LbmZwOw6WZNILoczaoNfs+g28CCEQZY+suh21buATm+hK2id
         wqW1kdHZjC1sUCGg5yUwT99H823G1sUaaV0aDwZDDJyU3wYAqTF489mEYwcQTbHak+qq
         swgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788328894; x=1788933694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XWX0Z0XhP6kZ3ued+eAJhd1QUL93rSNRpXL2eH5Zlds=;
        b=DvIOuukuWffazQBmxS0t7dQVk/rTRF5OZ2oZUzAZcpmN9k7WTtyiSLYZSQ4kz/onNi
         GBh61+Z5qLtb5t5HMi73ttfL44Rq3+KILVt09U5C+A7JrzeqOjEpe3C4Ep4bt4GAgtKU
         J0TefMuf05K9m9n7tWhZ2E3786udJvddeBPNWr3Yzv73hHxTb/YotuH4weMCdTY/gDew
         M+EXfUPUGaeNZVjLoEcQJui2SaAvnTyNaIflHnbyKBAfPqNG6LfO9dESLFgPtpJHmVPN
         7yd1RqpV3KyXWRFHLaqcEK9J8D1KZeTkIqe8aRCk4JBuv9b3EBCnLUG4aG7JGNliaKKb
         n4MQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7IWySkf0R1S26XbsHYwer924bxol69jgMQxiZMcw4+AHoCP+jo1Awry3SsyEH0R4XrzmiFd0=@vger.kernel.org
X-Gm-Message-State: AFuF++ng5tLpFR+zUBrmOMMYT7DLWVitIi2Yf/czMaF7VxwQVk13WgLq
	Kz7T9C4KcafRaD/W5RUcBcamla58wUecuZrIF20RisdXJTGfA5ASyCkd
X-Gm-Gg: AYBFou1Em9PjAZ/QUpfp2unn0ROFjGMjRc/bpoTydfOz18b83qYV/BmfYJi1Wew8oL8
	dhHXklhjuqroh/ACP8ZKrG1fHXEIvT0T3IgAxIdK01TH4iO8i9anlBYBzBP5YgdvNuH7v7nCjE3
	mdyKqe/Q5Csz0Xs1ndDBLbH5hbEOuYXRgUHl+YHFJbghDbKbhiO+eGethnrEz9M9iv8ATLpzoKi
	M4q2CJwT+DLeWcqEAHTOjf/Qgbs4c1Qd7vr9atMmbDdGPIlbF8XHALUHSXX/j9poEoCzaa0Vgs+
	bM49ryMv1y5I4U+8zyyhHS4+//52mduHzAJrOyjXeLCq8s/pWigj4haA9U+pIeTyvWQbfZej3uS
	stL6FphLNQpDLuNfZVNOihi0gVVn1LL2PcfE8ULKXnJKqcr+GYj0IF2J+im0B5GjwUE/STQjwJ3
	UkihzSz4LXinUwBjLDn8WfB9cFL+yPUOm98dJIncPBxdKu3PUOcLdCcu43Ow==
X-Received: by 2002:a17:902:e78f:b0:2d9:56dd:f804 with SMTP id d9443c01a7336-2daec71e483mr36829135ad.13.1788328893615;
        Tue, 01 Sep 2026 23:01:33 -0700 (PDT)
Received: from fedora ([59.172.176.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd382116sm7488205ad.26.2026.09.01.23.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:01:33 -0700 (PDT)
From: XingWang Xiang <v3rdant.xiang@gmail.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	XingWang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net] net: mctp: i3c: serialize probe with bus removal
Date: Wed,  2 Sep 2026 15:01:18 +0900
Message-ID: <20260902060118.4025762-1-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mctp_i3c_probe() drops busdevs_lock after finding the matching bus. A
concurrent I3C_NOTIFY_BUS_REMOVE can then unregister and free the bus
netdev before probe passes its private data to mctp_i3c_add_device().
The latter consequently adds a list node through a freed mbus pointer.

Keep busdevs_lock held until the device has been added. This also
satisfies the __must_hold annotation on mctp_i3c_add_device().

Fixes: c8755b29b58e ("mctp i3c: MCTP I3C driver")
Signed-off-by: XingWang Xiang <v3rdant.xiang@gmail.com>
---
 drivers/net/mctp/mctp-i3c.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index 88d9e36cd..4e857dd5d 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -288,6 +288,7 @@ __must_hold(&busdevs_lock)
 static int mctp_i3c_probe(struct i3c_device *i3c)
 {
 	struct mctp_i3c_bus *b = NULL, *mbus = NULL;
+	int rc;
 
 	/* Look for a known bus */
 	mutex_lock(&busdevs_lock);
@@ -296,14 +297,16 @@ static int mctp_i3c_probe(struct i3c_device *i3c)
 			mbus = b;
 			break;
 		}
-	mutex_unlock(&busdevs_lock);
 
 	if (!mbus) {
 		/* probably no "mctp-controller" property on the i3c bus */
-		return -ENODEV;
+		rc = -ENODEV;
+	} else {
+		rc = mctp_i3c_add_device(mbus, i3c);
 	}
+	mutex_unlock(&busdevs_lock);
 
-	return mctp_i3c_add_device(mbus, i3c);
+	return rc;
 }
 
 static void mctp_i3c_remove_device(struct mctp_i3c_device *mi)

base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
-- 
2.52.0

