Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE235CB61
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926453; cv=none; b=l3cYD34WGuYo0m7/aQNsBaT/KaVFib3Kngsi31sffIwYAnTECgVK/yo7ImhCZ1tuGmUkuBD/ixpi+fEYjkiCm6iKefhczK75cnemgLxA204mZ/2gxyFTt/hyzH4XCBxQFjQCq5YU8lhLau/lr8YAONVeW+X2zmxkV0Mkov5ek7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926453; c=relaxed/simple;
	bh=hMbcO0KhK/HNpfDdSE27ZVvUkIWR95KPiO/dBugJfsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EX8npwCSoMQWwp41qhiErXePgDEm+vdilmALBqzjMusyVCfNSbRrR5JXgR1/nJHzaX07RO/BEfLD5oz5bWU6IrHczYnOdedzfUbRgx9qLGiv05FPF+LTMdg7zOzY6qGH71WP6jLov12DT+MXQB8AZY1Si9uXbj7tXxYBR+lLfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogWpdIV5; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogWpdIV5"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91a931f66so14377365ad.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789926452; x=1790531252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nz6Sygv/+pmEz2twr3jJ433N/mk/SDG1C8A8z4/oa84=;
        b=ogWpdIV5oSEmCs4hi/4m28xnuV69Mc42+iIoo4B/62csSwJqPqBautieIDEe8NzSu5
         V6KeJlY76/jii5Y/qMTzdCCFXtNi6W2RIdorjkuhl0tqJgCBMHIilW1giUxCBzYAFlee
         spELg5N2QJjH3yXYgU8N4La7mhzzXfdG9rvEEQi9AmRt6XUjLSzaOAkdXWg6WEiBdoiF
         pGqxh+cXljehMvUWsA610qKx0ZZ92kE5Hb2vMzFHq0YsrpT9ZNfKr4J+hcVRSh8VP1hm
         IPlfRGhcOrDm2T0oTmafOzAkhYAwD81cxUHddNfcvlr5iwA1D98G31EOuhikiYyxNwTP
         KYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789926452; x=1790531252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nz6Sygv/+pmEz2twr3jJ433N/mk/SDG1C8A8z4/oa84=;
        b=LBULbYlgTeGjcrt0UtlrrEsPSc32rfWXRFyZyDKV6acfHEJvBdlTyGjYcHtcP3EQqT
         PTsIqnbkjYzUxJGJLvew1Tfeq/1jWoiWjKMpkfTq4K7XZqLF0oCgCF9tr5OnbgdBaRh8
         /7cdkAjdNFHPbEwh99n0jJnYWM6YWbyc0/umhrtr+0BZvxPPSUgiEKkQAneBXHik5F/8
         IpF9U4lZTUl5bvIWZ3D9PJICruZdxr0wshR6iC5IlkZo9o363LPZRxCIjuKT0gJhuWbT
         am8VIttc1OvaTjTh50UXVf/8agz9aFSzITiqkW4SdnT7PTLaaRtyOq6tUcPj00nsjkZi
         L73A==
X-Gm-Message-State: AFuF++kOhHhMxTDWZr0tHDiWEKO9NSYoorArtp87xZc6AeCFsEXiQsqA
	eVJsW2jWV1zXzvtAjTg6MF2MNgwOH4BUsHOuM1AHadHh1eNS7s8I5DRcl6ZKQ9sD3Che38+c
