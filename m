Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793054325;
	b=voMxhFJEfMA8LkZWy6/OoRHLyv29b+ghAJzL0dqTjAlnv4dFim4Q2gnrZS2FVZRSD+N4
	 drbtxJXWoLSmOScvsq/0ggM0omRJUPWdIGCkMGEzG69hvDaVaAPA3C0ZneufWrCLhALTn
	 SJ0at7JyCVQa5+f/dGrPUckhVt0k7uzZC+Hym5U3K5Sn4pIDCmOfc9Hnbdk4iyw91Z1CG
	 Vopfq2L87KAZP9D8yl+k5IT7dskHJdwxhCNPs/ImlsjrfpG7gUU9UP8VNT6QdHTL3ziyg
	 itFBBZbQUiGQ0u08mJfjk0/kXSmB7ppjlUWWxmGbsUACHMqKMa1Sj9fHZmk6UD3qQCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cHXZbNTUg/Ax1p5zA4xqb/Pkz7l6MQaU/rT8lSK2nOM=;
	b=4FrYS8zyJxh2UT7EZCPjoymlpiDDcZ1nvQFcR6Ge7RdqDUlpbHEu88yQ0bS62+ClRLYk
	 oJypHcZPuNKiKXlPRY5Q738mui+ym04CZSO3piRifFrUS+le2Px2CQfaXJ9vFxCuxANLd
	 1xkIH6h9DqB1Qh+mvyVGdXvkQPTPzFz6NS1kddld7teJQezbPDbh5NWXk8hHlQ2YXgNeh
	 mZ8/AQGnuCJdfSHgsUg5YYinR7f7QgUJEMfQMhRitIW+HpjMryRLxHwVKmD9Sn8HoglS2
	 3Gioh8p0hCeJevYBViLASWZ5332ViGZZcLCvFxLVYFAYWOUTVXS5KkZ9mAsT3vD0s0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AhkYbOgr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EC606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C7EC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AhkYbOgr
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so2444531b3a.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793054324; cv=none;
        d=google.com; s=arc-20260327;
        b=OJYs8Fmnhy1Xw6dCQkg4z/1z4ezsjdXfz3qTKVilSiKWwZ3xiHzdOv/IdaGcb3f6um
         Ww7V13jd84NuBpKlAf6KBVMf7vuQnWMoBLcnEuGMw4zEVQnMsE4KIDbpGkRfIKrQoLdG
         Y+K2kZYFBidKhr06VtJUfxksRf1kKZOGG4O0aBOfc3kAC7qHziyCWsDar2yucd+Z2W9N
         NoQfuXa5j5YP3al3WEsWDIjBJySoj1PmHEuB3PuBQUq25y+3CEdCChwEDGIkhuYw2Ws3
         ZaadOkpo5wQ+etIBeRqHYLde6B7GdEYGnlLuuqPgyyf39JeZc/BdQU96volGEbW9SHXp
         E6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cHXZbNTUg/Ax1p5zA4xqb/Pkz7l6MQaU/rT8lSK2nOM=;
        fh=wER0C7QWD5j0U6VmKnK8AizfQAOBri+N8uz/0mstWRY=;
        b=sdiGo4c/BW2Ugqe14E68AiIKOg2CBILLzzaoxMZSnah8zeUSaFeHf3PkIxXSbjlJYu
         6EZfKCTQnlgFfYljIsV03lCMvnCSRQvX/iUVdOLfOh1hMoWeww+4h3Owu0vaBFxx+bFk
         ehLOa4H3ZezOFppyXMjFKPaiupTy7nliJoFQhlwPBwrtL019Ho6YX3sI79mHwGpbA21J
         Uf+OapZ8N5zLKkT8CyUZ2v5MRr7ymljRewMY0s7dOnK2sK39fr8vdbCqGNPllv6kxk+t
         95AUxJbf2//jjsQv5MudLtqbk2+OuSXk1UuBo+EiDxvRXFc75XqSVj6aFtceiPU3jXNB
         gJ3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793054324; x=1793659124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cHXZbNTUg/Ax1p5zA4xqb/Pkz7l6MQaU/rT8lSK2nOM=;
        b=AhkYbOgrlKuxl0cBRMaCcQFeQKH33/Zs4GV4wWsW1yxxo70qOYtYHPDypHnGOR1fDX
         BtzQd/zto+rNjL+a2+Wk224dfucP3x13AXdZmPGVt91cBlzxdjEUCqbwEbiTaSVR5BeO
         LmWy5gztB96pjlwKNPnojgLN7jldXRlZKFOhwRE6YrgphyQI5ncevlOxzOoMhh3ibibO
         UW5oia+Hdk1v3Dyn9yCAhszv0H2GhMkaSJ0yZ9vSekBPLQMPxcyhTwwv+AASdXSueHvE
         vsWXX/IKHKsItO3CnPAdjKcNM/XGb4hcFwbrlEkq5OGsYUjECtRhkJvJrQXY/k+uF8na
         fI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054324; x=1793659124;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHXZbNTUg/Ax1p5zA4xqb/Pkz7l6MQaU/rT8lSK2nOM=;
        b=LCmAWmHUduDLAJ9rAvcQv1dUXSHF3jTNZIyzls2wvKEcif5OIv+tP3WfJdDipRGqI0
         h+5mMR86xycEDZHR4rizhpDl6sHxS2G/EMqAy52va6u93ZyqwCUkETjeQkKQ8TW9IJDl
         fvYmQl61CCu5FuwUXbM1dfDnIXRbP3xQK0KTalECuyWzBjh5sbUpxeraqEBtm1+a5dES
         ZYBFiScwURbiKw0K6ihAX+W0bJIsvuCzEoJ3chfRJknckVVobatEus8ZHaNHkKaMTG/e
         oRbx0ULLfD0g0LOqwUtbaBctlmdrRafZySM6r2AqKyJieSdZZuXR+srq7ytqNUb3aiMn
         k55A==
