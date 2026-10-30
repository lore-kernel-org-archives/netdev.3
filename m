Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370088;
	b=DeifaPFrCdt07/uQwjVT48TqcrMfT6F1baJEFDpt0fVnaBwiGgryX7pKi8iL6f/TIifq
	 L11hpz2CGbk5hLBI0F/iDwXWw2/4rrey0h95t/HkDp9sa2IoPj5VQKAQTrlcIT+pmoOGG
	 YcgjUlCMrjbfyM3T1HJDbW0L5i7qiBGzPI1Ep2XBn9U0C8VZ1ZahbJH8AxqRWHTkbYu8o
	 QEtkEG+n2yAt+UmHBHvWn7ykGmCsxUEBqBN0DrQK3pEaeQzskASzb6ONk60ok5L0PwvLW
	 yaURhUKbLAMLf9vQ4ZS0f9u8WSqNU/Su6Isw4vOn2uUzki/gp0wI9ucD5tgecBjoYBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=E00FdPkngk3Z4+CY6OL2kt07v6G7rAIhm8TLVIKRgo4=;
	b=rL902U+KkuYA2vfgW69OFY+IgvffwltyxhqIAHZujqXeBAkVxFLeyeu2J/mtgPawelFb
	 eruUC466fSYjQEbnYDWvwacmUhAmljNIGsMrW49Y6TqUXHxGUgFIQhtY0apIbuiT5p7TW
	 QVWniAxaCUPjh3UWQAizALPUEEM09v78nhKs3lMYdGfuAFoP8KV19rz7hn4TXOpLFOCW4
	 W8P9JuTgHHUhd2fsMxqfraMHSYzUknIewD9DjJC+U9qR8+ILs6tj8i9uvt4AE2nQFA4VV
	 qyE4HRSlfLajALZ/x0rB6s4QLS5PBl63CYMD+KO9Dv+PBTq9JLwp3JCfr6C4grxueVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWLQd2fq;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656F606A329
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1656F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWLQd2fq
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eafa528803so234982e0c.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370087; x=1793974887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E00FdPkngk3Z4+CY6OL2kt07v6G7rAIhm8TLVIKRgo4=;
        b=vWLQd2fqqRdj0tJghjKvE8ElecP40p5bn7552qu6aqe3YMlCAVn/KQL4XPskM021cn
         j71FtJbaxZXPll7uv0rxSoHi4SJcSwXROeJf19uEEMh55nexfnBjHGjfAM0Vsi6rz9o1
         38hfHchtdv/iuFst+xG0kmJTr9C1DGxnfgAzZbY0w20tkZ/QCbk/RIsbK8M7wGq9B8g+
         neOamq0Uqnu/OC4j6ymPmnn4dNT4AKNzg09qAgBJJZRnoZJk7WF5Q1iRap1KCdfJeYvt
         29bfhb3+W9YflALjjHEfXQyiiJl3VvgXS9ZGoGLumWdybj+JGBxoVyecBJfE5c2a4NKZ
         WAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370087; x=1793974887;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E00FdPkngk3Z4+CY6OL2kt07v6G7rAIhm8TLVIKRgo4=;
        b=P19m9ILLqcNY6M4mXFBfrdPE/LQw0nEqPq5m6UdA/Q0/B4xEDqDbE7RoDXpD7wOSqc
         0UksLPSaiQwMowkDuR08WlN4p6Zaa/FupmMcNELgfPm3aYBMydKU/MeXNOPN3FAMgdUY
         6ponysQcqRdxrBEbe6KoVu+RNCZ+SRF9P13fBrODHBKmtvyjYSPq371AlDK6ZQHpWTP9
         Qdyhf9P1ifW70o0jxvV7ssfhWsLpJiBd06sxp2XBPkzZubLViInnrHPpohuwp6zFUhkg
         VlJrE9cvEEhw4iabVuAf/QoFZTANrpY3rZ9l2JaHB0pCuM4m6biSPhfXTF0svQNZN0wj
         sQTg==
X-Forwarded-Encrypted: i=1; AKwUvBxKKp5Waeo7RjHGIjeSRbwOGWrvCYxaovSAQ8p2R94+Wb2vEqE47BshK17S3c9Pi/R7wokiPlE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUfMmTiJYk8GthjMdsyMlplQ/hF7AbaFS8UwxE/K1w0+rv0j1L
	NkEgMP4JMPv3h+Xss2eVqgyVKNkVp7/wWj1xvJEvD+TfPP4+KmJCk9eF
