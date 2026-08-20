Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D0415B78
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224586; cv=none; b=HRgyWT4pBpzdZ7FWuPAAZh8kEqgVBWimJwE+ktrvU8a88l53pgbso6adckIFMIvsjEnX2tYPvMlDE5hpYoALkbYttfulFOuaRzrQUFO/mF6/nPiv+BER23sDoTf9sRQdhEnEUz2CLYHCPtVyxc/pb9YG9x46hlWZEyTFRYdTuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224586; c=relaxed/simple;
	bh=ppue0JSqwEjX5KpVPCrk1v1pQBRDVVORRdtVZNi4u3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egTLiU3ebxQICzjefGalu08g7VGs++CaF0fs74gN9Q3oGFS4IbR5BLeLTcbxiEmtJHDoaiUmwEGmIIjqy04EaNFhK9j9+PjBkRV+QUybOtg5ffoyLSQCY/IWv75W67B0jY3eH0p2Jb+BOU/oprEgvOdiQPWuu9J2GgISg93YYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPkSKk3V; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPkSKk3V"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84faf87d19dso2128805b3a.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224584; x=1787829384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tLJE4MWDqQkE9SdIsVgvMszarH9pKrrkx4zPhYzjrH8=;
        b=rPkSKk3VQAMw+Vcpoo9/VbGkLvLeW6mBsz8tKFlW0rz099kofcrScwA5pzlksGs6XS
         Xk2tt6m80eIZEdknba4lvQH7etNmZODpJ7CuOiJsXT7a1VjkBb+iZiytdVlT6OYYJP7J
         /GTGj897hDOdXPXE8+NrvQ0hW83I7bTY8lSlc/exH0FROPbRDBeAsa+G8ETgiYbHTgCm
         fgvsO0Iq+bORfq5K90ZEbTTicZ2jnQ63EN3pY+sGCzYAAurXVk2wldP1kJJSETqzD0uk
         opWSLyV/g1lafnpJe0RDuZx+964I7SYYw+VIKoACLRqL+VirCMgn34ioPKuWZN8se7DG
         A6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224584; x=1787829384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tLJE4MWDqQkE9SdIsVgvMszarH9pKrrkx4zPhYzjrH8=;
        b=ZVQlTCWL0nBpY1guSynp8zS/asLphg93T9MdywEit6xASPda90zWonElTDUIppK6KZ
         y9uS0bNUf9IIxcpNs1xh7VZs77Dyj7aW40LJ/mTwV/CGOVdCX/wY4fLBzh7Gt4wzx9WK
         CW/UDCKkpz/B1SslgrMSvCWlVwdc0evulx6EJX53F8zLzRsvrtRMyGN6+AvX/33jBh3k
         OM5vxp6zZlLqKvia20+jV/5+xs8JMSri+M2/NcZ/wNXJ/mljyrVnrSzwAHbFenMBBXz3
         JDDlLtLQCxvk9kEObJzWvTfZ4xqGTUCg7qzBKrd9NZZNkK6rhvj56mG95gy2PjdkUIvk
         gadA==
X-Forwarded-Encrypted: i=1; AHgh+RroYKvmoAUOUGsp5G/OgkNJIg146aRqBnxgZkn27U1DWacMMyOm4NZ2sJNnCB72woVqUM6G36k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2HbOIX3nGXMdpy2nOCkzrJfQRbMksksWkMrIKFv2JDmquzRmj
	vWyoHACe/pEi3W1fHzWgDEqBFc1J4nDoXDXE8w+OSckd/TJrF1UiECNi
X-Gm-Gg: AR+sD10iowWKBQsPg4Ua3cn1Mq0Kti4lFmXKFzFDV/jxy+loaqhHPen/eRn+phmKyGu
	4JfMbQwG3BC1lgA7ap9dIIKj8KwJLuMRaS2Io7McHIn+HkFXt9lqvCZlwtD54aZarV+sQdk9r+o
	f3e+2uXOyeUKbpOQN0aaMNIxhAeo3BP7ohD1YvhIZ33v1Yet9zKEKF8EagZVaxEYECRdhkIL10A
	qUjcjtOXu9F0sGLb8azfNjNva5PZmZ0WVxIhO5s4qAgd+D1aNeJrcFfyvD/sDQYJsJleHqJot6F
	mc4YOGznyxR2ye2mNxx8f3bPEMdVDKRReYHs/yPyqJtOcyOsBagirmU73jSW4hlBCmbjjHgBKwr
	NHgkMWVYWNTSsFtKHCcOXuvD0+rqlfjLzDkjI2FQbrq+afTsP4TgziebVZBYA3r23nZWQHTtysA
	VEud3nOZBk3o5WYemyPSxzwjmAWwUdL9C2o8Z7pDcVyIuFYNLc+DRiJrhEz8zpVl2hU/EUpdf00
	rpLoSdhr9x2MVGETVYK+TNbES9O+y9w1X21rbbeKpFA+4jK7OTvkg3wqwsxfx/2cco0SMbZo6jl
	Ymzr
X-Received: by 2002:a05:6a00:9515:b0:84e:24f:2677 with SMTP id d2e1a72fcca58-851d380a098mr19994118b3a.4.1787224584420;
        Thu, 20 Aug 2026 04:16:24 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d366f028sm1509554b3a.53.2026.08.20.04.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:16:24 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] net: marvell: mvmdio: Handle errors from optional IRQ lookup
Date: Thu, 20 Aug 2026 18:16:12 +0700
Message-ID: <20260820111612.98011-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available. Other errors should be propagated so
that the caller can handle them appropriately.

The existing code propagates -EPROBE_DEFER, but ignores other negative
errors. Propagate negative errors other than -ENXIO.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 2ccb8c8f5feb..d59cf332d1ec 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -373,8 +373,8 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		writel(MVMDIO_ERR_INT_SMI_DONE,
 			dev->regs + MVMDIO_ERR_INT_MASK);
 
-	} else if (dev->err_interrupt == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
+	} else if (dev->err_interrupt < 0 && dev->err_interrupt != -ENXIO) {
+		ret = dev->err_interrupt;
 		goto out_mdio;
 	}
 
-- 
2.43.0

