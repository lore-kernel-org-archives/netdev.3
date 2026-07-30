Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEB42DA48
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415298; cv=pass; b=JmTXNR+/g7WSXZtuR5YJ8MosQbA5gkFTGm9z4LjT6OVuBj4hGVzHUT7kEO2RcN/yHI12RSdtoQU6EL9Nd2iFzIZSbrOCwO5rWPjF4b7oXKm+IJdH4RoAE03CSClesQzjMhF5m/TS88Hzjjq492zI6smZDUEtgTFhCBtFEUp/sJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415298; c=relaxed/simple;
	bh=ocgyBapkKknCN66XVJbMxtziTJrpEj5nCAn9tk10TNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXVPdZpGezMkmw9yZryw2WSyZD69OBw4vPnjkih1/NRFlSo+E8N6BLsVK/XmAuF48X3p1xmR41CFRLR544SiNJoduDWKpP+lwpB24izBtoeei8Dhm61VETWZU2Kqnf9Z8GJPC3ZAzpRucruop4CDbHYcHVCJwnM9UMRS1W6GWe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=wnp9njaP; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="wnp9njaP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so2308230b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 05:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785415296; cv=none;
        d=google.com; s=arc-20260327;
        b=gj442l37ZHS8RQIXn0HN6OBZTiXtjW7yAS+47Cqi/QraWuXKB0+AoV13oiaWNRJz9/
         aJIiHtNlIICFOOQWnGCxAOzHO9XTX2igO++5EpxydRHrg4KnCahy3oKyoVTR8MFqMbJP
         4q7Pz/M3SXw7yo/9tK9q1pjwPeLUamWi4nXaWPj4aBDrgLeepaGOjmgIiUzB3EMHk+au
         Q0jMZ1URV+RFgq4ez2z/HnZUSOxtOuOGqCMDk+avAnEd994Hspr+ep7/KVDijvfgk0jU
         l0QY0dkBMJqyQMvQckwICek5m54mVJ5RzETm406jT6+Y/cbn75GCwA6hTLyK5EI0UQkj
         2cvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=irweRXoJC8pjj+aDyGAc/w3BPBmxR9OfFjFL3zGebdI=;
        fh=UUkJMi/IySMoQMpweKmrQKm6fGFzmfAPmvWPVJi477U=;
        b=GiEiIpsfofnxCC68ktbPc26sbsINl6g9Vp2QAZiW28qBKvZQtKvrtK/EiqW40yvXa8
         h3Y5vEDXykSfAZKfKs2fCMU2wGSZpmD2u9TTqkHAusBiMLr1aaaZKdAqCbxIAtwTul6w
         OzHjlTZ+QV9mpfhMc6ncJInukr0Rxya20dViU5M1wP4a0tKl9DLZT/OKxW8+pQz4sX+U
         uMUHMzmr1CuCvv301xmsBdImjO5geOS06mRrlTSzMYxS9E0RE0ntcNVwfQ/Oo+r7BYHa
         7v6KCm75qxY6Eem2KUTnWuAePv5MgdQbgox6BV0kQk4j6tCS2BsCmmNCMTy9PDmAwSW3
         KAkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785415296; x=1786020096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=irweRXoJC8pjj+aDyGAc/w3BPBmxR9OfFjFL3zGebdI=;
        b=wnp9njaPwI5wAhBqEOR3tt59s8yW9q6mHrUQ/OIV18Zy9jb/y5HlN15vyUVOiFU5DP
         ST+TfEH5eTqJ38QNgLg35KIjnk2k+BsHMy8S+p2dETfAMt7Y6LIaCWg/LZHbg97A7Gne
         YJrTn50TY2k8zeFf3HcOpiEcbGj5/PrNGsEA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785415296; x=1786020096;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=irweRXoJC8pjj+aDyGAc/w3BPBmxR9OfFjFL3zGebdI=;
        b=lKMOGQIsey8yJ3CViIg+V80RrPElVaI/6mQCaevVUBvXDU1Bu9a/ONiEhAnYW3C73F
         leXsOoREg0s+SbgvoMcmknk6rOGwbdOEK9XzkHzJcwFI4VsKnT284dvNktCyCQcP955J
         gNbgXuRNz69YWFq6LZoRzXfnf5FuHReVsbkF54fmL0abu9XIsq03ndCjEspieaIa6udD
         5AgkKHJzXmcMuAW4q7K+hbib5ZfpvtRio2eVvH66VgPeCdIxZs7Rf17I9mja+klP5fb2
         Gripp1C7/8AD6OQGqEhbujmjYmTIqnRw2nmhfhKUKQIWTF5U8Pxt3RgXqVVRn3DvxYdq
         wmsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHcGFUOoTMknju5VKpK+7WHzMcmEoNBelYpwT6mA3IXazqmVvBdzVXX7/HNdXwKt1rI7O9+GA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SilmQDDI0YJmi4imrQUTmovtFYoAHH7EM8oj//P/xGI5Q+gG
	LitIw3KfNBcV/C/X7LBcZ5z0OwP6IkVyM5MwQXs6bgzuXB95iUAtvABUJZCbxbyAQZCqcRFLAsL
	a82zfVG2z5e4l4ZkcaC8inIMa4p7y+nlv5yGrWocv7AHpZ4lmA8c=
