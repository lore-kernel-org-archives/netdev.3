Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30F49E5DD
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668680; cv=none; b=k/yAQHqvmZOmjvSLY/iQPClZQdrEgm2sXyGYsrbU9VUoRH+DURCZu+G5HYr/N+TgO5CIb3ke/kzHat1zHx4Czzm4lJz/qfz8M195Q11esWo7hVbcPJ1FRI8pAnq6H8MSjBHyIPbaEyoGU1YWdtBS0g1Jn6Pvoin+QL7Ygyzgo4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668680; c=relaxed/simple;
	bh=iBKmB6XVbw2VzxW2s/DhdbL/zmmCm2V2XhWA9HVlSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nL87EFR/HUqKJARexvmmb8Rx36/quN2mGcYwteycxfJEo7wK+Ct4BqJE6D+m1sZKwdc3u46QR1punDpX8fU+8eKH7rb/sy0k9SLwi7esRLKX6j9CKpIbXv1bhFVkOhso6J8CBqXwXLuozRjmwfT9wCP7+dGtWVHwhvYcwifRtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2b/i9ag; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2b/i9ag"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so333411a91.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668677; x=1790273477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HWFtSmWZB00VeRuG33e5z2FRH2nwFCEJMuVCaDQLlH8=;
        b=P2b/i9agi8HXVey8XMA8Z/RD62JPOYQLmEzOWigD/WDNSTq51GetAdC46PneGJz0LN
         pABkpPwQp0chn2gHPPqJ0AY4IZ/Bk1Z9ql6Mv2bvqFYMnQr8YRug2o6HZPIYOaKy34qm
         jfqu/fSAnBr++JbyBRzZz7yxT5hNk5DaW3OxbSUMq8F/Wu2NNt7no/xw6cLVezDGSZTq
         Tlsn6HmCJ8SiOOcGU9g5tvu+LZr14LC/xfj5MnGqJQkjyQwjlh+iOofdXD4xcdvaL3at
         AFNd1zSlZDt3uFb98OTx3GO26bH0TCp73udiH64jIU6pY9ZCcLY8gzP2ybjTrATeDhyM
         RtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668677; x=1790273477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWFtSmWZB00VeRuG33e5z2FRH2nwFCEJMuVCaDQLlH8=;
        b=ryv4r/PWDjdUKqGzG/Gg/t5CplSrfvJU52nRI2Nm6ak19ZLXh26+eyTE96hmqZdmqZ
         jLruDXLvvU09+nWc3t+PADtUpKCvre0riwHe59R/E3dbCNlcKIdlGUPA0IRle/LN4bT5
         mjmyzhDWRRor+9G88vty/96inB0h/lgnJjxSXg97/g/5mqBOILBULdDxGf6gZ0eGDmwW
         592t8K8QZufCTG+fhTWw1q2RLaUTAIuXAQ4alIHJhKQF+joqKZ1DaLDKF+qr8Dr5jibr
         xsbs9xmkvUGzkLorCwSqafkbB75h29R21z0VzigqI83eV5pTWqG2Y3bUP29QZB3Kip6H
         HEsw==
X-Gm-Message-State: AFuF++nXuR/9xIszpYgTE1JxfnmRtWCr+7YNrt5fj00hlrnMxx6NQw2C
	rf+cDoxAxcuZ+CdLaAb0a8hg0TwbJvJcRW2phFcXjYjnOtmSY/xP4tIyGdMJZRrc
X-Gm-Gg: AYBFou2OwacdP2rrbSDzYx3P1gOiA6EBI9oG7xbrTIvmx4Do4O8O56ZcZfpWSW0AGs2
	umO7Wx1PkK7+QMI/Cd5PtnZsh8jGqqX5Xmm20FXNXQVleu0usVyqEHwJbnZ6RU8hSrmfhpKRERr
	L4IoM8Oz555u61/39E/LE3j6csqCl7V+FSeskWTdm4TDERSFUvZsZUe55xLWIO0EHq72OtaavVk
	Vh1nudW6vPnHOa6xyO7YMbn1+8Andr7HKintj5+UB6sihMqmQIvv3I1ZSufoU+6/NBny/PNM6tS
	ST9aSePk/jtNqiH5eB7EfRoG3YoHq0VXgrRtaKf1mpUM0P6z40tu2WIMP6/BcmFnXm1PJHeOBd2
	+Eggi6NUuEBsNEFGgxfnuL5xmUH+gyxz7FAQdHgAtUtFKDpTot2rVj765Oyw3MPB16lX7akkr+8
	yBwdf/0AiZhrN5Z28iMS08WPAkzA4ULX48/Jf+ezmUtDJVUVbQLPJtzBLFaoi8xqq2xg==
