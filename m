Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2931F99A;
	Sat, 19 Sep 2026 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789860766; cv=none; b=fihngwyfzz0gC2Fcf6ykjb1pug5JM+cfvZn+YVRMBsBux4gR86J6zf4PE5Pa4m+BaohoNh2JG5TNXRPA1HviFANphBlCHqLPOykWaYQmYTHBNRvn33fdJis0fwWiTn4V0tDLtOSWfN4cdTR5zld02lHYu0lN/KI7MZV9JLPrj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789860766; c=relaxed/simple;
	bh=jtfSpnCUi+ZSj332VANJM7Q7YF0tN4hcw8re76HulcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cF3UlydNM9uarXT3YzAcNqCaJFxZ8Ww8Hf5AUBHv8YqoBlxfbhmbB1T8ck1P3GqHrH8S6JINxas/dbSTiZBX9pDTr4B4FGfszlXRla8jO+CrGNOQxcSDkiHsO8FOL5LFLU+KyHCwZ7FB+xqxRa1fgl+mBBA7IzRTQFk8SIkMUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1bnMzDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1bnMzDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A591F000FF;
	Sat, 19 Sep 2026 23:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789860764;
	bh=jtfSpnCUi+ZSj332VANJM7Q7YF0tN4hcw8re76HulcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A1bnMzDz1c7otxwMGx+obqzTZV3qOKicezbfi+Tq6KCTXSU7cAaqNCV+X1SS4ue0p
	 EM0R6J/SsymEO/5XXXjZzrIcTfMCYqh06qBc09c87HwrDpGimC1TgPy3m6JLp+fqzf
	 3hK0QyRd03v6w84dITCB53/22qavNIfUs4g0Pk0DpnvnEw1LKQSYhk94HWG8AGzi4e
	 rSsGmuvpMNmCjnvZB75r19WLVnWEY9aJsQAXkW2jIrJ4KyEG+KyugbsZ2jXaO/Lbyr
	 ft14/TkvyF2RlW3SJiPPBYxEbrweRSM+nLSQ1bG9IbLaj4ZhrR8gQYdYtnrrHcRMZd
	 vs4tAPbMOmMlw==
Date: Sat, 19 Sep 2026 16:32:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Subject: Re: [PATCH net-next v12 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <20260919163243.19ab30ac@kernel.org>
In-Reply-To: <7039c9b9-a365-4481-be36-f7bdfff040ef@birger-koblitz.de>
References: <20260916-ax88179a-v12-6-60c04c9924a2@birger-koblitz.de>
	<178968029668.22033.6092490845837885048@kernel.org>
	<20260919151524.6a65c24b@kernel.org>
	<7039c9b9-a365-4481-be36-f7bdfff040ef@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Sep 2026 01:22:49 +0200 Birger Koblitz wrote:
> On 9/20/26 00:15, Jakub Kicinski wrote:
> > On Thu, 17 Sep 2026 21:24:56 +0000 netdev-bot+sashiko@kernel.org wrote:=
 =20
> >> Critical: 0 =C2=B7 High: 4 =C2=B7 Medium: 19 =C2=B7 Low: 4 =20
> >=20
> > Per subsystem documentation we ask that submitters review
> > the AI feedback and confirm / refute it. If you think that
> > none of it is correct one email is enough. But I really doubt
> > that AI was wrong 13 times (counting just High and Critical issues). =20
>=20
> I was traveling the whole week and have only managed to go through about=
=20
> half of the AI comments so far. There are several that do not make=20
> sense, some which fall under "better safe than sorry" and others where
> it is definitely "oops, should have seen that". I will reply to the AI=20
> findings in detail and definitely send a new round of patches in about=20
> 2-3 days.

Got it, thanks. FWIW no need to spend time replying to AI now if you're
planning a new revision, anyway. Up to you.
