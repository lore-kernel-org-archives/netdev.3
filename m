Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56430C619
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619678; cv=none; b=Iw+ZMp8nxIYzxV6LM5TyzEzLipRc2LjebIwj6iDoC5fZ6azyrruAfnwxlakac8kD4XXN/Dn8N7SdS+TWdT9QgNhalEbUmUEFT+eIRQRYRi4zIfH7EHyLJde1bTaAcoTXc6Ze/tWTcvVB6LnR0kObyHyTiMuUw49IpIO419LqLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619678; c=relaxed/simple;
	bh=Iz1jUJ8PYkI/xIvrRo6nkzRb6tq0Gz7ryEZH18pbLJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZ0ATfbMJYui9vYwMdSCK9JXsn+Dah/j8EkvlT72t2oQFjD/IKI1LRfDp9BjkVJzKoAI0s7yhaJfb0eqHOwpIRz14A2VTWuI25QALBmq5AFPzrPyn9S1ZeNHin85xQaDPWKw9SNqkYdNpa/rpTVyCG/2ObFRPMIQnaHnd34MPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0KBFjGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0KBFjGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA991F000FF;
	Mon, 28 Sep 2026 18:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790619676;
	bh=Femqy5YucPhKQtqlHfsFg2683UcZE2IuR7plxOthRT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c0KBFjGfKbkN3SBEKLIX2ulglV6LjRzVevSsqhBRza7NAYcJoUj1gjQh300eJOpdA
	 /UwaeurUKzAbn8c/BrMNEq14kK1pjwpvQ6XifQmeKM2IOwYM70ocWnnh+KSgFx3LfK
	 I823blrAqNti6yYOPwhAzMXQACF9oW8RRgFb9Gn82FSpSnKVPGD4+3VSG7We0jYMxG
	 /lQu1FbGJYVDP+jj0dgTcwZlp7Y3ObQ1GlFkdTNSsKSbOK6AzLm82CdcrxVPqPqPks
	 kJIcKgaRdmV3Na3PU7utz3EEmxcPTP5WC2I8HYOpPtYH6Dqq8Qeu/gIzpiaLuLsxW2
	 LKGLvW+xYlHRA==
Date: Mon, 28 Sep 2026 11:21:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, sdf.kernel@gmail.com
Subject: Re: [PATCH net-next v2 1/2] net: use two lockdep classes for the
 netdev instance lock
Message-ID: <20260928112115.18a9d249@kernel.org>
In-Reply-To: <CANn89iLdVkThwG0A3tNTd57FdBSNk6xgp0p26f43u3FOBBYnww@mail.gmail.com>
References: <20260926041832.1649675-1-kuba@kernel.org>
	<CANn89iLdVkThwG0A3tNTd57FdBSNk6xgp0p26f43u3FOBBYnww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 09:08:16 +0200 Eric Dumazet wrote:
> >         mutex_init(&dev->lock);
> > +       /* see also netdev_set_instance_lock_class() */
> > +       lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);
> >         netif_rx_mode_init(dev);
> >
> >         dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;  
> 
> Some virttual drivers (like  tun and wireguard) do not use yet
> netdev_lockdep_set_classes(),
> I'm not sure if they eventually will.
> 
> We might ease their future request_ops_lock = true conversion by calling
> netdev_set_instance_lock_class(dev) directly inside register_netdevice()
> 
> -> No EXPORT_SYMBOL_GPL(netdev_set_instance_lock_class) would be needed.  
> In fact netdev_set_instance_lock_class couldd be static in net/core/dev.c

Ack, maybe I lazied out on this one a little. I wasn't sure what the
consequences are of not setting the class before the first lock use.
I _think_ I've seen a splat at some point when I did that.

I will investigate further if I need to respin
