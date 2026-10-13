Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9123747A878;
	Tue, 13 Oct 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907503; cv=none; b=rQaQc9HRPMXl7buk153/37Is4TWuhdg56YcmmNjLQhEICnGWE2L/7Y2v+jN7Mu4FXkaKOf7ZONoF5ZbOH1YcDl7ctJKhc1NDBBS3B+PTqLauRg2U/zeQWZvb4jOHGKGsclYReA5/Q7g+nqFuAQozn9k+z2bmBTSJ/U3vRe8S9Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907503; c=relaxed/simple;
	bh=7h0sf2gRFH8R6xYhtPmrWahpAhDfFsMUKFNZdgMHXqY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kP8ZYo2x06JszqHrTgLax8K89Oj3gb+UCju4A30AaP86/PytBIqHxDvgWXQaLu00OPmcK3n5JodgI9DGRMGP+xUR+Yn60nuSgxaRB9eYWGJ016Qqd095ui7OmHg9wU6VKpiZknVgHL7GWQBnII3uq2oA9iogAHUlKMmlplFJAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=GFhehqNj; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=wAewEUij; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="GFhehqNj";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="wAewEUij"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69DG4Lsj017755;
	Tue, 13 Oct 2026 18:04:27 +0200
Received: from lubuntu-18.04 (host-79-32-222-240.retail.telecomitalia.it [79.32.222.240])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 5B11C122955;
	Tue, 13 Oct 2026 18:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1791907458; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQvYSYqZ6k/sUq4Txag0yspZVB/kBchpbDi+DaXieqs=;
	b=GFhehqNjmKPDRm/k0rT6tjJj+MYSNiBnmRsk9R27AXbbSLof21ZEhu5M9/HWCkn4t2iUo6
	Q/33OnVNkdABZlBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1791907458; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQvYSYqZ6k/sUq4Txag0yspZVB/kBchpbDi+DaXieqs=;
	b=wAewEUijpoGpB36UnWtjPYF/uxxyXeQhnldRNDY0Fbq7jbSqh7ZE8SML/zvyq8yrB8+83y
	9Tncl7Pt2l13J//3B3Pl29h1J6767kg0UtZ38bqWQ8CYiniE7hfHyC31DsTZO7U1bgWdml
	FpmbeLic/U+KStOLbl3rcoDe8uSBzLuSbk+IJybaLz5whPcz1w4Z68FlmqErQBWtY6DfoD
	jG2Rdkj4eN48pY+0OJvj30OcQN5p3GuSpfN2hoEtd/st4izT9br3NUFG+ukiHo/SH+RYaD
	bmGl9fzatCHYigKLDZh9L184dAbSnmi6cQW/EOypkYq73NCqpjeuvdcLG0DC9w==
Date: Tue, 13 Oct 2026 18:04:17 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangbin Liu
 <hangbin.liu@linux.dev>, stefano.salsano@uniroma2.it,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v5] net: ipv6: seg6: report lwtunnel setup
 errors via extack
Message-Id: <20261013180417.0647d60d8a95d2af01367da9@uniroma2.it>
In-Reply-To: <20261009152015.462383-1-g.goller@proxmox.com>
References: <20261009152015.462383-1-g.goller@proxmox.com>
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

On Fri,  9 Oct 2026 17:20:13 +0200
Gabriel Goller <g.goller@proxmox.com> wrote:

Hi Gabriel,

thanks for the v5.

> seg6_build_state() rejected invalid configurations with a generic -EINVAL,
> so "ip route add ... encap seg6 ..." sometimes reported "Invalid argument".
> 
> Add extack messages to the checks that lacked one, and use
> NL_REQ_ATTR_CHECK() for the missing SRH attribute so that userspace can
> tell which attribute is missing. The checks themselves and their return
> values are unchanged.
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---
> 
> v5 (https://lore.kernel.org/all/20261005140637.644840-1-g.goller@proxmox.com/):
>  * use NL_REQ_ATTR_CHECK() for the missing SRH attribute (Jakub)
>  * reword the inline mode message to "inline mode requires the IPv6
>    address family", since it also applies to IPv4 nexthop objects
>    (Andrea)
>  * consistently call the header "IPv6 Segment Routing Header" (RFC 8754)
>    in all messages (Andrea)
>  * include the offending mode value in the invalid mode message
>  * reword the commit message to match
> 
> v4 (https://lore.kernel.org/all/20260923120228.172643-1-g.goller@proxmox.com/):
>  * use NL_SET_ERR_MSG when the SRH attr is missing
>  * use NL_SET_ERR_MSG_ATTR when we have an invalid attr
> 
> v3 (https://lore.kernel.org/all/20260922090851.38978-1-g.goller@proxmox.com/):
>  * format fix
>  * use NL_SET_ERR_MSG_ATTR
> 
> v2 (https://lore.kernel.org/all/20260918153544.1178884-1-g.goller@proxmox.com/):
>  * dropped tests
> 
>  net/ipv6/seg6_iptunnel.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> [snip]
>  	default:
> +		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[SEG6_IPTUNNEL_SRH],
> +					"invalid SRv6 encapsulation mode %d",
> +					tuninfo->mode);
>  		return -EINVAL;

A small nit on this one, as it is new in v5: I would have kept the
v4 text here, "invalid SRv6 encapsulation mode". No need for a new
version just for this.

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Thanks,
Andrea
