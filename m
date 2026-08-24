Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969746C847
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590558; cv=none; b=jDVrxWyXIce77YufGieWf10c7sa/GVYM62M0cId3oOnq9TWIXbD7Onqiqmfjlw7Oa7jtglTHA3uaUJV8hhrwUv54I2ERyvtAjnr3cG6DG2hRPz9Bhlhr+SWSwCvBWxaaJQN5m5PIwaAHN6LhbC1ZhntPG9V37pSrWc9+ulDAGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590558; c=relaxed/simple;
	bh=90+/tOBKCR0tL5zuqESaCxvdFdnzYhVt3aAtBlDvc9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t/sjAfNcErWyWzImqSc6KAEA8JwJxEQrEdslSwHLDs9rI2aOsDXdo05T4aUBLfLQoo+t5NEb3lMXzPaJvC1MUfh73Yqx5r37nL+dv5uqYapFJwEoij7urZ1EF4p19oul+5/3U1zfRybK0PP216PCM5qrWD64FroYz5Fuo3UwLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dnim.dev; spf=pass smtp.mailfrom=dnim.dev; dkim=pass (2048-bit key) header.d=dnim.dev header.i=@dnim.dev header.b=WCw3nU0b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7uEdByn; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dnim.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dnim.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dnim.dev header.i=@dnim.dev header.b="WCw3nU0b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7uEdByn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D40A81D000BB;
	Mon, 24 Aug 2026 12:55:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 12:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dnim.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787590554;
	 x=1787676954; bh=90+/tOBKCR0tL5zuqESaCxvdFdnzYhVt3aAtBlDvc9I=; b=
	WCw3nU0bgzNyrix+a/HRC7u6xcjjVeZOtSfgiw6gdto758oaPJtrSdFheczbNNTm
	zGkNHRd3dsrFfZ0AYss5azNk0siGMOelFerTf3xANhvooQYfregXbiuNFa+UVXf0
	Ev7osxieAZT6jZ/dVGtzbzUR4r4/i+fI08PZWkPEJ5v+lzoOQobRDdCYYbCjVWd0
	ea4r+hPP/LpYWHjJDrwFDjgFXX5d8JqduOVCkHmYbkr9k5YgLFyPMjNbGRh2D/BF
	9mrNRDWG623Ul/xu8oC8TwhPcK0YZsaNPflvRbtjccreqQk49mE51QCa48oVtVtc
	DztOizPRSPKrMaxThVvvAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787590554; x=
	1787676954; bh=90+/tOBKCR0tL5zuqESaCxvdFdnzYhVt3aAtBlDvc9I=; b=F
	7uEdBynXEMNZAa05ljSlcLiSDVclw71R+BieAu0GvKyPkmdphNZZSxiIcXN8lkwu
	ntVpp6nKErRpdaIWo7zIof5bWCE4gdj8RRAZTi8LiGaPy4Yjixlbqj7SjBliKdnt
	pn75IUvpTqQYA2dLHXNiOYxpsXyhVp/CDRWv1JApw+kSD8uDbUdNxzmtmygyQi+g
	iNEmw7bxqwapPy6ttHYyxMj3Lh5/EgaJzSk2eyDhGWeDrmogTuiMVHd6ZxaavR1m
	BWN11ZGX+30lLAwjzZcua7Lxs2mZEKH5kuRuqjpkFvE7b09KHQw6CUSKLmiKnO12
	ZO5PgBqNKPu9JxhsSAFcg==
X-ME-Sender: <xms:mneManhnOSlTUF_zkBUISyZn92ogyH5iJPmf6MejSAZJgJdJ1xtgkA>
    <xme:mneMajuggRzphfzK9J4CGSyjlraQ0xyMc1rZUvGuXBxi2rlK6RYcyhfAXvn5GXit0
    LL5HHVADpepArXl9mf_r1gKmdwWq0fu06svppSj7myvL4gXqTlCAfc>
