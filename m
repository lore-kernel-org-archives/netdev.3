Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6812DC32E
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316054; cv=pass; b=qVfOYDbIKL9NrNWXPwVQKK/P4Quy6UqxPD6Qddo3P2twiUYhKIDajiFcHSCz0qOe6cIQGnHFb424k/ZNFjO9Uhsrzvd2zyu1L2NAo8SyyoPduhAsdySKPovD71YiTpAcAIa49b8BR5HEVyvbVmbPvYxEz/EffNRgWb/PvHmcz+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316054; c=relaxed/simple;
	bh=WY0uPjx1UWjenmuOs1RapjNHNNFmYpTvN3dcjrhXK3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryVFwvAp1Ot89+NVzChxSfDavdDVVU7Yeas53o2QyN3bK1NwRzqOOWrHpsRyzIz1SG40coMfunEso0dB7XiQxHranCQvMCtve50aFoOe7Ls+Vim/3wVgJfA5QY0ilZx+XUmR9ThD8EC6g9s6SU4IpkjhYtTuA1LRYupN572B9Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=qy8ZZVaD; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="qy8ZZVaD"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso909899b3a.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 05:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787316052; cv=none;
        d=google.com; s=arc-20260327;
        b=aNX2+aVLkC5FHaihLbGZjBPCLjIfMA/6zHTcBsR+eSBQAFkoLqJcIeftOQHQGrNIvv
         1cY1obcWYPENjCYmEUy/btGebYBOkbTNbLfwljj5qyTA5n4jmakqNfwmu7/BkjWc++6C
         lM5zM9vzF+II4ilUuZq7hi6p0An5vYf6oBMv5gfuEyvrsmEHM+XfYgqT/l4Osxb9k4WK
         imt5whwYfIwr1Fe8IqVooq+pCSD4zuS7l06H1xaYScbVMiBAlVNEIgubajaP/OsyEuj5
         HywaM6nPkTKCDdnF7TJ7Kzb1RodcfYJWu+D+DtQqwsXR9yb3GWNSO3NC+SRHA0ufJeR1
         p8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WY0uPjx1UWjenmuOs1RapjNHNNFmYpTvN3dcjrhXK3M=;
        fh=M7oqS4dhWck/l2Fu3NRPAuwjyyua/Nnn2TtGiZ7CsYo=;
        b=QDGrG+zHXzFW4m++2sdTnnKnuDW18RFpxbodUOWXZbcCT/RkDBs18tzv6++bR6oz0z
         ei0pxL25RmTx4mLnOp2Mdve7T+aPsorn8Gwh+isF2u1Kg+JqN2QGdkCivBdZqeNKAfK7
         TdY4yHQhBOrNUOhPB2Vu27REikI9uZml3hOWw8zTHQphs8aW7rFQ7gM59V3vyI3aceyi
         abSzTjFzn3HnBsKx+EshwYRpCxXWcGQxoN5jZhV6Nuj1sfvTW6F5sM9B2/WZhwt+WH0C
         ExV3y0oD0YZLxLlB1ZRRbrehRGDFK38zee3ATKr4deSoU8cHteBKtfYlXsmMfZ5dNORu
         r4iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787316052; x=1787920852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WY0uPjx1UWjenmuOs1RapjNHNNFmYpTvN3dcjrhXK3M=;
        b=qy8ZZVaDcaA5/dBfO6ykA3iQVHmwZfNsWoXTZeXKrJtt4vFSRDpPvpZszz5Kydg+7Q
         V778QBlcW29W7PWm5Zmo4Zr+YMJzgbiFPgNgCib4GYioF35XE50TDMQKjPbVct3M94Dl
         pkLhSN7S8K1PAKZ7dh6dtbG2jtr+39A/dwYl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787316052; x=1787920852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WY0uPjx1UWjenmuOs1RapjNHNNFmYpTvN3dcjrhXK3M=;
        b=Lp/YxfATu45jcZiwXlNtOybb79qy7h8TXGe9tHYRNSbZagBXPibf8Gee3F+z0JSVSo
         hcmscSeZZ4yFYO/ujHmCrYxH+957IK+urVvhnPCc4DoZRVV5/dI2RQH4cL6OauL3Zcbu
         LxGZcE0656N8yTDajKpoiEl8EoI736LW0EI6u++s4uxRGEcXmsFm4EDXzLf8RFZRIkQ+
         qUjO1mjygzTCp/cnJZcF4QWnF+7C24u5lcK2k+AfXs0cqe5UyDue8Zg3tGTIbgx4xOuA
         Q1fvt8tHCm/3cb6EKvkboSvp81eEn4uDputtKFsjD3hbsK0aItOpiCtSD1ePWKcBhhIm
         KlbA==
