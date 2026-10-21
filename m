Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567066;
	b=rQCXRy6MQVV7OIeIf8yf2II73guuC7DX8604IDkYDf2A9/UG8tJIG0/uDx/qI2dOCiNQ
	 4jSU4L9NiF7u/jlYGyHNbIujImmYGlNA3MYFlhbBASP6s7zl5QdteVA1UFskh/nP9sV0I
	 Z90vjoyYVlZPVDrEba7mVUatVoItiYmz6k7SNgOdMGcXJr077k1TnLb/g77qvMn+YKJMv
	 OHnH6NQqMSZhM+JbfnOaWjx/AUaE0fI4ALo0A8wArnj4P+YG85AMqJYmceVjQH3Q2PhWs
	 JU3KCPfhQ0Qa4PNO5ypUN8pcfgDAupfuPO8g+4TJtkfyzoLU2qxv9efjwgOsyXNjK1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567066;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MMgOZgkUteCFlHmZXsf24fsfX17GQD8RIBRAoV75lVs=;
	b=AdsLH8YaW8XWsDi6aNJT7PU0lM8Ax6n2a3CXnUTfRa1VxDJKTcCj+63QpKAYE2SGzkUZ
	 tEWpHS+uHZz484I3sIyoQCEoBALCdHbY4mTpqHoqiyAe8ZW8NDjJtVpK2xW/OAv78g6CR
	 PgWXN21O7EWc9mpXnL/teZ3ZHjAH5hSSW7IBgrKiu+GitxTph/u1ZHmAsH7Js6fypmUca
	 AB5aelsGa5lKaK9TnlNZVvimAaCnzzNIy2rFqLuLqWfziz3TcjOBHikldFxEl8ggA6tdm
	 f9T8vpp/tjDcPcBTE/fTvWas9GJTH2gfjyoVTUHWm0HPaMUxEChcKTZUfyTJVHuTF6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feTdqOen;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FD606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feTdqOen
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C991F000CE
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792567065;
	bh=MMgOZgkUteCFlHmZXsf24fsfX17GQD8RIBRAoV75lVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=feTdqOentVS2bwAoSATRUELrx2e8gCymxaHDdTGCHuN9y1yRf+T4bhyyNfMjm6aSg
	 xhh/tWD6Vl6PzLTsd9kwlk7nW26nx1DoQTquSSRIiRr3qq8gVsYsCKD8tMItkhnjTb
	 HmZtCOwqNNjHwONti87IMVOsHmLr3EtSX/2XW9SGE5dH3OxTX39v31kD/DC4UAXwqG
	 EXKYPoMGmhv3CG+PveWOz4oPQJ1H/2mX6C9746GoiIedUeUsZbnnx3nr/CBjD/BjpU
	 Fjbz9Q834gfCY12QmFQ/rZAelgpOjOBn8yHCx1wqeYc9i/tY/4o5MniGeG3NWW9z5t
	 OmKUKoxTtYmtA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab4c608a6dso3612371fa.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:17:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwS5m7F16nhIij+L1s/knAB27JARa828Ea30Qu6EzdyK6JbCYA72GVO3zPS77CmvgLln4lJpOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5ZsTpCH3KzilOEuwvshuq/XrZd79I7BqxHBP2C+seSr4Qqh5P
	HgsOVysdkfzEp1pO0RmF44eyTpVlbs7uWZbo1pG03aPyUCa1foDYmESF35OpXGI0lUDmp05hdvb
	s39fay8o77dlX/Gh87ZbXOG/zQgNXQpw=
X-Received: by 2002:a05:651c:a0dc:20b0:3a9:a9f3:1e93 with SMTP id
 38308e7fff4ca-3ac44165272mr2468721fa.10.1792567064242; Wed, 21 Oct 2026
 00:17:44 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017104228.3418775-1-edumazet@kernel.org> <179253060802.212662.8966600542568977512.git-patchwork-notify@kernel.org>
In-Reply-To: <179253060802.212662.8966600542568977512.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 09:17:31 +0200
X-Gmail-Original-Message-ID: <CAL4WiirWKxpSGnkY1Udi8kkMhyHEYh=4jir76A8h+dra2uXv8g@mail.gmail.com>
X-Gm-Features: AclHuK96_QLn7gZWS7cetluTI5BD3tpwUAqq3EFa3exVX7XNiTcbZONe0yaiNs4
Message-ID: <CAL4WiirWKxpSGnkY1Udi8kkMhyHEYh=4jir76A8h+dra2uXv8g@mail.gmail.com>
Subject: Re: [PATCH net-next] ip6mr: clear skb->cb[] in reg_vif_xmit()
To: patchwork-bot+netdevbpf@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 20 oct. 2026 =C3=A0 23:10, <patchwork-bot+netdevbpf@kernel.org> a =
=C3=A9crit :
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Sat, 17 Oct 2026 12:42:28 +0200 you wrote:
> > reg_vif_xmit() hands the skb to ip6mr_cache_report() as an
> > MRT6MSG_WHOLEPKT report. skb_realloc_headroom() copies skb->cb[]
> > into the report, which is queued to the mroute socket, where
> > rawv6_recvmsg() reads it as IP6CB.
> >
> > By the time the pim6reg device transmits the packet, skb->cb[] is
> > not IP6CB anymore: qdisc_pkt_len_init() overwrites iif and ra,
> > and any qdisc installed on the device (fq, fq_codel, pie, cake...)
> > or a tc BPF program writing skb->cb[] fills the area holding
> > dst0, srcrt, dst1, lastopt and flags.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next] ip6mr: clear skb->cb[] in reg_vif_xmit()
>     https://git.kernel.org/netdev/net-next/c/238164201431
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

For some reason 'Reviewed-by: Ido Schimmel <idosch@nvidia.com>' has been lo=
st.

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3D238164201431a425e48dfcb8e9a59de63caf175b

Thanks.
