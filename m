Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208300;
	b=T2WA2FWMeXN5U8p+dS7GFw9LhtqxoVDwDU+sARVBqUAiAsJq3qJZI5gd7GSmUb33Yvl9
	 9zZQzHRE5bFXhyWHHHAn/Wtf6m9Wu+kTfB75LBDJzvfDWZ/9fjvjq6leX5hnqK3GX9FQu
	 bFLx0QLno8c4KML2bQGgmgs/M07+MBs2GkRFJ4RWxSLvTtktxBGdQb/0h6Cl/nHhh3Me4
	 +sDxVw5EJd7Oni3+yOwE0keL2RwLWtTvDsH3zUU28BiIh0TMYXrqm/uw+GONFWBbc3cmD
	 loTHrv6a22LKexkkp+t0ZFgkMqq/kNuJyxzxa2ZHahyajdtlf1YLWyRXijfEiIAI0Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8OYFe2XU1DYyJ60n31cK1Ueu0La+cc+ar5c9yH0L4lk=;
	b=Lk8TkKSif24KQ7I9+2DMPJI7T7f+39J+N7pn+Dc9H3g08e3rpHJAOHyAxCwqBK/dpgt5
	 SMXNO4PqoD/1x1wskBbb1m3VRdTCrGwIGeg8dsWPTe3QQpiuK11ceSFiA5XyVzE4+CfGB
	 0xE0gHEZc3UIk+NqZbk9VSsFjFBanrCtXqdbCtL4BAEdpXgu8ceCB/uRK/qOvgtim9BkA
	 xITv1DDYtONBqLT763CQ/PK4Lhc0NZHxRxwXJjIbbjRNyqgQ5JY3DItwZmISkY/EqyLWq
	 7jPF8tFMcTjRtDcWqZT9df+uQafxIiQ2lCQIQXaNLk8DjYB+19oiwv+D37CsxWtyGag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VPQYYvpx;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE01606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE01606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VPQYYvpx
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492f0a1b685so352193f8f.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 23:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208298; x=1794813098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OYFe2XU1DYyJ60n31cK1Ueu0La+cc+ar5c9yH0L4lk=;
        b=VPQYYvpxeyg2AEnNUpLQ6j0jv6Se1SjL/cTZJyLGelqwJh+kyTNxT0k/2I5gXttQI9
         vWb1t2ujfG0eoCIqxbGdeKF7T/4wHvrDnPp9G+i9CgYqy9uP2krVS8sdPPOzjq27xk6w
         T2JjN/CBRQAd4DsVbOt6IZxftGnw5khD168aJDn45D0CCckgwukbqx1Ge6vn/w7eNK2p
         XGsYsKFXYV33N+mb/K9GzmNlIFwwb2bMEi9wp6r1FDInzYnEdQ8RrCpO+diXzpdrv56G
         rwoEZwDiTYzjTygBd2vwNBIaNZI8aTilCd6QO10TiiWFoYsDZTzr7vLcJ1qsfIrNTRZq
         kw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208298; x=1794813098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OYFe2XU1DYyJ60n31cK1Ueu0La+cc+ar5c9yH0L4lk=;
        b=E2zg7gRuqBXYG/H8NDNzuNVC9U3DEObU/8Kuk8/D2ESDh7r/rAM0esHBgRENekUgfN
         oM4J7H+fRBvn5qIaVirfJgrLnlS8WPe5LAnP4T4LzXEDhHG4CW5pP9Fm37V9RDKKlRkt
         L8bL5u9pIYUnoYv3RIXBPuNm5bGDWL+sqIvEVC5H5+ykuuejy88/qvA8CoA02S/BBwJ9
         lNtmq1/JJziXy4ntj4HzWwDHXJl7F/394I8vAIlwLIecFY3tz+E783IO09EmaP0BM5Ju
         bLSfadvftfzp+7QiuaL1BO8CZMjyWVA61UNV1xWW4xTkAwzKzuP3yfPoGZSSF/uYIy7r
         fJjA==
