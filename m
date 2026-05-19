Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE33EDAB3
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229803; cv=none; b=AOW3RTVZ+H3dbC+vqFOrM9Hy4PPnRGjOoRZMwXdfi1hbHTY3adBPGyyppd7MfnxxxOCecgLaDbLUzk+zd6HnNny/xtFI44V1RYxoP9em+i0inf5NQDHQa2RmjoawuUcHDtHTyg7yODaNdfLyRNR30gEzoa4fzlzBetpavwaPjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229803; c=relaxed/simple;
	bh=KYY7YF581t9FoakHguW5K5u4vb4KwOhwVigS0T14oyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnfGSldubYvlm7UQgbIrT9bQ329GRswVd7PLFjJm8dFJ9QZJcNbZNnR1MzFxG0Sle5z0QXaF+HhvuYASFOn/xEJ6rmOzGH4hT/Xxex8+UNpQAUgixQ5MloQqA2r/tdB6DITqJVH7MZBqzIVeyWxj3OazfoztKhgdmdsOoiimwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+3crCXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+3crCXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D138C1F000E9;
	Tue, 19 May 2026 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229802;
	bh=javdDT8NW6bNhiHy15NtSQhRTq4gh7HAPyiyb3k997M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E+3crCXIimZTQ+KJXZ6JO1vYLCD5dvKsJ4+CdLqHH0mdCp4RsG6WylNDGpqq64QuL
	 iLXYjCkX6CeyAZ8oK3TQgU5EEK7emPo1lFFO6xHWL5Ki0idHX4HYHG7mBPL9axldxY
	 hWYttJcEnDsFZ04KZgXvwA63MPJ341oYYT9uNCorQdey49igsRn0dYGuWS5fWjFFBr
	 h/NrwhVB4rfYRq8+Pr232RKdQtWYMFcKkzwJPk6G6KgtIOCoApOpVQN2m7toWj6e8b
	 r6ns9OfLGi5HLekKk4vubb+sUc/HtxrzlHJaMt+JAWDH/QGdRJYDdKwgs8xWCs4z+F
	 helBkB9JluA3Q==
Message-ID: <1b2e20b0-63b4-403b-841b-d261bbf358d5@kernel.org>
Date: Tue, 19 May 2026 16:30:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: icmp: reject broadcast/multicast routes
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+c13a57c2639c2c0d03a6@syzkaller.appspotmail.com
References: <20260519200836.4141061-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260519200836.4141061-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/26 2:08 PM, Eric Dumazet wrote:
> syzbot was able to trigger ip_rt_bug() in a loop, using an IPv4 packet
> with a crafted IPOPT_SSRR option:
> 
>   options: ipv4_options {
>     options: array[ipv4_option] {
>       union ipv4_option {
>         ssrr: ipv4_option_route[IPOPT_SSRR] {
>          type: const = 0x89 (1 bytes)
>          length: len = 0x7 (1 bytes)
>          pointer: int8 = 0xa2 (1 bytes)
>          data: array[ipv4_addr] {
>            union ipv4_addr {
>              broadcast: const = 0xffffffff (4 bytes)
>            }
>          }
>        }
>      }
> 
> Change __icmp_send() to not send ICMP to broadcast/multicast destinations.
> 
> Fixes: c378a9c019cf ("ipv4: Give backtrace in ip_rt_bug().")
> Reported-by: syzbot+c13a57c2639c2c0d03a6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a0cc169.170a0220.1f6c2d.0004.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/icmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


