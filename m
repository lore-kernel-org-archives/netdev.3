Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E613BB695;
	Tue,  6 Oct 2026 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301468; cv=none; b=ZG6PxeoyATiGAGLRTF5hQ0yEyQEgRm4U+V9+oOkT4fsuUUY9LhbNnX2e89juDvkcWKpHEe3cNJpog3KCszQZfunD+vSdVtJ/8lF2rlv/GdNpvlabf2DIWMsfhZbwu9SjUsmg9b0ZDDz/vIF+kxHay+yfes4GF2cRq5b+d2NqQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301468; c=relaxed/simple;
	bh=/akPqFjBPFk1i0fF17zHYL4oqlB65msOV86aBtJy4xg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e6AlCAoK8UOVZR0om9KLdUAn7IzHmmoNolIff9k8Xw27gDqAbAfIHCidsd6MI9QHaKxjvL+2GHKiZ/7lbVir0hGMQwq82cZPD4qrJl+i3VgEqqJnQvVvk0j0Dw9rc/9pHaPQFD0S9heTK1uc1IlLYmgE2TVCFm7MWnXX0k0Kg70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=APvjwjp9; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=QPhveSUG; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="APvjwjp9";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="QPhveSUG"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 696FhqXA030345;
	Tue, 6 Oct 2026 17:43:58 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 765B91228BD;
	Tue,  6 Oct 2026 17:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1791301428; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdK6cwIPlCPet6hLfR7uwhBD0oYQ7PTncgtI8QIo+SM=;
	b=APvjwjp94Y2KzdF4/TiFIfkGLof61N5HhXDspThV1XQKByYWGpIFEhN4AVoPs5xXSvw8pW
	pJnmNn3pLKYNYgAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1791301428; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdK6cwIPlCPet6hLfR7uwhBD0oYQ7PTncgtI8QIo+SM=;
	b=QPhveSUGTjxu6991vCq4MxLFJZyQQLkRxrf+kF82xofi76IkGCFBwPMCOmFIZ/Mw1vFqY7
	rDCWz0l7qvTWenQlysre/3TejmKYDHSDKXu5oAbaSL2a6Jor7hLwOY72bYJYEwQGtMgp2X
	VFc/N9XBCXnH8mOrl6XdLTX59476m9oKQHuRVdmcLCADyVtzxlh8qKtFf1kf22yW9Jyi6R
	0A5M6Uv5xKuDIquEEH5LjPUcMtMl1vc8JSp8Lk1ycKhVxrnYnswEoOlskNiAX4w/YCGTnW
	jpm566rsZjUSybQBUfls1SlPhUYSOV75hxcwfhAbJgPtb9hp6eKLZEknmMfxUg==
Date: Tue, 6 Oct 2026 17:43:48 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hangbin.liu@linux.dev, Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH v4] net: ipv6: seg6: report lwtunnel setup errors via
 extack
Message-Id: <20261006174348.b62a0e824aa8acfbf187e4c5@uniroma2.it>
In-Reply-To: <20261005140637.644840-1-g.goller@proxmox.com>
References: <20261005140637.644840-1-g.goller@proxmox.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Mon,  5 Oct 2026 16:06:34 +0200
Gabriel Goller <g.goller@proxmox.com> wrote:

Hi Gabriel,

thanks for the v4. +1 to Jakub on _MISS. I also have two comments on
the message text.

> [snip]
>  	switch (tuninfo->mode) {
>  	case SEG6_IPTUN_MODE_INLINE:
> -		if (family != AF_INET6)
> +		if (family != AF_INET6) {
> +			NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
> +					    "inline mode requires an IPv6 route");
>  			return -EINVAL;
> +		}

This message is also returned for an IPv4 nexthop object, where there
is no route, for example:

  ip -4 nexthop add id 1 encap seg6 mode inline segs fc00::1 dev dummy0

What about "inline mode requires the IPv6 address family"?

> [snip]
>  	/* verify that SRH is consistent */
> -	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo), false))
> +	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo),
> +			       false)) {
> +		NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
> +				    "invalid SRv6 segment routing header");
>  		return -EINVAL;
> +	}

A nit: the same header is "SRv6 segment routing header" here and
"SRv6 SRH" in the other messages of seg6_build_state(). What about
using the name from the title of RFC 8754 in the extack messages,
for example:

  "invalid SRv6 segment routing header"
    -> "invalid IPv6 Segment Routing Header"

Thanks,
Andrea
