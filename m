Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793558122;
	b=RWZ43UEKimdx96N/yX8k6Q+fkoHa5qwaFq1G1P5ZBsTgy09fdJHw9YjF/WOzzXwCMVI6
	 gR96TFwDKimVP3OCvfyg9DdjPL5kJDX2kA0aamM4vC6zdxXj5FH8i1yFalY9smFTP236/
	 IYY/kEUKo5aCokOUJFo4rzf+kUG7p8tGhWB1mpGWPD9eXdSAOVI+pQU1p0gsI28bBq6/P
	 sU5U66RysRpfGs4aqfrLAMAW8796exMIsQTVyEqzpoXyaWsfI6qA/DUeLOWGwOJHOSng+
	 +qClTknQEjtVRX0mFHcthcVROnM8v2/GGl2vssiwmz1gUuJKPi1jPIYGuhdOWiI2l0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793558122;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NeaxxiB8XRsAbArnbO9LqRRB+RzhYlXZCcVhtW2N93Y=;
	b=1aVTcxDqCpXKra8i1Am6r8qCrewgAoIxzwfdI1I+Lk815PmSJHBcDAy24T8hhf7PDsh5
	 WTSwyNOw9cGqfvuGLzDS1bquuKST8YlWRUjvUA3rh54pWmd4gQ0q21HxoTGFMc/+GUDeA
	 dQDVjWa8S1wVTwaozm1cgq9HeTCXB9mhurHPKezEnCwFPb1EQ6uJZilxAzemnb/ikvOM5
	 qEMcOYLKUhqN/K6dsr9QoY1w1qOsIAZHZqCEJXiF/iBcH+eBWAi97piUILyEtWnIQg/ag
	 kvsk1uzeDPVP5zPoCeAHQx2osnWrRS5rrbrsDU7YFcZsAyVQReyumCQXJrzcQTanNCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjAMwEJb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DA606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjAMwEJb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096971F000C1
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793558122;
	bh=NeaxxiB8XRsAbArnbO9LqRRB+RzhYlXZCcVhtW2N93Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gjAMwEJbZlqqwtzc3LO2nGRWfi5SukuXHOhig1Ouxb97KQiAco005hd47ggnBVMVw
	 NofncsR8hGIKDl/2CIfSfgXX/rKSFtkJ4h4Mjy0AQ9UsqDUnKGvmWnJp3gu8irpTWY
	 dXSrFdGbyHs5c1Oyz+9ZdLdkFT17ZWjDKni2/qhxn09A+vl/knwpLwACZv6RAqtlKy
	 AwaccJq4o1oVEt81mQFZCcS4thQpZEV8CK/41pK4AIEK/5aCOdLFx8b02bz1VfhovP
	 paR920GpESYeIUE38vRtwOW5/L2T+NRwuSUUlcQPIRf3mRahq8VxIZ9nuSIclXy3hH
	 rNGbXnndGr9aw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-82380b0f55dso1044624a34.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 10:35:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzCxDCfbm2b+2NPMXmXpO1o7KSWKKHfW71XeMyLiL/4Ki0M7tE6+Z3FSwNF+eMAZ+gAoLYVkXc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLstaPp7sjIiig2b9sPbBHjRTLFuIaBKjnunU1eurYM8yro5Sp9
	3MM1QN9NudbYnEPeunljnePTTRFN16m5hVBHgYNnBsXMgmy6Qq9p1G/uuKgFs6d7glu5XGG40wJ
	+M2aeyGagFwP8NF1oXCbX2Dd0U1JuHAs=
X-Received: by 2002:a05:6870:c2a5:b0:494:9d42:1e26 with SMTP id
 586e51a60fabf-4a907798b6emr4953913fac.54.1793558121351; Sun, 01 Nov 2026
 10:35:21 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6426d558e45fc6ab724c40af62e4a8793215dd8a.1793219189.git.gnault@redhat.com>
 <audm81hsgydhfWn3@google.com> <CADVnQyke=Xhtt3XFBstE5oDiZAXq0zqyN1XtCa_fe3iRYzKdDQ@mail.gmail.com>
