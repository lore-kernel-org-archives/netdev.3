Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0193E5A20
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361479; cv=pass; b=Dr7ZPiD47V7JZmHPQk8TzkyjHIaElVkxBD6e4wys2LDmrjti3H2YRdkedu9HYhvc3Z1GCp+jICsqkYh+lRGZ+REugvIlXQXmeGzajldb5Q6QfnYwQPgMdFLu7+lhS4BgQrTluu+tobBzxeqU9gmENzpBbOb1bm50OnJQ1TA0sZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361479; c=relaxed/simple;
	bh=cwHaI0+qe1vW5l3HCQ1yhCG418FCdcAVBmgF5qvOkbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHqiNyg90VgqAlHYb/LptYTIx2BPLLP5C05fnnQ2HncZPcIbUZIMh0rgKrAGHSsROgx1fi9iwKFrHQIn29GVUVZjBYva9Y1yLAlbRR2txQU6u8/uDttkmsrdVPKKNKWkNmXSjfT6sW5i88WYtKsW0ZVlAu6TAa1LMaXZsmR5NyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ob/zIgja; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ob/zIgja"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a0678c489aso133068b3a.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792361477; cv=none;
        d=google.com; s=arc-20260327;
        b=KSo6H7dXySHlSzlDkpVb2+QfMqzuB4xC5kBmJiFWSJ2O6Zazl+/bZ6LT3kEMAp9iVa
         yOZCn0zoFgPpzzVaGrNlDO+i4B2pRieVVn0gM0TgmCT0jtb9WCRCnO7/Sf8cyptEmtWz
         UyZ87UBDkRX84+PxWpZ32fo1IxIJiG1JjETItG5LBi7fJfYLmrzLQE+nqE4EWJmgZkov
         tC2Ui01E2JAOyKNRXFQR+7ePkuOSMCbkhpU1ted5RWEp+F8lrBYSRf8MNklL2Fg86Ab+
         gJfQB0CyuI16n8hTdxWdqx8ROE4hRXB5AMRe/ypwEmVGNRNjJ/kzt+mjEshIsFCB1bya
         /D6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OoemeGpHEs/RQ85AUjiFb21jtyRu1UrD2oNceOXKc5M=;
        fh=EakCbeaeMZaLWc73hRXASTYkVnV4XJfkDESzIjyhDYY=;
        b=iLyQ478yCbyil1yHCYzAdsQfDRPJRrHxmp/fxmycRqzlH/zoGno+XlSy0O7wfykpO1
         TygBdnJ/HHL5gwB3g3iMe+wzN32ZXesXcUP+IoGo2YaVX/+MF+qLv66UMxtSLD9aLxuD
         JGXtjkR62DfsNyU009c3pcmw6+EbUlsMWMfQeOHU/YvckLAB+tt3xYEq+5uoShLUwKH/
         qK7VSJOYcZAEnnFliWoDtrlXAASS0lz45IIwdTOCyF/CM8xHEWSekQfRhYj+DP9if2/q
         /AjEz0UPGHMfygKKI/1122es26y7yunq/WNnTiUHykg1onurTuMPMB/5n2SXfH8sJyGg
         8odQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792361477; x=1792966277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OoemeGpHEs/RQ85AUjiFb21jtyRu1UrD2oNceOXKc5M=;
        b=ob/zIgja/dt670Nqu/zZklydS23wD8F+846eOU604YJUilN5gMdZR968etSCgV7K1F
         5NPuKix841BYxv3gxvn0z8SB16AQpfTGgXJ+nD2Xrf01TSs6ZiHPuPc6GbTfdK0dqrHH
         FU+xnrFP8qKWHmqH3FylLEidxgBfDj4e3R0UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361477; x=1792966277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OoemeGpHEs/RQ85AUjiFb21jtyRu1UrD2oNceOXKc5M=;
        b=R/pfYLW2baBZEE3FvzHDjeV48is088ete0IXB8YBvyxRMs5G1QiRJQ7+amydZflEKw
         tLigmCgh1bYv1sDqCaT1EQlEwQ+uvth3oMWlOPXtSjVTA0yETC4EPouXS1gLYQkWFqRl
         ZDFAhqt1omj3a6Woa3DZzG1e6dVm0QI1Urmpzo4qBqSoL27ye4WVU+Xa6e8rG0tv6Y7k
         opPpewwGuO2PeuS6P2AVglXkH2f4eaikBFB08VttwPsG43j0bq6B/qpHLE1w0ql6QEqL
         CHPq2SaVbR+BKf6+I7XzKrJjkWcUmnwwSzxJdd1ZbK/072b+JyAK+dMCneB/KJ/KTSHv
         M4nw==
X-Gm-Message-State: AFq9FYKurLCwfVd44Jtm8uw4E8Fy/oI2V/UPwjtGUdtthNk4IyXNROFL
	n/3HPomRaa0nb6JdZ6F4je8Ql88URL2RYXBMEqHVTmqcKk8bXm8jOTsUa2efr7foTYKcvzvLipA
	VYe329W7RsRpNWoSoXNVonEtXzOr24pxT4A0iNiz1