X-Received: by 2002:a17:90b:4b90:b0:39e:4c81:6c62 with SMTP id 98e67ed59e1d1-39e54d65a40mr16963a91.29.1789668677248;
        Thu, 17 Sep 2026 11:11:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361168c4sm6297189a91.4.2026.09.17.11.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:11:16 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/3] net: devmem: remove gen_pool from dma-buf allocations
Date: Thu, 17 Sep 2026 11:11:13 -0700
Message-ID: <20260917181116.3319017-1-sdf@fomichev.me>
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
embedding the net_iov_area directly in the dma-buf binding. Patch 3
batches freelist allocations.

= Performance:

kperf/client ... \
        --num-rx-queues 4 \
        --dmabuf-rx-size-mb 2048 \
        --dmabuf-tx-size-mb 2048 \
        --validate no \
        --time 60 \
        --read-size 67108864 \
        --write-size 67108864 \
        --num-connections 4 \
        --tcp-cc dctcp \
        --pin-off 4 \
        --devmem-rx \
        --devmem-tx \
        --devmem-rx-memory cuda \
        --devmem-tx-memory cuda

With 4 queues, 4 flows, 2GB BB, cuda for both rx and tx I see no difference
in throughput or cpu utilization (see selective runs below).

== Before

10 runs: 206.031 243.546 293.931 319.015 319.923 323.189 324.321 325.499 327.134 349.450 Gbps

Sample:
client: == Source <redacted>
client:   Tx 48.170 Gbps (361716776960 bytes in 60072872 usec)
client:   Tx101.256 Gbps (760343429120 bytes in 60072872 usec)
client:   Tx101.077 Gbps (759001251840 bytes in 60072872 usec)
client:   Tx 69.440 Gbps (521435873280 bytes in 60072872 usec)
client:   Rx  0.000 Gbps (0 bytes in 60072872 usec)
client:   Rx  0.000 Gbps (0 bytes in 60072872 usec)
client:   Rx  0.000 Gbps (0 bytes in 60072872 usec)
client:   Rx  0.000 Gbps (0 bytes in 60072872 usec)
client: == Target <redacted>
client:   Tx  0.000 Gbps (0 bytes in 60074846 usec)
client:   Tx  0.000 Gbps (0 bytes in 60074846 usec)
client:   Tx  0.000 Gbps (0 bytes in 60074846 usec)
client:   Tx  0.000 Gbps (0 bytes in 60074846 usec)
client:   Rx 48.158 Gbps (361638901920 bytes in 60074846 usec)
client:   Rx101.253 Gbps (760343429120 bytes in 60074846 usec)
client:   Rx101.074 Gbps (759001251840 bytes in 60074846 usec)
client:   Rx 69.438 Gbps (521435873280 bytes in 60074846 usec)
client:   net CPU  1: usr: 0.00% sys: 0.01% idle:39.42% iow: 0.00% irq: 0.64% sirq:59.91%
client:   app CPU  5: usr: 1.21% sys:97.71% idle: 0.09% iow: 0.00% irq: 0.24% sirq: 0.71%
client:   net CPU  2: usr: 0.00% sys: 0.00% idle:38.19% iow: 0.00% irq: 0.84% sirq:60.96%
client:   app CPU  6: usr: 1.24% sys:97.73% idle: 0.04% iow: 0.00% irq: 0.24% sirq: 0.71%
client:   net CPU  0: usr: 0.05% sys: 0.27% idle:69.92% iow: 0.00% irq: 7.71% sirq:22.04%
client:   app CPU  4: usr: 1.78% sys:80.71% idle:16.79% iow: 0.00% irq: 0.38% sirq: 0.32%
client:   net CPU  3: usr: 0.00% sys: 0.00% idle: 0.00% iow: 0.00% irq: 0.39% sirq:99.60%
client:   app CPU  7: usr: 0.21% sys: 6.64% idle:90.75% iow: 0.00% irq: 0.05% sirq: 2.32%

