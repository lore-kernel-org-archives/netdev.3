Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007756;
	b=aDjWixtuT9YOovtCLeB7adMYqcUngJjchswLaZ2pLRc6/B3pMfl3bIMb87qdXnqxioqL
	 bSZu28Fx6fRthfL3GW+YGhFZBU5f0Zwr28cFJdcSLNycubztbG+IKWRFhOuo+TmoE+9P3
	 T1+JiznBKEAMcNa4IlX6UDpkjOsi+R+4s62dGcjp6/DqFhuH9HV9jhItre200ONL1KR/Z
	 +fo8+vUUiU/9DeZQo9g2m9DXT4P3EMY5mbkEKJv35Pplg3sh87UCYMLNu7XXtgH9R5xNX
	 FKKWaWiHYza7nL7KWllC+q2hwvyXunDCd9YRC/PtlpgQr/2g2UQ6HmWYmKGmMI+QY7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pnU+U4pwgALNgf0sM94ivT57kakLzMx+bbRDD/caJhk=;
	b=SxWKrCz6UHQZnp5acpBQoBZzz3fFmBpgVND7eFUUkmwkrfS7Pzr2rMnD9KuxQpVOnG64
	 5ezxOcxHdXyy7J4kGXCmOqKqeQ73PFfqySkoGs5JnqgfRRU13WO7khNy6jLhj3iCuffk1
	 pXBVbZgpnibl+5YG06YmUuXCpFQwNKBe11GBOO7SXAWnUHC7QGx9SToU4LfpJ+9JChLAZ
	 ajRIZSEEiz8xABKYHABWSulSEaQexTw6NamV48HX369s/twd+hRnsmwKOuuol1S66UyDZ
	 zzS79ekG6qwnhfJRqrcZUhYCc5kSSBSvY2Bqh8xClSIJsOJIvMppXIq2b+u3obs2Vpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=vQnEBQVM;
	arc=none smtp.remote-ip=209.85.215.232
