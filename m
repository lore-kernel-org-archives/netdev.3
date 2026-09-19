Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BF397E89
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857276; cv=none; b=MGMvrTqkxVxo2+hx41nlenVuVSIxPqLUSU3EWX14+8tH1lMJP8fvJlGS9gpI4wJS9jOIkpFrs8iu5TYyFq+gXpmpRpfXdeq60+hnlOYbGG9fAH81+fZJLKij0aZkDijy+5ejBj1qiDUWl6NJjYDOj48TUdqdSGyMi/i0TK1dJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857276; c=relaxed/simple;
	bh=wOlYZODCnWgbZZy7EFDEtjpA+YRshMveyCdiX6qNFAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiJbigKrrux9EUnM2uxTfC0a4eMlbmVkSVrX5v26CuFnxZRvcyuhDrGLzNHeN2wRE0z7asW1PSc7jv/oLz6g7A9GShFMip3xIbikFS4nM9Yr0Quswj1bHT/SccpCegAv8mbmUIhFCDnIWUezqJDEUve9IYa1OZW9mFt3Kw3D4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efcltKNJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efcltKNJ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe433fso16029055ad.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857274; x=1790462074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WI1pki+zfwXSN5E34Vg9l05h0Yqa+0/MqFS6gNIfHcw=;
        b=efcltKNJqW/7HGHJgatxbipBfbnnQ6TQnRUxuqZR02ZRWbPguKWzF1gpIi6/95mor1
         mfc3HFmNrBpo/DT/NtGWEwRaiLVp0KmhUByVqViKIx6xlt1WOpwpdEQTNqhtfQw2C3P/
         R3xyffbknUuTqYZlPj2NXFw/sQtNQLJzZazsIiOUdtOS4QfTAU2AmIZXEesBkHP7DN0e
         hE7afFDg3G7nxru+fTP2ieryR3/U9neKWgNQiRT4BNWYxELCKgEs0J555WsrjGCbq+H0
         wPZiCh8yQXbO9oA6A3hcuPlFqPOTSQGaroBHcEpRuTEHcjbehIQtXUglwlN2Zpzp1aVI
         CQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857274; x=1790462074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WI1pki+zfwXSN5E34Vg9l05h0Yqa+0/MqFS6gNIfHcw=;
        b=qhyPFlORt2eQICqJDVDE0vRk0F+sXfSCOK6HGbtb5gFdG+RoY/8gt8nCiChwDjBOu1
         uTMmwN1qx2DsZigNI396+eUUcl5tqageyiYYZyO0sXxmnryGmHRbyncW1z3qQUanZn8b
         7f+XbTLSq11M+IrGsM7N97zEpUfkwPmr+KufyavsB1Yu4kAEmp4LlGXsR/4TLP2MDLsq
         9hwg7obRdQWV5plTo95NttGo1qV8SsFMXL+lDsP+yLASAMWRSO7T2HEvDeuAn3s7KpZh
         kPPFxAb2pbj5DJYtlpwaBfzMlK5IoG2kceguNWxbWplZL6z9wE5UGZBi3b/QPSBTuzk/
         28wQ==
X-Forwarded-Encrypted: i=1; AKwUvByrXxHXtGSW0HAmuytgG02jywb7hnUHSrbSe5+Q0cu1BOlopDyD+Sgz3NRYSosOarfF3elQAk8=@vger.kernel.org
X-Gm-Message-State: AFuF++nu7xTlqEcphG1aV+3esIQe0tnGp4s/KMIhNJg1eoMX9EBnHiM3
	M5s1eCVbr4F2lQhdPhCr0eVngo8S19X92Midv1bocy+HaCwLO68qy3h3
X-Gm-Gg: AYBFou13OCPKhNQkAssdjKa0r1WJ9Zd4fywlXdDHovWszgD5wVOXBBSD3vzAqSinZLb
	Zd3Q9yRxx+D6fVIlB3NhvJu5zlqSJCgFlDa3YoqymwQEf8Jz/n0X5AnjQchgifReUBuma37bMvu
	yIgxgA+bRyJ21j0xtLSCEpFbS1XHWQNvZ/WlQi0w2c6ZyM32xjKFRULvCRTdYL/d7HTHH5rgNBU
	Y8G1e8hZKdH9cYp1Q4zhgz/WjttSddH8DgZHnV5Y4IYAktjh66bjVwQnnV8hPOhF/US1z2rpV87
	wTukU/KAttT84VdHSB3xrSwxvEUfmbrUhUHExp8k+WPwcPdwtk0TwiRK7WY92pb43Rs09UyUXOQ
	nKzK8atfE8FynqH5AYuSvZMSb/2V+MXhHFkn9q4mW8dw1iy6XfZ9i9ptO3VZnxNqqJtuzPcHASy
	ryGx4y01wiNEI3QiartzrPxG3nQYeu/qFvoGHFPndBJGN+0fo/LiDkRpOCvHJnpSldfLa/ysdRQ
	aEXC2la3isBgw7HdhZrMZ8pNrfKUWNIRgXy83N6bNkEy52V9xWN+8UT5pw/1VsPYtkiATvowEzV
	ULDeD4x+Gg==
X-Received: by 2002:a17:902:d54c:b0:2dd:c100:b2d1 with SMTP id d9443c01a7336-2ddc100b3d4mr44684205ad.60.1789857274157;
        Sat, 19 Sep 2026 15:34:34 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ba65csm13032565ad.52.2026.09.19.15.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:33 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: ms@dev.tdt.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: wan: lapbether: validate frame length and headroom in lapbeth_rcv() and xmit
Date: Sat, 19 Sep 2026 22:34:33 +0000
Message-ID: <20260919223433.3882618-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drivers/net/wan/lapbether.c, call pskb_may_pull() before reading the
2-byte length prefix in lapbeth_rcv() and ensure sufficient headroom in
lapbeth_data_transmit().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index c3630a82913b..3838910ea7bd 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -133,11 +133,13 @@ static int lapbeth_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto drop_unlock;
 
 	len = skb->data[0] + skb->data[1] * 256;
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += len;
 
 	skb_pull(skb, 2);	/* Remove the length bytes */
-	skb_trim(skb, len);	/* Set the length of the data */
+	if (pskb_trim_rcsum(skb, len))
+		goto drop_unlock;
+
+	dev->stats.rx_packets++;
+	dev->stats.rx_bytes += len;
 
 	err = lapb_data_received(lapbeth->axdev, skb);
 	if (err != LAPB_OK) {
