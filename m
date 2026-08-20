Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4643E08F
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229699; cv=pass; b=DNtcG8eWgz2Ou5SlhwMXZmnaue8287KvAThMFYqG/trYJ4rlAYfhP4f9mkeN0RT+xx2WNIFj/aVMb9YF3JApqhBgKuL/EE22STTiQ5lqu/zSJOJow4/94gImy67zFw1Qq+6ZaXF6xuBwL/ru3St055S19WfdgRcTAHgSk2sRgXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229699; c=relaxed/simple;
	bh=pjEu49fJXCBZxcggrQ/SmLGHyVXfgvqpXDkL90EVyK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9CTF1nJkOXLeAqpdT7XlHoiMWZfEIkbNMxfmp36C+ahbR2JOgRfqh4qjLYQd21K1CxQZ6SFg1hHtBn7NJXB1VuvbsQQARB3eEexYeJ9Y6keHUSgmeDqEQiXiIi0ewSUCdH98QpRaLCelThoqXgXb/ns3IROn1Z6WgFkp7n2v7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=BA3sBpNk; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="BA3sBpNk"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e04df8c46so2053389b3a.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 05:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229696; cv=none;
        d=google.com; s=arc-20260327;
        b=dIHb/tll7VBM9YiklMQ3KM24KqZ0S7nORMKOgjty8dVrdZb3VXXHwjCW6Vv0TAYpBW
         Epc4S0vfOEqIWwek+2ue4p/KBs8mJ0FWAC21HTSMA2jT2WyFAD4PzZNEH/jCIGcyqFOz
         7p1ibEFxbslB6iU1NHZ8NW4HtcUL0gzmf2HoRjP63EBSE6Z/324Y4RdiwISxu2T2om/f
         RwGC3dJAhxgMPioEGq0nYLjgFukCwXYbwmFVk5HpPfZNVTwGvPmx2X6ktLbTsbUg5bnh
         imhKpMeypOIVbaXSn4vdvhN4NpIJ2iVQJ096IIfEWSqlqh+sFtavMB0KBKKw37UIbDqM
         ZF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MN6K5LaS827qFsNfPJFjKO3bo+XxHFnIs992QmHH034=;
        fh=Mo4jABy+Qqpu3ugugQfCi9Eaac8e5YZFLy7xCFbdG2c=;
        b=MMO+iZjdEL8QBKI1k6DizXhx2ccvsCGhmj6es24bkIZASjSTegMAKtOu56y7/zDga6
         hbL3noH+OxR6YRX6Qebfpi2bLcITAJf1z5IFR3wt6cKxnlJ6EVKOfFcu/ihM3V4+R8RA
         6q7n0ZoD32X4hcRGlJc5ATjbDPCgCvtDFUtG31Rwc3phUyaey4R3snmWgSLBzZsAiWpM
         bfzcBuLLP2RtJ/Q4T9mPOHRxlmXkukFoCECHgr3czPE+8JBGqBVhSO8pRiBUEGbheLcr
         2ASUqPB4C7FKVWIP070G5vR5bjj4ogWHWXVeSeFfCpS2jI1hy0yHw9NzeflRpc7X1art
         d05g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787229696; x=1787834496; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MN6K5LaS827qFsNfPJFjKO3bo+XxHFnIs992QmHH034=;
        b=BA3sBpNka40QsYyu3w07kJBwDBIn/gcF8mrc38wlPCC39U1hBoA9qqZBXxrm1nWt+l
         15qDPltAxHw/z6NTXOb7ImIl61vf/zhsQWd/UIJBaPPRBAXsSt+9UHlxvev9+k+09Owh
         VV30z2AjFBMwMERNsk2br3Curkwtts56wPgWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229696; x=1787834496;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MN6K5LaS827qFsNfPJFjKO3bo+XxHFnIs992QmHH034=;
        b=oWzoUoWET4KKrs1QTJ7fezHYdSQZ8BaqWWjRYLRdFbGv39LmG53TgjJ2E/NZK56cMA
         tnD/PuYHP8c5+rer8B9P1SPm3Up/4tTpfq/7xOGDaIbl4JldkHngrVUZAM4WohOocDaT
         NkL03CDuGvU5xxiTVRTLHfyFQWSfwYxsfLzXdY/n93e1jBCHaWRytKcb5gasM+/LUJNo
         Bf3M8af0k4Wq9sM1CwWBLZnU4BzDIG8Gf+PpW+u75r9odQ5NmwllGPFyFS19mGbnh+ky
         NCG6dPE0GQ/rCWrMqLxxIaKNcn5iPOcgxbIluznBRhwwRVL8l2QXpv4qSlsmT+pRYb8b
         OzXw==
X-Gm-Message-State: AOJu0YwmBcCfSwCvY+NNCqHyfEjlq9lTiv3McSFdEACRmSZOjSimhtFQ
	nrkuzpnlIggUX7UBV0fNUsPVxPQGyWQRXb9gRlpJqH3K2BzGGrhH4sic/lxbs7j20k9p4zzUQUu
	j3ghpLcQmQu5/0JRJQrfHrPfIwuDx5X1gyaYYPsFZ
