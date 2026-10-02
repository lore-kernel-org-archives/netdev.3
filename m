Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC30137750;
	Fri,  2 Oct 2026 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900721; cv=none; b=W14Cu+7lGeFry7aMAA8hLD5+QqrEepbx1QhCk46yJV5IfK8WxC/V2Fh2p0keBKwOLiUNtHBXIV1He34x1FrGVhsSzRZGOT9HbilFjkOcda5F4+YQv8Flwwa3WW/Y1Oghe0Op7IayuzlxBq/ZZQIeIYb9k/tMFZDnoZvs+Bw8v6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900721; c=relaxed/simple;
	bh=o0G4QQhfH6bBXTjTTBOeRVLoRr4OhOyegueK7UiHvGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeFVlDK3YImfwKXYBkgnAW6Xzq5kk6QuN4Yj3TO4pmZE/Qj6zGC/AEWAHRu7mjgaiPJgJ2ZwR6iTYGVhb8Dwwu+PHHiQ4qI5EdfDtsf/LqD0ejLsk406Jg9mi/K3b7fjPezLpZ/nMdcyc+bXcx2Oodyl8SSj9heknwVnDcV5ER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGjeAjc2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGjeAjc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D1B1F000FF;
	Fri,  2 Oct 2026 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790900719;
	bh=Hne+mQG+mQK+ZGWBZJ5U1PF+GJPaQCXm9zzGpjSGBH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IGjeAjc2H7KdbAfY1n7BRY7fWK+7TL6JDoeX1ZWjLlfCKWMZrdfibdVExR2x7ywzb
	 U2T4frBicscJKd9vmjDjGNcC4eF4fS0JD/QerZ2UmR1QK4S5/VQvLtGOrHbXM3sleA
	 C3NHg/Iu+ICzSbc5FNwxs8cyHv/J7cokfbzUux2gdu+NgDYbxCUnkhSOaziaYGvE8z
	 PLk1u1gqILS0QUWJi0T2E6yZAd7zu5oXIWGIF4GE3ApQQG7TMzQH9GawJJJban44/D
	 Swl8kBaxpyx84RXOge9Ju1H2rjNCUoit4xAnmsEWQaDTGOjG2BP5+x1WZNuKoIpAqS
	 GRTNJXtjxDpEw==
Date: Thu, 1 Oct 2026 17:25:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: reject a netdev that implements only one
 hwtstamp NDO
Message-ID: <20261001172518.4902bc1b@kernel.org>
In-Reply-To: <20260929213233.1555567-1-nb@tipi-net.de>
References: <20260929213233.1555567-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 23:32:32 +0200 Nicolai Buchwitz wrote:
> @@ -11447,6 +11447,13 @@ int register_netdevice(struct net_device *dev)
>  		goto err_uninit;
>  	}
>  
> +	if (!dev->netdev_ops->ndo_hwtstamp_get !=
> +	    !dev->netdev_ops->ndo_hwtstamp_set) {
> +		netdev_WARN(dev, "driver implements only one hwtstamp NDO\n");
> +		ret = -EINVAL;
> +		goto err_uninit;
> +	}
> +
>  	if (netdev_need_ops_lock(dev) &&
>  	    dev->netdev_ops->ndo_set_rx_mode &&
>  	    !dev->netdev_ops->ndo_set_rx_mode_async)

Third such check added here.. we should probably factor all three
out of register_netdevice(). Hardest part is probably naming the
new helper. netdev_check_ops() ? We already have ethtool_check_ops()
We can't move it earlier because some drivers set features form
ndo_init And while you move it you can also make the warning
about not using _async return an error. It was "soft" to avoid
bricking people's systems on boot, but it's been there since v7.1
people will have enough time to spot offenders by v7.4
-- 
pw-bot: cr
