Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52C3815DE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871120; cv=pass; b=erTMp6HgNA114kJpUnBxflknkUkgJS9XIuRdWIEeu+ruu7duaw/vXWtOBp4UjPc3/epqdndky3a2vGnYGt9G6eOk37bM0kxdmhXt0hUjaQrqUP0el+XRTyZydrIcdCuADB4ejPBBKdLIvQtOW+0O3P6Ci0iAzLeq4b8sF+yyyMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871120; c=relaxed/simple;
	bh=S0r0cGZ7NaesTXmp6HeI9s5W1vfRGs1p6GRplXqhx5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEw/QNZIGMlDg2odJ4xeG7Ovz9+7kOEVAg4Tt6HY8G8zBfl46qtRHiP6do/GLFmUEMqP0NyP//Kf/g0niBmmQN72ZiErjr53Fa4s91nvHkoK2s2sOSPBTzpm7mcYJmtEpXJ797qwlRDdgTKVN/Wrx0cF1Erml38jtNTPIjYRTM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7ehH5yj; arc=pass smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7ehH5yj"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-887ba76d5afso944812b3a.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 09:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790871118; cv=none;
        d=google.com; s=arc-20260327;
        b=RkdMvdC7PKjW8lEnjzTdz/J3ModeEhfVsPj/vKExqtvEVvrTyd9dX4zK1wTbLztjpA
         qrK8McDP526V7rIKJmnbIIEjuuu1h6UyxhpZ7ABDP544lTwvOf6pBJuKpr0BdH+rlCCw
         dRzBqCSXNEPi/9lAdm3A4UMRyNjt9nTqPc14SHBVI/+xkzZb36Cui9QhSfOi3ZCJodb8
         qbALLjUSiPu5nAw1O+pNw6hLQhfBRrXqu1h0EE+7+rWeyuffg4Uz8tutb2IhYyleYnXN
         hGEhSCYiMtwoC+ujGkikJTlowq5ehdG0b/DHR3ZMsrhydosoSwKoZoprOBSQN2rUyygk
         PPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5hKfE8YeFUB2v4D0quTu6qsZ47v3trhdTivuK/VDgPs=;
        fh=P6XLisPIm4GoyAKpM4/xO5f8XtTSP+iBeTkn6g9ctTY=;
        b=M+98qCNOngFBSuaqeLLaw7R3KKtERPTSnt1YTdM4gGORgK+5uuqrrOw6sK9gEb3F1M
         VHjaW16MoKUn2bDnolGXf1btzkbOC2I/+sls1UJRP1eKOv+i4tl4pt1jiKhFcjRs7RPh
         6A+RcNmBaVvBkbRaZTc85rA8b5zqb5F6vAQRE5CPJ9w1OOmEHkocYpvCFCVXIC2f1DFg
         IMbd/aLPhPoOwDDtieHrQlP3QHA8N52Tn0ixhueRsRkb6UbqMkifB76SAhtKK7LzwbRo
         EMayM7iJ47FbVjDp4P+dqjzFoRtHAOH9NsYZ7nMXyOZ0naz9fJd1UihXYwsD4SoY68zL
         SRVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790871118; x=1791475918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5hKfE8YeFUB2v4D0quTu6qsZ47v3trhdTivuK/VDgPs=;
        b=D7ehH5yjaPP3+GLQjDa8spEsW8WBXQIs3PK2wUXyhskiEZH9pmBCXR1ayOe+J8lyrw
         dVyfUCygNN26Bs/BS1USW1LbVAKA60KCGrc+25C2ykiiePW7I79PDUlsdT6xT/ZuI7rA
         JpZfPthI+A0RVFK5xjAnZG252fbVh33DUeIH6y9096aZ9YNsxQXDrpAS5VW8k1BU08KW
         9aGdhwTBk/bZ4zgiO4F4DB3YcunNmHrsVYqfD4diK7TWxX/3JuorZfPmY3xoSFGy+zKJ
         XS1oi0peDkE9lfGAd8jK3sjdydikU06p4+iU00aAqSJOSbDiQ4UMjy6uet2tAZsrjMtT
         liDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790871118; x=1791475918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5hKfE8YeFUB2v4D0quTu6qsZ47v3trhdTivuK/VDgPs=;
        b=XPZZXz0hdzI+ID0RP+pquirQ2LrIXPXHN+haCvQHkTBMPNPedK9w9xNa/svaJXf7Rr
         6tOAK3WraP71sw3NlCdvTPEN0ONjufXRwXWxMZSVWlhPx1KT7BGmTJKGJfYwLkLNuixm
         5etuPXtBCEPS/nRguOPSyeZ5gw+eXh2Wche5IRoTYXg0irkb4nGQcJD+lMswF3tExTI4
         a1IX9a4WbGXS+scstXB5aeXMCUCJnYDK+yzalh6PWt5HfuCaFRjbYEGL/XHU9lluJUfj
         xdWpyOY0Mh7nmrUsWtBd4rZdjYWXCMilDjvMUWmGm3yvc8i0M4LBpylILq/ykr4w/+cD
         u99Q==
