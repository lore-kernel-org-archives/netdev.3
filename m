Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E713DF01C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786475168; cv=pass; b=nihOljyD4UZtmWztbtrrPb6N26Z4oQRR6Hx6FCjZKOQnObET1B5nZzVhgq1j/9Ko+xyRiSxnZ+CsfrcKtNU0KP2zc5VSk0bBkUQfozxWGNM+6r8CZKikzMEc39iY0dQd+dA64ry20tAmXrK6rco6gN5Rg+s3RAfmdElFyqohLAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786475168; c=relaxed/simple;
	bh=rKjUe8l12laQaYCR2nsnMV+NraIoKfBe+/vXRLFKb04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4LkjBgzBZnCIKxbYMyDetE3RTczqKk2+4hHCs9pGNYKiQK7p/aZZ5VoOSOIp6Wfumkse6TcpWMXqIb/nFYSGeifyzdadti7Tn1ehLnY9WYKHddZq6fndKRxduh0K+0bRFign1wxFTSwMOU4JIvlEtf2gJKgKs0sNwFb5CT/5j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sS0AMO+F; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS0AMO+F"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8f0e5e36912so1063666d6.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786475165; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbT2III8U15359SGMMKa1kZ+w42M3oezjfAmsbRZzPRxHRnifJbMJJYeT6E6eT0AmC
         S/VZi7rtq/QuSVcro+xLAqKLiZSSrctGxkXcDt0UbL3qgeZW/4kQ3KC4WyJ70aZEWDOE
         XnNFPOwhMTF6tPGJh8iihwrId/TRNvBwy2Q7UXkbJYuh7b4nhhzCo3mfEv8c5QOG3vxY
         QxZ1IDIYltDtrQ2GCLCFpn2SVK4QXkteENb2qpSim5q+xrJJQPl6Sil2yCeOxDsS7eGc
         DIs1mqeKCONLd3qmG7/n3B2QHck2YqZcP73mOFWDloN3HYU1HCdOFjHvxsnGOhurf4Gm
         XMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=enZbBxN3Oyyjq7G1ENN3d+tcDx1SrKg3URWD8Mv+loA=;
        fh=AEDqiM8iHxbyxBvXmQtwWJuA1p6kFo0g7FCqFl9CAbE=;
        b=rfIfwLqvybW5Oz7DRLAbwV3MjOJ/Ly+ijj98AIxFbd8dBzJJmO3hl4WCNWzNZ2JDLd
         n6N3lVBVHGtyce7AbO8+0y93Ff8HFOeD7P/gsp6q5a7p/+KQSBGKeDjmueped/HCzzst
         nNSXOfayWbq4BeEQ0eQFayWqadJDUxO+34mrU1t9Ob2F7KPEF1vT6zdNtggSo3xnLxA/
         7H8n5GAIOHOHo0pRIyOuVVXcnA/M2TbUHLxoFchYDfR43d8XJIjrZgoXJFSvhAp8R28X
         kPm5dIAclMy2FytYkOwF7+8O0tM5Nh35pJBAydvcUYWo1RSWwU0t5V67xmjUDPiSiu7f
         CUXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786475165; x=1787079965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=enZbBxN3Oyyjq7G1ENN3d+tcDx1SrKg3URWD8Mv+loA=;
        b=sS0AMO+F772c09vT9GeYFDPZgmL44sEMFxRyMp5ikGOI4OJJLWgBQRyafKJ+Pn+VUO
         3lhI4hwbXMjJH92lxrFWXSkHnNkSEFKCL3EeyvDha3TapPmscftAitC766lKqjr3bmLl
         5gJgUdOTfFpX1EbATOZhUs2R7M4MqYSlb7TpxgwZMx1+w+9hkHkj2fhP8pw680YwJgaU
         9NBzylt+dAjWPMys8CwveuYJwZUY02XwC0w9NQfYGx6eFASLx/LFhlTl7ffTmBCXPRCZ
         m2zbo2kD8hDTwZseD8oOP3TuLpzGUhOC83P0MO8JHrP+avkJUL2nwV6bA+eWs2AKE/L0
         CG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786475165; x=1787079965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=enZbBxN3Oyyjq7G1ENN3d+tcDx1SrKg3URWD8Mv+loA=;
        b=GRGvY1yioL7J7nmN8mJTCEw3FuJnlOJVet2n0mVCXp6w49jP7Yk5us9YRecwo80idr
         x0FK0ONWe6YKqxbFF370t5HPVYIfuCYaj70A7JyObvQnaX3x9VNE1IFthYHFmYHGSFBg
         tZ8DVUzabVLvKvIOwAWKNi38Ox+ZzsfQg6e5lNtekgOrq1y3C9Jv4nvAAMkifVxdNa1o
         z5XESbMb9QXQ0FiPhrv6xltF1dGZ0arU8hTg4h3DpRpICnO5qyPxY/N91TF7HdyKc/2Z
         rx/tusG6J3Jb4TH0fmfGrSIDxDkFUNzVD0JGEXKTZEhlRi5b3Fdn/D/TcZDMr+vqyUnS
         3N5Q==
