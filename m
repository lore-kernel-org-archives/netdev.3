Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E231A556
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756466; cv=none; b=h3UwmpxMhcW/JOTCUBc1N89kG6RkJuDceoEe8Gv5WG4z5vlnRNhDLTvsW7ekruoSWGF974oHmezq0xt/NxBkWrUkazwFTw9SL50A03+RezN8rI7sTOja9jL2SI+IojklkRnAeTfdI93vUDW7l/npBfi1rZ9x59bUMOn1Fa/T3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756466; c=relaxed/simple;
	bh=EH2ClwoL3M6yVYOwkre3mOJduO5W/XN6Vq9zM16CB5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2PS3G6dB+4IyNN/BliukIaKSHz/2Ig9gKMU9qYWnjfJNuVdxNur2nXde2C93iRn5Qi9mhOlNdh2Q1EQyjFbK/uyxA8cG+BwyaPeQEC9F36EFRrlje6slM1jaihPTBBHodnl6FmO9dHF6Q03dif0MYYpKSgTs1CDc1gV5QrlTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cc75f2924abso3504532a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756464; x=1791361264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqdxT67lLu+zzttJbC4gppTruXTdwqprw/04FtUuWRk=;
        b=ulvb8iRBmowiYYiAbRzsZQnzxjf8rRn7Z+1oW/HnKqBMwWlEBBne0JbecNYSC96rz/
         X+6PaC/3aJjBOb5QbRWEvZRiDXNcb2h/SaafpKi61ieHZDcgEyLWm0cDlt476E3qYmjj
         idqNY69MiJlPfNgnJplbxFcH+/r41xqt8RNQUACl7F5v0FGUxCT5bsMhZ0/dobSCRAEf
         vMMVG+jE18E0gJPLh5dL8f5rWiJAddLjeyDFN0yIvbPu3onp813DZ/KlIxV8659o2Z+k
         yA2pSFsinjRrNfckKJYsGgCySrAfTXY4SypSkx2sZHTdJV9uL0swLnrcyIdd5hh4FBjt
         47RQ==
X-Gm-Message-State: AFuF++kvdJAPP1Mpw3o9zImH7gtDh/BNY7Sq1RIOAuQalrDl1ny18ZyD
	WhMBtThFMo0rBD3+6UxmqH0AOVZNVeRT3TmHe25kuZxL1f9ccEsRXz6yYvdc5qmVapI01A==
X-Gm-Gg: AYBFou15RiCGOxGckVqDvGJ3D9oE0exCLalZ7UFRusSTgiCyPV3cYM1a9ZAdBwhSZKU
	57V7cqVo5lKurLK0E8yH3MqVjomRg4zecG8r/2M7m7Wp38fkOOGdJyHw005xUvQtu+m7jlSdn8B
	EPI5vjwH3fe14GAmPA0QrqTByvzgutn1Ylbw/aGmMh9TRTBWveqjJLlpwmrHjTYtMEbgEum8qZ4
	IEh4OLc/ZuQIE0/73wWmcULyh/2qaI0IHLElw6yp/mP9WeqeHKxiy5s96D6W/N8vlNM8tr9J7A0
	75BJ2BBNFnIVg1GatD9uYjS6cRaED9oIGsb5LDAgbqNtEOnzAGSc6v8uADqUH5Kay3k2LfME/nA
	WhT7x7ZMxVNBRZpBsNBNmFAA4YgTuQIAID0LoZbMUl2dxR4f6aXk19+x8v6p81x16oRF/4AgAI4
	Zuf0qnO2+UrgrrNTTr8NTWFF+lrGL4RJ/cF/XV3+ejjGae3vWY9VcXO0jgqTYvPyxygfYZ7ROkf
	CHbt21CMbN+qxLPyzI=
X-Received: by 2002:a05:6a00:2e2a:b0:886:cae0:fb69 with SMTP id d2e1a72fcca58-8874d0abc1bmr420479b3a.44.1790756464283;
        Wed, 30 Sep 2026 01:21:04 -0700 (PDT)
Received: from foxmail.com ([120.239.72.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8872643904asm419955b3a.45.2026.09.30.01.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:21:03 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	talgi@nvidia.com,
	hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: [PATCH 1/2] dim: clear irq_moder on init failure
Date: Wed, 30 Sep 2026 16:19:51 +0800
Message-ID: <8d6a637142c411f83771fda5b57bb4451651488b.1790751008.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790751008.git.shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net_dim_init_irq_moder() publishes the allocated object in
dev->irq_moder before copying the moderation profiles.  If kmemdup()
fails, the object is freed but the pointer is left dangling.
net_dim_free_irq_moder() treats a non-NULL irq_moder as live, so a
caller unwinding the failure path would use-after-free.

NULL the pointer after freeing it.  On error the device is left as if
initialization never happened.

Fixes: f750dfe825b90 ("ethtool: provide customized dim profile management")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 lib/dim/net_dim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index d8d4f6553559..bf59deae6a29 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -141,6 +141,7 @@ int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
 	kfree(rxp);
 free_moder:
 	kfree(moder);
+	dev->irq_moder = NULL;
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(net_dim_init_irq_moder);
-- 
2.43.0