X-Gm-Gg: AYBFou32aVs2Jflgdu7sBwHp2djlaMsuYMArP/oqX2qbAGUBxnQbcvCFu6KBZngBRF1
	rYKai0Cu7wE6PyQ5jDFj3fLXU8gSyCtlXrvAQVsUVO+MuaS9YuqJPm552DcOtx8se/UwWZtr2FW
	wYR3RlLF+gkYt2/vlHQDsJ1K9Cw5T8ddH4JlGESazZ/A3D+F8KDpDtn+w06CMP5ovboBzu2g3oq
	uEibnsxNIabA1EG5RxKtgF77hp597W6VyYqtBEPBfy94H8MoP2th9qXYx6NTqYVcETA3JgMF2fO
	XBAeM/tAmymQf0NLULPVX3xX2MusDzwg3qE9ixEOj9DWSO9raECMlQX+LiXGOE02ID/pNpnDYhB
	Srr8HvswLsAMv26YfrSynN6PxQxnD0WCEr2B8qZZUVfIclvSRImcK46rsHrOyg/LN0u8MOvSzxy
	xp2DKIO/K+he97C6wq8Q+fXrRGNGD120armtQd0D037+XYM4o3QNOqUwn/1NT0r+GstNyjjMn4O
	lJncSaoog==
X-Received: by 2002:a17:902:ecc4:b0:2dd:ad74:6d20 with SMTP id d9443c01a7336-2ddb1bc62afmr152131625ad.29.1789926451529;
        Sun, 20 Sep 2026 10:47:31 -0700 (PDT)
Received: from localhost ([101.126.86.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc18032e5sm21894925ad.76.2026.09.20.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:47:30 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: netdev@vger.kernel.org
Cc: Dairui Zhang <zhangdairui@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	David Wei <dw@davidwei.uk>
Subject: [BUG] net: devmem: NETDEV_CMD_BIND_TX has no permission check and no accounting
Date: Mon, 21 Sep 2026 01:47:27 +0800
Message-ID: <20260920174727.1332115-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETDEV_CMD_BIND_TX appears to be the only mutating devmem genl
command with no permission enforcement:

        BIND_RX        GENL_UNS_ADMIN_PERM
        QUEUE_CREATE   GENL_ADMIN_PERM
        BIND_TX        (just GENL_CMD_CAP_DO)

GENL_CMD_CAP_DO is only metadata - genetlink only enforces
GENL_ADMIN_PERM / GENL_UNS_ADMIN_PERM - and
netdev_nl_bind_tx_doit() (net/core/netdev-genl.c:1155) has no
capable() of its own either. As far as I can tell that means any
user can call it, on any netns; it's been like this since
8802087d20c0 and is still true in mainline today.

On its own that would just be an exposure question, but the bind
path also does no accounting at all:

  - no limit per socket or per user (the only bound is the 2^32
    xarray id space),
  - allocations use GFP_KERNEL, not GFP_KERNEL_ACCOUNT
    (devmem.c:207), so memcg can't throttle them,
  - nothing deduplicates repeated binds of the same dmabuf fd, each
    one doing a full dma_buf_attach + map_attachment plus a gen_pool
    and a per-page tx_vec,
  - everything is held until the netlink socket is closed.

So an unprivileged user with a dmabuf fd can loop BIND_TX on a
NETMEM_TX_DMA device (fbnic, gve, mlx5, bnxt) and eat kernel memory
and IOMMU mappings until the machine falls over. gve is the GCE
guest NIC, which makes "any user inside a GCE VM" the most obvious
victim scenario.

e302aa3d00fb ("net: devmem: allow bind-rx from non-init user
namespaces") revisited the bind-rx permission flags a few months ago
(GENL_ADMIN_PERM -> GENL_UNS_ADMIN_PERM, for the container use
cases) and left bind-tx alone, which is what makes me suspect an
oversight rather than a design choice. I could be missing some
context though, so asking before sending any patch.

Questions:

  1. Is bind-tx meant to be unprivileged (like AF_XDP TX), or is it
     just missing GENL_UNS_ADMIN_PERM like bind-rx?
  2. If unprivileged is the intent, is a per-socket cap plus
     GFP_KERNEL_ACCOUNT acceptable?
  3. Should repeated binds of the same dmabuf fd be deduplicated?

Happy to send the patch for whichever model you pick.

Thanks,
Dairui Zhang
