Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793459878;
	b=2jPfJaR6Uqd08V7vTRuOkGtRDPT79lgpYJ7/gs/7Bju9kZSb+i2QcajlM43H9d2WyYSw
	 3L7dx9rL1s8gnWW3vL21BIme/OBb6ksTSnh/3MwtJXfV3MQj2+sPI8pJJMHF9GWbs2PAy
	 eVFTvhf0/Q+4jk9MtQIrLMMwQnFrC+WLYRLuSScBL4rhKwhHa0gURSw6IyUoFfuKWLOvP
	 3yt2xu971C1cEyDWXTrmrIU2AZ8SOKJ/VefZgNQYD56f+xSLbLM48vffDWuwrs6CHG4RS
	 orMTbw5AfOBjw7pPTfgUcuMn4pI+w333tdjDSrHjp6f93katRDaLJWczZEkErIl9Pew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dN72lJ/VYEAZ0crc14RL+WcfO3wLnaLimkA5461AVno=;
	b=naO0MSd6HzhQSripmDPfj6NbN/wTcMsB1Rihbw0Ewv25hyycZQxntN/QvvRSzUQ+mJYC
	 ZAl9pI0W51qdu/019OJ4PLT4VOsWM8adh7l9RYZdok3GwJdguVwpZx6zMB/Gz1HdxvsS4
	 fg0fn6HL0lzY1Xy4M9ViQTLdFAzYsH8a2efqFqOJ2+gPU1+nz8JZfb1hzR2+1RFWb6AHS
	 C7TlkqX65BbkVlycp3VbSeJY29LaFD3zjYryIi9A0oZVvyKTYZnrBkKy79IwOgXjVNWxV
	 xYl4m13/vlqiT2on+CZ7mHQ97NxfsfWOvXgJPL3X4oHJ1XPkQ66o3Nnh34m+eTeZrxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyH20fuy;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DB1606A31F
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 15:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9DB1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyH20fuy
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-77bf892b496so534668137.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793459876; x=1794064676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dN72lJ/VYEAZ0crc14RL+WcfO3wLnaLimkA5461AVno=;
        b=uyH20fuyJrWkxeehR17ywV/R46gVGwq6Be66FbNIfTUj+WmJrjp9wOZVAsN89rGKDG
         hSoN5+J957cQonI4yORUn0OLdIeV7GnvEKXJsO2frsQ3QnfyCSwgHI2urODtPB5NvjNP
         8TSa8EBicESS7EACUcId0UsmjSyoT/uuAv8wZNIATG7AvFGvmkbkihR339fJwka7YNmo
         fK+p6kZ8nIzTJ/+tGYseljESvvfvsCb+1+mr0xO72waKBnslTmI4M/7s4DYYV0fVA9uf
         +Ad4wT4NF+vIDw4xqVXsJSDczWmvRdnaWJgXiwo1aKxoCL9/6EVFbQGlJ8Xn4g5sYPoV
         LLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793459876; x=1794064676;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dN72lJ/VYEAZ0crc14RL+WcfO3wLnaLimkA5461AVno=;
        b=uZXO9Fu6OnsWbSDirSX/BMIvhdLMqpigUMsT/7iKJVqP0qVYqWeIpAOxQDXDjpm2AB
         NRMilb2ayWMq8Ui1lpgLo18G/rh5eWgEq5CjF30h3QKzt8Yk1kBSCm+tJJOFFzTVyvic
         jKDOWMcdZ5Jmy2X3NbFpKvCcosF7ADev0GuSGPsILW0My7W9p87pjk04R1Trn74BupL8
         7ZmHcrdLjlnzcl5CrlywEGf5OBLx2mpFuoDmUQt0GmYA2serPcP6sJXOz7vK7FglAZXw
         7szywLJNbZX3FfnnTT6ssMjihwoiAdyFknpSEDUwoo16QZTE0kk9vMUvDxK5VoWSsDdJ
         Dq7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxMipdh0214Zk1i630y/vuXsr50RJkIjFjNV01myBS/kYmVKbtVBA4CI6zxhX+5/wad+mbkE84=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnedUr6M8wFjQQ1BHVuz1chiM1YEF6HjNPDp0bHFBf70G9a/bZ
	BnRf/QaPFMzNUgtEpDO4ayhhK54Y5eP5+zn/KDcloJXVbdqw1NL1Grml
