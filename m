Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97C3D3B3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770147401; cv=none; b=gNnuwGRWTXi87OtR0uAAgWmKDZ0vD9Vo+udAAHbGpadj1RxUq61GOi51GtslXdYsQJN7dEZoUBXsjmhjmcuBJeWa9lIDduY11+ABsHuOIX4DwH4T/XpL4rUoVNCLGEBfHKp6lKzWsZ+edy92jt5jHxallG5IHIx4CUE+EoxAElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770147401; c=relaxed/simple;
	bh=VXxXrFR7FOAeHWVzQhn1Sz/LPEHliuLvfiDtTIU10YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zn/FulawGQRLVEUa8ro6jJnPm8yUAGMPDpXMLkfbMAK9jIgGuLxUcnbuti70xGYJzvWIFf+Ltpd3u9Y87MZAf5R4tsZqJrNYBEJ8N2jPVt/6x3w41r0tNDIyB44YjO24aGGRRKiDyiyhKAzWqw9ADayTZImSxzUbLemCWfj6c8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFW8nQd/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFW8nQd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5C7C19422;
	Tue,  3 Feb 2026 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770147400;
	bh=VXxXrFR7FOAeHWVzQhn1Sz/LPEHliuLvfiDtTIU10YQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OFW8nQd/RRf7I/7OqnEfel1RFGngPtyZVUNhxXzPI47EKSr0kfV6axyAZWiFGBey3
	 2RG5//5WTGQsb25QFg1rYW0hgQxpQz82+K1fatUS8nyZdFLf/48yIGTRdNkA8IExm3
	 r/zCQgQd+tL1Y/aQ42gC9I//frrpoqIf8+7IbrhXjbaJJDJEulTHgkJtziE6SE9xKD
	 0ECrlvMs23rtfwIS51ZTIh959pHENEr3YWp/zG4kpdOG3TRnkFcTILsIS2g6Rqxdfq
	 fvRTTUEncfJQB48Ab5AHNSB7O88GTkjFbMMY1Pimmjf7C1V0uZB6KhX6M2gxtRx/1X
	 22oBGShxMLMBw==
Message-ID: <b0ed91ce-cf96-430d-aef9-9b42bc52277c@kernel.org>
Date: Tue, 3 Feb 2026 12:36:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] inet: RAW sockets using IPPROTO_RAW MUST drop
 incoming ICMP
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
 Ido Schimmel <idosch@nvidia.com>
References: <20260203192509.682208-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260203192509.682208-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/26 12:25 PM, Eric Dumazet wrote:
> Yizhou Zhao reported that simply having one RAW socket on protocol
> IPPROTO_RAW (255) was dangerous.
> 
>   socket(AF_INET, SOCK_RAW, 255);
> 
> A malicious incoming ICMP packet can set the protocol field to 255
> and match this socket, leading to FNHE cache changes.
> 
> inner = IP(src="192.168.2.1", dst="8.8.8.8", proto=255)/Raw("TEST")
> pkt = IP(src="192.168.1.1", dst="192.168.2.1")/ICMP(type=3, code=4, nexthopmtu=576)/inner
> 
> "man 7 raw" states:
> 
>   A protocol of IPPROTO_RAW implies enabled IP_HDRINCL and is able
>   to send any IP protocol that is specified in the passed header.
>   Receiving of all IP protocols via IPPROTO_RAW is not possible
>   using raw sockets.
> 
> Make sure we drop these malicious packets.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Link: https://lore.kernel.org/netdev/20251109134600.292125-1-zhaoyz24@mails.tsinghua.edu.cn/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: David Ahern <dsahern@kernel.org>
> ---
>  net/ipv4/icmp.c | 14 ++++++++++----
>  net/ipv6/icmp.c |  6 ++++++
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

