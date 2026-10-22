Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658474;
	b=JWrip2DIfTy9v0BIArbalRpPwy0/STn1lrwKtEClVPZ4cEIedSNBPXJGlndrLqwO97o6
	 IVYAQRNvM2mIDhiJgItLToi4DlqEp0x4ZTsAjYB0uhqTqHp+pC/B6CCaCS/GXgP1DF6E9
	 doQyB3y9UQ8FaCtO7neuYQtRdQX5OSniMCMXt4mgs/CgpFNjrB3jhNcEpYczL5sRTugMW
	 SDQktFCUzTFRHVB7aPZ6dL8x6mWJ5+XHOjl9430owSalSSaf2PKx0JnjK/mLQYq7KcJAh
	 yxN1P7Ry2yQiwAMRLAJ0FYoJPAGVLfDb//BMhCicNWkkfb8F4qXPZn9oV1dTR4z957A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vC4h8lGS1ajXS2oicsb2J7xM/pwGBkpjOexFGH/bzyQ=;
	b=O8mvpoiKlkksCF7RzxUxz0TZ7rJKd4vKSDuaEldP5B/B5gwXa+b3aMmytF9LUdhC5CH3
	 T8Mgo7tIAcwA2FDJua798eCc/hz69ojudBG3frZ26nlPuSuWWBb1/cj2u/43Cm7/3++HF
	 UVxC+rGr8vbYJuSfJrylGcGI7SejjQzjoQciGMBXhqSa/MVPAazsR2i7ViPm2PO9KqDnP
	 zw+1njs+Gu95TI5Y5WqI43FE7vs62ixvQRopj6Gs3poI2+kEH+48JpnwrTK3e6aKIeP71
	 o3at4VN4SO0Ohc7NPRclBDcqeyxYyhh9YV1v/Vun34NvznHpexdPkYdmvgudLmWc+aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=swRhHnmH;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C0C606A324
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C0C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=swRhHnmH
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso874936a12.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792658474; x=1793263274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vC4h8lGS1ajXS2oicsb2J7xM/pwGBkpjOexFGH/bzyQ=;
        b=swRhHnmHx+DjLVUh8U0VQ5RiCFwb9iMTsSTYOqzB9jdmyGJsn8qvs/y+ky9PwOMf5y
         Spf3AScLmINfgzBOCybDf4Hd1bl6vABYjyTN77/sl0NGIFH3GQKjPrMlcKZUdfzEclIg
         Q28lD5BakbLttuIYgy8t9F9GXVPil7k0HhGznnAhbYQ6I5Yd/l80MQfdhRO8qTFtRhm/
         Al9mrVs9agv4iCtw3V/ruQ+ec/AUhH9FUEG7vzq728XoWr3GBWnldAFKWcRLxjnXKFeF
         VmZcQDz2STo66zc8ql8Us90JrC6GO+Iwtas+ed5u9yBGnxMri922z+E0tNfhtaRXxoZH
         KA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658474; x=1793263274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vC4h8lGS1ajXS2oicsb2J7xM/pwGBkpjOexFGH/bzyQ=;
        b=bc/u3jPaQXnxsPaEGfad9xFRlRNvKBf9ulUt8x+DEYElONJdYXOXCutgirsDOQxYLE
         1Ciz5EhtjZZnPM//U2QVtBp13of1Jcoetjbf6F70C2ubQDxRTPfLt+sOhVZzpECLqNci
         Gkam7piJDls2JQMDuwdRxE6VdnPdHCzgsjV78hSMLzDg2fSPlrpc2esE/3SY7ua1S2IW
         OKqaq1vIjOhT5Ar/qYJ/woVHyfSfBF+oOK9Lid/Zx7sJCEErHNAkjyXi5a4wtnP4SDVn
         UzcCtqR8qj4tRa04e4XM8hVOxN7WYjrsCYAK0QSuDv8Ml/gUWVBqFAScWjf+nXRIXJ8C
         SpBw==
X-Gm-Message-State: AFq9FYI8z4txxNmpA9RCGK/aJ0CW7oiUmaZidbf3XxANPJGGTtpwK3JE
	iuYcpxw8GBNlKy/S3VH4ddIiVA5K0rlB+nNb3/ybWiwJdS0iNFLTJKyvfyyAUQAA
X-Gm-Gg: AYBFou2KAVtKw4yVGn/QAfZ+SkhprrsfOdiwFpaLY+EB8WB1/1DqP6B/L6dldtgj9Tp
	mXMRPYxLvoXG9x5gYTXXdtoK6OxJgP6uho+OfsjTbcjahsTr1QwF0wia4yX6Oa/TsqKYTpNq/p0
	N/lRCphPD1kXP+02uQrHcpqaotVq5iRzvGsOhgNhDzAj94bORoA5ODme69ujCfYkLERpWDa3aUW
	b1QKlbCFhCuALdFfM0wvWaKNY/1XKDWAZ4C8mcf40znWqKk1ZNhkNRAB99D48Nd4KWV0/SY0lmw
	5OIKAfgFKH9fTfagEpQd0ptjr9up4kBd+wYbegL/IPRP5xI4eJ+weNN+L61oyYrKgz2CKVvaBVN
	xHh/AfMSi62fGwSV2Qd8WW9zQzakwAOPXUO7NZFZ7rumSbaOBqci9HF50aAVmfXKxoGvUqiLLmk
	fbYPIGtTBByDOFreiPzVwziv0OzlCElZ7cqcYG6AkQxoVNDAEnkvvmojZXLmyM0+uFFr023hVOL
	5cD27FYdsLX2ziET3DV5/Cbsgyi0pr0Y6GQdsk/w1g3
X-Received: by 2002:a17:90a:d885:b0:3ab:4f1:4f7e with SMTP id 98e67ed59e1d1-3ad86f66878mr3777020a91.28.1792658473846;
        Thu, 22 Oct 2026 01:41:13 -0700 (PDT)
Received: from evangelion-g ([2a09:bac5:40e3:a82::10c:51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4933d16sm3266344a91.13.2026.10.22.01.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:41:13 -0700 (PDT)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH] net: 8390: fix kernel-doc warning for __ei_tx_timeout
Date: Thu, 22 Oct 2026 14:10:46 +0530
Message-ID: <20261022084046.214725-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
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

---
 drivers/net/ethernet/8390/lib8390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/8390/lib8390.c b/drivers/net/ethernet/8390/lib8390.c
index 84aeb8054304..c1b7e3e9ee9c 100644
--- a/drivers/net/ethernet/8390/lib8390.c
+++ b/drivers/net/ethernet/8390/lib8390.c
@@ -246,8 +246,9 @@ static int __ei_close(struct net_device *dev)
 }
 
 /**
- * ei_tx_timeout - handle transmit time out condition
+ * __ei_tx_timeout - handle transmit time out condition
  * @dev: network device which has apparently fallen asleep
+ * @txqueue: transmit queue index
  *
  * Called by kernel when device never acknowledges a transmit has
  * completed (or failed) - i.e. never posted a Tx related interrupt.
-- 
2.53.0

