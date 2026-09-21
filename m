Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6D4EB848
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013502; cv=pass; b=BcCOHD2ypPo0s3hxkv2Qf56nQZZ2NbZr48Q8bVwRUMeNTZ2oBWm9baSc55ki18mN0AIxhuqjEWerGNRg6UuGD4kpNh0MQVpc7mDsVBrMcN+hfiMX1yyA1ENtO1whhevtQc54sZobl2xRhkh0dGlenqMCtyCxDmqQ77v3O4bIPpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013502; c=relaxed/simple;
	bh=XVIYV9FVnMFewydRoY4sZQFy/bO7vE60jVchHBCjxBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SikM4bPaFIaK1PInAs4kM/98o6sYFlC9ulDYFMjWhjasvQ4e0pPzdD+/1i/qpzZjoBXBUyNOC2t9vbnVCdaw5a5WhqKcM0vDoxbNlnRndMS163znxWm3VrJskqKrhbaeLgS2uDwJ9LUCk3JIPjTNVi1zVCs41Ej2ABmWaNh128s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=dTc3kkeP; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="dTc3kkeP"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-868cfc5c244so1741067b3a.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790013499; cv=none;
        d=google.com; s=arc-20260327;
        b=syQStfkWwCPh6Ddeo589XEye/uX6b8ElS8s7CDMcl5per6UAU1vTeb9e+X9JAp579F
         Vd0Tk2gSs1EN5UDTl9k0rkQ0gqm+Qo+qrWsvnKRCKXXozd8GWKbspSEFgntA26OSW7K/
         ybSjByHqzhuLxIxr/+UZec/b1bMXWEbhda9KAYG/qZyxAGT3mVP9qkfyRWIp9WDy49fZ
         lSKRWO1w0yDMxgLigcMLczV9Yp2w3+CmEDcjxOgkVAUw7KOpVB1T6y4QlRxgRdtVf6fS
         JS/8Ak1+3BeIfPy/q5k0su1Gr1g2HlXwyNzHm+DBSFXgUPuzI0bxAtoL9ucvH8+Bxe37
         b0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFClP2GWIVn7JBUWb2z+jSETSVb0ynsKzTcWUBX9Qes=;
        fh=SJqlvzogZtXwhxiz1L3TETzTkvaPVAiAy6Dcd9MJ3CU=;
        b=cxY3+smjlB1oruvYQRbIlim/z/u2YMoYlS3kFq3vUHyklPHRW1ZijcKvUadn8MB33p
         6hbJ2f2v4zcNJEnO04hafG4oKvQEf7i/TqoH3iEppSzThYShTgYoGp3L9dwCgn9RPxM4
         +6JV18qanrqEo4wl1EqEaIrSdqUHiKeP0s/V8f2xtZ2Kj52Ib2LOHbhC4id/HRSWTq/K
         dzWnvBAhSiFLsqip/a4sbiL3wLCADDYyCPSEjylWFWgAoh9UbQhBF1naiRYcSUqCCCzc
         r8vy87qdN6bJyxwoVyWIbZ+ehmkyQBfFMxKGK1u5pZDcw2Oz9Ae+EYcKCqEEa8gSei3/
         Iglg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790013499; x=1790618299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFClP2GWIVn7JBUWb2z+jSETSVb0ynsKzTcWUBX9Qes=;
        b=dTc3kkePc238S9WB+7dCv4pIamb/iA6uGrUIsLfMaFkLq23RMaAayNFmG/OUSaQtlp
         QPw0bZNs2v43AKhxsU6UegHpe2dkLU4V3F9znzbC0M9VMsNJF3kmKhW5y4MTsMCBCUW+
         LVoEECU4XO6GsWmDT+N19VswebrRNahQQ2i38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790013499; x=1790618299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFClP2GWIVn7JBUWb2z+jSETSVb0ynsKzTcWUBX9Qes=;
        b=164/nTLvmGnl85NVsljihFNtySNZSDiYGj0tnnv6W/yU7arlyU732e6pyXSa1P5DCZ
         8NsZlCyiZKXgLZFvCuqkySej+Cb7hlCo1oDdmG/+HcEcoxqNlUbxRIlI3WwtOlIRSrMY
         seZxpXWAGZhSjoVo0wEI4eWfmebCIVHPrPHvtBomPwDfBotOkJ0AJX9Ub7L0fnTc5cQl
         MJZ0XoEMbDixvzKDYn99rncToXGhlBH90pWbgrtp6QYMoDyooG+TKOmm1bt9Ijr5Fva3
         6nCOv5D7sJrMFKOEZOhZB7ACaZJCAJ8Mxq8EANQtvGDe0UqOivcAvr5FEqGNJYGPdemU
         4qqQ==
