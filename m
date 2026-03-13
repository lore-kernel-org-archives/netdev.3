Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B13A2558
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413793; cv=none; b=khze0N96IsoMR2MjIN8mU4asuhBLKy8sKHpw5Tm50SiYOFMkqLhOY5rvRidBQl+xVhJxsC8kak+m12thKNm3WrMPCeXJ/kUzdCpB8pI32IFjU497ippBOW0dVzOEUXGeu1hsLolFakuNPRyci1B0yStoTO8vHL4jQ+6FwFpNBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413793; c=relaxed/simple;
	bh=2FKwk7JQNn1KBP1EuttGVWJ/fhwdSmIPkJVOqoLSu7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTenS7H/C5ismdFsC+a5H/vPacYoHbf3P+Nvl/yi7ofs8XZ6LLYRR+e0Oxtn1UsFZkQGbXQtJ7qNNYJqQFpW8y7J8YjlDUHCOdiG5p/Kvh7jboksIQ+DVDaaaMrCcEHF5Ni4COIAunZ3tSWkfagzSaa7vflTwMd/aeE+pDur00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3RdbZ9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3RdbZ9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A32C19421;
	Fri, 13 Mar 2026 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773413793;
	bh=2FKwk7JQNn1KBP1EuttGVWJ/fhwdSmIPkJVOqoLSu7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E3RdbZ9d2U789m3l66jEFLrklRoaqY9MMgo9+cjX5cdcTq8ucMoeZ49Lrum+udoRe
	 tQX9AuHafOhwDe+WKPBBnCD0km4eGKaYoytuzWEjItWkbIx87Dy1BraQqtLLK4xezR
	 G112vrP2XV6AdSp9Vt9GhMl23eOziEth3v5UdjOYkhG3N6KIOZ9bUCzd1VagR0zKl1
	 iWrDLa7scaWDQN2RtuMWJZskaS47cBmdGlL+mD1kd+xKAiW05hDsjdU0JGTi7qLi8h
	 ILwt7LH4odCDevoHTbRIIV4ZuMGU8tUsyNFBfYwvGBZGMGa6B65XONCe8AXQ1G8xw+
	 o9VlI4su1pWmw==
Message-ID: <1644761b-4960-431f-bf3d-5593007212fc@kernel.org>
Date: Fri, 13 Mar 2026 08:56:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] ipv4: bump rt_genid when a relevant devconf value
 changes through netlink
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: tgraf@infradead.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net
References: <20260313144555.4956-1-fmancera@suse.de>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260313144555.4956-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 8:45 AM, Fernando Fernandez Mancera wrote:
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 537bb6c315d2..6dd8fd0a1323 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2107,8 +2109,33 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
>  		return -EINVAL;
>  
>  	if (tb[IFLA_INET_CONF]) {
> -		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
> -			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
> +		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
> +			int new_value = (int)nla_get_u32(a);
> +
> +			if (ipv4_devconf_get(in_dev, nla_type(a)) == new_value)
> +				continue;
> +
> +			ipv4_devconf_set(in_dev, nla_type(a), new_value);
> +			switch (nla_type(a)) {
> +			case IPV4_DEVCONF_FORWARDING:
> +				if (new_value)
> +					netif_disable_lro(dev);
> +				fallthrough;
> +			case IPV4_DEVCONF_NOXFRM:
> +			case IPV4_DEVCONF_NOPOLICY:
> +			case IPV4_DEVCONF_PROMOTE_SECONDARIES:
> +			case IPV4_DEVCONF_ROUTE_LOCALNET:
> +			case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
> +			case IPV4_DEVCONF_BC_FORWARDING:
> +			case IPV4_DEVCONF_ACCEPT_LOCAL:
> +				flush_cache = true;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +		if (flush_cache)
> +			rt_cache_flush(net);
>  	}
>  
>  	return 0;

This replicates logic in devinet_conf_proc for example. Why not refactor
devinet.c to handle changes to values in 1 place only.

Also, you are flushing the cache for more values than sysfs does.