X-ME-Received: <xmr:mneMaivBAtzY0p_Evd7_zLm837_Qbu0187pGvMJ5KnjZMgxIu6EtDMYSe6fvVCWoespb8wzMxqgka91u1w4RGqheSzqSxIOHoDNoaId70Z8JbRsqhh4ZbBDAUISIv44ABat05Yp_7Qo3kUg>
X-ME-Proxy-Cause: dmFkZTFU/ebiYip6Hzt4pJUd67o5aWGJU7/l4IdwHv+hXBqFGMWWHcPzj9cgSZQT5HdSZc
    KnzVdj9a6sg5LmM2kG2MQQ9UDB1cZgl+sF/AF16r/gKMR29+MHGgE0VJxmbjfZpD9tlWwT
    rBiis1C7VOei096O+hLQ1utFeikYbhQwm/SLGw3yOrTg7t80fPpQlD5InyLlkii1zNvvIX
    uWCBBVCH2JiO1FRq60mRXu5cafUMFG30Vp2kkSuA7o+LJIQAvUBFKajYPUkCUduVXEPm1t
    MophBmI8eVSKIfwssZ5NomT2Sb4Adl5DueTWWGsDEw+pxdwu9PLiLu6p84Z05QXn4sjndx
    y3x3IYCIjKptlVx1YbaBseAdrB0VHuI8qex/4fASwmTRegP6m1IZ7zbU7RdIj/WnWyIEuz
    GuxODSKWk7l0dc6XJdOsEU036UrjEzdm3lCmPKLvKuALgu20QPdYJNeA9V0gONceT0wwzw
    tniNoPoK8I4//HMU5mIcF6gHRL1DuN1H4JwZxcjNwffNMgh3Zvn/mCZH/TMJUKsEzK+a5+
    2pCzrb/AetOQWD9CNVC9mdoNExoE1zxnrhJYjmRupiVanEhSA74MJj0Lyuce0uJFEOp+QY
    axb5J651wLHRzwnlT3PNyss4uM9nFldfDcX5pYbidc9x/96T1RxTW0qmfvyQ
X-ME-Proxy: <xmx:mneMagElq3tTm84f1NGZQbuT0FO1aXt89N_ATRREk-PQ4oefNvBGTg>
    <xmx:mneMalN67lxL70hxrUf5kKVc1fGp0Veiki4RJ5fFrLvWv-ol764INg>
    <xmx:mneManLCv2G-Peyld6Uci6cvdf0fhDwuwcNfjwVq-0nffyWpg3fbjw>
    <xmx:mneMam-hocExthEd5CAR4ZrcPRg1Whk8EZV9Ly8yY8MSfVyrZxEU1Q>
    <xmx:mneMasqNmyhcTmFI9Q7kO5d82vS3hnvndhW3WmrZSW2irazlgVBw3VKY>
Feedback-ID: i14ee4b4c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 12:55:53 -0400 (EDT)
From: JR Lanteigne <root@dnim.dev>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, richardcochran@gmail.com
Subject: Re: [PATCH net] net: fall back to skb_iif for the timestamping
 pktinfo if_index
Date: Mon, 24 Aug 2026 13:55:53 -0300
Message-ID: <178759055328.4181951.10346301845266420247@dnim.dev>
In-Reply-To: <willemdebruijn.kernel.1e07ba16c4cf4@gmail.com>
References: <178746246095.3786864.2262454553798466512@dnim.dev>
 <178756707212.4073008.8425791726071449399@dnim.dev>
 <willemdebruijn.kernel.1e07ba16c4cf4@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Willem de Bruijn wrote:
> It may be possible to detect whether an skb_iif points to a physical
> or aggregate device (e.g., through lower_dev)? If so, then the value
> can still be used in most cases.

That only guesses less often (tunnels register no lower adjacency).
I agree with Miroslav: 0 when the physical interface is unknown.

The userspace check fixes chrony only; every other consumer of
SCM_TIMESTAMPING_PKTINFO has to rediscover that if_index can be 0
and grow its own IP_PKTINFO fallback. The kernel is the one place a
fix reaches all of them.

The gap on cpsw: one napi serves both ports, the driver delivers
with netif_receive_skb() so the id is never set, and it would name
port 1 for every frame if it were. The driver knows the source port
per packet (CPDMA_RX_SOURCE_PORT) and needs a way to hand it to
put_ts_pktinfo(), e.g. via skb_shared_hwtstamps.
