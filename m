Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436213;
	b=BSucIVLWYTY9Hxsl8h4vVj7RkSQUlSxG4MhQ6jaIDC+qcgo0mUXSAnvrukVIPQhfSp5Z
	 pPu4QaXic60i9F8BI1T2WvAjXbQSosJ3m5gogJemkHtyBSimR3FlF7RrB6uMNKkBWLdPi
	 X1yLglpsupt6iwm4luJYw57RmYQUqadhNBTqie+gZ9Y/cle0WAJv/Z78SFrVTvyLQWDRN
	 6y44x4l8jkiwoOXR+igse10ScTDTNu30Q77kfxEbcAL2QVsDzyg/5KL0mfBwLh6oTrF3p
	 mgl6q74ps1VHJtx9GXCToe4YfFu7kyUMAkScYEmIU5iDZOw2tIYzZRimvQ2t/kgxLCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ad7gFIQdBQZKzkKCsOE/9mkrFdAk1a3efziNmDQqoYk=;
	b=kwAXTzWzFm4KOgvb/1YqAOSjz9VOXSA9O0IEeM0WX5xZIHemmfQZez7dG4DSzYZmjWkm
	 rBIckIbhstL38vc0xsQDfLXDZsMQN44m4ML9mkUF5wphs2goRYg8n2Kbn4bAILu1nR3iS
	 oeqQdpB+pFFF3N9E1CHl8yIL9vyGihUgb7CsE9jOnKwT1aMHtzqmOmu8ogrfbqqk1aMP2
	 0fZWhbnf3Aaa2+MyvlLf7LKsGiaEigbAZP0uYuLBV6cRRwoSG+r9c1V24z+cwXlRP/FsD
	 zdVUrOHWtGmaxPxizblJbU9AMEogrsEA7ZhP86T73GJtdnOvLPEi1nlbxdpXuvd9iqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDWGI5ul;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E39606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 08:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDWGI5ul
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c45111bebso625686f8f.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793436212; x=1794041012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ad7gFIQdBQZKzkKCsOE/9mkrFdAk1a3efziNmDQqoYk=;
        b=gDWGI5ul7OPLpHwRY/foqogofpQSVG6INHe0USsjKb961EtCT7nDj4a6B3yTS+dW0Z
         /RETt4vAROFvGI3DRN21HTlVMvmp4CIUi7Th+/xnvj8M3r3MEoqMTKPBpe9S+tCaTb73
         n/XlQdOgT9i3vU5S5U98/LhcnIXq9LDWrX5adZUrxam995+tiFurTBecyqeA6abOh8TF
         WdauYPBz6UActVTI59z18M4Th380HWDSyVFx7s9b8J5MYqClAZ/YKR4lrh62lNMJw/yA
         LngZV2B2l3ZSfprlljxsu0nCNCUvo8FYjNm9lwunW1xLJBhPU4m5P63MJD31M5YkIXzU
         5xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793436212; x=1794041012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ad7gFIQdBQZKzkKCsOE/9mkrFdAk1a3efziNmDQqoYk=;
        b=XB+gquUZaaVcmSlzmL0E+5qs/jqFuksSgruII7B3EBTK44vEPDgSuKfgubw/x5Z8Id
         8ZYj+ykPFj5vcCPKbj9y0GIwPtoNTs0urdlCXm1+JjmcbxoBtK8FCKytttZ+v+I/ljXc
         eiXAMJeTaFYrg3PY9o4smDUI5LYwWAlkM2DL2l/GdPwOpnemoXjkkayP6xEK0x9Fb6f1
         JsBdIDnwqoOpuGdHLbq/LjsXhO8qsPjGpr5pONAhtba1ABaYWknJLxrDon7rQYTXb+GJ
         xahJS6RIPluzzGFXR7u2orsgeIEIbQip413oZ/MhfO0bUapubyb+4lgmmFoMVgXXK6P4
         PPdw==
X-Forwarded-Encrypted: i=1; AKwUvByh76rPkaV+wbjbtrejqNBDyAttP4Udi+iGFGGCJi+lHkptesuHgQn/f15e+0hKxkU33rabom0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKD8O5toRM33+j7k8lgtARP5rg6eAdJLOgt3ZnfbgTZGnuW98Ql
	dG8acQddQykB2pNOdMXJRFh3UV59F4ohZApCWTCJficttJ8wl/zy3qP1