X-Gm-Gg: AYBFou0g1ytQFs83snibydWmlO4MjoRrfrL+SoosN+t8yFsY1Mv8GahxBf+HWpQSPwA
	B27zXG20SJ4JQvoDEyFPXQ66uPyg0GD45MMDWxM+ErOBRdhU48QFKtscAZwwOoSCD+bDU5dxpnC
	lO5IXOQJTTtpYy0ug3dwTzgffSEkZisqfLTm7YuQ5eq5DUv+mtzrLoGZDff9tvioo82gcOOtHJ8
	bB1igY210RuDxAcgOW1mie9oC6WdbJHNGyI4LkBNe3qJIcF4D1jI7Vowx/2E4BdFlkt4H32etJK
	vYSzvLe91FPYheSmUKp4EpZDqNfgrvF18j5NMUAGWAFDYBKFIovCd1PIT/YV0PyYJ9dZdw9artO
	Z49ghAm4gcBL5spXXbGcrUBKSNicvSMJ2p16bTqPQ5O/utfRrBczu4/zZt9VUlh30FjInhJLxqr
	9auDdyz0wotGo0MxHXn87F5Qifke7gTFfJUBiqIYRrV1T8vcY0OKJuDKs7808luRBdX2/nVrUOi
	pU3MZO3w3jHDMJsfAm0fIOunliPKQACtjrvY4aXORXcIEqzzHTTFlJ7DF3rTJYUqcc3Umg2+g5o
	R9d9G2pdR71UAX7ZgfV10zwxqjfluFWWgIM0z3832EXnAtzQdgwS3PSVay+pkcaGE0KtGKSama2
	3qOxcaul3s0neyO4UnC4MIAlnv4fhtOvOuXEmidsjYmTp2PLqUh4rQrg/867hpYpwEVUs
X-Received: by 2002:a05:6122:512:b0:5da:9b81:1aa4 with SMTP id 71dfb90a1353d-5ec6870c946mr1146359e0c.5.1793370086742;
        Fri, 30 Oct 2026 07:21:26 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c99e3csm2476107e0c.15.2026.10.30.07.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:21:26 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:21:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ahmad AG <ahmadag1001@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Ahmad AG <ahmadag1001@gmail.com>
