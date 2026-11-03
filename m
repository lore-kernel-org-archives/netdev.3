Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748422;
	b=ynY0slAZelAky9aAOu2GV94tvmIXAgDoMBE6YljCt9HqpC1y3k+1zl5gn+/E2Dker8im
	 T1ktgqa5aBJaqZfs3biYuR9jZk5Z5+c/x9av49BPHzRknbzE7E2cVly84B2ZzJDqEg8CM
	 96Q8/BYs1scRr1FlL6NIR0xjScTW75WvJ1RZeCvt9MLoAV6kQq2jrMthkXkCtFFlRaL3j
	 sJIR2SoBscnW3Em2JqxxShR69rzgnI9SpPOGMKxKCZZSn4R+j9m+mOSbKnk0c8Pz/jLSb
	 VrOT48BlFflh/N/ssGl2vE3p6jSHgGXkiV647AZyXrLbd97JXuCgs97mXqJOGIIi17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=GYRyPmJZ7VWmEJxbkLyGw/WWdEL7OKIehVLxgCMD04Y=;
	b=zACBsnuAvwTZFBuvH/YMPTKBJ6ZZNAan74LbfLDiQMB7jUtxdiLyemSVSX4FUlByVHrV
	 BJB5VwKcWAXchGM6rdvpc5LiUJ18c/0k7yEEuQmvAyL4r2q/lOkq29TTK64fKqbXvYuAe
	 ikfK9Dfo6NqLtXXXu1Vs3xDs+ZM12VTNFo3ADMz/zj/+Boruj4Aj0x0SKJOleyttrS+LB
	 fzxNwL1VXLgwR1LTuka++jZfpUb4gDC/bhX2PPP6nVT6QWCJOLRtRiDZTtYMhFElwDvPL
	 uJRXzDin2s06X9E3zT5UHMpOObgH6j0Vm5P8NefgZuPcHz64hJYJDdcpDAMlNFRkz5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="kMqQ5/+Y";
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59D606A32D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E59D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kMqQ5/+Y
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso111597eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793748421; x=1794353221; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GYRyPmJZ7VWmEJxbkLyGw/WWdEL7OKIehVLxgCMD04Y=;
        b=kMqQ5/+Y3q+3svE8pMnZxDPk4dEBWFIZpEzNnbKht5uygeHOSpTFh1FfkhHL4jxNSg
         hs/M4i1gK8tL+d6Xb/h2b8iNMF+Mgmth7XA3bijSxNHkAAPYMwbgz5UKv55ujE24G6/O
         RoDQCz36Ylpau1m0BSKQlLFquBABJNJDb+ftwe7Hdb7pFZvkd00Q/VDEujlMGNlE0YbV
         Gg4mvJtd427alIgL2np2OEjFpwYU2OESTtccko8bdnzKv6D739uHQTWg+bJnet5YWGux
         h7TigQZBiEXh1QQSre7xMft/7cLZETtPzLeA5qcNE2RnlRwfOgyzBAdCkeSURbyvpb9h
         uc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793748421; x=1794353221;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYRyPmJZ7VWmEJxbkLyGw/WWdEL7OKIehVLxgCMD04Y=;
        b=YCexw14vGOelT5UMML7OviIzhB8cySnhb/FmDT9X6oMoTUdzod26ju9spoXZoFrmh9
         6akjBSKpbUCl78AXT0UkzI0IhVohhYUkfJOcKSx4yCh6paMttQ8weehkTr42QW+fQqQ0
         01OEuXMV3wkYKigsAqyvhYAwJTj9/McA+XkdlKdTzgTiSacsbp8uR1KunYg2L811r+9y
         L6K2mmTn5JDnFg+H8tYi4LeBQ+EXG95O/42uwjzAX59a1Rut0UeQqVtEMuSUyIOeSdZm
         eMc2McYqEtQ08n5NuBbR77+2gwaBnF4KUNwqc+zDt6v6az8IrtmsEMmrxGHNSB2ErKWs
         9Jcw==
X-Gm-Message-State: APuU4Z8O56lV5q7u7Q91/o8WUjk+dGI7OixZjOqQeL+KHAEhgCLITpHD
	S2GPbYrX9HiK/j5X+dShWp2gJQbNkvthJcX+eDTA2mssghz87rv1lOE0IdpC2rHuuds++x+kg+p
	GgEzsmeExu8KPitgtusAXWavqYg7i2ee2ouVXOpT+ZTvIdvCSoGLb0wz4yX88KjT7kvkr2WEQ9L
	jZjraI5JU/2eHOyI9VQnTs3L2i6kgCAevwlhGxSiWNu4gTUJQAVWbUtHVgGhkMPRE=
X-Received: from dyuw3-n2.prod.google.com ([2002:a05:693c:8803:20b0:351:2266:121])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1a15:b0:355:fdc0:a811 with SMTP id 5a478bee46e88-36a42493bc4mr19610913eec.37.1793748420418;
 Tue, 03 Nov 2026 15:27:00 -0800 (PST)
Date: Tue,  3 Nov 2026 23:26:55 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103232659.1340283-1-almasrymina@google.com>
Subject: [PATCH net-next v1 0/4] net: devmem: support leased RX and TX queues
 on netdev unregister
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	David Wei <dw@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"

Support leased RX and TX devmem bindings when either the virtual device
(e.g. netkit) or the physical backing net_device is unregistered:

1. Pass struct net_device **dev_ptr to net_devmem_lock_dev() so callers
   can lock either binding->map_dev or binding->bind_dev.
2. Rename binding->dev and binding->vdev to binding->map_dev (physical
   DMA device) and binding->bind_dev (device passed to bind-rx/bind-tx).
3. Always populate both map_dev and bind_dev for direct and leased RX/TX
   bindings, and rely on dev_memory_provider_uninstall() and
   netif_rxq_cleanup_unlease() to uninstall RX queues and clear
   binding->bind_dev once bound_rxqs is empty.
4. Add kselftests in nl_netdev.py covering leased RX and TX devmem
   bindings across both virtual-first and physical-first netdev
   unregistration orders.

Mina Almasry (4):
  net: devmem: pass net_device pointer to net_devmem_lock_dev()
  net: devmem: rename binding dev and vdev to map_dev and bind_dev
  net: devmem: support leased queues on netdev unregister
  selftests: net: add leased devmem RX and TX netdev unregister tests

 net/core/dev.c                           |   2 +-
 net/core/devmem.c                        | 121 +++++++++++----------
 net/core/devmem.h                        |  25 +++--
 net/core/netdev-genl.c                   |  58 ++++++----
 net/core/netdev_rx_queue.c               |   5 +
 tools/testing/selftests/net/nl_netdev.py | 132 ++++++++++++++++++++++-
 6 files changed, 249 insertions(+), 94 deletions(-)


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.56.0.385.gac671c819a-goog

