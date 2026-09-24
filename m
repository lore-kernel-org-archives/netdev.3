Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034EC4D9901
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282733; cv=none; b=hagQ9Y8V5VGwyS84dlBiMg6il3zYwGJO1ZaRyIW7Bgj7V8IRkeNAW0q62L0hqKHlw730jVBcXencQ2iDnVjqXz7dt05blJRVWFRALWBAMtSi2E28GP7+Fv/5azdmU1VjIx1wp5XPx3urLngTww3YVzWcK3jcrCCXBxNHnM852ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282733; c=relaxed/simple;
	bh=hEGiBEOi5woV4xempkgCXFP668FsKubP1oj1IYYuES0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uvill9PJLs9jLNDjhYliphufdTAcs5DolsifExtWNtDtq2I8dgI+2548B5x6w8/hcX0sAemzbY2fCfEi8wErDULfGT+C0y1RRTlOTyDl9QW0rZV2iISeFs2d/OUENKGSlxO0eJwszhzdFur+ls2gVLW1kR2hKZ71s+ftKlJiOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=everpuredata.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=NTUtHUTX; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="NTUtHUTX"
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-495437bb891so813305e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1790282727; x=1790887527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HDYMiV8RMerr0fsYntJKhZJhzgvwPwMDOJtIUcfyt2k=;
        b=NTUtHUTXrQcotkPVPl/8blB6QM/ONLUql6JoOG6EF6tfGKouATTzUl0+5ruc9wuAva
         FPpR63vE4PMwjnTM7AHLb8qd0APpmrb+q63VMsaNRD/iH7PwzdFEnrSZoab7kLcSvYxe
         X3mk/hrfm1CwdyiC6s+++MXQcccDZ9tUGL8MyvebsMc2SGsxzYDiYRaMlWbd3oSc0sdK
         66zTUdcEgx3KY5s7oVaotvJEDaltTxll1+PUDuXiczlb2WopDO8q0wpqhbHbOVlvHBX4
         Z/6yXqwB+obvK2ml2gI/EUALOVePtiTuMF8uncq0pZ1ouJMAI0YH7B3nYiTglbMO7IBQ
         dQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790282727; x=1790887527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDYMiV8RMerr0fsYntJKhZJhzgvwPwMDOJtIUcfyt2k=;
        b=Z9etHsDmsYYQyHK/zBITw6LbzcLCD/7PN2hhj0oNfZO6IcykC4JQFgSUUoppwDnO2E
         2LIFEcvaSJIKoDPEyGNjYE/qAELHLjFTzGNaiEJsbyku6XIQXZuP5DZALHBro5iPo4sA
         D6d5X+ORqdJSc4gi9Z9K0r86/PqmZF0H1+uwiZwIdeHNes9lxtdUAHOx6iJBN2xNj8gi
         7TmiHzx4rr9tSeEjEhPGL7ZZZl9kxKkh9jNENe5wjXl4XM4N5dFoJo6PsO6Vq063LrLT
         0koCkBWI69QN3rGyNejglWiMKsg3fsAwvVjkMATZYsRQu+vy4Cy9MZdY2JJSzQcUYEdw
         OCTw==
X-Forwarded-Encrypted: i=1; AKwUvBzcEjBSdCKUPa/0BzhC1a9BDkevGWoORR2nYMTh1uOvx2la+wUb9Uq01NwIPIYParUzlXWuq38=@vger.kernel.org
X-Gm-Message-State: AFuF++kjFTnfomf0lPpa3AS6DduwDsPJGfEp95dzGQx5jU4T5Bxyqh4k
	zM5tkXkHkIF1Z5R53SzLThT9aL+6iSv5MAzDhSOIikIJ+LP6xN7ro4hU2draIJwe7hcXXl6qAwW
	8/umomrTU4r56szq5LZ1/fVXqZdcol61NCWyV
X-Gm-Gg: AYBFou3NdpD3SkA+ZWq4Fz6BHnVykHrb5HmNA4iffEmLzyMCmW5bpvp2X6Pq9xipJmJ
	KaBRshJpTnuirwDnG0P58jBjEYRCtT9uppBakxskx6Kr1t4hk4yMFoZpg6Rx4b+k64hGK9NgzOk
	slp8ZJZWoCKntt4AjjH37810X7AbooxcwOv2tx18yCpNgKSgBY99TIwSg9rwzr6M1OgiRQ5cDii
	xGUpPlW6yRlrTyc9fnjt5EFmmk6UB9qYy206CAi8ECZYMcYooNAjtwPbrYWRH8LtjmL1WuniiOO
	BMhgOjIGWDfLK4gVGMK03xiai/jfuTQ2oNvTUsBPHhpAn9avRQGMw3o+EN18nsndp3lfsD/dVgo
	Qleh5XxiNimlOjAwABF8BJhEK7aeE5qJ4rb+vfpA=
X-Received: by 2002:a05:600c:468c:b0:49e:715d:95ca with SMTP id 5b1f17b1804b1-49fe66f9fc1mr64060215e9.13.1790282727176;
        Thu, 24 Sep 2026 13:45:27 -0700 (PDT)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-49fef4b7564sm1008245e9.15.2026.09.24.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:45:27 -0700 (PDT)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id A047A340200;
	Thu, 24 Sep 2026 13:45:25 -0700 (PDT)