X-Gm-Gg: AR+sD13GMjqBvHTi2uzXHka115l1yMra1gjt+8aLzznmPmXLe8624/zltmlJEeElJOO
	s2MOiFQ0OU2Ytt8wS3kgG+UuKA9LpgnUFe/JF9QFALKqZprCcpa8DbD+m7GW8QT+LOLp/xc6Kl3
	LtNmsamzAnKTdam8+sc3U6DyECA0ClVZod/+P+jf9f9qd6EZAEVyKahWU95+w8H2dp2T/0L4ArQ
	ZBVn1t3CAkNk+M8y3PM5aPHhqNRZw2MNie1MelA/5d9YtpmiiyCYwy+c9hOqW/N7s0x5YBcGuUc
	WDqFnYFBEiRbi5ZzGw2h3IcXNj8eIyunL6HALHiN2tZbL375pqC2lUoh
X-Received: by 2002:a05:6a00:6ca2:b0:848:8715:c2d9 with SMTP id
 d2e1a72fcca58-851d383142dmr22125250b3a.2.1787229696568; Thu, 20 Aug 2026
 05:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819204210.23722-1-fw@strlen.de> <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
 <aoboL020DIcOn2lx@strlen.de> <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>
 <aobuk1osK-Lq-aMk@strlen.de>
In-Reply-To: <aobuk1osK-Lq-aMk@strlen.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 08:41:24 -0400
X-Gm-Features: AcwNN1UpFvYrcQTitibXq00qJxEsxIdVdGcrG3kY2OUmcWMPjFUT_iyVnlqIEA0
Message-ID: <CAM0EoMm8G9FaZZfctYKsm4Rkd3RVmVxkWMp6zJ1Gbxge5hdp0A@mail.gmail.com>
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Content-Type: multipart/mixed; boundary="000000000000326193065979d767"

--000000000000326193065979d767
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:09=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > Example: If the ebpf one could be reproduced with unshare -urn would
> > it have been fine to make the fix sit in netfilter?
>
> I don't know how to 'fix netfilter'.  We would have to remove skb->nfct
> and re-parse at every turn.  Is that a viable option...? Don't think so.
>
> > > And that doesn't solve BPF (can sit anywhere) or OVS (no idea here if
> > > its affected or not).
> >
> > OVS is very likely affected.
> > I saw your other email and you are the expert, but I am itchy to try
> > the nf_confirm() approach.
> > At minimal it should fix the PoC imo.
>
> As I said, I don't see any existing function that could be used
> to add the required re-validation.  nf_confirm() is the last step
> in the pipeline, its way too late.

Sigh - couldnt help myself. Attached  fixes the poc from kyle - i know
you are hinting there are other scenarios where it wont work.


>  nf_conntrack_in() doesn't work
> either because you can install matches earlier than that, e.g. via
> -t raw -m conntrack in classic iptables, or via 'hook prerouting
> type filter priority -2147483647' or something like that in
> nftables.
>
> The only other option is playing whack-a-mole, accepting the original
> proposed patch for nft_ct, but I can already tell this will not be
> enough and revalidation will have to be added everywhere.

whack-a-mole is what i was worrying about. Someone will come up with a
scenario for ebpf and likely ovs and you will have to fix multiple
spots until the next one.

cheers,
jamal

--000000000000326193065979d767
Content-Type: application/octet-stream; name="nf-confirm.patchlet"
Content-Disposition: attachment; filename="nf-confirm.patchlet"
Content-Transfer-Encoding: base64
Content-ID: <f_mt1ie8sa0>
X-Attachment-Id: f_mt1ie8sa0

ZGlmZiAtLWdpdCBhL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX3Byb3RvLmMgYi9uZXQvbmV0
ZmlsdGVyL25mX2Nvbm50cmFja19wcm90by5jCmluZGV4IDdhNDBlNGUwZTMzZS4uMzAyYjRhYTkw
NzNlIDEwMDY0NAotLS0gYS9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90by5jCisrKyBi
L25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX3Byb3RvLmMKQEAgLTE1MSw2ICsxNTEsMjIgQEAg
dW5zaWduZWQgaW50IG5mX2NvbmZpcm0odm9pZCAqcHJpdiwKIAlpZiAoIWN0IHx8IGluX3ZyZl9w
b3N0cm91dGluZyhzdGF0ZSkpCiAJCXJldHVybiBORl9BQ0NFUFQ7CiAKKwlzd2l0Y2ggKG5mX2N0
X2wzbnVtKGN0KSkgeworCWNhc2UgTkZQUk9UT19JUFY0OgorCQlwbnVtID0gaXBfaGRyKHNrYikt
PnByb3RvY29sOworCQlicmVhazsKKwljYXNlIE5GUFJPVE9fSVBWNjoKKwkJcG51bSA9IGlwdjZf
aGRyKHNrYiktPm5leHRoZHI7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXBudW0gPSBuZl9jdF9w
cm90b251bShjdCk7CisJCWJyZWFrOworCX0KKwlpZiAocG51bSAhPSBuZl9jdF9wcm90b251bShj
dCkpIHsKKwkJbmZfcmVzZXRfY3Qoc2tiKTsKKwkJcmV0dXJuIE5GX0FDQ0VQVDsKKwl9CisKIAlo
ZWxwID0gbmZjdF9oZWxwKGN0KTsKIAogCXNlcWFkal9uZWVkZWQgPSB0ZXN0X2JpdChJUFNfU0VR
X0FESlVTVF9CSVQsICZjdC0+c3RhdHVzKSAmJiAhbmZfaXNfbG9vcGJhY2tfcGFja2V0KHNrYik7
Cg==
--000000000000326193065979d767--
