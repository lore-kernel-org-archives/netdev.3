Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99334327BFA;
	Thu,  6 Aug 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031388; cv=none; b=SShB34UQ1zatNcQJoIJzCvBTI9PS/5g+qVbz1q5+8xs7ZBQiTo9GLYITIjru3BPYZoFqZmbrQj9UfuOkA3a0ZtO3bcXvsnad5Wbm2XBYAXABYCbOuoVU2VDp2M8wtmnhmW7D8gYyK7EBC2mUZkDQpo/zvlPHi+0CQ33AGMgl0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031388; c=relaxed/simple;
	bh=LGZ2jVEFcx8aS5UsAAih2KUk0uQWAE+9ks51fuZhAA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfP4bucCIBL4ckSz2qVy1kZARBIWfYrMyvVbz9hsPQevSb+z3L4nnO05Ngx1EFbWtbCmOyJUIueGa3BoFe81KPibf8qaFwspYoqr8guDwY5dmdXukdFmvuFd/Fj4M28kfRUHgUziE3QESCSMRquCuIGJVgR8CAWuGa7nKyMdzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=i2rrr0BA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="i2rrr0BA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cNcS7zzKdlrVhy1rc5YbX04lit0mptMog2vwKJandMU=; b=i2rrr0BAJOTmLlb2LUiQO0kY7J
	FwqPCPRBYK3q/Rya0hDJJZ7HfICDaVsVro0jZSFXKWWWt/BUOfyEKIT9NArNUVEYwJOXPMc+5wnYu
	3JdTWkZnE5GI9gY7Aa+4PP1GyxDer5AEoTIWRk46N9IT50n5v3Ny79M20HpyY+DSmz1eoLY5vTnJl
	99V6hjzRbMb33uX29QEwQcAu1AD1lkykQewHPm5O8wcfAMQQLDMwgjVpyiFhWPDujMYDCwhfi9/LB
	fiNfB3wQp1mQ2j0fUpBkK7i90Wump2rET6RoJrE+FzuNkkscz4vR99cDe76h9RCQQVygGY2lDx85E
	9E2qMSAQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1ws0Lh-00EnkK-17;
	Thu, 06 Aug 2026 15:49:37 +0000
Date: Thu, 6 Aug 2026 08:49:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] netconsole: add an address family to struct
 inet_addr
Message-ID: <anSsOVuekqtrHDbA@gmail.com>
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
 <20260805-netcons_ipv6-v1-1-170a35b92da1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-netcons_ipv6-v1-1-170a35b92da1@gmail.com>
X-Debian-User: leitao

On Wed, Aug 05, 2026 at 10:33:01PM +0100, Gustavo Luiz Duarte wrote:
> @@ -731,7 +733,7 @@ static void netconsole_print_banner(struct netconsole_target *nt)
>  /* Parse the string and populate the `inet_addr` union. Return 0 if IPv4 is
						    ^-> there is no more union.

I think there are other references for union that needs to be updated as
well.

> +static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
...
>  	return -1;

Should the failure path set addr->family = AF_UNSPEC?

> +++ b/include/linux/netpoll.h
> +struct inet_addr {
> +	/* Address family: AF_UNSPEC when unset, else AF_INET or AF_INET6 */
> +	u8			family;
> +	union {
> +		__be32		ip;
> +		struct in6_addr	in6;
> +	};
>  };

Since a1116396476f6 ("netconsole: move local_ip/remote_ip/ipv6 to
netconsole_target") struct netpoll has no address member, and netconsole
is the only user left in the tree:

    drivers/net/netconsole.c:   union inet_addr         local_ip, remote_ip;
    drivers/net/netconsole.c:static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)

Since you touched it, can you move it to netconsole headers, please?

--breno
