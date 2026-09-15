Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B83D091A
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487587; cv=none; b=UBdhYPqwck/MkvRJFRb3V/ly3XA1S/OoCh4IKQY5Su85VgF+NY2d+48zH1unu0J6ZlQ30YWB7rlq9QkXtfv5m8Q/4KP7nMLB+Xw3yThfSVt7+87576OjYXSc/TpwimHK2oEkUOK47B2M5tvXOnsak6V2q8hkYeas9jaIO4VVNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487587; c=relaxed/simple;
	bh=yqqrxw4DzAghj5Pes3+XD5OvfwMc+jPi2qh8Gsi8RVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XApC0Lga07r5SXrmwTTFopwJigmJXBSkdxa3N80Xm+4t6673rB/5Rnu7TE1ZNWYTqYyWV6FaaCV9cyOERSDIoOAzXI4kKDk+9YXm63DkK/0SC1pLLP+cHmnyKXC+6lq8KK4jUBiLuwWflWcQNhld0m/+4gzO5outXM9NJJlijJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dokcSmjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dokcSmjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE6D1F00898;
	Tue, 15 Sep 2026 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789487585;
	bh=k50jCDR2ZA0oF12TL43XwHo6y3W6jShzW7Rai+1OTAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dokcSmjnpCLF3RK6d+iHIDPgT64abZ57VS/JgtAUHU/ngoBcbXUmhFhgEwelYQ7r3
	 Sw9JANQOX4mwlV+iIAetuBooJNI/D5rZ7M9WWH7lPcUIJp3fX9+eC1LDFMENlMMqx6
	 k7DxRYWFIfsREqMiYlcY71yp+JokyKmIYOUTd3uRK0f6a73p8qjTXKHLVddl/Ay9No
	 bHk3duSTvxjGQTUB0ql27cXqpQe/y7pinoC4CWAkGY9z+5Z3UxbnI7o20J0sv+IpIP
	 3pL/55lhUvQSU1KJkXxeqWaxBmkDiXBwIDr/6pfMscgoa1ZztHZbWjta8IMMHR2h8j
	 r0vWuYh/W3wGg==
Date: Tue, 15 Sep 2026 08:53:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org,
 vega@nebusec.ai, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in
 qdisc_alloc_handle
Message-ID: <20260915085304.775a829a@kernel.org>
In-Reply-To: <CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com>
References: <20260911133146.3440982-1-victor@mojatatu.com>
	<20260914191108.55a1a4f1@kernel.org>
	<CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Sep 2026 07:50:54 -0400 Jamal Hadi Salim wrote:
> On Mon, Sep 14, 2026 at 10:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > On Fri, 11 Sep 2026 10:31:46 -0300 Victor Nogueira wrote: =20
> > > This is a less intrusive fix meant for backporting; a cleaner approac=
h that
> > > uses a per-device IDA over all qdisc handles is planned for net-next.=
 =20
> >
> > I don't think this is net-worthy in the first place.
> > We have a ton of code under rtnl_lock.
> > We cannot provide any protection from malicious netns admin from
> > overloading the machine. =20
>=20
> That is the one million dollar question.  We labelled this as net for
> this exact reason. i.e malicious container could overload the whole
> machine.
> But it borders on "hardening" (improves performance), so net-next as a
> target sounds reasonable. It was a coin toss.

IMO any attack from containers / user ns is hardening. If it leads
to a crash we take it via net _because it's a crash_ not because
user ns can trigger it.
=20
> Since we have a few similar "grey" issues in our pending queue - so
> where's the line for net/net-next?

TBH the line shifts depending on how bad the AI flood is.
I tried to document some rules but it only lead to bikesheding.
So my recommendation is to write the final fix, without worrying
about keeping it simple. And assume the maintainers will redirect
to the other tree based on their judgement when applying.

With all the AI kiddies these days we routinely apply to a different
tree than tagged.

> > Nothing against the patch itself, but if you plan to do something
> > else in net-next let's just go with that from the start.. =20
>=20
> We could resend the same patch for net-next, the alternative "proper
> fix" is more intrusive. See attached.

I'm not sure we have to do this, given Victor's patch already
drops the time 50x ?

> Another option: Is this worth fixing?

Right, I think it is but IDK if it's worth maintaining state for.
IOW Victor's patch would be enough for my taste.