X-Gm-Gg: AR+sD11WSAAiaTXdCBKRJ3Vna3YyiQLNAtHNTaUxrzpouRe3YZ9Q+VStOJzV4x1HeJF
	hZEugHOPjAmtjWGe96/ahAXJVj2/wuUR7ms+3zMwrPlpJClhUzH6/4YJxag7/q7oWsHaZfB3zEd
	5Mhd1ioDk4jxkkoRoeXmbtWJgDS+CmYlAO41v/V+LoBHH/3IA1bAJh9kggkSZmkF/+f2Yk3pLDW
	2s0rRHfrT7f4Ph5aivbMZ/FQSezkuCubEDv9cJvfsTdzqQrHKww4Hm7LqHw0+YY/+DabDg5wz1g
	MT0BTMeV++KEFIbbgf3245joEFb4gQLM5GeOvQLgvLkrVcnvl6Ieku2e
X-Received: by 2002:a05:6a00:420c:b0:84a:2e5f:d697 with SMTP id
 d2e1a72fcca58-84ebc23c442mr2558157b3a.33.1785415295857; Thu, 30 Jul 2026
 05:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785304107.git.milkory@outlook.com> <99183398d8534a2bd65e8819cde9dae92dd97114.1785304107.git.milkory@outlook.com>
 <CAM0EoM=VxHRg-xULQqPLvC5_XveZ0EvvaCH3EmL6vTWnM9+aNw@mail.gmail.com>
 <CAM0EoMk8bgBKQv90YEvoKxWkrsoEauhkbeXee9xYtxc9gU+n8w@mail.gmail.com> <TYCPR01MB8566FD415B7837A5202E4601BBC92@TYCPR01MB8566.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB8566FD415B7837A5202E4601BBC92@TYCPR01MB8566.jpnprd01.prod.outlook.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 30 Jul 2026 08:41:24 -0400
X-Gm-Features: AUfX_my_7CWlOIskcMYLgZfC5a8grFLAo5aaWuivOpVjx_rDPSZTDXknnOyccjU
Message-ID: <CAM0EoMnS_XcLBqfxW83a5x-pCUJ7jmgXAmkm4p0Y07R7vjSdkA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: reject overly deep qdisc hierarchies
To: Zijie Huang <milkory@outlook.com>
Cc: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 8:27=E2=80=AFAM Zijie Huang <milkory@outlook.com> w=
rote:
>
>
> On 7/30/2026 4:59 PM, Jamal Hadi Salim wrote:
> >
> > On Thu, Jul 30, 2026 at 4:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> >>
> >> On Wed, Jul 29, 2026 at 11:41=E2=80=AFAM Ren Wei <enjou1224z@gmail.com=
> wrote:
> >>>
> >>> From: Zijie Huang <milkory@outlook.com>
> >>>
> >>> When creating a new qdisc under an existing classful qdisc, the curre=
nt
> >>> code does not check the depth of the parent hierarchy before grafting=
 the
