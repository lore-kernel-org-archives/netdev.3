Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144E403E8D
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571665; cv=none; b=HlKndkjhEuZzxfAkqZ7BKob8oey/6TLS1PX/uUBAA+0kcceb2468IJxiL9OBvAYzStxEosXoFchJicNX0T2sHC8XE2th5lSY+5dB8H4jpAJ9N3g2O0dTCuvvXzuLnpmqeNI8khlHKEoZPjUlXuLkvSms9nMNJ7Aj8LIfMKSz2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571665; c=relaxed/simple;
	bh=iaGcrqH1hQCgKp3yKreQ1rWzVmgbQ5BHx/AViwaP7sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1xswuhQWupNKnLRQ5Ixw1tf5gGADtrF9QeVlui8O8Z8B1PdIqoAnWvZNEy2iCdkQa4sgpCGsSUuXe3dd2vAT6LDXbfZqw+qveB4EKwxT7+3LqXu30Pi3jetWmf10dZZ4pxr0SjOkid2HxCu9vWfSunY9ou/XsxVqX5nXV5YJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEtUm0ti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEtUm0ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECE01F000E9;
	Wed, 12 Aug 2026 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786571663;
	bh=aRIji7EM7irrHf1vNYhRUZoiK1vvnuhs1SS4Gk1HZa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HEtUm0tiBq0UgmU65aEV4hnW9HMRqgESvkC25Urh/jylHYuhRKb9Amy9nSTZteBw8
	 iDLcBv7EFNnKYBvoH3Ay6BkvgdjC8uSByzNtvqBUgPfGXJeakuZeIjmx713GXW7beg
	 M0oOmCbjaW7Heug5my17SaIEd5GD9bg64wfOke2PPZRoTzePNl2qlTAfCTc2bcqxzf
	 xUXKlQlJFIfyOItVdzzNKcyK3loSlYhHIzQ1/kslP556w7ShaZlj5gUZsMvG/AIFeX
	 cL8o9vVaGhb7akRZUvBLb6uBpe/N/6fsjYuU5V+ukgHesTKARaTI0be2a1DBl61pjf
	 A9Cqxk5EncR9A==
Date: Wed, 12 Aug 2026 14:54:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, Eric
 Dumazet <edumazet@google.com>, pabeni@redhat.com, horms@kernel.org, Willem
 de Bruijn <willemb@google.com>, Max Yuan <maxyuan@google.com>, Pin-yen Lin
 <treapking@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Joshua Washington <joshwash@google.com>, Danny Gonzalez
 <digonzal@google.com>, David Decotigny <decot@google.com>, Brian Vazquez
 <brianvv@google.com>
Subject: Re: [ANN] Google's Netdev-CI for IDPF and GVE
Message-ID: <20260812145422.049f49fb@kernel.org>
In-Reply-To: <CADWJPTu9=k5y5WmEfdFiemhg+sRA0ZW5e5J_W_Wazrt+JKpMyg@mail.gmail.com>
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
	<20260619115905.051eb340@kernel.org>
	<CADWJPTus-1pXZZeYfGqJ1=OR_RPZ5Wq=H2tc1S0_tGi1fGFNEQ@mail.gmail.com>
	<20260804071657.03263c97@kernel.org>
	<CADWJPTu9=k5y5WmEfdFiemhg+sRA0ZW5e5J_W_Wazrt+JKpMyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Aug 2026 13:56:51 -0700 Sheena Mohan wrote:
> On Tue, Aug 4, 2026 at 7:17=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Thu, 16 Jul 2026 16:15:35 -0700 Sheena Mohan wrote: =20
> > > Thank you Jakub. Just wanted to share that we are working on exposing
> > > devlink info for both GVE and IDPF drivers. =20
> >
> > Hm, but please don't expose kernel version as running.
> > It will spam the aggregations which compare "platform changes"
> > with a different version every week for no real reason.
> >
> > We know exactly which kernel was run for each test,
> > so it's also useless info. =20
> Thanks Jakub.  Device information for both GVE and IDPF is updated.
> Following your suggestion, we removed the kernel version from the reporte=
d info.

Thanks! Looks reasonable now.

BTW I noted that the branches tested are a bit spotty.
The gve manifest only has results for around 33% of the branches=20
over the last 3 days. Some of the results are nul so the run hasn't
completed.

idpf runner looks better but is also missing around one branch a day.

Is this something you're tracking?
