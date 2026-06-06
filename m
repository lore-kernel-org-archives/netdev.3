Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA73B27C1
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780774028; cv=none; b=jEJn3tkbiNOe0uM7Z5JMnquWQG/NWNDm3io3ujCXraAFRbEH3UHq8y5J5WQ6PZsMqPS/OkHfAwJxpus77/8UE3CaNQ3juHrpEHwTWwlG6Z5BbOVAP9YU6HiClucwdHudu2+K0OnFNQgMCjsjMLguDNM+RhQXWxOj7XLFBF/kKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780774028; c=relaxed/simple;
	bh=6gxBk/BPRKDdysbY2FIXgqNF3nQVkwV6kBuB5bd48Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke38LfhQUHWpraPgHMVoJlgjm0SLvS2x9zgBu/Nn+RFOcMaLGNS9BbKu0zCTe3AKBmM9J+f2SmNDsRxhX7P8jIC0Ua4kWhaEieLk6/jA+GHmP1bZEuac8RGSIaOWqOHskrqpcBDHKNjfwt31iREXQ/g4JGJ37k4ebJXGvXUStS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4G5OOmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4G5OOmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E2A1F00893;
	Sat,  6 Jun 2026 19:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780774027;
	bh=qWstBFKaHpOAfdkIpGJ3RzziS2FAn9MgojvHghSkGzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y4G5OOmZxM1uO60M7dohkan6WSefN138a+X6Q20viYoAStgdajXt8f50A+LsUX+DL
	 K0ZIdA3seRRldyZjglmIqXyA5PFvz8hotJmAvpzui4wQgw1oaivPdTDW0ysgVh8vn6
	 nr5ecI/d/rwStVX38d2v2TDrPc+hYp/JVrC2072oBCPUrQxy0zoxgFeSnfM7FLacut
	 SdRQGxtSy4GlfLP5DdVAjyj0NWMjkoVOdls5J4o2lLDI7A4BCt5cnQuAlVq7x7DwQT
	 bOqlQONy5DkltXjr8hn2YVktP29FCnmREwx/e5/mSYVG8QcaCzzpP207cN0AJ36OSe
	 DiBtd5GK7GlQQ==
Message-ID: <5733ad97-d8be-4bc9-ae66-9137b93708b6@kernel.org>
Date: Sat, 6 Jun 2026 13:27:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL
 and IFLA_GENEVE_LOCAL6.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260604052127.2227300-1-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260604052127.2227300-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/26 11:21 PM, Kuniyuki Iwashima wrote:
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index a8c64be26f2c..d692d466da6b 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1487,6 +1487,8 @@ enum {
>  	IFLA_GENEVE_INNER_PROTO_INHERIT,
>  	IFLA_GENEVE_PORT_RANGE,
>  	IFLA_GENEVE_GRO_HINT,
> +	IFLA_GENEVE_LOCAL,
> +	IFLA_GENEVE_LOCAL6,
>  	__IFLA_GENEVE_MAX
>  };
>  #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)

drop the uapi from this patch and update man/man8/ip-link.8.in

