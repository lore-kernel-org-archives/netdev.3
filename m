Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A5311C32
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428291; cv=none; b=p+F0jhW/Q01jmbClVUGnu1K8LPzO6q+DUHp7yY4gI5dK89GxqyzJMC+Yen1AY38ShPSeAp2yFjD1an3f2ZxppWxwNMCuuTU2qa1b6bTm3l5maMzbGCDo1iOdwAzIMorutrm92u+MJhGzPyp6ZRnIQbv5POvDxVbfATYgYDEa6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428291; c=relaxed/simple;
	bh=DBBHKT23v+NhiJykhf5+hSDnn/wAAJcDra3CQ9FrTHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLTcKwPlCIZSpGa041eb9p59PU9Pn1ImeRPECSiVEk9r7UxR2M3JZ6xsJk5JkSTKvUdNlpPBYTEjL8KS0T4vwyxvQag9Xqk4gFx3WEg71WyrZda5NLv0Zm/AmnxD4NKEbVtR6EZ76nBXgdqlEsg1g8obJRmn/ohhY11wnweAbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1NJ0AAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1NJ0AAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59101F00893;
	Tue,  2 Jun 2026 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780428290;
	bh=HaqkAdu1vI9fa4GXKVN8THfxCfDAAzYu/8HtB8lFpzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l1NJ0AAle7xkpz24q+pOgyD9H0zRS+KexTqolCVeR4MYmyw6NqerknehdjUZmpGte
	 c4ruD0dZb3m4bkMa9rFxNeiYuCBkWy8e9wglxiSMBZWZnYt9RRC4Trxo8s1/qAY1RW
	 BqzU7wSFpe263IcDU67qNmW6ls88ZNbH2MhJ+D+J8fUFN4Si8mTASSSYhLxLH9x7OD
	 obRqF+fkXushP6Wt9hZBfG41nQdHET5qHfGp8doZgttlsJwNtK6nQQcVUPxIZ9uz+Q
	 8Q9DZUSM9iXnjKCxawUsPnL6QeLeYWo9JUSwq8jyrB16IMyprN5yoAeNt5NHrbmQ9q
	 Z8AXL1Zw2Un8A==
Message-ID: <037d8674-9879-4d50-b90f-88c59178c40b@kernel.org>
Date: Tue, 2 Jun 2026 13:24:49 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Tamir Shahar <tamirthesis@gmail.com>, Amit Klein <aksecurity@gmail.com>
References: <20260602161547.2642155-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260602161547.2642155-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 10:15 AM, Eric Dumazet wrote:
> This patch restricts setting Loose Source and Record Route (LSRR)
> and Strict Source and Record Route (SSRR) IP options to users
> with CAP_NET_RAW capability.
> 
> This prevents unprivileged applications from forcing packets to route
> through attacker-controlled nodes to leak TCP ISN and possibly other
> protocol information.
> 
> While LSRR and SSRR are commonly filtered in many network environments,
> they may still be supported and forwarded along some network paths.
> 
> RFC 7126 (Recommendations on Filtering of IPv4 Packets Containing
> IPv4 Options) recommend to drop these options in 4.3 and 4.4.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tamir Shahar <tamirthesis@gmail.com>
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: use Ido's suggestion.
> v1: https://lore.kernel.org/netdev/20260601124157.699463-1-edumazet@google.com/
> 
>  net/ipv4/ip_options.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

