Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA32737FC
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254047; cv=none; b=UT5Z7KTMH0vTV9WZB/ZB0eMZG/jTA3c7zuRFiMGHjUo2SUO8YC96J3wFPM/sdzYJ5+e0j5lsxPhxV8TJNYWGVmGzcrBN2UA+LQlmhLmtmBqa/An5bMyDMB119B29ogYs7oR09BDjOp1sLBO6+fMWfim3s/+W9pfPTTy+y0h9ZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254047; c=relaxed/simple;
	bh=vyiJo8EPGuCCdsmO8LoxQw5prvmz3X6/LQ52MU6g4mk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WZ5rdj1faZmLHr7kYkhNDUe3kYMdrJA78Rblwo+FsAa4mB8jr+cwolmVnYKzSA4F9+StdRd9wuzNXk3f2LqA7e8g2+DxeZstBTgQLXqcvfjo8Y2AlgUvKoE1cfhS9/qLcK1jQQytAXyehv9HR9OgvtNaOkUg+PWj8MAEjtjmnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pHvhY6oB; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHvhY6oB"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db3b126c9fso25496575ad.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789254046; x=1789858846; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXXAzz3ZXXLAd2p3ngCRoVSrsKDKQnRFabnDtirxPz8=;
        b=pHvhY6oBFgl+7GVbTv3YDOXWsu6qzxyEA7vFKJWKt9q3FJi49LtQzqrPkEnD+E7F7z
         GCg+i3hWlb9lPtU5DYbIlkp1ZdeFgNNJeQ8K58as2tCGz5JoItB2FFtoeZpIsJ2lnCtY
         WszjBa45v4f7oNVFlWg83cOuBiAwlAsjBYvdiFAijQRm9RSKFLrBCz/s/mqckxGGAh+6
         5JRcxenV3snO0ydMncN5HXp/AYk6Bw19U7SrrgB8u5EDtsT+o/IFHkCeFZze3/9+pb+T
         lMozzpi6Nd5RYeuBI0SGwg3/bweG99Y+t1Equ/EFvXgsq3TTS9nBYDJ44Y4s9SiWYeZd
         JxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254046; x=1789858846;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXXAzz3ZXXLAd2p3ngCRoVSrsKDKQnRFabnDtirxPz8=;
        b=iPkQOMVnsF/pB/5m8oXEDLBnsSC5qv7Zgwx8NOUn+Jir9oGT9xldCKSSpoz+q6Mum0
         +UpvDE3WummYo/RcAmdLFUsAX4Ib/PB/Z6MnVPDktH07A2uC7Nx+x6w93AnHi+J/RX2J
         Xf36BF0L+OfBCFynf210Nvi1e5WvXb+a5Ixl2Q3fGDrj1AXj7pmzNmtlfIN5tAOFcmly
         EgZKCABm4G/K23n7NRmZrPR38bOrJMHcbryoiW8F9WBpPvHXQLxoqHcuDcZhmI4Roa+p
         Qq6eqtqWCGeXoWZSYMFiLmdVR1ubG3DOOaaM3o16HnvokF94uGerOc/+IDJhQnSpilJE
         WO9w==
X-Forwarded-Encrypted: i=1; AKwUvBzucu8dHGwVa23ltM5Wnr2EW1BgCQO55GJ8BamyVVoERcHDyfVxJ8P4zNhYBSjCypnkLn8xbNc=@vger.kernel.org
X-Gm-Message-State: AFuF++kxBLMc9sF2euWSX1TjQdGLKfq/w0woOu8SyRzZQtQI6XQU3EXY
	OyAu9iDOvl7eYusNkFWXMFMBtA3M0weiSqfPsiLzSwLJ5e8Qyyco2lSw8uaVxAvOZMYCU8trpRK
	RV09Emw==
X-Received: from plkb14.prod.google.com ([2002:a17:903:fae:b0:2dd:4a80:b93f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:198e:b0:2bf:27b2:4b80
 with SMTP id d9443c01a7336-2dd2a335dcfmr204082005ad.14.1789254045633; Sat, 12
 Sep 2026 16:00:45 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:00:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912230043.2586313-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 0/7] ip_tunnel: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 - 3 are prep patches to unlink ip_tunnel device from
the hash table in ip_tunnel_dellink() only.

Patch 4 removes ip_tunnel_del() from ip_tunnel_uninit() to
ip_tunnel_dellink().

Patch 5 & 6 adds mutex to protect the per-netns hash table.

Patch 7 uses unregister_netdevice_queue_net() to support
cross-netns device unregistration.


Changes:
  v3:
    * Patch 7
      * Check check_net(t->net) in ip_tunnel_ctl().

  v2: https://lore.kernel.org/netdev/20260909234422.2416506-1-kuniyu@google.com/
    * Patch 1
      * Correct commit message; ip_tunnel_uninit() unlinks
        DVMRP device, instead of ->dellink()
    * Patch 7
      * Check if (!itn->fb_tunnel_dev) in ip_tunnel_ctl().

  v1: https://lore.kernel.org/netdev/20260907225846.3787676-1-kuniyu@google.com/


Kuniyuki Iwashima (7):
  ipmr: Call ->dellink() to remove DVMRP tunnel device.
  ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().
  ip_tunnel: Don't pass rtnl_link_ops to ip_tunnel_delete_net().
  ip_tunnel: Centralise ip_tunnel_del() to ip_tunnel_dellink().
  ip_tunnel: Unify error paths in ip_tunnel_newlink() and
    ip_tunnel_changelink().
  ip_tunnel: Protect ip_tunnel_net.tunnels[] with mutex.
  ip_tunnel: Support per-netns device unregistration.

 include/net/ip_tunnels.h |   2 +-
 net/ipv4/ip_gre.c        |   6 +-
 net/ipv4/ip_tunnel.c     | 132 +++++++++++++++++++++++++++------------
 net/ipv4/ip_vti.c        |   2 +-
 net/ipv4/ipip.c          |   2 +-
 net/ipv4/ipmr.c          |  12 +++-
 6 files changed, 108 insertions(+), 48 deletions(-)

-- 
2.55.0.1007.g17ff1f9808-goog

