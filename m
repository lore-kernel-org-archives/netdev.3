Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D8371885
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041519; cv=pass; b=hdcKhMe2lBexFADixHdw7/hOZpoAd29cJQmHGeEMsY+abJ0kyw2acfe6TtVPjZQqx/RHG8luRIb8IDa+6yKqlsMQPm07GjEqAhhafpfZln1lmhxHSBMZXcjfpnSZ7V5yO08U+jaF+VBEdEwBgqRXycMh7lyfsX0Wd6t3EfFXC48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041519; c=relaxed/simple;
	bh=QS8nUk2MQLUFkRJi6/rRGSU1OrivXfXKT078jkhl5co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmOzNZOfg6WsD+j431uv8GU+QTqpUbLlsDnWNjsYBa3V1lP3lBOiDUbp4NyD48Bfko+8c3on7MBWpX0DQ2SuBaFh2QDmO0QWNCMnaGVrOt4QclgSU1p4ZunBLBg/1K7tQmaytJNVyS4BtiG3KEzApIetz3U7fpk/NTIePM8uiL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OFF/lH54; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="OFF/lH54"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3119684b3a.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 11:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786041512; cv=none;
        d=google.com; s=arc-20260327;
        b=abQgrej4jftlcXvhogstX0MQmWM0LqfLp8upIKezgVxZxYFG3PE0VUKxP2xL+pCu27
         HMAt+XuhK7pt6wusxTrUQ9lXFYAfi/TrSgYXdQiMhiTaap372eGf3XbH08cQgA4wxmWE
         j11kY4lCZQkOHkz8pO5nuTflmBXDxvRCue5c94WQOY2ik1HEm/fjyTyXTAuop68R5QLi
         e4736b7vyHCW9EC4l4kwEhPM+Xta99CAbi2mDxJFcG46KCITQaGyCW9KUp4nAfDbjgRi
         ChXJXB9jLSUDTEAu3EVB0KSz6h8PVTzxo/rQ8p5GNIhPOfn4yBYa+UbKQE/hM3m/gqQ3
         DkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UzzSQ42c6CqUCkgPR4M9ccrX37Kn1FAe7+/9Junovp0=;
        fh=S3sKelmZIMuGFSOf6P2YTYYCxDbvTIozFUiqgjLipVc=;
        b=RdAQMzI9B8a576nosT9f756tD2WmOy7HympwKMVN9RCkUcutUG8h6drEgl1PRXc8Ol
         uXqHCWUm93SBqxdGG4MQo2GYNrH4tm2KGvXgjuLJdjQWJBKhar+NtEXU6AH15rLeuLOe
         vY7iiKnZ7BA0ilzPoem/fhxT604PpzgmyQl1YsbvSx6dd4XPsI3X3pTWsUU20PiTY3lx
         p3OWBeeMq4diivxD2X73Nz1RD4rloek2A0nNIsnlN//sGOXiOC69mwV0xbBxl1dIbwnC
         h0GvkNGBUrF7b8zRIod/yodzQcVmqnSz+Cy6vOvXSg01Nu/dlohqSakb1ha6BIwTqQ/x
         pbKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786041512; x=1786646312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UzzSQ42c6CqUCkgPR4M9ccrX37Kn1FAe7+/9Junovp0=;
        b=OFF/lH54Dqglld7L3oT8dLouWySG2ob5FU3EErHVtg1Q6id1t41VF1DdKWMpLvUy2r
         Agi/cJUU5mjPaPS6I6pFHb1BLmP966w7y1KQ1pAiaTX52cuUd78psEktS9E0sYzTvJML
         08DvakAf0YFNwe/ULr9168ujMzS6HmBDaeZSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041512; x=1786646312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UzzSQ42c6CqUCkgPR4M9ccrX37Kn1FAe7+/9Junovp0=;
        b=i2Z+DJhmBt+g+paM3Pl6iTlbTzt5kTDLyyFvqc0g0Bnxwh2hVXyqEsbN1Oz9saKAJF
         BeIX+Ma1MNac6RHHr20pCdUaTob8X6E85GpsF8Cdi1JOmMOLT4TRMdl7tjxjahi+mMJo
         QOY8EluL6YpOz0O248CRczu+/KdZoYIlCT/XHKhq6K+zp/RY6NtaEnrFSL+tkDyX7cAp
         14ojz1tBK5zotX/az4XAXXOtt5WbvFziR2+Z2exUy7SmAW9Q+71g6mNrnYI00pFgOSnv
         CkR5Qq3Eac8YSzkb7Xv3683K1Sm0F/FOy4PNvCT76DXOD9bDoXCBUMCjKghMgfk0RIqx
         JX/g==
