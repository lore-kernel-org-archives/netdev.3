Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0EA292B44;
	Sat,  7 Mar 2026 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853564; cv=none; b=fN2WaPIs5k3G6tqvqx+jftB2CJ+fp3584NvU8fX2dPCGeL1nvLKHkF6ATVS9E+VjJAlVMAfnAQgPe7NbAfVsZy3WQaozS7rH9SKPOiabc4qqfal2YBiueFhr2DzwBYk6+jrNKhB7sZ6G4M/J/riamTsqpiNEq7WRlylDV6Bp3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853564; c=relaxed/simple;
	bh=vaQY5oKpMf25ykRhJqFn13UzYNZzT3H4Cg7XQDo3EiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1ZZLx0EwEMZpkqo5aYWTxOZ24xLt3gGfusD9NKsKq8x6QCPKmlnYan0S0R4kRWK1amBIlUrKFhOVMRwto1GY83X9+nYsyJxjAvfgQFKJhGJbZ5RnyXs/uBVKIcNHfG1e0N3/UK+tB2nSOCyK1jlyppU+zYQIy4JimxzBiYSmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6/xWO6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6/xWO6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE255C19423;
	Sat,  7 Mar 2026 03:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772853564;
	bh=vaQY5oKpMf25ykRhJqFn13UzYNZzT3H4Cg7XQDo3EiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S6/xWO6fTxDgpzpRpB1nw1LqEvFAp+LcV9ueP2YI9tJ6oSExHVJnW9EFzlV/c2jCJ
	 uie/7l2nidhFrID6ec+ogTSXd1kPSHEEtbeie9SKE18dax+xWvnuG/4Po/TnsgrYOH
	 VFbcLOriFNMucqzVOQxDEOeU1Qq3xGZb2mq8QiLTcJYZnf3tuaXkLYHG3pb7jewj00
	 7lbAU0x67iiGhHimEf5mL3HSsfG1DH0/16ZNqv8m96uUBK8G3tGEfin97/y4NhiigY
	 FgP1ke5k35SCMiBUG+bg0B11b/yqNZGSRE4OXY0iu0JWwmhxPy7TKI8KqBsP4W+Kl5
	 bpPBnJipOgp6Q==
Date: Fri, 6 Mar 2026 19:19:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: mvusb: drop redundant device reference
Message-ID: <20260306191923.4ae5a6e1@kernel.org>
In-Reply-To: <20260305104722.16217-1-johan@kernel.org>
References: <20260305104722.16217-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Mar 2026 11:47:22 +0100 Johan Hovold wrote:
>  	ret = of_mdiobus_register(mdio, dev->of_node);
>  	if (ret)
> -		goto put_dev;
> +		return ret;
>  
>  	return 0;
> -
> -put_dev:
> -	usb_put_dev(mvusb->udev);
> -	return ret;

better still:

	return of_mdiobus_register(mdio, dev->of_node);

and you can remove int ret; as well