X-Gm-Message-State: AFuF++kIXNPncDdv3loDd5uAWa3qaxDGJTOakiHEmNjtG6YOB4KG2QaX
	T3coioEMEq1VxmXftlRHrAd6DQRwjwpkPYocuCRiIZfqhP9sABlWvrMQz0rktkvZFwNdC4tM11c
	J4fF0bUGf/60lPJNosQMkTwTaLKPzf/LRC9/52PbZ
X-Gm-Gg: AR+sD13Us18U5fOb+avNuot3Uxu36/sE2eMQid4moLB9Kf6q7ibVL4Pl8Z4zZGDlbvO
	tvVUHYprFLWjd0DAsnVLWcvEHgVf4dHA8UBiMeGgXn/N4d1Jcy28o333G45YFKlU/shea8M7Xkq
	ajtVdRR4I803bZrP3kpgyeKBk5C6Mwz1L4cjfnnSZsA7dEiMCR9mFDd6RmcUq5FDcs7m7W95L7w
	T5oi1uOyADpXq5tHipAhQeY96P19OHDQM1qzIClllseiwd036MjzDMNPJyUVd4wV9m450CLk2zK
	BweFea82D/RMJUBfcxZXWDSpDio0zObbLw3sde/DwIdMj81j27oQ
X-Received: by 2002:a05:6a00:2394:b0:845:dbdc:8652 with SMTP id
 d2e1a72fcca58-851f9a295d8mr9588657b3a.2.1787316052165; Fri, 21 Aug 2026
 05:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
 <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
 <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com>
 <CAM0EoM=6C=yarfbjtegiobdK9jvLzLwJSSMxFBYDiG6XtZQ35w@mail.gmail.com>
 <CANn89iLD-c930HoW0tf+A3c+5ANHv7iRzy0wFt-HqNFswtee9g@mail.gmail.com> <CAM0EoM=dvzBUxeXVGw83uqqe0Kp0y-6e33hiJ0u1R=KNn9-qAg@mail.gmail.com>
In-Reply-To: <CAM0EoM=dvzBUxeXVGw83uqqe0Kp0y-6e33hiJ0u1R=KNn9-qAg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 21 Aug 2026 08:40:40 -0400
X-Gm-Features: AcwNN1Xq-xdldO-PU2Uv6LCy2b6HZO5pjL2hlQ64C15yBGx5SLzPN8JNIi8EHk8
Message-ID: <CAM0EoMmXh3buZiPrb15A034Nc48ucwjPz75N2viYr1b8QmjfwQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 3:44=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 12:01=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Aug 19, 2026 at 5:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > Ok. So one patch per file?
> >
> > I would have done that, but you are the net/sched maintainer, I will
> > certainly respect your choice :)
>
> No worries - lets hear from the esteemed sashikos, if they complain i
> will resend with separate patches.

Ok, given Sashiko's complaints (some of it legit) - i am going to send a v3=
.
And lets see if i get this patchwork instruction correctly:

--
pw-bot:cr


cheers,
jamal
