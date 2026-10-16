Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A82E5429
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142391; cv=none; b=hpC4daubFg96dIw/rrIunf5fKqy90gxo8gXIjFvoT8ipxHm7sFZ0obndYCW/yoB/Kypz70CK7QcwwMj4DNDWpnUXQEbVubTfTjK6xwEDwbf3RTmll/XM5MqJOs0Z+fKoW5fvzANBeIiBprR3+f8Hbt+B2+YWqJgVF99ALx8V1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142391; c=relaxed/simple;
	bh=DLAP9RC5mMtWUduIJZtAGgYZB/6qns/Bt1gDxt00Z7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=su2xyIL/v14PvikSeec+8duXdhDowjuxfYj7uCzsRr4PRCMITx+FlsEk6qq0om15+eSOFO97RZHQpsrzdhxYf2Am94wKQKJInDSKG/p+URntCM11O5EnX5xgcTOVUuiXjjvDaQDFYJ3egKTkDCt1Vge9Y8bx8yOSCbm1SKdw04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEQyMdWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEQyMdWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2461F000C5
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142390;
	bh=/t2tiqiWlMqEuUVPsB0DqO7U+OTFZo8AgKHUXvVj37U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cEQyMdWKJhwrXF/UMATfHCIhzTRV3Q4+Dn26UKufvH3C3USIPEpKhmADhJxgnebk+
	 ZlusZ59Vk5NZ4I8PsO+fCpNDtZepVz3pfC4tRbsYm3D7+sm4ij440aHclpKLFIsM5n
	 hbzW1vcCVUNFv790L90RgC1ECNU5onM/r3hixCe6n7A6YshaUiYtOl1YylOlJlGSvT
	 hjWFwIKPGmpLEiLPPzILgy4QDK5rIpiJStHr36seUtE5pSkuKadg83azIT7oDqlLxU
	 bQexpvG7U0fPF/C68B5qDaGy++/BECRElzXGbBS8GqqjR2ppnA8rnazYvo2pUDjK8u
	 cFblCvEWCYbGQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-49429181ce9so3500719fac.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:19:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzZmm1GVsFBT2GriT/bflpu+Jliz6UJq/sCSJVksEXoQ2FQrE8mG/RkYRGxWPWjKZvSj629FLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9Sq3Tqt/7pwrJBeBz3yB1CV4zb98oj3Mqkq3NgbnHuZ5e5Lkl
	H2euvOxTJ5983TC8txOAIdr9GfjjN4xT1ZxD/HRaTgutY6isjxOBq6RJI5bnlqX2MLD3q3greEL
	mGIW8U8mg9BWrBodYhWoHhXcpM5Yz2Ig=
X-Received: by 2002:a05:687c:2342:20b0:4a6:f705:25a with SMTP id
 586e51a60fabf-4a6f70611c8mr3943314fac.21.1792142389365; Fri, 16 Oct 2026
 02:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
 <20261016-bug-net-netns-move-rcu-barrier-v1-3-4157d798658f@gmail.com>
In-Reply-To: <20261016-bug-net-netns-move-rcu-barrier-v1-3-4157d798658f@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 16 Oct 2026 11:19:37 +0200
X-Gmail-Original-Message-ID: <CAL4WiiotbSnDNKgDyZTwK6v6_3hwBneyrm_tr9kp0skJExjs8Q@mail.gmail.com>
X-Gm-Features: AclHuK_b--R3M1UoWM1m-8RJlvCBIaxANRb4MJAPi8AtyNAqzB1vxYc2RDNdPMc
Message-ID: <CAL4WiiotbSnDNKgDyZTwK6v6_3hwBneyrm_tr9kp0skJExjs8Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: remove rcu_barrier() from __dev_change_net_namespace()
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2026 =C3=A0 08:10, Qiliang Yuan <odys.yuan@gmail.com> a =C3=
=A9crit :
>
> Commit 6549dd43c043 ("net: dev: fix the incorrect hold of net
> namespace's lo device") added rcu_barrier() before
> NETDEV_UNREGISTER_FINAL in dev_change_net_namespace(), so that dst
> entries released by RCU callbacks were on the dst garbage list before
> dst_ifdown() moved them to the loopback device of the old netns.
> Commit 070f2d7e264a ("net: Drop NETDEV_UNREGISTER_FINAL") removed the
> event but kept the barrier, and dead dst entries now point to
> blackhole_netdev instead of a loopback device.
>
> The barrier waits for the RCU callbacks pending on every CPU while RTNL
> is held, which takes a full grace period on each netns move. Container
> and sandbox managers move one end of a veth pair for every new network
> namespace, so this limits how fast such namespaces can be created on the
> whole system, regardless of how many threads create them.
>
> Remove the barrier. The RCU callbacks queued by NETDEV_UNREGISTER
> handlers free memory and drop device references, which the move does not
> wait for. Cached IPv4 and IPv6 routes through the moved device are
> rejected once its netns changes, since rt_genid and fib6_sernum are now
> unique across netns.
>
> Creating 400 netns, each with a veth pair whose host end is moved back
> to the initial netns, a tap device, addresses and routes, in a 16 vCPU
> guest, median of 5 runs:
>
>                    before      after
>   1 thread        68 /s      440 /s
>   4 threads       74 /s      409 /s
>   16 threads      77 /s      283 /s
>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---

I think this is mostly fine. I was working on this months ago but got
distracted.

I sent two patches fixing pre-existing issues that would be widened by
your patch.

https://patchwork.kernel.org/project/netdevbpf/patch/20261016084802.2725187=
-1-edumazet@kernel.org/
https://patchwork.kernel.org/project/netdevbpf/patch/20261016091556.2750902=
-1-edumazet@kernel.org/

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks.