From: Tim Menninger <tmenninger@everpuredata.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiva Lingappa <slingappa@everpuredata.com>,
	Eric Badger <ebadger@everpuredata.com>,
	Jon Curley <jcurley@everpuredata.com>
Subject: [PATCH 0/2] SUNRPC/NFS: limit transport disconnects when cancelling flexfiles I/O
Date: Thu, 24 Sep 2026 20:45:23 +0000
Message-Id: <20260924204525.3381590-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series narrows the transport disconnects performed when flexfiles
cancels I/O for a recalled or revoked layout segment.

Today ff_layout_cancel_io() first cancels matching RPC tasks and then
calls rpc_clnt_disconnect() if any tasks matched. rpc_clnt_disconnect()
operates on the entire rpc_clnt, so for a data server client using
multiple transports it disconnects transports that may have had no I/O
associated with the affected layout segment.

I encountered this while testing pNFS over RPC/RDMA during data server
recovery. Restarting the NFS service on a data server while sustained
direct-read I/O was active could cause repeated reconnect activity and a
large throughput drop. The client-wide disconnect from
ff_layout_cancel_io() amplified the disruption by tearing down otherwise
unaffected transports.

The first patch adds a SUNRPC helper that combines task cancellation with
request-scoped conditional disconnects. Matching tasks are cancelled as
before. A subsequent transport-queue pass marks matching requests
belonging to the same rpc_clnt that remain on the transmit or receive
queues so that, when released, xprt_conditional_disconnect() is called
using the request's saved connection cookie.

The disconnect state is stored on struct rpc_rqst rather than struct
rpc_task. A task can release one request and later acquire another, so a
task-scoped indication could otherwise be consumed by a successor
request and applied to the wrong transport generation.

The request-marking pass also preserves the rpc_clnt selection used by
rpc_cancel_tasks(). An rpc_xprt may be shared by multiple rpc_clnt
instances, so requests belonging to other clients sharing the same
transport are not marked.

The second patch switches flexfiles to the new helper, preserving its
I/O cancellation behavior while avoiding client-wide transport
disconnects.

Testing:

The code in this series does not depend on:

    https://lore.kernel.org/all/20260916232906.4101987-1-tmenninger@everpuredata.com/

However, I used that change while collecting the results below because,
without it, the client enters the earlier recovery livelock before the
transport-disconnect behavior can be observed cleanly.

As a control experiment, I also tested skipping the
ff_layout_cancel_io() task-cancellation and client-disconnect path
entirely for RPC/RDMA. Doing so eliminates the reconnect pathology. This
shows that the pathology depends on the cancellation/disconnect path
introduced by commit b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the
layout is recalled or revoked"), but simply opting RPC/RDMA out of that
behavior would also remove the cancellation that is intended to drain
I/O associated with a recalled or revoked layout segment.

This series instead preserves that cancellation while limiting transport
disconnects to matching requests that remain in flight.

I have repeated the data-server restart test many times and the behavior
is consistent. The counters below are intentionally collected after the
restart event, once throughput has partially recovered and the client has
entered the post-recovery state in which it remains until the workload
completes.

This distinction matters because some transport activity during the
data-server restart itself is expected. The problem addressed here is
the continued reconnect activity after that transition has completed:
once recovery has settled, the client should not continue cycling
otherwise healthy RPC/RDMA connections.

Over a 30-second post-recovery sampling window, this series reduces
sunrpc events from 4,526 to 289, a roughly
16-fold reduction. RPC/RDMA disconnect and connect events fall by about
6.6-fold. During the same interval, read throughput improves from
approximately 0.4-1.1 GB/s to 1.9-2.2 GB/s.

Before (throughput: approximately 0.4-1.1 GB/s):

    Performance counter stats for 'system wide':

                 4,526      sunrpc:xprt_disconnect_force
                 1,911      rpcrdma:xprtrdma_disconnect
                 1,909      rpcrdma:xprtrdma_connect

          30.021267692 seconds time elapsed

After (throughput: approximately 1.9-2.2 GB/s):

    Performance counter stats for 'system wide':

                   289      sunrpc:xprt_disconnect_force
                   289      rpcrdma:xprtrdma_disconnect
                   291      rpcrdma:xprtrdma_connect

          30.080790959 seconds time elapsed

Tim Menninger (2):
  SUNRPC: add request-scoped disconnects when cancelling tasks
  NFSv4/flexfiles: limit transport disconnects when cancelling I/O

 fs/nfs/flexfilelayout/flexfilelayout.c |  7 +-
 include/linux/sunrpc/sched.h           |  4 ++
 include/linux/sunrpc/xprt.h            |  5 +-
 net/sunrpc/clnt.c                      | 93 +++++++++++++++++++++-----
 net/sunrpc/sunrpc.h                    |  6 ++
 net/sunrpc/xprt.c                      | 75 +++++++++++++++++++++
 6 files changed, 168 insertions(+), 22 deletions(-)

-- 
2.34.1

