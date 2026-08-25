Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783D3955CF
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659303; cv=none; b=CFD3PTCxdNS0nUN9ULJVHuJ1HMjPZcB6UhRUTdIftWhUSNyxC3mrVd3hD87oWBPsnsgdtznSCt/7ULqGtxQtP+YizjlItKoS3N+naTm49miTrypyAbCxnjso9rQTz3egfWD0F3mb2e0fVQyGXAte2z/Q29QqP1f7TrJdsuQiPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659303; c=relaxed/simple;
	bh=OjXtOGl7YkY2Xqii5oTkMzXhJi4K525HjwElrZGr9t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQl7TfeeeeuEBRpl+mCN43xZEBtHddD7vM7fRUSK9Ec2+pVGG8IdJiK8UKla51JNYbHDSRgEMJNmi+2O6vMnYCTgSsedaxhRQSix4AkZKyjrsv1jljpSfTmrHWYlFmba8nTmvE0EYyLFbBORnSW5182CF/OHB0HM4sixJaepZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=QcesUw5p; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="QcesUw5p"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso7913220a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1787659300; x=1788264100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rERM0Vs5Xf8JcQg7lXP/QBLbgNVt1jtxOkK+TRQufS4=;
        b=QcesUw5pTJRHULvlFNXVKTVvROqMG+SWjysSvahk6BG5zQZ1E5F6xN9F3ZVSqRgQ3I
         HJiesGiObWqdF4yR7ckguwH/E5ZDyvuY/CbGPgILQUMr98kGnWzs0KwTNGDk5j6MqZSc
         oL+LfHmGQqEw8KP0HlzGJzmuj0JqboZhNodWvrkKuwKaY9j8yP15TXPmrKQt49WaeTbp
         7EGIU32jZxP/YJws1Row8iQseuNWOXuyiNGk1AAqUjK98Jh7c8WB3pjkF2WxzIL9QPmG
         rl/habOBh1gLAMwzOS2mwaveaXaCk38dZnNnC1uO2OqrSiif+L2YR88cZ62oCSlAEWBG
         El6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787659300; x=1788264100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rERM0Vs5Xf8JcQg7lXP/QBLbgNVt1jtxOkK+TRQufS4=;
        b=O2tasUgkgec12Zr+BKXFIgUA/q6YKFTFppSvs2FJmqXnn/G3IQeJdFq+s8qiQhcNiG
         JvFX2j8FHTIelZNQnelgOvrNL/bdI40LBmIPZSYnsxfmnZOdZlvQOV5J8ut/tWPTcWCW
         ZSSK33mgC5iZsXIGJ209lleUItVvH01wVvziB171uVLDV94OEJGDIGByo15b4jDGH766
         yMO8ZJoAo8feZXH1DA1cx8AafUEWtL1vxtYV9a080a/sqNbzGe7RM/VkkolM/Ns7B1ef
         3Ioo4KNUxrgEJLzJrdjIK1Cbyy9LWHaJMOovrU/IlKv12aanjMpc1XQFDoYRsptQwj4r
         XGQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoE/PPTPPjgCPHVoTrt3hREU3zTnN91GlGMpEDPFx/2NFQ7Ysvr3nRoLYjyunJ23pzvM99Oeq0=@vger.kernel.org
X-Gm-Message-State: AFuF++k1EiMcFrVdgyPi4Wj/qFswtl8258DYm6U39P/O0Bzqpv3p78DY
	ni3PAXWyC+Teb6kHNWYdJm2yVtw8kZY2zVe7zRQ1VXaGi8VIM2o1bpeGacq2k2Ln9UtJ
X-Gm-Gg: AR+sD10tdeQ0oeHW8XMjfVh83W1ev6HF+ze+92Q9XkqX7sH/jJnZzkgwSK07n3T18jP
	/Ek1c/+5l9LymNUV5fLO9XLOfqSdURm8psu7p0wNvycwvlv3HDwWkWkGPNlYMCKTPijepCt+1Ky
	aWl2VcGBKmKFSX2ucxKp22v1tl0h90q3jQLZrT/HY5zd0L57U3hisYqxbeE/aihy5rnKtumCB0N
	ZpqZRE3GG+olM7J7vatjD+OgZxmsT/nssbLV93icNqa9TgeoPPpJJizknQM0czY9s+bgUeRVk07
	BZV+mJG4h9lC5Mnn8IMmNL96x0iuRfiHod1ing3MpleiQoZoefNpWk6NCpMUip17o90RV5DcAk8
	iAv1bcK/gQmtWbySBiF6SGSFBHEB1oJjGxPFVcqAw7IqYUP6egAXK2T6TO55GOO190ox9AfI9/4
	VoJalc/FX8l/dxJXLyJZQa/+4H0dfZUEnRaunltoqbRgmm80+xYMr+57bEMbErAgj02yHCiitD0
	8fEMcxgAY3pdchJfYUS2KQqsaZkQmCplfND1nAgrzOrwV84cflLy3YNNYEouUEZh7st
