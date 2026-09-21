Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C44F68C3
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014639; cv=none; b=UmtMVWnUIvJ3twVOUejq6e6sy+SoW7DgMzHIy5ejxph5syNsRGt5fcVECr/rkzfJOsUX2OUOfw8idiVHtUNU0RhbtEPYT3RqZ5f9FGmMTBtoSkK/hn9juCR1tIRIN8bBKslOGOhD6mRWGeW56ufq4tU7HdukH908E6tpg/8Xxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014639; c=relaxed/simple;
	bh=e1OnODo+uuWbbcApLIlYOF/9/C0z3kAfGZqFpd5dT1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=a3KN5OSEVR9TEes9orMxzy/PrfX0TPhjyhLM4F/CjvFobAuEhxjFaRdmzhIXYi8GWSmqfFTZ8bCGLaxKXaxhJsMnk0HsQVfSTx/DvVSC6rzDcIHJGYxtMihdAZfsrmf6yql1wsuDRsk7LEo0qqEZd7YJZcWRACkWRItmwnvxRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WGBqQ2PU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WGBqQ2PU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2AD3E4E4075B;
	Mon, 21 Sep 2026 18:17:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DD56F5FFB2;
	Mon, 21 Sep 2026 18:17:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 798C2103291F5;
	Mon, 21 Sep 2026 20:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790014622; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=El3dYegPgTZX3qYGBzZbbXTLYxxd2Ka23UQlt3bs7ig=;
	b=WGBqQ2PUI0fuoEnLpBeVQUUiBcGUgU3IloGNB62kpjlgCbUMeOYf3wAeC/8yQ/Be9gp5Cd
	Xplf4C/EQZjiLt9qlpLP6w7tqnjBOaL0Fp4sgAxDAFBVI3p1kYaOni/lGBG3rjJNd3IKSa
	uKRBNhl6dmt7wnUMwxPNiuw/mhTBydAdcACjidEDlfnkEXZYZknirrp5kUpFtuidoY999b
	KJIMaSGQftYMTVr+S7JcMOzZ70f+2LXTNBIyaqEjufeKvyGkkZ0q5YWED5AD8By6mW++IG
	qjchP69/705PDJoUsU17ZmDCi+dUfzbY2gHmeaNwrY6WP60ORRcCrHVxjrxVnA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 20:16:57 +0200
Message-Id: <DLL782VNNCCH.1JND0AEPMQ462@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net RESEND 1/2] net: macb: Preserve one-step mode on
 rejected timestamp requests
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>
To: =?utf-8?b?4oCN6rmA7Jqw7ISdW+2VmeyDnV0o7KCE7J6Q7KCV67O064yA7ZWZIOyghA==?=
 =?utf-8?b?7J6Q6rO17ZWZ6rO8KQ==?= <5mghybrid@khu.ac.kr>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr>
 <20260915083839.71546-1-pabeni@redhat.com>
 <CAH1Bc_yQYJ6cWyYVvfWK0pAgrXW1TMkpzmNxZvAXAKZJdiOqWQ@mail.gmail.com>
 <CAH1Bc_z6PFc7N6XVZ2dQEH=7D9mkXwGkXP2KKMW-Emd4zcf3fA@mail.gmail.com>
 <DLL0PZY25HAD.1RWXC61P3MZRV@bootlin.com>
 <CAH1Bc_yDpY1q3yLH5R+fbr_3=LicRv-qsrcPQYspZHz095TVxg@mail.gmail.com>
In-Reply-To: <CAH1Bc_yDpY1q3yLH5R+fbr_3=LicRv-qsrcPQYspZHz095TVxg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello =EA=B9=80=EC=9A=B0=EC=84=9D,

On Mon Sep 21, 2026 at 5:48 PM CEST, =EA=B9=80=EC=9A=B0=EC=84=9D wrote:
> Thanks for explaining the approach.

No worries, doing it especially as you are new according to the lore
mailing list history. Welcome!

> I found both issues while validating hardware timestamp configuration
> on the Raspberry Pi 5's Ethernet interface for my research. I reproduced
> them on the board and tested both fixes there, as described in the
> cover letter. These were hardware-verified failures, rather than
> cleanup based only on source inspection.

Great news. Nowadays the difference between "LLM found an issue through
static analysis, generated bugfix and sent it" versus "someone had a
real issue and fixed it with the LLM help" is hard to tell, and the
first approach is sadly more common.

> I've already applied the fixes locally on my Pi, so there is no
> immediate urgency on my side. That said, the structure you suggested
> looks like a cleaner way to handle the configuration path overall, and
> I think it makes sense to take this opportunity to rework it in that
> direction rather than keep the changes limited to the current fixes.
>
> Rather than posting a v2 limited to the current two fixes, I'll prepare
> a new series that refactors gem_set_hwtst() along those lines and
> incorporates both fixes. I'll link back to this series for context and
> validate the reworked path on the Pi 5.

Perfect. Make sure to fix your SoB: we require real names in the kernel
and kimwooseok looks more like a username.

Side tangent: I wouldn't be surprised if you were even allowed to use
Hanguls if you preferred. Though there isn't a large precedent, I hope
we can assume (1) systems have full unicode range support and (2) no
one expects a name to always be firstname + lastname.

=E2=9F=A9 git log torvalds/master | grep -a -P 'Signed-of.*\p{Hangul}'
    Signed-off-by: =EC=9D=B4=EC=83=81=ED=98=B8 <...@gmail.com>
    Signed-off-by: =EB=B0=B0=EC=84=9D=EC=A7=84 <...@samsung.com>

My own "=C3=A9" never caused much trouble.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