X-Gm-Message-State: APuU4Z/80HPxdz7Yra3V3Uh4ZHhlpFQJ10XsZ7bJlkCw4+D9Fr9qzH2I
	8Zxv8ftkRfdbcGGlL8EWANlSoFyetL2vnvuP4jMuimSN7iskXEQ2254ts74cPg==
X-Gm-Gg: AYBFou3Nt29aW4J0b/rFM/tZqbcfpx0juD7Sn2QXPOat6C2UOV+9hPow8sxD3K7p4C8
	9GMyUTlkVdjJLY48o6JUCLugIoI1FWQvyejyO3WPzD5RPn+bQh1Eel74awX/pQkYPri/THwy4Eb
	q95QcXHEC2XI8HVs/Qd+ndE4jzCeufsc+1cUbXCiAK46vFX4TuqQ6wYVTlpJTf3XwkWeYNyjN+N
	ZwUgtU4s/6Ou7NL7F9HDBFDEy8F/zoBK/bq45ZEcvl9qPjtSiV8MxfqWKVCk/QxN+5+GrYvrRSH
	R19FQQ57CfZObr+TzfLlwOz+EOH5SDa2J4TIU7i8AON3yuqrj9QkjpUx+eq+7rMF1upFcLACpJX
	lp/oYrlitWyiU6xeDfqiBusD1DZ5GwX7bA+0si4xXETqD6Y411BEDMUTtcse7kDSAXy3RPsdm0V
	gvN77Hk7O0ZGsolDpTZRQLbAmWoz4tQYNVqXCoFBqVBj+m1bRvPPBQTXOnWwmCjuUZlceDqvMNN
	EUsbR5IGe8X6t914ShRmpw/MQNnOYRpO+AU5pLFzezwpZrTtL7WZhAN7DauRp14UUdD4FBwqyz4
	bXUwBSzipeKUyb+Q9SFq9GUYgr+8dHK/pyi536xvUNQYVQ==
X-Received: by 2002:a05:6000:3c5:b0:490:6ed6:e568 with SMTP id ffacd0b85a97d-4958c778ef0mr5598800f8f.52.1794208297974;
        Sun, 08 Nov 2026 23:11:37 -0800 (PST)
Received: from localhost.localdomain ([2a06:c701:474b:1700:c04b:c764:c130:9d10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186ec5sm8368341f8f.33.2026.11.08.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:11:37 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: netdev@vger.kernel.org
Cc: akiyano@amazon.com,
	darinzon@amazon.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net-next] net: ena: set admin device pointer before queue allocations
Date: Mon,  9 Nov 2026 09:11:27 +0200
Message-ID: <20261109071126.87125-2-thnkslprpt@gmail.com>
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

On the first probe, ena_com_admin_init() allocates the completion
contexts and admin SQ/CQ buffers before setting admin_queue->ena_dev.
Their allocation failure paths log through this pointer, which is
still NULL. A failed allocation therefore dereferences NULL instead
of returning -ENOMEM.

Set admin_queue->ena_dev before the first allocation so the helpers
can log errors and return -ENOMEM normally.

Fixes: da580ca8de2c ("net: ena: add device distinct log prefix to files")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 297fb36ab8c16..23b3ef50b8b6b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -2000,6 +2000,8 @@ int ena_com_admin_init(struct ena_com_dev *ena_dev,
 
 	spin_lock_init(&admin_queue->q_lock);
 
+	admin_queue->ena_dev = ena_dev;
+
 	ret = ena_com_init_comp_ctxt(admin_queue);
 	if (ret)
 		goto error;
@@ -2045,7 +2047,6 @@ int ena_com_admin_init(struct ena_com_dev *ena_dev,
 	if (ret)
 		goto error;
 
-	admin_queue->ena_dev = ena_dev;
 	admin_queue->running_state = true;
 
 	return 0;

base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.43.0

