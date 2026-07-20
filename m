Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702F42CAF1;
	Mon, 20 Jul 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557799; cv=none; b=TKaS26yBbZ/BPa6Vc5LV0rj+lK67oNoi0aOqlckIj4F7z0vT2DzXtNpChw3jp0V9JdbcDr5/hFpf/asruSv17dbdgPsKipiVBrhdLbMEfgXAj/lm2U0xJWtz8y78gJsrLGLa1wQ0ypBe9Q+JSa07o+7WNY32GRzY/OYrwpZEfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557799; c=relaxed/simple;
	bh=99yFqUUOkpx+mN7kBHmcIOHUVY6Terg4Te7dzKvX81s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teJNJJgwNjG0/n1h38FTaQAZCbL+r+9e9fMIMkc17JDmTExpGnZYaapIe9v3C1mKNTFDkzWLmXlMmh6uxTomzHMWYpm6jooq7lN7jdNh9dXl/qFjuK00cv5Wj6jhMidcvr5ynTeYkvpOLSj/cXxhHJeHGvhIFNRO936aKOFAazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HE47/hf1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HE47/hf1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9uJ9Av665dlyZ+eSq6PzHEgaGm/rN3N1ZejkkA+u4ts=; b=HE47/hf1rmOca15Gfh2qrllynm
	8BgCDVOe3rx7KQwf8G7DieOOQeV+Bc1GUb+V7ATteGsQw4GvKNq7LbjrnnH3USa3xveMprQdtL5Ht
	tm213aMsiPKmolMvFaWgW8r3knxdS+6soZmB9EBo9a7R+adOxt/0+Rx2iBnlKX+wOu2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlp02-00DH0j-Fi; Mon, 20 Jul 2026 16:29:42 +0200
Date: Mon, 20 Jul 2026 16:29:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minhong He <heminhong@kylinos.cn>
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	remi.denis-courmont@nokia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] phonet: check register_netdevice_notifier() error
 in phonet_device_init()
Message-ID: <dfeace82-f1d5-4dee-8b7f-4b4e38580c8f@lunn.ch>
References: <20260720070031.108248-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720070031.108248-1-heminhong@kylinos.cn>

On Mon, Jul 20, 2026 at 03:00:31PM +0800, Minhong He wrote:
> phonet_device_init() registers a netdevice notifier before calling
> phonet_netlink_register(), but does not check whether notifier
> registration succeeded. On failure, netlink setup still proceeds and
> init may return success without the notifier in place.
> 
> Also, the existing phonet_netlink_register() failure path called
> phonet_device_exit(), which runs rtnl_unregister_all() even though
> rtnl_register_many() already unwound any partial registration. Calling
> the full exit helper on a partial init is not correct.
> 
> Check each registration error and unwind only the steps that have
> succeeded so far.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
> v3:
> - Use goto-based unwind; do not call phonet_device_exit() on
>   phonet_netlink_register() failure (avoids rtnl_unregister_all()
>   after rtnl_register_many() already unwound).
> - Drop Fixes tag (theoretical init failure path; not suitable for
>   stable autosel).
> v2: https://lore.kernel.org/netdev/20260716101504.158387-1-heminhong@kylinos.cn/
> - On notifier registration failure, unwind only proc/pernet.
> v1: https://lore.kernel.org/netdev/20260713075212.431455-1-heminhong@kylinos.cn/
> 
>  net/phonet/pn_dev.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
> index ad44831d6745..f41322a12fb7 100644
> --- a/net/phonet/pn_dev.c
> +++ b/net/phonet/pn_dev.c
> @@ -350,16 +350,30 @@ static struct pernet_operations phonet_net_ops = {
>  /* Initialize Phonet devices list */
>  int __init phonet_device_init(void)
>  {
> -	int err = register_pernet_subsys(&phonet_net_ops);
> +	int err;
> +
> +	err = register_pernet_subsys(&phonet_net_ops);
>  	if (err)
>  		return err;
>  
>  	proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
>  			sizeof(struct seq_net_private));
> -	register_netdevice_notifier(&phonet_device_notifier);
> +
> +	err = register_netdevice_notifier(&phonet_device_notifier);
> +	if (err)
> +		goto err_pernet;
> +
>  	err = phonet_netlink_register();
>  	if (err)
> -		phonet_device_exit();
> +		goto err_notifier;
> +
> +	return 0;
> +
> +err_notifier:
> +	unregister_netdevice_notifier(&phonet_device_notifier);
> +err_pernet:
> +	unregister_pernet_subsys(&phonet_net_ops);
> +	remove_proc_entry("pnresource", init_net.proc_net);

It is good practice to undo in the opposite order to which it was
done. Sometimes there are dependencies, and things will break if you
tear them down in the wrong order.

It is also unusual to see two undo steps without a goto label between
them. Can proc_create_net() fail? Should the return value be tested
and cleanup done if it fails?

    Andrew

---
pw-bot: cr
