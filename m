Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBF424D5A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838937; cv=none; b=O6A0VpSnipnlMcfvNNLDGCqrHrbTSdDfNTNx6bgTF9uc3PKSiXGJZrgrEigcGRh0matoLatmOImBdECrgaS1kAzQCnRMHttyDy6vBshap8Fnx9jDq4el4tevE0QE355H4PX2e5Oc4Hi0xLdm11Qk1Z1dhRLZGaDpF2r0h7jK9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838937; c=relaxed/simple;
	bh=ssCO/B8xGShkRHmKVnJnoFWpOgm2MxYZm5NUMJiQu+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aapo42b3Dm2LUEunLDwlR3ScXDEBotoyb7PXpRrYD3axuhWoQFRv96IpTBsk7EDqIBFXlLrP0/9XIMhcvabP2ffoD4j/lu88R/12z5G9/bkZCHAkXCw+OczepPUnoNzqjd6Se3BiC7SVY+TzyydamG3MM8OG0u3Pvi6kVQyBWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFJHEjDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFJHEjDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDF41F0089C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790838931;
	bh=ssCO/B8xGShkRHmKVnJnoFWpOgm2MxYZm5NUMJiQu+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XFJHEjDegou+QNR6o5iUZ/Ep8W87rsm129LLm0wFTcvJIEOX8OlY5AugVq58MDjdx
	 xj0EpgE3WzIGMjUDbOTcYMLJl6CO2c3F37fc6MAlxCPQLS2awwpSe1jtaUqV2sGQd8
	 80CYPKNg6zNtai65TppJmmWRjSb9NpMSiJERBhvpj1P+NQEMzX/xwDy6X6F647+Dmq
	 8drvTUfB/fhU9djPw6MfWDbZlyJuoyp7Rv5CWHEJ/s6FEB3rGmI8HfV+O6Ti5QF2WE
	 Hf9M3bDgN4h7z2y3HfPr1dzC5WM5yQJwgM9XAD8SLnoeMpQsaltfgXFKZ91nCMshhm
	 l5a3P96lXTZlQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-46556b9e02cso338884fac.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 00:15:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxDnWnQBQltCgbhuSjyAvb5kVon1nk3WGTtBT4dRu76VMdi0577bsRoDFOQtWILxMWcu2J4+Ng=@vger.kernel.org
X-Gm-Message-State: AFuF++kGKTCRiSUpTlVa6/GnB5o4cvpgLGcG21CN0Ee8dTevICLLpmKF
	GbpuerUAYAxRrFw2LTT81tpMvweUR/p+eC+sKb0UUpyjQrNlgdK8Z0ElnOC/WxqxCu5O+d6ehvk
	0FO/TzVngeOJIktN7xTZErJFY5CEAk5E=
X-Received: by 2002:a05:6870:9f86:b0:49d:c801:9830 with SMTP id
 586e51a60fabf-49df04b038dmr1840758fac.22.1790838930230; Thu, 01 Oct 2026
 00:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928181557.85796-1-omar@blockcast.net>
In-Reply-To: <20260928181557.85796-1-omar@blockcast.net>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 09:15:19 +0200
X-Gmail-Original-Message-ID: <CAL4WiirokTFzOqFNr0eOWucpqkJoGR_4s19cBAEN3O7E7ydm5Q@mail.gmail.com>
X-Gm-Features: AclHuK96pD1JzfPlXhO2WoV-1MufwzYMW3UIxzfgANqozXYGqVKlXckFxTqJKZI
Message-ID: <CAL4WiirokTFzOqFNr0eOWucpqkJoGR_4s19cBAEN3O7E7ydm5Q@mail.gmail.com>
Subject: Re: [PATCH net] amt: pull the AMT header behind the transport header
 in amt_parse_type()
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:16=E2=80=AFPM Omar Ramadan <omar@blockcast.net> w=
rote:
>
> A gateway's encap socket passes ICMP errors to amt_err_lookup(), which
> calls amt_parse_type() on the quoted datagram to see which AMT message
> failed. On that path skb->data points at the quoted IP header and the
> transport header at the quoted UDP header, and icmp_socket_deliver()
> only guarantees the quoted IP header plus 8 bytes, that is, up to the
> end of the UDP header.
>
> amt_parse_type() pulls sizeof(struct udphdr) + sizeof(struct amt_header)
> bytes from skb->data, which on this path stays inside the quoted IP
> header, and then reads the AMT header behind udp_hdr(skb). An ICMP error
> that quotes only the IP and UDP headers of a Request, the minimum RFC 792
> asks for, therefore makes it read past the pulled data, and past the end
> of the packet when nothing follows.
>
> Pull up to the transport header plus the UDP and AMT headers, as
> vxlan_err_lookup() does. amt_rcv() is called with the transport header
> at skb->data, so the pull on the receive path does not change.
>
> Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> Signed-off-by: Omar Ramadan <omar@blockcast.net>
> ---

Reviewed-by: Eric Dumazet <edumazet@@google.com>

Please read https://lore.kernel.org/netdev/20260928181557.85796-1-omar@bloc=
kcast.net/