X-Gm-Gg: AYBFou0NhuuwLGFCidfydRUMKXEX5Ku8Nf6mRiZsbs3PMHetUc0MRE6c5HE5kfXwQaR
	hsBhgueKodvQDCDFBT+dRJJJHaNKwO3ZfzElPAN68BcM/hhSkeOIZyRMtDnTynFjxq4ZayAVI71
	xLNBFqM5d6YC3wg54cyUEHf++LwnPTYowg0tmEIC0VLqum440e6hWqhz3K11Htoa9W0TANtK/xI
	DE7MMkzd47Lp5G5akNUwyk/J3gLAGMnCrJnMDDlVYVvxRoSKw5DI7hIMJidDX8twqYo+UCKRCsW
	wNPB5y6zFeD9VbrEkxUM13hmam+qyKrOc7j9du5txnJuFftY2kQOEMtULwH20imoXr7x+3mwk+g
	tgQ/5pQWtpje+pitr5C0OsZ7MDwnyjKY89k07eJZDpcKGpXuF0jLLnOaNeDjTMflZ62SDbtFDhW
	cqYCA31WQ2FZQGoK2FzAaguI6O6Q+ZxRZKBzlu8R41+vhhuVfh1+JkNvlDcsp/vveuaPfUVcGv4
	Rk84byVX4ibM5lpWPCTZejEY8QLQAXGh4IgfWP0LSUn3T8IANbDygu1msZBem8sKR3BqKJT5MMv
	kzQQKRnXkM+hDT007IWjjetgjimgHwepeVJMYc3yIDVAz1wqp/bFUmGzVQ6WOrwvonV9SEJ6EJR
	OSVlCScc=
X-Received: by 2002:a5d:5e01:0:b0:48e:296a:27f7 with SMTP id ffacd0b85a97d-48e6e4fae29mr10390799f8f.24.1793436211428;
        Sat, 31 Oct 2026 01:43:31 -0700 (PDT)
