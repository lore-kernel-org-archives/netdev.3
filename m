Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736235B657
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297584; cv=pass; b=ahCatR+jwqdtRAooHYmVTtSI7EXfD7RXmAfJHIQY44UjBimXpne87KE6co0jOi4mkhB7mE7U0mmLigh9h+/eLDCznr+NAyDsfmcX9/cI0UqcsFuqUWUzbSOu7zoAVvfWztS6JWI6hP8KmFMfdI6wXkCsKZ5RFA6qKY9r5w0SJcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297584; c=relaxed/simple;
	bh=DUq8LGPBqt8SdNVFvCb35XbDHvQhmyVsE12hf8eYvpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdr07sJC0q1T/Hyj35UkEc/3NteYF1kEfQ6ZA9aVrDtXFqj0s13cmsIEty6gQRNX75QkbArrehA15uR9n0ZJlvUxldWHC6AzAuls4/iwOo7G8ANpHLNm5Os7kssmFlqUnF+47bpB1+24X+j2Fy624newftkL+aMJy+VEB9MVr8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PqAmuXLB; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PqAmuXLB"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c739561f0d3so2497339a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297583; cv=none;
        d=google.com; s=arc-20240605;
        b=aNSp0fvZp5cO5y+8AJPMcLmZG4jSCpMzXDjWbYyvZ/3fpOhYEd658z7O3tj47iLIWT
         SFzCtM1ha0FAl2Ng1/7T+xTiU1Ar0PeyPV4fLyILei6LO3IjDBO0Nw67rB4IOy6c8nRd
         nv0Y2pj9QjEJW4RVyL5D1ctFwFuqp0pKwbkTJ+DzsfIq6150/QbzxgTdt380Sw/7HFk2
         qT+g4MLkD/6NeHsZ75hBpPXxB1lSwvn7mr19M1CiKCMeRwncZ6T8Y+q3SW93DqepX6Wk
         IedBuk0Sy2ifWCMsaO2NaVeNglPiJM+30vk700pj6agozrTUOPnd6k1apYlZisNbQpMw
         VWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXWUtkYT4FoBAzKXThRQRMQz4bR8XCJn8//fdEKHV5A=;
        fh=UUOcVM29V7X9XfDoiP0OghSvJhYdCo5nZ5tzuLkOdo0=;
        b=dbfZLAoVRBXmqO2gkTgrgvPUlKEQdzTQNMA/w+ffe3lK5s9KcFDMHCsqU84PkwIN75
         obZjQoINMhMlP6ULCHKF5JmnGpUiqcC9bDgxsb+GpPEnBVjQPhXCLRNOk97Ksq9DO9gT
         v91nNTTDRKnqx1lkUVstMFZn4GbFbz23zOpaWqqQjdmDtCXtOVLBbMpy3oZQV/LdrYG+
         cexijEpKdWuGxIHUx1KfxhZ/UupQl35cSit4ONGdvo08Me/YKbODoa5vMfpPV4IpjKhI
         Jeqz7LDf85Yang6vRL/ZpEhIiT7hJAV8WVbi3F/PXJrtScQLgC3tPnV+vkhYNAq7ZCkc
         fo6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774297583; x=1774902383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXWUtkYT4FoBAzKXThRQRMQz4bR8XCJn8//fdEKHV5A=;
        b=PqAmuXLBZA1LYezZ7lrRes2HbpYxY4jjn65QEuVBJ8ja2pPAasryoSsimHY0NNXU+S
         9i/Qby1RnHuNbbTvJEGIJjYCHVTlMdFWTUK7UvSENXrH2rJzXoQDXOi7eqMeJ1q/aJdv
         gnvOpYVLex2FvPwHGfsZmiydjIIh2PpoGSwfkjDgs/rHwE4d9ucq/Q8FZaiQgruz2WRh
         fcwGvSZgi4lRcJQvW0HyHx+bDiqMwKoOmZ0IYlDTf6xl9x/xjkWGdWIr2dkW/JDLwUYo
         +RojfSpc6sXPletFPPWSR9u9xuHdgIy9BQ+9Y4k9E36UCwLiEYCara3xiD12ZgNRLzAW
         WgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297583; x=1774902383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXWUtkYT4FoBAzKXThRQRMQz4bR8XCJn8//fdEKHV5A=;
        b=NQH20KshTYiTvWjtO5TeSXbkjpGncCPRaJQ2ydnJveO3cklrMzxY0hX7y4KGJM7lwX
         hT0uBOEPUikHFq+lFcJBhceUICufLXMGn9I16Asp1aD4MWJ3ATwCoaFp4qHSaXa9tZQJ
         ZCP4J/MOPOf3bpnEEWoZCAz/bADAk4fQbu6ke7axb6ygxIwTu4+lRrOBI0S97ckd3wuu
         /rfo5UcH61uiwg2gMNxHUZC+9rkr3hyhvIPQ0Y0sg37bWJSqIegXm19a+f8twWqHcV/C
         Kg7FdrxYKJYgUbK9yEGPqJ23SZdQJlKDQ3Ci7cZ118FahbrEptvkhvai8ufRstDkAyRW
         F88Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTVv5FbZXsM+OWp684xDgGe5/kDnZ0bsfVyC8HVtZBRy+EM5JqbIOd8PhORiarEYH3Lwtt8GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFVSRYXtQcRkJlAjo59vS8Ahvzylzd0dg+RrhgXpV6qWvXU8b
	NFc0qNoHMlvie/EM1ihoqahCWHenzmnLNxY7Qp/q5oisGd8L4of8EIkjJYR7Mp96AEnbh6WWvju
	FVEUAlXtCOo/hlD2NghcqS3VLSbh3omnx/h8r2sfJ
