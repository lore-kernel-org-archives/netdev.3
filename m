Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7015A86D
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216317; cv=none; b=XWlhW+XvUG4LcMUuVG/CPJaZvWT+vrcTLlLbcI5uHTL0utmy5x6NtNrQqgTQEC/mjIsrhuy/xrm9UuWIZDmHZLPnMQpDvPe7xpidmHVYaOk8oAExszVQ+gu4bv/Qlkq0MqZdgeMjh3BVrm5n/KP4Ukox99T9+P6u7UO7q3iXEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216317; c=relaxed/simple;
	bh=UFgwWFaUDHNfS7pe9YQMo1osWM7ZIU7JHCt0yYbjg5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0d667R1DHIKFooX8qWR1LGgF/uHeSJNqdZTD6UBSsFXzqS4wqdcbutHuUxZF/gAsa+wAcK6NJSJesGhtiGdC40Qqs/X/fuCDNadtZJ6d02qioT3uq2pNm0Q4UsIOKQmYAAkYjDjOIYw/zFDWrG4r8MYrFTLLc160tTX7xbc+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WapjTEQm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WapjTEQm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3330692a91.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785216316; x=1785821116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ystWRSu0XGzWLVNCp/qZNWLqhKRo+gG6ngoi7HTHAw=;
        b=WapjTEQmaUuQRP0mz8HApPfyFRyXeWTnQuqPbvtAYT07mT2WZrxziGY8gd3m5ELnOB
         FjdsCRswGdQLmhX0bhBRrltlV6LCJ1Vwx8574OtxsLjWYpFiRPrn9WiyUg7XmeqznzMK
         iJFFwYwOXj8iZjgGp+lEx4yjuN+sd1LJ7xnuMiPOdau4TuaVMgmfhdrpORnmbrvnUc/y
         ZmENDttNVjJfgRzhQUKEvPKQxVUc7uvnIN2gUexUTFZeLgnGTZenx0CVqiwnxFmhkIR+
         8A3CwJAl4n8gl/LRFtXwD8hpKtDO+3NgEfVsWi0JArcyUKGsFs3lVhW4xp61J5e6l68e
         y8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785216316; x=1785821116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ystWRSu0XGzWLVNCp/qZNWLqhKRo+gG6ngoi7HTHAw=;
        b=CyAq8jMO8K8Eqh+qo65VdYhe+vm0ZilHmm7Ou0R/1gLjAU2hnMZczqiHNzEuZ9jNNn
         wZkhQDOjEWTy/zn+WdRVaDXDr4Lia88iF8yMw/2Zo6cio6qQomnvsao8/AglfoP5AnK/
         cDXUjCgXPJCZZIs1vvj6/S2wU2mOOCQLpaRe3jA8iNtGOm9o37io+sk/WBd5Cr/fhyao
         lBeWNx9DS1UcVz5NHg4inv4X78geko116Qsmf+inckmOlTmnwvbaKyG8E3YujjJUWqU8
         QdcK2rGK/4/bO8F4DPp5cxn31s45pPU/zWunmt5wCGjXYCOdlifTgFJ3dU4WXdZY9fYX
         0i0A==
X-Forwarded-Encrypted: i=1; AHgh+RqQ+UL9Fp/dQ6+vitjOXcJ5HskCXy27qN6I/BEBJg5KiqBuSTe/M8SCSuEqoXhf3jkB9Bx2syE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgAatq3buVFDBz9RAPCV9TNpZzKNiztLihhNMyBlvEkVlcuwnp
	a07sia5NBBw5i13YXTVsoqj+2fTqSPQMNKberm3h7OiN/njD9JGmKLE=
X-Gm-Gg: AR+sD12ktjy82Eqo3oHO7rggbSmMhNFNBHQjXQXa6kXpSlpsKb7nNzppEgpb+wv8Xmf
	Rj93ZzVOk7sWygc7jMJrH+2WxCl+xfzDj8zvf1R9d9oZw+twbI2z/IwwX3NXOvb7JXsZsQUDRZo
	h4DwPsZd7yvtXPmgSi67hRG02jSMf8BdYMDnCdncts6BSjiwJVYPuuTqW5pAZraMec96xImDvEn
	IwBbY3FSX+oboBydxw5BQviMoCPlNqYfsvo70OMYoZFcVd0v4WDNNl9UvjGgAu1LPyGss96Zm6d
	vpETGjLG4im66aXoBa3q15/3n/Muem7jGnLQBPSAg2FfK5w86E5CcYl51PBA61SkU9fYm04hWph
	nfO3sCUL6ykqJ7V2dMBURoNTZSW6k3IF7FCZsYjHP/S+hXPQ6vDuVgKtAuzYqXTFMn6CJFhSGS3
	f98a1u
X-Received: by 2002:a17:90b:4ccb:b0:38d:e658:5959 with SMTP id 98e67ed59e1d1-38f6a34e4bemr1207868a91.5.1785216315635;
        Mon, 27 Jul 2026 22:25:15 -0700 (PDT)
Received: from localhost ([2405:201:8018:1843:4ab6:2030:c63a:e807])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13015052sm56592223c88.5.2026.07.27.22.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 22:25:15 -0700 (PDT)
From: Ayananta Paul <ayanantapaul@gmail.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Ayananta Paul <ayanantapaul@gmail.com>
Subject: [PATCH 1/3] Documentation: netlink: fix spelling in tcp_metrics.yaml
Date: Tue, 28 Jul 2026 10:55:07 +0530
Message-ID: <20260728052507.9954-1-ayanantapaul@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "reordering" which was incorrectly
written as "reodering" on lines 113 and 115.

Issues identified using `codespell -D - -S "*.bin,*.o,*.a,*.so,*.ko,*.gz,*.png,*.jpg" Documentation/`

Signed-off-by: Ayananta Paul <ayanantapaul@gmail.com>
---
 Documentation/netlink/specs/tcp_metrics.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
index 13144aeed31a..dddf92bedc4d 100644
--- a/Documentation/netlink/specs/tcp_metrics.yaml
+++ b/Documentation/netlink/specs/tcp_metrics.yaml
@@ -110,9 +110,9 @@ attribute-sets:
         type: u32
         doc: Congestion Window.
       -
-        name: reodering
+        name: reordering
         type: u32
-        doc: Reodering metric.
+        doc: Reordering metric.
       -
         name: rtt-us
         type: u32
-- 
2.53.0

