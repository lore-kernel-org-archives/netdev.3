Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6492F8E99;
	Wed,  5 Aug 2026 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895028; cv=none; b=ETUMRegPBfGc64HMRiNAalusvzpvRqWExu0/8coeJBWCNLXbUFrZs05wGzCbYVSG/lceOWbkt+W4UFfWXui8PnwzUkxLyT1WzFJAg503p7S5YH4VgyotTUz7m8EqXiKC/oqcr3XoUPNdXtPG213mk+C6l78KFcNQTOI++eYgW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895028; c=relaxed/simple;
	bh=M3MVCXVMJYy4hgvbkILKhPoEXsVweNVT1+kmnRrxUrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAWWCQt66h1HAlsNA4HysiqZc3DRoVtKspVxzyF/UWaYmEDgKp9IRXcG8sKq6IjcopIC3JfvjLdw4Zvy7h6cXpfbKY+5oj0tsApnLkZu6sOxBgWqeN4KtQhsW5LYm73FYCofyw+US/QdQw21gaOyxuTdZMBZ06wOLuxp+/Dn2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX3pjgr5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX3pjgr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67B51F000E9;
	Wed,  5 Aug 2026 01:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895027;
	bh=7ij/6JhyxuIBKG2aLSNGBxpyckpbChyM9TYkrksBZhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aX3pjgr5f+Pe+eLzwPJVLoM0oCvvc0rKrutiRS+pSzrZk1ROwBHDpuOvwMPj2nk3S
	 VOM7yunbq9sNH45BqIiXiOGk7e6FfZxai/wuacL59pVP516Nvtr3/S423rHSThX3Zu
	 BSmkLitkqRt5q7CYImzCUsknyMxvqwvCOn1p4aaOX4c6zADgGXqcGvfSov+JY+RVKX
	 elJVg6FnYK+ijyHwCABJaXaSvXs9B9WuPnQTDT9Be/z6PhqGuCbxdJZTsb9LigD7bi
	 EwPhx/ULr31tXB1i/hHf1+zvU+paAwmUnMQX+/hTCeuKOYlFNXJY9fga2f6gqQIyqe
	 LTI/n+C/QK4hQ==
Date: Tue, 4 Aug 2026 18:57:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minhong He <heminhong@kylinos.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Dmitry Skorodumov
 <dskr99@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ipvlan: check register_netdevice_notifier()
 error in ipvlan_init_module()
Message-ID: <20260804185706.49149c53@kernel.org>
In-Reply-To: <20260803090007.142517-1-heminhong@kylinos.cn>
References: <20260803090007.142517-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 17:00:07 +0800 Minhong He wrote:
> -	register_netdevice_notifier(&ipvlan_notifier_block);
> +	err = register_netdevice_notifier(&ipvlan_notifier_block);
> +	if (err)
> +		return err;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	register_inet6addr_notifier(&ipvlan_addr6_notifier_block);
>  	register_inet6addr_validator_notifier(

You should error check these as well while at it?