X-Gm-Gg: AYBFou1rMSDQFuXMptMtScMDKMkiMZdv34cQCoEvnMAPp7Y6slrHpbA5hOFJ0Tcpi+n
	bmg7/TMQ39iM3TmfB1Ec+HDjtbUnJge3a8ghY6fdKfBMUlAxMqWCQq+/hjMoAvL+SShyuEdIRuj
	otVcV7atuHemt93ZtuUx7eyXJrnFYzxNwBxC0v2RdKM32mTUrlMD1XJo2dyyXLOkZSZyoLTXA0e
	38Brm3rvyI0Dq+8sW4SzkB9+5F7kkJ+L9GOTxbRAo6jBro+cVirQ6HA0jd3InAIdSSD6s+ARbYG
	WXjlTzHT4TVUbbJ8ixo2p9+0VcLRK1GXbZESXpgd2qvp7MPNEx7BHUSxGA+1fFbGFzkIHyz3WpF
	WkeVvIfHIATB+mJ92p30nN0F+aSuoIccHsrtuOhKHX8Pl
X-Received: by 2002:aa7:88c7:0:b0:891:6aeb:84fc with SMTP id
 d2e1a72fcca58-8a04be250efmr4714279b3a.22.1792361477433; Sun, 18 Oct 2026
 15:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v6.r0.20261014054826-1@mojatatu.com> <179231932829.3135.5746553688919070963@kernel.org>
In-Reply-To: <179231932829.3135.5746553688919070963@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 18 Oct 2026 18:11:05 -0400
X-Gm-Features: AclHuK96JPZ0ZkfktkoWdZZd6RY8fz-we85yT59ylQYRqFyC7qTVJUuMzufPsfs
Message-ID: <CAM0EoM=6ayQJaWJdZG2AjTQ_Lu2DKvn=-JLdHAFaQi=j1KvN=A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/4] net/sched: cake, fq_codel: return the
 classifier result to the caller
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	victor@mojatatu.com, toke@toke.dk, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 6:28=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The new comment above fq_codel_classify() in
>   net/sched/sch_fq_codel.c gives two reasons the function returns true=E2=
=80=A6
>

I will not be updating this unless something sgnificant that needs
fixing shows up.

cheers,
jamal
> --
>
> net/sched: cake, fq_codel: return the classifier result to the caller
>
> This patch changes the classifier helpers in cake and fq_codel so they no
> longer compute the flow hash. The cake helper now returns the filter's
> flow/host overrides. The fq_codel helper now returns either a 1-based flo=
w
> index or a request to hash, so the caller picks the flow. It is preparati=
on
> for later accounting changes, and classification behaviour should stay th=
e
> same.
>
> > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > index e6c87a32950f9..4cf3d379b8e95 100644
> > --- a/net/sched/sch_fq_codel.c
> > +++ b/net/sched/sch_fq_codel.c
> > @@ -73,22 +73,35 @@ static unsigned int fq_codel_hash(const struct fq_c=
odel_sched_data *q,
> >       return reciprocal_scale(skb_get_hash(skb), q->flows_cnt);
> >  }
> >
> > -static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdis=
c *sch,
> > -                                   int *qerr)
> > +/* Run the qdisc's optional external classifier. Returns true when the
> > + * caller must drop the packet (a terminal TC action consumed it, or t=
he
> > + * result carried no class ID); the reason is then in *qerr. Otherwise=
 *idx
> > + * is the 1-based flow index, or *do_hash asks the caller to use
> > + * fq_codel_hash().
> > + */
>
> [Severity: Low]
> This isn't a bug, but the comment above fq_codel_classify() lists only tw=
o
> cases where it returns true. The code returns true in two more cases.
>
> First, if no filter in the chain matches, tcf_classify_qdisc() returns a
> negative value. The if (result >=3D 0) block is skipped and the function =
hits
> the final return true.
>
> Second, a filter can return a class ID whose minor is above q->flows_cnt.
> One example is classid 1:2000 with the default 1024 flows. That fails thi=
s
> check and also falls through to return true:
>
>         if (TC_H_MIN(res.classid) > 0 &&
>             TC_H_MIN(res.classid) <=3D q->flows_cnt) {
>
> Neither case is a terminal action, and the second one does carry a class
> ID. The behaviour matches the old helper, which returned 0 in both cases.
> Only the new comment is incomplete.
>
> The commit message says follow-up accounting patches build on this helper=
.
> Could the comment say that true is returned whenever no valid class in
> 1..flows_cnt was selected (no match, minor 0, or minor above flows_cnt)?
> Otherwise a reader may assume these packets fall back to hashing, as they
> do in cake_tcf_classify(), when fq_codel drops them as BYPASS drops.
>
> > +static bool fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
> > +                           unsigned int *idx, bool *do_hash, int *qerr=
)
> >  {
>
> [ ... ]
>
> > -             if (TC_H_MIN(res.classid) <=3D q->flows_cnt)
> > -                     return TC_H_MIN(res.classid);
> > +             if (TC_H_MIN(res.classid) > 0 &&
> > +                 TC_H_MIN(res.classid) <=3D q->flows_cnt) {
> > +                     *idx =3D TC_H_MIN(res.classid);
> > +                     return false;
> > +             }
> >       }
> > -     return 0;
> > +     return true;
> >  }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-BA27.v6.r0.20261014054826%40mojatatu.com
