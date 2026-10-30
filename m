Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354763;
	b=nrEYta3Wwi6GacfmjCG0NhF0y4zH69xjPnGH/B3QDPeREx20tyYJxVA1S5VDBKe7SsyA
	 6KmihgwWWridc/zUMT/JrZu/A2TYgurCiMuLo6YCP/pNV8ocWMlb3HtxXoK4C78a0K5nZ
	 qUO7qRrUbZHGJhaXyDKMN39xWb2LJJ0h6UG6Bq6DBF4vbQL5CqKoD48FJNDidJrZcvTEh
	 xOpk5JJWwliAqU8a19ZT2j3+lMj+4L+iSBm276R8w5D870ZRAdDuk/z7r9KpSFklQhQEH
	 OnBjAnn8MVWhk3Edel53BR9CdI3KzUHl6k/LbcnBJ7GSXukHQfJL6a0tfUU/JMXxqSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7+KhCK8nbtPPPnxE6PcA8d9mBVnldjGZ8TKiU45jN9I=;
	b=twAxwJpQ3o94urpOnkcIwvydvP9Buz+vZlX8ilJ3Yh5EIxkoZbC96eRC7EALyb6atNZ1
	 NN++UFRpRNY+jzAQ1lEfENAKhIHzKFRW6er45CkWp8aYfONcdfWZ3c114a4bBwFidhNko
	 yHXRcHa+2GfNFXzXeGywHaIhTDO7gj6yUTdaGtFyQOoVA6KcY5mRYPcNoGyB0WEmqhkoz
	 ft3TuPuwSp//wsgpt18uPyQHMvadspIbKtduKEqV1c5295uf9wBmNeapmbbRQY5VnZBwG
	 Op8C7hyf0UmolJugTGBRMB7HWHSAR5poCYn1GIxwpBU6OmTS6deyrO0FPgXdq0CTGrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N56b1vMX;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355D606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0355D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N56b1vMX
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso5238325e9.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793354761; x=1793959561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+KhCK8nbtPPPnxE6PcA8d9mBVnldjGZ8TKiU45jN9I=;
        b=N56b1vMXSyRiJ3dek2lXPsTDyEWeGyxYE8qkLlr466bV2HtDVFe2LiqTyjijM8Kkex
         EGPhi5UpnInWdVP6FIY1AFSpa7WBXfRV8exXn8u4xpikHUz5//hVElg5fmDoVUKa7pTv
         eGXeeO4+n69+qjDASlnHRfbVm0ccwDBNnXnYcl1sPE4HGA/dGiBBVv9uIoaQVDWakP2Y
         btKf1+AoydXDkRK69Yix2r5u5t0sDG6hnjEAflY/9MDWDXcvS6+WjKY2mdSd3mD2zMVH
         z80LPyF+TN0kFKImah9izUIyrwdgXZPb+MdoygOJGR5Ti/x2rrAczznuo0fK9y7Zlmm7
         C9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793354761; x=1793959561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+KhCK8nbtPPPnxE6PcA8d9mBVnldjGZ8TKiU45jN9I=;
        b=DMPASMeG5/QOk6ISgjJT28f2hSFLs39D8/t31kf02E8EEq5/KYe8ZZJSs8aMkSvJeU
         Pd1LR9QTgLg8wkd794RR9vEVMR7FByu8Ffr7/UqTreOArb81hKZmfcDScfyfGbeu2Nft
         Gfkc893DGzaK9PTxPzXJz/ledwCrUxceHMc0j6AAASFTgbuEhGU2f2HJH2EIgZsTVC6t
         Njmi5tQW6HqMWElj06zEpX7Fvu5aC2qk527fMClyrbiisKlAVfP4S19XCI8srYkLlnrt
         i+GWqyemaM/lIFCVvLEVEdSqzYpQOI/SLVfj0vI4ErBz0BUV5WKdnvm+aOxZ2wTngCq3
         2FzQ==
X-Forwarded-Encrypted: i=1; AKwUvByE+Fa5F9+6ycBApBFOa4Ag0n7LYq78+q0VaKe9grlb+dEQn+UkopZKWe8C7f5wVOfzi0i9ueY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIb1neihSKtcR3A3JEoUF0gEIi7QlkPS2iBH8c34Bi5301xejQ/
	LTGTXVjPz0eCGnSHfa+Yb9f87BRMGALGykI09zntKUdGkXzJmGbC4p32
