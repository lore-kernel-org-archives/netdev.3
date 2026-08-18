Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1C2931D5
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046702; cv=pass; b=TUa3fczQ7Gam0K6AV4/tJNW9qekg4IY/WGtXYCTYlmTsCsC7ca3k7Nkrd00bWCQZPW7KT1AvXZ+9M/+JbQVb9jDK91r+11YmuRHB89ayuAGbHqoWPCDlmV1r5vRVzKN5OlmYpUfpF3tv9yvb008S8QFWXbTfuLXNNPoY2uN4eo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046702; c=relaxed/simple;
	bh=otMdvj1RsW7CEYo87GadfPUS3eEtIw8WCq6yZnzG3Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iw36eDrSWk50eoMnmYPM3XM7tvkLlvnoo8jkjBQivQfzQhgaMRqVVk9J+w6brIlmOwvGBlAO6iED4UsgrucYugX2umeZCgix7fFm0msVtK2wDyQZNZO+hWC7nueCxh43J7OFi/Bx1ceoaidPuuHoaUx9CBEI0brAweA9kMjOJqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=H/G177O2; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="H/G177O2"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so3685641b3a.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787046699; cv=none;
        d=google.com; s=arc-20260327;
        b=hRyvOXfLZcRJRtT9bOi/nHFx8SLM1wZHWURVyfmDY+RCJgF3q6rJroXJCYYxjkzbBR
         GKVqQTYQg8mEvWM+f33nt6nfmnB9+0f9NKv4SDFI2k2yJoVAkSJzYozrrluxf8oNwV9v
         fAhjUnLGjZk8N/AXyRyaWUm9fYUObyE1+XQHS+NR+AVkvqkqAAD3hFeCyRSkRCuy/WHq
         x71TMKLXyDqFFD6Jfb6wHWO7s4DFckaD1VwXTwwsHqxgJDzJR3l3uvfG6VsYKDuv1ID0
         ERscnuQ/CYaYKnF/ThodseV1Mj0WQJxR9qhD8KN4U8aqYI/7wlv34wtq9/GQ9aOxIK9E
         TaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8XmdlJPcuQ46kcIO9yPONW63W13Q2fzfcpNS7QphKiY=;
        fh=1xzxxQYHyUPgdrqnq+VatmzWkkDwmHKFuCpp6UliZww=;
        b=If+bstZ4h6W6QQnL/nHtmMh2Mt0e3zA80cOTCENvw1iV0VPrU5MKQIW09t8G19G1Nx
         qcXZkZg/GsZPx7+M1TvzSAjDNjwPipLsBi05Knj6SLUS1A+swcVB2KLaPqlQ+44caNUw
         KaCRoVlshOfUFdjlxeMFOQW8WO+Clbl6r9d/fjzwNtldfzchtznH240qPF1CVeJa6IZx
         8FlRwz4eztzWYTy5BRsbBRY34Qe7uhcGZ+gAyqnLJlFE0WqDdk84WB48Ovf9LkYxWN16
         px7KRnpW+Pohz0dKaMHMhos2IWp+eNmgT6sRIkS13bSVQA9HCTAgMgQF34F2/hvh10BV
         pLEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787046699; x=1787651499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8XmdlJPcuQ46kcIO9yPONW63W13Q2fzfcpNS7QphKiY=;
        b=H/G177O2VeHq0Bmu19bCduKYsmB4InJ7zXxXyRy0flbAZ+YMm8wEzc7sh8T/5r9+qn
         6+N0yr5KbRKzYLGr76QZgN0SOanKmu9xPXjPtokKwLzL0FUjIojDpA+jZAzJ5aqNId1N
         nYh9F2x/k+XzVYJtmFcguWk0fLD62ICj9lggo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046699; x=1787651499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8XmdlJPcuQ46kcIO9yPONW63W13Q2fzfcpNS7QphKiY=;
        b=E5oIwYky0KtNuDv4yfyjOZtmd2sRLv5uw7zbWzDcsOtadehYU42s6y5XFT3JdVMc7u
         UcxSH2AGpMqj9yafkV6f1A71jjxzZq6BO7s8lg6XCyeaJn91EjT7Xlfa6b2zcWsu9tcB
         fwhI4jJcIt6w75XdLUakJ+596ckz10FONO0JWmVc3axJ4xjAXY/Vfixfg95DFpvQOF0Q
         WCaVHZQLRiUnDGak1a5fLYrGDx5Vt0XAU098RN0FdyuXV2l5NuqorvrzjnPdYmdXJIZ7
         svcksXWQO7LuVKNoTVA+QiCUi32WbaNTLQA3i2le39MLBD/s9MHX8C6effKbzoDiuCjF
         gfVw==
X-Forwarded-Encrypted: i=1; AHgh+RqcnBgO7qtVYKKw+FH6hd9MKdFTlKAcj0n0pcKKWdieXCPeAnHz2sti97gdylY686/bm6ojVQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHb1wVnR9rbjqIfUr6J9gwpPiQE4UyaEMAlVDQeRnLQgboePF
	yjd7ZX5/xFX+7GtNf2hFkt0JOtq23/ZgBpGxgV5ewEBFUcLu1dA3qMlTC+49b3EbhGwIYJBnCsz
	HlprI9skLTY0SsaTCfTwshXdAtEk5R205C0xX/Nsg