X-Forwarded-Encrypted: i=1; AKwUvBzrkm0sqao1vEAoqXNvgcSs8SVC6yez+ohb3lic9BWJ7NKV/tCv9spV7DR7ExRlilvtSkWF57E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJREIR7iaYB1w39XFX+MF40n7v2Q1o21AQMVSa1J+WKFW4ozvev
	vgLxzXXqBRmCIsVRNjE/+zrBTiiKDfaH0uWFoQkdfz5eAjRS7fDmQ+CcTCWuZ2oelFeRF8NVUmU
	t975kO7J6FFuLPWtBZIKAmpMEllFWw7o=
X-Gm-Gg: AYBFou2vfCdq2IB1+dbceRyuIpuuC0HLkFabIPmlw6QnQecSwaK+UN+Ma4LDZTREioH
	EEsYhW9ahT5Z43czNphXNYgqnOUBbSeKr07cMj7mqvtIvUpA1ycEbKLYMpwNpH06EAanzk2zdfr
	KtXlW/C7vqGDHl20GM3gyIFWCpOD6CLy/5IVGOeT04uy/gf30TvYHJTVAIMjAlfJr9ZSSv323Ah
	rx3D4pM2l1GPuPaOyLeZTOk+iSTPDJitVt7xDk7gaiGAUbnN4uJ+iSiE5FW2XDw6eGEn5SLYRj7
	CBQC4qNYfSvHsVVVMdEzkqmFei7YzFjuy5UXPeOlUhkCRq81fVj/bv1At0Z575SDyNZREYluTS5
	tk9YW8p+KGpMzKDQB8p8NIVisS/FzOnijJXaaSTCD3c9ouC4aH3aMR2nsTApY6oU+taWgXtHnEV
	6JKM+JFPwLRFFT2uM5JOznKDqwXL9n5qqY3w==
X-Received: by 2002:a05:6a00:800f:b0:881:a5b6:7954 with SMTP id
 d2e1a72fcca58-8a367a3e9c5mr6111889b3a.39.1793054323880; Mon, 26 Oct 2026
 15:38:43 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022163639.2566945-1-andrey.misyrov@gmail.com> <179303675173.3134.11217955296529787762@kernel.org>
