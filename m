Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793526618;
	b=mb8pL0pfh8ejxI4NrXJL1PDemZbZwbtmwmTlbYLCSuls71c00HV8kCueYv6XGeqUWpE8
	 60A+Nkg3wm+m8RYAmGqv2TF5OlW5gbjD62nxi2CdNYK4FZYlJjzDjXBq9TWC8+oEXK9wz
	 araiLBL9j0xe3a0/9R48SfXqPFDOXr0p3JvmG4batK25+0F7ur6zUHu2eWP1qfjwrAFOI
	 plQojqcPIaN2PLuqdcZ+KpTTASyJG9/XkBnNj7oUuebpooEGg6e6mQ+DTmIcGW/CZ3E9G
	 i7LM9h1o8Y0cgNJGN+6E75wd6486ArQ2saw8eC9ZGsAMUD7qO4dKmm8pvw//xc9uClQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793526618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VRwFzuB7fWGW1t5e+uWnFaSjsE+gErCYZsaIW9DBl+I=;
	b=gdu8Z7jgMYUqSF3/hdGTwdh49WSFWFWg0oxRXIzksMvFzRT4Xoh8jS4Z4B/gdd2IdnpK
	 4xeHEI+3jX9H0ZJLRIEjmPy+C2IC2LTpaDBjfnyXhbZhgdxSF+w648yI4CnRtd8H8+jBp
	 aRP5sDG/K47xx9SEYuuvsqBuqEoQmpSMJRxiegK8FQqKXVoJU+krQVE9gYIDwpb6qobgj
	 IrQusmPFGVE7KKCyhX1BsLTwcDyouTUOBi9cLJVJb8u+lrUAS5+YJWfmAFY8nXJvAYiKt
	 sPNUUDPWety7wMVvzjPYMbOSgWZOw9QVwSV9Ar6udl8e8/KOxBW+hjAay6SyogSgbxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Uao/RAIV";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C5606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 09:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D29C5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uao/RAIV
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so12810865e9.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 01:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793526616; x=1794131416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VRwFzuB7fWGW1t5e+uWnFaSjsE+gErCYZsaIW9DBl+I=;
        b=Uao/RAIVw+DXGrjH+o1O7lghiXhrpgVAzEvbtfsA4T7ocqAaaYcxE0JQ4Foe0rrbMq
         uOy+go/yoU8aB8xi4m5iMMLm1haKd3vfwEauZN91Ibn0sfYXanowUXVEkgvBC2DI/KK7
         49c3YNx91K5U+zOTAHQJ2dl16+QVQcJRHwYg/p9hHTiRwMsUvgBq+q7W/pZeRlYCBAgv
         +84E/qhqg4WXulFKjLBnqQ4GOdVDGeqqm12ceSZaWbxA8gK4/rq1fKB1NpXuq3ac9AFs
         5PENjPnMKZkKnGM3WXJs+jNeFnzPFoXlLB71wnZIkdh8t3ge3bi+YGvb6HK6VEG3bTSx
         Zmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793526616; x=1794131416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VRwFzuB7fWGW1t5e+uWnFaSjsE+gErCYZsaIW9DBl+I=;
        b=XJWr8YHkt2Iw5qSYozYLgJnaj95ga6gFnp47F0ZRhHWYrT4TKuff1GGfPz1Xrn5GKa
         Y/RHjE8kZAHZgRQqe3UEPmUweBh9qpGLM3Qa6+yogYPTxl67lxyQTCXcmhZVeMGD6CDF
         SVrkeM1mQQ6oyWWWGQ3XbF6o3adhOnlcrdwKvxmaxGKa2ArzEG/kC4YR3QFk7Z/pLQ/V
         qu8e+GN9K7Fz9UI/XP8FeuOI+5Jk1yErgJGHHJ5JqLCexiQLUCg/t6OFzFRKOCOzpR28
         LxVMuG3m86cIRqGTPCYZ9PzL0wwLZAUf9m3WD8FD2TjCIlVO/qht8pV/r6IBwtWGcpMZ
         fj1Q==
X-Forwarded-Encrypted: i=1; AKwUvByMMyUxoJnYGmKJij6qM2hahxYq756i3j/fM5UNAnifSVMXCXyq/OMhCJL7SIP7IHdUkTFdO2A=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+PbdTrFBRoes5geJ3y3u5Xb+U+W2khZQYR1++rw6LS50A4vpM
	MAhx+ILsiwCqW1sJi7A3SxmklsL8CTxYmQLuRmkutImBJmZPjXl+5+Sh
