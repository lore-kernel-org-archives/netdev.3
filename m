Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794117491;
	b=XBpXMeo7PnDU5hyGz0bYyyh35objHRlBtGHlWJgTwfiYdLOPwhcnOF1dFqgcZHRMLs7w
	 AsE4FJUv9HFuIFwngFlR2GZEOfgD83F8U+aPppteQF8XIkQctbI0NtmBy8EWEAep23z4y
	 0OoClMd7l8C66aS/D2HZDz+SZqdv/NIiYhT+6dUrwAdEj8lX5Og9Y97fw+xt5PCLMSE4d
	 gcBQbERJBR0qJ6k+7ZVuFDdD5vxx55/ui+mdCqBplCjhMRBFV1GOwqRsgg6e5rJHM6rT5
	 D13876w+xvF0kN5e9OazZIMmdQ0YU9n+8x9DIZfXcOmJSTiT3iCyCVJDxw1gufZDFfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794117491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=NudwAWVHsIqQmPrY4IvqXCLbf6QrsGDu0BOJqzkRoQE=;
	b=zym3MdHnng5dkgl9+vx355i1oDN9iOno1r22BuVs6xlxH2FSmorB1hsdJkP+RQN8oOcq
	 7/abuu820Bscu/225q50P3ftiydmBSWD+ndccp8oQc/mJBzgwfeTpUuRb1n11NSetq+Yk
	 5AuCxvjrEoTOazooAKHJ2CmIn+WKpuAvDuBLO0xuYftJIT6qCviz4zxM8GNdWwLqmemrN
	 Hi9nO9kmKtkxQhvSpMEC594PsYBTvWdptLxCCxrnsG1Bhdp3AvI9shnqJr1sBM0ynDx60
	 LylorbXOTQ/37CODzU3KwuZGHKWc88b+T6NBevOxYc8DSseN9MRMf1agVB4fb1B9xrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hdNlp9oT;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33382606A31D
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 05:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33382606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hdNlp9oT
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36f26e6abe9so451522eec.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 21:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794117490; x=1794722290; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NudwAWVHsIqQmPrY4IvqXCLbf6QrsGDu0BOJqzkRoQE=;
        b=hdNlp9oT7RX1RRN+GLOB/VsVJjeitGC6YXOgCxOQ2T72t51C6d5kzUNXMBgKJbZ47i
         jv0SvDmKaiWZQ+Q5WkHbhVu1T+NV+Aq0xgFLQedxqQuE62wv0dztqnqihie4dvGvWbDa
         IqLxg5Rb35sh7/oGPY7EBw8WnC9Z0rsD7PIoZH7i1ZpKNsb87iubGaXAblyA8FAo7bmQ
         DqFx0fwRJlTNvRwmr9TaQuZKBQaOozSQAGvBgiq9WoWKPN75AuywsAgwtQxqk2aM4ctG
         xHsIxYy9dWWQhH3dZTW33hNDPSTi5nimKwEfpvChm7YFf1eqV6fkJIPyl6Olg5JVz+qa
         j8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794117490; x=1794722290;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NudwAWVHsIqQmPrY4IvqXCLbf6QrsGDu0BOJqzkRoQE=;
        b=H21PIzA9iqss3DMdKMtoVM+uAy6LI0GDjDvxt8hT+3DwLmupy7UchAYhnYHvbeHi0S
         NIe7Eif+8JssvcMKuRvepTjmzBCG4a8K9QESKQnyXEkhSSNfM66XzLEH6OBaITAKC4EI
         gq7wcc+z7loj5a+ckHyMUY5JB6IWIef1dqODc2/2I8fbiBl+H/0+h93HSGEQNWjWJe/l
         DUmFz5wumml6Nb04oXegqztj4lWkv0hnXxR/KTtQR5ng+XfKT2tIUiFnJYbnYmk78cHV
         dgwYXJCMvYoqotnC1tekydAm+OTXPnYxqHcL8fLrQX4wB2oy+g4yy1c/6g3tc8jL1SyT
         DPbA==