X-Gm-Gg: AYBFou1BfKtgMED0aV87Il9yiW3bD8Ds4VsyERU8x2VFGJMpEuXFwgqumu2cTEsYaNA
	pvUIWv5imhsba7R0a8KUOukWuk284u7UeBBC2dPlCEILgsSnbbzwyFtPWHGZ0Ebgc1tsCKAPf1i
	PmllF7Ycy9ewS6DfZJl+Fu+C8KZCAGHYSVMcVBhrp7qmVIeZMm1TiFvS7tH2feH6i7N2g7Us09x
	pTgMpw8HK+61H8+OaAg9mAa/RxDx3mTcTRcsICDwlGG3nsRGc7Bd1T5kXLrik9yscdzSMo5cM0n
	ghn4udVLUFtel4juINlFBVyE/H+4jnkPozlYHutUX6c837N3CqyBI9VVHXl1Ds6rsUkHoJo2pQM
	CVKWI1+BbIteF+7Y8KCTNHkdHmaRvICv9oTyipDdzrlvWMyZ55Mi450TvEN68i0/NZ7HXZ9WNsL
	ybMI0dIuIg6fPrpn6kDX1A4vVEMYBc3sHhebqPMkrvdkDpwdsjwrdvarhGhlaOXo2ORZl4lLkI2
	JJggUJD+EJJIQzFQu0TRmIKURYwqATsF9bcS8AycnSx878Oqb7PwyXv7BQWTu3kA+0CcMEevdEv
	WQ0FASTUgVcj8THZnGf00pJAr17kfnNsPF9ov8H/t1KbHfp73NhImDf29HdgUbjN0OJk7qM1lSr
	769MmL/BW25sURHRAUFmwmShlgbfrcyDDWzEdetGPPPNl3rsiKHwv1H+4S/eTT9ji37sb0/yLRw
	qZbGzr7Jvtt7BXzg==
X-Received: by 2002:a05:6102:6058:b0:7c3:91f5:26f1 with SMTP id ada2fe7eead31-7d072bb31f6mr2253019137.6.1793459876557;
        Sat, 31 Oct 2026 08:17:56 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d08f6bef24sm2625869137.0.2026.10.31.08.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:17:55 -0700 (PDT)
Date: Sat, 31 Oct 2026 11:17:55 -0400
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
 stable+noautosel@kernel.org, 
 Ahmad AG <ahmadag1001@gmail.com>
