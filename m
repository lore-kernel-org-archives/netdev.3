Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305BC42C51C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201333; cv=none; b=GqQ17gaOH2v+auiV5I9OSm6hVD463ZnFOrGle0+SNXs51eMTHsDV6c2JMUyQ7DozqZhj4FggLSfeoHEutF7jphVNM4W2uuze85P9CXJ3edbEpq3cGB6XEOkqHDD9xASkVkom/T1aUhKRrDmDXb7pnmFEaB2sn/bFFOPbWErvv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201333; c=relaxed/simple;
	bh=yXobrol6sR2sbusi9bYa9G/jNKiCk/EvDifEqMwFXQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otK67pQ6PrBa/7K62zzTSn12/LJHAwivvaXgeG7N4L4R2rVSzGGA2XtUY6KSVpCN8/NTkXQ6okLZXzjCTLlAvCxEdmzSs395NKwguLolhh5aHQFTdoP4gEcsni0ZJ70J6K34/ZGxze23hoeXVLlWedfpFn78Mj4OPDPILh02yc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNSaI73z; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNSaI73z"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-383390e7584so242048a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788201331; x=1788806131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MrhHUGt9PYOpeIFjjhYfmqQTda2e8V2Z82RwTN9welM=;
        b=XNSaI73zc1xZWmgrW+lDZQwF722LCbQ/WsP8jfQ1U/1mJ78L2/hTI2qAE6/xH+Uet5
         NJTMqRI6KWBOCrpWHYjg8xaThvG51zVimtFdM0eqQ9cI/qilB7aEnUCezaDmiCdjV75l
         p+VWb/e7EavKXI8fy0+6NVfpLgwGFuhDD9LqELot6oKI4nubDmkWFjpHGQT171EcVL+s
         GtsNIG1QDbDMN6O5MTw2LEqW2REhojSOd5HzH7Elumpaw7L5Dw68HAm+xmHbbTapmN7w
         NGuVXNHSNR0dSlIIH8LxmZxs9HCDzvFnCfmWOG8uqrG1qCwWxYQhAGqr6tmhfQE2xv4H
         Z72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788201331; x=1788806131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MrhHUGt9PYOpeIFjjhYfmqQTda2e8V2Z82RwTN9welM=;
        b=NApWsf4nOYxEKGxTmKdHtFfi+ZgWUiCDbB5uHMliONRsgfOykKDvyqaN4xwsw5vkhs
         QrWSeFdNaRfpuzF0k6J9xfgbk+mUzPXxYL0qrpxBcN2b021P+wFnW1e+dFngT4QXGQW4
         EJ5X+XJMaThAYNltqp2JlvSB2VjZuw3HXdt1v/930Zf+gvckdlVS09v5/1DJ5fjVFnxq
         Ev/gSo98ksIUzzcBZzCXAAyQMmSYWR+3pp7JEpUq+Fs6IkuBQpNBIxLfE7ORCBUmOa0s
         I7SJTWt2bpkIa84n4qfzPfmKg+gsBEomb4Y+5UdXkAIIeLrQePGBf8IbpT5rEPqcuJza
         ShQQ==
X-Gm-Message-State: AFuF++muwBLfOVdq0Wf5TGaoOZR6ZoaCBQa69Ly6/9zgGEsui3dWZGEJ
	0yu36u3kKGrl/DDtIzvJxNUD+kYZMcSHnXV0U8rWL7Mlwf9HYzMw0ShWIpkHMTS6
X-Gm-Gg: AYBFou3XaXk65EP3l/mhvjMsuB81qfdGkNkwzOG7InJAPHgGjVi3rZ62maakVxsCxUo
	ZO7G6Ck78oPaXzlG0BcNDdr8JWiIPZ/dwWgSkPKVIFECTo9lO39oSjf+C0KupaRukzmOdDQd7yE
	5P7HMWhHAUqhCFK2EIZ2X9XzfESzPNWa8VbqfPsxREzUKt99wwbZa8IQ8IxNgjhq8rVSOygP0Cr
	CJijD/Z6PTklFg4atlgpOnizPQlEuZbhhN/w45ZffEH1oJNfKSZX1+avYx+7nm9BoX74qC5R0vC
	/PsMBZhC6fzgKosm3zDPfZuM9y2duIokknjXdFS0RPelJsxHSj1dke4xd2kS7RogFxViFtDd4u0
	GF5vuUPI0jzu+hu0l46HngffCmmEg3bHuUAkttzilna8c69DWL9dueRdeGWj8QUBx5IdJp60P+u
	oUNSVX5rbxiX0oCNhn3maqtyeTOAfl+PHaGApPxiJuPcJq7gz5HQ2fng==
X-Received: by 2002:a17:90b:3a50:b0:398:ceef:edde with SMTP id 98e67ed59e1d1-3990f8d06a7mr165876a91.15.1788201331012;
        Mon, 31 Aug 2026 11:35:31 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d62b807sm883311a91.16.2026.08.31.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:35:30 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	bobbyeshleman@meta.com,
	almasrymina@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: devmem: remove gen_pool from dma-buf allocations
Date: Mon, 31 Aug 2026 11:35:27 -0700
Message-ID: <20260831183529.2517322-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace devmem's gen_pool based fixed-size allocator with a binding-level
freelist similar to the one used by io_uring zero-copy receive.

This is motivated by allocation latency observed in the NAPI receive path:

  [ 1036.228913]  ? gen_pool_create+0x90/0x90
  [ 1036.228915]  net_devmem_alloc_dmabuf+0x1f/0x60
  [ 1036.228918]  mp_dmabuf_devmem_alloc_netmems+0x17/0x80
  [ 1036.228920]  mlx5e_post_rx_mpwqes+0xdbe/0xdd0
  [ 1036.228926]  mlx5e_napi_poll+0x113/0x830
  [ 1036.228928]  ? sched_clock+0x5/0x10
  [ 1036.228931]  ? wake_up_process+0x778/0x14b0
  [ 1036.228933]  net_rx_action+0x15d/0x570
  [ 1036.228934]  ? update_rq_clock+0x31/0x240
  [ 1036.228937]  ? __napi_schedule+0x55/0xa0
  [ 1036.228938]  ? mlx5_eq_comp_int+0x137/0x230
  [ 1036.228940]  ? atomic_notifier_call_chain+0x36/0x90
  [ 1036.228943]  ? sched_clock+0x5/0x10
  [ 1036.228944]  ? sched_clock_cpu+0xc/0x170
  [ 1036.228947]  irq_exit_rcu+0x12b/0x370
  [ 1036.228950]  common_interrupt+0x85/0x90

udmabuf can create a very large number of SG entries. In the worst case,
devmem ends up adding one gen_pool chunk for each net_iov allocation
unit backed by those entries. The gen_pool allocation path then has to
traverse a linked list that can become too long for this hot path.

Patch 1 removes the gen_pool and replaces it with a simple freelist of
net_iov pointers protected by the same spin_lock_bh() pattern used by
io_uring zcrx. Patch 2 removes the now-unnecessary chunk owner wrapper by
embedding the net_iov_area directly in the dma-buf binding.

Stanislav Fomichev (2):
  net: devmem: replace gen_pool with freelist
  net: devmem: embed net_iov_area in binding

 net/Kconfig       |   1 -
 net/core/devmem.c | 158 ++++++++++++++++++----------------------------
 net/core/devmem.h |  38 ++++-------
 3 files changed, 72 insertions(+), 125 deletions(-)

-- 
2.53.0-Meta

