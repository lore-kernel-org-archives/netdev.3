Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A34437451
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249716; cv=pass; b=Rjbz6aE4wREGdbLfPbw4ftmzHyzfepN0tDYYK8XpY6Es4FlS9TH2GsllrNpAwxd73s8dhsfJJyjtg9qBLdqtIWVnSB5NrGLW+9Cn3/kPxKVayImFtRke5zaY5f5MQeHAeEsY4JxX7Xgb75WQDQsBITO9/y8QJGUUgW53bSxZKpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249716; c=relaxed/simple;
	bh=4awJtKKDvPw2gOyvaadrQ+P4QGynoRlmFCCWKym08cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcQ/VJbxcC2OWXpWLx+1MF604WJE7YmZb/Z75vO4t2UbyPkCjEI4NVO6H15N/OBUHHj8vbrW+U6rpD4sUHet7qITjQY8VQEeSPRC0euh5oC68xBAeFOOH1IqY8WHp6ujnMl/EHHR+y8YG388cNUdSVpsOEWMTLk0EtWRCIoqOJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gOZXBG3N; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gOZXBG3N"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86212a185dcso1408088b3a.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 04:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790249709; cv=none;
        d=google.com; s=arc-20260327;
        b=aHX37Rrt8WABhJjiWVY1d0vYAzwrHElf+mCrzQgxZp9HtxZ6QfSwfpD2l+46IiCCeV
         wGxboLmzCN7ooMRfC5rO/tsc29IysgQeDm1LEzIwwbOOGuu/kXoQXWXNgmARtffNBxlF
         fbWP3Ef6Qt0Yn3nhA8qX9oSxFIvjZ9ctw/k+A9O1j2uMsKTwqoyHwWikynEfvaWFncm2
         zc3OWvheYcAwaJ1eZADxF8gwyhn+9JgwS4g0coEM4hoU6Vi88jTmGH0X5+kodtnJGgD9
         CKnGTQijZBaDTApybtrYnMloj/0lLPr8t5eytqYvZwhPYn0HQviTUO8Vz+6VmoWyNPpq
         W+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mDZnrGdEXceSo8wKMQm6VdoJFC1vELp0xmTxaa3Jb98=;
        fh=72luQlzIO770HWM5Naq1rkU58knqb2+sE8Z9AokkTzY=;
        b=OJALT2pDiaRlh5Z1jx1aeDTDxmqGo9xfpVS5tOwka+Pbhvaxz0PxQ3iccPMLem4faz
         7FQYMfrpyBT4Kpw78sjNuEewsRn+V5DQTewtYKWiD8hIgeEBeh4B80aQyauNWylMRR4J
         dz1pI1BqeddwFjg+LwPf4IMUAI1aB6L3pPCQhZKwS49Jv5D7a9/44kWerX8R0z3Gz6Xz
         cccTIbxiagHCgX4SWBxIvfUybIDLVa93cLWJcmxQk3qgTSs0QCG3q2W5qK0ZMhVQQtUb
         xDzwOglijQ2eEyeSb0uXVUma8/MDz/TMJPgWuuGd7f+7dLVP1caDnVWJWcBJW2OFrJIn
         bqww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790249709; x=1790854509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mDZnrGdEXceSo8wKMQm6VdoJFC1vELp0xmTxaa3Jb98=;
        b=gOZXBG3NZqteJ58Mrt9FzAXS9mrCoUoMizjU99e18+P26N2nfHThiL2jenPCkkUD8z
         fL2HMDg+jBAQ+ko9ZrmUk7IWd7FaHse10kYpPBAQH7g1J7NE+vKu7aIpKwRVMftiAFHM
         MbNotHhkW1QFEC1t1t8g+VUZax0kPE2BOeA4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249709; x=1790854509;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDZnrGdEXceSo8wKMQm6VdoJFC1vELp0xmTxaa3Jb98=;
        b=rH0XOsF9auQAEHNd+UehhpWscPkxu8izWf5iNHy1PCHu4Ey/IqNztiUFWBF/YvFcNo
         2nS5hVyunsIncWeQeNWGBNbTiW1QtPQ9NKiTsJVXNoQSh1yUsCLJZSaJWF9atnDamnTt
         Sf1vmvxGlg24FIdpNCvjvlphk5CVJEiRVoak9f1TGOVlI8FqQgGQXpzx+c+SrPnOLuwm
         4uiUhc1GaC2Snb5Ww7LJy6eVaqj+Znu3wxPlXQnUHbA9Yy8GyTC2VX2XpT4HLpoxmxnU
         qndLYsq3hArycmumn22NWGF8VQF00/BfG2JHd8sEDllvPD6x5y9VPO+a3JyIPQiRcrdF
         ckxw==
