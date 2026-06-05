Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0852317143
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622165; cv=none; b=hAyB9Mi82fp2SBmsdPIHOrFIDEUD6ZR+ogZ0vb10cjGKQUPqL5VjFPfxceKtr6m2UIqX4jHxlqi/nI7hTT1e134/HE6g101b2EU+Bd2WK9Lp3icI/atzimpyKG8Ul/7hYGSonoTwh7jv1Nzcg+4DSDkCxzpcihXvKIbdLQ1ySN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622165; c=relaxed/simple;
	bh=JFxTH3jKe4KFsjjZCpsw19+ny/is1Ss9MtWJgF894ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t67dGtk4og2END/bbUlTEZJDBA8klEYtsV6InuMZCXOW9mhWrQ03V2nUzgLpjVKjhH++CbOCbcFu6jt69wX2XrZpuLRkE5zVubpWVGKB7IDJn4ZxCpIxZ/2C5Z7L6E6mbrgQ4kcHGsyOtfgBxx1V9CnQQT3IIkVXvXdMgYeDqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO78WiEV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO78WiEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEE51F00893;
	Fri,  5 Jun 2026 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622160;
	bh=hkRL85CKlA0+NNH016iTsIqEMiEm4bunDrOSFpr4B4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dO78WiEVFdsnjvYDgdEtWf1X4u+Ic/n2nycek/dma1uyfBpQvzKuvB81Utm3ksafY
	 eW7d+ZaEuFPXrofQLeH4ogUXthLHdt42bFLyb5JQWJ9mcARbDxz/G8u5JdIMizA4PH
	 NZpvakPbad8EmdX1UwEe1vqKeMwwaCJ9aSfsGpfQ9wD7CJIITcxUUJDAwx0hI+B1xw
	 N1o9YeR7qxRCUL7TEBRco7uARNomeCFziKpHug7HZlxZExrs/D84mbAjYtDLE8zK7k
	 6AZod71LZyaTxLdqkKHmRRC8Fa8+MRzmRZkOuh6FWIXqSlkOUOvIR0ciJUnXOO898j
	 YvQRO8L0SOkEQ==
Message-ID: <8d1c122a-829b-4812-86dc-ec3e0b1e1a9e@kernel.org>
Date: Thu, 4 Jun 2026 19:15:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: remove obsolete EXPORT_SYMBOL() and
 EXPORT_SYMBOL_GPL()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260604174555.2801532-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260604174555.2801532-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 11:45 AM, Eric Dumazet wrote:
> These symbols don't need to be exported, they are only used from vmlinux:
> 
> - inet6addr_notifier_call_chain
> - inet6addr_validator_notifier_call_chain
> - in6addr_linklocal_allnodes
> - in6addr_linklocal_allrouters
> - in6addr_interfacelocal_allnodes
> - in6addr_interfacelocal_allrouters
> - in6addr_sitelocal_allrouters
> - inet6_cleanup_sock
> - ip6_sk_dst_lookup_flow
> - ipv6_proxy_select_ident
> - ip6_sk_update_pmtu
> - ip6_sk_redirect
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/addrconf_core.c | 6 ------
>  net/ipv6/af_inet6.c      | 1 -
>  net/ipv6/ip6_output.c    | 1 -
>  net/ipv6/output_core.c   | 1 -
>  net/ipv6/route.c         | 2 --
>  5 files changed, 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