X-Gm-Gg: ATEYQzy2N9K2s4GKJQB1y/8d4ZFR2rTY9TrqiU7A50OnAgVkC9lDj6pehA5WE7J1WpS
	OwOrrQ1YgDC/XONsy5vWFxdy2I8vRBMSuEqV5tZbm+rVrgbJ7V3h9Epm4Qd2RqNIh62fZ47KOe0
	f6Y98WLHjJ0RTLV1mX+8RA0OOz/RUA/OEUsvF/A74+H7pr57Lq8fYka8FT2sXCx7GcGcFIrkZxm
	H3sTK+F598MLUKjZYAhc5r7NMUNi+JgsuA8wKk615h76FMC2zGXZ5cxXdNE5MwSijeiS7xz2go+
	rEV8jpzucf8XJAG5eQ==
X-Received: by 2002:a05:6a20:3d21:b0:398:bcee:4506 with SMTP id
 adf61e73a8af0-39bceb6a713mr12969400637.38.1774297582653; Mon, 23 Mar 2026
 13:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315222150.121952-2-gnoack3000@gmail.com> <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
 <20260318.In1aekohyivu@digikod.net> <c3fccd822db5fc76b7fab00a9515eb276a71b421.camel@canonical.com>
In-Reply-To: <c3fccd822db5fc76b7fab00a9515eb276a71b421.camel@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Mar 2026 16:26:11 -0400
X-Gm-Features: AaiRm51FuUBzeGG69rPX77Gd8XhRpL659WyssRMUKEJbgtgMD3UG1iYgVDMDkg4
Message-ID: <CAHC9VhS-pygOtPHM1c5TYHCJehGtWY7x92Jmjbb599PRmPLXgA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
To: Georgia Garcia <georgia.garcia@canonical.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:37=E2=80=AFAM Georgia Garcia
<georgia.garcia@canonical.com> wrote:
> On Wed, 2026-03-18 at 09:48 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > > On Mar 15, 2026 =3D?UTF-8?q?G=3DC3=3DBCnther=3D20Noack?=3D <gnoack300=
0@gmail.com> wrote:
> > > >
> > > > Add a LSM hook security_unix_find.
> > > >
> > > > This hook is called to check the path of a named unix socket before=
 a
> > > > connection is initiated. The peer socket may be inspected as well.
> > > >
> > > > Why existing hooks are unsuitable:
> > > >
> > > > Existing socket hooks, security_unix_stream_connect(),
> > > > security_unix_may_send(), and security_socket_connect() don't provi=
de
> > > > TOCTOU-free / namespace independent access to the paths of sockets.
> > > >
> > > > (1) We cannot resolve the path from the struct sockaddr in existing=
 hooks.
> > > > This requires another path lookup. A change in the path between the
> > > > two lookups will cause a TOCTOU bug.
> > > >
> > > > (2) We cannot use the struct path from the listening socket, becaus=
e it
> > > > may be bound to a path in a different namespace than the caller,
> > > > resulting in a path that cannot be referenced at policy creation ti=
me.
> > > >
> > > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |  5 +++++
> > > >  include/linux/security.h      | 11 +++++++++++
> > > >  net/unix/af_unix.c            | 13 ++++++++++---
> > > >  security/security.c           | 20 ++++++++++++++++++++
> > > >  4 files changed, 46 insertions(+), 3 deletions(-)
> > >
> > > Some really minor nitpicky things (below), but nothing critical.
> > > However, as we discussed, I would like to see the AppArmor folks comm=
ent
> > > on the new hook before we merge anything as I know they have an inter=
est
> > > here.
> >
> > John, Georgia, we've been discussing this new hook for a few months now
> > but didn't hear from you yet.  We plan to merge this patch series with
> > the 7.1 merge window (in a few weeks), so before that I'd like to merge
> > it in -next in a few days to get a broader coverage.  I'm pretty sure
> > this hook will work well with AppArmor too, but could you please take
> > look to confirm?
>
> Apologies for the long delay replying. I have looked it over and I have
> no objections on the hook, it looks good to me. I would prefer if we
> got a reply from John as well since I'm not 100% confident but he
> should be out this week. In any case,
>
> Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

Thanks!  I can understand wanting to wait for John, and if I'm
understanding the other aspects of the discussion (unrelated to this)
I think there still might be some additional discussions or revisions
before this goes anywhere.

--=20
paul-moore.com
