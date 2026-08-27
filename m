Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFA62D7D47
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855890; cv=pass; b=EXiiOC43VYoB0THi9fKPgXbTCHPW5yD31nnv1sw3/HBDHBCMaw3vImgz6VIR+Px2Q/sPsFeHu4mSZ8zOkjN0YSmoaxh683HA0R0xmR0gWOU0QrZmSj0V4tGnD/YhTGRqM80vY8V3eEZjoQFJwTjcb2PmrWG+3G2fF+IzqOwWtlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855890; c=relaxed/simple;
	bh=A3OHUfTDY4B60KmnWjZgp77Qh697513pEoWAN+uT65s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtx9EWrzGGGyw82QR0oD6zjCg4ZuvpLe6LDrMI0YJsE6nu5PvOiGmzvjdREmMdnKrX1bOMozFNwun8ztSVCayRCTo7KeKWEXG82NqUhVpJzGiN7SVAYLsnAEMWvuOoCqqSwopeKzMpUxfQoiB58YbzAwQGrb6zZIvLPHTkiQTwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=R5/fwmMa; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="R5/fwmMa"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66c744a00edso319183d50.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787855887; cv=none;
        d=google.com; s=arc-20260327;
        b=HFderc6v3hj2oEz13NFI3NUeMeDYzLYkRkyQMXg0pZDOr7vOuivUUG4i9/sPYxLg54
         sLcKpkJ2mbLTZ6NJj0jf+jXZVcQ4VZ5QHsTKVWTN5PfVo7OLPJR8VpO8FB12AIihuwyb
         kie4me2azMXJ0l8pEnWHSR71nDLLIFaAoN1dYmI1ADEpzgHzRhA7sXvteuUt8IrQVnF0
         8aU0CzU2OUQ7TGiPzHexvYSM+9md+qQNEt8zDDxZ4YNaAEg5tEX/i6rPy6zgZBu1AR72
         eELmuoMr6riDb/3v/LYaehieX6PXaNXZminmhtQvN4a0PAdIdXQc6ddLO5HDsJDXXyfl
         lAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5lMK2X0TFxVNPsZak8BQQicRG+0cwUrweeRcMx9M16A=;
        fh=T+XlqujZH9hK4qHYQeJGWWQGNCghtKHpotUqh0b3YZU=;
        b=hQWcJCauscJl3hllsmatzUFxppJaM3cLHTc7/ZBNrT3ccbiD1NHdlq7VKz/c73+d3f
         0D/iqq/p+YGAxzIARWrAqal5fXrwxdGV2IQJFTMUrRHbLOL0vrvQtx+5DhcloEYw0gOh
         TEsb2QLOVqYoooy59MnWMZxPvPPFWhxuJzdgL159nxTyyl4j0KpyRTH8Sycgl8tmTGNi
         2ZaoilDOardYnNuBPMJIpN5D/0jXctCMWqyX52AdhRhOdTZZ/w0K6Ta2q9m4VR1oSyCp
         RGnQ8nu6uRFi/givqK3v2EOdg7w2jUei0hQrP99gHmfkySDCSIghFCcgLoPd1ky8zPKa
         vCRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787855887; x=1788460687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5lMK2X0TFxVNPsZak8BQQicRG+0cwUrweeRcMx9M16A=;
        b=R5/fwmMapuoLh1VH9Q6QvkT52HPBhv/6HJfAF76HQvEYfyB3Y1lAVsjd5qlqEfIFZG
         NjawUmaiOU8zga5d78Sg1bCvBILxtJt/tOjpBHrJneQHmLT5+TUh/tm2JqwUmqSmlk6m
         I1JgVxe8Z6ZpAlGlUO6tsiaLRAfpN6dF2z5dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855887; x=1788460687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5lMK2X0TFxVNPsZak8BQQicRG+0cwUrweeRcMx9M16A=;
        b=CtO8NMs0SgNO+RWRii2tHqhGgUFaypTYWP3YE2eQOaMzMiRbWx0S10FsdLN/OE5aNK
         HmYBkzoM1MFevdvKuMKDqAFGV0k691b/lUHhfIk7FQwoEFA2/Cdq/zjx9NER2gUR7177
         fsBeUM1O2D5SVnR4LKamYC47Py0yoUPknv52DuTteIg9Z/IqBM+WUYSUdSevMTwgz4UD
         pIDI4DbWzoSNpOKTLf9FHZMkCM6dZvcw7tEdxdfN/UTCh8kmz95cyeOCfdDVkOPpOxs8
         E0wWrNOxFCcqUxkCqxYBls7u19WdOU6dRV/BiNHX+7XHk59Y25B2JdDZcM1Ngu+bCRHj
         eUHA==
X-Forwarded-Encrypted: i=1; AHgh+RoHTiBFVwTRnd4RjK/Fkz50Tw4O1gCnHMAofwS/VSF5fu4vfPprXln/RHVgDgwdjRxmrbq8Ibk=@vger.kernel.org
X-Gm-Message-State: AFuF++kGD+J8fEp9Cd8I2Eq3U1TA6ZYfKSEbmO39dclqIAgrYnhrqy6Z
	CD4O3t1G/B2q/REPwGjwSAggNz/VEZI18oVP5O5WB35k1bwJ3Z2ckSVGHLZRkYyOcy7TGp1wHrE
	Lpf6adu367VxyPo0TONm+rNR4WH9f7unQmzgbHTQI
