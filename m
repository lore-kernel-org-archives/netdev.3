Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792925536;
	b=C48cQt6ODh/wdj8+gIyKPl25lQAqK6DQoOK1UUaizQ/fSvsi3W92n077N2C1EZB7//w0
	 XoO2hl2LmljGoMef2YmlECsY4n5BpXpL8vJnOBnjRqYFPEzdOdVS6/Zb/UDzXyGvjtl8X
	 w8WdnkPWXuYYg9+sDHyWiQTUtH/f4lpoqoUlIqYBa7+i2VzGEJupr1XGRANSqpHe/tqiF
	 gYHjrDGqtrqPDVUzToAJEGpImj8NLsdaE+VK4DhfbBMX31YRjCix6Oi5jhPlyvF4jdHsL
	 EKW07/Gsv6RGgST0fE0XDoasidZtTf+YdjHD73208gYlVQyi5Op6UOtAJ0JlvNS9d9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925536;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hPKSPo730DdMIk8vI3kNTPBHSLfjkeDsFQWYgCdWptQ=;
	b=VIsqYqCg8Y/18VEiSLUo8AzERKouxitG0R74zLFioKm2s0GLeansT27po7xvIX8HeAVU
	 1p6su2ofjDFXLp9FIWfXP+2ZjjtnJpOcyfLOX8RJjeDjahkO5gQTBjwNt3R151eP8qyKm
	 13pO5i51YGJKuQwvGQ5wmuATWPQDJzrLwmLCpBPbrHQkuBLD9D10/qPfUL7Y7ImSsqpS1
	 mdcDTLR1VSzFYsqTNRyJKpUn5aB+gTmpN29+gjhmUNKFlmtj9u+kRHWzlUHDw0dHtDBHn
	 XmHKP3S6feEIDyAkmX73zkxvVGcKEkKsMKd/SCwK2DJVKvIgd3ijlFVuvFGA+c+jlWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoCjN7mY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F422606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoCjN7mY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AAC1F01828
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792925534;
	bh=hPKSPo730DdMIk8vI3kNTPBHSLfjkeDsFQWYgCdWptQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AoCjN7mYl33hi24P5LWbL86/NhclCu4RS0pStpBPOewB+IwblOR4Tfr07z7dW76Gi
	 xZx+Qa9WBRdhNpcw3M9CiYn+AxieakIRIBl9fV960JABdzohScGn7OqPEuB7ldda1U
	 cQ+Ysb09EpV6g/PjdeLRBgU4myV7Zg5x+azXX3mcFJDY7Gwsx3JfHvKMs0/A/x3OES
	 NrO1kYBe7EQVtDhBzH0gfiaJORGR8QYHpdkChG2aBcyJc/gcLYBxXS8LXe8/Vu2pQj
	 Rb7ShKif6fvkcJYhqRAvzg7z20vBVPVwI+S577+z62M7lWmoXAzrValZStpLqEdkiX
	 GCDgWggYOM4Lg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4a76f63b243so2310556fac.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 03:52:14 -0700 (PDT)
X-Gm-Message-State: AFq9FYLUMuBqf9Ux6I1s6DOi2VLe47wuSz6nP8F9sQkRTZKspAt55R9p
	jT9qLFdJ3UsK3E+MPThRDIpyyZIjWkFbV/zNwpLnnUkq2418r92LJTXNkkTL6rJ+7PRhbR2xdAq
	x19dfTJt6r+wVsGzMxFu44fFyZ7rYeKo=
X-Received: by 2002:a05:6871:c91d:b0:45e:d645:e03d with SMTP id
 586e51a60fabf-4a83f4cf2bbmr1508221fac.11.1792925534172; Sun, 25 Oct 2026
 03:52:14 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025071729.34967-1-idosch@nvidia.com> <20261025071729.34967-3-idosch@nvidia.com>
In-Reply-To: <20261025071729.34967-3-idosch@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 25 Oct 2026 11:52:03 +0100
X-Gmail-Original-Message-ID: <CAL4WiioCj01X+x=kmq4DAsusQGHSbUTi3ZZSrVNxX4dVHks_aw@mail.gmail.com>
X-Gm-Features: AclHuK-w_CWxZjTECE6jJnpscRA3B6CFD46erB9ilUpSlsm3V1pz5ChEGv915LU
Message-ID: <CAL4WiioCj01X+x=kmq4DAsusQGHSbUTi3ZZSrVNxX4dVHks_aw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ipmr, ip6mr: validate packets injected into the
 register vif on xmit
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	yoshfuji@linux-ipv6.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 25 oct. 2026 =C3=A0 08:18, Ido Schimmel <idosch@nvidia.com> a =C3=
=A9crit :
>
> reg_vif_xmit() passes the packet to ipmr_cache_report() which copies its
> IP header into the IGMPMSG_WHOLEPKT report that is queued to the mroute
> socket. Nothing guarantees that the packet contains a full IP header, so
> when a short packet is injected on the register device (e.g., using
> AF_PACKET), the copy reads past the end of the packet and a recvmsg() on
> the mroute socket leaks the uninitialized bytes to user space [1].
>
> IPv6 has the same problem [2]. Its reg_vif_xmit() does call
> pskb_inet_may_pull(), but the helper keys off skb->protocol and does not
> pull anything when the protocol is neither IPv4 nor IPv6.
>
> Fix by dropping packets whose protocol does not match the address family
> of the register device or that do not contain a full network header.
>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