X-Forwarded-Encrypted: i=1; AKwUvBzS3mEY8xk45HRQ6eeIaUrXGCDkqWm22Oi4tCr0bXHLI2hiSlCbl1cmOluvdPfzG/P4HrvzQJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lZxCQfkcNnXHaCOqTGXcmPix0VN8InsqlpufA8HEfuH0vh+EPB
	owurdOP/EcPjQdH4doM7ByDL8A069Sffta+OyInFTzDW9mnXjRMdwRVuMm/12pqK4EmUyA4Y1Bb
	rpHT4ff7llVZqXNqpYr1fabpyBDUXYOPfzdCpVYU=
X-Gm-Gg: AYBFou0UXW3v04dbYut/zOqobhMjREUxdKPuwm947O8KJn3dgQY6sl17UzC0jkWB7vI
	4pJj8lkStJTQK76m0yxBynclZZQ9IOTMv8ak6QJkXuBmoMRC2dNN91CK9Aad7/K9nXSifa1ZuJf
	aTA/L5HiByI4WEBpKosk44qfMN8iLkUW3YTX7gkRyir29obAJElIJs75vLxnP2AuCj5F0xPhDjR
	VZwI3NEwUp788fAUcIffTZZWpRbd645S+yMefUe84FYJrWhXDyiw5BIUCNlLm5seFMw7vccl1zh
	a6nxhOYrnTn8E6PushwGEBvAnbSMqP5JmoSH13Nvc/mW1FsgeuBO+ri1xVVWeQHHX2mroPRMAAQ
	I8hfjh6WhOEv1DP/THz8FYOCTe1PkMUVxIqAm2EsHsb/o11t0yssCgw==
X-Received: by 2002:a05:6a00:2451:b0:878:1aee:fa43 with SMTP id
 d2e1a72fcca58-88af5e9e0b8mr66237b3a.33.1790871117648; Thu, 01 Oct 2026
 09:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928190401.1641260-1-wbriggs@cellusys.com> <179083835206.434549.7959555054670908229@kernel.org>
