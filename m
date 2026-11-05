Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917271;
	b=Wup3UUhudiyIglGfEwC2DMcU2bmkjIG455E9BTHaRFwQzdWmo+371EGQNu4JqJpbMvbN
	 InEPwYrYztJ2yCHS5FAiszx2sm2W7ic51fZpc16cYJK2dT4xT4rpW4MRAbmxFvnGPOIs0
	 KPwlR24UuQziH3tYD1F2JlHfO0nmotfdMDI0U74EVfVlACV27wk5xtkV1cifCY3O2yxHZ
	 IKIZ4SD0nqnnQoOYP/WOYu3UL7hsNWNqBXhpwzy/0EX+oOMmBgAhlcGEiJpTL6dR6v6NS
	 96FiAQAneXBtCyPO99o+3H+rUa/aTw+Of5hXQGRsoxrYIDXR2AM9KjNbiZxumBX/uUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SeK2ptx5a0hAbgEAKy9F6rfb5PgJz2u6yxoaC4Xui3Q=;
	b=3jmzYs3QWCb+4gIlWpTQSJ7i5kI6IFHRAA91/wf2Rj4A6hFxk3sBciqxO3earGw6SlJI
	 g9LO7KQ/h/8OmZ02f+4zpPSveDZrFik5qL9uIHDQesT0hRWjaxnFUM0xov7Ng2695l9T2
	 wwAxVnxJL/sdqTllDNZYA0cjwTUFb/AXN5pkg08hjAiaO3fXl6XRG52PjaNCUCjLgeCqE
	 CefZ99TkNWnSXAj9e/CoHSsv2PCfDYiTM3BvAZzx4fah1qMvG3amtrv9K7x1G4Wo8v1EP
	 E9FnT6cHe2Lzd124TKf4dYN6HSocmZSx+0S4hE1hRe+PefgpBf/rCYsgoP7XcJRdAAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tXK09pbb;
	arc=none smtp.remote-ip=74.125.229.136
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3294606D808
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3294606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tXK09pbb
Received: by mail-dl2-f8.google.com with SMTP id a92af1059eb24-1379d236149so80317c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917269; x=1794522069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SeK2ptx5a0hAbgEAKy9F6rfb5PgJz2u6yxoaC4Xui3Q=;
        b=tXK09pbbOwh8AP9jNlpQhqDpUJfAjAae6Ku58Zgm44oOrfeRgdSy3UqYDB78OGEkcU
         +7aiH8UB+U/cTYuBSbGlhDQoEbs9Vjmeyf3p9O/kparVcGyxuc93925WNTKkW6a3BEzO
         kK/Sp3YdmtVRiF09ADY4T1DxgRws8BeCuiAIpg2IYjHqryzRmvfWPHfU/TX0kerBTqqP
         Z9XvevicmbaLbeiorRF3IL8ubRSPGIbqOCg8Q6r+m7CUkeDrHjJ0xWcSXEoZeV3ileAK
         XGTP86A9kpQXIAKr1zaON1csyIQLpcAgryipH13EsnYOQnbNlmrL/xzxbLANwK/Q5qrd
         5YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917269; x=1794522069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SeK2ptx5a0hAbgEAKy9F6rfb5PgJz2u6yxoaC4Xui3Q=;
        b=NgpnOkVeka0ngmYxDKG9nkD5kDGcl8YtuMf7uQCRi00HMwIE6HCRF/oaqVA+qrvHWc
         M01ZQAihIQ5qo12V1ie/cmgTl7s+OhSzPhMbiELhDyUcrCw6AVdE7o0ReA/b2fuPZ83v
         eEp2idc9Q67vfwqYlQx78AlYk5xY7fUh65Y4q5FeeeEPDMNvVBVDfSS71lz8dDwXCHzW
         CYwmbr1ISJQvDKu5iFSys6eOI+AUKBRvNBrMG0N98+Vf5qc79VHcYZgmYOKd8gEIUdYQ
         yRai7NieD++/MrGR3cRQEIUHhQxedwVVOvbUjjFazsvYA1oVSGKH6pnbNZT/A8OppzHd
         TDfg==
X-Gm-Message-State: APuU4Z/4wtdj1zroyrEFiuCWK7oelc4WdilegMaax5ij6l3TEzvVumS6
	vt3g6E3NHovyB9X0Sm9X3vC0VwcEiWS++df8xTgF0G578feSbbmT/f7J6tM3LeRuSSs=
X-Gm-Gg: AYBFou22dKuTjMrwQ+TEJRasckQzeZW8Iy7197We49UJyYtgeKi3SgcUMfY//PRF7G7
	/uW0I45tA/UPb05yC35GSu6uh1IVvqvF1pnqSICdvH8IozWqIaCGzoADpC24DZd9Xu3V2x2jgSt
	/OhU0DNrCcRfawZfAY6GFJmTscZ2tRW+ogPMQAY9XXs2V+dPsieH9xwGYXoSYJF/GjI3xozXx0a
	si4/9hhZBru47bHzVyQAlkbz3VEWR3MMqq+COaqOhSvJJtWvHNjj5XUDyem2DOgEOnKnwkS3OW/
	CWrg9ZIpcoQmSXqANSjqKIzHP0WTMk8wvs61Y3gyLMLP5bW5ipUfqgMSwknQdnpcaiFrgZ2EJFN
	uEZ68tdnv7C9/Le9fkE4Fd5FdHGeNRdvMFgrmpEDVHZ2CiGILjDcVY84OGEcyZYF1AfXyS66usY
	xeI4IfwXkqAJGqynoU4xFgtiierITla1EUPnEgvSAH0EuKKUFRnQ81SXk456UFxFJK+e9f3XO0Z
	2SszZrWUZ6yQdhdsmDAZN/lk9g8/2mwFbsY0scfsBSBS0rl6h7H5OfNJElXkH2LW+nGgpUFOPY7
	lbSTAS1Nsppr/COB4Zyr1Is=
X-Received: by 2002:a05:701b:4292:20b0:15a:4155:3d9d with SMTP id a92af1059eb24-1b25d37e36dmr449336c88.31.1793917268955;
        Thu, 05 Nov 2026 14:21:08 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:68::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm26931552c88.21.2026.11.05.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:21:08 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	sdf@fomichev.me,
	dimitri.daskalakis1@gmail.com,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 7/9] net/mlx5e: lift the netmem TX frag size limit
Date: Thu,  5 Nov 2026 14:20:56 -0800
Message-ID: <20261105222058.944293-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105222058.944293-1-sdf@fomichev.me>
References: <20261105222058.944293-1-sdf@fomichev.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TX data segments have a 32-bit byte count, so devmem TX frags don't
need a size limit. Set netmem_tx_max_frag_size to U32_MAX.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c3c2c5720c6f..28ba04bd5f4a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5967,6 +5967,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
 	netdev->netmem_tx = NETMEM_TX_DMA;
+	netdev->netmem_tx_max_frag_size = U32_MAX;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(priv);
-- 
2.53.0-Meta

