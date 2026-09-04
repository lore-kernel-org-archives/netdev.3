Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4B488231
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523166; cv=none; b=Aaomav8BTfefqkghb8YgwJ7LYzgM0s/t2AIpVUkRX3NRhQqrfspVwt2zudAnqmZiTQC4hD6tCPKawN/j5kJ6wgSf3gCr8D4ectT5D3HEMVjUBZpq4RPoXzau5RN5lEEglLJmy2GOkSDHU1naWlZTKtHT8pOqJLRfviT4dZTpTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523166; c=relaxed/simple;
	bh=kB1MKI07S77deBJkcRp4alvrux7z/pJIPbNfJVdZkZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVZTDQk+4THddDtFiRVpU3W5sR0wzRsv0Dyywer97pDtYYTIZTKSAauXW5QMQ/sK7erYQEnWNpvj/oa/QRf6gFPn8SdVfD/OYv8WeRnU12qtb/wWOxYbn//dmSR9j/ktof0zAwo0EsT1rkawVuRamW9P0+SZW41ezrMjWTKT+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEKx6TR6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEKx6TR6"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1015756a91.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523164; x=1789127964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EnusHejKpGyh9HbEBCnQmungQzWoz8PMUq/SwTBA+5g=;
        b=OEKx6TR6CE7g6OGH1vAgBvxKX9Uj529HHTo/QdwZIsnmpsCWxmR4qWOn8kvfjWhh1e
         eL1BuKANHoRJ3RrWVl1+2EaBcx10yrEFnMdbcwTYm4421K8AYhiGLzGweyqntyTYKTaK
         spdQEgE0iPUdGxEPdXC1WavR9yrqSpdD0j+6cLKWz44WClGRDAmNrSbGt4deHKcZLlwi
         gwfopXyNVgM/MuxgNOxFMnaZaVa1JdOu9EPjVe+mpbALkd1UbIIctyWLBXz8n+8yvF0k
         q+DHMlpMzXUTIZfWHSV3H37gg51qDtBGo4+S26CNkgpjfipFX93cneTuaU+ZsfNhe7cm
         +tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523164; x=1789127964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EnusHejKpGyh9HbEBCnQmungQzWoz8PMUq/SwTBA+5g=;
        b=lcFI/YGBUX0DNI4mHfDbiX0yOZbOf1w7yBblvmf4jRzBuScqQR6CHQPuheno44rn8s
         IHr8bhpr5E/M6SYK/v76uL/5Wk46w5HoO90REyuzfCRhxxMvX3o/Ef0M9pdz8RTWj+/7
         dgImdTFzck76U8RYbaZmZNkobHyEwt3PyCsxA8P1jYuwazOI+DwdmfMys456c6Q9nfiO
         x2m1wtH1+6LjaSetAUFb+Gdcxaau6M5LCCqe18J6oOvDYXNy/egVwJ5Ca3yKwvAtHBmo
         aTCmBibuJvrYrIHxip5Alw2/MAZS0V8Kqp1EmyD5rFcWwcS/LeLLczgwvJ6mkogPVwyN
         4dVA==
X-Forwarded-Encrypted: i=1; AKwUvBxojBwju7guNW1DKliHrWmT+2IKuv/iE2UwWb8vq/VtsXxk59ZIjCZOfQPdubf42hVDSoOV2to=@vger.kernel.org
X-Gm-Message-State: AFuF++l7X2281h0x1bdc6+6eMt1xyTLv5WqPhl3nGjn8DOXdmsbbPr7i
	RkZ4xk2gzImvsWeXM4sxhL4cw7jNUhPJ/cCiD02fGHSI3RvsPNbs0sr+
X-Gm-Gg: AYBFou2pC2qQwwdEo8dYWfHjMo95O92Xc3vKzLo1vCrHLbjLZiHRT+3CmDWFgHitI8y
	nrUphChikkLLJgs3UOY4IUi6m4YNzK2brRGRkjrusNNJHbAzNckgTX//++KKK+gbXseqUWAcBjv
	AuRhNGFowgYt1AuAsgOKW0naQyVozQdq+Snsx6yFFN4P2ynBTbv5KYqMgoSltXhdnm9eRMcYFU6
	MQ5grAdlWKViotlaefQvVqifO3iLLQrk9VvNKIURc5NNkGdAIUjutUJjzqUAbPchJF3fy98TVDP
	K8Qqlwvhw9/sIZOzmkQxx5fRfdmwcDqIXwZPc+RRSkbLbRBa187c7bx3dnRahV/LP/zc+iQ66MM
	lyc/IQu/0BPOfmnJQaGa7txItbGsQ2wyp0Zws5c0zlU5v0nJ5MSb6uBDsasYzugp8AqIdZf8qOz
	B4Y5PfVScsjDqVrnWsMMfgBSbSSpuYx2/htIQw+A406xoUu+F2UoHd9YQFyuP00I/1Z9GMOLBxH
	H1lMKzAjQl1c4A=
X-Received: by 2002:a17:90b:3fd0:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-39b07fed101mr14362000a91.10.1788523163577;
        Fri, 04 Sep 2026 04:59:23 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339c0ec914sm7034122eec.31.2026.09.04.04.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:59:23 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: cortina: fix typo "trigged" in comment
Date: Fri,  4 Sep 2026 17:29:16 +0530
Message-ID: <20260904115917.13695-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "trigged" to "triggered", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/ethernet/cortina/gemini.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.h b/drivers/net/ethernet/cortina/gemini.h
index 24bb989981f2..d359c633c5de 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -726,7 +726,7 @@ union gmac_config0 {
 		unsigned int dis_rx:1;
 		/* 2: transmit data loopback enable */
 		unsigned int loop_back:1;
-		/* 3: flow control also trigged by Rx queues */
+		/* 3: flow control also triggered by Rx queues */
 		unsigned int flow_ctrl:1;
 		/* 4-7: adjust IFG from 96+/-56 */
 		unsigned int adj_ifg:4;
-- 
2.48.1

