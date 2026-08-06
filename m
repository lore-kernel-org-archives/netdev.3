Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE9480321;
	Thu,  6 Aug 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031917; cv=none; b=AjN7bMWdKGYs6W/e8SGu4edQjSRRheQtCDyGoYARGz3rHXOJurM5ry/KB4LcmgPpa6cCJ75himbQhq48+gpWNnGBiKIIZIS4MabsssP+1scsm26wAWah4k0yImfdLdUcDHl23+ap/mwlZnFZ98GGIrb/84qJNwIIfhpCqq91d9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031917; c=relaxed/simple;
	bh=25GZVt6r6uHR00ioUFInr0Tz5oVLKZsd7tTwsm7u4f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgKxzvLz8AgBWiDCU9nJ73lTxXbNqXJZC7yyzjzkgx4s28JzN83HICBdvmWI6Ws1uE+PzVCh4kZNMP0HoNMeF5fnEpWyXZigjd0iD9Ds0xf6rkqqbArllBnlo3LGz9O3YSpnyTPTL/+Ik3AyRjiJFNwP5KsD8L605DnFt2beuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gCGGIwEr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gCGGIwEr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dgmfbaoGdUMb9P229Ft+Kf+pUXbtQ7Nh7m79L8GZplo=; b=gCGGIwErge9fZgjj/KzBICBZHV
	D32yPw/o8v5fFjoQ2Z4K8RxDnfb5i34VYjGEy+Geqv/C9AmPUgDs5ARXxfb/skT6zJGkNgRXj5xEX
	Mr0vhlGu6DzslJ1xaidO6Bi1H7qeQQJ4W/cgSBEAJPtwNP64ROODqGyK5Tfh0KNUqY8tW7FfhBsVK
	DjYp1+UhjKGpvKuwONitBm7lFl8bSOFEtUiWlO0H1luKS5kbduacHtipxjK2JldVUlHB+T8vmQkxV
	w5KtSxLpbNEs688cVXYaR1wguUe9qJLq4QtjloGrVJkx4emaP8VNFtsSNNc05B6O/8vwOX06JWuT9
	qluzyD7Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1ws0U7-00Enwg-2x;
	Thu, 06 Aug 2026 15:58:20 +0000
Date: Thu, 6 Aug 2026 08:58:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] netconsole: reject enabling a target with
 no remote IP address
Message-ID: <anSvBeRT4vqq5uZV@gmail.com>
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
 <20260805-netcons_ipv6-v1-3-170a35b92da1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-netcons_ipv6-v1-3-170a35b92da1@gmail.com>
X-Debian-User: leitao

On Wed, Aug 05, 2026 at 10:33:03PM +0100, Gustavo Luiz Duarte wrote:
> The command-line path already requires a remote address, but if a user
> creates a dynamic target and enables it without setting a remote
> address, we currently try sending netconsole traffic to "0.0.0.0".
> 
> Refuse to enable a target if the remote address is unset.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> ---
>  drivers/net/netconsole.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 070bae7b4fd7..a41b0a5ce64f 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -471,6 +471,12 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
>  	int err;
>  
>  	rtnl_lock();
> +	if (nt->remote_ip.family == AF_UNSPEC) {
> +		np_err(np, "remote IP address not configured, aborting\n");
> +		err = -EDESTADDRREQ;
> +		goto unlock;
> +	}

Why not doing it  before the rtnl lock?
