Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760553D812A;
	Wed,  7 Oct 2026 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363515; cv=none; b=c968AD+miHfJc4Q2LJQ+F/1KVft5SDWPP/uF8qBksqbpFhxUp1zGCFaPMpg1o70nNQraTS02BrRzr+5eX7hD0dyRcLaPep4mzW2FPB9cICALfpfHCjK7jqvkDyj0ntxpBV6lD1L99mWnvW+LitDBUFKqlM5eug0OZPkjhiuf71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363515; c=relaxed/simple;
	bh=q08rdZ3vOXEzVVRiBycbO7Wq7m1ZTqO5mAiKoAuBmKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrOo/VAQc/cRZydvhrtAJviX36o3MwgQ9m7t9sga61oi4F3DvAxrWf9XCN5iyZiGhhpsqwGMDqAS/ut2Ne8JP0KuNmvVIjJ/pMIAUVe2di09UqgbG3IwwCckB8Cg8L7bwFNz26TJuGwXcAjRYoJeHVjLZZzZwtbPgOdP0jF8J/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HphPBdON; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HphPBdON"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=apMsyzvREPGcbRioTUNx1bwvtoun0JTuglsS9LHwric=; b=HphPBdONNvFlva9mcCQThwAa4a
	nI4QlMNZ9+R9E97yHBMI5U1EDrVj7WIO/MJsqDYQoMG9H2CvZHNhoIBgoo3zG4rhGc3R80d5UPF/o
	j3dT7F8nANmeQ5N7BzouEik6E9x2uJWVmxUMGJmmwL3wJrFBN565QbnthGnURmopzQ/gGBrhzM+r7
	8h0ELLP0MUGi8gFp9vguGYcYj1HZKUpwLB3zBjAIEy10eLVzIfKhcyCV4D2Tro3YG+sX+9wCBtk+8
	PItsIprK/ovRi897QXaRU1htHG4lAyNwtUMwea6ucWs+Fa1D9VRp4MjfoB+grIIeLtkD9dOjQWzqs
	pnvIQ2Cg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xENTk-004dDg-12;
	Wed, 07 Oct 2026 08:58:24 +0000
Date: Wed, 7 Oct 2026 01:58:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] netconsole: read np.dev under the RTNL in
 local_mac_show()
Message-ID: <asYJRc4mU1qUrdgQ@gmail.com>
References: <20261006-netcons-fixes-v2-0-ca652d55fd4a@gmail.com>
 <20261006-netcons-fixes-v2-2-ca652d55fd4a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-netcons-fixes-v2-2-ca652d55fd4a@gmail.com>
X-Debian-User: leitao

Hello Gustavo,

On Tue, Oct 06, 2026 at 07:21:26PM +0100, Gustavo Luiz Duarte wrote:
> local_mac_show() loads nt->np.dev and dereferences it with no lock. It
> can race with the interface going away and netconsole_netdev_event()
> eventually calling netdev_put() and freeing the device before we
> dereference it, leading to a UAF.

Thanks for the fix.

> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -888,10 +888,17 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
>  
>  static ssize_t local_mac_show(struct config_item *item, char *buf)
>  {
> -	struct net_device *dev = to_target(item)->np.dev;
>  	static const u8 bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> +	struct netconsole_target *nt = to_target(item);
> +	int ret;
>  
> -	return sysfs_emit(buf, "%pM\n", dev ? dev->dev_addr : bcast);
> +	/* Hold RTNL here so netconsole_netdev_event() doesn't tear down np.dev
> +	 * from under us.
> +	 */
> +	rtnl_lock();

Same idea as Eric suggested earlier, this might be doable without having
the heavy RTNL, but using netconsole's locks

--breno