X-Gm-Gg: AR+sD10AHzeGoA7cwl3SGPKRGkTc2SpJt3Yx+X4VYssBWxg/f7RYOZatc7JY97NGHHB
	MosMOlJinsEuR5+kPLfBP6852w4i+ATxNl8KiadplHL1L+7+GefH+APoTfRjbvaghp3yi+QdNW0
	tVZBD/RLKAh1UJI7MZIn9cCs1T9ugNa4/ofeiqMeug/bOOAFwVsSqoBvjYVcaOsl68N8QOU4Lsy
	jyY0arwLsE5FhQGOhf0GK0GABMagvG9mrXOOoWRuad7J0Y5ZCuBRMMT0bfEtPrkEkCpcJm/55+D
	TQUnSagjHDcGKh9nqwWzEYFSRADjaY2+8+KWRGI7pOWOwQ==
X-Received: by 2002:a05:6a00:3697:b0:845:dffa:3740 with SMTP id
 d2e1a72fcca58-84fde11d75cmr34034397b3a.4.1787046699504; Tue, 18 Aug 2026
 02:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813122242.1690024-1-jedrzej.jagielski@intel.com>
 <ccba8112-ff9a-47ea-8b91-a732e28b555d@intel.com> <PH0PR11MB5902885C0E23D5DEED9011C6F0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5902885C0E23D5DEED9011C6F0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 18 Aug 2026 05:51:28 -0400
X-Gm-Features: AcwNN1Wz1CC1eLlWGa6z_CgIC6iXZGQ1QwUOoIIRqFkgovWlwyo83_Id4cDFOic
Message-ID: <CAM0EoMm+XqVrSznS4pK_n2X6XGWO-kb001gSwQMDCM20keECKg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/3] net/sched: u32_change() fixes
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:48=E2=80=AFAM Jagielski, Jedrzej
<jedrzej.jagielski@intel.com> wrote:
>
> >From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> >Sent: Monday, August 17, 2026 2:43 PM
> >
> >On 8/13/26 14:22, Jedrzej Jagielski wrote:
> >> sorry for spam, previous series get treated as incomplete so resending
> >>
> >> ALREADY ON NETDEV, SASHIKO RUN
> >
> >hehe
> >ofc, the above does no harm here
>
> :D
>
> >
> >for the series:
> >Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >
> >--
> >
> >Sashiko has found one more *preexisting* bug, perhaps it could be
> >handled by one more fix in future series?:
> >https://sashiko.dev/#/patchset/20260813122242.1690024-1-jedrzej.jagielsk=
i%40intel.com
>
> yeah, i saw that and i thought about extending the series

If i am counting correctly there are now 3 more "preexisting" issues
that require follow-up. Are you going to do this?

Regarding the other legitimate issues Sashiko raised:
1) Please double-check everything an AI claims, especially if you used
one to generate these changes. It is very confident and _does_ make up
shit. Example, based on what i have seen being posted it will make up
fixes tags that look serious but dont exist;-> so you need to fix that
id.
Along the same lines: My assumption is you are actually testign this
against something like ixgbe and additionaly  a device that cant
offload? Adding a tested-by (if possible by someone else) would be a
plus. And a tdc test  would be appreciated as well; the skip_sw reject
path is only the user-visible half that seems possible to create a
test before when things just returned success to now returning an
error.

2) Can you please add the comment in the commit i asked before to
explain the user visible changes. In case my or Sashiko message wasnt
clear; before when you ran:
"tc filter add dev eth0 ... u32 ... skip_sw" it used to succeed (exit
0) and then the rule was installed in software with a skip_sw flag but
was used by neither s/w nor h/w.
After your changes the on a device/block that can't offload, that same
command _now fails_ with -EOPNOTSUPP or -EINVAL.

Something along the lines of:
Because skip_sw is now honored, "tc ... u32 ... skip_sw" add/replace
commands that previously succeeded (and were silently skipped by the
software path) will now return -EOPNOTSUPP/-EINVAL when the block or
driver cannot offload the filter.

basically you need to resend with a v3. Add at least one tdc test.

cheers,
jamal
> >
> > > @@ -938,14 +938,6 @@ static int u32_change(struct net *net, struct
> >sk_buff *in_skb,
> > >             err =3D u32_replace_hw_knode(tp, new, userflags, extack);
> > >             if (err) {
> > >                     u32_unbind_filter(tp, new, tb);
> > > -
> > > -                   if (tb[TCA_U32_LINK]) {
> > > -                           struct tc_u_hnode *ht_old;
> > > -
> > > -                           ht_old =3D rtnl_dereference(n->ht_down);
> > > -                           if (ht_old)
> > > -                                   refcount_inc(&ht_old->refcnt);
> > > -                   }
> > >                     __u32_destroy_key(new);
> > >                     return err;
> > >             }
> >This isn't a bug introduced by this patch, but looking at u32_change(),
> >there
> >appears to be a pre-existing issue with how manual hash table handles ar=
e
> >tracked in the IDR.
> >When a user creates a u32 hash table with a manual handle (for example,
> >0x80100000), u32_change() inserts the full handle directly into
> >tp_c->handle_idr:
> >net/sched/cls_u32.c:u32_change() {
> >     ...
> >               } else {
> >                       err =3D idr_alloc_u32(&tp_c->handle_idr, ht, &han=
dle,
> >                                           handle, GFP_KERNEL);
> >     ...
> >}
> >However, when destroying the node later, u32_destroy_hnode() removes the
> >mapped ID rather than the full handle:
> >net/sched/cls_u32.c:u32_destroy_hnode() {
> >     ...
> >               idr_remove(&tp_c->handle_idr, handle2id(ht->handle));
> >     ...
> >}
> >For a handle like 0x80100000, handle2id() returns 1. Does this mean the =
IDR
> >entry at 0x80100000 is permanently leaked, while index 1 is erroneously
> >freed?
> >If index 1 is already in use by an active auto-generated hash table, cou=
ld
> >freeing it here allow gen_new_htid() to issue the same handle again to a=
 new
> >hash table, causing collisions?
>