In-Reply-To: <CADVnQyke=Xhtt3XFBstE5oDiZAXq0zqyN1XtCa_fe3iRYzKdDQ@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 1 Nov 2026 19:35:10 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq+2q24Er0QJ0G+jxg9s6Up98L7Xb2Phaqdipx=UsUbmA@mail.gmail.com>
X-Gm-Features: AclHuK8iu-f9Aj9w3B26-Em_Ta9c9KnAMSfHSnL1Sz9utiOk9aqJ26k2RRjKpCA
Message-ID: <CAL4Wiiq+2q24Er0QJ0G+jxg9s6Up98L7Xb2Phaqdipx=UsUbmA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Fix dup-ack detection on non-SACK
 bidirectional data transfer.
To: Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Guillaume Nault <gnault@redhat.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Tom Williams <Tom.D.Williams@morganstanley.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 1 nov. 2026 =C3=A0 18:52, Neal Cardwell <ncardwell@google.com> a =
=C3=A9crit :
>
> On Sun, Nov 1, 2026 at 11:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Wed, 28 Oct 2026 21:32:35 +0100, Guillaume Nault wrote:
> > > When receiving a pure ack from a peer that also sends data, we can
> > > have SEG.SEQ > SND.WL1, even though the segment contains no data. Thi=
s
> > > makes tcp_may_update_window() return true (because of the
> > > "after(ack_seq, tp->snd_wl1)" condition), and tcp_ack_update_window()
> > > then adds FLAG_WIN_UPDATE to the segment set of flags, even when
> > > there's no window update.
> > >
> > > Since FLAG_WIN_UPDATE prevents the segment from being considered as
> > > dup-ack (as it's part of FLAG_NOT_DUP), this can inhibit fast
> > > retransmit on non-SACK connections, making recovery very slow as it
> > > now entirely relies on RTO.
> > >
> > > The "DUPLICATE ACKNOWLEDGMENT" definition of RFC 5681, section 2,
> > > says that lack of window update is a necessary condition for a dup ac=
k:
> > > "(e) the advertised window in the incoming acknowledgment equals the
> > > advertised window in the last incoming acknowledgment.". Spurious
> > > window updates can thus prevent dup ack detection and, in the end, fa=
st
> > > retransmit.
> > >
> > > Avoid this scenario by setting FLAG_WIN_UPDATE only when a window
> > > update actually occurs. Pure acks with SEG.SEQ > SND.WL1 can now
> > > be detected as dup-ack and trigger fast retransmission.
> > >
> > > Also, stop setting FLAG_WIN_UPDATE in tcp_ack()'s header prediction
> > > path. One of the conditions for header prediction to happen is that
> > > received segments don't trigger a window update. This flag update was
> > > thus wrong to begin with. Now that tcp_ack_update_window() sets
> > > FLAG_WIN_UPDATE only if a window update actually occurred, we need th=
e
> > > header prediction path to stop reporting spurious window updates too.
> > > Otherwise BPF programs would get inconsistent window update informati=
on
> > > (CA_ACK_WIN_UPDATE) between fast an slow paths.
> > >
> > > Finally, add FLAG_SND_UNA_ADVANCED to the definition of FLAG_NOT_DUP.
> > > This is necessary for the case where an incoming segment acknowledges
> > > less than a full segment of the retransmit queue. Such segments were
> > > not considered dubious by tcp_ack_is_dubious() because of the spuriou=
s
> > > FLAG_WIN_UPDATE flag, which prevented the segment from being seen as =
a
> > > duplicate ack. Now that FLAG_WIN_UPDATE doesn't cover this scenario
> > > anymore, we need another way to mark these acks as non-duplicate.
> > > Adding FLAG_SND_UNA_ADVANCED to FLAG_NOT_DUP is the natural way of
> > > doing this, since, by definition, a segment advancing SND.UNA, even b=
y
> > > a small amount, cannot be a duplicate ack.
> > >
> > > A side effect of this patch is that repeated zero window acks receive=
d
> > > from peer can now be considered duplicate acks (because of the the
> > > "|| !win" condition in tcp_may_update_window()). Therefore, they can
> > > now trigger fast retransmission and fast recovery, including congesti=
on
> > > window reduction, when the peer is stalled. This is RFC compliant and
> > > shouldn't have any negative effect.
> > >
> > > Add packetdrill selftest. Before this patch, the 1001:2001 segment wa=
s
> > > retransmitted upon RTO, now it's sent right after reception of the
> > > third duplicate ack.
> > >
> > > Thanks to Tom Williams for the investigation help and initial
> > > reproducer.
> > >
> > > Reported-by: Tom Williams <Tom.D.Williams@MorganStanley.com>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> >
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>
>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