X-Forwarded-Encrypted: i=1; AHgh+RoQ8Ej0NI/vQHh/QBfzLDnYG0QF7a+23ZIhLhAihSFnuzBc05HwqUzdGF9okFG04oGL8L3ZL8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyynlotJa0xeNWV24XxrdjXXt/w6jhv6oVrNC01tSLd7VUCzOOE
	vggwS+OO1kIMMEDGRCPd2hoZFQEZvgK3p52hc+x7eiocK84zlN+0ztTW6WngMDHxZ54Ee+CSfVx
	/PJBx8/3TFCZ+dpMKO+OeLSb+4e302Mg=
X-Gm-Gg: AR+sD119BqjlgXarZwlGdBkytkjHVu/KMaIx2EJQaw+Xv+OJ46QxIazVI7m6mDkqhJj
	jPlVCh5V0J1N7FpTOXBBXgFTtSl9POlRxSnwHWqjYXYpIKedqaKxIy7JMIc8c+TkUEcVaj7ZOvj
	+CsMp8xM0qOwA61EIbF0EV/nFaIXeT/ZiBnXEs/kHgQZBiE3cX1it27lbqsdzFTol3kw3FZ1ZLM
	HELRjs+jWgWRxiyYK2Kn0PkzxCCSyus+MGvQxwjUtpbztRdBIu8BpyDOy2SssV6XYq5iUkHGJqF
	mVyebRG6eAU1IGKU3KISgFn1J54G/BBM8sBoN9cgUg==
X-Received: by 2002:a05:622a:4e9b:b0:517:6d6c:187f with SMTP id
 d75a77b69052e-52d600f6931mr26600781cf.14.1786475164759; Tue, 11 Aug 2026
 12:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785995291.git.caoruide123@gmail.com> <a12d76b7f2305b5a8d64c3d6c3585e39684ff792.1785995291.git.caoruide123@gmail.com>
 <5ac3773c-4a6f-4796-a43f-545c3c42271c@kernel.org>
In-Reply-To: <5ac3773c-4a6f-4796-a43f-545c3c42271c@kernel.org>
From: Ryder Grass <caoruide123@gmail.com>
Date: Wed, 12 Aug 2026 03:05:54 +0800
X-Gm-Features: AUfX_mycIscTqbCmmYibXLk6WZz8k7CRi-SgcT9cJyOuNj-7U0yDo1zelPV2cj0
Message-ID: <CACveakTyaFu-KSuPU7xHGC-_y4AMZTL4E2qFwMmF208d0j_GbA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] mptcp: fix MP_CAPABLE token migration when
 cloning reqsk
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	martineau@kernel.org, geliang@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com, 
	kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thank you for your comment. We are adding a