X-Received: by 2002:a17:907:8e86:b0:c1c:4db0:8314 with SMTP id a640c23a62f3a-c24e5b55335mr630228966b.13.1787659299395;
        Tue, 25 Aug 2026 05:01:39 -0700 (PDT)
Received: from localhost.localdomain (cpc69057-oxfd26-2-0-cust39.4-3.cable.virginm.net. [82.6.0.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629929dsm1808384966b.23.2026.08.25.05.01.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 05:01:38 -0700 (PDT)
From: pamoutaf <paula@bynar.io>
X-Google-Original-From: pamoutaf <pamoutafpro@gmail.com>
To: achender@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net/rds: fix out-of-bounds write in rds_conn_peer_gen_update()
Date: Tue, 25 Aug 2026 13:01:32 +0100
Message-ID: <20260825120132.51636-1-pamoutafpro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paula Moutafian <paula@bynar.io>

rds_conn_peer_gen_update(), rds_start_mprds() and rds_check_all_paths()
all iterate conn->c_path[] up to RDS_MPATH_WORKERS (8) or conn->c_npaths,
but c_path is allocated with only

	npaths = (trans->t_mp_capable ? RDS_MPATH_WORKERS : 1)

entries in __rds_conn_create() (net/rds/connection.c).  Only the TCP
transport sets t_mp_capable, so for the IB/RDMA transport (and the loop
transport) exactly one rds_conn_path is allocated.

c_npaths is derived from the peer via the RDS_EXTHDR_NPATHS handshake
extension header and is only clamped to RDS_MPATH_WORKERS, never to the
transport's actual allocation.  A remote peer on an RDS/IB (RoCE) fabric
can therefore complete the unauthenticated handshake and, by sending a
second RDS_EXTHDR_GEN_NUM with a changed generation number, drive
rds_conn_peer_gen_update() to walk c_path[1..7] past the end of a
one-element allocation -- taking cp_lock, writing cp_next_tx_seq /
cp_next_rx_seq and walking cp_retrans on neighbouring slab objects.
rds_start_mprds() and rds_check_all_paths() are reachable the same way
via a peer-supplied c_npaths > 1; note rds_check_all_paths() is a
do/while and dereferences c_path[0] before testing the bound.

Reproduced against an unmodified 7.2.0 KASAN build, triggered from a
hand-rolled RDS/IB peer completing the handshake and sending two probes
with differing RDS_EXTHDR_GEN_NUM:

BUG: KASAN: slab-out-of-bounds in do_raw_spin_lock+0x55/0x9a
Write of size 4 at addr ff1100000425a624 by task ksoftirqd/0/13
Call Trace:
 do_raw_spin_lock+0x55/0x9a
 _raw_spin_lock_irqsave+0x12/0x18
 rds_recv_hs_exthdrs+0x34a/0x52a
 rds_recv_incoming+0x5a8/0xb33
 rds_ib_recv_cqe_handler+0xda1/0x12b6
 poll_rcq+0x8e/0xb1
 rds_ib_tasklet_fn_recv+0x1c4/0x348
Allocated by task 10:
 __rds_conn_create+0x5b3/0x168f
 rds_conn_create+0x18/0x1b
 rds_ib_cm_handle_connect+0x486/0xa35
The buggy address is located 44 bytes to the right of
 allocated 504-byte region, cache kmalloc-512

The corrupted neighbour's cp_retrans.next is then dereferenced on the
next line, producing a fatal GPF (RIP: rds_recv_hs_exthdrs+0x3ba/0x52a,
KASAN: null-ptr-deref) -- a crash, not merely a detected access.

Fix conn->c_npaths at the source instead of guarding every reader: in
rds_recv_hs_exthdrs() (net/rds/recv.c), clamp the peer-supplied
RDS_EXTHDR_NPATHS value to the transport's actual per-connection
allocation rather than to the fixed RDS_MPATH_WORKERS ceiling. c_npaths
can then never exceed the number of rds_conn_path entries
__rds_conn_create() allocated, which takes care of rds_start_mprds()
and rds_check_all_paths() -- both already bound their loops by
conn->c_npaths -- with no change at either call site.

rds_conn_peer_gen_update() is different: its loop is bound by the fixed
RDS_MPATH_WORKERS constant, not by conn->c_npaths, so the c_npaths fix
above does not reach it. It still needs its own bound, computed the same
way as the allocation site and mirroring the sibling pattern already used
in rds_conn_destroy() (net/rds/connection.c).

rds_conn_peer_gen_update() and rds_start_mprds() (net/rds/recv.c) were
both correct when written, with c_path still a fixed
RDS_MPATH_WORKERS-element array:

commit 905dd4184e07 ("RDS: TCP: Track peer's connection generation number")
commit 5916e2c1554f ("RDS: TCP: Enable multipath RDS for TCP")

They became wrong when the allocation was made conditional on
t_mp_capable without updating either loop or the RDS_EXTHDR_NPATHS clamp:

commit 840df162b3eb ("rds: reduce memory footprint for RDS when transport is RDMA")

rds_check_all_paths() (net/rds/connection.c) is unrelated to that
regression: it was added new, three years later, and was unbounded
from the moment it was written, but is fixed by the same c_npaths clamp:

commit 9ef845f894c9 ("rds: If one path needs re-connection, check all and re-connect")

Fixes: 840df162b3eb ("rds: reduce memory footprint for RDS when transport is RDMA")
Fixes: 9ef845f894c9 ("rds: If one path needs re-connection, check all and re-connect")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Paula Moutafian <paula@bynar.io>
---
v2:
- Per Allison Henderson's review, clamp conn->c_npaths itself at the
  point it is set from the peer's RDS_EXTHDR_NPATHS in
  rds_recv_hs_exthdrs(), instead of adding a second bound check at
  each of its readers. This covers rds_start_mprds() and
  rds_check_all_paths() with no further change at either site;
  net/rds/connection.c is unchanged from v1.
- rds_conn_peer_gen_update()'s loop is bound by RDS_MPATH_WORKERS
  directly, not by conn->c_npaths, so it is unaffected by the above
  and keeps its own bound from v1.

[v1] https://lore.kernel.org/netdev/213829b7380f1fe12aed2f2ae9ba33c2870addd5.camel@kernel.org/T/#t

 net/rds/recv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/rds/recv.c b/net/rds/recv.c
index cf3884d87931..c7f575bad91c 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -133,15 +133,16 @@ static void rds_recv_rcvbuf_delta(struct rds_sock *rs, struct sock *sk,
 static void rds_conn_peer_gen_update(struct rds_connection *conn,
 				     u32 peer_gen_num)
 {
-	int i;
+	int npaths = (conn->c_trans->t_mp_capable ? RDS_MPATH_WORKERS : 1);
 	struct rds_message *rm, *tmp;
 	unsigned long flags;
+	int i;
 
 	WARN_ON(conn->c_trans->t_type != RDS_TRANS_TCP);
 	if (peer_gen_num != 0) {
 		if (conn->c_peer_gen_num != 0 &&
 		    peer_gen_num != conn->c_peer_gen_num) {
-			for (i = 0; i < RDS_MPATH_WORKERS; i++) {
+			for (i = 0; i < npaths; i++) {
 				struct rds_conn_path *cp;
 
 				cp = &conn->c_path[i];
@@ -210,6 +211,7 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	u32 new_peer_gen_num = 0;
 	int new_npaths;
 	bool fan_out;
+	int npaths = (conn->c_trans->t_mp_capable ? RDS_MPATH_WORKERS : 1);
 
 	new_npaths = conn->c_npaths;
 
@@ -221,7 +223,7 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		/* Process extension header here */
 		switch (type) {
 		case RDS_EXTHDR_NPATHS:
-			new_npaths = min_t(int, RDS_MPATH_WORKERS,
+			new_npaths = min_t(int, npaths,
 					   be16_to_cpu(buffer.rds_npaths));
 			break;
 		case RDS_EXTHDR_GEN_NUM:

base-commit: 564973a259ec76f2dad0853420e7034cc43994c4
-- 
2.50.1 (Apple Git-155)

