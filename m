Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CEE436BEA
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927190; cv=none; b=Ix32cWGJrYNybMVbiXqy9VI5ppfn4w346IhDxJ8tc+/ZJa9nnWhtddrRufdnGPi54LRQW4ROOwDeE723qruIyvT10LP0xErnZ+PL52oiL8IKTny/N5gzT+mn992pwWeSRwk7/sUENQvwasqwCz+zZbrCscZrHWtmqe319VrOTn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927190; c=relaxed/simple;
	bh=trT3rvTJhFIl6Mb56wr2RPbI2BiO4KDm+AC3rKln1Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESvVw8BQy/V4rO6KMdAGi182JtKJdhFRxr+3ZF2LspCkh2VpSov4Qrk0woTZ2sJL+fVIu+7SGHf8cm6b9RAjDAXmTdmgW+qHU7PD/VV2CcX1nMzt5cGPJkHyO6/RoaCt5ZbGwFUeuV9drjLZG+QWso7XJRY2mp7uDdQYljl4g6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhgF4PyZ; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhgF4PyZ"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-3396cec93b6so8346656eec.3
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790927187; x=1791531987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dmW+yItKor5Yjcaq5d7/Bo8PmdtPozw8dGlxBD6FboY=;
        b=AhgF4PyZzA6iPctdwj54sRMd4aEvOUbsbMtUjsIAewkuFxFPowdkDQ/CFqQI5RAKcH
         lvJWcP5n53tVxtnTT8N+QC6KHkMSZ2DW2G96vuzGZsxKuCAGS5lD09Og3g2YijlDINyt
         1yCKco4MGh7jHX7XYC8hbRs9KP/4HELA3MJtyXjjxE08jHhvt+InnJjf5AbNpo5D93Fe
         25vopb5I+xvlr+EEJjcXGMtwDqwjK+/nHMhneLPZQCP/vXzuYyzSUJkNASVlQRWpCNEE
         a0GZnqRIh68oAQ1gShytL2S+jRlc6FSu2V+p9PWIZw9B6MS7vBwdFh2Uo9z0hpsDH3kn
         uk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927187; x=1791531987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmW+yItKor5Yjcaq5d7/Bo8PmdtPozw8dGlxBD6FboY=;
        b=Ut4FZDKfQmiuVPSBGVZxWg/TjM4RosgIN+bbdeuMP0pwiuc2ccmb+Whgu5I3lptZuQ
         10gf4VHaCH4S6jgwwgDwuSxcX4UBr7mt7NYjkjxHvpl/weUkroBAOQgQ8J5eltacrG8R
         0EEZH/166istSVTzpwLM0aXiDUgg4W8cZahsTpbHjJ42sXLP5dv5j2aAGswqSr4IOnzl
         fE+dRj59NiQehGL6UPYysx5UpokGxOLsbqnGECPgZu1R5i0I/1eZwhZxZvYYI1ygnD+I
         3TgzGB9HfmAYc3kJ8YKe2WM8Azh19AhpAyPYFbC+MGIaU/Dhe5J5LOF7yMeYAFsea87g
         l+sw==
X-Forwarded-Encrypted: i=1; AKwUvBzyveJvAtqgqdwZ49LwKw5qCKZlZ5p9r0Lt4NJeRabBIERUu6l5yAwz4nVzjkc7nLtljV8c3qg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjxnzppsaep7myY923EtWaxjZ4h7qd2yDVP588eZTCVfIZsnma
	ZhmkxNhfM1mROtNOmquTa0NtYGJ+TJJIlA9Q/xwKzQKTqStn2QnI463H
X-Gm-Gg: AYBFou3JKTTIya1QJeOZQ+F8drb6FX06SSscWxWedinhVP83gtO9S++/vEhmi+MA66g
	uBgDVhjhOVgJtpb7XEaaLFTZsnzmQtc6hD6TSThCjjtgR3vNzm+giNuJn0uebJFs1fmsBdoJdPq
	lceq/fKsxE8vYR/3XdE4NNTgTsLlrNOpA904x0K3rhV8dP4c6mlxaJcLAqfslQUYLbzzOnQ3ssZ
	VjkvxRoZKqL6Nht2aFzo8a6UyhEbXHSm0mdBkUqVbH0SdM+z2YP44T0j0xlfing2xvRM/rv+hOv
	+GzX4jbC60lpQhO7+qeX6zedJ022LwmXAgBXtI8och3xUsWhm3nr21/Y0DvDs5gv1VzMsbAjgmG
	+5dndIve4ElRVmQVBMX1MzqklSBmLXDyIc0T3WZhfeBJGp71Ulv97iQ3JnjNWtpNDHJURVF1Csz
	g18cJfjHXSVKdoYg9a3KRJ9p7icAc8ToMcVtYVTMtauDLpRwa06jzsIaBd8fSHQkKFbY/3
