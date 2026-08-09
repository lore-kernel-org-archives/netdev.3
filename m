Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675835CBD6;
	Sun,  9 Aug 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287519; cv=none; b=MbQnelAto5aoI55cKt87UiMQeiU5a8RqBppAWhICeOgh1yuVLolMEFKOFvgNTgkKwVOqEg1ambiDW53z5s1UnaKBW+Ph0dG9Ek7CZS0YaNttZgTAm1DoRTQMSvd4hlWBwLfNm1BHZNJ+maZMXEU9ItCfaLBB9ZHZcUMHv9c/jZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287519; c=relaxed/simple;
	bh=p/Fe4IkjbTXHdmr0L42TEXPNQ8l+qPKC07wX03LnPS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEzgItMJrqTYGJlRMcON50DJnAyYHg1dNO0rJkNw6DmLWuo7B5jCtwtT2zq3Pid8FgYGtvsElUkTNu6lCPp+3OaN7uR0oya1lM6WgSOfmotQcUUAZAwh7ySzRtV6ERx7IUKLHDFqwzx8+1kUMpiRpz6MiWmcfjLvXryzzxE1t0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6jcFpZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6jcFpZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC8A1F000E9;
	Sun,  9 Aug 2026 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786287517;
	bh=0/U0efVdmqMIqMl8Hq5vF1VeYCr6FcCuHiKgGyvxF+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h6jcFpZZSRkrx+cmJ0c6rEaamonMLK/Q7FDsLIpbu+lnjrggGg2bH/PQRV+RECqz2
	 7/SGQnbzEZIdrKryOClpghs2urYPHYX3LMdaRypQvj4yCeK5ZTXrFvFNx8uIlNxfUg
	 K/9yUe0l3rwOMJCNRFeqp+QSYinZhrdvnBGFRfyrABL07AD15QOv5QNeo73VGEJF2q
	 GQi+xthO6BM1iscIO/zIfhuW/NmXrbDeDpbLXOhh0cViNip1c1yEXFWKDUvlZHZHdO
	 OGX4acfLgzkbIIsUBGsaELXAS204j10vUbxigujsN2F7U1YY/19JWJ7UxQ2TjzGSrL
	 Z+QoxMq6IxMHg==
Received: by pali.im (Postfix)
	id 4B0917C6; Sun,  9 Aug 2026 16:58:36 +0200 (CEST)
Date: Sun, 9 Aug 2026 16:58:36 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Guillaume Nault <gnault@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Michal Ostrowski <mostrows@gmail.com>
Subject: Re: [RFC net-next] pppoe: remove session socket receive support
Message-ID: <20260809145836.5pqf2rgf574fjlds@pali>
References: <20260806091626.231225-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806091626.231225-1-qingfang.deng@linux.dev>
User-Agent: NeoMutt/20180716

Hello, I would like to point out that "no know open source
userspace implementation" does not have to mean that there cannot be
some closed source or not publicly available. But I agree that
probability is too low.

Anyway, could you describe what is this functionality (which is being
removed) doing? Or how to use it? From the code and description I have
not figure out how it is suppose to be used or for what kind of scenario
or use case can be it hypothetically used.

Would be nice to know what exactly is being removing and what userspace
applications cannot do after applying this change.