Message-ID: <willemdebruijn.kernel.1a3f3b65222d9@gmail.com>
In-Reply-To: <20261031084316.387533-1-ahmadag1001@gmail.com>
References: <20261031084316.387533-1-ahmadag1001@gmail.com>
Subject: Re: [PATCH net v3] net/packet: account user-triggered allocations to
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
>   fallback), the block array (alloc_pg_vec()), and the rx_owner_map
>   bitmap of a TPACKET_V1/V2 RX ring. The size comes from the
>   tpacket_req passed to setsockopt() and has no limit other than
>   available memory.
> - PACKET_FANOUT: the group created by fanout_add(), about 1 MB per
>   group with max_num_members = 65536 (a 512 KB array, rounded up to an
>   order-8 allocation) since commit 9c661b0b8544 ("net/packet: make
>   packet_fanout.arr size configurable up to 64K").
> - PACKET_ADD_MEMBERSHIP: one struct packet_mclist per distinct entry
>   (packet_mc_add()), with no limit on the number of entries.
> 
> A process with CAP_NET_RAW, which an unprivileged user has in its own
> user and network namespace, can therefore pin kernel memory far beyond
> the memory.max of its cgroup. With memory.max set to 16M, a test
> running as uid 1000 took 525508 KB of system memory with 64 sockets
> each mapping an 8 MB TPACKET_V2 RX ring (1 MB blocks) while
> memory.current grew by 1024 KB; 264832 KB with 256 sockets each
> creating a fanout group with max_num_members = 65536 (memory.current
> +512 KB); and 46000 KB with 100 sockets holding 2000 PACKET_MR_PROMISC
> entries each on lo (memory.current +124 KB).
> 
> Allocate these with GFP_KERNEL_ACCOUNT, as other allocations a user
> can make on demand in the networking stack already do, for example the
> AF_XDP rings since commit b0057c68df71 ("xsk: account ring allocations
> to memcg"). vzalloc() takes no gfp mask, so the vmalloc fallback becomes
> __vmalloc() with __GFP_ZERO; it also takes __GFP_NOWARN, like the page
> allocation before it and the pg_vec allocation, so that a ring that does
> not fit, in the cgroup or in the system, fails with -ENOMEM and no
> allocation warning. These
> allocations scale with sizes or counts the user chooses. The small
> fixed-size ones, the rollover state, the per-CPU TX pending counter and
> the deferred-free work of a TX ring, are left unaccounted: there is at
> most one of each per socket or ring, so the socket bounds them. skbs
> are bounded by sk_rcvbuf and sk_sndbuf and are left as they are, as is
> the per-packet zerocopy state in tpacket_snd(), which lives only as
> long as its skb. struct packet_sock itself comes from sk_alloc(), and
> the netdev_hw_addr entries that PACKET_MR_MULTICAST and
> PACKET_MR_UNICAST add through dev_mc_add() and dev_uc_add() live in
> net/core; neither is changed here.
> 
> With the change each of the three tests in the 16M cgroup is stopped
> by the cgroup's OOM killer. With memory.max at 1G the rings charge
> 525436 KB for 525536 KB of system memory used, the fanout groups
> 262400 KB for 264608 KB, and the membership entries 26880 KB for 200000
> entries. These figures are from a KASAN kernel, which inflates the small
> objects. With 8 MB blocks, which always take the vmalloc fallback, a
> 32 MB ring charges 32636 KB for 32768 KB used (1G). In the 16M cgroup
> the cgroup's OOM killer then acts; with oom_score_adj -1000, so that
> nothing can be killed, ring setup fails with -ENOMEM and no vmalloc
> allocation warning. A workload whose memory.max leaves no room for its
> rings now sees ring setup fail or the cgroup's OOM killer act.
> 
> The missing charges were found by code inspection of net/packet/ with
> the help of an LLM and then triggered with a small test program that
> creates the sockets, rings, groups and entries and reads
> memory.current; the numbers above are from that program. Tested in a
> QEMU/KVM guest on the net tree (x86_64_defconfig plus kvm_guest.config,
> KASAN, MEMCG, PACKET), running the test as uid 1000 in a cgroup v2
> memory cgroup. tools/testing/selftests/net/psock_fanout, psock_tpacket
> and psock_snd.sh pass before and after.
> 
> Reproducer, as uid 1000 in a cgroup v2 memory cgroup with memory.max
> 16M: unshare(CLONE_NEWUSER | CLONE_NEWNET), then 64 times:
> socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)); PACKET_VERSION
> TPACKET_V2; PACKET_RX_RING with tp_block_size 1 MB, tp_block_nr 8,
> tp_frame_size 2048, tp_frame_nr 4096; mmap the 8 MB ring and write
> one byte per block. Compare the growth of memory.current with the
> drop in MemFree. The other two tests replace the ring with one
> PACKET_FANOUT group per socket (max_num_members 65536, 256 sockets)
> or 2000 PACKET_MR_PROMISC entries on lo per socket (100 sockets).

Please trim the commit message a bit.
 
