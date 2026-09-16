Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A2439F86
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587483; cv=none; b=LmiwILLtM7rq5vuB3u7Vt0h6jlOG1Ieki+x3sYLd8IgneLiWoltKWeHrYlvBExdTFq2RDHa1vmTzxyvxifVWvJqfU4shmJs+fk+4FlRNdeuB8kRoPNpES1UbLJD8PWAmGASKUh/EKl1zs/Vi0evnKOVv/BPx9kmTC2HyukmL8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587483; c=relaxed/simple;
	bh=GUUQbRt1zMfb+eBg5VoDPbwqdt+9wQD7eh4Y4Ha+Vco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOGyuWbAH1ERPW3sXw1eA6Zvr+NaSx725H38kanhT0H16L8vVWsmXcGPJTa2lo70X9cRIZDVLm58qYTs8B+IEB5eraIFE6qvFd956wMU289vV6c5d9NEY18G9CvhnsPZqrzL8dxFm7j0QA6hSD1XVsh5EHinDDX6ynJyQcN33QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhxKBbVo; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhxKBbVo"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so515205e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789587465; x=1790192265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqmFViQO1iqqbGZZzEcy3ok+zdPAZK2tv24+QLSxd2g=;
        b=lhxKBbVojw5DhqleSjJ4N39W4YbSbbTIwV3CUz1D20d84WfvOGJT16k9SIB5cIkJTZ
         DDI2qYa2gCBmeu26/5PHlT3Mj61C/YAtjARS48Yt9iD2Gz1105+uV6N74hKo7CMi1r/L
         xpVrze4QT/I7ZjHWrkJ79WeabbVRgQjHiEYOPaFWiXOdwJkFfKdjteP7hKgBIVOUM5Y8
         z1GGksblsVD3EL72cyBl4HBZKxNoEyB5vT1xNoYXCehyeFCF8g4IeLyTdmRKynW/j/Jh
         8GdPILsk+EHMOkJt+o+juNEIp1tkv7x8U2cd8w7/xcVQ1z48AauncTHbqeQ02gkkbNVM
         IXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789587465; x=1790192265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hqmFViQO1iqqbGZZzEcy3ok+zdPAZK2tv24+QLSxd2g=;
        b=CGE7ngzCcWIi17lZ2bg9MjcVt1zOUt23nGDYgBJ4IShcV1+p30L6XyVtIxKr3BIIQB
         PKCyjUMu0P+Hnv2ae/Dn/J3B5ywO/wpnu5mtctreQrxaqjL6Lr1iTXctgQRON8Ovg/d6
         GNCoV6g42mwuunTv5Ugrn1duqOnrDHI2Zj/4TEDp2TReM+eialc4Bd80XVzx0k4b1qi5
         +Ev+Xmhyi5LufydjPL+FqpgQASewev3/heiYdXMMZTbRzTYsp8fVhMv/wKso5SzyFHZb
         sraOYC1hTkDCCsWtIL7UVcTg/BtaJKsagDBeOlmXfj4D0i4gI2Z9KVf6HyHB/uGoeKLv
         wGrg==
X-Gm-Message-State: AFuF++kU7qVNyKVfyGbGIUoNufqGWDOdDjOByoGGQvZpJxopReLtNEK2
	UN9gcMxRglMbPlZXEYK8F9TCwUTMh6t5DZxLC1NyoYi2ahf3saLU0r81mUA11QXRXLA=
X-Gm-Gg: AYBFou2F8lenG+K7ZcjVTvf6IVljR0QLGly14OJhYl09JMvlMDn+0+8KR89DeUwKa5c
	kFwEfiOsjPhFwREEGINT3t91gEoSti9qBR3G54Xnrh0ecThLnq/5P19d2/6VfSFHKn/0K/V21+r
	7NuUtSJzkam2wZuV5yct3ST/qRxWkTX2Z1lfCqcX3HPYJqII/yyh+b+/kgNEgpTacV0VEIJtwcM
	FAr41oTyzLIoDyq5o7OUECRYULaXUy6j67x3urzJB512TTwvJZ2eOZKmdmqXJAwiRkAYfepWU5+
	UIDkTGpQwQU501QcP/e7lXWYcGTNJ2rRcfr87Kz2wmU42ffCm7IKwRHGf4GBeVux+QM+zsvDxsn
	nG0fUaT8Jjdq9wvhP3rJblPLiBNtJ8KeEtivIJ+i3ggokapVhZVPIBCjBYGnNyCOiJOkUAHmLvc
	eZxuvn0XZeyDYeqIb6KGswbhNJax7yOihhsE2caGfS+LqCWB4rIfTgFFNKV8SKyTYQEdgZUVc43
	g==
X-Received: by 2002:a05:600d:8485:10b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-49fbc43a0a0mr19318395e9.8.1789587465257;
        Wed, 16 Sep 2026 12:37:45 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23ac75sm12936105e9.13.2026.09.16.12.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:37:44 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v2 4/5] vxlan: vnifilter: account the VNI node to memcg
Date: Wed, 16 Sep 2026 22:34:48 +0300
Message-ID: <20260916193449.2552039-5-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916193449.2552039-1-alishmery18@gmail.com>
References: <20260916193449.2552039-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_vni_alloc() allocates a struct vxlan_vni_node for every VNI with
plain GFP_KERNEL. The per-CPU stats block it allocates next is now
charged to the caller's cgroup, but the node itself is not.

Use GFP_KERNEL_ACCOUNT. The only caller already handles a NULL return.

Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
v1: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/
 drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 9a1baca39d8b..fbff52c450c0 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -710,7 +710,7 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
 {
 	struct vxlan_vni_node *vninode;
 
-	vninode = kzalloc_obj(*vninode);
+	vninode = kzalloc_obj(*vninode, GFP_KERNEL_ACCOUNT);
 	if (!vninode)
 		return NULL;
 	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);
-- 
2.53.0

