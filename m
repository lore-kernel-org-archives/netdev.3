Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80583C8724
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546052; cv=none; b=Pm07X+hWLRpj+TDV0hWMG8YcM3ATp7zzm0pY3nkzumi7qUOpz7cy4DkIRaulDDB+iViVRnkb3dpVTFD2lZPaKYxcQ25yOL3OovMf4wL9bMfB42NL0bnm+Q+3rgo7Qq5C5WxsQ9fYYN+v8XCCKZIWWFC6oWEM6kT0THogvz9gADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546052; c=relaxed/simple;
	bh=sscHr/a0eI+rSyX2APqOJXjosRWL7Frah0IdG2yROFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSxBs6yRdvHynu0SINvbNVZmg8Kt1PMRO1Hp2UmCdSdd+OoCRyXE5MlVsZ2oDJIBWH2A81SzJV5RA4Ap5UMln1fN22657B6PQ5KvZ7ye/wK0vIh57uUpU2p7wyNQvUFkVQibevs736fCC0kIcluegx4+IHEA72kz2Cq4AsBIX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFrJuvFf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFrJuvFf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso6505185e9.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546046; x=1791150846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uylNNtWhFrB2xKZW5KF3UySVhmnx4gMhtUpqjfbH9bg=;
        b=MFrJuvFfS+wV+0MljxiIkn57ZPO1HfhRN329+rbFNyYqxXRVZdMsynWI1XYasSXeMZ
         Evw+IOxQ9efJ1mN28e88gymdxYPZUVFLNzKmqhwyUkyd9TKW+eG9HISu9ijg1wgxZoze
         TJQSrpRQ0bRiISjyspsEe4pb/aRQE/ehz5xeOMIrMTGpSC/1lp/rPN+5FfTjWUkVsYXP
         vrrBBDt8zb6QB40/nNBoADXEfMYD6+J2JqclAbk1hHqG+e8jFAmXAH7xfDEcMDf6Zc0X
         Dj4zvWg9Bu4UKzyKoQY2CQE7I/Z22nAbaAt3z9GD9BFLaOH+0lRqXn3claFIV+xUyeBH
         U+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546046; x=1791150846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uylNNtWhFrB2xKZW5KF3UySVhmnx4gMhtUpqjfbH9bg=;
        b=PLEpHtTShZM8dSaQZe9Uqx9BpK5qOchBGoj30hxiI4bgIOrNuk86AYMtGKrxDYS7Pc
         tSGQKtjtyCEhsTRJqbrYXGApoUfYGhYn575bcnysc0FQmsSBDqzW13JtYuF1YRBefvfM
         WMPm3CA7Teh668gwoS6Z26p6SgQ0tgzTkk0gLpnkI4YQIuQfPP1o4W6dRI1DflFYDrWt
         DfaI2vkR1BTfi9i6rR61Q4n9ppuHTr8B0cXytzWPPqK8R2hSYdFJr+BwCNKjyQBoXGMX
         7pT5B3kLyDVbGp7TeB5FGoNM9Q/e/bpGohv956n7LmGCNcU2LpdJ5Oyo5Y8HM1tJKa1v
         mWwQ==
X-Gm-Message-State: AFuF++k+pQS+ypAv7mU7h88mTOb1ZLg1YZrOETMvXeTY/CY1GAELxb9P
	Se9Gqb/UxsELkPMHHJ52Iv0CkuCra/zCtzKuqQJrWyvCGAQ7+1Bc53yMigmGPv4ZNaw=
X-Gm-Gg: AYBFou2RDaDUXiUFC2kXmp2vCWt4076l4RA2DHdgV4P9/qImWrfUgQsLjTjpiu9AjPM
	YGMesjjUiY9HNag+JyOe1EZq3e1TQzi78QNrpkq6cxzdMdi7wFJGPlY6RzJVcFl6YQoE9laNyYb
	6mK68w128RcWNc0qAEKhTf1aARruWaL0UMDJClf/Jl3/JSElq8uEGo8uqx1u9BYFM8XD/J7jeb+
	jCvlvkVahTBE45s2RvyMYuYHx96+YWHYWLLpIj9YPA1igUK9s6Eax/Ty+LlOb/Zele+ZED6KI3S
	ZQyInT8ZRzlQPKo9IiJDhuNPzyR4yaZP8eESvBUZpoXIa4ZUBdKFmjqjGPcvOGvFG2Me0m7pD0i
	Gbz1uIVIXutZCnFVH7JFQS/u9tE7Suvd2Sib2PlkMAdS0g34u3qaj2RP6UwbeTLRkT4flY//12H
	AStvBdJSnJOtBPbymHbDe2xjCXX3nOkGjbqIkjNQALR3o/A66B0K+GQF2aoNaqXDemiGWiWk7uV
	w==
X-Received: by 2002:a05:600c:1f83:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fe66c8087mr200153965e9.3.1790546046087;
        Sun, 27 Sep 2026 14:54:06 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001922102sm89556865e9.15.2026.09.27.14.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:54:05 -0700 (PDT)
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
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v3 5/6] vxlan: vnifilter: account per-VNI memory to memcg
Date: Mon, 28 Sep 2026 00:52:08 +0300
Message-ID: <20260927215209.2581830-6-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927215209.2581830-1-alishmery18@gmail.com>
References: <20260927215209.2581830-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_vni_alloc() allocates a struct vxlan_vni_node and a per-CPU stats
block for every VNI, both with plain GFP_KERNEL, so neither is charged
to the cgroup of the process that created the VNI. A netdevice's own
queues, ethtool state and NAPI config are already GFP_KERNEL_ACCOUNT in
alloc_netdev_mqs() (commit c948f51c1654 ("memcg: enable accounting for
net_device and Tx/Rx queues")), so these per-VNI allocations are the
unaccounted part of a device that a cgroup can grow one VNI at a time.

Charge both to the caller's cgroup with GFP_KERNEL_ACCOUNT in
vxlan_vni_alloc(). __GFP_ACCOUNT only charges an allocation made from a
task in a non-root memcg, so the sole caller, which already handles a
NULL return, is unaffected outside a memcg.

The charge lands in the caller's memcg: adding VNIs from inside one
moves each node into the accounted slab and raises the cgroup's per-CPU
memory, while the unaccounted slab is unchanged.

Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---

Notes:
    v3: replaces 3/5 and 4/5. Account the per-VNI node and its per-CPU stats in vxlan_vni_alloc().

 drivers/net/vxlan/vxlan_vnifilter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 92ea1fc94f45..3087877ed1cb 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -711,10 +711,11 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
 {
 	struct vxlan_vni_node *vninode;
 
-	vninode = kzalloc_obj(*vninode);
+	vninode = kzalloc_obj(*vninode, GFP_KERNEL_ACCOUNT);
 	if (!vninode)
 		return NULL;
-	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);
+	vninode->stats = __netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu,
+						   GFP_KERNEL_ACCOUNT);
 	if (!vninode->stats) {
 		kfree(vninode);
 		return NULL;
-- 
2.53.0

