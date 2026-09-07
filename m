Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4A479868
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781118; cv=none; b=l0fYZltDsXhA0zAAj0S4KBw2s7gJU5WxJ1Zp7w2lemOQgTiPLnEp2AeZvgK5i+WLhFdq04DmtrMXHn/ZNy5YXWeeR2C1HIlpEMD2x6PwkcwF7/MlP8FeO5nKDRg4x2GhGoO+iJPRP/8x3w1iGwfTUA+1Mf6hyxk5OJ5JzFkWhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781118; c=relaxed/simple;
	bh=QwwysY4kOM43IbyyWzoqUwfxdkp/ukWs4YrGuT2WZP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKcpsQ1U6uAnXA1wmKBDg0FwVNO42l94tMgn4nb3ILSUp3CAdRrkaUBOuu5RONOn9HTZO3vAPfJ4NTpF2WcT7ucMw+xWBUFwO04ACvOLdva+/kSjocyJam3brIqZhY/MZIV6id5hBzmxsbP7bdTE/faIYrSlUW4n392ZltHy0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=idpgG5X3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pIUf37WU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y+5sIrJ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MChbDhfT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="idpgG5X3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pIUf37WU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y+5sIrJ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MChbDhfT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FA4F1F785;
	Mon,  7 Sep 2026 11:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788781110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/G9iIGu/9g0dryRqsEYEcbpFTvYwURVflBEUt+5w6pI=;
	b=idpgG5X3XEAnwZu0CloAiW1a/H/wVn+0u9F8kk5/W6JBJBIXrUhtmilhF7EmAlsfHu9gj2
	hvbYsRinyENEzSHg1c3W8Tm1ZUtagEhsfLiwv27me37nsa0J5YHzCQVtM2mwgPogvN/gC+
	7skZMp+V9JAwj5M7WNWBVazEK6xjiLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788781110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/G9iIGu/9g0dryRqsEYEcbpFTvYwURVflBEUt+5w6pI=;
	b=pIUf37WUghLnE71Bc/quiac0AH0f92y0qN3k/gn3A4w+pkiq+VNWxL7c/dveItgsFglzpM
	oqR2QnQtA8sOTwAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y+5sIrJ0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MChbDhfT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788781106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/G9iIGu/9g0dryRqsEYEcbpFTvYwURVflBEUt+5w6pI=;
	b=Y+5sIrJ0++mbf1bjfwbjT7nWge/YF0oToq4/jXPhKdups30NHFlNjfCtNBqQvVDTV4Ew2s
	Sk9LJDdkPI8zHzPe4QVqR8UURJZfetQ28S3HGeyIBWgums0cL+dvIQXZfyrZx+bvQj2VgF
	KrKp2sLk947mH2LR/TRzHZApnLoxMfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788781106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/G9iIGu/9g0dryRqsEYEcbpFTvYwURVflBEUt+5w6pI=;
	b=MChbDhfTsL4jIxyGY1lXgNyGS7Oblab90jIHtOZrJajilb3qOd3grFUbk+UGqU3FudcnxL
	7n0whG6xSgM8uXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE82613432;
	Mon,  7 Sep 2026 11:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ELhqNzGinmoJfAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 07 Sep 2026 11:38:25 +0000
Message-ID: <7612748f-3a0d-4930-9067-f5bc49e1b361@suse.de>
Date: Mon, 7 Sep 2026 13:37:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: null-check fib6_node before accessing in
 __ip6_del_rt_siblings()
To: Naman Gulati <namangulati@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com
References: <20260904180645.706425-1-namangulati@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260904180645.706425-1-namangulati@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 9FA4F1F785
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[a73e5ee0fd534fed75bd];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 9/4/26 8:06 PM, Naman Gulati wrote:
> syzbot reported a null-ptr-deref in __ip6_del_rt_siblings() [0].
> 
> The stack trace hinted towards a null dereference of rt->fib6_node when
> fn->leaf is accessed in __ip6_del_rt_siblings(). With
> RTNL_FLAG_DOIT_UNLOCKED set, inet6_rtm_delroute() operations run
> concurrently without acquiring the RTNL lock. In ip6_route_del(), the
> route lookup happens under rcu_read_lock() without acquiring
> table->tb6_lock.
> 
> Between ip6_route_del() looking up the route and __ip6_del_rt_siblings()
> acquiring table->tb6_lock, another thread can modify the routing table.
> For example, when an ECMP route is replaced via RTM_NEWROUTE with
> NLM_F_REPLACE, fib6_add_rt2node() unlinks all old siblings and sets
> iter->fib6_node = NULL. A reproducer was found that triggers this [1].
> 
> Add a check to ensure rt->fib6_node is non-null before accessing it.
> 
> [0]
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> RIP: 0010:__ip6_del_rt_siblings+0x31e/0x7c0 net/ipv6/route.c:4056
> Call Trace:
>   <TASK>
>   ip6_route_del+0x1054/0x1110 net/ipv6/route.c:4232
>   inet6_rtm_delroute+0x5d7/0x6d0 net/ipv6/route.c:5669
>   rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7132
>   netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
>   netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>   netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
>   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
>   sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
>   __sock_sendmsg net/socket.c:815 [inline]
>   ____sys_sendmsg+0x565/0x870 net/socket.c:2713
>   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
>   __sys_sendmsg net/socket.c:2799 [inline]
>   __do_sys_sendmsg net/socket.c:2804 [inline]
>   __se_sys_sendmsg net/socket.c:2802 [inline]
>   __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2802
>   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>   do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   </TASK>
> 
> [1] https://gist.github.com/NamanGulati/0766a1159b6ca61928faaf87425ff899
> 
> Fixes: bd11ff421d36 ("ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.")
> Reported-by: syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a9b03f9.04649fcc.10325f.0003.GAE@google.com
> Signed-off-by: Naman Gulati <namangulati@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

> ---
>   net/ipv6/route.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 9658939511e0..08bd68f1b5bb 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -4019,6 +4019,7 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
>   	struct net *net = info->nl_net;
>   	struct sk_buff *skb = NULL;
>   	struct fib6_table *table;
> +	struct fib6_node *fn;
>   	int err = -ENOENT;
>   
>   	if (rt == net->ipv6.fib6_null_entry)
> @@ -4026,9 +4027,13 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
>   	table = rt->fib6_table;
>   	spin_lock_bh(&table->tb6_lock);
>   
> +	fn = rcu_dereference_protected(rt->fib6_node,
> +				       lockdep_is_held(&table->tb6_lock));
> +	if (!fn)
> +		goto out_unlock;
> +
>   	if (rt->fib6_nsiblings && cfg->fc_delete_all_nh) {
>   		struct fib6_info *sibling, *next_sibling;
> -		struct fib6_node *fn;
>   
>   		/* prefer to send a single notification with all hops */
>   		skb = nlmsg_new(rt6_nlmsg_size(rt), GFP_ATOMIC);
> @@ -4051,8 +4056,6 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
>   		 * and emit a replace or delete notification, respectively.
>   		 */
>   		info->skip_notify_kernel = 1;
> -		fn = rcu_dereference_protected(rt->fib6_node,
> -					    lockdep_is_held(&table->tb6_lock));
>   		if (rcu_access_pointer(fn->leaf) == rt) {
>   			struct fib6_info *last_sibling, *replace_rt;
>   

