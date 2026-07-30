Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE503DA7C3
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402000; cv=pass; b=A7gL2K4XYlEa3a1MMgTdSP9MbgdCEPPOUoEZEVJb4wZR3uL4ef91/GJ5xR7DEqOMFR8d5PpZmTZDHiJLYbRgapKKKamhXrDJ6q5hM7zJdhrDrzv4IcLtJ/nUNlenDg75XIorOYIF/nl8NxNqMKrJmgQidZDLdl/IwhML84L7AJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402000; c=relaxed/simple;
	bh=3BlbjP9htkirpCvdUHhtkATIpPBwnsVzz+jKBiWdpd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lm5rY4pddMDE14g9O0PupjpvghE6tv1YcuwELbsmAY2mGtc/Wf3CoArBMzqz5/2quG6g1PLqg1xJ1sOHMTg3BRyKnsd6uW9v7xDyfYWI4CD7M5XvIhSrGl481KB2PfplhoLAVj6gHEX4orwAI17Ihq/F2uXtPIvHIzcgf/Ix5mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=icrnlSEL; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="icrnlSEL"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84864086bfeso1943180b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785401996; cv=none;
        d=google.com; s=arc-20260327;
        b=bT2dTpRKeILE3vfWRfSjNew7NzrMGeTTSrsZmfPvDa8/G42hwQVbfuSuSMxTtN/Pkn
         MxwKziHbBlbwMD7KGiCOsI590l9h6tTvIV01qEagg3DWLcRMoYfhCuyDRsrpAb129b77
         A57G7sdbO5dH6yXoPxzSDcQnTSnu4V2h+aAUOtalOdE7ke4wAY3noi+4t4M4X37CHOsp
         Ngp2KVTxz+7KsV/a6nEb1gV127eKrLU3pslwIU1nu2Ocv7cb5OtLtwSoWzLVI1NOm/va
         6EUbyOrkNe+0dIj2usuTY5mRuvEtHn3JfOH34jEWvNEKbpRS6z8Urhpo9WsXSXq3TzLS
         btHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KPZyk5Vpr0XemuaXR8dlGCqcRzh51T3XihIUfyZqUrE=;
        fh=68k4wrhjm+X+zarppED4t5u9pQSdHBLx6rSI0vzOyYQ=;
        b=QCAUlJogmv6UdX8weg+ktVUwq3TqD0yMt/qGKLljruIf/mt8ffBafT64LfoB0o1MVH
         oCm0SwdN2fS6sODmvYOuQLC+pQ0VrhUskMXrewcEwiTWG6t34uUZi+w5Z+ZFm3VkTwJU
         2CUQrogKFEu0QqEPp/Poz0QyD3xxlAaSMCHfVl4Jv9iNSJtw6vKud/FJ402TEvJt7WcJ
         eisUCecC9b86PPabLUqkVRluEpD6GlxQBkgV+SAua/dEQ5wiUtON+89r7gmMEo9QeeRU
         6ZrKLG8SaCtaPN4DbMvC2bLtHIx9azdT5lneFDygQzChl/wkQpVNN+jyXhLTbbxS3fdp
         QAoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785401996; x=1786006796; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPZyk5Vpr0XemuaXR8dlGCqcRzh51T3XihIUfyZqUrE=;
        b=icrnlSELGqSP+x93h7dkugPkLtOEyofDkt48Hr2dSB1pRuATnA0vMLD1bKFp5DzoKo
         n+EXxGGcxR1hEx/f/LfJJW29QKfKk8ycaAsGu9VTNvc7fnfNWIH0BFLIPrItFiLd71GT
         LCqUS1vhcBeMOYuRF+epnrzBbgNuNZ867l/dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785401996; x=1786006796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KPZyk5Vpr0XemuaXR8dlGCqcRzh51T3XihIUfyZqUrE=;
        b=Gj1nqLyE2/VSPyscvPDPoixhNAKaGxmZVzpkw5DZlCmNAMzfGpEmV7nixYrCoaC5OY
         QMUU3BIWjd3K8x7ZNljLUAgs3y3mpOV51/LR4t+OrqHtKeUtoM7j+ZFNPosLOyLUe+5z
         04kSe3kcfuouGs04LfJ9sjH4tzXyVt7z8NpL+JAU2/It7Hg2Xg0EJ6D+7QvTF5Hzr08a
         v9a89SYkQSxZ5nFYCxkfSz/olKjg2KkcVel39JqwdxsP+dAITIbhrmqZYRplPpMkRhcC
         I4bObtuy7DnT+VttZU3ZJnBG6OcbSlxbHaHeh6ta7OZjaAqQgSeY2kVbSPkLSDg40LfU
         AJPA==
