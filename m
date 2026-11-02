Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582775;
	b=KDW/7x0O8gqVDfHd3r5o5ByaeD49d2btJhCyjzpF0tooBlJXRJHwtgmFQTITm8BwKygZ
	 F4t2zYCB8hgyAWq9BwzXuR/HqPiQ/2SvSmfoHyqimA4YDPR2Sdg4P/W1YHc91dr2HSREG
	 GEbCg4L79peWMAarKWN99p+V3031VbgId1eC2MVBp7CDZB325vVgF67DgpexTsC/kwe0P
	 0XhubrT50B2POXZAaOQ0V7B0pek4LSaF02GqvW4Gs1GYC4AX5fl05CP6QgUPEHRWvSra7
	 aGM3lryMA2mOiuZG//MO139OyWMs26qmd/AkuJi8XI6fmToQV0SwBIDjWsoyCcc5t0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582775;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dKJhgABntFpeEvPRMITUX6NzxL+GKjKT7B8PFs7e3ug=;
	b=C5en2K+vIk9A5tp60zWzoZPEDgkod6kyrEkKpHH8R+A2ULsh6/i1W1bhN4p314BovE/k
	 x3kNWw1e2phGN3D7FTn55+/P6yarJhyJ8XVHNZgnNf2pvywTHptGdNU4+mWpNZf74JPJx
	 Ho9SXMsc1RvLhjUvk8uEzP8GyaQ2kZqzCSyaZ/dnHzWVHPlS/n6t6UHBr8fyEJyfTbErt
	 uCLgUPPaVk3D+3W7pkRphLR1SKkhGR45gG6PzX9Ju3wEosf65fIOD1AvRBI+tE/CqN47j
	 PwBhH2bv7m2qd7lQTpSLcNbf9+Jav8ZyR9r8qrIBTgZ/0A7MAEbS5aqx463ooBALrxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q+AfSDu2;
	arc=none smtp.remote-ip=91.218.175.23
Received: from mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC27606A33C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 01:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC27606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q+AfSDu2
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=l3N0psSADePkKldw55AfcXDQE2PfeeVZR7BrUgT4jW4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793582770; v=1; x=1794187570;
 b=q+AfSDu2PAe+jEAVVCv/vb70Ab8OyBAgZmhcNhjEOUkilEdAYESS5xyzvRKbghuzccqjGznE
 cTqTZSBYZqkpJlIcnPasYEfTcQ37RQKjaxxiQqtp8/ZzDthl1ogwSGvKgi6ShmkYKSAXCZ/HxQ8
 c6C+1jdn2K07FaBFas9kD2dA=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id ad46c3b066790dba;
	Mon, 02 Nov 2026 01:26:10 +0000
X-Mizu-Trace-ID: ad46c3b066790dba
X-Migadu-Flow: FLOW_OUT
Date: Mon, 2 Nov 2026 09:25:54 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Gerd Rausch <gerd.rausch@oracle.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Flavio Leitner <fbl@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/5] ipv6: restrict gc_elasticity to 31
Message-ID: <aufmolKft7khDbNq@fedora>
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
 <20261101061331.286404-2-jiayuan.chen@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101061331.286404-2-jiayuan.chen@linux.dev>

On Sun, Nov 01, 2026 at 02:11:59PM +0800, Jiayuan Chen wrote:
> Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
> live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
> ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
> smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.
> 
> ip6_dst_gc() reads ip6_rt_gc_expire into a u32, but gc_elasticity has no
> bounds at all, so writing >= 32 shifts a 32-bit value by >= 32 bits, and
> a negative value gives a negative shift count. Both are UB:
> 
> 	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
> 	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
> 
>   UBSAN: shift-out-of-bounds in net/ipv6/route.c:3369:53
>   shift exponent 32 is too large for 32-bit type 'unsigned int'
>   CPU: 2 UID: 0 PID: 615 Comm: ping6 Not tainted 7.3.0-rc7+ #364 PREEMPT
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0xc1/0xf0
>    dump_stack+0x10/0x20
>    __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>    ip6_dst_gc.cold+0x15/0x1a
>    dst_alloc+0x4e0/0x620
>    ip6_rt_cache_alloc+0x189/0x7e0
>    __ip6_rt_update_pmtu+0x68e/0x1160
>    ip6_update_pmtu+0x30c/0x3a0
>    icmpv6_err+0x1fa/0x330
>    icmpv6_notify+0x303/0x770
>    icmpv6_rcv+0xc12/0x1670
>    ip6_protocol_deliver_rcu+0xb4a/0x1520
>    ip6_input_finish+0x19c/0x400
>    ip6_input+0xd4/0x240
>    ipv6_rcv+0x1fd/0x330
>    __netif_receive_skb_one_core+0x118/0x1c0
>    __netif_receive_skb+0x21/0x150
>    process_backlog+0x37e/0x1200
>    __napi_poll.constprop.0+0xa5/0x5e0
>    net_rx_action+0x4c0/0xf70
>    handle_softirqs+0x204/0x9b0
>    __do_softirq+0x10/0x18
> 
> Make it a u8 and reject writes outside 0..31 with proc_dou8vec_minmax().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2: switched to u8 and proc_dou8vec_minmax(), as suggested by Kuniyuki
> Iwashima.
> ---
>  include/net/netns/ipv6.h | 2 +-
>  net/ipv6/route.c         | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index ffda15318be59..aefce37c04a4f 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -25,11 +25,11 @@ struct netns_sysctl_ipv6 {
>  	int ip6_rt_gc_min_interval;
>  	int ip6_rt_gc_timeout;
>  	int ip6_rt_gc_interval;
> -	int ip6_rt_gc_elasticity;
>  	int ip6_rt_mtu_expires;
>  	int ip6_rt_min_advmss;
>  	u32 multipath_hash_fields;
>  	u8 multipath_hash_policy;
> +	u8 ip6_rt_gc_elasticity;
>  
>  	__cacheline_group_begin(sysctl_ipv6_flowlabel);
>  	u8 flowlabel_consistency;
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 94e5ef1c4f83e..f7d56dd3926bb 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6579,6 +6579,8 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
>  	return 0;
>  }
>  
> +static unsigned int ip6_rt_gc_elasticity_max = 31;
> +
>  static const struct ctl_table ipv6_route_table_template[] = {
>  	{
>  		.procname	=	"max_size",
> @@ -6625,9 +6627,10 @@ static const struct ctl_table ipv6_route_table_template[] = {
>  	{
>  		.procname	=	"gc_elasticity",
>  		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_elasticity,
> -		.maxlen		=	sizeof(int),
> +		.maxlen		=	sizeof(u8),
>  		.mode		=	0644,
> -		.proc_handler	=	proc_dointvec,
> +		.proc_handler	=	proc_dou8vec_minmax,
> +		.extra2		=	&ip6_rt_gc_elasticity_max,
>  	},
>  	{
>  		.procname	=	"mtu_expires",
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
