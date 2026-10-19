Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEC4CF490
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375312; cv=none; b=g5Fu3eV5zIEVZJPxkQ2co3+8Tz26hI6rzMEL9zsfSmjS9RTK9xkIDvsBpRkX3MBFplRI5MJ5aKSeQEgbpk5EpCngafmGxuPk/WUVa24969G9XFN5ZpFaMj2s/KDAhxfgv0ZuN3c+tFgQhYy1+Vs5gC6RnD9s1FMYAmwKqSYNY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375312; c=relaxed/simple;
	bh=Edpgj08Ldip+n177eITHmraa2Y1TOk9X7F6IHHHcGgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXR+DYDZa7+iU+a7sgm/HDC93RbyYI56Ha98l65AWU6xq68eW7HlX5/ONNTYmu2DF/RwvaQNK+y2HzZM/xeTjLUy7W6FpECTU4l9p9K9T4xxkzU3Hp8WsSUQV4l0DlsM6LLynQvGMrrjorzlAXI4elagjA0RQgpECq4EnGqZ+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR7xsXp4; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR7xsXp4"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so3894833eec.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375310; x=1792980110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lI/WkdtlMsNUr1YYA3okLxJjK81+p7pTaP8W8gi1+18=;
        b=KR7xsXp49sZqmriMvN58iYWi3XGysoh58xjt4ACKonW2k+H4C/RfSqRZZy2f70wMNk
         D0+fsWfuBiAWrc/u9wsZvekUYxfrTOPKO95WBdpfEyABrluBJ5qQFTJvHKemtW8/W/vf
         0Ughm9ePfsVSV3xbn6t1ioxqmdLJzBoIm8aHNZHiURO7epLG3S163w6WE82U0YioTq8i
         RtMam402XNGYAPM/yH367jzdibuQTx5U0LZWJcDkw9iKlUqKpR2TQRm80qgKp+qKCh1V
         l34ghjW+yYRZNVPnkgqSXxS90SMsrvTSsaEJvI3vBeQcC6klawwEURTQ2xJpBUWhA3Tq
         AdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375310; x=1792980110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lI/WkdtlMsNUr1YYA3okLxJjK81+p7pTaP8W8gi1+18=;
        b=K4L22bk3kIgSRWMun426XQPv1mJQDUJ9Ppr1u39w7Eob+U9J2r3f22al8Yzc1P8GVw
         iCfoCvCljHPEi3YEbaAYBwAeqVDtYLw9r6n0ZPoIeMiwccogy0wYiedHWlZBRjRh/nla
         rQA7Du8DbeXNUb6n/Rm3zZiZ/rcfGseeBpioIi//3uti7tpQLcxYtC4GUWIejW+exZvG
         pH0h6LeWzTQPCqIszlMdGzDk4vv8ZRzs7ZR7j2CwZb1ApTYpGjR1s+Tn89QsYcfVWSsX
         BaE1aJ3JwnQgZizqIliFzy6nsLoZ7ew4fZEPYNZu+8XPFvYw2rGwJzZIFQjTJhY0ZKHM
         COiw==
X-Gm-Message-State: AFq9FYLJ0FZaZ/hHXVL4D+7y4O28FmTghMtQY33AeJaQNX3BCSkbJ/mK
	qyCx2ZHwL3/H8ji4f4H4dLuQ7+dMF479pUywRcecz3GX26Mfw5Zro48gdqhZyDdw
X-Gm-Gg: AYBFou0nuiGPokqoT1HSs2wKiqUt7QTjL1KhfjnBCpKHNZoUMVfnL+YIoZuT6GYe8bn
	2UPNF73Gya3fu2A+Q5CjQND8APoBSIadqQErnQIYfvHVRRkVQFNVYB3Utx5nqO2tdrPztIxoRiQ
	898WTknjUzVmASxtEjfSwxvE3oqbAflBQXTITu8JSKZwjWtVKe5wJGKVqRuqeW5On7jChP68ASy
	pL769niWQm8Sp/VYDjCOzxysr64q/uZTTBI/zEPdJJo70c8vI85DVRg8m+xqiDSoV8Kuxs8Z2uG
	sX8AHXjBH/f1ww0sXp0Vtv7N5CalvSo8cJxMyZaP4KS1xfUV9U0dsoW7cY0/8ro/fQ8Z/45zPfF
	wWcgk07QJIaLPHtR7mmJOkl3Wl5P/4QFmjUE8+Aiyx9mhM42NTDtIG81XUmzhgF2qxbEawYV67N
	LlWPW40j3Z+1Hu9SYFHCWoEliOYvA6/SnN9rQWLgZj0jZ+oPQcr4HwyxAasyEohcUoJ4h5ip76I
	nqVz040ha9Ew3Pwc5DEo6MbOrradYGEVxcFU2xnPWArNIoNClHZTgYTALJ0ertXhVD4XHn971BS
	Gsvn2KiuYmQSriBrCIkfX7q+l4gKKelM5N078OIT0GJZx8xLvA==
X-Received: by 2002:a05:7301:53c9:b0:34d:de2e:1fca with SMTP id 5a478bee46e88-361a1b53139mr9460560eec.21.1792375310141;
        Sun, 18 Oct 2026 19:01:50 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm29108094eec.21.2026.10.18.19.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:01:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: ag71xx: re-enable TX interrupts on RX OOM
Date: Sun, 18 Oct 2026 19:01:47 -0700
Message-ID: <20261019020147.213746-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the RX ring runs out of buffers the OOM path calls
napi_complete() but does not re-enable interrupts.  Because
INT_POLL masks both RX and TX events, TX completions are
blocked until the OOM timer fires (~100 ms), which can cause
TX ring exhaustion and dropped packets.

Restore TX interrupt delivery so the engine can drain completed
descriptors while NAPI waits for RX buffer memory.

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add Fixes: . 
 drivers/net/ethernet/atheros/ag71xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index d93fd91ff884..5a33759be3cf 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1746,6 +1746,7 @@ static int ag71xx_poll(struct napi_struct *napi, int limit)
 
 	mod_timer(&ag->oom_timer, jiffies + AG71XX_OOM_REFILL);
 	napi_complete(napi);
+	ag71xx_int_enable(ag, AG71XX_INT_TX);
 	return 0;
 }
 
-- 
2.56.0