On Thursday 06 August 2026 17:16:24 Qingfang Deng wrote:
> No known userspace PPPoE implementation reads from an AF_PPPOX
> socket. In particular, pppd uses the socket only to establish a
> session and obtain a generic PPP channel with PPPIOCGCHAN. Packet I/O
> then uses /dev/ppp.
> 
> Before this change, packets received before PPPIOCGCHAN set
> PPPOX_BOUND were queued on sk_receive_queue. Since no known
> implementation consumed them, they remained there until socket
> destruction and unnecessarily consumed memory.
> 
> Pass every matched session packet directly to ppp_input(). On a
> successful connect, the channel is registered before the socket lock
> is released. Generic PPP can therefore queue early packets until
> userspace attaches /dev/ppp, preserving packets that arrive between
> connect() and PPPIOCGCHAN.
> 
> Replace pppoe_recvmsg() with sock_no_recvmsg(). Like PPTP, omit the
> poll callback because the socket no longer receives packets. Remove
> pppoe_destruct() because the receive queue is no longer used.
> 
> Assisted-by: Codex:GPT-5.6
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  drivers/net/ppp/pppoe.c | 50 ++---------------------------------------
>  1 file changed, 2 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index bf7414b46a26..e3d425943c76 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -350,23 +350,9 @@ static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct pppox_sock *po = pppox_sk(sk);
>  
> -	/* Backlog receive. Semantics of backlog rcv preclude any code from
> -	 * executing in lock_sock()/release_sock() bounds; meaning sk->sk_state
> -	 * can't change.
> -	 */
> -
> -	if (sk->sk_state & PPPOX_BOUND) {
> -		ppp_input(&po->chan, skb);
> -	} else {
> -		if (sock_queue_rcv_skb(sk, skb))
> -			goto abort_kfree;
> -	}
> +	ppp_input(&po->chan, skb);
>  
>  	return NET_RX_SUCCESS;
> -
> -abort_kfree:
> -	kfree_skb(skb);
> -	return NET_RX_DROP;
>  }
>  
>  /************************************************************************
> @@ -498,11 +484,6 @@ static struct proto pppoe_sk_proto __read_mostly = {
>  	.obj_size = sizeof(struct pppox_sock),
>  };
>  
> -static void pppoe_destruct(struct sock *sk)
> -{
> -	skb_queue_purge(&sk->sk_receive_queue);
> -}
> -
>  /***********************************************************************
>   *
>   * Initialize a new struct sock.
> @@ -523,7 +504,6 @@ static int pppoe_create(struct net *net, struct socket *sock, int kern)
>  	sock->ops	= &pppoe_ops;
>  
>  	sk->sk_backlog_rcv	= pppoe_rcv_core;
> -	sk->sk_destruct		= pppoe_destruct;
>  	sk->sk_state		= PPPOX_NONE;
>  	sk->sk_type		= SOCK_STREAM;
>  	sk->sk_family		= PF_PPPOX;
> @@ -921,31 +901,6 @@ static const struct ppp_channel_ops pppoe_chan_ops = {
>  	.fill_forward_path = pppoe_fill_forward_path,
>  };
>  
> -static int pppoe_recvmsg(struct socket *sock, struct msghdr *m,
> -			 size_t total_len, int flags)
> -{
> -	struct sock *sk = sock->sk;
> -	struct sk_buff *skb;
> -	int error = 0;
> -
> -	if (sk->sk_state & PPPOX_BOUND)
> -		return -EIO;
> -
> -	skb = skb_recv_datagram(sk, flags, &error);
> -	if (!skb)
> -		return error;
> -
> -	total_len = min_t(size_t, total_len, skb->len);
> -	error = skb_copy_datagram_msg(skb, 0, m, total_len);
> -	if (error == 0) {
> -		consume_skb(skb);
> -		return total_len;
> -	}
> -
> -	kfree_skb(skb);
> -	return error;
> -}
> -
>  #ifdef CONFIG_PROC_FS
>  static int pppoe_seq_show(struct seq_file *seq, void *v)
>  {
> @@ -1046,11 +1001,10 @@ static const struct proto_ops pppoe_ops = {
>  	.socketpair	= sock_no_socketpair,
>  	.accept		= sock_no_accept,
>  	.getname	= pppoe_getname,
> -	.poll		= datagram_poll,
>  	.listen		= sock_no_listen,
>  	.shutdown	= sock_no_shutdown,
>  	.sendmsg	= pppoe_sendmsg,
> -	.recvmsg	= pppoe_recvmsg,
> +	.recvmsg	= sock_no_recvmsg,
>  	.mmap		= sock_no_mmap,
>  	.ioctl		= pppox_ioctl,
>  #ifdef CONFIG_COMPAT
> -- 
> 2.43.0
> 