In-Reply-To: <179083835206.434549.7959555054670908229@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 1 Oct 2026 12:11:46 -0400
X-Gm-Features: AclHuK-SE6KAyYVWH0zHyC1WoWJwVISfzWpNwt0v8Yvh6tmXfkow1wJu9vjLJXM
Message-ID: <CADvbK_fps4LrNX36j-MBpFmc-S5bQXhqkBgz+HC2RRuCvhdBXg@mail.gmail.com>
Subject: Re: [PATCH net v4] sctp: carry peer capabilities across an INIT collision
To: netdev-bot+sashiko@kernel.org
Cc: wbriggs@cellusys.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 3:05=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] On a peer restart (sctp_sf_do_dupcook_a -> sctp_assoc_update,
>   ESTABLISHED branch), the patch re-derives only the inbound counters=E2=
=80=A6
> - [Low] The commit message says the change only affects INIT collisions
>   (Table 2 action B), but it also changes behaviour when the peer=E2=80=
=A6
>
> --
>
> sctp: carry peer capabilities across an INIT collision
>
> When an INIT collision is resolved, this patch makes sctp_assoc_update()
> also copy the peer's prsctp, ecn, asconf and reconf capability bits, the
> ipv4/ipv6 address flags and adaptation_ind from the temporary
> association. It also re-derives the inbound ASCONF and RE-CONFIG sequence
> counters (peer.addip_serial and strreset_inseq) from the copied
> peer.i.initial_tsn.
>
> > diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> > index 4521be3bd85a..77ac155fdb70 100644
> > --- a/net/sctp/associola.c
> > +++ b/net/sctp/associola.c
> > @@ -1107,8 +1107,19 @@ int sctp_assoc_update(struct sctp_association *a=
soc,
> >       asoc->peer.rwnd =3D new->peer.rwnd;
> >       asoc->peer.sack_needed =3D new->peer.sack_needed;
> >       asoc->peer.auth_capable =3D new->peer.auth_capable;
> > +     asoc->peer.prsctp_capable =3D new->peer.prsctp_capable;
> > +     asoc->peer.ecn_capable =3D new->peer.ecn_capable;
> > +     asoc->peer.asconf_capable =3D new->peer.asconf_capable;
> > +     asoc->peer.reconf_capable =3D new->peer.reconf_capable;
> > +     asoc->peer.ipv4_address =3D new->peer.ipv4_address;
> > +     asoc->peer.ipv6_address =3D new->peer.ipv6_address;
> > +     asoc->peer.adaptation_ind =3D new->peer.adaptation_ind;
> >       asoc->peer.i =3D new->peer.i;
>
> [Severity: Low]
> The commit message describes this as an INIT collision fix, but doesn't
> the same code also run on a peer restart?
>
> sctp_assoc_update() has one caller, sctp_sf_do_assoc_update(). That is
> called from sctp_sf_do_dupcook_b() for the collision case, and also from
> sctp_sf_do_dupcook_a() for the peer restart case:
>
> net/sctp/sm_statefuns.c:sctp_sf_do_dupcook_a() {
>     ...
>         /* Update the content of current association. */
>         if (sctp_sf_do_assoc_update((struct sctp_association *)asoc, new_=
asoc, commands))
>                 goto nomem;
>     ...
> }
>
> These new assignments, and the counter resets below, have no state
> check. On every peer restart, a live association in ESTABLISHED,
> SHUTDOWN_PENDING or a similar state will now:
>
>   - replace its prsctp, ecn, asconf and reconf capabilities
>   - replace its ipv4_address and ipv6_address flags
>   - replace peer.adaptation_ind
>   - reset peer.addip_serial and strreset_inseq
>
> The restart behaviour may well be correct, but the commit message doesn't
> mention it, and the testing only covers a COOKIE_WAIT collision. With
> Fixes: 1da177e4c3f4, this goes to all stable trees.
>
> Could the commit message describe the restart path too, and could that
> path be tested?
>
> >
> > +     /* Re-derive sequence counters from the peer's Initial TSN */
> > +     asoc->peer.addip_serial =3D asoc->peer.i.initial_tsn - 1;
> > +     asoc->strreset_inseq =3D asoc->peer.i.initial_tsn;
> > +
>
> [Severity: Medium]
> On the peer restart path (sctp_sf_do_dupcook_a()->sctp_assoc_update(),
> state >=3D SCTP_STATE_ESTABLISHED), only the inbound counters are
> re-derived here. Shouldn't the outbound counters asoc->addip_serial and
> asoc->strreset_outseq be updated as well?
>
> On restart, sctp_tietags_populate() reuses our Initial TSN:
>
>         new_asoc->c.initial_tsn         =3D asoc->c.initial_tsn;
>
> and sctp_unpack_cookie() bases the temporary association's outbound
> counters on it:
>
>         retval->next_tsn =3D retval->c.initial_tsn;
>         retval->ctsn_ack_point =3D retval->next_tsn - 1;
>         retval->addip_serial =3D retval->c.initial_tsn;
>         retval->strreset_outseq =3D retval->c.initial_tsn;
>
> The restarted peer runs sctp_process_init() on our INIT-ACK, so it now
> expects serials starting from our initial_tsn. The ESTABLISHED branch of
> sctp_assoc_update() copies next_tsn, ctsn_ack_point and
> adv_peer_ack_point from new. It does not copy new->addip_serial or
> new->strreset_outseq.
>
> If N ASCONFs were sent before the restart, sctp_make_asconf() builds the
> next one with:
>
>         asconf.serial =3D htonl(asoc->addip_serial++);
>
> and that serial is initial_tsn + N. The peer's sctp_sf_do_asconf() then
> discards it silently, because it is above peer.addip_serial + 1:
>
>         } else {
>                 return SCTP_DISPOSITION_DISCARD;
>
> Would T4 then keep retransmitting this ASCONF, with every later ASCONF
> queued behind it, until sctp_sf_t4_timer_expire() aborts the association
> at max_retrans? RE-CONFIG requests would carry a stale strreset_outseq in
> the same way, and the peer would answer SCTP_STRRESET_ERR_BAD_SEQNO.
>
> Most of this mismatch predates the patch for associations that already
> had asconf_capable or reconf_capable set. However, the patch adds a new
> trigger. sctp_cmd_process_operr() clears asconf_capable after an ASCONF
> has already used a serial:
>
>         asoc->peer.asconf_capable =3D 0;
>
> The copy above now sets it back to 1 when the restarted peer advertises
> ASCONF. Before this patch, such an association never sent another ASCONF.
> Now it sends one with a stale serial.
>
> The COOKIE_WAIT collision case doesn't appear to be affected, because the
> local outbound counters have not moved yet at that point.
>
> Should the ESTABLISHED branch take addip_serial and strreset_outseq from
> new, next to next_tsn?
>
This looks a legit one.

Since asoc->peer.asconf_capable and asoc->peer.reconf_capable are updated,
we should address it in the same patch.

So please follow the report above to update addip_serial and strreset_outse=
q in
the ESTABLISHED branch.

Thanks.

pw-bot: cr
