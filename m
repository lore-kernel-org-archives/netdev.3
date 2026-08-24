Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1515A85A
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575064; cv=pass; b=RFHbuz8R+f2CfQWCWAYRBTMY9RaSb2dfMd8xkwag4F6gDjH+vz2e/YXXY4EK1ixF7NJKdilviodmTxWj5K0l8Fc9P8vlB76RzuQ5nneoDu4x33/cDK6lHRlPLQ8EI+L1156SRzfzURa6yQryqNJ71TTlz1MmQCqRPWFiJzyLRks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575064; c=relaxed/simple;
	bh=AFPMXYM952CeZn+6Ksl36QVco5ORZ9O5pGTpwuoCQ8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj8/O44npIvK9KXs08kR3/BgzK6eBsXm2YKhZKY47civPoczd85pRGhX81MZ3MfORFih8wiTntY43+GWWIQS0QcTGeCIC8qB3SOvn6ePfPWf3ZNsHjQfMhvwByFy/0/nRUIW1/3sGGzPc67OuOvt8eofVk+CksE8pZUioIJt1/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=q490xa/o; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="q490xa/o"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84864086bfeso1025675b3a.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787575062; cv=none;
        d=google.com; s=arc-20260327;
        b=g4W8VE7LLTud411tHmDTA5UpD4AqckYYC9hKMgwRnnWe6cAApGIbLzdKZCvTQfjk/S
         Zn0iBeFD718XRS++c8yLtWAd6bdkX0rFV9pKPnQdsH5lPN7UcEv68Jzm0ExDtzUUYB6p
         Gy5B9b9VQ/YZk/rbqe8Kue40MDgTXHCHb8kn8akD24TF3EAQ1MGnOEjbMNKJDiyqqEGM
         KWkct5VqZuMvL7gGBLN6WgRd4Bj/5tAwmsyIxO0Q4KX490iMaC8r4iPxOWBGJDSo37IK
         JK0uxbUGzc/+i/VfOq5EKkNqeDVQUDb4G4P6kzl+ct7BeYmX45IG71pNPPK2F8AVphNl
         lwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W+zQW6HBQa1lN1ja3xskW7ThxwtJGSF8B4qtZOtAofw=;
        fh=4N5FssHd/Gfyz1e29NYp9PS4UyorIoqzPqGhCOG7doY=;
        b=TS82bHwVvYG039K5T5d59ZYYz/JSRa5DU7fuUS/pOVEh1/QUxQjkQ1dSJQ9ThkVohC
         wENrgoOkM1c9aCg67lqUlfKY+oxeL+GNhOOKqY+/79taM1BckvbojhR8JXWisGRSo64F
         159ao1WrJSF+JNfRAKWjSg+AJ1U0JfhV90SAlzbzhYAjwTR+iuuRJP/TgOsIVfpQLni9
         BrqHE338p4l2XT4akSI1RKnghh67LABroHnKcCG1sAhp2QcnozppeZKGYFbz+VAAMrCB
         VyNTJ+vgzF+7L7Q/DzQAYnOaPJrS9ViaUKCPXRDCJ+1ZuDm+Y0HQE2K4XXnXSK5tIM0c
         Bcvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787575062; x=1788179862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W+zQW6HBQa1lN1ja3xskW7ThxwtJGSF8B4qtZOtAofw=;
        b=q490xa/o3ZB7pnEmNVEGqKuLPnH61YtL/mi5ngA5404lHPWNdT74hWYiLtiFqeqT4l
         QQL4+FWB2Xw+Y3QUpXTNHdTxUcsvP5sycWcDa6cbnNef1u5kHZxRfNxuiwS2en7bchqN
         Z+y2i8bMWC/xY8VluHvdwJ9Of0WuLpehpX9wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575062; x=1788179862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+zQW6HBQa1lN1ja3xskW7ThxwtJGSF8B4qtZOtAofw=;
        b=nbFPV6mEMXBKI6U1DtBKiB/ODVBXQaDJTrGHqIkz86D7JfQHGxb/3D+Xb+XSpnt50s
         B73MZi4jUXr5IDhH7kiRlzW/Z+LAIdPJWJG3cXtFFcq5TKZKpb44iya8yfMuzgKOr/M2
         2XXqEH0HcsHCkLjHwVcVQbYxSFahXoqNXTVeNwRNAyv/mEHilW8acMBTfSpTrm1+KZUA
         ItARjg2yxNygxrmkpPfpVm133kT+UW5li7/DYYXRhGG5lrxB675Uc7imFK4cA2ZTgEn1
         BBfzog4nkTlqNOBi+QIKjhFDBn7Nb9cogFe+YPE7spbGVuVF3i4vwD2R2QP9trYkgnyf
         jYTA==
