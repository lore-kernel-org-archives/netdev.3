Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C73B47D3
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953066; cv=none; b=c3uKSreE4h+0F+vsi/CQlz/nTrLP5yGy+VfRUc2DsLUAg8KXdsChzlaOMWXML93E0CmWpWTTZaDh7TTGgo9Q1ykcR0d/ZrExRFzpgXT1z9NyNHUBgjmbNo6Y+JZKbeaQ+pnREY4yYUe1liwj8FRTMr3naK8AtTFiUEoFUAAr1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953066; c=relaxed/simple;
	bh=KqGtfRoq3jZT/Dml4qg+Mxz1uCIEFJzeVXIq0OKduLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ClAn7X4punNgL9B2GZZd0UqVMobdtU2zheTDQmD5V4nShZt5bjzDtEwtgTC4r644KQH4W1hmPCrNrRSggikO5I7hLdV/6S3ls52s8FgC+F+/LPyUgQMR2zGhc0Og+xOwf6536ZAeW2AmXNBG6GmQ+7qs1w786h5KCH5PBYIzy4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT3KZzX/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT3KZzX/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4998e0916faso13914145e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786953063; x=1787557863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDeFtTnxMBvDDeM+UXcBJoOG/+TlVBVJ2Mo0e9wRHls=;
        b=LT3KZzX/BjyCw8+wKR1qFBm+3/AuNUzbGuIiN7u/jmEolL5UWMzmf4XaLydaQoKV3l
         5Z3huDM1a8YrbkmkPOYPDd59w63TfioL4QLiuwddqD6W2vHk1n+hsLbQVtNbVzaFE0jZ
         cozX6D+oOoCuV6yhMW+KBFvhqlpr8RzsDBbGKLHesXWYgjxl0ltMMlvzZpev2N+tkdc7
         VTHtCQ/U5yC/3pztHtLBlbBft73dcF6+kJxM7e6DUvDGFl6/C3n6YZKo4dzRKm4q2dv2
         ydy67rbfies3oTvm6MnHV99ozwh6C58IhoscneP3xmYZedJY03H3r5bYZJDjRYPn5P0D
         vQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786953063; x=1787557863;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DDeFtTnxMBvDDeM+UXcBJoOG/+TlVBVJ2Mo0e9wRHls=;
        b=qdKC3MGV25xM9WF2n3BB6ygGdhGP25upYTWC7F8BUhK8z2vGqhP3ZEZlfq7ama1JaR
         WiwIQGvA9eWVTcdwf/m/JNZqio+QrkiLqCjs6sFsrdde92XTYgsrJtUmQ/jQ/CouRmWI
         /y1FDD7OeqTeNV6qxzHj/Dgt7+mQIlOiAoZGvhC8HyX+fUgi2NiiaCG9uqnwurNo42v/
         mCZQNsyTlas0SKMyRV300cyPzIgomh7k9ciQWh4vTaAJ2WMS7gm5IHXB3cPwjAMqcVyP
         82UKYMV+RaUfvx1TBUnN8JmWoxdrUy7xSAhaoykSK+JE6uzA8jwoY7iKbzj6nlOBgxea
         jt0w==
X-Forwarded-Encrypted: i=1; AHgh+Rr9dxSjkgcstjPpUt9bGMYzQ05LcU9Kl5Ss1YZ5wbR94noxxfNPZG8gmR1HVXgETFdu6NQvYik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzziNqfZNxlkfLxvIwOUVeFuXlx4R8duj6JOK7s0ItpXsP92m6Y
	Z1CiI/ku9fhVl3n/p23zt8LVgv3QzjqeNcAywd3QUyUWTFtHZU0oHHaq
