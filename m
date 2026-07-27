Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344B3FBB6B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169203; cv=none; b=BqhYKDa7ChrwZiPb7MvVROQ6O3DW5aSEzKOCZYaJ/NYH100IN/h5Ly/F8/h6+dMmJjVr+1li/8PQspllCFgZsz9ZD4hOVoOvlcaQorx8fq8JZ/zuyp6/SkDqfaJYw9eqVi56YFV7ipSfdY/7/HoQkbVfm4kogb3Bm4snN33YTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169203; c=relaxed/simple;
	bh=Qiy45oJzCQ9dnaxrlc7jaSaIxiSUqCg141Nqaw0KcP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/SGSBbH5nSoWqNKQQdUyXhmFXIW8eWC0C8YfGlHKlU/xBaGcHThGc0tVTyi8Xd9kRIAUYwyYCLNqoAoKj6Zh7mWOmwTt3W36MaYuk2UfsHQqWMbBt0R+c5p1GoiCSZqH1z/3olrqnmhGcxX2etr8N5TW6sQuyK0sFd2QzgNZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy/KqXfX; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy/KqXfX"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ccbff2e6a7so17921365ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169201; x=1785774001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0IHSYEqP/JaWlXEBlk0DX7t1dhJCuZAYJeNyk0qp2ns=;
        b=fy/KqXfXAojatLyzn+TJhIvVg5oFQaH/f0TW9ftxAnDWDzA8ruL1Y5k3wdb1JiisIn
         QMJwHYgkUk1T1TMHYCKCLU7JidYlvrgY5HoD7ostm7C2ecvGDUhggFcZKhlrGy5Vqbca
         OtKHQFhX+WDSwzX+0rUQk8Z7Bo0I6qg7A6jjQIBIIkOsVb/6nhPjLXhvPmYV7px6DLXQ
         26CM7/vwk89BA+mSEuL6I04Xkx7O6mTfAvq46ho6ZPEJG2uXN0MuDe13xp5+IBz4hqPw
         lnYr0pOvm4UZ5x0CrBfnx6thqsdtqXojpoGMvQ1byHAj7+NgtaiajyTQtJgKrg2qxVTw
         KDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169201; x=1785774001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0IHSYEqP/JaWlXEBlk0DX7t1dhJCuZAYJeNyk0qp2ns=;
        b=aWrMG3JkdxtVus4d4txLK/NhH/R7sYBJFKmqRBgEo9k2rG671L3YAZBg7GeE3LBsWK
         SG0R5Mph2+KyN4zqe0wIOHx3fD/jmXS8L3y154yGJLalA1gkPalmFJnWrlyciPd7TO7z
         9u+Hn8N3m5ue4sYSgOyiWG/v7/9+Hlq+mWQPPVeBBAEzNa9x0aNOpswwcDFUHtL4L2aE
         q5yDDiCJE1fNHK0xjj3PJF3/K8VMglId4pALWzH5Xp+wmEsCJFeNwslWW+pFlLvmpd5Z
         +R4yS9a/r2UosDIrE/3XY6YKBglb1AlVmWhJ/x6RDhD07yxseDPSZYocsCWYhYGpXbqL
         hI7w==
X-Gm-Message-State: AOJu0Ywxi6beqc2wsw9hYmDphDO/hHRcN0wjv+QdYpvK6O/NquBWSpHb
	6WYHHSNKa7JxXy//ejNv1yIYU5ioFZT4LhZomxwWZXRoOQoVtm1+dX/PKxWRU0ND2/8=
X-Gm-Gg: AR+sD1141F2wBJgoPOMeAMctR53yjVpUkDkj/JUxaTrRzmEyvd0RKCenNra779G3nbZ
	afjL4aT+spQ+Tlu5WzTDAVGyrzMMZewB32awtu2kHnNb8YpaOCa9L2guFaRq3j5MoL7vkWBWn/S
	Nhah92+R+aMEuM+krezOaMGkt5TCOgzeXFgVLsMR9MH+O31jxLqHJgKYxLMeg7l2EyMH/u1xM0S
	3m/ylAzpewONkEVI4lDqO84GN+j/62AbyUC0ZxosoVIPyfh9rtLehy2S/fKSwiZm9nDUO1k3VkW
	/Nju0VX5gQ9V4orRE1BMTTLtuxeNTlt9iv5XdlK4JwFpZNs6NJCZGYEFatTc8o882UaJY7BmL2+
	qSNdv6w+rjsStB6xSfGBbbS9bAGxOYpW/ndZrZtzyWylPeVO2qNJ1EaX3vbqAk1LSReQ=
X-Received: by 2002:a17:903:2f4d:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2cfde78b5ecmr87867845ad.11.1785169201307;
        Mon, 27 Jul 2026 09:20:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d849sm37758895ad.81.2026.07.27.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:20:01 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	witu@nvidia.com,
	alice.kernel@fastmail.im,
	dtatulea@nvidia.com,
	yoong.siang.song@intel.com,
	martin.lau@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	leon@kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Subject: [PATCH net 1/6] xsk: require at least 16 bytes of TX metadata
Date: Mon, 27 Jul 2026 09:19:54 -0700
Message-ID: <20260727161959.885642-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727161959.885642-1-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_XDP accepts a TX metadata length as small as eight bytes, but every
supported request needs the flags plus at least one eight-byte request
field. Such short metadata also lets the kernel read beyond the registered
area.

Require 16 bytes rather than sizeof(struct xsk_tx_metadata) to preserve
compatibility with applications that do not use launch-time metadata.

Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Link: https://lore.kernel.org/netdev/20260720155210.34229-1-blbllhy@gmail.com/
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/xdp/xdp_umem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 58da2f4f4397..cd8643360eb3 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -210,6 +210,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
 		if (mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
 			return -EINVAL;
+		if (mr->tx_metadata_len < 16)
+			return -EINVAL;
 		umem->tx_metadata_len = mr->tx_metadata_len;
 	}
 
-- 
2.53.0-Meta

