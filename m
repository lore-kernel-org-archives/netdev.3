Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF773264D7
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670449; cv=none; b=H+sIz/25+Evp4zFwRLfjYor5S8zbeQ/LwgUUdE5vmSyIp2c7bFEg7ZFvXQ+GZ+2bTBuglR11brzvRA0dt480zTqegzsYf7T1Ay3utV6AlW0lYPaDjSwitKHoDa0xyBsGykKlA5MWvRuO32tkU7i3JR5PlMudvtcZQhcFsvrIgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670449; c=relaxed/simple;
	bh=18idaFULcNw/q5t4kbpqfPm5Fx521vHHVHwuR+KJ+Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPXiEKC6Sw+NwRClcL8dinT9yHQCaM/SPlTVy0WcXjKiIKhKiLTm13w9aXJlUT5Y9AODrWXDRsNQbMuaLJQp7cCbo4Dii2DQC8gbrXzzYITQ7y3uYOr5HlfyZ1B8aHhKBD4xJMdL63hmp/LubOmSRrabRAwDgif67X4jMtuWa8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDeuFoH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDeuFoH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0D21F00899;
	Fri,  5 Jun 2026 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780670448;
	bh=gn9zYwuucWBEJQnBQlOhMcpiYln/tT1dOkuqyc/sZOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lDeuFoH4JZ9vY41zFqxXdlF+RaCUYvHWMnD+spdw0Hg+9MPiX4wZOw8Tv8E88NmPl
	 j0s4HbFTAIxixTjWxo+tE+MDmdcZk9RDNKcOAKkR0P846hoGeJXxfxGKgd+rR6NFlB
	 mFJDKfQwlm8Q86SfVBDpjTzP3NYDqp3yBCBPPb7t556myXL4w7mKVgP4lauq3m8Oey
	 IDuhtphNKiGMNzDAOuLjZG1x/UO1281vJZwiWfzTdCPJ+M4L92fdEmZ7O0lwi5jZBd
	 sigm2u7Ry33mjDng7grgXXZplNocH3LuBrWZdnRG5559MKUQrrAgTWWsauY28N9Ec/
	 KRgv/wfOvhhTw==
Message-ID: <1db331d2-d65c-4175-8790-2657f5455cb9@kernel.org>
Date: Fri, 5 Jun 2026 08:40:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] neighbour: remove obsolete EXPORT_SYMBOL()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260605073426.2922242-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260605073426.2922242-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/26 1:34 AM, Eric Dumazet wrote:
> IPv6 can't be a module anymore, we no longer need to export:
> 
> - neigh_changeaddr
> - neigh_carrier_down
> - neigh_ifdown
> - neigh_connected_output
> - neigh_direct_output
> - neigh_table_init
> - neigh_table_clear
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/neighbour.c | 7 -------
>  1 file changed, 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


