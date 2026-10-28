Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150891;
	b=LZ5a6jAxjhdwnGfyjLoWriLudnXrF2wP5WAZG4laAeyRLamGgOk7p31P11M6CgJUnWuX
	 qBsr4iWQdtL8a/3N2/r9YUEXctKL4yiZg4Bwp+DprjnDSPYN9V4wTmLW/XZPqNr6H6MnR
	 vikmdqokyXfZkay10ChMltI9dggxoVJ8v9eMUqsLZkR5arNvD6WLrrJcQqyV5VTGr884A
	 Mn6cK3eyH0cN6Clfn+1gv+Nhry9XPzz04RCnKLyHOMGVNmS2TvCiTpeP/nMIz/8hjQqtm
	 REgPJ+8VeHQNk4lnRrXaiYPEVJgC4tR8pqWbl92Awdk9tKiHUbkeaEHS7kxntkvVGHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150891;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OoEszvGm7Jt8r2Hgps9BAadui447M2pxW0SiVZm0x7s=;
	b=DQ/DafmLPZV/wt624mG9uuV1yulpIYO0K+BzV/hgskg9/Cvs7luu82Z4bilmAbQqjAgZ
	 sEoHnc5z9dH4XTInIvSky1g4eON9HF7EkITzbizb9Sz/xB2WXVxbpFYQN1Ti5zE3BCAf8
	 4P2arIpjrhpbyfebVFXUBL1vXtaWGXXvL7mxhGtEbdWWzkHykMzBNZPKeFeGtMY/k/WwJ
	 GvhchCRljamG/Ypj2aSnvt40DE4vthW1Qb6gKXsLGsz5UbAWjDieX1uzQMjf02uZOYDsY
	 Q22cM3x+fdXuKp0VmJrWhsamW/MrAivrWf/dfw113H03YBG7T1LrTzEZ/rRBNhTtY7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rkp7nNL0;
	arc=none smtp.remote-ip=95.215.58.169
Received: from mta1.migadu.com (out-169.mta1.migadu.com [95.215.58.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF0606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 01:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DCF0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rkp7nNL0
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sbvDgc3joPyy/j914OEP6tCwRBpNWUQikTAlXej1Uq4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793150886; v=1; x=1793755686;
 b=rkp7nNL0OLdSYcb59MXeFHASOBTGrfoVXSeiDOAzcm6l2NlZvGUgzPFj1S+1o86f7XPYvI3/
 6bb/0LcC7zO+bwkuQX2rgJIdUS3cr0StXRACoH///yv4lMgTmRbdiNo4WddWx4oIaVa3w7WWiNw
 qraOAe9NEp20TCritt5BRty8=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 47897f4e5ab642e4;
	Wed, 28 Oct 2026 01:28:06 +0000
X-Mizu-Trace-ID: 47897f4e5ab642e4
X-Migadu-Flow: FLOW_OUT
Date: Wed, 28 Oct 2026 09:27:49 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Antoine Tenart <atenart@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: Zhou Qiuyue <n0ps1edzz@gmail.com>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
Message-ID: <auFPlcB4VfQ76NYC@fedora>
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
 <at7uk8gXtzNufuQF@fedora>
 <at9sKRSEJLVGj9OK@kwain>
 <auAAmqXcxmC6BDrR@fedora>
 <auBs0Xn5yVJ1NtdK@kwain>
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
In-Reply-To: <auBs0Xn5yVJ1NtdK@kwain>

On Tue, Oct 27, 2026 at 10:43:48AM +0100, Antoine Tenart wrote:
> On Tue, Oct 27, 2026 at 09:38:34AM +0800, Hangbin Liu wrote:
> > On Mon, Oct 26, 2026 at 04:07:40PM +0100, Antoine Tenart wrote:
> > > On Mon, Oct 26, 2026 at 02:09:23PM +0800, Hangbin Liu wrote:
> > > > On Mon, Oct 26, 2026 at 12:48:08PM +0800, Zhou Qiuyue wrote:
> > > > > diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> > > > > index b965258cf..bdea82543 100644
> > > > > --- a/net/ipv6/raw.c
> > > > > +++ b/net/ipv6/raw.c
> > > > > @@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
> > > > >  	if (unlikely(!skb))
> > > > >  		return 0;
> > > > >  
> > > > > +	/* l3mdev_ip6_out() may have replaced the skb dst. */
> > > > > +	rt = dst_rt6_info(skb_dst(skb));
> > > > > +
> > > > >  	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
> > > > >  	 * in the error path. Since skb has been freed, the dst could
> > > > >  	 * have been queued for deletion.
> > > > 
> > > > Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> > > 
> > > Doesn't this change the device seen by the nf hook / used for the stats?
> > 
> > Should we still use the old/released rt->dst.dev after the VRF output
> > path replace skb->dst? vrf_ip6_out_redirect() said it allows the nf hook
> > use vrf device.
> 
> Right, but then in the direct path the NF_INET_LOCAL_OUT hook would be
> run twice with the same dev. Looking at other call sites for
> l3mdev_ip6_out, it's not clear either,  __ip6_local_out reloads the dev
> while ip6_xmit does not. I'm not sure what is the expected behavior.

Hmm, me neither. David might know.

Thanks
Hangbin
> 
> Regardless of that, the change in behavior (if right) would be worth
> mentioning in the commit log.
