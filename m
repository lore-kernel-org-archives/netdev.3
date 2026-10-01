Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4B3769F0
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838361; cv=none; b=pmsASoajetPrYhEjhtyisN2JVARRuzNaLLsLoV+6nEo2jpoS3sgQCDRofDLey2oFUrBphut4c66LltDM7Vx3H1/1tZJHbBs2LefZ8H80s7jY08mZzXKNWCOJcNZ7Z2qu/R9eiMkiKPExvqWn4TbzyfcgNuGsbPgKqEjXyNbRzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838361; c=relaxed/simple;
	bh=IbopxjPoCzKlvvHW8/4/PJizp71LJ0jYs5Sz563vkBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKQ6js0JbUG85UzxTcA9uWqQMjT7DXfYhkTjM5g4JkSFQUzEImC2/8YCTQyVLVKs4cJEwTANq358J46GPbiHDdfVxI6e0LFtVFPugNYa/U4iEue/Qu0VI8NJv0+0qiTfNpGn2muKE1A16q0K+WymKZn429o6fArgRWfiOcxfFJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knzw8CIa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knzw8CIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CDF1F0089A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790838358;
	bh=XJ7R+ElrpnxBa6DAVtgH/R7fvLqOGL960kSWt5dCJ9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=knzw8CIazXTOt6SQceOxFzr6UoG4d0PiXl58e4KNCSn27ZrlOQ7sR37/TrDLJzgWc
	 BhTeOMjNlmpnAKVwag0LcnbqqVDH0SN9YT1DWaGHm/bDLCckpOyUK8FKBP4/kaOrHV
	 r94XMz/ppPvMMHQDt3sMGGoG28gsNu3WrC+JGhxFPz9qx4yD2obcDs8crqPv534pYj
	 hfFHKhZq4V6wp82lTe5Hs8WfPcbfUqJ+4O6mtLC1jJ1+Fu/6FuO008AYPc7J3O1Gr/
	 Xej47+JIHQKGv4JiC06Sz3KSZskduuhmvF4RrNSAxtCK26r2esxmAPZUqDAFv7RHfx
	 LvR+GbfT3ETKA==
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81bea216172so2975777a34.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 00:05:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBykE5ABFnuXkipT/mHmNssdWjMn+pBr/ucRHooVswAb5AZ9Br4c93FggJVFctK4DRduRnTG/s8=@vger.kernel.org
X-Gm-Message-State: AFuF++kzXbeviHveVK6qq6Crk09rWZQ/KUEqFQ/4oEA002ZzjKYPGkUD
	u4jZxvdcN2iPHT9FUHojHt83KRmeolCnJJCEmSOwOLUQJ3mU9SfQBZm4oMz39SHhHuo3DTym/WJ
	SRIjkR8L702mgmERyEevg3Orar9OM5ig=
X-Received: by 2002:a05:6820:81c9:b0:6dc:5ccd:a0bd with SMTP id
 006d021491bc7-6dcf5442dc9mr4214357eaf.33.1790838357438; Thu, 01 Oct 2026
 00:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928181554.85766-1-omar@blockcast.net> <179061959167.31693.11895969550331516671@kernel.org>
 <20260930222700.45470-1-omar@blockcast.net>
In-Reply-To: <20260930222700.45470-1-omar@blockcast.net>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 09:05:45 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiqw_7Mxa5W1EQgw2=KpJNNxG=cBLXsHvpio29GvD1UKZg@mail.gmail.com>
X-Gm-Features: AclHuK8Ah8EWWi4llXxbTO1nKhuE2OSHUxQopb875Y107JX0Vth7_tpLGa3czjU
Message-ID: <CAL4Wiiqw_7Mxa5W1EQgw2=KpJNNxG=cBLXsHvpio29GvD1UKZg@mail.gmail.com>
Subject: Re: [PATCH net] amt: do not offer software GSO on the amt device
To: Omar Ramadan <omar@blockcast.net>
Cc: netdev-bot+sinfo@kernel.org, Taehee Yoo <ap420073@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:27=E2=80=AFAM Omar Ramadan <omar@blockcast.net> w=
rote:
>
> Found by code inspection: an LLM-assisted review of drivers/net/amt.c
> while I was working on an IPv6 outer transport for amt.
>
> It has not been triggered. I have no reproducer, and I have not seen
> it in production or in testing; it comes from reading the code. The
> path is a GSO skb, for example from a UDP_SEGMENT sender or a GRO
> merged UDP flow, that is routed to a relay's amt device: it reaches
> amt_dev_xmit() unsegmented because the device offers
> NETIF_F_GSO_SOFTWARE, and the outer UDP layer later segments each
> per-tunnel copy at the inner gso_size.
>
> Testing: W=3D1 build with CONFIG_IPV6=3Dy and =3Dn, and
> tools/testing/selftests/net/amt.sh passes with the patch applied, but
> amt.sh never sends a GSO skb, so nothing exercises the changed path.

1)  Note that tx checksum offload is off by default on amt, so the bug
would not trigger by default.

2) Please take a look at Documentation/process/coding-assistants.rst

3) A better fix would be (for net-next) to call udp_tunnel_handle_offloads(=
)
in amt_send_multicast_data() like other UDP tunnels do