> >>> new qdisc. This allows users to grow a qdisc hierarchy one level at a=
 time
> >>> past the intended depth limit.
> >>>
> >>> Reject the operation before creating the new qdisc when the parent
> >>> hierarchy is already too deep.
> >>>
> >>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>> Cc: stable@vger.kernel.org
> >>> Reported-by: Vega <vega@nebusec.ai>
> >>> Assisted-by: Codex:gpt-5.4
> >>> Signed-off-by: Zijie Huang <milkory@outlook.com>
> >>> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> >>> ---
> >>>  net/sched/sch_api.c | 24 ++++++++++++++++++++++++
> >>>  1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >>> index 668bcd60d183..09d57ad76b89 100644
> >>> --- a/net/sched/sch_api.c
> >>> +++ b/net/sched/sch_api.c
> >>> @@ -1467,6 +1467,24 @@ check_loop_fn(struct Qdisc *q, unsigned long c=
l, struct qdisc_walker *w)
> >>>         return 0;
> >>>  }
> >>>
> >>> +static int qdisc_parent_depth(struct net_device *dev, struct Qdisc *=
qdisc)
> >>> +{
> >>> +       int depth =3D 1;
> >>> +
> >>> +       while (qdisc->parent !=3D TC_H_ROOT) {
> >>> +               if (qdisc->flags & TCQ_F_NOPARENT)
> >>> +                       break;
> >>> +
> >>> +               qdisc =3D qdisc_lookup(dev, TC_H_MAJ(qdisc->parent));
> >>> +               if (!qdisc)
> >>> +                       break;
> >>> +
> >>> +               depth++;
> >>> +       }
> >>> +
> >>> +       return depth;
> >>> +}
> >>>
> >>
> >> 1) This check is expensive because it runs for every graft.
> >>
> >>>  const struct nla_policy rtm_tca_policy[TCA_MAX + 1] =3D {
> >>>         [TCA_KIND]              =3D { .type =3D NLA_STRING },
> >>>         [TCA_RATE]              =3D { .type =3D NLA_BINARY,
> >>> @@ -1749,6 +1767,12 @@ static int __tc_modify_qdisc(struct sk_buff *s=
kb, struct nlmsghdr *n,
> >>>                 return -ENOENT;
> >>>         }
> >>>  create_n_graft2:
> >>> +       if (p && !(p->flags & TCQ_F_MQROOT) &&
> >>> +           qdisc_parent_depth(dev, p) > 7) {
> >>> +               NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep")=
;
> >>> +               return -E2BIG;
> >>> +       }
> >>> +
> >>
> >> Could we introduce an O(1) variant? Store the depth in the qdisc tree
> >> when grafting a new one and then just check here and reject?
> >
> > Something like attached. Compile tested only.
> >
> > Also - since you can reproduce this without much complexity how about
> > you also create a tdc test?
> >
> > cheers,
> > jamal
> >
>
> Yes, I will include one in v2.
>
> >> Also, if we are going to check here - i think the dump check for loop
> >> is obsolete now?
> >>
> >> cheers,
> >> jamal
>
> The loop check seems to be obsolete for normal tc paths since bc50835e83f=
6
> ("net: sched: Disallow replacing of child qdisc from one parent to
> another").

Not exactly. You can still graft - as you have shown - a higher depth.

> I think the whole regrafting path is mostly historical now, but
> maybe not related to this bug fix.

Yes, that doesnt belong here.

cheers,
jamal
> >>
> >>>         if (clid =3D=3D TC_H_INGRESS) {
> >>>                 if (dev_ingress_queue(dev)) {
> >>>                         q =3D qdisc_create(dev, dev_ingress_queue(dev=
),
> >>> --
> >>> 2.47.2
