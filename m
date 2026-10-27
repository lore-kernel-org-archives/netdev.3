Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105117;
	b=PDIWePo9CgFvtCTeTv6+QGzVpxkAfbFiYcvit1k7UVz1HozVJ4gcmL171YTDoQpDviiP
	 QvkGbiWD8fmcxEagez+mWm6SHPHokx0EVtkNe2gHxk4vpPxxm1mxfYAasK1uj+YddzKq8
	 EG+4jwYBnp+EU4ghfMC1oBMqchhX9Nv5yWJJMRGpZ4V0rqo5yH1z9OJ6aodw7NtG0azgx
	 YsiRQ9/AJMM5KuB8XHlQl3eJXF+/hKwpnHHZjT0vUf6SYkgTYlOwqBWf+5ko3Z5niTH+F
	 ZKpO2F2QwvaXUVZezz1TVJi3ckePdNKqzVpa/N+dk3b2DzrupkxNQ+48MVdUzMSWbYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105117;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8rARxPE73nvg4HDl8BXq2HThRMe4cw7sIRWSbPBB7mo=;
	b=IzSS4u/oFWrGRuWFySFaWCPrdbtqqO53F8YtXMo1pbD+21SKxng6W9SWfutaDSFBT6Gr
	 VDkljQSRSvIuyf2NaSbYGjf62LVALRNhsBm9WKABugQM+iuxvBhjzvYLSd+7K0+iMQGGO
	 b91oNpzmwid2whRqSSYu6G2aG1mkZY4ONNJ6cvAdygajyBlcELhwNAnuKrDLZobifIqxg
	 ME9AChL0IMG9FI6OfJTkDyTyEqRvIQ1xYAo3TlJKGhVSkL1aoN3BHnUSr9ldG4ZmIqNsw
	 7myRhjy1EwUC/yt/r014ac+lMpg0/Xhm7hBKrfNy2VRTe/L7lQxlFZil/YHX2q1ZjJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRPIqqJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC99606A330
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRPIqqJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807801F031E6
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793105116;
	bh=8rARxPE73nvg4HDl8BXq2HThRMe4cw7sIRWSbPBB7mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RRPIqqJP0S34a1u2yvRl3ThLhqOttRUdn4B8P6lTrJ6bqieh/Y94iDe0U+gPtGiRT
	 owH8txV2l5FtzylUpukGMMQlrzceFA4W5Nk7Kp4ZWtYfznd7sRECQWhw9xFTZU1nr6
	 SH04bvyTPMiUfwoszc1gMC601/B+uP3R3nl7x78DIZw7kvTFbeK3jFT/JI2pW/oRCq
	 QdxMheBayi5JBK2xCN3hAkcBvTxJ9rHkkgnx1OseCrThCVv5yd4VkkgDtXU0Qk5bVM
	 T0CsuI+2MeHx9RBlKQn3I2HQuFFC7UpkqktWo00afeHmssMnR/ElrGP2Ntapjm6WsL
	 EwP/zkQY43WaQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6d68de53053so2006433eaf.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:45:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByoNdd+P/FBewFs80uF70pv1185mFfI5Nh6igH8HbX21XTfQtimT4MvosNJKhtil6m8D/3B0l4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXdGrC8+12qnCYy2ElvqPdQziutId3+L5OOx3rJDn7ydsrNjuk
	nPfhUFd8/gqmpWl1Mcfy8xh9lX45mVQUn0R4DS6TLPVz5oE3q6GVcWc9KPLYHwQoKKQYsx0FY7C
	74Yfh5ZssGAWiVc+g7PW/stlenSDwP7Q=
X-Received: by 2002:a05:6820:160a:b0:6d8:9568:8413 with SMTP id
 006d021491bc7-70ba0dcd52fmr5093612eaf.29.1793105115842; Tue, 27 Oct 2026
 05:45:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027121442.907414-1-magnus.karlsson@intel.com> <20261027121442.907414-2-magnus.karlsson@intel.com>
In-Reply-To: <20261027121442.907414-2-magnus.karlsson@intel.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 13:45:04 +0100
X-Gmail-Original-Message-ID: <CAL4WiipZoXk-fgKwSdAcEU9U3pytPtZA0QXqN0LXHK6y4RUQkQ@mail.gmail.com>
X-Gm-Features: AclHuK8mCS6wHzS36AH1Czb_foiMFwXwVsjs2YDT62ASqzMvBMTq5CeXZM9tV-o
Message-ID: <CAL4WiipZoXk-fgKwSdAcEU9U3pytPtZA0QXqN0LXHK6y4RUQkQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net 1/2] ice: fix USO for 32-bit systems
To: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: magnus.karlsson@gmail.com, intel-wired-lan@lists.osuosl.org, 
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org, 
	maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 13:15, Magnus Karlsson
<magnus.karlsson@intel.com> a =C3=A9crit :
>
> That USO works for 64-bit systems is just pure luck. Currently, the
> computation of the UDP segmentation header is performed using sizeof()
> a pointer instead of the sizeof() the UDP header that the pointer
> points to. Since the UDP header happens to be 8 bytes long and a
> pointer is 8 bytes long on a 64-bit system, this works on all those
> systems. But no such luck for anyone using a 32-bit system as 8 bytes
> !=3D 4 bytes. So fix this by using sizeof() the UDP header that the
> pointer points to instead.
>
> This was found by an LLM while implementing something else that used USO.
>
> Fixes: a54e3b8cffd6 ("Support UDP segmentation offload")

Missing prefix?

Fixes: a54e3b8cffd6 ("ice: Support UDP segmentation offload")

Other than this,
Reviewed-by: Eric Dumazet <edumazet@kernel.org>

pw-bot: cr
