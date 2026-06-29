Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472103C9EEB;
	Mon, 29 Jun 2026 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782772950; cv=none; b=H2xsMSTgyPwI2X7lLeanp0ZUf+49h7a6exaEXi7m7Rb9jtfDTN0SsNLkk1hpGz5ZYaiZ4JGVFsrdiGRxlVWtZji7HpKWunrvOBt9hobiOuO8L4+N06YpKV52SrtVNo0hhJlPacDbYEg5xl6BNFI11Pl58uLLqEHGdG6xdEXDgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782772950; c=relaxed/simple;
	bh=Y1FUyUQ+6pDo3Q5u+Ak9XpYlYqm3oNTdVvT0dujNB3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoN4dKKOzxgBAIYrBp7hjzJacQhHN/uf2Z4fqfd4mip3Ep8Z/0HXK4Q43iWDJ3ldTkrdTo4wjOQld1trI+QkCU6tyloFWJtiVD49eZGdOiA94uc6wcbbTo/q6KxhklPYINdSL2omez93nZSKM1Sa9ok0Rus5JaYZESh6CqnR+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrAiodgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrAiodgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735301F000E9;
	Mon, 29 Jun 2026 22:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782772948;
	bh=dfGsgo+yOeIxzkSlnKWKokDKNnAd9uFqZ03mLJMQ/38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NrAiodgObb2yFqGGJQri6AIaCve5EmL2LVTm6FpN01BrRMSNXahENgpFLJAahKPOi
	 ExapQOm/WvJl1AO2YcwcAG2x8sg3jmsvc9e48/n9JN5sIr8koTWYFEL26+vyr3GanM
	 9mC2jOadOH1TrlWpeDkNti3BwaWvfSVKEKykoiUU53Pf/uqEdEwcXiMkzssDjuPyEq
	 fpF8U5r4y3GTBMZNi/hjcFvH319MhdwJ6q7Py5ShfPZnnjuyFtC6a/lr2UUJYcdKVj
	 Ge43D38j4hwNblZ0DZ9nzuUebhZLUOsDpAgk+OZpPlMszbdFPLX9O61Kbyb1qaJNPR
	 gTg6gMY8i77HQ==
Date: Mon, 29 Jun 2026 15:42:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "moderated list:CAKE
 QDISC" <cake@lists.bufferbloat.net>, "open list:TC subsystem"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
Message-ID: <20260629154227.741f2051@kernel.org>
In-Reply-To: <CAE+C+Da2-t1t76M6T9p=s6frGgOwj8LpOtVxBnmWa6kVHx9kpw@mail.gmail.com>
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
	<20260613142626.1b2183eb@kernel.org>
	<CAE+C+DZpYpJDJOaCK48KBpayXSYorFRSvTE903RBqyPyYkWcCg@mail.gmail.com>
	<CAE+C+Da2-t1t76M6T9p=s6frGgOwj8LpOtVxBnmWa6kVHx9kpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2026 14:44:28 -0400 Samuel Moelius wrote:
> On Mon, Jun 29, 2026 at 1:24=E2=80=AFPM Samuel Moelius
> <sam.moelius@trailofbits.com> wrote:
> >
> > On Sat, Jun 13, 2026 at 5:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote: =20
> > >
> > > On Tue,  9 Jun 2026 23:29:36 +0000 Samuel Moelius wrote: =20
>  [...] =20
> > >
> > > Both Sashiko's complain - these values are neither safe nor sufficien=
t.
> > >
> > > How was the -64 chosen? It looks suspiciously close the min ethernet
> > > frame length. =20
> >
> > That's how it was chosen. But as you've shown, it was not a good choice.
> >
> > I would like to submit a revised patch that does the check on the
> > datapath, as you suggested. Should I send that patch? Or would you
> > prefer to wait for a response from Toke? =20
>=20
> Apologies. I just noticed Toke did reply. Should I send a patch
> consistent with what he suggested?

Yes please