X-Gm-Message-State: AFuF++kmbbF79vbrQJt9TEBK88X8XxB6D5sAcwzpQlIymrQKUtdH/y1K
	NylcY2zPxL/Kt3YdU7UfjGOpxBA0+pVthT+DC4r+URSMOKP+wQNIYHVGwTAK/Hr0IcGTKtgQCq0
	5Y57+0XDzXR8sxQRfNDyVjEx0aJn2SZ1oJRW9LNqv
X-Gm-Gg: AYBFou145lPfamWQrOCZ0QwAg26FyfLVJrIGHP4aDtuc0zT8dlQeY2531Y/DRl4XseY
	6IZFuWJofWqtJDoptsElxhwfwaeGtt9CzuxPtVpPJdSxb1OLT5T8pLvevA2g5k7Q/wxs3Z1rXDm
	3qD8mcov1jXZYDD/LlafZqNQp9fNzI0G4IutARU5upob5HICYPugio4l3ZP38l33yvOLzfRdZV2
	k8c8DcwuJLtnLn5VanJD7hNwONge4BomUF8RdiYhloDTRj6z0LJwpdwGr7j5mU6q6TzS0NeKy36
	lVSGKkyKlTo8L3J+rLDC/noe7vt/+bL12dZMK/BatuShAmEx4pZNiewYfVkNcit9GwcqalVaHJm
	25rFfhR+ZNDrms2IDLFWt8OnymyT4cQpEOjLNN7CndrOaclvZ
X-Received: by 2002:a05:6a00:1ca9:b0:874:705d:f640 with SMTP id
 d2e1a72fcca58-874de20a543mr13521909b3a.34.1790013498828; Mon, 21 Sep 2026
 10:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-4CSL.v1.20260917072652@mojatatu.com> <CADvbK_e0-1JsCSMAQXGP3yxrvmtJDvG3TBShft=EfLKEGkBR=A@mail.gmail.com>