X-Forwarded-Encrypted: i=1; AHgh+Rp0Ygqc20w02C+oVb/WFOrtQComb31+h8hQHSgr+O+6oFNXshkH+BcgA5Xfkw7Yns+ZuGAvEj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1NgorwbJuWnUYP5VFqlB/3E/g29RY3OQTU4PBsBu59RItvdRN
	gWekmalg/phXWouQLxC/7s5e1O8vRql377xLoAaQhgjyUxli1T0ipN7zfb0FJVZy/lhNsb/4AX5
	AuCSa5GPNe1gZyzq+Q4gUMvwsfYrsPypGmQebD6Iyw4RGHWps/Ms=
X-Gm-Gg: AR+sD13JihwjxUzwVANbckKIjoJ3jxEm7nIlct0NLxFQAugOkwvK4ipJO6Q1abU4Iav
	h1P0o2QUa4cP4FvETSIAdBukTXKgl/HqLRRl/oQ+/z9wPdusC8/bLXt3RwQz+GXZVBMkknex2F+
	+ZfRwg42ILs/n6YI0/XHigGFtkpLsdDhWhBv2qcV90LNww4WF31YjnT4DDIptj78nJQ9KtFvVDU
	LNLB4itJYLJ3j2xLjYTwRPYNn+mGPK3Vxyz6UBKFsjXO3GrG1cTORG03JyrGopjJC0750c87gz1
	T+cexG6MQDKqmaCxWNMHQK+Fjvqh76MWikBeB2UiyWMLjFCNtN9t1RAb
X-Received: by 2002:a05:6a00:450b:b0:848:76af:db37 with SMTP id
 d2e1a72fcca58-84f2e0147e9mr19156359b3a.7.1786041512054; Thu, 06 Aug 2026
 11:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805093012.95155-1-henrymei@tencent.com> <CAM0EoMmZGXhHL2v=AyjR9xSs8-s9EfkA9FkpULqtFBEOUxHQQA@mail.gmail.com>
 <aabdf499-20ad-4667-b289-626c09a56c0a@gmail.com>
In-Reply-To: <aabdf499-20ad-4667-b289-626c09a56c0a@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 6 Aug 2026 14:38:19 -0400
X-Gm-Features: AUfX_mz_-gI0Cyrp0J2uVmWaq9VzcXirckg30k-UyZYmHUgTiUNFzySpc73NRsA
Message-ID: <CAM0EoMmM-7cphQGmfZa+H3p5HjQ71gJ=8J6-HhhRwzAv--74AA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: fix tp_created race losing
 existing tcf_proto
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	corvus@tencent.com, henrymei@tencent.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:28=E2=80=AFPM Aohan Mei <ljp1205831794@gmail.com>=
 wrote:
