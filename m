Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F77364059
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791706522; cv=none; b=ZIuj0MWV8LZPJX4yoMOhaM5/91LamfCPtHSkxU2Qkg6jeZ4w0ODQoa9XN8Hxal0b5It7BL0l+v88LEn0XoiiR/6RVg2Z/HW1f9k2cXSAI5YA+EjlwDu2w9o3WaRDdwPfsqAOnor6vfd46zmNj1c7I7zAoblGNjvJY8uHfNH36nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791706522; c=relaxed/simple;
	bh=/FCg25jwFYL2ar3DHPT39gbE1Iw7WOPXNMb12c2vqN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaEDEgkBjfMEisk2VYGTyqwMTSPbFrxC/vejJAyEeMXtJxcLV4yexhCHeaS7C++/kjBcoBpRm0YZA8E4sXppWgFEsUQdZk5lZxJL1h6XcI9Y4ClNu/+uIqXM0MG9auIySgFzb5PCXm0KHRwQ/JGGsSreTRJTlGvQM0Th1EH9osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkAueSbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkAueSbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729EE1F008A1
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791706521;
	bh=CVfiSFcCF0e/GPeUJhHYWYQxeQKMAvPyvPYtAOqKv1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AkAueSbnjw5a6OIk+Q40Bko5u0dnx8+RQRi89c74qJ5Vs8FZpmntHIev7ZXD8uoWA
	 DTejzy9KJbdsMe76wJ3Z/5bqbcX1sPMge3aGD7NS3tc1Fzl0km5LvtXN/VkGwxU81W
	 YkR/0RhvmB2/FvD/f+eyoIwecF2w/arvE4/SNuxfecsHzJ3LHfwx7TL3scP7lop6bd
	 3QXIe2WjAm0cAfYKV/MF/b9BpG5U7FRAWfBJTaHYZg4ZFziRSM9dlfNOqvk5fcWA3A
	 RmMTZ+KFZ4o+zcwGA5uGg8wKOp30SPcmQgiji4tSEmWTVZyi9YrPyLNHWJEs9q+mTQ
	 ms6m+Np0iulXw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-483d290f398so652937fac.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 01:15:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz/w7jP7VVgm+sq1y23JAYh/S9qWhVXsLwE1fTt4RGCRJiJPVy7zekXA7mKiaVFe46rd2BMivA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeW7hJoNlbVKx5cRGZluh6Rcs/yfcWe0I3zdofg24vnNS2sRDY
	0zIEqVowCXDT8dJTwVV9Nt//tkD623KjLWxWJKuZ/IoVQfe1lMvMAeqDorcHqMadKhAUKreJKdz
	u0ERBaGbR3DEdPLbgi+CU2A9roT5m/m8=
X-Received: by 2002:a05:6870:1495:b0:4a2:21ce:f2f8 with SMTP id
 586e51a60fabf-4a2a88f8190mr6010986fac.41.1791706520768; Sun, 11 Oct 2026
 01:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011052006.60585-1-jain.sm@gmail.com> <179169628642.2527009.18099159731266030842@kernel.org>
 <CA+FWx==a6tGvhtPfz92PJa4CxgR4tGNBGHQMq9jEhX5P-4sB2g@mail.gmail.com>
In-Reply-To: <CA+FWx==a6tGvhtPfz92PJa4CxgR4tGNBGHQMq9jEhX5P-4sB2g@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 11 Oct 2026 10:15:09 +0200
X-Gmail-Original-Message-ID: <CAL4Wiio1bAsM_Z2LEQz9r0-ehHoWpzTneWy49hd2FGeoVVEQhQ@mail.gmail.com>
X-Gm-Features: AclHuK9B4U4RVCwX7L_yEsSbxUzqDO0uYorO0scfr3eIuyaVKw-Jzcv8lIuYjy4
Message-ID: <CAL4Wiio1bAsM_Z2LEQz9r0-ehHoWpzTneWy49hd2FGeoVVEQhQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: keep the route window metric when SO_RCVBUF is
 set before connect
To: shashank Jain <jain.sm@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 11 oct. 2026 =C3=A0 07:26, shashank Jain <jain.sm@gmail.com> a =C3=
=A9crit :
>
> The issue was found by manual code inspection assisted by an LLM
> (Claude Code, Claude Opus), while reviewing the networking changes that
> set window_clamp on unconnected sockets, and then confirmed with a
> reproducer before posting. The patch carries an "Assisted-by: LLM" tag
> for that reason.
>
> Reproducer: mainline a5ebb76233b7 built for x86_64 and booted in qemu,
> two network namespaces joined by a veth pair, with
> "ip route replace 10.0.0.0/24 dev <veth> window 4096" on both sides. A
> small program sets SO_RCVBUF before connect()/listen() and reads
> TCP_WINDOW_CLAMP and tcp_info, and the SYN/SYN-ACK is captured with
> tcpdump.
>
> Without SO_RCVBUF the route's window metric is applied
> (TCP_WINDOW_CLAMP=3D4096, rcv_wscale=3D0, SYN "win 2920, wscale 0"). With
> SO_RCVBUF set before connect, mainline reports TCP_WINDOW_CLAMP ~1 MB
> and rcv_wscale=3D5, i.e. the route metric is ignored. Reverting
> b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is set") or
> applying this patch restores TCP_WINDOW_CLAMP=3D4096 and the scaled-down
> SYN window; with no route metric configured, mainline, the revert and
> the patch behave identically in all four combinations.
>
> Thanks,
> Shashank

Note that we ask to not top post on netdev@ mailing list.

A few remarks on the changelog:

1) "TCP_WINDOW_CLAMP 4096" only holds until the first data segment.
Since a2cbb1603943 ("tcp: Update window clamping condition"),
tcp_measure_rcv_mss() overwrites window_clamp from sk_rcvbuf as soon
as scaling_ratio changes, with or without your patch. What the patch
really restores is the SYN/SYN-ACK window and the window scale.
Please say so.

2) "no window scaling" is not accurate: we still send the option,
with a shift of 0.

3) This also fixes TCP_WINDOW_CLAMP being overwritten by a later
SO_RCVBUF on a not yet connected socket or a listener. This is
probably more common than the route metric and worth mentioning.

A packetdrill test covering the SYN window and wscale would be nice.

It seems to be a net-next candidate, since WINDOW_CLAMP is not well
documented / defined / implemented / tested.

pw-bot: cr

Thanks.


>
> On Sun, Oct 11, 2026 at 10:54=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wr=
ote:
> >
> > Hi!
> >
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> >
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> >
> > The evaluation is done by an LLM so it may be wrong, if you think
> > that is the case please reply and explain.
