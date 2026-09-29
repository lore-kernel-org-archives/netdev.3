Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153953A3A8
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695687; cv=none; b=o+4niPJ8+D1hyB1k9XmHJO4qkyoPQbgbdZll0cfSpqTAcH2fmQXK5J453RIZe5VAS9i8v2BkgrF0gjsLxpOOUmrgl2CEiGl/rt6yZH3/57RKKHEzZDU5NVfyssAjl7yow6Q3SZeBYD3JIoaZi1yZEcWJg9KnyBEf8sM/U4SaiMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695687; c=relaxed/simple;
	bh=sdBfJBQ2h3qBppkvRSx3+19NMmi4+/Ld3/Ibrb5Np5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuqpAM9C8WnNxqQSe8XSFpfVl+t+C4hAKGjZd4njRy1OfVPPkw4jP4QA35MORg6zQFuKOj1wCDHqUOnZsZ5mJp5iJT+MtnyPDl7PcXuFvyFoUeFNiYHtGKYuTQCnN5fEnzQ1h36pL8tutyZSKUIvNjy2vlaLZjW8WePNeKFJK8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dEXGn4yl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gO7FhB2d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lLgwkQOD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YSrEm3M2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dEXGn4yl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gO7FhB2d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lLgwkQOD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YSrEm3M2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24C991F385;
	Tue, 29 Sep 2026 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790695675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV7bVN8G9aM58O48ZfZEE3HtbwlasD/1u4f6YGY0lVU=;
	b=dEXGn4ylyssoP+UT18M8qLC/xh5FTyj6TYvl/+PzjMrQ42ks6S0Kn92Q8+hXvwFZOJD0W/
	5jepxK3upkIf4IzsJl0ey9cLEMvTNsSipmBf2ElcttywQ3rLRoR5fk717DXWgVy2sZhsmM
	XZAWwzm4VhmTWa6Y+hrOgojbh6A6B2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790695675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV7bVN8G9aM58O48ZfZEE3HtbwlasD/1u4f6YGY0lVU=;
	b=gO7FhB2d4Qw8Ii6GIYYcQs3i5T42dcbl5rKGAPIpfZkQei2hUeqZTXCgdMdBn4nMI1+EhY
	YHtXXdEKYmvzM8Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790695671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV7bVN8G9aM58O48ZfZEE3HtbwlasD/1u4f6YGY0lVU=;
	b=lLgwkQODl9q9qa+5tJ8vvVxLxpm1n8i49dB4vMkIuidMBas/ExBpC92k5B64TI850+xJdr
	2J2QalRp/UDdczbMpGQCkNyRPBKM5fxeDCv4JDtcqjKRTVR+1XA4PePDb5j+XFlC1A39RD
	rqAze/vEb+qB22+zQQunFYVhkoC1LrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790695671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV7bVN8G9aM58O48ZfZEE3HtbwlasD/1u4f6YGY0lVU=;
	b=YSrEm3M2gmdLk1tniqcETUnISC0Hrr2mxgUbXp+YipgmSEvgQQsTAczEwJSEku19DtJYFi
	v3DJ9qH0bQkdewAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 571DE133F1;
	Tue, 29 Sep 2026 15:27:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SFkYCvbYu2pZIAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 29 Sep 2026 15:27:50 +0000
Message-ID: <b3682f3b-f895-4843-815f-7f8a09530ba3@suse.de>
Date: Tue, 29 Sep 2026 17:27:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: fix NULL deref when joining a group without a
 socket
To: Wentao Luo <luowentao077@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Antonio Quartulli <antonio@openvpn.net>, Jiri Benc <jbenc@redhat.com>
References: <b397156b-c184-4061-a9d5-52cce5c4f07e@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <b397156b-c184-4061-a9d5-52cce5c4f07e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,kernel.org,redhat.com,google.com,gmail.com,openvpn.net];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

