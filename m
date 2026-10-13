Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB454EB872
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899552; cv=none; b=OC9xWXa5zZ6GAynhbE/t++nKIIjx7RskdeIPGavDSV0av+c6aEkBsuBz9IK170d+H8GcVFT31lqAyPT6boSBTm5UIue+OlP7RxsZNcqsSHukpzrApslHe7MeDpQM38GDBh3fQ1EBphllseI5iL+aQmYYSxPvgrUA0YEvwJ0xHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899552; c=relaxed/simple;
	bh=bM5ODnkTE4YRR8HbV8C5Z+Ku1Q9ttvkcICyvgA4chm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMSZp0JXtaXNeNAIDUOH8wDvuendDtutinI+7aMyheqx439UnU0W+iYT0ydkkkpgxuTzjgcl4yt8rdR77yQ+6xVpx6GRmGm/ug/ksHPS0i5o3A7MRdZvv9/jBuBS3umSoyuQBXl/H6sMCOkyWx+skEqj0u0am2q2QKvnZxofv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJBGUOzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJBGUOzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E1D1F00893;
	Tue, 13 Oct 2026 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899551;
	bh=dC/LT/OLHmB+of2DVyrQgsx8eInGRvi9YzDMSDwDp38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cJBGUOzzoMYELyBGkl0B1LBmipS66qSr5f7CAi+TtfJhUfg1k+UtJCqvB0qn5MHdu
	 VouA4jijAht+ZkfImwLm4fXkBpJr+/7Fo+6bhFJfnKPY/8fD7vT+o++q2dadSAYkDT
	 RUA24uYeqLdRbrHMQD0vM/x4NFBCNhi7oPeeW4DT78t2wYuMfkuUmxI+zXkox4Rqp9
	 CPCldpm6XrSRfTWwd2cEGDBHGpspWd96BtvCxLfiEz6kVvhjG0mh8AfAo244QlD0+e
	 EallY/M+5VfCn7tsNHdHChW5QOjYB/uuVkgG/YmS1pzqYgD257Nc6sHwnUu8nzmhY6
	 iuIfi/Fo7tCuA==
Message-ID: <76f16ff2-3102-44e9-b4e0-5818044bbc75@kernel.org>
Date: Tue, 13 Oct 2026 07:52:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB
 changes
Content-Language: en-US
To: Antonio Quartulli <antonio@openvpn.net>, Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
References: <0c6f073c-12c7-4843-846e-69c48c290107@kernel.org>
 <20260929150454.466148-1-ralf@mandelbit.com>
 <375bc468-fb28-4620-a5c8-0f7ba9e693d6@openvpn.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <375bc468-fb28-4620-a5c8-0f7ba9e693d6@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/8/26 6:33 PM, Antonio Quartulli wrote:
> You're right that a cached dst can go stale later and that reuse-time
> validation handles that. This case is different, because it breaks
> reuse-time validation.
> 
> dst_cache_set_ip6() samples the cookie itself:
> 
>         dst_cache_per_cpu_dst_set(idst, dst,
>                                   rt6_get_cookie(dst_rt6_info(dst)));
> 
> rt6_get_cookie() only returns a route-tied value when rt->sernum is
> non-zero, which happens in ip6_rt_pcpu_alloc() and only for nexthop
> routes. Everything else reads the current node generation:
> 
>         *cookie = READ_ONCE(fn->fn_sernum);

Have you tried setting sernum for all dst_entry when they are created?

This deferred reading of fn_sernum seems to be the problem. fib entries
have sernum set. dst_entries are created from the fib entries and should
carry the sernum from the fib entry at that moment.