X-Gm-Gg: AYBFou3ekSCcy805hwKy9hh+SuT9Alxwquko1vCxq7RAsDYWj7yd6nOXhRdqcnwtxIp
	dF41eETrKKucblELlnG2WREtGcnLtQreZ7GmAkpRE3GoOG9zX8goZ/lH4QLXllvuSTheqCcNxsg
	oqGIHuknck4o50ru8nSqEggfaYSe9ktgr58gD7y6JBdAvv74ycrPfmZNmOY4jFDvKe8vtuokNTl
	MnJZIOTz3jwIj8J8emkDSdVWTwbHrreFNkpfBPPBIIPkmjV7sm1wUTFnmDKqrvoHlFHf1s4K9wq
	jGrfG11WYu8gBUS/8Ms2Gk0XV/eYs+/cPq4J2hyJKq39eqeaHx2CEYCFoMEjpkHUb0HPWUps475
	yOTfF1g/g5GTb4US/W1J1nOgyxc/br4/T2NBAJVXNagUTKA/jUL/WZTnrLSDmrK692Oad5vZyDl
	q7Gq3ganA8DDxfNvFXT0QJ2rPa2wl1g/VawnZJvcPgte2hz2HZLqmuGATe4ngomjtDx9Iu1S0Qw
	YEXnMLh9OZ0OSTL1IzaGQRN1HkElIY6F5QT774oNzobg+uNdj9Mcn2fZx8Fgj6Ytgy03UbRv2A8
	ntqgYCXjVgvUeQ9HzzFlXQ6Uxoiz9xVrZf7QCzCaM3fAC5MHitIOZahzbqVWnrcGm1mNm3IhlHw
	amL1U7bI=
X-Received: by 2002:a05:600c:8b47:b0:4a2:1960:6db with SMTP id 5b1f17b1804b1-4ac185bc2aemr37877015e9.26.1793354761147;
        Fri, 30 Oct 2026 03:06:01 -0700 (PDT)