> The ring pages have never been charged to memcg, and the membership
> entries and block array not since commit a9bb7e620efd ("memcg: only
> account kmem allocations marked as __GFP_ACCOUNT"); neither has a
> culprit commit. The Fixes tag covers only the fanout array growth.
> 
> Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size configurable up to 64K")
> Cc: <stable+noautosel@kernel.org> # changes memcg charging of existing packet rings; not stable material
> Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
> ---
> Tool use: an LLM coding assistant (Claude Code) found the missing
> charges by code inspection, drafted the patch, the test program and this
> message, and ran the tests in the QEMU guest; I reviewed every hunk, the
> results and this message before sending.
> 
> v3:
>   - target net as Willem suggested; stable+noautosel instead of a stable Cc
>   - Fixes: 9c661b0b8544 instead of 1da177e4c3f4
>   - leave the fixed-size per-socket allocations (rollover, per-CPU pending
>     counter, deferred TX ring free) unaccounted
>   - add __GFP_NOWARN to the vmalloc fallback like the pg_vec allocation
>   - give the reproduction steps and reword the Fixes rationale
> v2: https://lore.kernel.org/netdev/20261030100504.23498-1-ahmadag1001@gmail.com/
>   - cover all user-triggered allocations in one patch; sent with git send-email
> v1: https://lore.kernel.org/netdev/CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com/
> 
>  net/packet/af_packet.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index cf6429f0947..3cec23a505b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1778,7 +1778,8 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>  			/* legacy PACKET_FANOUT_MAX */
>  			args->max_num_members = 256;
>  		err = -ENOMEM;
> -		match = kvzalloc_flex(*match, arr, args->max_num_members);
> +		match = kvzalloc_flex(*match, arr, args->max_num_members,
> +				      GFP_KERNEL_ACCOUNT);

__GFP_NOWARN missing?

>  		if (!match)
>  			goto out;
>  		write_pnet(&match->net, sock_net(sk));
> @@ -3773,7 +3774,7 @@ static int packet_mc_add(struct sock *sk, struct packet_mreq_max *mreq)
>  		goto done;
>  
>  	err = -ENOBUFS;
> -	i = kmalloc_obj(*i);
> +	i = kmalloc_obj(*i, GFP_KERNEL_ACCOUNT);
>  	if (i == NULL)
>  		goto done;
>  
> @@ -4494,7 +4495,7 @@ static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
>  static char *alloc_one_pg_vec_page(unsigned long order)
>  {
>  	char *buffer;
> -	gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
> +	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_COMP |
>  			  __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>  
>  	buffer = (char *) __get_free_pages(gfp_flags, order);
> @@ -4502,7 +4503,8 @@ static char *alloc_one_pg_vec_page(unsigned long order)
>  		return buffer;
>  
>  	/* __get_free_pages failed, fall back to vmalloc */
> -	buffer = vzalloc(array_size((1 << order), PAGE_SIZE));
> +	buffer = __vmalloc(array_size((1 << order), PAGE_SIZE),
> +			   GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN);

__vcalloc

>  	if (buffer)
>  		return buffer;
>  
> @@ -4523,7 +4525,8 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
>  	struct pgv *pg_vec;
>  	int i;
>  
> -	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
> +	vec = kzalloc_flex(*vec, pg_vec, block_nr,
> +			   GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>  	if (unlikely(!vec))
>  		return NULL;
>  	vec->order = order;
> @@ -4648,7 +4651,8 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
>  		default:
>  			if (!tx_ring) {
>  				rx_owner_map = bitmap_alloc(req->tp_frame_nr,
> -					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
> +					GFP_KERNEL_ACCOUNT | __GFP_NOWARN |
> +					__GFP_ZERO);

bitmap_zalloc

>  				if (!rx_owner_map)
>  					goto out_free_pg_vec;
>  			}
> 
> base-commit: 7b29287b182fc50518e9e65c41f86d24a05b7205
> -- 
> 2.43.0
> 