X-Gm-Message-State: AOJu0Yy/IMA01Bq2ZYCVg08WhLCyUy+E033/9i1H13k+EBHmrOUmcc1D
	ijpLo3NSglPCm0Tck6Q8MqDnWMTYTyZgQwmzNOplQnrYu/ae297YqIeYsZPHD1PiQYCX6ox1QGr
	KpDj0qUSKG3HurWxM5fsG8dsz+5l+fn0tG1pPZAB5WrYwZhldrYk=
X-Gm-Gg: AR+sD111hyI4phZLrPg8ICH5AtPyS0M3uWdABbhmHa5364Vc62UPjij7nBRW7BP/Csy
	FS0byPXI5+CFqmyzxR2N2UvqFgCJCRpZCehs/lh930SnTaNo2Rq4zym7c+TVDzxy3rgxUgAIidw
	Ld0sBZsCt9Y6bf6glSs6qaLmLh59aBGUAVY2zS4z7ou13Ba7K9tOF1V62FoZsFJ+1WPSNJheV56
	f71YUgXWxO78fLBdUJ5YN/LP/Iuoxq+e8EeDDHun6DJxB00iv2eUbx5KfVAm0l2f7hG4LSD5aiA
	FRUM7/VVGaxMWxJ8Jp3LrOS55DJWeHISmz3REK099xgG3Q==
X-Received: by 2002:a05:6a00:3a1f:b0:848:2f84:735 with SMTP id
 d2e1a72fcca58-84ebc424124mr1806162b3a.72.1785401996579; Thu, 30 Jul 2026
 01:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785304107.git.milkory@outlook.com> <99183398d8534a2bd65e8819cde9dae92dd97114.1785304107.git.milkory@outlook.com>
 <CAM0EoM=VxHRg-xULQqPLvC5_XveZ0EvvaCH3EmL6vTWnM9+aNw@mail.gmail.com>
In-Reply-To: <CAM0EoM=VxHRg-xULQqPLvC5_XveZ0EvvaCH3EmL6vTWnM9+aNw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 30 Jul 2026 04:59:44 -0400
X-Gm-Features: AUfX_myD7Q65NLG2aRwJCeg7DTLnsENiJP9nB-26SkPFU3XOh6JiFJEHLRa0q3k
Message-ID: <CAM0EoMk8bgBKQv90YEvoKxWkrsoEauhkbeXee9xYtxc9gU+n8w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: reject overly deep qdisc hierarchies
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vega@nebusec.ai, milkory@outlook.com
Content-Type: multipart/mixed; boundary="000000000000c9d7660657d04bb0"

--000000000000c9d7660657d04bb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Jul 29, 2026 at 11:41=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> w=
rote:
> >
> > From: Zijie Huang <milkory@outlook.com>
> >
> > When creating a new qdisc under an existing classful qdisc, the current
> > code does not check the depth of the parent hierarchy before grafting t=
he
> > new qdisc. This allows users to grow a qdisc hierarchy one level at a t=
ime
> > past the intended depth limit.
> >
> > Reject the operation before creating the new qdisc when the parent
> > hierarchy is already too deep.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zijie Huang <milkory@outlook.com>
> > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> > ---
> >  net/sched/sch_api.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index 668bcd60d183..09d57ad76b89 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1467,6 +1467,24 @@ check_loop_fn(struct Qdisc *q, unsigned long cl,=
 struct qdisc_walker *w)
