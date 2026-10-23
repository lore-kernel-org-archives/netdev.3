Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793708;
	b=K0kEdFjnv695EskBQmS+Km2AgFl56uCn8St1QOG1WfCs9i3jdSFM23shwseBdTa6xhy8
	 +llHSDZv3uiXF+4LXy3nqOEDz+QWBb7K8HECYAZ50O3i+89mEylaHNpDft48ZGrB5Ap0F
	 yof7KS+u3GsimK9Ecsvz8NOPXyR9BquUIjcKqzEWvzWQYLAmeUEU+ZDnB9lcW/dbKoCzx
	 USEU/Vwx5hUVNPZub3OnmX1f28k+YpNhj1CVJuHGrbo/iAg7YjCwyV5p+ZLRHlxos+k1K
	 i8QHgEl05Qv2xl1w0VzIqC7e611wR7xeegsFt0hLN+rpfMHWhfkzZLD1nwgGmAvSDCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793708;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/XORbWQ8BvmlVZlfkyV/hYVE6d6wi3LiuPwenCeNuPs=;
	b=VGo302JXDrBRPD8lbG7g/XUnaeb19ZVyzXHczcen/O4/1VcCgHMWT+XwvcCzdKRBfaFF
	 e3quBB7kcG89uBaUaItf6elB+jci86DbxPfCneIHnPuqd1wsbcYvUqULPAq6/NKzZbrgJ
	 kcgwCaebc2w0QUIbEJcsc8Jt/fUbV97ZUQiQh9IV5lnzU2au0+qZlELNmoLr0ZJBbeMy1
	 n2YWdZ79P6JYDjdBjIuj+gt+EriQyr1YhCWLhIceLkzmQ5kTqB9DSTkBj6vOmJwOTRLVK
	 0tVp7y889UVNO3yOPWZksF1v74oWLKfiiw433Zfs871TGsA6nmIN6C+brUR5b3gMjMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMDS9W5p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B53606A31B;
	Fri, 23 Oct 2026 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMDS9W5p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6801F01825;
	Fri, 23 Oct 2026 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793707;
	bh=/XORbWQ8BvmlVZlfkyV/hYVE6d6wi3LiuPwenCeNuPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eMDS9W5plSEsd6PBeaM2BLgv9mGB4bbrX+lZApJaw0Gu4MpUjlv5Gy0gn/5OMdYFo
	 0kYommQ0MaoHabeokHHdecy4Me73gvsFBf5XT9KYiSnEg1M+pcJBVuJJ/4KnZ/kFNv
	 d7F//u8bY4+s1jSLrJ0cpUBkhkrVBx01ikYhwZ1JXbEqpo5XgN75xBdA6hKyVZmxhx
	 HODIpUBETqYtYFedLnzdCc2bdlMwSYEQP3wQ4de1BUG7JpV64lwh/F8r7fbiQ4wN87
	 3sro6ndv2fbveg/k0cjAtaKCo56iWTqVTiRqdy6aepdWNvw5RxQEU9iTgePF4DpNFa
	 R8F7yhwz5Vung==
Date: Fri, 23 Oct 2026 15:15:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Kees Cook
 <kees@kernel.org>, Ilya Maximets <i.maximets@ovn.org>, Breno Leitao
 <leitao@debian.org>, Jeff Layton <jlayton@kernel.org>, Kexin Sun
 <kexinsun@smail.nju.edu.cn>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] netlink: fix out-of-bounds bitmap access
 clearing stale mc groups
Message-ID: <20261023151506.4f5e5b15@kernel.org>
In-Reply-To: <20261020032119.1334986-1-bsdhenrymartin@gmail.com>
References: <20261020032119.1334986-1-bsdhenrymartin@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 11:21:19 +0800 Henry Martin wrote:
> netlink_realloc_groups() sizes nlk->groups to the number of groups
> that exist at bind/ADD_MEMBERSHIP time.  When more multicast groups
> are registered later (e.g. a new genl family), existing sockets keep
> their smaller bitmap.
> 
> When clearing a multicast group of a departing family,
> __netlink_clear_multicast_users() runs netlink_update_socket_mc() on
> each socket on mc_list, which does test_bit()/__assign_bit() on
> group - 1 with no regard to nlk->ngroups.  Skip groups that lie
> beyond the socket's bitmap: such a socket could never have joined
> them.  This is the same guard do_one_broadcast() already applies.
> 
> The overflow windows differ per architecture, both needing privileged
> module (un)loading.  On 32-bit kernels the ~54 dynamically allocated
> genl groups already exceed the initial 32-bit bitmap, so the table
> can grow there directly.  On 64-bit kernels the same in-tree set
> fits the initial 64-bit bitmap only while allocation stays
> contiguous: genl_allocate_reserve_groups() takes the first free
> contiguous range and unregister does not compact, so an
> unload/reload sequence can fragment the ~59 free IDs until no
> fitting range remains, forcing the table past 64 bits and reaching
> the same stale-bitmap overflow on the next family teardown.
> 
> This issue was discovered by Tencent CodeBuddy Security.
> 
> Fixes: 84659eb529b3 ("[NETLIKN]: Allow removing multicast groups.")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> 
> v3: Correct the reachability again (sashiko review): 64-bit is also
>     reachable - group IDs are allocated in contiguous ranges without
>     compaction, so fragmentation from an unload/reload sequence can
>     force the table past the initial 64-bit bitmap too.
> 
> v2: Correct the Fixes tag (the clear path was added by 84659eb529b3,
>     not by the dynamic bitmap commit), drop Cc: stable and describe
>     the actual reachability (32-bit kernels with in-tree families)
>     instead of implying generic heap corruption.
> 
>  net/netlink/af_netlink.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 9fdf964224ab4..8cc655aa927f1 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1657,6 +1657,12 @@ static void netlink_update_socket_mc(struct netlink_sock *nlk,
>  {
>  	int old, new = !!is_new, subscriptions;
>  
> +	/* A socket whose bitmap predates this group can never be a member;
> +	 * don't touch bits beyond its allocation.
> +	 */
> +	if (group - 1 >= nlk->ngroups)
> +		return;
> +
>  	old = test_bit(group - 1, nlk->groups);
>  	subscriptions = nlk->subscriptions - old + new;
>  	__assign_bit(group - 1, nlk->groups, new);

Dunno :/ I would prefer the following fix, otherwise it looks like we
may silently ignore a netlink_update_socket_mc(..., 1)

@@ -2163,8 +2157,12 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
        struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
        struct hlist_node *tmp;
 
-       sk_for_each_bound_safe(sk, tmp, &tbl->mc_list)
+       sk_for_each_bound_safe(sk, tmp, &tbl->mc_list) {
+               /* bitmap predates the group, can't be a member */
+               if (group - 1 >= nlk_sk(sk)->ngroups)
+                       continue;
                netlink_update_socket_mc(nlk_sk(sk), group, 0);
+       }
 }
-- 
pw-bot: cr