In-Reply-To: <179303675173.3134.11217955296529787762@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 26 Oct 2026 18:38:32 -0400
X-Gm-Features: AclHuK__RAb9glund1hU_JAR20mlu30KhixzS1u2vtH0FD81M4p2c0D4Z7kbBXM
Message-ID: <CADvbK_dTUCUFn+sLY+zuN5_9+YC-axzM9FVr-yBKJ4jxwebkkg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix ASCONF address change on single-homed hosts
To: netdev-bot+sashiko@kernel.org
Cc: andrey.misyrov@gmail.com, marcelo.leitner@gmail.com, junvyyang@tencent.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 1:45=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] The patch rewrites the wildcard DEL-IP (0.0.0.0) branch of
>   sctp_process_asconf_param() (net/sctp/sm_make_chunk.c:3153-3159) to=E2=
=80=A6
>
> Pre-existing issues:
> - [Low] The wildcard SET_PRIMARY branch of sctp_process_asconf_param()
>   (net/sctp/sm_make_chunk.c:3182) takes the packet source address from=E2=
=80=A6
>
> --
>
> sctp: fix ASCONF address change on single-homed hosts
>
> This patch drops the refusal of a plain DEL-IP of asconf->transport that
> commit 9b2854f86f0b added, so the RFC 5061 5.3.2 single-homed address
> change works again. The wildcard DEL-IP branch now looks up the
> transport of the packet source instead of reusing asconf->transport. The
> plain DEL-IP branch now clears asconf->transport when it removes that
> peer.
>
> > diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> > index ddc31a5dbad32..2b76e451d5cb0 100644
> > --- a/net/sctp/sm_make_chunk.c
> > +++ b/net/sctp/sm_make_chunk.c
> > @@ -3151,9 +3151,11 @@ static __be16 sctp_process_asconf_param(struct s=
ctp_association *asoc,
> >                * packet MUST be deleted.
> >                */
> >               if (af->is_any(&addr)) {
> > -                     sctp_assoc_set_primary(asoc, asconf->transport);
> > -                     sctp_assoc_del_nonprimary_peers(asoc,
> > -                                                     asconf->transport=
);
> > +                     peer =3D sctp_assoc_lookup_paddr(asoc, &asconf->s=
ource);
> > +                     if (!peer)
> > +                             return SCTP_ERROR_REQ_REFUSED;
> > +                     sctp_assoc_set_primary(asoc, peer);
> > +                     sctp_assoc_del_nonprimary_peers(asoc, peer);
> >                       return SCTP_ERROR_NO_ERROR;
> >               }
>
> [Severity: Critical]
>
> Can this leave asconf->transport pointing at a freed transport?
>
> Suppose __sctp_rcv_asconf_lookup() found the association through the
> ASCONF Address Parameter L. Then asconf->transport is T(L), while
> asconf->source is the packet source S. Take a packet from a new source S
> like this:
>
>   [AUTH][ASCONF: AddrParam L, ADD-IP S (or ADD-IP 0.0.0.0), DEL-IP 0.0.0.=
0][DATA]
>
> ADD-IP S creates T(S). The wildcard DEL-IP then keeps T(S) and removes
> everything else, including T(L):
>
> sctp_assoc_del_nonprimary_peers(asoc, T(S))
>   sctp_assoc_rm_peer(asoc, T(L))
>     sctp_transport_free(T(L))
>
> Nothing in this branch clears or retargets asconf->transport. Only the
> plain DEL-IP branch below does that.
>
> sctp_inq_pop() reuses the same chunk struct for the bundled DATA chunk.
> sctp_assoc_bh_rcv() then runs:
>
>         if (sctp_chunk_is_data(chunk))
>                 asoc->peer.last_data_from =3D chunk->transport;
>
> This stores the removed T(L). The last_data_from fixup in
> sctp_assoc_rm_peer() has already run, so it does not catch this.
> sctp_rcv() then drops its lookup reference, and T(L) is freed after the
> RCU grace period.
>
> When the delayed SACK timer fires:
>
> sctp_gen_sack()
>   trans =3D asoc->peer.last_data_from
>   sctp_make_sack()
>     retval->transport =3D asoc->peer.last_data_from;
>   ...
>   sctp_outq_select_transport()
>     reads new_transport->state
>     list_add_tail(&ctx->transport->send_ready, &ctx->transport_list)
>
> Is that a use-after-free read and write of the transport?
>
> Before this patch, the wildcard branch always kept asconf->transport, and
> 9b2854f86f0b refused a plain DEL-IP of it. So asconf->transport could not
> be freed during ASCONF processing.
>
> Any peer of an association with ASCONF enabled appears able to reach
> this, including a well-behaved peer following the RFC 5061 wildcard
> procedure.
>
> Would it close this to set asconf->transport =3D peer after
> sctp_assoc_del_nonprimary_peers(), or to clear it whenever it is not the
> surviving transport?
>
This looks like a legit issue. Either way above works for me.

Thanks.

> > @@ -3166,13 +3168,9 @@ static __be16 sctp_process_asconf_param(struct s=
ctp_association *asoc,
> >               if (!peer)
> >                       return SCTP_ERROR_DNS_FAILED;
> >
> > -             /* Don't free asconf->transport; a later wildcard DEL-IP
> > -              * parameter reuses it.
> > -              */
> > -             if (peer =3D=3D asconf->transport)
> > -                     return SCTP_ERROR_REQ_REFUSED;
> > -
> >               sctp_assoc_rm_peer(asoc, peer);
> > +             if (asconf->transport =3D=3D peer)
> > +                     asconf->transport =3D NULL;
> >               break;
> >       case SCTP_PARAM_SET_PRIMARY:
> >               /* ADDIP Section 4.2.4
>
> [Severity: Low]
>
> This is a pre-existing issue and was not introduced by this patch. The
> wildcard SET_PRIMARY handling in sctp_process_asconf_param() uses
> sctp_source() instead of &asconf->source:
>
>         if (af->is_any(&addr))
>                 memcpy(&addr, sctp_source(asconf), sizeof(addr));
>
> sctp_source() returns &chunk->transport->ipaddr whenever chunk->transport
> is set. When the association was located via the Address Parameter
> (transport T(L), source S), SET_PRIMARY 0.0.0.0 makes L primary instead
> of the packet source S. That doesn't match the comment. The ADD-IP and
> DEL-IP wildcard branches both use &asconf->source.
>
> With this patch the result also depends on parameter order:
>
> - After a plain DEL-IP L clears asconf->transport, sctp_source() returns
>   S.
> - After a wildcard DEL-IP, it returns the ipaddr of the removed T(L), the
>   dangling pointer described above. The lookup then fails and the
>   parameter gets SCTP_ERROR_DNS_FAILED.
>
> Should this branch use &asconf->source like the other two?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261022163639.2566945-1-andrey.misyrov%40gmail.com