mptcp_sk_clone_destroy(nsk) in our v4.

Regarding the comments from Clashiko, my reply is as follows:

Comment 1:

> This isn't a bug introduced by this patch, but does this clone helper als=
o
> need to migrate the MPTCP token_node for MP_CAPABLE requests?

I agree. Patch 1 only fixes the MP_JOIN msk reference ownership problem, bu=
t
the same request clone helper also needs to handle MP_CAPABLE token_node
ownership.

Comment 2:

> Is it ok to pass an MPTCP socket to tcp_done() in this failure path?

I agree that passing nsk to tcp_done() was wrong. nsk is an MPTCP master
socket, not a TCP socket. tcp_done() and inet_csk_prepare_forced_close() ar=
e
TCP-only here because they use tcp_sk(), so they can interpret the private
MPTCP socket layout as struct tcp_sock after the shared inet_connection_soc=
k
header.

We are reviewing v4, and will send it out soon.

Best,
Ruide


Matthieu Baerts <matttbe@kernel.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=B8=80 02:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Ren, Ruide,
>
> On 06/08/2026 13:14, Ren Wei wrote:
> > From: Ruide Cao <caoruide123@gmail.com>
> >
> > TCP request migration clones pending request sockets with
> > inet_reqsk_clone().  For MPTCP MP_CAPABLE requests this byte-copies the
> > token_node hlist state into the clone even though the token table still
> > names the original request.
> >
> > Moving the token only after inet_ehash_insert() succeeds leaves a windo=
w
> > where the cloned request is already globally visible from the ehash but
> > the token table still points at the original request.  Reordering the
> > move after clone but before ehash exposure closes that window, but
> > concurrent RX can still race on the old request and observe that the
> > token was already moved.
> >
> > Move MP_CAPABLE token request ownership during MPTCP request cloning
> > under the token bucket lock.  Make mptcp_token_accept() and
> > mptcp_token_destroy_request() re-check token_node under the same lock a=
nd
> > treat an already moved or removed request as a normal race instead of
> > warning.
> >
> > If the passive MP_CAPABLE socket cannot claim the token, fail
> > mptcp_sk_clone_init() and let the subflow fall back instead of
> > installing a socket with mismatched token ownership.
>
> Thank you for the new version!
>
> I have one major comment, please see below:
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf140402=
2e8c9430.1776149210.git.caoruide123%40gmail.com
> > Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> > Signed-off-by: Ren Wei <weir@nebusec.ai>
> > ---
> >  net/mptcp/protocol.c   | 12 +++++----
> >  net/mptcp/protocol.h   |  4 ++-
> >  net/mptcp/subflow.c    |  2 ++
> >  net/mptcp/token.c      | 61 +++++++++++++++++++++++++++++++++++++-----
> >  net/mptcp/token_test.c |  4 +--
> >  5 files changed, 68 insertions(+), 15 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index ca644ec53eed..07eaa6858d05 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3608,17 +3608,19 @@ struct sock *mptcp_sk_clone_init(const struct s=
ock *sk,
> >        */
> >       mptcp_set_state(nsk, TCP_ESTABLISHED);
> >
> > +     if (!mptcp_token_accept(subflow_req, msk)) {
> > +             mptcp_release_sched(msk);
> > +             inet_csk_prepare_forced_close(nsk);
> > +             tcp_done(nsk);
>
> Here, you cannot call tcp_done(nsk): nsk is an MPTCP socket, not a TCP
> one. You probably want to destroy the msk instead.
>
> (In theory, your reproducer launched on a kernel with your patches
> applied on top of MPTCP's export branch [1] should produce a warning)
>
> Apart from that, Clashiko has a few comments. Do you mind checking them
> and reply to each comment here, before sending a new version, whether
> you agree/disagree or if it is unclear, please?
>
> [1] https://github.com/multipath-tcp/mptcp_net-next/
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
> pw-bot: cr
>