Received: from pop-os.. ([51.36.40.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0a66caefsm36175695e9.5.2026.10.30.03.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:05:59 -0700 (PDT)
From: Ahmad AG <ahmadag1001@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ahmad AG <ahmadag1001@gmail.com>
Subject: [PATCH net v2] net/packet: account user-triggered allocations to memcg
Date: Fri, 30 Oct 2026 13:05:04 +0300
Message-ID: <20261030100504.23498-1-ahmadag1001@gmail.com>
X-Mailer: git-send-email 2.43.0
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

A packet socket allocates memory for its user that is not charged to
the user's memory cgroup:

- PACKET_RX_RING and PACKET_TX_RING: the ring blocks themselves
  (alloc_one_pg_vec_page(), both the page allocation and the vmalloc
  fallback), the block array (alloc_pg_vec()), the deferred-free work
  of a TX ring, and the rx_owner_map bitmap of a TPACKET_V1/V2 RX ring.
  The size comes from the tpacket_req passed to setsockopt() and has
  no limit other than available memory.
- PACKET_FANOUT: the group created by fanout_add(), about 1 MB per
  group with max_num_members = 65536 (a 512 KB array, rounded up to an
  order-8 allocation) since commit 9c661b0b8544 ("net/packet: make
  packet_fanout.arr size configurable up to 64K"), and the per-socket
  rollover state.
- PACKET_ADD_MEMBERSHIP: one struct packet_mclist per distinct entry
  (packet_mc_add()), with no limit on the number of entries.
- socket(): the per-CPU TX ring pending counter
  (packet_alloc_pending()).

A process with CAP_NET_RAW, which an unprivileged user has in its own
user and network namespace, can therefore pin kernel memory far beyond
the memory.max of its cgroup. With memory.max set to 16M, a test
running as uid 1000 took 525804 KB of system memory with 64 sockets
each mapping an 8 MB TPACKET_V2 RX ring (1 MB blocks) while
memory.current grew by 892 KB; 264640 KB with 256 sockets each
creating a fanout group with max_num_members = 65536 (memory.current
+512 KB); and 46664 KB with 100 sockets holding 2000 PACKET_MR_PROMISC
entries each on lo (memory.current +256 KB).

Allocate all of these with GFP_KERNEL_ACCOUNT, as other allocations a
user can make on demand in the networking stack already do, for
example the AF_XDP rings since commit b0057c68df71 ("xsk: account
ring allocations to memcg"). vzalloc() takes no gfp mask, so the
vmalloc fallback becomes __vmalloc() with __GFP_ZERO. skbs are bounded by
sk_rcvbuf and sk_sndbuf and are left as they are, as is the per-packet
zerocopy state in tpacket_snd(), which lives only as long as its skb.
struct packet_sock itself comes from sk_alloc(), and the
netdev_hw_addr entries that PACKET_MR_MULTICAST and PACKET_MR_UNICAST
add through dev_mc_add() and dev_uc_add() live in net/core; neither
is changed here.

With the change each of the three tests in the 16M cgroup is stopped
by the cgroup's OOM killer. With a higher memory.max the rings charge
525436 KB for 524832 KB of system memory used (1G), the fanout groups
262656 KB for 265128 KB (1G), and the membership entries 26880 KB
(1G). These figures are from a KASAN kernel, which inflates the small
objects; without KASAN the 200000 membership entries are 20480 KB
charged for 26412 KB used.

The missing charges were found by code inspection of net/packet/ with
the help of an LLM and then triggered with a small test program that
creates the sockets, rings, groups and entries and reads
memory.current; the numbers above are from that program. Tested in a
QEMU/KVM guest on this tree (x86_64_defconfig plus kvm_guest.config,
KASAN, MEMCG, PACKET), running the test as uid 1000 in a cgroup v2
memory cgroup. tools/testing/selftests/net/psock_fanout, psock_tpacket
and psock_snd.sh pass before and after.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude Code
Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
---
v2: cover every user-triggered allocation in net/packet in one patch, as
Willem suggested on v1, and resend with git send-email; the v1 mail had
tabs replaced and lines wrapped by the mail client. v1 changed only the
fanout group allocation.
v1: https://lore.kernel.org/netdev/CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com/

 net/packet/af_packet.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c91..06386db4c8e 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1233,7 +1233,8 @@ static int packet_alloc_pending(struct packet_sock *po)
 {
 	po->rx_ring.pending_refcnt = NULL;
 
-	po->tx_ring.pending_refcnt = alloc_percpu(unsigned int);
+	po->tx_ring.pending_refcnt = alloc_percpu_gfp(unsigned int,
+						      GFP_KERNEL_ACCOUNT);
 	if (unlikely(po->tx_ring.pending_refcnt == NULL))
 		return -ENOBUFS;
 
@@ -1735,7 +1736,7 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 	if (type == PACKET_FANOUT_ROLLOVER ||
 	    (type_flags & PACKET_FANOUT_FLAG_ROLLOVER)) {
 		err = -ENOMEM;
-		rollover = kzalloc_obj(*rollover);
+		rollover = kzalloc_obj(*rollover, GFP_KERNEL_ACCOUNT);
 		if (!rollover)
 			goto out;
 		atomic_long_set(&rollover->num, 0);
@@ -1778,7 +1779,8 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 			/* legacy PACKET_FANOUT_MAX */
 			args->max_num_members = 256;
 		err = -ENOMEM;
-		match = kvzalloc_flex(*match, arr, args->max_num_members);
+		match = kvzalloc_flex(*match, arr, args->max_num_members,
+				      GFP_KERNEL_ACCOUNT);
 		if (!match)
 			goto out;
 		write_pnet(&match->net, sock_net(sk));
@@ -3773,7 +3775,7 @@ static int packet_mc_add(struct sock *sk, struct packet_mreq_max *mreq)
 		goto done;
 
 	err = -ENOBUFS;
-	i = kmalloc_obj(*i);
+	i = kmalloc_obj(*i, GFP_KERNEL_ACCOUNT);
 	if (i == NULL)
 		goto done;
 
@@ -4494,7 +4496,7 @@ static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
 static char *alloc_one_pg_vec_page(unsigned long order)
 {
 	char *buffer;
-	gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
+	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_COMP |
 			  __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
 
 	buffer = (char *) __get_free_pages(gfp_flags, order);
@@ -4502,7 +4504,8 @@ static char *alloc_one_pg_vec_page(unsigned long order)
 		return buffer;
 
 	/* __get_free_pages failed, fall back to vmalloc */
-	buffer = vzalloc(array_size((1 << order), PAGE_SIZE));
+	buffer = __vmalloc(array_size((1 << order), PAGE_SIZE),
+			   GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (buffer)
 		return buffer;
 
@@ -4523,7 +4526,8 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
 	struct pgv *pg_vec;
 	int i;
 
-	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
+	vec = kzalloc_flex(*vec, pg_vec, block_nr,
+			   GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (unlikely(!vec))
 		return NULL;
 	vec->order = order;
@@ -4532,7 +4536,7 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
 
 	if (tx_ring) {
 		vec->deferred = kzalloc_obj(*vec->deferred,
-					    GFP_KERNEL | __GFP_NOWARN);
+					    GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 		if (!vec->deferred)
 			goto out_free_pgvec;
 		vec->deferred->vec = vec;
@@ -4648,7 +4652,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		default:
 			if (!tx_ring) {
 				rx_owner_map = bitmap_alloc(req->tp_frame_nr,
-					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
+					GFP_KERNEL_ACCOUNT | __GFP_NOWARN | __GFP_ZERO);
 				if (!rx_owner_map)
 					goto out_free_pg_vec;
 			}

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