>
>
>
> =E5=9C=A8 2026/8/6 01:52, Jamal Hadi Salim =E5=86=99=E9=81=93:
> > On Wed, Aug 5, 2026 at 5:30=E2=80=AFAM Aohan Mei <ljp1205831794@gmail.c=
om> wrote:
> >>
> >> tc_new_tfilter() attaches a filter to a chain. When no
> >> tcf_proto (tp) exists for the given (protocol, prio), it creates one
> >> with tcf_proto_create(), marks tp_created so the error path can clean
> >> it up, and inserts it with tcf_chain_tp_insert_unique().
> >>
> >> However, tcf_proto_create() can sleep, opening a race window in which =
a
> >> concurrent thread may insert a tp with the same (protocol, prio). In
> >> that case tcf_chain_tp_insert_unique() destroys tp_new and returns the
> >> *existing* tp, but tp_created is never reset. If the request then fail=
s
> >> (e.g. kind mismatch), the errout path calls
> >> tcf_chain_tp_delete_empty() on a tp this thread never created. For
> >> classifiers without a delete_empty callback (all but cls_flower),
> >> tcf_proto_check_delete() removes the tp unconditionally: a live tp and
> >> all its filters are silently lost while the owner's change() still
> >> reports success. The race is reachable because cls_flower on
> >> ingress/clsact qdiscs runs without rtnl_lock and can interleave with
> >> rtnl_lock-holding classifiers such as u32.
> >>
> >> Fix this by making tcf_chain_tp_insert_unique() report through a new
> >> "inserted" out-parameter whether tp_new was actually inserted, and
> >> gate the errout delete_empty call on it instead of tp_created.
> >> tp_created itself must stay set on this path: the chain reference was
> >> consumed by the destroyed tp_new, and errout_tp relies on tp_created
> >> to decide whether to tcf_chain_put(), so resetting it would underflow
> >> the chain refcount.
> >>
> >> Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concur=
rent execution")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> >> Signed-off-by: Aohan Mei <henrymei@tencent.com>
> >
> > This is the same issue Sashiko found. A patch is here:
> >
> > https://lore.kernel.org/netdev/20260805134049.927864-1-victor@mojatatu.=
com/
> >
> > Also, please add assisted-by: tags going forward if this was ai generat=
ed.
> >
> > cheers,
> > jamal
> >
> >> ---
> >>   net/sched/cls_api.c | 21 ++++++++++++++++++---
> >>   1 file changed, 18 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> >> index fee4524ad..9ceb2b538 100644
> >> --- a/net/sched/cls_api.c
> >> +++ b/net/sched/cls_api.c
> >> @@ -1937,7 +1937,8 @@ static struct tcf_proto *tcf_chain_tp_find(struc=
t tcf_chain *chain,
> >>   static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain=
 *chain,
> >>                                                      struct tcf_proto =
*tp_new,
> >>                                                      u32 protocol, u32=
 prio,
> >> -                                                   bool rtnl_held)
> >> +                                                   bool rtnl_held,
> >> +                                                   bool *inserted)
> >>   {
> >>          struct tcf_chain_info chain_info;
> >>          struct tcf_proto *tp;
> >> @@ -1948,6 +1949,7 @@ static struct tcf_proto *tcf_chain_tp_insert_uni=
que(struct tcf_chain *chain,
> >>          if (tcf_proto_exists_destroying(chain, tp_new)) {
> >>                  mutex_unlock(&chain->filter_chain_lock);
> >>                  tcf_proto_destroy(tp_new, rtnl_held, false, NULL);
> >> +               *inserted =3D false;
> >>                  return ERR_PTR(-EAGAIN);
> >>          }
> >>
> >> @@ -1964,6 +1966,11 @@ static struct tcf_proto *tcf_chain_tp_insert_un=
ique(struct tcf_chain *chain,
> >>                  tp_new =3D ERR_PTR(err);
> >>          }
> >>
> >> +       /* Tell the caller whether tp_new was actually inserted, or an
> >> +        * already existing tp is being returned instead.
> >> +        */
> >> +       *inserted =3D !tp && !err;
> >> +
> >>          return tp_new;
> >>   }
> >>
> >> @@ -2254,11 +2261,13 @@ static int tc_new_tfilter(struct sk_buff *skb,=
 struct nlmsghdr *n,
> >>          void *fh;
> >>          int err;
> >>          int tp_created;
> >> +       bool tp_inserted;
> >>          bool rtnl_held =3D false;
> >>          u32 flags;
> >>
> >>   replay:
> >>          tp_created =3D 0;
> >> +       tp_inserted =3D false;
> >>
> >>          err =3D nlmsg_parse_deprecated(n, sizeof(*t), tca, TCA_MAX,
> >>                                       rtm_tca_policy, extack);
> >> @@ -2382,7 +2391,7 @@ static int tc_new_tfilter(struct sk_buff *skb, s=
truct nlmsghdr *n,
> >>
> >>                  tp_created =3D 1;
> >>                  tp =3D tcf_chain_tp_insert_unique(chain, tp_new, prot=
ocol, prio,
> >> -                                               rtnl_held);
> >> +                                               rtnl_held, &tp_inserte=
d);
> >>                  if (IS_ERR(tp)) {
> >>                          err =3D PTR_ERR(tp);
> >>                          goto errout_tp;
> >> @@ -2440,7 +2449,13 @@ static int tc_new_tfilter(struct sk_buff *skb, =
struct nlmsghdr *n,
> >>          }
> >>
> >>   errout:
> >> -       if (err && tp_created)
> >> +       /* Only delete a tp that we actually inserted ourselves. When
> >> +        * tcf_chain_tp_insert_unique() raced with a concurrent insert=
ion
> >> +        * it returns the existing tp; tp_created must stay set then (=
the
> >> +        * chain reference was consumed by the destroyed tp_new), but =
the
> >> +        * existing tp must not be deleted.
> >> +        */
> >> +       if (err && tp_inserted)
> >>                  tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL)=
;
> >>   errout_tp:
> >>          if (chain) {
> >> --
> >> 2.50.1 (Apple Git-155)
> >>
>
> Thanks for the pointer. We tested Victor's patch locally and confirm it
> is an equivalent fix for the same issue, happy to defer to his version.
>

Thanks. Please respond to that patch and add a tested-by tag

> BTW, "TencentOS Corvus AI" found this bug; and the patch was mannualy

Also add a reported-by tag to the patch response

> written and validated, so no `assisted-by` tag here. Noted for future
> submissions.

It does look like there was some human touch to it (other than the
verbose comment) - and is a reasonable patch except you missed one
spot.
I am wondering how you tested it. We had to craft printks to see the issue.

I was kind of suprised how quickly you found the issue. Victor had
something already based on what Sashiko said but i said to wait until
the first patch made it in.
Does Corvus AI watch what Sashiko comments on?

cheers,
jamal
> Thanks,
> Aohan Mei