== After

10 runs: 213.032 226.471 235.052 257.113 323.233 331.597 342.893 348.188 351.866 354.311 Gbps

Sample:
client: == Source <redacted>
client:   Tx104.829 Gbps (786515886080 bytes in 60022934 usec)
client:   Tx105.455 Gbps (791213506560 bytes in 60022934 usec)
client:   Tx 61.717 Gbps (463051161600 bytes in 60022934 usec)
client:   Tx 51.430 Gbps (385875968000 bytes in 60022934 usec)
client:   Rx  0.000 Gbps (0 bytes in 60022934 usec)
client:   Rx  0.000 Gbps (0 bytes in 60022934 usec)
client:   Rx  0.000 Gbps (0 bytes in 60022934 usec)
client:   Rx  0.000 Gbps (0 bytes in 60022934 usec)
client: == Target <redacted>
client:   Tx  0.000 Gbps (0 bytes in 60058283 usec)
client:   Tx  0.000 Gbps (0 bytes in 60058283 usec)
client:   Tx  0.000 Gbps (0 bytes in 60058283 usec)
client:   Tx  0.000 Gbps (0 bytes in 60058283 usec)
client:   Rx104.767 Gbps (786515886080 bytes in 60058283 usec)
client:   Rx105.393 Gbps (791213506560 bytes in 60058283 usec)
client:   Rx 61.673 Gbps (462998508768 bytes in 60058283 usec)
client:   Rx 51.400 Gbps (385875968000 bytes in 60058283 usec)
client:   net CPU  0: usr: 0.01% sys: 0.21% idle:65.30% iow: 0.00% irq: 9.15% sirq:25.29%
client:   app CPU  4: usr: 1.19% sys:98.00% idle: 0.03% iow: 0.00% irq: 0.21% sirq: 0.54%
client:   net CPU  2: usr: 0.00% sys: 0.00% idle: 0.03% iow: 0.00% irq: 0.44% sirq:99.51%
client:   app CPU  6: usr: 2.14% sys:77.48% idle:19.92% iow: 0.00% irq: 0.36% sirq: 0.07%
client:   net CPU  3: usr: 0.00% sys: 0.00% idle:43.01% iow: 0.00% irq: 0.69% sirq:56.28%
client:   app CPU  7: usr: 2.03% sys:71.04% idle:26.45% iow: 0.00% irq: 0.37% sirq: 0.08%
client:   net CPU  1: usr: 0.00% sys: 0.01% idle:46.66% iow: 0.00% irq: 0.56% sirq:52.75%
client:   app CPU  5: usr: 0.05% sys: 0.08% idle:99.21% iow: 0.00% irq: 0.03% sirq: 0.61%

== Comparison, over 10 runs

Median Target RX:  321.556 Gbps vs 327.415 Gbps
Mean Target RX: 303.204 Gbps vs 298.376 Gbps
Range: 206.031-349.450 Gbps vs 213.032-354.311 Gbps

v3:
- fix 32-bit build (NIPA)
- clarify the teardown warning (Mina)
- make the freelist RX-only (Mina)
- derive net_iov count from dma-buf size and fold the SG walks (Mina)
- remove redundant total_niovs state (Mina)
- remove redundant freelist slot clearing (Mina)
- simplify net_devmem_iov_binding() (Mina)

v2:
- xmas tree (Jakub)
- batching (Mina)
- perf numbers (Mina & Jakub)

Stanislav Fomichev (3):
  net: devmem: replace gen_pool with freelist
  net: devmem: embed net_iov_area in binding
  net: devmem: batch net_iov allocations into the page_pool cache

 net/Kconfig       |   1 -
 net/core/devmem.c | 216 ++++++++++++++++++++--------------------------
 net/core/devmem.h |  44 +++-------
 3 files changed, 104 insertions(+), 157 deletions(-)

-- 
2.53.0-Meta