X-Gm-Gg: AR+sD13pXOIfIFXM/o0ETrBfMfLa0joG6U812dg5TaMQMX2rl/7VGEeL8DXZG7BpKc8
	ilnRtoqIiisJLqgtsSyCRMpxaGxCymGByRqNpU0Sp9Mh0vvQk8PoCHYrZ+FoGp43QMdyIVnCPI9
	bhBBAm0GqLaNfljJHgvpeuAkFgBcn4GRbyhVNGK++m4RaoVeSUn5GIUs10FZCtE9r78p/cBquXE
	wKJb3KusI1o8wg0Daxrj3SI0x2/JCMiEa8y35lStBOl5Q+dhUMWRXuhrutT/tV5OuVCIaUp1TMc
	0Hk6I/HwXp72gt/i9N7WKDyYSAl2wbQI85J1XDSv0yy83+62HxHMGDyEotQ=
X-Received: by 2002:a53:c6c1:0:b0:66c:fd1b:117 with SMTP id
 956f58d0204a3-66e4c5f36camr133209d50.5.1787855886638; Thu, 27 Aug 2026
 11:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824153903.4143642-1-victor@mojatatu.com> <20260824153903.4143642-2-victor@mojatatu.com>
 <20260827084456.GA396647@horms.kernel.org>
In-Reply-To: <20260827084456.GA396647@horms.kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 27 Aug 2026 15:37:55 -0300
X-Gm-Features: AcwNN1Xs7Xbud-5E3z-gTFDfmnNs9DwcfpWsx63JUxk7ecadRS1H8BCyixO9dVM
Message-ID: <CA+NMeC9wz08GtvBv6B8Uma2suKQDi8okr_VZt7hDZ5shmX_8Yw@mail.gmail.com>
Subject: Re: [PATCH net 1/4] net/sched: act_api: budget all shared attributes
 in notify skbs
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, pctammela@mojatatu.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:45=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Aug 24, 2026 at 12:39:00PM -0300, Victor Nogueira wrote:
> > tcf_action_shared_attrs_size() is supposed to return an upper bound on =
the
> > netlink attributes every action dump emits outside of TCA_ACT_OPTIONS, =
so
> > that tcf_add_notify_msg(), tcf_del_notify_msg() and friends can allocat=
e
> > an skb large enough for the reply.  It has fallen behind the dump path =
and
> > is now an underestimate for every single action.
> >
> > Attributes, such as, TCA_ACT_IN_HW_COUNT and TCA_STATS_BASIC_HW are
> > emitted unconditionally and never accounted for. TCA_STATS_PKT64,
> > TCA_ACT_USED_HW_STATS, TCA_STATS_RATE_EST, TCA_STATS_RATE_EST64 require
> > specific conditions, but are also not accounted for.
> >
> > Fix the issue by budgeting all of them so that we have a legitimate
> > upper bound. Even tough for of them require specific conditions, they
> > are cheap so, to avoid overcomplicating, we opted to account for them
> > unconditionally as well to account for a real worst case scenario.
> >
> > Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event mes=
sage size")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810164=
357.1653956-1-victor%40mojatatu.com
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> [...]
> Hi Victor,
>
> As you are no doubt aware there is an AI-generated review
> of this patchset available at
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.414364=
2-1-victor%40mojatatu.com
>
> And while I trust you will look over it, I did feel the following issue
> was worth raising here for you to comment on.
>
> I do see that it doesn't strictly effect this patch. But at the same time=
,
> perhaps it ought to be fixed, either as part of this patch or as a
> follow-up.
>
> Text of the AI-generated review:
>
>   This isn't a bug introduced by this patch, the TCA_ACT_STATS line is
>   unchanged, but while the surrounding terms are being made exact, should=
 this
>   container use nla_total_size_64bit(0)?
>
>   It is opened through nla_put_64bit():
>
>   net/sched/act_api.c:tcf_action_copy_stats() {
>                 err =3D gnet_stats_start_copy(skb, TCA_ACT_STATS,
>                                             &p->tcfa_lock, &d, TCA_ACT_PA=
D);
>   }
>
>   which reaches gnet_stats_start_copy_compat() -> gnet_stats_copy(d, type=
,
>   NULL, 0, padattr), and on !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS a 4-b=
yte
>   TCA_ACT_PAD attribute can precede the nest.  gen_stats.c even fixes up
>   d->tail for exactly that case:
>
>   net/core/gen_stats.c:gnet_stats_start_copy_compat() {
>                 int ret =3D gnet_stats_copy(d, type, NULL, 0, padattr);
>                 /* The initial attribute added in gnet_stats_copy() may b=
e
>                  * preceded by a padding attribute, ...
>                  */
>                 if (ret =3D=3D 0 && d->tail->nla_type =3D=3D padattr)
>   }
>
>   No overrun follows from this today: TCA_ACT_KIND is budgeted
>   nla_total_size(IFNAMSIZ) =3D 20 bytes while the longest registered in-t=
ree
>   kind is "tunnel_key", emitted as 16, so every action carries at least 4=
 bytes
>   of slack that absorbs the missing pad.  It is only the term-by-term upp=
er
>   bound property that is lost.

Hi Simon,

Since this doesn't look like it causes any problems today, I think we
should, in the spirit of what Paolo suggested on patch 4, send this as
a net-next patch later.
WDYT?

cheers,
Victor
