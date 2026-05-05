Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46C3A5455;
	Tue,  5 May 2026 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958482; cv=none; b=KU5K5NDVPgwNa0nfQm8vsX+v8pgKOoMTPe69drQ9ALeilB2SKAC4shaWqWYYZGxD8PZLAzAGvCmt31/Fb18uwGJryCOo9tbJKGYR1f/vBdL0wNyPAefpqUKKu1tSKsW/bggDj5EbFgC14zTLbRa8Sx0msdm/ANL5/JMwTexhRX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958482; c=relaxed/simple;
	bh=HD3iTXfKGJBlIpjktgAQIrYhdTUbSK8KQ+y1nR0wWcw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=S0SqXs4sNB0soOibMrttXj/xrD2Lc7R+6Cu8SSwVigf1rhCtYzMKd/KFQrsgyK2sKL+Q7GfRN3v7Th/xHAN2CJMKxwunY/eYr63rOntrv4ComV1EPmqkMNKnKfGmmuVI3Khfk6+i+epTBVIfzote1okpyD+3Ug9P+yhuwUtZins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BluNQRxq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BluNQRxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9F1C2BCC7;
	Tue,  5 May 2026 05:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958481;
	bh=HD3iTXfKGJBlIpjktgAQIrYhdTUbSK8KQ+y1nR0wWcw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BluNQRxqU/Nb+izLhUsjxTwXDG/jWhQaJheesmKvldmgp/MAx4YPYXNc2aEDjnZeI
	 t2Zj3NDH4D2/HKOxh3nzdHzWqJTMJjMgB6rNA4biUj8NIpz7HBnVutSujpyXPLV3JD
	 JmdcgoUWf48B1eLcDrnR1Nn/4fcwfVUTvtsE1qGkiDqUCPJVeSTU1NZO4g8Kl7F1mj
	 QC4wK3qMrAYYBztQTJExb/itLpMeaKe29VnV6jQwtyv81X90S2ppK5qkARAdkP4qj9
	 /DV6SMmn9aeox/oVeZ7hfzriG/Z5lMgVISyUxaUuBG9ZLioDRPyBz86MULm3todC3t
	 lPX3r8hQ6/lBA==
Date: Tue, 5 May 2026 07:21:13 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
	Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
	Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
	stable@kernel.org, "Kernel.org Tools" <tools@kernel.org>
Message-ID: <c75c7d50-36b2-4397-8355-891c83d663c9@kernel.org>
In-Reply-To: <2262783.irdbgypaU6@sven-l14>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org> <20260504171051.2b3e47ef@kernel.org> <5990011.DvuYhMxLoT@sven-l14> <2262783.irdbgypaU6@sven-l14>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <c75c7d50-36b2-4397-8355-891c83d663c9@kernel.org>

Hi Sven,

05 May 2026 07:00:27 Sven Eckelmann <sven@narfation.org>:

> On Tuesday, 5 May 2026 06:46:11 CEST Sven Eckelmann wrote:
>> On Tuesday, 5 May 2026 02:10:51 CEST Jakub Kicinski wrote:
>>> On Sun, 03 May 2026 14:22:33 +0200 Sven Eckelmann wrote:
>>>> While reviewing the fixes submitted to batman-adv in the recent weeks,
>>>> further problems in similar or adjecent code was identified. This was =
either
>>>> noticed in the manual review or reported by sashiko.dev.
>>>
>>> Are you CCing netdev to get this reviewed by Sashiko?
>>> Please don't..
>>> We delegate code to sub-sub-systems to lower the patch volume :(
>>>
>>
>> Because of `b4 prep --auto-to-cc`. Will now manually remove you.
>
> To speed up the discussion: @Konstantin, is there a way in b4 to say "sto=
p at
> the sub-sub-systems" when doing `b4 prep --auto-to-cc`? I am just trying =
to get the
> `b4` workflow somehow working with the netdev requirements.

Maybe a new option could be added, but that seems difficult to guess
where to stop, and to which subsystems to apply this.

Can you not simply omit using `b4 prep --auto-to-cc` when working
with "internal" patches?

On my side, that's what I'm doing. I added a .b4-config file with this
content, not to have to specify --set-prefix nor --to:

[b4]
=C2=A0=C2=A0=C2=A0 send-series-to =3D MPTCP Linux <mptcp@lists.linux.dev>
=C2=A0=C2=A0=C2=A0 prep-pre-flight-checks =3D disable-needs-auto-to-cc
=C2=A0=C2=A0=C2=A0 send-prefixes =3D mptcp-next

Cheers,
Matt

