Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE552D63E5
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279074; cv=none; b=pOfF6E2S35s4kl2cJ0Z01pgM+JhQb6eYofbMH+2zsdO2OhmG6gDiIh+iXRR3zqDKNqE+biu/RtybTG0eXbk9mXnr89rY8GGaxW7TVA9NYkbHygvxY1YcCPArTzI6la+97sPZknxzJBZv+DbV1s5HU1p6NWwPQlp0YBdrsl8NahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279074; c=relaxed/simple;
	bh=CZ0KRWqMI03pyEwTO5s36gWT9C8Ll9NZtTC3eQ17wbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2aJZ89e4rC5/41OZVu8xD4DzXDFl1Kv4UlPS/PCl0K+xpW/5KPOgFAZDYfz5V98csGmCYrpj+tHDMmSLcLW/+UigAXY/OSQP+6JL7Z8G4iVHOgbhsKm/C1ql5ejdKloi1Zh03eVwILrOwm6IAOSO5p/vIcAN0g5+3zreBpz/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASikToQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASikToQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7808C1F000E9;
	Tue, 28 Jul 2026 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785279072;
	bh=CZ0KRWqMI03pyEwTO5s36gWT9C8Ll9NZtTC3eQ17wbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ASikToQHro7rHTB4zeIWRMHmeJ8DLQS0kMVIMkvL15Q8+OLSDc0GmNOg96nPKI2vq
	 d7Pp/q5nv9p2heikrvHRipT2S0LnfDgaKkAbrk57QyXl/QsF/qelOnyQo6wwkmliJi
	 z8nwvezgaxJs2U+WgjkdXPeLxTjdh/HdWsX+zu5oXu8nZubqMFlXa5fhLZcfy4N3b0
	 Fe4xq9SaDqgyQhkYfOFrb+Qo21YVZGWWGU2cIBSa9/+jnSGNgf20aOVTxMpMzmHi+/
	 yAyEyO6PbEqrX9CMvqTaKWT9s6k/GmLlwPzIRjc8HArLegcL3IIzSx/bOkmYBaDByl
	 JoczH4hgmILAw==
Date: Tue, 28 Jul 2026 15:51:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>
Cc: Ren Wei <enjou1224z@gmail.com>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai, zhilinz@nebusec.ai
Subject: Re: [PATCH net 1/1] net/sched: sch_cake: validate 6in4 inner
 headers
Message-ID: <20260728155111.3463ac49@kernel.org>
In-Reply-To: <875x1zwfzz.fsf@toke.dk>
References: <cover.1784855599.git.zhilinz@nebusec.ai>
	<502a543e7f04d14a15a0f6cecab30dbdf77033d1.1784855599.git.zhilinz@nebusec.ai>
	<875x1zwfzz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2026 12:44:16 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > A malformed packet can therefore use an inner header with a non-IPv6
> > version while still setting the byte used as nexthdr to TCP. When two
> > packets from the same queued flow reach cake_ack_filter(), the version
> > dispatch can fall through to WARN_ON(1), which becomes a denial of
> > service on kernels with panic_on_warn enabled. =20
>=20
> Hmm, I seem to recall a policy that says we don't care about
> panic_on_warn-induced crashes? What say the maintainers?

Maybe in cases were it's triggered by root doing something stupid.
But packet triggered WARN will definitely cause eyebrows to shift
upwards.

> That being said, I am not sure an unconditional WARN_ON really serves
> any purpose here? As you've shown, this will most likely just be caused
> by malformed packets.
>=20
> So rather than add all these new checks, how about we just get rid of
> the WARN_ON?

=F0=9F=91=8D=EF=B8=8F
