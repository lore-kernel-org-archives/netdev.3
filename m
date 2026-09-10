Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714F3AB292
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789075194; cv=none; b=oo9C4eRNj1iDyWA5pRhk7KHqKZg/yb2WCQyC0Q9/9nfKCrEVe7oTP5EutEI4fKWZRVuaYEqqL9X8Xc82yMKHOU7slbJHvGyRfqhiiJ+zOGOHP9Z+A3s7BZslNagloTkpM/SvuUtak6LCX3oZPDD9RtTKVNwePj61RtU8JAOSGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789075194; c=relaxed/simple;
	bh=0aH1/xZq6BqoJ8NBok0Fya68fVfmA8ZB4sdGtLgyxas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvvfnDEe/xbwqyfjXgpVGAu4+9CMmTDf12F+Ues8hQMFpKr5pGxCN/DCE59eG5KoxPF0oUNwqGPolSfB2Qnc9WO8JMLsSDT3KberI9o5SBaPc+B8/B7cuF+NXksk2PuI+MuXrpFhE8TQW/cn6tDEsjNUpq2wAN0OSsRf5Xp9HUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rowc8lce; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rowc8lce"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965683e9e9so96622a91.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789075182; x=1789679982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u1rqc5jPkp4qWs7zOMQ/40kpJI2gBjFB0iGuKAIdw1E=;
        b=Rowc8lcevd/wERc/j0B+/EZnNBqPzlzXXHuaSQETM0R8azx35V+0fkb7kUe/JkCuI+
         aL/uqFD3M8fSe7R0CvlHJO26ZeLp4QPC6ttRcdiwBQ15+ZSORiWVcwoG/pw7PFyh2jtT
         fOzLf83G6hosKeWYkcYPB/MzTptXgsaQClTNSxwSCVW+lddxHmm72Hfv17LGe0oPWGkc
         0u3/Bhhz7HpbFFkq28avgX6psamoxh5e37DQN0BWYcNPRpB85zjLFpNYxxaMcls+6cpK
         SSkGn4MHP5X2lCY6t1Vcd2/C1IV308Qk2lBnx/Nyehu0tpW5x21gIRcMydUUd+9DPKg1
         ST1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789075182; x=1789679982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u1rqc5jPkp4qWs7zOMQ/40kpJI2gBjFB0iGuKAIdw1E=;
        b=gIyaxbY6evqX1kxzUIUlBFyVzHozpBn87g+gjLTBspeELWmDhCxkoIuUMwFqvPjS53
         cI8ywMFd4Kj7pwZJa+tAamsTVAQEtM6bbTJ4YF+efGlWjMJSB6MYl76mI8BWUL9ptSV3
         FhIKJJAfwbT0QwMRVk+jJDeGz6xrHFNLwTWAoj4SnecWUnT8v4W2IRaTxIlvW6Rvh6qv
         LhR4tFJyVEXP1zYy1tE8cRKk81tIRvLtg9VNUE+x+W17D2yK1LTThVvL2ZN8l0nkdpeW
         fFhXstapuFraL1VkglGZKxDkP9Q/vXXxZ5B2UX+xin1vl29Vk67+XmjYdsjCVb/ttjA4
         y+sw==
X-Gm-Message-State: AFuF++l8h7CHCqDRCuqBuR0YfR+db+sLaws/r+EQOlYXb01ALJolFMHD
	WwduXhG+34ZByrkvW7xuVGDaZiT4DgK/wX9GtvUcKFu8byMBY+9LNiEn
X-Gm-Gg: AYBFou1hF7UO5adPkdPPWqxB+TDVrNZ+YNui/Vc4BP80MyEj05af9j5nrmvtsOOmmOz
	KepKwJGLE0VAbKNc4VDo+LSWAAKnk60Hslruc1j8FPHoscuQeAkTs19Zg/21w24sGB8NGNcxlvt
	xWlGlQp+40D4S/3cdKGMsN0gjMJYbQ7yexJEcUQ9CnEnBTCvozZTwlOLXBQqvHK1URknmTvWvhr
	u5y8qo/wlypUSNzPwMwcP9+BpYgqRuXJgeGcqc6eusUSCdHPoiT/o7rwiq5EDUEXkLaUrEH1UgQ
	gT0gQaslY4319YbHHCqI9RCfykULvyYUrcgBDW198PrcmtJi36I7AKyA8+/mEtLGaaeUb9PaP+o
	Q0Pyf7E/5M4vIUio4AM1pn5A3aQfJqJS156/Thp8u/CG+y03cjwKlmIGroK2PVec4o1aAM3OMZP
	fKeV19ZEgu0DUQC/bKIEsfksgXuhjd0pEll2jLINjyLTgeaB7w6m6m2k7wZ0bQvwKN
X-Received: by 2002:a05:6a00:4fc9:b0:846:bc60:5bf7 with SMTP id d2e1a72fcca58-86b31401661mr1235255b3a.6.1789075181652;
        Thu, 10 Sep 2026 14:19:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb760sm146528b3a.46.2026.09.10.14.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:19:41 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:19:35 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Richard Gobert <richardbgobert@gmail.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Jeff Layton <jlayton@kernel.org>, Qi Tang <tpluszz77@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13 net-next] net: inet: relocate ip_generic_getfrag
 and guard IPv4 socket logic
Message-ID: <aqMeeDnj4pcuvz7-@devvm7509.cco0.facebook.com>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-4-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910144914.8025-4-fmancera@suse.de>