On 9/29/26 2:22 PM, Wentao Luo wrote:
> vxlan_sock_add() ignores -EAFNOSUPPORT when creating the IPv6 socket
> of a metadata device, so the device can come up with vn6_sock NULL
> after ipv6.disable=1. A later IPv6 multicast join still uses that
> socket. vxlan_igmp_join() dereferences it and oopses.
> 
> This was observed on an external vnifilter device by adding an IPv6
> group while the device was up:
> 
>    BUG: KASAN: null-ptr-deref in vxlan_igmp_join+0xb8/0x18c
>    Read of size 8 at addr 0000000000000010 by task bridge/729
>    Call trace:
>     show_stack+0x18/0x24 (C)
>     dump_stack_lvl+0x78/0x90
>     print_report+0x468/0x5cc
>     kasan_report+0xa4/0xf0
>     __asan_load8+0x7c/0xd0
>     vxlan_igmp_join+0xb8/0x18c
>     vxlan_vni_update_group+0x2b4/0x390
>     vxlan_process_vni_filter+0xfe0/0x1750
>     vxlan_vnifilter_process+0x218/0x270
>     rtnetlink_rcv_msg+0x1ec/0x514
>     netlink_rcv_skb+0xc0/0x1f0
>     rtnetlink_rcv+0x18/0x24
>     netlink_unicast+0x4b8/0x558
>     netlink_sendmsg+0x2b8/0x584
>     ...
> 
> Return -EAFNOSUPPORT from vxlan_igmp_join() and vxlan_igmp_leave()
> when the address family has no socket. The same leave path runs while
> rolling back a failed join.
> 
> Fixes: d074bf960044 ("vxlan: correctly handle ipv6.disable module 
> parameter")
> Signed-off-by: Wentao Luo <luowentao077@gmail.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Just a nit: the checks on the leave path are not necessary. While I 
think it is fine to leave them just for the symmetry, I do not think we 
can reach such path without succeeding during the join and if the join 
succeeds it means ipv6 is not disabled.

> ---
> Simplest reproducer. Build with CONFIG_IPV6=y and boot with
> ipv6.disable=1:
> 
>    ip link add vxlan0 type vxlan external group ff05::1 dev lo dstport 4789
>    ip link set vxlan0 up
> 
> The NULL pointer dereference is then reproduced.
> 
>   drivers/net/vxlan/vxlan_multicast.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/ 
> vxlan_multicast.c
> index 3b75b48dc726d..33ec1fd59ca82 100644
> --- a/drivers/net/vxlan/vxlan_multicast.c
> +++ b/drivers/net/vxlan/vxlan_multicast.c
> @@ -29,6 +29,9 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union 
> vxlan_addr *rip,
>               .imr_ifindex        = ifindex,
>           };
> 
> +        if (!sock4)
> +            return -EAFNOSUPPORT;
> +
>           sk = sock4->sk;
>           lock_sock(sk);
>           ret = ip_mc_join_group(sk, &mreq);
> @@ -37,6 +40,9 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union 
> vxlan_addr *rip,
>       } else {
>           struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
> 
> +        if (!sock6)
> +            return -EAFNOSUPPORT;
> +
>           sk = sock6->sk;
>           lock_sock(sk);
>           ret = ipv6_sock_mc_join(sk, ifindex, &ip->sin6.sin6_addr);
> @@ -62,6 +68,9 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union 
> vxlan_addr *rip,
>               .imr_ifindex        = ifindex,
>           };
> 
> +        if (!sock4)
> +            return -EAFNOSUPPORT;
> +
>           sk = sock4->sk;
>           lock_sock(sk);
>           ret = ip_mc_leave_group(sk, &mreq);
> @@ -70,6 +79,9 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union 
> vxlan_addr *rip,
>       } else {
>           struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
> 
> +        if (!sock6)
> +            return -EAFNOSUPPORT;
> +
>           sk = sock6->sk;
>           lock_sock(sk);
>           ret = ipv6_sock_mc_drop(sk, ifindex, &ip->sin6.sin6_addr);

