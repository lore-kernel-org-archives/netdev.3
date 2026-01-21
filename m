Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203F3BC4EF;
	Wed, 21 Jan 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002800; cv=none; b=vBBwMgwYztXmilik6kXhl1Ih60ujNEclsHIJiCTYDBNLb5lqhHcKo89qutvVJUFfkBrFT7PpOAqSBYKwNDUoLGcxj861tRgUCDHkC26c9nYCbS8W0LTcoCWfCCdwHmgfrQVUStwhSXJ5nzGAdEJZqbQyMDQx3QcR6NnHYcDgMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002800; c=relaxed/simple;
	bh=RmqCf2wR5mujk0thtN0HVfxp4irGJYjIkh+aH0XjYy4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=la0a4dWVzB+XCTWZmKlDHOmpLql6CpjoYK0L/WS/77f15N937TXhonevk3AEyygPDQ9xVOPmirnyD159ZT67aMBUq5ustSx2Ovvv5klgGaFsU+EnIwn0sSdzjyki4Qr0BtvCCM0Tij5wLpDZA6JLFOqnE0r4cqK31L+f97be2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=ATITGszw; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="ATITGszw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769002788; x=1769261988;
	bh=RmqCf2wR5mujk0thtN0HVfxp4irGJYjIkh+aH0XjYy4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ATITGszwYIQbcxcSRILU1ZSV9Alw8VZfYlmYyxIuca9eYMwPGJ3WGjEVjIo+o4iPi
	 OAARotb1riwyD8DWKsplci+J8Ez8sbBJ2wRquwOqWPqqxorU+jggQn/iDi4amkzUBO
	 Z18yCumz+S6LxunVL7bLEwmF1y1B44ocbzcERG/GW06mWclHSl8ttPMcAm8mR1mCdc
	 NpDxJKp+xQZL7GdXrwLgs0pxeeRWy617XUTeAkTGdIWt5bPOnnoo7elYlkY+PFix9E
	 WBBlI0J8xP8HYYOFsGU7cnYbn8RKcmaoaQLGYPVrCxky8J7rWxcQaY/62X2T7YgtFM
	 zmHyJGiCUaFnw==
Date: Wed, 21 Jan 2026 13:39:42 +0000
To: Eric Dumazet <edumazet@google.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink dump struct
Message-ID: <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
In-Reply-To: <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org> <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: b2a462617249e0597036a82c08d089850476b13a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yes, it's not proven so you might be right, I knew it was 4 bytes at best. =
We can do next or toss it, I don't feel strongly either way.

On Wednesday, January 21st, 2026 at 7:25 AM, Eric Dumazet <edumazet@google.=
com> wrote:

>=20
>=20
> On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses p@1g4.org wrote:
>=20
> > Zero-initialize the dump struct before selective assignment to avoid
> > leaking stack padding in netlink replies. This matches other actions
> > (e.g. act_connmark) that zero-init their dump structs.
> >=20
> > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses p@1g4.org
> > ---
>=20
>=20
> I do not see a bug to fix, current code is fine.
>=20
> act_connmark problem was that "struct tc_connmark" had a 16bit hole.
>=20
> No such issue for struct tc_gate.
