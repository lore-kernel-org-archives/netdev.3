Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C428C87C;
	Sun,  1 Mar 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388671; cv=none; b=Xvkc3BGi+de24bp3A5hEL0lcP8s0IMz/49flYs4P6xPgVVwOWTEFKz2AuYrwiKxIc5JyYHouLpPqM1xVIu2kODahe0wWGQ3UbcWrrUcl/HjkvR4KwEhY/IynJ6A3ah2RQPpTg7BT4uupb4kBd3quWxRBTEkmcyjnqH3xO5Tqi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388671; c=relaxed/simple;
	bh=NiyZ/P/wWqXWdm4jfNvH5gJbsCSPXe72r/2jIcLBWAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovtEm3hu9yXw0/LBNzNBPrjd2UnPHsTaPv+p4jy9VNhTvN47xsOct3oket05BuMWDP9rtdYpnZncO1aZUMF3pCpXGS3QWTjIAo4ssCiphDx8vYmDhAa98xEzgaBvCgoAoF/luyv+FicRYdD1lJRuAWIC0ckBF7cIJ3tY0w9qazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ksm3Brv4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ksm3Brv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E82C116C6;
	Sun,  1 Mar 2026 18:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772388670;
	bh=NiyZ/P/wWqXWdm4jfNvH5gJbsCSPXe72r/2jIcLBWAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ksm3Brv4AhmDE7TWipj7KuKGfwAj225hQX8QdKATXOeuFAX5tD7v6ODjO70ea5oas
	 iYWvFYMyFv4Xya7ANU7QCETcQq8lLrjkKkdgfOrIcNk0IVftXg9MS5Ry7Uuq2yd6j5
	 EA/Ir6LYw9RABA2UKGD816+wfXtzK6fsyAnJ5zEm913I4eUSPCbxn4ec938LZ+aD3s
	 R5odmHtUUTv5Pt4yF+7RdmodOGPk7Dkx/Tl9lVaEPz6e1fJplX+pkEz+GCSxKcchQU
	 yygaLWvIIITBHCyMqD5OapSYMLIP+rjVj23j/NdHLaXFhXTDrrH6b8GlhZnunWmLF2
	 dpC9LN4slNAAQ==
Message-ID: <d4baf286-3ecd-42e1-aae1-d7727a68176e@kernel.org>
Date: Sun, 1 Mar 2026 11:11:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: nexthop: fix panic when IPv4 route references
 IPv6 nexthop
Content-Language: en-US
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260228031400.163009-1-jiayuan.chen@linux.dev>
 <20260228073959.0ef1b33f@kernel.org>
 <3a00c5bf-6740-47c3-b885-c1e0cfe62289@kernel.org>
 <CANn89iJjjNW4U6ZxVcuRxWaKPbo1wfEyBD4Etkf+f6CWyhAHFg@mail.gmail.com>
 <d3722ec10046a2fde021a2b8a51a83431c8bcbac@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <d3722ec10046a2fde021a2b8a51a83431c8bcbac@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/26 6:57 PM, Jiayuan Chen wrote:
> The crash actually only happens with loopback nexthops, e.g.:
> 
>     ip nexthop add id 100 via fe80::1 dev lo
> 
> In fib6_nh_init(), nexthop objects always have fc_dst=:: (no
> destination prefix), so fib6_is_reject() returns true for any
> nexthop using loopback device. This causes it to skip
> fib_nh_common_init(), leaving nhc_pcpu_rth_output, nhc_exceptions
> and nhc_rth_input all NULL. When an IPv4 route later references
> this nexthop, __mkroute_output() hits raw_cpu_ptr(NULL) and crashes.
> 
> The simplest fix is just allocating nhc_pcpu_rth_output in the
> reject path of fib6_nh_init(). The release path already handles
> it correctly.

should have read this before that last response. fib_nh_common_init
exists to avoid putting ipv4 logic in ipv6 code, so your proposed patch
is wrong.

Perhaps the better change is to not use fib6_is_reject in fib6_nh_init
or relax the loopback check or move the jump label pcpu_alloc to still
call fib_nh_common_init.

Also, a test should be added to the nexthops test for this case.
