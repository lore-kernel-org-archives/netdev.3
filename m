Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E111429D;
	Fri,  9 Oct 2026 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510295; cv=none; b=QJddFEIbmgNTaup3h7PfEEeANK7I/HntaoNrFmPg0uQsweuaxjEdEwPLwjaJ+lb9Q07sh/LAaUebZRWJbfzKNFZ9NAJMg4tNXoDiAfVoHRcMmoj5cYoKZhKB/2cVuNRwY0vO9RC8HjqhjBdjCU3OEi8rfX+LvxJHkeMCnLvLFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510295; c=relaxed/simple;
	bh=ps36k8CjuoTjZMV2brFGNLq/m90OAIIYoSzr+cqNdJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxkuFgCbw+Cakuwt8rCx1jcTJza1gezQfH+nePbvdXUrkh1iF9wzKTNWD0oA6cU1LDpb4CzAgkkVXM8wrk1Y99ISHnnD4oEYbCv8ERlcsTz9gP/qPFvt6MHBRbLLYst2ojYKmDaDQ8/3ISa62MqHLBu0vwQg1s0jVhLaVQkgvuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb9teZNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb9teZNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA991F000FF;
	Fri,  9 Oct 2026 01:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791510294;
	bh=33ru3Gxhk6Gm0/9IKmIgi6zRS1VwEU25zdzjDfJ2KD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nb9teZNs7TgdIun2s8u4WHb+8A0a37JNFbsPtXbso1NfpxgrQxcmSs8cs6rNqH3Yb
	 0vys8vn3SQFECa2C6658Wckyh+B99xEHYoaZMT3KmIvqEALKIovmgleV0gqRq1N9TJ
	 weIVYpa7U9e+Ts9XU/wrhQzvb8RekoOtuCxh+D9RovZquyplJZenPmKv71frxsPyYP
	 F0398g3sIKaAzrEDCu2UjVSl37ivGdH5apro0pva5e34zvtXISqOB0qFLSPpZ42ziy
	 Glv/A/VGtu+PU9Jy88OmAnAcYvcrGyh7tff43mxTJxebkMQESnfhvcU5Rpi9pkpRLI
	 5wKyno4Aa+eFg==
Date: Thu, 8 Oct 2026 18:44:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Andrew
 Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell
 King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH net-next v2 10/12] net: dsa: rzn1-a5psw: Add fixed frame
 length workaround for management port
Message-ID: <20261008184453.3e0374d1@kernel.org>
In-Reply-To: <20261001154326.754314-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
	<20261001154326.754314-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 16:43:23 +0100 Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The ETHSW IP used in SoCs such as RZ/T2H and RZ/N2H has a hardware issue
> where the internal mgmt_tag_vld signal is asserted as a level instead of
> a single-cycle pulse. This causes the frame length counter on the
> management (CPU) port to over-increment, so valid frames are falsely
> detected as oversized and dropped.
> 
> The recommended workaround is to program the maximum frame length
> register (FRM_LENGTH) of the management port with a fixed, large value.
> 
> Add a management_port_fixed_frame_len member to struct a5psw_of_data to
> hold the SoC-specific value. When it is set, program A5PSW_FRM_LENGTH
> for the CPU port with this value in a5psw_setup(), and skip updating
> FRM_LENGTH for the CPU port in a5psw_port_change_mtu() so that MTU
> changes do not override the workaround.
> 
> No functional change for existing SoCs, which leave the value unset.

drivers/net/dsa/rzn1_a5psw.c:212:24: error: initializing 'struct a5psw_of_data *' with an expression of type 'const struct a5psw_of_data *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
  212 |         struct a5psw_of_data *of_data = a5psw->of_data;
      |                               ^         ~~~~~~~~~~~~~~
-- 
pw-bot: cr


