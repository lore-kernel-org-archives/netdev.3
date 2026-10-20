Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528059;
	b=yTJIU0X8ZhF5LHC5z1l4faktA31FXj1dKzQBbcbujtIL1tySIiePijxLENa/7cTuosTN
	 Ru1ZBFYcMLUe609NyQB9WhJ7gFqM4WBfuY8A5EDav1qXARd1Ey/8PJ7akDKCJsaiN1WGe
	 uzesNdRyrZhI/jMa1c3ftayo+XRyX+Cdst6oOREIM4EtiXS6+nzKNhcm+kBv7QjQ3r1yi
	 U0v/f+kXI603Ls7v8YiNHlgTncdAt/zK1MJ2xcJ3IhPvEoReexfTZYHDNpQTu8/nQTSPZ
	 /9Zh/aRj1qJBWRV+bylpdMhSpcCE3IH8cPfIfLkZbTFrF5fGYdCZdZ32cbTfRoPWSrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528059;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Mm8j0XhfffO5W2SZHZPf3exKju/4xVfUOaT00ZyRTb0=;
	b=WrG3S7NGm+OymThj1aNWijPvnlBXWluGk/xhLwZPGjgH+R9HyEQ5FJqUvDIrpB9K3YmF
	 uRdQGkX4Qpeh7+N7dhT89h9ER18sX+CRNJAdWnX2BRyTq2B2olV/OBdnGg2o1FCRmGHhx
	 6AE8d5A7BiwpnZAxfDv7uZEoMQ3NFYaY2clufdEE+jL+FWhPfwrkfZl9XTSWfdFwLBy1O
	 8RozQRZQGRRvBbSTaxkXDUUClzRIA7mFkpoBkhHGW1hLqusCxtEv7yg8DHtMQwuiA7lHy
	 oEeJNv9GdTQGLcWNeoHA94rNKoYiW3daFU3gSq1bwEw4hr8QEbRc8PGsN+f/OJcUhYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgsPtdZg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CABC606A31A;
	Tue, 20 Oct 2026 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgsPtdZg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2E51F000CB;
	Tue, 20 Oct 2026 20:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528059;
	bh=Mm8j0XhfffO5W2SZHZPf3exKju/4xVfUOaT00ZyRTb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZgsPtdZgYmMEJPt8BwA+JYdWGCcf4f5KZpfgQwnRcwQi7yjJ2US2+RMA/Q8Y5vOGr
	 IPJ6czIW9urBUN+QK/W/Xl1lE0mOvOxysa2pkmwzIe6TMpt/AJ8LOQpFYyyF6SEGqx
	 u7+QZ4xwlD5pciVvBExeDnv/xzu/yX3Sb6CixcZbUEq8nZDj/6a2CUxBvvREckxp/Y
	 Qb3ntthD5T1kS8kz+K1ck6xe3m41nDQJEdv4paPJ3ZENOLXauXXdcjb8VdaYdVODHt
	 J6WxetKi72+ZHhepA929E2Tdwe3JF2woEA8wGupi0brE2w5boPJW2OC9zdd0Ss9dQu
	 Y/XM+IP8yPsRg==
Message-ID: <6b84d4b4-e040-40ed-8d60-c065fd02ad4d@kernel.org>
Date: Tue, 20 Oct 2026 14:27:37 -0600
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] seg6: fix transport header for inner IPv4 with IP
 options
Content-Language: en-US
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Lebrun <david.lebrun@uclouvain.be>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hazley Samsudin <hazleycryilis@gmail.com>,
 Stefano Salsano <stefano.salsano@uniroma2.it>
References: <20261020023336.34-1-andrea.mayer@uniroma2.it>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261020023336.34-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/26 8:33 PM, Andrea Mayer wrote:
> The End.DT4, End.DT46 (its IPv4 path only) and End.DX4 behaviors set the
> transport header of the decapsulated IPv4 packet at a fixed 20 bytes, the
> size of an IPv4 header without options. They do not validate the header
> length either. With options, the transport header points at the first
> option byte. The effects include:
> - ping -R sends an echo request with a 60-byte IPv4 header to a local
>   address through an End.DT4 or an End.DX4 SID. Since icmp_rcv()
>   computes the ICMP checksum from the first option byte, the request
>   fails the check and is counted in IcmpInCsumErrors.
> - A UDP datagram can reach a port that an iptables rule drops. The rule
>   checks the UDP header after the full IPv4 header, while the socket
>   lookup reads it at the fixed 20-byte offset.
> - With an inbound AH state, ah_input() reads the AH header at the fixed
>   20-byte offset, but copies the IPv4 header over it with the length in
>   the IHL field. A packet shorter than that length can make ah_input()
>   write past the end of the data, into skb_shared_info when the skb has
>   no tailroom.
> 
> Validate the inner IPv4 header length with the new helper
> seg6_validate_iphdr_len() and set the transport header at that length. A
> packet that is not IPv4, whose header length field is below 5, or whose
> header is truncated, is dropped with a drop reason. The fix is limited to
> the header length, which the transport header relies on. Other checks done
> on IPv4 input, such as the header checksum, the total length and the IP
> options, are not addressed here.
> 
> Found by code inspection while reviewing commit 44930446dde4 ("ipv6: seg6:
> clear IPv4 control block on IPIP decapsulation"), as a pre-existing issue
> that Sashiko also reported on v2 of that patch. Without this patch, a
> bpftrace probe on ah_input() shows the reporter's reproducer packet
> written into skb_shared_info. With it, that packet is dropped before
> ah_input(), ping -R no longer fails the ICMP checksum, the UDP datagram
> reaches its real port, and the SRv6 selftests still pass. These effects
> reproduce on an unmodified kernel, without error injection.
> 
> Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
> Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
> Reported-by: Hazley Samsudin <hazleycryilis@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260809221915.2ffc1ecd0f445fcb70270e31@uniroma2.it/
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_local.c | 56 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 48 insertions(+), 8 deletions(-)
> 


LGTM.

Reviewed-by: David Ahern <dsahern@kernel.org>