X-Gm-Message-State: APuU4Z9cTT+KqauvCbwoCxjzjuDeEobqRFLSQlki/lAXCL1HWuN0WLBd
	LGhMZnG5ethfGJ4RsGEzpeaRyugS0xpimfHRxqzJUHaQ71aM8Qf2C0XQFmKzu3Cl106jOCClg2h
	zfqAltmdhaNl3SzHkP2gDFzDjMeowWnh1d7VJNJXOTu98JoCG7htdTsdLHpVeCz74VNMWFOZ87k
	lJNU6nn4A+u7Il+0blmqdM0WwaCtXaNxgEeGPRJhnAbONe4GhEXBeQ4VlwC/s7Z/E=
X-Received: from dlan21-n2.prod.google.com ([2002:a05:7022:eb55:20b0:19b:58fb:b643])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:221a:b0:1a0:e3e2:22a3 with SMTP id a92af1059eb24-1b39feef1fbmr979002c88.31.1794117489848;
 Sat, 07 Nov 2026 21:58:09 -0800 (PST)
Date: Sun,  8 Nov 2026 05:58:03 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108055809.2122934-1-almasrymina@google.com>
Subject: [PATCH net-next v2 0/6] net: devmem: support leased RX and TX queues
 on netdev unregister
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Support leased RX and TX devmem bindings when either the virtual device
(e.g. netkit) or the physical backing net_device is unregistered:

1. Pass struct net_device **dev_ptr to net_devmem_lock_dev() so callers
   can lock either binding->map_dev or binding->bind_dev.
2. Rename binding->dev and binding->vdev to binding->map_dev (physical
   DMA device) and binding->bind_dev (device passed to bind-rx/bind-tx).
3. Guard __netif_mp_open_rxq() and __netif_mp_close_rxq() against an
   unregistering physical device reached through a queue lease.
4. Always populate bind_dev on RX and TX bindings and handle teardown
   and netdev unregistration of both bind_dev and map_dev.
5. Resolve the physical backing map_dev in netdev_nl_get_dma_dev() for
   leased RX bindings, lock map_dev around net_devmem_bind_dmabuf() on
   bind-rx when map_dev differs from netdev, assert both devices are
   locked, and check map_dev->reg_state.
6. Add kselftests in nl_netdev.py covering leased RX and TX devmem
   bindings across both virtual-first and physical-first netdev
   unregistration orders.

v2:
- Split patch 3/4 from v1 into 3 smaller commits (patches 3/6..5/6).
- Clear rxq->mp_params and return 0 in __netif_mp_close_rxq() whenever
  dev is already unregistering, avoiding queue reconfiguration on an
  already-shut-down map_dev during cascaded lease teardown (Sashiko).
- Drop unnecessary xa_erase() in net_devmem_unbind_dmabuf() and use a
  local map_dev variable in net_devmem_get_binding() (Stanislav).
- Restore ASSERT_EXCLUSIVE_WRITER(binding->bind_dev) in
  mp_dmabuf_devmem_uninstall(), drop redundant bind_dev->reg_state check
  in net_devmem_bind_dmabuf(), and expand commit message rationale
  (Dragos, Stanislav).
- v1: https://lore.kernel.org/netdev/20261103232659.1340283-1-almasrymina@google.com/


Mina Almasry (6):
  net: devmem: pass net_device pointer to net_devmem_lock_dev()
  net: devmem: rename binding dev and vdev to map_dev and bind_dev
  net: guard memory provider RX queue open and close on unregister
  net: devmem: always populate bind_dev and detach both devices on
    unregister
  net: devmem: resolve physical map_dev for leased RX bindings
  selftests: net: add leased devmem RX and TX netdev unregister tests

 net/core/dev.c                           |   2 +-
 net/core/devmem.c                        | 110 ++++++++++---------
 net/core/devmem.h                        |  25 +++--
 net/core/netdev-genl.c                   |  58 ++++++----
 net/core/netdev_rx_queue.c               |  17 ++-
 tools/testing/selftests/net/nl_netdev.py | 132 ++++++++++++++++++++++-
 6 files changed, 253 insertions(+), 91 deletions(-)


base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.56.0.455.g6c5a503b38-goog