On 09/10, Fernando Fernandez Mancera wrote:
> To enable compiling the INET subsystem without IPv4, shared generic
> utilities must be relocated and IPv4 socket logic must be guarded for
> CONFIG_IPV4.
> 
> This patch moves the generic ip_generec_getfrag() from ip_output.c to
> af_inet.c. It also introduces CONFIG_IPV4 guards around af_inet.c to
> reject IPv4-specific ioctls, protocol registrations and bind requests.
> The same guard is added to reject IPv4-mapped IPv6.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv4/af_inet.c   | 96 +++++++++++++++++++++++++++++++++++++-------
>  net/ipv4/ip_output.c | 18 ---------
>  net/ipv6/af_inet6.c  |  5 +++
>  net/ipv6/datagram.c  | 12 ++++++
>  4 files changed, 99 insertions(+), 32 deletions(-)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index d9421ac38d78..b0c48ba544bf 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -129,6 +129,28 @@
>  int disable_ipv6_mod;
>  EXPORT_SYMBOL(disable_ipv6_mod);
>  
> +/* Keep the function here for now as it is generic, it should be moved
> + * to a common L3 place
> + */
> +int
> +ip_generic_getfrag(void *from, char *to, int offset, int len, int odd, struct sk_buff *skb)
> +{
> +	struct msghdr *msg = from;
> +
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		if (!copy_from_iter_full(to, len, &msg->msg_iter))
> +			return -EFAULT;
> +	} else {
> +		__wsum csum = 0;
> +
> +		if (!csum_and_copy_from_iter_full(to, len, &csum, &msg->msg_iter))
> +			return -EFAULT;
> +		skb->csum = csum_block_add(skb->csum, csum, odd);
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(ip_generic_getfrag);
> +
>  /* The inetsw table contains everything that inet_create needs to
>   * build a new socket.
>   */
> @@ -425,8 +447,10 @@ int inet_release(struct socket *sock)
>  		if (!sk->sk_kern_sock)
>  			BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk);
>  
> +#if IS_ENABLED(CONFIG_IPV4)
>  		/* Applications forget to leave groups before exiting */
>  		ip_mc_drop_socket(sk);
> +#endif
>  
>  		/* If linger is set, we don't return until the close
>  		 * is complete.  Otherwise we return immediately. The
> @@ -478,6 +502,7 @@ EXPORT_SYMBOL(inet_bind);
>  int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
>  		u32 flags)
>  {
> +#if IS_ENABLED(CONFIG_IPV4)
>  	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
>  	struct inet_sock *inet = inet_sk(sk);
>  	struct net *net = sock_net(sk);
> @@ -570,6 +595,9 @@ int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
>  		release_sock(sk);
>  out:
>  	return err;
> +#else
> +	return -EAFNOSUPPORT;
> +#endif
>  }
>  
>  int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
> @@ -962,18 +990,24 @@ EXPORT_SYMBOL(inet_shutdown);
>  int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  {
>  	struct sock *sk = sock->sk;
> -	int err = 0;
> -	struct net *net = sock_net(sk);
> +#if IS_ENABLED(CONFIG_IPV4)
>  	void __user *p = (void __user *)arg;
> -	struct ifreq ifr;
> +	struct net *net = sock_net(sk);
>  	struct rtentry rt;
> +	struct ifreq ifr;
> +#endif
> +	int err = 0;
>  
>  	switch (cmd) {
>  	case SIOCADDRT:
>  	case SIOCDELRT:
> +#if IS_ENABLED(CONFIG_IPV4)
>  		if (copy_from_user(&rt, p, sizeof(struct rtentry)))
>  			return -EFAULT;
>  		err = ip_rt_ioctl(net, cmd, &rt);
> +#else
> +		err = -EOPNOTSUPP;
> +#endif
>  		break;
>  	case SIOCRTMSG:
>  		err = -EINVAL;
> @@ -981,18 +1015,26 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  	case SIOCDARP:
>  	case SIOCGARP:
>  	case SIOCSARP:
> +#if IS_ENABLED(CONFIG_IPV4)
>  		err = arp_ioctl(net, cmd, (void __user *)arg);
> +#else
> +		err = -EOPNOTSUPP;
> +#endif
>  		break;
>  	case SIOCGIFADDR:
>  	case SIOCGIFBRDADDR:
>  	case SIOCGIFNETMASK:
>  	case SIOCGIFDSTADDR:
>  	case SIOCGIFPFLAGS:
> +#if IS_ENABLED(CONFIG_IPV4)
>  		if (get_user_ifreq(&ifr, NULL, p))
>  			return -EFAULT;
>  		err = devinet_ioctl(net, cmd, &ifr);
>  		if (!err && put_user_ifreq(&ifr, p))
>  			err = -EFAULT;
> +#else
> +		err = -EOPNOTSUPP;
> +#endif
>  		break;
>  
>  	case SIOCSIFADDR:
> @@ -1001,9 +1043,13 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  	case SIOCSIFDSTADDR:
>  	case SIOCSIFPFLAGS:
>  	case SIOCSIFFLAGS:
> +#if IS_ENABLED(CONFIG_IPV4)
>  		if (get_user_ifreq(&ifr, NULL, p))
>  			return -EFAULT;
>  		err = devinet_ioctl(net, cmd, &ifr);
> +#else
> +		err = -EOPNOTSUPP;
> +#endif

(passing by comment)

Don't we have a coding style rule to avoid ifdef conditional in C code?
Should we add some new devinet4_ioctl/etc wrappers that we can conditionally
compile out in the headers?
