Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B313790B
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183680; cv=none; b=Mk7XCMRq4KzEW2kRF/zqVJbGfblXw/Lyf225I8q8p7a/o6CXiGJGLPzGomGx7KIZrUGsZ/mSQ0cnUbyzqywuOfroFWIj/Cct5Ubc7nFE9/xlEsQImyx0IkPeTxmMz4s8NLXAKBfy4mkEdZU3JOWLZ0vVNJ+eHhL+EENQJOf555c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183680; c=relaxed/simple;
	bh=zqQQxhUBkPqBV/Wxnm17qMpBUv1EivR8LE7WqPMtYlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/tLweEVSdfkvvdUdGpwuT/ei3JEPmar5dZa8r0lvbqv24gFh/a13C3uy7NVwGUrENVbQAuqXMqsCeVC+CC67ApKzXV+JSM+Jg47fd/Q9DantjiN0Wdk5wj5RwWSUsyNaS/2LG7l4a4CzAgKkJnAEf8JGxmJGMxPRg/PWUfMXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/RndNFl; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/RndNFl"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so2623110b3a.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 23:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784183679; x=1784788479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b7IjFTyBqnxJNzn0lNGNSBZ7FEn3/j80CI18ZBi2gVI=;
        b=k/RndNFlAWWNwHHEVsoXYK0IfsJCm8fwzhFQtptHPmd7UQETm6tLR00dRir0pEw2si
         FhO/kTI1ZOL6PXFDvIeMbtw/V0KkIvmB/mQklyqp4T5peVFek0f9y4CQvXfSMk3g1oPU
         dmrDiakfVYuwBOA/02cdTkX6njjDBNkDxYXntGfFBXFwClnKKb7tUQQX4jKQ2z01HkoW
         w6I7uWZTW5Zn3yCS14MwRJTsaRNd/3nYZNpApG4+1S1frL+pjb0fjlBB9iLYcqaOdspV
         P1koIc2d23LMW0gsmLC8azMQQi2i00u+BY6rYDpBrWFkvru/cLNvD9drxf6OpmBQT67G
         Ftew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784183679; x=1784788479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b7IjFTyBqnxJNzn0lNGNSBZ7FEn3/j80CI18ZBi2gVI=;
        b=jhBFb5ra44rVILChqphhB6ytNPX9/aPwqEHQaFlnk6XOx1emYuImSZfDqxgQaLtfER
         Orn1ZDjgK4LJsF8P9y5UDEr2eZ6xIGn/SAO+W6I+SHUoUjMM2S0zuzfE4Xpouvv57n2X
         1uF2ojq3pbl3cAeo7vqe13ZLRP3ZgJEjHZ5HayVpViw566jGDJL6NeSm//oPvaK6trBY
         aRSecwZ7yfFJN/Snfz7LtPly+DuN83iPSsVOdFbWX6AX1+HWhgC7w/TGJ+WEAaPh5Udx
         qLkzY71KZQvoI1Q4K3i3NYMmzEE8ElWpx2HYH/ZtkyKnGtp1blF7GD94pZsM4noqpnuH
         8d+w==
X-Forwarded-Encrypted: i=1; AHgh+RpVNkBEMzEwkwZuGYY6Xf4SuP2aBx2VWmbBNZNgXlolrWC/n76fB2JlBCypuu7lWqDqA2UlCMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLkITO3E7eOFaYoldjurtXDO3l3jVIj3KLqr2j7jwWr+qxl57
	mVbu0Afi1ZhBnc9DCjZ+GKTI8byaiVc4l89fbBQdkaiLq2+axpQ/p8ef
X-Gm-Gg: AfdE7ckKrKAEbc0Nt2eRmNcyqnarWHFKapv/ZuduGmJmDVv8bZhU7W90AavR/MaZT0v
	DkzlpAyUrL4K7d5zTl5hrSK1YodXyBH/xBLfUICIa5hPRDnAKI7bCGPsZoQvx3DpDLoa0CKTq22
	BYnf8Ie2pCwH7dprVR6cImvAgijw60vdGOvpw9GVh2Rw6eCh7JpAwtNyEGxTo3pS/uXwJE2FDfl
	KLu2WGNoA24Pecx528lwOBC3syqoFRizSW8h3zCID0nkuPfiYoNjvifjcw/cprMqDO8+5AD4wqA
	Udi2RCGIxsw7jo6M82yuuc4538KlUpkicfemuhGHx0VmFYyA9aaf4Ld7ytUVJwN8CNeLKUZLM3Z
	nxYcBfV02CZ+lUmn855CdpQ8u37R6mOrM9BIymNwwfAKhW49JZhdm0rGYYSxw6H+egBwWS5P3Yw
	t8u+acryt9t11J3XNLIFWA267OVAY=
X-Received: by 2002:a05:6a00:14ce:b0:847:7f7a:dd18 with SMTP id d2e1a72fcca58-848895db925mr19400651b3a.3.1784183678667;
        Wed, 15 Jul 2026 23:34:38 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dadcfsm4242172b3a.48.2026.07.15.23.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:34:38 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 0/3] octeon_ep, octeon_ep_vf: fix RX skb frags overflow and page leak
Date: Thu, 16 Jul 2026 14:34:29 +0800
Message-Id: <20260716063432.2908100-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The octeon_ep and octeon_ep_vf RX paths add one skb fragment per buffer
with no bound against MAX_SKB_FRAGS. buff_info->len comes from the device
response header. A long packet needs about 18 fragments. That is one past
the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag() writes past
shinfo->frags[]. Patch 1 bounds octeon_ep. Patch 3 bounds octeon_ep_vf.

Patch 2 is Guangshuo Li's fix for an octeon_ep_vf RX page leak on the
napi_build_skb() failure path. It touches the same drop code as patch 3.
I carry it here so the series applies without conflict, per Maciej. Patch 3
moves that drain loop into a helper. The helper carries the page frees from
patch 2, so the overflow drop path frees its pages too.

octeon_ep has the same leak on its drop path. A separate patch will fix it
once this series lands.

v5:
 - octeon_ep, octeon_ep_vf: widen data_len to u32, per Simon Horman.
   buff_info->len is a u64, a u16 could truncate a long length.
 - octeon_ep: dropped Maciej Fijalkowski's Reviewed-by, the check changed.
 - octeon_ep_vf: the drop helper drains the length in a u32 too.

v1: https://lore.kernel.org/r/20260701112825.1653044-1-maoyixie.tju@gmail.com
v2: https://lore.kernel.org/r/20260702180518.2013324-1-maoyixie.tju@gmail.com
v3: https://lore.kernel.org/r/20260704061511.2350737-1-maoyixie.tju@gmail.com
v4: https://lore.kernel.org/r/20260706150208.2944898-1-maoyixie.tju@gmail.com

Guangshuo Li (1):
  octeon_ep_vf: Fix RX page leak on napi_build_skb() failure

Maoyi Xie (2):
  octeon_ep: fix skb frags overflow in the RX path
  octeon_ep_vf: fix skb frags overflow in the RX path

 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  9 ++++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 51 ++++++++++++-------
 2 files changed, 43 insertions(+), 17 deletions(-)

--
2.34.1