Message-ID: <willemdebruijn.kernel.2e53c121ad9ea@gmail.com>
In-Reply-To: <20261030100504.23498-1-ahmadag1001@gmail.com>
References: <20261030100504.23498-1-ahmadag1001@gmail.com>
Subject: Re: [PATCH net v2] net/packet: account user-triggered allocations to
 memcg
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ahmad AG wrote:
> A packet socket allocates memory for its user that is not charged to
> the user's memory cgroup:
> 
> - PACKET_RX_RING and PACKET_TX_RING: the ring blocks themselves
>   (alloc_one_pg_vec_page(), both the page allocation and the vmalloc
>   fallback), the block array (alloc_pg_vec()), the deferred-free work
>   of a TX ring, and the rx_owner_map bitmap of a TPACKET_V1/V2 RX ring.
>   The size comes from the tpacket_req passed to setsockopt() and has
>   no limit other than available memory.
> - PACKET_FANOUT: the group created by fanout_add(), about 1 MB per
>   group with max_num_members = 65536 (a 512 KB array, rounded up to an
>   order-8 allocation) since commit 9c661b0b8544 ("net/packet: make
>   packet_fanout.arr size configurable up to 64K"), and the per-socket
>   rollover state.
> - PACKET_ADD_MEMBERSHIP: one struct packet_mclist per distinct entry
>   (packet_mc_add()), with no limit on the number of entries.
> - socket(): the per-CPU TX ring pending counter
>   (packet_alloc_pending()).
> 
> A process with CAP_NET_RAW, which an unprivileged user has in its own
> user and network namespace, can therefore pin kernel memory far beyond
> the memory.max of its cgroup. With memory.max set to 16M, a test
> running as uid 1000 took 525804 KB of system memory with 64 sockets
> each mapping an 8 MB TPACKET_V2 RX ring (1 MB blocks) while
> memory.current grew by 892 KB; 264640 KB with 256 sockets each
> creating a fanout group with max_num_members = 65536 (memory.current
> +512 KB); and 46664 KB with 100 sockets holding 2000 PACKET_MR_PROMISC
> entries each on lo (memory.current +256 KB).
> 
> Allocate all of these with GFP_KERNEL_ACCOUNT, as other allocations a
> user can make on demand in the networking stack already do, for
> example the AF_XDP rings since commit b0057c68df71 ("xsk: account
> ring allocations to memcg"). vzalloc() takes no gfp mask, so the
> vmalloc fallback becomes __vmalloc() with __GFP_ZERO. skbs are bounded by
> sk_rcvbuf and sk_sndbuf and are left as they are, as is the per-packet
> zerocopy state in tpacket_snd(), which lives only as long as its skb.
> struct packet_sock itself comes from sk_alloc(), and the
> netdev_hw_addr entries that PACKET_MR_MULTICAST and PACKET_MR_UNICAST
> add through dev_mc_add() and dev_uc_add() live in net/core; neither
> is changed here.
> 
> With the change each of the three tests in the 16M cgroup is stopped
> by the cgroup's OOM killer. With a higher memory.max the rings charge
> 525436 KB for 524832 KB of system memory used (1G), the fanout groups
> 262656 KB for 265128 KB (1G), and the membership entries 26880 KB
> (1G). These figures are from a KASAN kernel, which inflates the small
> objects; without KASAN the 200000 membership entries are 20480 KB
> charged for 26412 KB used.
> 
> The missing charges were found by code inspection of net/packet/ with
> the help of an LLM and then triggered with a small test program that
> creates the sockets, rings, groups and entries and reads
> memory.current; the numbers above are from that program. Tested in a
> QEMU/KVM guest on this tree (x86_64_defconfig plus kvm_guest.config,
> KASAN, MEMCG, PACKET), running the test as uid 1000 in a cgroup v2
> memory cgroup. tools/testing/selftests/net/psock_fanout, psock_tpacket
> and psock_snd.sh pass before and after.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This predates the introduction of memcg accounting and indeed
much of the code that is being instrumented.

I also don't think this is stable material.

Especially on the actual ring buffers: retroactively enabling
this may break existing users.

Consider net-next. Else, net still needs a Fixes tag. Review how
important each of the conversions is, keep the important ones, find
the oldest one and use that as tag.

> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code
> Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
> ---
> v2: cover every user-triggered allocation in net/packet in one patch, as
> Willem suggested on v1, and resend with git send-email; the v1 mail had
> tabs replaced and lines wrapped by the mail client. v1 changed only the
> fanout group allocation.
> v1: https://lore.kernel.org/netdev/CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com/
> 
>  net/packet/af_packet.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 823e0911c91..06386db4c8e 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1233,7 +1233,8 @@ static int packet_alloc_pending(struct packet_sock *po)
>  {
>  	po->rx_ring.pending_refcnt = NULL;
>  
> -	po->tx_ring.pending_refcnt = alloc_percpu(unsigned int);
> +	po->tx_ring.pending_refcnt = alloc_percpu_gfp(unsigned int,
> +						      GFP_KERNEL_ACCOUNT);
>  	if (unlikely(po->tx_ring.pending_refcnt == NULL))
>  		return -ENOBUFS;
>  
> @@ -1735,7 +1736,7 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>  	if (type == PACKET_FANOUT_ROLLOVER ||
>  	    (type_flags & PACKET_FANOUT_FLAG_ROLLOVER)) {
>  		err = -ENOMEM;
> -		rollover = kzalloc_obj(*rollover);
> +		rollover = kzalloc_obj(*rollover, GFP_KERNEL_ACCOUNT);

Is it worth accounting even such small ones?

>  		if (!rollover)
>  			goto out;
>  		atomic_long_set(&rollover->num, 0);
> @@ -1778,7 +1779,8 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>  			/* legacy PACKET_FANOUT_MAX */
>  			args->max_num_members = 256;
>  		err = -ENOMEM;
> -		match = kvzalloc_flex(*match, arr, args->max_num_members);
> +		match = kvzalloc_flex(*match, arr, args->max_num_members,
> +				      GFP_KERNEL_ACCOUNT);
>  		if (!match)
>  			goto out;
>  		write_pnet(&match->net, sock_net(sk));
> @@ -3773,7 +3775,7 @@ static int packet_mc_add(struct sock *sk, struct packet_mreq_max *mreq)
>  		goto done;
>  
>  	err = -ENOBUFS;
> -	i = kmalloc_obj(*i);
> +	i = kmalloc_obj(*i, GFP_KERNEL_ACCOUNT);
>  	if (i == NULL)
>  		goto done;
>  
> @@ -4494,7 +4496,7 @@ static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
>  static char *alloc_one_pg_vec_page(unsigned long order)
>  {
>  	char *buffer;
> -	gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
> +	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_COMP |
>  			  __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>  
>  	buffer = (char *) __get_free_pages(gfp_flags, order);
> @@ -4502,7 +4504,8 @@ static char *alloc_one_pg_vec_page(unsigned long order)
>  		return buffer;
>  
>  	/* __get_free_pages failed, fall back to vmalloc */
> -	buffer = vzalloc(array_size((1 << order), PAGE_SIZE));
> +	buffer = __vmalloc(array_size((1 << order), PAGE_SIZE),
> +			   GFP_KERNEL_ACCOUNT | __GFP_ZERO);

Consider adding __GFP_NOWARN here too, similar to the pg_vecs, to avoid
excessive warning when enabling memcg accounting.

>  	if (buffer)
>  		return buffer;
>  
> @@ -4523,7 +4526,8 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
>  	struct pgv *pg_vec;
>  	int i;
>  
> -	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
> +	vec = kzalloc_flex(*vec, pg_vec, block_nr,
> +			   GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>  	if (unlikely(!vec))
>  		return NULL;
>  	vec->order = order;
> @@ -4532,7 +4536,7 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
>  
>  	if (tx_ring) {
>  		vec->deferred = kzalloc_obj(*vec->deferred,
> -					    GFP_KERNEL | __GFP_NOWARN);
> +					    GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>  		if (!vec->deferred)
>  			goto out_free_pgvec;
>  		vec->deferred->vec = vec;
> @@ -4648,7 +4652,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
>  		default:
>  			if (!tx_ring) {
>  				rx_owner_map = bitmap_alloc(req->tp_frame_nr,
> -					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
> +					GFP_KERNEL_ACCOUNT | __GFP_NOWARN | __GFP_ZERO);
>  				if (!rx_owner_map)
>  					goto out_free_pg_vec;
>  			}
> 
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> -- 
> 2.43.0
> 