Received: from pop-os.. ([51.36.40.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d5dfsm8772221f8f.3.2026.10.31.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:43:30 -0700 (PDT)
From: Ahmad AG <ahmadag1001@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org,
	Ahmad AG <ahmadag1001@gmail.com>
Subject: [PATCH net v3] net/packet: account user-triggered allocations to memcg
Date: Sat, 31 Oct 2026 11:43:16 +0300
Message-ID: <20261031084316.387533-1-ahmadag1001@gmail.com>
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
  fallback), the block array (alloc_pg_vec()), and the rx_owner_map
  bitmap of a TPACKET_V1/V2 RX ring. The size comes from the
  tpacket_req passed to setsockopt() and has no limit other than
  available memory.
- PACKET_FANOUT: the group created by fanout_add(), about 1 MB per
  group with max_num_members = 65536 (a 512 KB array, rounded up to an
  order-8 allocation) since commit 9c661b0b8544 ("net/packet: make
  packet_fanout.arr size configurable up to 64K").
- PACKET_ADD_MEMBERSHIP: one struct packet_mclist per distinct entry
  (packet_mc_add()), with no limit on the number of entries.

A process with CAP_NET_RAW, which an unprivileged user has in its own
user and network namespace, can therefore pin kernel memory far beyond
the memory.max of its cgroup. With memory.max set to 16M, a test
running as uid 1000 took 525508 KB of system memory with 64 sockets
each mapping an 8 MB TPACKET_V2 RX ring (1 MB blocks) while
memory.current grew by 1024 KB; 264832 KB with 256 sockets each
creating a fanout group with max_num_members = 65536 (memory.current
+512 KB); and 46000 KB with 100 sockets holding 2000 PACKET_MR_PROMISC
entries each on lo (memory.current +124 KB).

Allocate these with GFP_KERNEL_ACCOUNT, as other allocations a user
can make on demand in the networking stack already do, for example the
AF_XDP rings since commit b0057c68df71 ("xsk: account ring allocations
to memcg"). vzalloc() takes no gfp mask, so the vmalloc fallback becomes
__vmalloc() with __GFP_ZERO; it also takes __GFP_NOWARN, like the page
allocation before it and the pg_vec allocation, so that a ring that does
not fit, in the cgroup or in the system, fails with -ENOMEM and no
allocation warning. These
allocations scale with sizes or counts the user chooses. The small
fixed-size ones, the rollover state, the per-CPU TX pending counter and
the deferred-free work of a TX ring, are left unaccounted: there is at
most one of each per socket or ring, so the socket bounds them. skbs
are bounded by sk_rcvbuf and sk_sndbuf and are left as they are, as is
the per-packet zerocopy state in tpacket_snd(), which lives only as
long as its skb. struct packet_sock itself comes from sk_alloc(), and
the netdev_hw_addr entries that PACKET_MR_MULTICAST and
PACKET_MR_UNICAST add through dev_mc_add() and dev_uc_add() live in
net/core; neither is changed here.

With the change each of the three tests in the 16M cgroup is stopped
by the cgroup's OOM killer. With memory.max at 1G the rings charge
525436 KB for 525536 KB of system memory used, the fanout groups
262400 KB for 264608 KB, and the membership entries 26880 KB for 200000
entries. These figures are from a KASAN kernel, which inflates the small
objects. With 8 MB blocks, which always take the vmalloc fallback, a
32 MB ring charges 32636 KB for 32768 KB used (1G). In the 16M cgroup
the cgroup's OOM killer then acts; with oom_score_adj -1000, so that
nothing can be killed, ring setup fails with -ENOMEM and no vmalloc
allocation warning. A workload whose memory.max leaves no room for its
rings now sees ring setup fail or the cgroup's OOM killer act.

The missing charges were found by code inspection of net/packet/ with
the help of an LLM and then triggered with a small test program that
creates the sockets, rings, groups and entries and reads
memory.current; the numbers above are from that program. Tested in a
QEMU/KVM guest on the net tree (x86_64_defconfig plus kvm_guest.config,
KASAN, MEMCG, PACKET), running the test as uid 1000 in a cgroup v2
memory cgroup. tools/testing/selftests/net/psock_fanout, psock_tpacket
and psock_snd.sh pass before and after.

Reproducer, as uid 1000 in a cgroup v2 memory cgroup with memory.max
16M: unshare(CLONE_NEWUSER | CLONE_NEWNET), then 64 times:
socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)); PACKET_VERSION
TPACKET_V2; PACKET_RX_RING with tp_block_size 1 MB, tp_block_nr 8,
tp_frame_size 2048, tp_frame_nr 4096; mmap the 8 MB ring and write
one byte per block. Compare the growth of memory.current with the
drop in MemFree. The other two tests replace the ring with one
PACKET_FANOUT group per socket (max_num_members 65536, 256 sockets)
or 2000 PACKET_MR_PROMISC entries on lo per socket (100 sockets).

The ring pages have never been charged to memcg, and the membership
entries and block array not since commit a9bb7e620efd ("memcg: only
account kmem allocations marked as __GFP_ACCOUNT"); neither has a
culprit commit. The Fixes tag covers only the fanout array growth.

Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size configurable up to 64K")
Cc: <stable+noautosel@kernel.org> # changes memcg charging of existing packet rings; not stable material
Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
---
Tool use: an LLM coding assistant (Claude Code) found the missing
charges by code inspection, drafted the patch, the test program and this
message, and ran the tests in the QEMU guest; I reviewed every hunk, the
results and this message before sending.

v3:
  - target net as Willem suggested; stable+noautosel instead of a stable Cc
  - Fixes: 9c661b0b8544 instead of 1da177e4c3f4
  - leave the fixed-size per-socket allocations (rollover, per-CPU pending
    counter, deferred TX ring free) unaccounted
  - add __GFP_NOWARN to the vmalloc fallback like the pg_vec allocation
  - give the reproduction steps and reword the Fixes rationale
v2: https://lore.kernel.org/netdev/20261030100504.23498-1-ahmadag1001@gmail.com/
  - cover all user-triggered allocations in one patch; sent with git send-email
v1: https://lore.kernel.org/netdev/CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com/

 net/packet/af_packet.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index cf6429f0947..3cec23a505b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1778,7 +1778,8 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 			/* legacy PACKET_FANOUT_MAX */
 			args->max_num_members = 256;
 		err = -ENOMEM;
-		match = kvzalloc_flex(*match, arr, args->max_num_members);
+		match = kvzalloc_flex(*match, arr, args->max_num_members,
+				      GFP_KERNEL_ACCOUNT);
 		if (!match)
 			goto out;
 		write_pnet(&match->net, sock_net(sk));
@@ -3773,7 +3774,7 @@ static int packet_mc_add(struct sock *sk, struct packet_mreq_max *mreq)
 		goto done;
 
 	err = -ENOBUFS;
-	i = kmalloc_obj(*i);
+	i = kmalloc_obj(*i, GFP_KERNEL_ACCOUNT);
 	if (i == NULL)
 		goto done;
 
@@ -4494,7 +4495,7 @@ static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
 static char *alloc_one_pg_vec_page(unsigned long order)
 {
 	char *buffer;
-	gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
+	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_COMP |
 			  __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
 
 	buffer = (char *) __get_free_pages(gfp_flags, order);
@@ -4502,7 +4503,8 @@ static char *alloc_one_pg_vec_page(unsigned long order)
 		return buffer;
 
 	/* __get_free_pages failed, fall back to vmalloc */
-	buffer = vzalloc(array_size((1 << order), PAGE_SIZE));
+	buffer = __vmalloc(array_size((1 << order), PAGE_SIZE),
+			   GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN);
 	if (buffer)
 		return buffer;
 
@@ -4523,7 +4525,8 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
 	struct pgv *pg_vec;
 	int i;
 
-	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
+	vec = kzalloc_flex(*vec, pg_vec, block_nr,
+			   GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (unlikely(!vec))
 		return NULL;
 	vec->order = order;
@@ -4648,7 +4651,8 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		default:
 			if (!tx_ring) {
 				rx_owner_map = bitmap_alloc(req->tp_frame_nr,
-					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
+					GFP_KERNEL_ACCOUNT | __GFP_NOWARN |
+					__GFP_ZERO);
 				if (!rx_owner_map)
 					goto out_free_pg_vec;
 			}

base-commit: 7b29287b182fc50518e9e65c41f86d24a05b7205
-- 
2.43.0

