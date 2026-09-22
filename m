Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DF48F02F;
	Tue, 22 Sep 2026 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113845; cv=none; b=XSINQup1MJg4miRrkmR/+KpPu2Vl+bVp4IsYOr++TN4dfgVVfaWOD1ArIvHKqXboXQpaVZS3UIgJZOVGK3go9QNY/oiDH9W5LQogx/jW8ie7EFO8NJ18LMPWwIBMiPSXVlD6K/sojISvjS8iP+kn4xemmndyYMCPEq0NDaES7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113845; c=relaxed/simple;
	bh=lLDT+RUyWFZpuVk00hj+9APRrmOZIYwKkXfHJ0TomUQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a4zuvoso1s7WOqBKwgNU6Lmkzmova6J5MM6ej1wrzK0gaG/QxOq3FiF8S7ggrYLhEERkEz4ZpYiuhHMg/cN2T7ljXM6VkNBx150KdKTm3nKzzLmKHi2OyMLNJfjwA8bx9vW+n8LYlz9J7W46jdQgdQeU5DKqFFdQ67S/iNS9vy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=9IsLVYht; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=RP7AUSb8; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="9IsLVYht";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="RP7AUSb8"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68MLo4Gu000611;
	Tue, 22 Sep 2026 23:50:09 +0200
Received: from lubuntu-18.04 (host-79-20-84-28.retail.telecomitalia.it [79.20.84.28])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 0B6D8122874;
	Tue, 22 Sep 2026 23:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790113799; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sF10tc47L0MCJMhJ+ydbI8femWky+2NL+/vsV3eWaBs=;
	b=9IsLVYhtz3FFMItq0juGujIiydWw18nlXz/HRj6KtCVAkl9U4GtH5mkwCU3r1zG59Mc4BW
	M1qSJNRDvZ4F4YCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790113799; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sF10tc47L0MCJMhJ+ydbI8femWky+2NL+/vsV3eWaBs=;
	b=RP7AUSb8kz2t2+YAnUHP/u+gR1E9YlcOjqrpvUx1vOX5xEM4BhnJ1/NWstNHNDaBBwmSl9
	SNG7jpUZDzwH7Ut0s28KsB2F+c5WQYFkZsFHqvSZZJrL7acjOI0uuwtwjSkYm0a/2usAsL
	H7EfbPAyEQj/ppwgjlr32NuEmkf8+Ci7S/Yb+S3yslHQfSmYaeOjaVN4HekA5zA2NymGhT
	Ao+lwbU4TgpKVR4OsbivyWhr++c5MlvjhI3NuJe4HndNHMLLNIgDlfztcB3CrcNp8wrpk6
	ZQ4fBSElKz0eOgPz6ffZ5/zV5UxgsKtQwdMwJGsYJ/byaY1Hoy17vHki7/hGJg==
Date: Tue, 22 Sep 2026 23:49:58 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v2] net: ipv6: seg6: report lwtunnel setup
 errors via extack
Message-Id: <20260922234958.9ccce91258707b88fbca9728@uniroma2.it>
In-Reply-To: <20260922090851.38978-1-g.goller@proxmox.com>
References: <20260922090851.38978-1-g.goller@proxmox.com>
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

On Tue, 22 Sep 2026 11:08:33 +0200
Gabriel Goller <g.goller@proxmox.com> wrote:

Hi Gabriel,

> seg6_build_state() rejected invalid configurations with a generic -EINVAL, so
> "ip route add ... encap seg6 ..." always reported "Invalid argument".
> 
> Attach an extack message to each of them. The checks themselves and their return
> values are unchanged.
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>

The commit message stays in the changelog, so wrapping the body at 75
columns would be better.

> ---
> 
> v2 (https://lore.kernel.org/netdev/20260918153544.1178884-1-g.goller@proxmox.com/):
>  * dropped tests
> 
>  net/ipv6/seg6_iptunnel.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 61c6a27bf202..e7f75970e26e 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -756,8 +756,12 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	struct seg6_lwt *slwt;
>  	int err;
>  
> -	if (family != AF_INET && family != AF_INET6)
> +	if (family != AF_INET && family != AF_INET6) {
> +		NL_SET_ERR_MSG(
> +			extack,
> +			"unsupported address family for SRv6 encapsulation");
>  		return -EINVAL;
> +	}

checkpatch flags this line ("Lines should not end with a '('"). The
two-line form used in the rest of the file would be better:

	NL_SET_ERR_MSG(extack,
		       "unsupported address family for SRv6 encapsulation");

The string goes a bit over 80 columns but should stay on one line for grep.

A side note: the source_inline bot failure looks like a false positive,
the script matches "inline" inside the string literal.

Thanks,
Andrea