X-Gm-Message-State: AFuF++n8OlJr1VbBTrPneughMaRcY2nj6Fdfs0ihUSf9hfeRq9fAcPBo
	u5vQ4/6J1b3Cvn7mlMAGpduKq+DHFKN+x/qHPsMaXzFYDl6LtY4oRohTiIFT+q8cCqmp5KKy+/X
	O4seSE8kk2FCDgXzHExPNort2JPauPVTlwz9Mi8lC
X-Gm-Gg: AYBFou21QhWX1HQUfsp+BNYNszk1mOyO+ZilALH6udsk7XLvKUOT7Va002zZNrCne8L
	W9fy8AlTIr8qWUpRwTt3NB3yLgeFFtGlpvPQ32Zm1wzpEy5T7OvUDKtk0wWawnpEPv/kL+JcDZn
	a7ZPgi1QXL75pjKrzeKkLAOrEPAYhQRMRKt47rStkYqZZBEHRL5bR5tg+EIKfxVGScyhFxxwdtv
	oAGvSQ/OOqG3s5wBTL7EAny2amnhb5/eyZOep/JM82UP0FY15Y/OMfRYXny1xdFSEZxfFSAKT4P
	2Djj0EsMijRZfBAU2PN3pB0KRRzSFB3K/XCIpgVM/lTwzIjIScwZ3fFjrNCmVr6Cr77PGoZvmfu
	ev4RmPgGGGVHIevVrkWTXH8m7/xTKDuBdRA==
X-Received: by 2002:a05:6a00:f04:b0:857:726d:2707 with SMTP id
 d2e1a72fcca58-87e9cb21961mr1973182b3a.19.1790249708663; Thu, 24 Sep 2026
 04:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-4CSL.v1.20260917072652@mojatatu.com> <179003833955.2160803.1077681716391858800@kernel.org>
In-Reply-To: <179003833955.2160803.1077681716391858800@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Sep 2026 07:34:57 -0400
X-Gm-Features: AclHuK_6hO2d1IslsqohBLTvdJzUbB13oddooNwCQPyP57DT_TBbN_ZSJdVy95o
Message-ID: <CAM0EoM=t8g27Z4ouLYUjWGSHvERNJk8rNkm3MXyk8Og9BMaxpg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_flower: exact-match ERSPAN key when no
 mask supplied
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	lucien.xin@gmail.com, stable@vger.kernel.org, sashiko-bot@kernel.org, 
	victor@mojatatu.com, hybris@mojatatu.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 8:52=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0 (2)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] Undisclosed behaviour change on the *with-mask* ERSPAN parse
>   path.
> - [Medium] The patch threads the key's ERSPAN version into the mask parse
>   as a *default* only and never validates it, so a mask nest may still=E2=
=80=A6
>
> Pre-existing issues:
> - [Low] The selftest match_erspan_opts_test() in
>   tools/testing/selftests/net/forwarding/tc_flower.sh (lines 679-726)=E2=
=80=A6
> - [Low] The flower ERSPAN index attribute is consumed as big-endian but
>   declared as a host-endian u32 in both of its declarations.
>

pw-bot: cr

