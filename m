Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433326;
	b=alF60HTKhfbTnuxwqOtNsshIJDKpcqGUaQqBPDLR8lgyedwP6CWkzENsqzW+P8z30NLW
	 iZzwHkG5sPC01nExvXp52GMMvJmMM7hAsBoHnyW2RfV3MMGMgiOHY17PRxNEsPxXsHDaG
	 oAwGMzvSuO9IvZbMNEc33rS9OiK+kqXORi/y1QG6sefza28wxC0+uDOep9w/dhjcSpHxH
	 a8bQ4lx/+WeIZ1hw0gT7Db0ayYCDw/P15Mu/LFZ4yguobt0v6jr58AR/7J3/ocq+SXVFT
	 h1XBW9bPWPXXIw/1TEofTqIOKe8oHTart6AQseS0Swo/m4HFZq4zNZstYHwDNzuf0qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433326;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ocFtF9sG4MlVq1jdsKR1b1G+co9+aktH46Vw5Jqpago=;
	b=LRHpzceGY6N5lfMuH4e7qpHyewLlvbJKiFTlulg7+3x9ixnR5LmhuDgIGX9P6XoLAMzV
	 MJPk1BtsPENm3lDL9UkDpY2qTXxgZVY856EqqkJHHGOybtTNXofjZs1cmVCbXnf4vPldB
	 B0n99vzVAUntYYidFUI06RQ0V+n8sg3vk21p3VuwHr9djMPQfEbPXFlVDcovfSPPEBflk
	 AlbE7XvxEI7kYL4rXGRHWUiSUl1V7WVC7dOBEehGWrolbAoPWjZf1VQIYq75zz/b0IkUq
	 AvrWZy7I0bOi+Nyyifm07GtfTxGR7EXwOkayHHIWm278jC4fGy6P/mvK6oFeXty+p8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoucYg70;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E2606A31C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoucYg70
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0CC1F000CD
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433325;
	bh=ocFtF9sG4MlVq1jdsKR1b1G+co9+aktH46Vw5Jqpago=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PoucYg709N3rmtxZH1tgGgXzfaf/i6358wQY29XncbH+TIv8YHlSkuvAkLoFMsPDH
	 f9KIYyuDBMrbQPhOfIRIcH4nkFIWssOlZkJ0GeuOZqTwx6/AEkbLtmF3TXzx/gRLij
	 LuCbhNfP993+PJczYLWvXzei6BwvdCnHcS6tILGkVHOUZt3OdMaHCCXSd9mmg3SJsQ
	 qhLzF+NkV7ZXIhHJ7vlSk4IGMG48GNpRFno/mB498J+g3lZCyi3siDQ4ZQ7ZQivT0P
	 BCbuSCndUD4IwA39Es7wrZRiyYqNz5YLPizs3pjbAZBWb8Yb8jh5hJpsYEy8ar/bT0
	 9CZLHb/Xq3OCQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-486f013db83so750336fac.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:08:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxU0HDlB37RCPV1RtU/VAAm4Q5kxuBUbAC+ej+jK5hdkmEkT6l/W/Ttfh71Ku+JWR8fzplchGQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtDh7UMuw0+UvIIS8NZ3xbn7Aj1X6CTLOhfN/FgrXBau7sjZVZ
	dS/4EiIHZQ/o6nduNW7F/IIJonMWrmlGZOxvv5nKnxAxK3kXkamdzn8vev0eaVkTyCEV/7JU+2t
	No+zp6rHw8XheQgCAp8w7y5pgA+fRXXg=
X-Received: by 2002:a05:6870:ebc7:b0:48f:e116:db7a with SMTP id
 586e51a60fabf-4a757b8982bmr6704028fac.56.1792433324846; Mon, 19 Oct 2026
 11:08:44 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019174152.2932829-1-cjubran@nvidia.com>
In-Reply-To: <20261019174152.2932829-1-cjubran@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 19 Oct 2026 20:08:33 +0200
X-Gmail-Original-Message-ID: <CAL4WiipZy6bt2OdhRPMieWsQ5PMNdzZa9=ymFG_ApL+L9Trdtw@mail.gmail.com>
X-Gm-Features: AclHuK83MVnli20kwP0_T83obYd87-wwM1s5t7PBnH-1oKhOuNWpz9ANmOD5k9s
Message-ID: <CAL4WiipZy6bt2OdhRPMieWsQ5PMNdzZa9=ymFG_ApL+L9Trdtw@mail.gmail.com>
Subject: Re: [PATCH v3 net] net: skbuff: don't copy alloc_cpu in skb header copies
To: Carolina Jubran <cjubran@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 19 oct. 2026 =C3=A0 19:44, Carolina Jubran <cjubran@nvidia.com> a =
=C3=A9crit :
>
> Commit 68822bdf76f1 ("net: generalize skb freeing deferral to
> per-cpu lists") added alloc_cpu to struct sk_buff and placed it in the
> headers group copied by __copy_skb_header().
>
> This is wrong for newly allocated skbs. For example, skb_segment()
> allocates a new skb and records the current CPU in alloc_cpu, but
> __copy_skb_header() overwrites it with the value from the original skb.
>
> If the original skb was allocated on another CPU, the segment may later
> be treated as remotely allocated and unnecessarily deferred there when
> it is freed.
>
> Move alloc_cpu out of the headers group so it is preserved across
> header copies. Copy it explicitly in skb_clone(), which allocates
> the skb object directly instead of going through __alloc_skb().
>
> This was discovered while investigating a throughput regression with
> software IPsec. The load used 512 IPsec tunnels carrying traffic over
> VXLAN, with 512 parallel iperf3 flows and an MTU of 4500.
>
> Before the fix:
>
>   16.09%  queued_spin_lock_slowpath
>              |
>              --15.90%--_raw_spin_lock_irqsave
>                        |
>                        --9.37%--__slab_free
>                                  kfree
>                                  skb_release_data
>                                  napi_consume_skb
>                                  mlx5e_poll_tx_cq
>
> After the fix:
>
>    6.84%  queued_spin_lock_slowpath
>              |
>              --6.57%--_raw_spin_lock_irqsave
>                       |
>                       --5.00%--__slab_free
>                                 kfree
>                                 skb_release_data
>                                 napi_consume_skb
>                                 mlx5e_poll_tx_cq
>
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