X-Gm-Message-State: AFuF++mRusXqFvVSeISdCWslDSoW4ovHh9lweNfc6MeGcC4vnMMcx/Fi
	7Qzmyr4mE3u11gL5twXe8h8GEyd8dmcTFbJbQviwBJA9XygpScXJnCXDS5gFT5xsHIKFo6Wc9UT
	YlfJWoLvB8xunWydoM8tLdEm5fMKfOi5SQUI4/Oog
X-Gm-Gg: AR+sD13fCvvKl/QI8V/KFrN5+CNy/V6/29paNd8mnhHDc4zMJuDcwlLu2v/ygg+LPI7
	4LC1twklGYZ400/Rg6cE4HVmH6MQaeIln4aB1hdB7IkIVdGyhHDlF5wmf2pD3b3wTH0Mdy81A8H
	gXH4g7RzAqyIZZ6ps7paZkUyIqmrDtjea/u10DQM6P3WLuYBYradH3fnPevsuPqHai/y7Ovjp9J
	1cfWkLnH0tC49wPwR/vwXLlqgSXSOYIE4cLa8Wo7PRblmSPO57NqmW1pmpLI8p5FW8AIzuEYNXc
	mto9RutBzjO5m7EoJNk4tzHe/j0lpgFuZfIgyW3aug==
X-Received: by 2002:a05:6a00:139d:b0:852:38ff:b4b6 with SMTP id
 d2e1a72fcca58-85239000a70mr1261001b3a.17.1787575062221; Mon, 24 Aug 2026
 05:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095742.68511-1-jhs@mojatatu.com> <20260822134401.6545e4eb@kernel.org>
 <CAM0EoMnLnc2dtzRyaJs+V6Niq=39OQ=p-XC7M+FMTQ0ctSvmyw@mail.gmail.com> <20260822160234.7115ccdc@kernel.org>
In-Reply-To: <20260822160234.7115ccdc@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 24 Aug 2026 08:37:30 -0400
X-Gm-Features: AcwNN1WFd__tN3SEBdmdHGbGryvUOqmS9T3vj_hnC4iwPbQb1gXTPHuTvm9wapk
Message-ID: <CAM0EoMm0orPkSuMLrpGMNkUATjmBPCvqWmKMEPQoYuYAEvCAQg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and account
 to memcg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 7:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 22 Aug 2026 18:14:49 -0400 Jamal Hadi Salim wrote:
> > > On Thu, 20 Aug 2026 05:57:41 -0400 Jamal Hadi Salim wrote:
> > > > +     if (qlen > 65535) {
> > > > +             pr_warn_ratelimited("pfifo_fast: capping ring size %u=
 to 65535 for dev %s\n",
> > > > +                                 qlen, qdisc_dev(qdisc)->name);
> > > > +             qlen =3D 65535;
> > > > +     }
> > >
> > > Why not a hard cap?
> >
> > sorry, where to put the hard cap and what would it be?
> > Or maybe you misspoke and intended to say "why put a hardcap"?
> >
> > Or maybe in this case probably safer to just reject the change if > har=
d cap?
>
> The latter, I'm asking why not:
>
> if (qlen > 64k)
>         return -EINVAL;
>
> To be clear I didn't dig into the code, just read the commit msg, so
> maybe you have a reason. But the "normal behavior" for out of range
> params should be to return an error rather than silently clamp() into
> the allowed range?

No real concreate reason other than the thought that it's a device
param as opposed to a pfifo one.

I am going to send a v2. Will switch to similar to what virtio does:

  if (qlen > S16) {
      //extack here
      return -E2BIG;
  }

The followup as identified by sashikos is on tun/tap - i have a rough
patch, untested but there are others ahead of that i need to send out
first.

cheers,
jamal