X-Received: by 2002:a05:7300:50e9:b0:341:fcbb:abfc with SMTP id 5a478bee46e88-34f219c4297mr2259632eec.37.1790927187317;
        Fri, 02 Oct 2026 00:46:27 -0700 (PDT)
Received: from dbg-srv ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm5871618eec.4.2026.10.02.00.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:46:26 -0700 (PDT)
From: physicalmtea@gmail.com
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] vsock: reduce RX per-packet socket overhead
Date: Fri,  2 Oct 2026 07:45:46 +0000
Message-ID: <20261002074551.318789-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

This series reduces per-packet socket overhead in the virtio-vsock RX
worker.

Patch 1: separate socket lookup from locked packet processing.

Patch 2: keep one socket lock across a bounded run of established
STREAM/RW packets for the same native socket.

Patch 3: reuse the locked socket for later packets with the same
address tuple.

Patch 4: coalesce default write-space notifications while that
lock is held.

Patch 5: defer the default readable callback until after the batch
unlocks. Custom callbacks retain per-packet notification behavior.

Performance:

Tested on single-stream AF_VSOCK (1 reader on Guest CPU0, virtio-vsock IRQ
on Guest CPU1, fresh QEMU guest per state, 16 balanced AB/BA pairs per
payload).

End-to-end RX throughput (64K receiver buffer, SO_RCVLOWAT=1):

  payload  baseline RX (G/s)  PATCH RX (G/s)  throughput change (95% CI)
  256B     0.5722             1.0286          +79.76% [+75.40%, +84.23%]
  512B     1.1464             1.9779          +72.53% [+69.50%, +75.63%]
  1K       2.2714             3.6368          +60.12% [+56.92%, +63.37%]
  4K       3.9095             7.7160          +97.37% [+92.09%, +102.79%]

Fixed-syscall stress test (receiver buffer = sender write size; RX in G/s):

  payload baseline RX PATCH RX throughput change (95% CI) recv() base/patch
  256B     0.2885       0.6737    +133.50% [+123.58%, +143.86%]  1048577/1048577
  512B     0.5631       1.2091    +114.71% [+104.97%, +124.92%]  1048577/1048577
  1K       1.5361       2.9678    +93.20% [+80.15%, +107.20%]     1048577/1048577
  4K       2.8378       6.1878    +118.05% [+109.15%, +127.33%]  538802/525645

Request-response latency (Ping-Pong RTT, 10,000 requests):

  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
  256B     126.968                124.541              -1.91% [-3.35%, -0.45%]
  4K       130.362                126.664              -2.84% [-5.12%, -0.50%]

Diagnostic Guest CPU1 system-wide cycles (fixed-64K receiver, with perf):

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  256B     15.287            13.630          -10.84% [-12.51%, -9.14%]
  512B      7.306             6.611           -9.51% [-10.92%, -8.08%]
  1K        3.811             3.458           -9.25% [-10.96%, -7.50%]
  4K        1.850             1.669           -9.75% [-11.78%, -7.67%]

Jia Jia (5):
  vsock: split socket lookup from locked RX processing
  vsock: amortize RX socket locking for stream packets
  vsock: reuse same-flow socket lookup in RX batches
  vsock: coalesce RX write-space notifications in lock batches
  vsock: defer RX readable notifications until batch unlock

 include/linux/virtio_vsock.h            |  14 ++
 include/net/af_vsock.h                  |   3 +
 net/vmw_vsock/af_vsock.c                |   2 +
 net/vmw_vsock/virtio_transport.c        |  48 ++++-
 net/vmw_vsock/virtio_transport_common.c | 341 +++++++++++++++++++++++++++-----
 5 files changed, 357 insertions(+), 51 deletions(-)

base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
-- 
2.53.0
