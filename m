Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3A3E40EE
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790517569; cv=none; b=F+IZf1WhXWNU6242bqszUoJ6rkwKtfWz/G6E9b80kVRfKeoeuGaf7kyRub8dsnosbrA4m6bwOFmWzz0Nck0TxN5HiAXJmxwXx25fIa9z5+TgaOZG/+tngzTieWxTj+bVTzp8AV9Sl0/Kz1btg5CZcd8mJsdiemqvZ4ImnItn+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790517569; c=relaxed/simple;
	bh=Dc3hU+I5mrqBnL/3yLvlMcQUORjHrKOzk+cIIchC69M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn/43Lgeu/oJEpE3dDWeWaOEeotcK6gBRJ2Uz2CxmbxUqe3raz2Jj0tMucIaA+famhD9Y5k1KfyMS+CA+nWGCbWNrJemYGFZ2qTyt6wCDcwgh6Rayr9cEK3wD6AXQ7P6cr2FrEyAkAg5U1Z9Wasrwq0qVOmIPaWT+bPHQhty+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHRuTF1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHRuTF1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511C01F0089E
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790517567;
	bh=9Y5aMWqoAq1uOVxpOyjGeC3g3XkCWAkdCuPxoE8cuBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nHRuTF1+HUuyhJkKZe5l1P1W74M3GohQhRXuAYdfnAl7xY17Xdigx9DegKqOWRStS
	 c0sZmLO1iPLzo6mD8E8tidsrfHiv9tr+pU/Pi16IzJnSar5NHZegmZM2ct9Tz3/kzH
	 lBBvVkw5+YW23jFcfxk29RWNgDDHsERL9LuRbMMe/1cd/Ie6QJFZuS6XewX23JZJNL
	 duoIM1bjsir4XU/VXtiaPLp2DnwWivuF69zOz5DE6iR/Ogt9I9TDRunti/sso+4ves
	 jn8FBkbbE4EQOMNFS/ByktErl61Mzm9U7XMorvcoid4oosrH604IPDZ3T7aAE0pSW+
	 qT/DOqp2uyQPQ==
Received: by mail-oi2-f41.google.com with SMTP id 5614622812f47-4e9818966c6so232504b6e.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 06:59:27 -0700 (PDT)
X-Gm-Message-State: AFuF++kwJW1hpDA3vSsysWhaf0YylG0A7IjyjXILeAbUsntiMwbYaXrm
	KOrI/YDjSVIh2mV6phfeQweuEFEcr75X8LS+PRuTftGt5pn+LRQTe/aHz2TrUddw25LqKz0pDOO
	aUaI2CBfFVY4v34aJ1H4Ppo0Guh6ZoNA=
X-Received: by 2002:a05:6808:1817:b0:4e8:721f:283d with SMTP id
 5614622812f47-4e8721f3e12mr2278833b6e.38.1790517566507; Sun, 27 Sep 2026
 06:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790082243.git.petalzu987@gmail.com> <79c2c81b7c61c61b242dbe1cc9b2db9860524a3f.1790082243.git.petalzu987@gmail.com>
In-Reply-To: <79c2c81b7c61c61b242dbe1cc9b2db9860524a3f.1790082243.git.petalzu987@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 27 Sep 2026 15:59:15 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiq6ughX_9V5cDxnb8GT-LTEunhdTq4T_YbhV2mq3zFhBQ@mail.gmail.com>
X-Gm-Features: AclHuK-tZ2AsBvnvtM7lmolBaWy7jW9oHQr9QF_kOj1-HeuNpD3TMPw_ARGI0OM
Message-ID: <CAL4Wiiq6ughX_9V5cDxnb8GT-LTEunhdTq4T_YbhV2mq3zFhBQ@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] i40e: validate TCP header before ATR access
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, lucien.xin@gmail.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, sln@onemain.com, 
	fw@strlen.de, petalzu987@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 8:23=E2=80=AFPM Ren Wei <weir@nebusec.ai> wrote:
>
> From: Zixuan Chai <petalzu987@gmail.com>
>
> i40e_atr() uses ipv6_find_hdr() to locate the TCP header. A successful
> protocol match does not verify that the complete TCP header is present in
> the skb, so dereferencing the result can access data beyond the packet.
>
> Check that the complete TCP header is available before inspecting it.
>
> Fixes: fd0a05ce74ef ("i40e: transmit, receive, and NAPI")
> Cc: stable@vger.kernel.org
> Reported-by: Florian Westphal <fw@strlen.de>
> Closes: https://lore.kernel.org/netfilter-devel/aq1HaYS96SNn7HJY@strlen.d=
e/
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/et=
hernet/intel/i40e/i40e_txrx.c
> index ef5e657816f0..cdac279b8aed 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2911,6 +2911,9 @@ static void i40e_atr(struct i40e_ring *tx_ring, str=
uct sk_buff *skb,
>
>         if (l4_proto !=3D IPPROTO_TCP)
>                 return;
> +       if (unlikely(skb_tail_pointer(skb) < hdr.network + hlen +
> +                            sizeof(struct tcphdr)))
> +               return;
>
>         th =3D (struct tcphdr *)(hdr.network + hlen);
>

pw-bot: cr

1) Please do not add bogus Reported-by: / Closes: tags. Florian never
reported an issue in i40e, unless this was not public?

2) How can this code be reached with a truncated or non-linear TCP header?
Unlike ixgbe_atr(), i40e_atr() returns immediately unless
tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6) is set.
Those flags are only set in i40e_tx_enable_csum(), which only acts on
CHECKSUM_PARTIAL packets and runs right before i40e_atr().

Furthermore, i40e_tx_enable_csum() (and i40e_tso()) already assumes the
network and transport headers are present in the linear skb head and
already dereferences ip.v4->version, ip.v6->nexthdr, and l4.tcp->doff
before i40e_atr() is ever called. Even within i40e_atr(), hdr.network
is already dereferenced prior to your check in the IPv4 branch.