Received: from mail-pg1-f232.google.com (mail-pg1-f232.google.com [209.85.215.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C4606A32E
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 23:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846C4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=vQnEBQVM
Received: by mail-pg1-f232.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so467193a12.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 15:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794007755; x=1794612555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pnU+U4pwgALNgf0sM94ivT57kakLzMx+bbRDD/caJhk=;
        b=vQnEBQVMO+QnfGuxd3pMG+Poh1HXhUmOrVuhSc8LH62am8bk9XxGHXhGsaptX1nbbD
         6JBrAQvAfzZLo1fWisbrjc0MzRgCjQD2DpzVInUpTD8HOOtQwlFw3rDOggkXJIRj8yee
         zI1mKn9qZkMllt/u3FPriMjQKY1LJd5yt7K8dEwbhBpbPUzDOCwiZGRT8NaaDgi+l2hG
         5gZjfbUdg4Xnn+ynBVF91gG4t/wgT9Mq9NmoOHn2nmNfJR5p1xKgAgyPW8pzN+CDYi76
         AjaM10PRWweMu9a1yIyZB85MOMQZ9h5op+Su1rY65arnlavzJMB6WjEt5mnN3c+onifY
         EHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794007755; x=1794612555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pnU+U4pwgALNgf0sM94ivT57kakLzMx+bbRDD/caJhk=;
        b=LCwhrNvuJMQhqLJrPj19DRaEISNfqXwOJg7kIvnMxVFw9MtrVQWW49bN0zD173+GU8
         BbFmbP+n7+YZ5t/sz0UDQP8LAa26X+WLSVHWmGO18RwZleGOES2aPPE7rMn5/+23MWJg
         b/vXf/gSFjLfVm8wEGNPRewvefH311VIhEuCXpkqaRxpvigo/YOHCbwl5jX24MVWqMcb
         Dk2Jo7FjQ2XmXdnZUc8J8GJyPlaDHokfmsqgzJvPkfxPdCWZ2bfkTbxrWka9GjP9QZeZ
         DACIDK0e+UYUS0gHpvjOQnl2yJwX7zUuPJjPzB1WwgehmLXKi2yOtLzjVBaSl5jquSp8
         BZ4w==
X-Forwarded-Encrypted: i=1; AL+hErGk621tBBv0RN3hXjAFwKn4z/ASvWd4l+CaNrm4UZw6aJoWzTGCpuJfH3ueNOIY4XD6JrqKiaQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ew5Wd0ruy+LKt8QKWEk7/EyCUJbViClgUhZK+gGNGc2LHEmdb
	Sf2o04q0zROqrYy7jcodk5mBes0Z/LUHKCKuqRSAcRsq7x/UcrF7FTyWE2t/1EOu9m5gb7AZRvW
	gNbR6Sn9UXHPYCzhVv/tf7BqfivqE/hB5TJx9
X-Gm-Gg: AYBFou2hpROYDLrCj2mEE3p7Gbo5vKSJGzkD+0ArPvJPTbc0BJQalB5sGE3UrVLM9Pv
	+k67oEGy1l3IYOdD7M277UY7VqEVK5UjzMP/VQbyIyWRLnz0VoWKg862UVKPAF5cnyZnAuu6Zk9
	pCnW12jvKQaDm8aypgrZuCx/ZlLFj7GIHbtlOvMUhnaNQzSBe1+aO7F3d2VmT9tx94gsfc+Y5az
	rGe2J8L2yUUdOfeHTMjIf4HqKPDzOOmyWsURgglWF9W0MtDSBCgt1aQPHgqNc4tlH8JRGRCerUj
	lqT3dtzwXJDUj1RLJLS9Pj8LXIrqLAljRZaAlIIBJOV1CnTtJUB7dCQWn3AEJVE+wBVQOoyR7a2
	MVQd7TTioTl4J9Ji54MEKnKxp0CWE1mnuV/ILlow=
X-Received: by 2002:a17:90b:3b43:b0:3ad:1b31:92d8 with SMTP id 98e67ed59e1d1-3b0db732ef4mr3775473a91.60.1794007754776;
        Fri, 06 Nov 2026 15:29:14 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b10581c3b0sm406284a91.7.2026.11.06.15.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 15:29:14 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 367F13400FE;
	Fri,  6 Nov 2026 15:28:44 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: cel@kernel.org,
	ebadger@everpuredata.com,
	jcurley@everpuredata.com,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	slingappa@everpuredata.com
Subject: [PATCH v3 0/2] SUNRPC/NFS: limit transport disconnects when cancelling flexfiles I/O
Date: Fri,  6 Nov 2026 23:28:41 +0000
Message-ID: <20261106232844.2176820-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
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
queues. At release, transmitted requests trigger a conditional disconnect
using rq_connect_cookie.

The marker is consumed under xprt_release()'s existing transport_lock
critical section, so the normal request-release path requires no
additional lock acquisition.

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

I applied the following because, without it, the client enters a
recovery livelock before the transport-disconnect behavior can be
observed cleanly:

    https://lore.kernel.org/all/20261105153507.3145077-1-tmenninger@purestorage.com/

I also applied the following fix for a separate frwr_unmap_sync() hang
that the reconnect churn makes easier to trigger:

    https://lore.kernel.org/all/20261106142039.1066437-1-tmenninger@everpuredata.com/

Neither change is a code dependency of this series. Both were present
in the test tree and are recorded in the base-tree metadata below.

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

Over approximately 30-second post-recovery sampling windows, RPC/RDMA
disconnect events fall from 1,965 to 276 and connect events from 1,964
to 277, approximately a 7.1-fold reduction. Read throughput improves
from approximately 0.4-1.1 GB/s to 1.9-2.2 GB/s.

The sunrpc:xprt_disconnect_force count reaches zero, but conditional
disconnects do not emit that tracepoint. The RPC/RDMA event counts
therefore provide the more direct comparison of transport activity.

Before (throughput: approximately 0.4-1.1 GB/s):

     Performance counter stats for 'system wide':

                 1,964      rpcrdma:xprtrdma_connect
                 1,965      rpcrdma:xprtrdma_disconnect
                 2,685      sunrpc:xprt_disconnect_force

          30.018975301 seconds time elapsed

After (throughput: approximately 1.9-2.2 GB/s):

     Performance counter stats for 'system wide':

                   277      rpcrdma:xprtrdma_connect
                   276      rpcrdma:xprtrdma_disconnect
                     0      sunrpc:xprt_disconnect_force

          30.048495495 seconds time elapsed

---
Changes in v3:
- Protect rq_disconnect_on_release with transport_lock and consume it
  in xprt_release()'s existing critical section, removing the additional
  queue_lock acquisition from the normal request-release path.
- Factor out xprt_conditional_disconnect_locked() to preserve the
  connection-cookie check without reacquiring transport_lock.
- Add a read barrier on the marked-request release path to order the
  dequeue fast-path runstate checks before reading rq_ntrans and
  rq_connect_cookie.

v2: https://lore.kernel.org/all/20261105020249.2607367-1-tmenninger@purestorage.com/

Changes in v2:
- Rebase onto v7.4-rc1.
- Adapt to the device-ID-aware ff_layout_cancel_io() interface,
  preserving device-node reference cleanup.
- No functional changes to the SUNRPC implementation.

v1: https://lore.kernel.org/all/20260924204525.3381590-1-tmenninger@everpuredata.com/

Tim Menninger (2):
  SUNRPC: add request-scoped disconnects when cancelling tasks
  NFSv4/flexfiles: limit transport disconnects when cancelling I/O

 fs/nfs/flexfilelayout/flexfilelayout.c |   7 +-
 include/linux/sunrpc/sched.h           |   4 +
 include/linux/sunrpc/xprt.h            |   5 ++
 net/sunrpc/clnt.c                      |  94 ++++++++++++++++++----
 net/sunrpc/sunrpc.h                    |   8 ++
 net/sunrpc/xprt.c                      | 107 +++++++++++++++++++++++--
 6 files changed, 198 insertions(+), 27 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
prerequisite-patch-id: 2e8f35e38c760c42d04307b131ce55f80df66fef
prerequisite-patch-id: e7030ad56461efdd80f97ab1e0790fd4593805a7
-- 
2.53.0