In-Reply-To: <CADvbK_e0-1JsCSMAQXGP3yxrvmtJDvG3TBShft=EfLKEGkBR=A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 21 Sep 2026 13:58:07 -0400
X-Gm-Features: AcwNN1VBdmzBlwDPWlbZg6XBeCj-MYlPDpLBOwS6X5iUNuIDd4zwM1zc1uZ0OBE
Message-ID: <CAM0EoM=u3XqrGTxyTxCbbh4fobfPv+ZFKh1LESbjgsoPh4g0rw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_flower: exact-match ERSPAN key when no
 mask supplied
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 9:11=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Sat, Sep 19, 2026 at 5:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > Commit 292207809486 ("net: sched: fix erspan_opt settings in cls_flower=
")
> > removed the unconditional memset of the erspan_metadata mask in
> > fl_set_erspan_opt(). On the mask-parse pass, when userspace supplies th=
e
> > encap option key but no mask (TCA_FLOWER_KEY_ENC_OPTS without
> > TCA_FLOWER_KEY_ENC_OPTS_MASK), the !depth early return leaves the mask
> > zeroed -- a wildcard. A filter keyed on an ERSPAN index (v1), or dir/hw=
id
> > (v2), then matches every ERSPAN packet's values instead of exact-matchi=
ng.
> >
> > Mirror the with-mask per-version defaults on the no-mask path, keyed of=
f
> > the key's own version: v1 index to 0xff, v2 dir and hwid to their
> > exact-match masks. The mask cannot just memset the whole union -- that
> > would re-mask the overlapping timestamp/sgt bytes of the v2 header that
> > the fix (292207809486) deliberately left to 0 in erspan_opt.
> >
> > This is a follow-up to commit fee10655709c ("net/sched: cls_flower:
> > validate mask pointer after nla_next()").
> >
> > Conditions to recreate the bug: add an ERSPAN encap-opts flower filter
> > with a key but no mask (raw netlink, TCA_FLOWER_KEY_ENC_OPTS present,
> > TCA_FLOWER_KEY_ENC_OPTS_MASK absent); dump the filter and observe the
> > match mask is zero (wildcard) instead of exact for the supplied fields.
> >
> > Fixes: 292207809486 ("net: sched: fix erspan_opt settings in cls_flower=
")
> > Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826025=
123.62758-1-ljp1205831794@gmail.com
> > Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp12058317=
94@gmail.com/
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Tested-by: hybris <hybris@mojatatu.ai>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/cls_flower.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> > index 1cefea571efd..f5acdeb0e2a6 100644
> > --- a/net/sched/cls_flower.c
> > +++ b/net/sched/cls_flower.c
> > @@ -1358,17 +1358,29 @@ static int fl_set_vxlan_opt(const struct nlattr=
 *nla, struct fl_flow_key *key,
> >
> >  static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_=
key *key,
> >                              int depth, int option_len,
> > -                            struct netlink_ext_ack *extack)
> > +                            struct netlink_ext_ack *extack, u8 key_ver=
)
> >  {
> >         struct nlattr *tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX + 1];
> >         struct erspan_metadata *md;
> >         int err;
> >
> >         md =3D (struct erspan_metadata *)&key->enc_opts.data[key->enc_o=
pts.len];
> > -       md->version =3D 1;
> > +       md->version =3D key_ver;
> >
> > -       if (!depth)
> > +       if (!depth) {
> > +               /* No mask attribute supplied: exact-match every field =
the
> > +                * key set, keyed off the key's own version so the v2 d=
ir/hwid
> > +                * bytes are masked without touching the overlapping
> > +                * timestamp/sgt bytes of the union (see 292207809486).
> > +                */
> > +               if (md->version =3D=3D 1) {
> > +                       memset(&md->u.index, 0xff, sizeof(md->u.index))=
;
> > +               } else if (md->version =3D=3D 2) {
> > +                       md->u.md2.dir =3D 1;
> > +                       set_hwid(&md->u.md2, 0xff);
> > +               }
> >                 return sizeof(*md);
> > +       }
> >
> >         if (nla_type(nla) !=3D TCA_FLOWER_KEY_ENC_OPTS_ERSPAN) {
> >                 NL_SET_ERR_MSG(extack, "Non-erspan option type for mask=
");
> > @@ -1509,6 +1521,7 @@ static int fl_set_enc_opt(struct nlattr **tb, str=
uct fl_flow_key *key,
> >  {
> >         const struct nlattr *nla_enc_key, *nla_opt_key, *nla_opt_msk =
=3D NULL;
> >         int err, option_len, key_depth, msk_depth =3D 0;
> > +       u8 key_ver =3D 1;
> >
> >         err =3D nla_validate_nested_deprecated(tb[TCA_FLOWER_KEY_ENC_OP=
TS],
> >                                              TCA_FLOWER_KEY_ENC_OPTS_MA=
X,
> > @@ -1607,9 +1620,11 @@ static int fl_set_enc_opt(struct nlattr **tb, st=
ruct fl_flow_key *key,
> >                         key->enc_opts.dst_opt_type =3D IP_TUNNEL_ERSPAN=
_OPT_BIT;
> >                         option_len =3D fl_set_erspan_opt(nla_opt_key, k=
ey,
> >                                                        key_depth, optio=
n_len,
> > -                                                      extack);
> > +                                                      extack, 1);
> >                         if (option_len < 0)
> >                                 return option_len;
> > +                       key_ver =3D ((struct erspan_metadata *)
> > +                                 &key->enc_opts.data[key->enc_opts.len=
])->version;
> Do you think it would be better to pass &key_ver to fl_set_erspan_opt() a=
nd
> set it there, avoiding the dereference of erspan_metadata here?
>

Sure - that will avoid some casting.
I could change it if i have to resend. Let's wait to hear from
sashiko-nipa. I have gotten sashiko-gemini feedback but it was spewing
some new (meaningless) stuff about things it was claiming then
dismissing ;-> So nothing useful there.

cheers,
jamal

> Thanks.
>
> >
> >                         key->enc_opts.len +=3D option_len;
> >                         /* At the same time we need to parse through th=
e mask
> > @@ -1618,7 +1633,7 @@ static int fl_set_enc_opt(struct nlattr **tb, str=
uct fl_flow_key *key,
> >                         mask->enc_opts.dst_opt_type =3D IP_TUNNEL_ERSPA=
N_OPT_BIT;
> >                         option_len =3D fl_set_erspan_opt(nla_opt_msk, m=
ask,
> >                                                        msk_depth, optio=
n_len,
> > -                                                      extack);
> > +                                                      extack, key_ver)=
;
> >                         if (option_len < 0)
> >                                 return option_len;
> >
> > --
> > 2.43.0
> >