> >         return 0;
> >  }
> >
> > +static int qdisc_parent_depth(struct net_device *dev, struct Qdisc *qd=
isc)
> > +{
> > +       int depth =3D 1;
> > +
> > +       while (qdisc->parent !=3D TC_H_ROOT) {
> > +               if (qdisc->flags & TCQ_F_NOPARENT)
> > +                       break;
> > +
> > +               qdisc =3D qdisc_lookup(dev, TC_H_MAJ(qdisc->parent));
> > +               if (!qdisc)
> > +                       break;
> > +
> > +               depth++;
> > +       }
> > +
> > +       return depth;
> > +}
> >
>
> 1) This check is expensive because it runs for every graft.
>
> >  const struct nla_policy rtm_tca_policy[TCA_MAX + 1] =3D {
> >         [TCA_KIND]              =3D { .type =3D NLA_STRING },
> >         [TCA_RATE]              =3D { .type =3D NLA_BINARY,
> > @@ -1749,6 +1767,12 @@ static int __tc_modify_qdisc(struct sk_buff *skb=
, struct nlmsghdr *n,
> >                 return -ENOENT;
> >         }
> >  create_n_graft2:
> > +       if (p && !(p->flags & TCQ_F_MQROOT) &&
> > +           qdisc_parent_depth(dev, p) > 7) {
> > +               NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep");
> > +               return -E2BIG;
> > +       }
> > +
>
> Could we introduce an O(1) variant? Store the depth in the qdisc tree
> when grafting a new one and then just check here and reject?

Something like attached. Compile tested only.

Also - since you can reproduce this without much complexity how about
you also create a tdc test?

cheers,
jamal

> Also, if we are going to check here - i think the dump check for loop
> is obsolete now?
>
> cheers,
> jamal
>
> >         if (clid =3D=3D TC_H_INGRESS) {
> >                 if (dev_ingress_queue(dev)) {
> >                         q =3D qdisc_create(dev, dev_ingress_queue(dev),
> > --
> > 2.47.2

--000000000000c9d7660657d04bb0
Content-Type: application/octet-stream; name=qdisc-recurse-patchlet
Content-Disposition: attachment; filename=qdisc-recurse-patchlet
Content-Transfer-Encoding: base64
Content-ID: <f_ms79xruk0>
X-Attachment-Id: f_ms79xruk0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmggYi9pbmNsdWRlL25ldC9zY2hf
Z2VuZXJpYy5oCmluZGV4IDQ1YTFlOGM3ODIyMi4uY2JjMjQ4Nzc2NTExIDEwMDY0NAotLS0gYS9p
bmNsdWRlL25ldC9zY2hfZ2VuZXJpYy5oCisrKyBiL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmgK
QEAgLTk5LDYgKzk5LDcgQEAgc3RydWN0IFFkaXNjIHsKIAlzdHJ1Y3QgaGxpc3Rfbm9kZSAgICAg
ICBoYXNoOwogCXUzMgkJCWhhbmRsZTsKIAl1MzIJCQlwYXJlbnQ7CisJaW50CQkJZGVwdGg7CiAK
IAlzdHJ1Y3QgbmV0ZGV2X3F1ZXVlCSpkZXZfcXVldWU7CiAKZGlmZiAtLWdpdCBhL25ldC9zY2hl
ZC9zY2hfYXBpLmMgYi9uZXQvc2NoZWQvc2NoX2FwaS5jCmluZGV4IDY2OGJjZDYwZDE4My4uMWU3
MDA0N2E3MWM4IDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvc2NoX2FwaS5jCisrKyBiL25ldC9zY2hl
ZC9zY2hfYXBpLmMKQEAgLTExMTQsNiArMTExNCw4IEBAIHN0YXRpYyBpbnQgcWRpc2NfZ3JhZnQo
c3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IFFkaXNjICpwYXJlbnQsCiAJCXVuc2lnbmVk
IGludCBpLCBudW1fcSwgaW5ncmVzczsKIAkJc3RydWN0IG5ldGRldl9xdWV1ZSAqZGV2X3F1ZXVl
OwogCisJCWlmIChuZXcpCisJCQluZXctPmRlcHRoID0gMDsKIAkJaW5ncmVzcyA9IDA7CiAJCW51
bV9xID0gZGV2LT5udW1fdHhfcXVldWVzOwogCQlpZiAoKHEgJiYgcS0+ZmxhZ3MgJiBUQ1FfRl9J
TkdSRVNTKSB8fApAQCAtMTIxMSw5ICsxMjEzLDE1IEBAIHN0YXRpYyBpbnQgcWRpc2NfZ3JhZnQo
c3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IFFkaXNjICpwYXJlbnQsCiAJCQlOTF9TRVRf
RVJSX01TRyhleHRhY2ssICJTVEFCIG5vdCBzdXBwb3J0ZWQgb24gYSBub24gcm9vdCIpOwogCQkJ
cmV0dXJuIC1FSU5WQUw7CiAJCX0KKwkJaWYgKG5ldyAmJiBwYXJlbnQtPmRlcHRoID49IDcpIHsK
KwkJCU5MX1NFVF9FUlJfTVNHKGV4dGFjaywgIlFkaXNjIGhpZXJhcmNoeSB0b28gZGVlcCAobWF4
IDcpIik7CisJCQlyZXR1cm4gLUVMT09QOworCQl9CiAJCWVyciA9IGNvcHMtPmdyYWZ0KHBhcmVu
dCwgY2wsIG5ldywgJm9sZCwgZXh0YWNrKTsKIAkJaWYgKGVycikKIAkJCXJldHVybiBlcnI7CisJ
CWlmIChuZXcpCisJCQluZXctPmRlcHRoID0gcGFyZW50LT5kZXB0aCArIDE7CiAJCW5vdGlmeV9h
bmRfZGVzdHJveShuZXQsIHNrYiwgbiwgY2xhc3NpZCwgb2xkLCBuZXcsIGV4dGFjayk7CiAJfQog
CXJldHVybiAwOwo=
--000000000000c9d7660657d04bb0--