X-Gm-Gg: AYBFou2rvHHKovMuGzTY2TU4cMTd78+82W4o3JlaKfOLVkUs7fQ1ZaixrODSLU8VRUT
	iUP5a+KNlzkMVL/ZA5XkuqVDLaCDi5dCcDslrXRRQyQwrLBGjrA6RFrvgTLSCPGe3D4M6x7vhCm
	NWp2vKxUiYycQR63wM0giK7b7O6e6U7k9uziLFogG1Avqcv/kGuErX3P2zfqMVaUbA1WXVSfYUy
	+XMLkAzmuPEWK/f/tFtKG94vkY52SLz5UUy4XAa+0phu95Itx2x9zhQ13MVRUzU5zEfUG3ge2+Z
	g3/OZCyKgKJp7tHckXju61kBKsn7UmlrUD3b8HlEUCNwX0t5HMto8ZvFn9E1tDlSVEEGBeIZXXT
	NqnedAjZxLEdB9O5XEtujL5tHbkupsIk/yAobfFOuy5ja6GY6wDuCKRKoEjy171TcQzv1i8kuc1
	yQoTy/MSCJrwqtldjBO9zQMGw1S9lR+v5M2pkmUy4jLeuB0URJwk2isdKbihYp+ecbkas6FZ15w
	81HpUaawFodcDxchhZOIbdiV+KUW779kDIrSKKsnbSBp0mPOMhV7+uqwYzfZvCihBxnuvz3N6XY
	leoKlmdmsBMSfj0ZIM/PhnWxvlxzCjt4qRX42SU9ceAuzbudrk3uFHT7KGuqN+zowmFMsOV1x5J
	QFTq55kM=
X-Received: by 2002:a05:600c:37cc:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4ac1980143dmr139263645e9.35.1793526615914;
        Sun, 01 Nov 2026 01:50:15 -0800 (PST)
Received: from pop-os.. ([51.36.40.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa820492cesm285566535e9.13.2026.11.01.01.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:50:15 -0800 (PST)
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
Subject: [PATCH net v4] net/packet: account user-triggered allocations to memcg
Date: Sun,  1 Nov 2026 12:48:47 +0300
Message-ID: <20261101094847.664612-1-ahmadag1001@gmail.com>
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

A packet socket makes allocations whose size or count its user chooses
without charging them to the user's memory cgroup: the blocks and block
array of a PACKET_RX_RING or PACKET_TX_RING ring and the rx_owner_map
of a TPACKET_V1/V2 RX ring, the PACKET_FANOUT group (about 1 MB with
max_num_members = 65536), and one packet_mclist per
PACKET_ADD_MEMBERSHIP entry. CAP_NET_RAW in a user namespace is enough
to pin memory far beyond memory.max this way.

Allocate them with GFP_KERNEL_ACCOUNT, as the AF_XDP rings do since
commit b0057c68df71 ("xsk: account ring allocations to memcg"), and with
__GFP_NOWARN where the size comes from user space, so that a ring or
group that does not fit prints no allocation warning. Fixed-size
per-socket state is left unaccounted.

Reproducer, as uid 1000 in a memory cgroup with memory.max 16M, after
unshare(CLONE_NEWUSER | CLONE_NEWNET): open 64 AF_PACKET sockets, give
each a TPACKET_V2 RX ring of 8 blocks of 1 MB, mmap the rings and touch
every block. MemFree drops by 526052 KB while memory.current grows by
1280 KB. 256 fanout groups with max_num_members = 65536 (265144 KB used,
512 KB charged) and 100 sockets with 2000 PACKET_MR_PROMISC entries each
on lo (45220 KB used, 124 KB charged) behave the same. With this change
all three are stopped by the cgroup's OOM killer. psock_fanout,
psock_tpacket and psock_snd.sh pass before and after. Found by code
inspection with the help of an LLM and reproduced on an unmodified
kernel without error injection; tested in a QEMU guest with KASAN on
net.

The ring pages and rx_owner_map were never charged, the rest not since
commit a9bb7e620efd ("memcg: only account kmem allocations marked as
__GFP_ACCOUNT"). The Fixes commit let the user size the fanout array.

Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size configurable up to 64K")
Cc: <stable+noautosel@kernel.org> # changes memcg charging of existing packet rings; not stable material
Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
---
Tool use: an LLM coding assistant (Claude Code) found the missing
charges by code inspection, drafted the patch, the test program and this
message, and ran the tests in the QEMU guest; I reviewed every hunk, the
results and this message before sending.

v4:
  - trim the commit message
  - add __GFP_NOWARN to the fanout group allocation
  - use __vcalloc() for the vmalloc fallback and bitmap_zalloc() for
    rx_owner_map
v3: https://lore.kernel.org/netdev/20261031084316.387533-1-ahmadag1001@gmail.com/
  - Fixes 9c661b0b8544; stable+noautosel; drop Assisted-by; leave fixed-size
    allocations unaccounted; __GFP_NOWARN on the vmalloc fallback
v2: https://lore.kernel.org/netdev/20261030100504.23498-1-ahmadag1001@gmail.com/
  - cover all user-triggered allocations in one patch
v1: https://lore.kernel.org/netdev/CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com/

 net/packet/af_packet.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index cf6429f0947..ec6ab96c4f8 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1778,7 +1778,8 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 			/* legacy PACKET_FANOUT_MAX */
 			args->max_num_members = 256;
 		err = -ENOMEM;
-		match = kvzalloc_flex(*match, arr, args->max_num_members);
+		match = kvzalloc_flex(*match, arr, args->max_num_members,
+				      GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
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
+	buffer = __vcalloc(1 << order, PAGE_SIZE,
+			   GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
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
@@ -4647,8 +4650,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 			break;
 		default:
 			if (!tx_ring) {
-				rx_owner_map = bitmap_alloc(req->tp_frame_nr,
-					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
+				rx_owner_map =
+					bitmap_zalloc(req->tp_frame_nr,
+						      GFP_KERNEL_ACCOUNT |
+						      __GFP_NOWARN);
 				if (!rx_owner_map)
 					goto out_free_pg_vec;
 			}

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.43.0

