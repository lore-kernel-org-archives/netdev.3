Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A236DA14
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216405; cv=none; b=D2mkDTErYTpmAtQ3qwLgLlyTpSgG1uVLvC2+WT3+lIEgUH+tlxwPoxjjapGP+Ml53yyDDCPZhAuXL0Z8aQ3UTi6g45FAwgrnzDetggFKVL6a28lxwBGIdm41AhoZMXUVxgYI0LAcXuzHn5oG8ulJ3iqZpaUio1BUR5XASiDchg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216405; c=relaxed/simple;
	bh=VzPpM2GYjcCEeJWlE8mh0m6YvB2umDl21dj1zgLCayI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAO5q5BY9Tiuo1pAqGm2DYU+BwjlnN0T/Yu1wp6XdkFh+nDnX5h42St/80W5/VeLsdRqvLof3LEC3cOsGezR2eAHgLF12XfqfVEM+kQsNQ/qqTi42PJqACDfidbfsVUsoSbtLHgGgKtdHNcfiBCcJD/8mk0gucMejysihPAazJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg1VR/gb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg1VR/gb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4956242332dso20463225e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787216401; x=1787821201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzpmYFmR3xRBQWp75KCP75aMVcwBSxfqQwzCsWsaceU=;
        b=Zg1VR/gb1MLXG8lE+ZKtQLaZbeMdUHc23+2mHFh/GiD5twpsY8kbovoreudRsdcn/f
         5rCKdDNPR5CQ1TR0xENLwMzoaE9Q54N4ogFxWi96HT4w2k6PFt2Ea/VRvE0x9mJe6dlL
         jdGQvudPg+SSsVuRqCJ1wjEmqP2lpPjWcUvm+JAooJiiWVyHrCCA8divFRdVXpt80ou0
         7o66ZzSMpD7ANfDY8uavdmj9eZgBaqil3XcuaS6Wc3N1R3JujKm8NYbLFgmZV8Kt07To
         oXYmrEbdz9x6mEAl2sF6alCJEJvTqAf1J1NF7N7YhBL+US/6ouwkqOd7n91e1y2sCd1k
         ocCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787216401; x=1787821201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzpmYFmR3xRBQWp75KCP75aMVcwBSxfqQwzCsWsaceU=;
        b=CJnw0nCS6mlBgVIsAM+99HMVaYgJQEQhSiUjqI6VEnsSARbfepXnw2y0pkrNWkuBFJ
         v33NfmCwNEIdoj3HA+RDAVFtz/aFrVcekjhjgWyCDrhACF7t6uQJ8IYArKz8yZKYxvZU
         kOtR7p+q12VDTKLtqs6HrXHGFx0W3CO7eU3d9vLkieEAqxptAhrmoKGeuVkuN6cxyZyI
         jwaT807U86QuIrGARnthQ/9irlwr/y8DnSemfHagP0CKttNrk06zqT6vq102iOGqB03V
         h+Cin8qBJxeUWXk+t5s+/4w/Nbe2DOmlLMg+/oeKJxRWu3NOPwXdoR70dEreVI3gTN8L
         D/Eg==
X-Gm-Message-State: AOJu0YwxC68cce4NWrcJUaIz/Kb2cVCAB6wTb/m+nKihMUPoMMzKRxiB
	eQhxLyGmeYey0SgfzS294L2o619izRtvHlY94ta76h1h5aoDhCqFZ5L769TqeqEi
X-Gm-Gg: AR+sD10CQcKOfp7F1/Ib4MigxirlVMkgQ4Ld0nZyc7Et2i8HW61iUSCjWqdDPt+ibEt
	1s4bJfyATWPUd3sP2YWV5wjZrBCRWzsfsUGSRj4MTAp8YktzUzAgN/uux6zhBjiEPZgJ5jRJJfI
	iMU8xJ+koPqTTllZqZxsyvB7cBh9iGQiko2qUtocfShBtZ5TW+xvT4YzPWF7zQRooDk8XjUzfCh
	W9I9kgk+6+Audp9cvEPk0O1FliZ6wJLKonmrpyC2jfOUN1qpYZcNgxUfNhnFyJT63g1TlKhQ7cl
	LAxjFgM+43VkNS+aGczOiFGnnFQRjzjb32cns8ykiKLCukEogSstE4WMif6tdCP6fKzEtKPjRZa
	TFmmAOi5eYyfAWXWA//rqKnL1EnE6yJLNT0KbKOJnZnf6Fcg3FyFgn1e8bbP8QW1s3b8pKoDGx5
	HLOOE87ocNNX8r2OANRb6Yg2wwyzqJLc5Xc4ZhtX5egIGYfPktjN5QxfudF8Q9AYPixDXcCGLhy
	KYOtWG2H197pCOATmUNpbcYVBj/u6/6sv42fjFzKd4=
X-Received: by 2002:a05:600c:a30f:b0:499:b01e:911c with SMTP id 5b1f17b1804b1-499b01e9125mr80109845e9.2.1787216401010;
        Thu, 20 Aug 2026 02:00:01 -0700 (PDT)
Received: from fedora ([46.205.218.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa1111b2sm176837215e9.5.2026.08.20.01.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:00:00 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kuba@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	yangshiji66@outlook.com,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v10 1/2] net: airoha: npu: fix missing streaming DMA mask
Date: Thu, 20 Aug 2026 10:59:40 +0200
Message-ID: <20260820085941.380401-1-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver calls dma_set_coherent_mask() but never dma_set_mask(),
leaving the streaming DMA mask at the bus default. On the non-coherent
EN7581 platform (Cortex-A53), this causes the NPU mailbox to hang
after approximately 41 calls when using streaming DMA mappings.

Replace dma_set_coherent_mask() with dma_set_mask_and_coherent() to
set both the streaming and coherent DMA masks, matching standard
driver practice.

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260814110017.2795022-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260809152813.585797-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed952de..4045d1eb93ea 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -766,7 +766,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 		npu->irqs[i] = irq;
 	}
 
-	err = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (err)
 		return err;
 
-- 
2.55.0

