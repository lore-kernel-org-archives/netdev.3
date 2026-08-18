Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89F282F1E;
	Tue, 18 Aug 2026 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069448; cv=none; b=ehGOXWIUpnyRDWWt3YQ2m7L5Lj4CIxgXEsW5slEJFY12DGFDSOIRZ+d7kJGg0PoKzJ+gla3iq0daLHyfypfUBsw1frJA41CvvnXRiKZxQbjAq/HWXcsSM+5uXCAXt5q8NC9qs3WTZ+l78kaSK0JrQ7PJ4SG4HncGN1m7V2hAJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069448; c=relaxed/simple;
	bh=7zfxpaB7k7YOdCOSe617FxL4y+on0DNd7XRW3TQbmdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoRxxoLKEpp5R7JA/Ux6Aw9t6NPDwdikOQ+nbbSe7UuHVA7bW3Kvy/SbLMnKGKyL69Nq2plTdav6uiDEG5rEm+3yPFE0VBOK6StAw11SJJHr4bQOlH3VOpUaoqircgHl1TlDQNZv7AEGJ4ziiuWlb/GpPWrzGoeTwMDeSoaiwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2177/WY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2177/WY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7382F1F000E9;
	Tue, 18 Aug 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069444;
	bh=8iIr8qy3JYxYu7QIB8ZwpnVs7iRZCgLe4d9Cte0dDNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G2177/WY5SEQnz4XOn92feFN3HF2yNMTAV6EIHUPoJFmF5ut+JfxcDSw41TZLObac
	 7JNWIJjTVH+sIkBOCQKd4UZvIzxnjI7QjgTMtyG90dPPYi/OnWKXZ2Xm5ULVTJeIRz
	 3lzhBHh9un0vI1W/MU5osiD9HxwpRiT8Fk2VdKlhZYpsLjrM4IxPAD2Q34MHggdSM5
	 oF6aM3pbnAvL8EIQdstvbgieX1joZc6D38n6XLgPevNerXw74lOggmvodKlLxRP5fw
	 aSpJ7jhuqISbC6BIaQUod0nCzwPFANm4etHkH7D/jl6n/YRWiM0fyzblyc1ur66NZz
	 diCTpDZiGlX1A==
Date: Tue, 18 Aug 2026 09:10:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v2 1/5] net: phy: split phy_probe() error paths
Message-ID: <20260818091042.5577d6ed@kernel.org>
In-Reply-To: <20260813132946.116176-2-xuanqiang.luo@linux.dev>
References: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
	<20260813132946.116176-2-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 21:29:41 +0800 Xuanqiang Luo wrote:
> +out_led_triggers:

the labels should include the verb

out_unreg_led_triggers:

> +	if (!phydev->is_on_sfp_module)
> +		phy_led_triggers_unregister(phydev);
> +
> +out_ports:

out_sfp_release:

>  	sfp_bus_del_upstream(phydev->sfp_bus);
>  	phydev->sfp_bus = NULL;
>  
>  	phy_cleanup_ports(phydev);
>  
> -	if (!phydev->is_on_sfp_module)
> -		phy_led_triggers_unregister(phydev);
> -
> +out_reset:

this one is fine

>  	/* Re-assert the reset signal on error */
>  	phy_device_reset(phydev, 1);