X-Gm-Gg: AR+sD12EQllSv2FrHrfIUiorXFflzzANmaUawPwM7bBVsjZZ5bQE7WYoFpktPus4x6V
	oH7tMr9/JWXOCNrLW7TSF1/gBsXFimox9AUwdeYJIwYvDzv6nMFbVa3OW4jtDfICSrZH6Qrq3oo
	zk/8c2JdQxxP1O9jm1lBQhuAVyvkIR+DfxpPUm7ScFDLK7PKhjvErbAoEMqN2jOA08CIIKA6eWg
	meGNubG7sKNAQLZcXvA9oyxYWjUQikXn3YcQvW/TNqkBAdDFHBc/g0swQPhipoaJ0KltWRxZK0M
	wRz2KQjQNcHz0HF5+ON+XVnx8yvM0fCwhcW9t3GN0uWeEYP4kQUDFBkbwqMV5TSZhL0v0awbywv
	tZqLy3IKaw91V9yaUyweXB7umRWAMVrXYUgrhVhSoKqKnZCE1Ve7WOO4ClhGFZZfUj32rln9e9D
	YyiqDUvVpjQIQrnnyqDeuNSqc1b+7tOzuuUGhRcWkvKioxPjIt2EuQHhM1+Tn1OavFGHoezrptL
	4Xldks/VV8Ts8i+RYz/15pD1MHP0AUEJ/130N79/Shb7nYUYanHkPi0
X-Received: by 2002:a05:600c:3114:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-49987971986mr331622695e9.10.1786953063033;
        Mon, 17 Aug 2026 00:51:03 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-40-190-175.business.telecomitalia.it. [79.40.190.175])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4999d11f073sm22486255e9.15.2026.08.17.00.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 00:51:02 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Leto=20Liu=20=28=E5=88=98=E6=B6=9B=29?= <Leto.Liu@airoha.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net v4] net: airoha: Add retry mechanism to airoha_qdma_set_trtcm_param()
Date: Mon, 17 Aug 2026 09:50:39 +0200
Message-ID: <20260817075044.17691-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leto Liu (刘涛) <Leto.Liu@airoha.com>

CPU accesses QDMA via the bus. When multiple modules are using the bus
simultaneously, CPU access to QDMA may encounter bus timeouts and fails,
resulting in QDMA configuration failures and potentially causing packet
transmission issues. In order to mitigate the issue, introduce a retry
mechanism to airoha_qdma_set_trtcm_param routine in order to ensure the
configuration is correctly applied to the hardware.

Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
Signed-off-by: Leto Liu (刘涛) <Leto.Liu@airoha.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v4:
- Rebase on top of net
Changes v3:
- Init data
- Use continue instead of negative error for poll
- Add memory block after CFG_PARAM

 drivers/net/ethernet/airoha/airoha_eth.c | 29 +++++++++++++++++++-----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 79418e682f71..302f8c432055 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2712,14 +2712,31 @@ static int airoha_qdma_set_trtcm_param(struct airoha_qdma *qdma, int channel,
 		     FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
 		     FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
 		     FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
+	int i;
 
-	airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
-	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+	for (i = 0; i < 100; i++) {
+		u32 data = 0;
 
-	return read_poll_timeout(airoha_qdma_rr, val,
-				 val & TRTCM_PARAM_RW_DONE_MASK,
-				 USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
-				 qdma, REG_TRTCM_CFG_PARAM(addr));
+		airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
+		wmb();
+		airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+		wmb();
+
+		if (read_poll_timeout(airoha_qdma_rr, data,
+				      data & TRTCM_PARAM_RW_DONE_MASK,
+				      USEC_PER_MSEC, 10 * USEC_PER_MSEC,
+				      true, qdma, REG_TRTCM_CFG_PARAM(addr)))
+			continue;
+
+		if (airoha_qdma_get_trtcm_param(qdma, channel, addr, param,
+						mode, &data, NULL))
+			continue;
+
+		if (data == val)
+			return 0;
+	}
+
+	return -EBUSY;
 }
 
 static int airoha_qdma_set_trtcm_config(struct airoha_qdma *qdma, int channel,
-- 
2.53.0