cheers,
jamal
> --
>
> net/sched: cls_flower: exact-match ERSPAN key when no mask supplied
>
> This patch makes fl_set_erspan_opt() fill in per-version exact-match mask
> defaults when userspace supplies TCA_FLOWER_KEY_ENC_OPTS without
> TCA_FLOWER_KEY_ENC_OPTS_MASK, instead of leaving the mask blob zeroed.
> To do so it threads the key blob's ERSPAN version into the mask parse pas=
s
> via a new key_ver argument.
>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026082602512=
3.62758-1-ljp1205831794@gmail.com
> Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp1205831794=
@gmail.com/
>
> A few questions below.
>
> > diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> > index 1cefea571efd..f5acdeb0e2a6 100644
> > --- a/net/sched/cls_flower.c
> > +++ b/net/sched/cls_flower.c
> > @@ -1358,17 +1358,29 @@ static int fl_set_vxlan_opt(const struct nlattr=
 *nla, struct fl_flow_key *key,
> >
> >  static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_=
key *key,
> >                            int depth, int option_len,
> > -                          struct netlink_ext_ack *extack)
> > +                          struct netlink_ext_ack *extack, u8 key_ver)
> >  {
> >       struct nlattr *tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX + 1];
> >       struct erspan_metadata *md;
> >       int err;
> >
> >       md =3D (struct erspan_metadata *)&key->enc_opts.data[key->enc_opt=
s.len];
> > -     md->version =3D 1;
> > +     md->version =3D key_ver;
>
> [Severity: Medium]
> Is the with-mask path also meant to change here?  The assignment sits
> above the if (!depth) block, so it runs on the mask pass too, not only
> on the no-mask path the changelog and the new comment describe.
>
> On the mask pass option_len is the non-zero value returned by the key
> pass (sizeof(struct erspan_metadata)), so in fl_set_erspan_opt() this
> guard never fires:
>
>         if (!option_len && !tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER]) {
>                 NL_SET_ERR_MSG(extack, "Missing tunnel key erspan option =
ver");
>                 return -EINVAL;
>         }
>
> A mask nest that omits TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER is therefore
> accepted.  Before this patch such a mask always defaulted to version 1
> and took the v1 branch (index bytes memset to 0xff, dir/hwid left
> wildcarded, mask blob version 1).  With a v2 key it now defaults to 2
> and takes the v2 branch instead (md2.dir =3D 1, set_hwid(0xff), index
> bytes left at 0).
>
> That changes which packets match, what fl_dump_key_erspan_opt() emits
> for TCA_FLOWER_KEY_ENC_OPTS_MASK (it selects the union member from the
> mask blob's own md->version), and the mask handed to hardware offload,
> for requests that installed fine before.
>
> Would it make sense to restrict the new default to the !depth path, or
> alternatively to describe this second affected path in the changelog and
> move the comment so its scope matches the code?
>
> > -     if (!depth)
> > +     if (!depth) {
> > +             /* No mask attribute supplied: exact-match every field th=
e
> > +              * key set, keyed off the key's own version so the v2 dir=
/hwid
> > +              * bytes are masked without touching the overlapping
> > +              * timestamp/sgt bytes of the union (see 292207809486).
> > +              */
> > +             if (md->version =3D=3D 1) {
> > +                     memset(&md->u.index, 0xff, sizeof(md->u.index));
> > +             } else if (md->version =3D=3D 2) {
> > +                     md->u.md2.dir =3D 1;
> > +                     set_hwid(&md->u.md2, 0xff);
> > +             }
> >               return sizeof(*md);
> > +     }
> >
> >       if (nla_type(nla) !=3D TCA_FLOWER_KEY_ENC_OPTS_ERSPAN) {
> >               NL_SET_ERR_MSG(extack, "Non-erspan option type for mask")=
;
>
> [ ... ]
>
> > @@ -1607,9 +1620,11 @@ static int fl_set_enc_opt(struct nlattr **tb, st=
ruct fl_flow_key *key,
> >                       key->enc_opts.dst_opt_type =3D IP_TUNNEL_ERSPAN_O=
PT_BIT;
> >                       option_len =3D fl_set_erspan_opt(nla_opt_key, key=
,
> >                                                      key_depth, option_=
len,
> > -                                                    extack);
> > +                                                    extack, 1);
> >                       if (option_len < 0)
> >                               return option_len;
> > +                     key_ver =3D ((struct erspan_metadata *)
> > +                               &key->enc_opts.data[key->enc_opts.len])=
->version;
> >
> >                       key->enc_opts.len +=3D option_len;
> >                       /* At the same time we need to parse through the =
mask
> > @@ -1618,7 +1633,7 @@ static int fl_set_enc_opt(struct nlattr **tb, str=
uct fl_flow_key *key,
> >                       mask->enc_opts.dst_opt_type =3D IP_TUNNEL_ERSPAN_=
OPT_BIT;
> >                       option_len =3D fl_set_erspan_opt(nla_opt_msk, mas=
k,
> >                                                      msk_depth, option_=
len,
> > -                                                    extack);
> > +                                                    extack, key_ver);
> >                       if (option_len < 0)
> >                               return option_len;
>
> [Severity: Medium]
> Now that key_ver is available at the call site, should a mask nest that
> declares a different version than the key be rejected?
>
> key_ver only supplies the default; a few lines further down in
> fl_set_erspan_opt() it is overwritten with no comparison against the
> key's version:
>
>         if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER])
>                 md->version =3D nla_get_u8(tb[TCA_FLOWER_KEY_ENC_OPT_ERSP=
AN_VER]);
>
> The only cross-check in fl_set_enc_opt() is the length one, and both
> version branches return sizeof(*md):
>
>         mask->enc_opts.len +=3D option_len;
>         if (key->enc_opts.len !=3D mask->enc_opts.len) {
>
> So key nest {VER=3D1, INDEX=3D0x64} with mask nest {VER=3D2} is accepted.=
  On
> the mask pass option_len is non-zero, so the "Missing tunnel key erspan
> option dir or hwid" guard is skipped, and the v2 branch writes only
> md2.dir and the hwid bitfields, leaving the union bytes holding the
> key's index at 0.  cls_flower compares (packet_key & mask) against
> (filter_key & mask), so doesn't that filter then match every ERSPAN
> packet regardless of index, which is the wildcard behaviour this patch
> sets out to remove?
>
> The mirror case, key VER=3D2 with dir/hwid plus mask VER=3D1, memsets the
> union bytes that alias md2.timestamp to 0xff while dir/hwid stay
> wildcarded, so the filter would never match packets carrying a non-zero
> ERSPAN timestamp.
>
> The pair is also not round-trippable, since fl_dump_key_erspan_opt()
> picks the union member from each blob's own md->version: the key dumps
> as VER=3D1 plus INDEX while the mask dumps as VER=3D2 plus DIR/HWID.
>
> Two remaining observations that are not about this diff:
>
> [Severity: Low]
> This isn't a bug introduced by this patch, but match_erspan_opts_test()
> in tools/testing/selftests/net/forwarding/tc_flower.sh does not appear
> to verify that the ERSPAN option values take part in matching, so it
> passes with or without the wildcard mask this patch fixes.
>
> The Type II filter (handle 101) is installed with enc_key_id 1001 plus
> erspan_opts 1:6789:0:0, and the Type III filter (handle 102) with
> enc_key_id 1002 plus erspan_opts 2:0:1:63.  The distinct tunnel key IDs
> already select the respective filter, and only one matching packet is
> sent through each tunnel:
>
>         $MZ erspan1 -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q
>         tc_check_packets "dev ep-ex ingress" 101 1
>         check_err $? "ERSPAN Type II"
>
> Both assertions still hold when the ERSPAN index/dir/hwid mask bytes are
> zero.  Could a negative packet with the same enc_key_id but different
> ERSPAN metadata be added, so the new no-mask defaults in
> fl_set_erspan_opt() are covered?
>
> [Severity: Low]
> This is a pre-existing issue, but the ERSPAN index attribute is
> consumed as big-endian while both of its declarations call it a
> host-endian u32.
>
> include/uapi/linux/pkt_cls.h documents
> TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX as be32,
> fl_set_erspan_opt() reads it with nla_get_be32() into the __be32 union
> member and fl_dump_key_erspan_opt() emits it with nla_put_be32().  But
> erspan_opt_policy has:
>
>         [TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX]      =3D { .type =3D NLA_U3=
2 },
>
> and the flower-key-enc-opt-erspan-attrs entry in
> Documentation/netlink/specs/tc.yaml has:
>
>       -
>         name: index
>         type: u32
>
> with no byte-order: big-endian.  Should the policy use NLA_BE32 and the
> spec entry declare big-endian byte order so both match the ABI?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-4CSL.v1.20260917072652%40mojatatu.com
