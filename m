Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACB31E83E
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722282; cv=none; b=Dft+MuquWLNybRanxrTtUI09wEBoTR7N9BEt9geAUYMBKhSL6x/Z06FmGZGVReX9FeGT/DoGo72STL5DtdDMhH0Dl6wBlybhtqMOMhGZQv6j+p8geYWEnblpVV4JQN0ud/TmA3S1+K54WlfTSOik4TVFm1n8nhM1+C7KgzfmyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722282; c=relaxed/simple;
	bh=Qiq5esm/Mx4JVoyTA0h8GrvxsusoyadDVsrzOrZHrrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4yEOrJW7DPqQ/m0HVi75imej/0ZesE7e3RVK/H0yXQbE+aqndmGmtHx0gA2Yh8VSUQ7CY8e0FOhC11XFfN30U+AOdCtKkKjKlNOIGePXRniyffy5iswkqCZwg1OmCMPjCqCzObB15eyDZDJ9U6m2CEyQj+Pjw4UP+ST93WrSN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnXAumKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnXAumKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D40C2BCB3;
	Thu, 14 May 2026 01:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722281;
	bh=Qiq5esm/Mx4JVoyTA0h8GrvxsusoyadDVsrzOrZHrrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qnXAumKvPQUgT3E/RpaKNnneH2AcCIfRlYRqmV8xhiJcK84ZxkA6bKalS1+B5IWMp
	 PAFqRSiE5XVXY933YYVtq0PxAH0GklcagPks80RwHWHbEbYMLsV+uQ5OPjM+TH7d0h
	 CkR2Op2df8R+YkAJMpPT6HgSKmZVKO0SjHIqCmlbQxw9dGnFjLj466JLlObxiWO9c9
	 UOI3eFuxiS6nll6Px+aQLOESMwuok2+lT95iZQpS2+4qGQr9vFAXiK7f0PneyaqXDV
	 trwZuvCcqaL5s4Kc1Fxk/Nwanwo29V8jTdCqVLS5lEYM0dhIFF1lRFL05MCqJceIvu
	 Y470C4ks6TIVA==
Date: Wed, 13 May 2026 18:31:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Wei Wang
 <weibunny@fb.com>
Subject: Re: [PATCH v14 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
Message-ID: <20260513183120.4ccc0acb@kernel.org>
In-Reply-To: <20260508042611.130945-3-weibunny.kernel@gmail.com>
References: <20260508042611.130945-1-weibunny.kernel@gmail.com>
	<20260508042611.130945-3-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 21:26:07 -0700 Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
> 
> The main purpose of this cmd is to be able to associate a
> non-psp-capable device (e.g. veth or netkit) with a psp device.
> One use case is if we create a pair of veth/netkit, and assign 1 end
> inside a netns, while leaving the other end within the default netns,
> with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
> With this command, we could associate the veth/netkit inside the netns
> with PSP device, so the virtual device could act as PSP-capable device
> to initiate PSP connections, and performs PSP encryption/decryption on
> the real PSP device.

> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -37,8 +37,18 @@ struct mutex psp_devs_lock;
>   */
>  int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin)
>  {
> +	struct psp_assoc_dev *entry;
> +
>  	if (dev_net(psd->main_netdev) == net)
>  		return 0;
> +
> +	if (!admin) {
> +		list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
> +			if (dev_net(entry->assoc_dev) == net)


Would

	if (psp_has_assoc_dev_in_ns(psd, net)) ?

work here?

> +				return 0;
> +		}
> +	}
> +
>  	return -ENOENT;
>  }

>  static struct psp_dev *
> @@ -79,18 +147,58 @@ static int __psp_device_get_locked(const struct genl_split_ops *ops,
>  	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
>  }
>  
> +/*
> + * Admin version of psp_device_get_locked() where it returns psd only if
> + * current netns is the same as psd->main_netdev's netns.
> + */

this..

>  int psp_device_get_locked_admin(const struct genl_split_ops *ops,
>  				struct sk_buff *skb, struct genl_info *info)
>  {
>  	return __psp_device_get_locked(ops, skb, info, true);
>  }
>  
> +/*
> + * Non-admin version of psp_device_get_locked() where it returns psd in netns
> + * for not only psd->main_netdev but all netdevs in psd->assoc_dev_list.
> + */

.. and this belong in previous commit. But TBH they seem unnecessary.

>  int psp_device_get_locked(const struct genl_split_ops *ops,
>  			  struct sk_buff *skb, struct genl_info *info)
>  {
>  	return __psp_device_get_locked(ops, skb, info, false);
>  }

> +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_dev *psd = info->user_ptr[0];
> +	struct psp_assoc_dev *psp_assoc_dev;
> +	struct net_device *assoc_dev;
> +	struct sk_buff *rsp;
> +	u32 assoc_ifindex;
> +	struct net *net;
> +	int err;
> +
> +	if (psd->assoc_dev_cnt >= PSP_ASSOC_DEV_MAX) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Maximum number of associated devices reached");
> +		return -ENOSPC;
> +	}
> +
> +	net = psp_nl_resolve_assoc_dev_ns(psd, info);
> +	if (IS_ERR(net))
> +		return PTR_ERR(net);
> +
> +	psp_assoc_dev = kzalloc_obj(*psp_assoc_dev, GFP_KERNEL);

nit: I think GFP_KERNEL is implicit if flags are not specified.

> +	if (!psp_assoc_dev) {
> +		err = -ENOMEM;
> +		goto err_put_net;
> +	}

