Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274E480DFF;
	Thu,  6 Aug 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031768; cv=none; b=E1P3526T+mFTPHSAzJC+FCyHXLw9b2YggXdirBKKYF5cPJUBuOoiW9TfsEScfnE7IQ8bO+sSQ3gie7PgevwXUXFNsyAW1ldaHiQqs7h+BDZN7ry8lVqvVmfjwgknmHbBp4Bni3l6ZthtvxTIFLM9EZ6Bzrd0/GvfCiB6LMiGZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031768; c=relaxed/simple;
	bh=wE/k8/WNv6BvebQn60khOnn2oOWf8YksLCH+ImDrJ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4GXJT0nd+NiQgGTPoO78bhRVdjbzR5c3L5L7ASK8rtB9vqsAOybDZktxBjgsKUd2OwhCt4MZsaM90vmjUmQW5KuC/iDwjoyUbs4iX4PGIZwUZutjfUkzT7abL/lRFHBJD4xTOXxR7TBmGw4Va+uebXXxiEk5eMpUiLgBVEI8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VuLcavTz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VuLcavTz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=AP0NfLw9tSBKwujvAY387+Ofdj5l95CRK91fcfrKpEA=; b=VuLcavTzuxI9bqsqdikQRcGsbz
	jr4UyMSI8Pulf23UEpjr7zLaoCKvQ0bxUo7LM4lM8lw732kB9I6TGQ/25uyqL+Ta2aJdOJQAXDwiZ
	vt/kwMK26GVBThjxW1Sd5h8LRFu6dVgjri5SUj//100SChy4iuidNPHvbRYlDOg8gJ5KcL7DEx8q+
	v6e5CYHpUz7wBIM5OmGINXuX44nNB6Ey0QNmc4Gscsv2RYSGeeUy6IWSEI4HiWEN9NyqtZTJ9GL9f
	8dfU8LOzgBJJ1XleUycW3vfjSDUvrS4/mVJroTOsU7U6/gP4iVtLSAY0o6937W/6FgccTJhsK3SsL
	Gg3wW0SQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1ws0Rn-00EnvK-1s;
	Thu, 06 Aug 2026 15:55:55 +0000
Date: Thu, 6 Aug 2026 08:55:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] netconsole: use the address family instead
 of the ipv6 flag
Message-ID: <anSte7-WkTYU4MnC@gmail.com>
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
 <20260805-netcons_ipv6-v1-2-170a35b92da1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805-netcons_ipv6-v1-2-170a35b92da1@gmail.com>
X-Debian-User: leitao

On Wed, Aug 05, 2026 at 10:33:02PM +0100, Gustavo Luiz Duarte wrote:
> Now that we have the address family in inet_addr, use that and remove
> nt->ipv6.
> 
> We no longer need netcons_local_ip_unset() to check that all bytes are
> zeroes, as that is now denoted by (family == AF_UNSPEC).
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> ---
>  drivers/net/netconsole.c | 82 ++++++++++++++----------------------------------
>  1 file changed, 23 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index d615a9256787..070bae7b4fd7 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -181,7 +181,6 @@ enum target_state {
>   *		local_mac	(read-only)
>   * @local_ip:	Source IP address of the target (read-write).
>   * @remote_ip:	Destination IP address of the target (read-write).
> - * @ipv6:	Whether the target addresses are IPv6 (read-write).
>   * @local_port:	Source UDP port of the target (read-write).
>   * @remote_port: Destination UDP port of the target (read-write).
>   * @remote_mac:	Destination ethernet address of the target (read-write).
> @@ -213,7 +212,6 @@ struct netconsole_target {
>  	bool			release;
>  	struct netpoll		np;
>  	struct inet_addr	local_ip, remote_ip;
> -	bool			ipv6;
>  	u16			local_port, remote_port;
>  	u8			remote_mac[ETH_ALEN];
>  	/* protected by target_list_lock; +1 gives scnprintf() room for its
> @@ -463,23 +461,6 @@ static int netcons_take_ipv4(struct netconsole_target *nt,
>  	return 0;
>  }
>  
> -/*
> - * Test whether the caller left nt->local_ip unset, so that
> - * netcons_netpoll_setup() should auto-populate it from the egress device.
> - *
> - * nt->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
> - * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
> - * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —
> - * doing so would misclassify a caller-supplied address as unset and
> - * silently overwrite it with whatever address the device exposes.
> - */
> -static bool netcons_local_ip_unset(const struct netconsole_target *nt)
> -{
> -	if (nt->ipv6)
> -		return ipv6_addr_any(&nt->local_ip.in6);
> -	return !nt->local_ip.ip;
> -}
> -
>  static int netcons_netpoll_setup(struct netconsole_target *nt)
>  {
>  	struct net *net = current->nsproxy->net_ns;
> @@ -525,16 +506,13 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
>  		rtnl_lock();
>  	}
>  
> -	if (netcons_local_ip_unset(nt)) {
> -		if (!nt->ipv6) {
> -			err = netcons_take_ipv4(nt, ndev);
> -			if (err)
> -				goto put;
> -		} else {
> +	if (nt->local_ip.family == AF_UNSPEC) {
> +		if (nt->remote_ip.family == AF_INET6)
>  			err = netcons_take_ipv6(nt, ndev);
> -			if (err)
> -				goto put;
> -		}
> +		else
> +			err = netcons_take_ipv4(nt, ndev);
> +		if (err)
> +			goto put;

nice, that is much clearer. 

>  		ip_overwritten = true;
>  	}
>  
> @@ -716,22 +694,22 @@ static void netconsole_print_banner(struct netconsole_target *nt)
>  	struct netpoll *np = &nt->np;
>  
>  	np_info(np, "local port %d\n", nt->local_port);
> -	if (nt->ipv6)
> +	if (nt->local_ip.family == AF_INET6)
>  		np_info(np, "local IPv6 address %pI6c\n", &nt->local_ip.in6);
>  	else
>  		np_info(np, "local IPv4 address %pI4\n", &nt->local_ip.ip);

Any chance it can be UNSPEC?

>  	np_info(np, "interface name '%s'\n", np->dev_name);
>  	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
>  	np_info(np, "remote port %d\n", nt->remote_port);
> -	if (nt->ipv6)
> +	if (nt->remote_ip.family == AF_INET6)
>  		np_info(np, "remote IPv6 address %pI6c\n", &nt->remote_ip.in6);
>  	else

Same question

> @@ -755,7 +733,7 @@ static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
>  	    in6_pton(str, len, (void *)&addr->in6, -1, &end) > 0 &&
>  	    (!end || *end == 0 || *end == '\n')) {
>  		addr->family = AF_INET6;

Why not setting family for for IPV4? In 

        if (in4_pton(str, len, (void *)addr, -1, &end) > 0 &&
            (!end || *end == 0 || *end == '\n'))
                return 0;
