Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FE20C00C
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776910852; cv=none; b=ekg1tq/wKe5cGvHPJ3ID8cZLEhNHoNSS1x31wM/kRTkhWMwa5tztA1s0uI0xYF4+W7kZdDmc+9ecUNGbg8pfL5DlYNVHrtFeD/nMmkdulFmY7kx+uFGSa29D3t7FKQP7SiQozgNcrzwGWEXbuMUrBnIl+zlNZoC9Dm6OxqwLZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776910852; c=relaxed/simple;
	bh=FwZYiq6hcAiIspx1Xi0htTl4+gP/1VfUkE1SSkVmTkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+t7R84A0jyM4vUVQHlDPOQnFw3oBm3VoDyZ0PjZcF3x28kuRh2qcE52MIpGWAGDJMcwnHbFAxYSA0/S47d2xh9Hu4MQTlCIyehFwhEKRILYaceH7cKiXbfgc8UWwD5paQJpfcaQ2VMJ6lRrWz1jQDaRaCsdtOeFegedNgFv38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPlylZQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPlylZQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBC1C19425;
	Thu, 23 Apr 2026 02:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776910852;
	bh=FwZYiq6hcAiIspx1Xi0htTl4+gP/1VfUkE1SSkVmTkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pPlylZQkLAiQkw7F+RcdRkuI9PAOb3btijHgCXvzK13FZIaZWWh4LXllYIGt+eLwB
	 fAdqftVEJPdbIrc+MiTIETtzF03tLK1U8+v1Ny9+f6rZDsANFKA4IswTv++bTBjocW
	 TTM6JhwpIX69n0iTdhcK0MAslQjkIZOwuCveSblx+R0gYyNm1nxLZoWK/wkEZ+dc7b
	 vgPf2LyXgKPSWzH9nmuJUrvCZp8SfohHu7KISyvd62F6LNcV0VDmA7tdcmK4XZf8ry
	 +BmyBPTE6a2wjFsDRmxQjTJ0rW8EeSMMZzx9189k1kxS5445l/J9orGpPga/lj7VKE
	 grGFzT5qMQwuw==
Date: Wed, 22 Apr 2026 19:20:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici
 <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <20260422192050.7c4ca760@kernel.org>
In-Reply-To: <20260422123242.530882-2-antonio@openvpn.net>
References: <20260422123242.530882-1-antonio@openvpn.net>
	<20260422123242.530882-2-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 14:32:42 +0200 Antonio Quartulli wrote:
> +	/* Prevent adding new peers while destroying the ovpn interface.
> +	 * Failing to do so would end up holding the device reference
> +	 * endlessly hostage of the new peer object with no chance of
> +	 * release..
> +	 */
> +	if (ovpn->dev->reg_state >= NETREG_UNREGISTERING)
> +		return -ENODEV;

AI review suggests wrapping reg_state read in READ_ONCE(), I think
that's legit. Also nit: I think > or != REGISTERED would be more
idiomatic than comparing >= UNREGSITERING ?

If you agree make sure Sashiko doesn't complain about anything else
once it's public:
https://sashiko.dev/#/patchset/20260422123242.530882-2-antonio@openvpn.net
