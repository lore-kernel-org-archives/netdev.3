Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6573A59A8
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352113; cv=pass; b=ZEQEYIqurRC5pSAKgNpS1AqMZC3pPCXVPUUdlehV2EYHYJxHXzE4C28mZzMfUUqkogDxhthydBhbfcdj5ruRij798LQ9JrqrJ6CFUKGBX1pR2z2bXdEy90UiPV7Xn4u8NoOEdThumuC49Vgy850whfaG9Gn5yI6OVgfKXRkikvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352113; c=relaxed/simple;
	bh=tDOXiVg0+h1h6bIO200hP40p0eMZwTt7k6rDajhWCvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akyzAH/4R5OnMtabfX4DRykhbcmq4pFR+mWG+/aj6fz20tyM87iRF9Fmqi8vS2eqG/WLyxDA4XTld91av1dJn2H6PNaV7gYZzWwODLdqO52u69uVYnGg2da4RFU7TWKMUZ5w9zUp9Hzo6AcTrWzJ9Qxv8cjESn6yGObibJNR+x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QenO65i1; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QenO65i1"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8efec2c28f8so9357116d6.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 01:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786352110; cv=none;
        d=google.com; s=arc-20260327;
        b=kpxGwE2n19IbAzvyi+g9vH4TNWmiBnCBWX40ns2sXbs8fc9dth5TRvAA29NDCJ5smz
         I6RMpLTrU+zF43w5U7wpqpBoJsbFYafzTCRuQHbjXUPThPpLYUtiMJrV1LNFtmVcuxL6
         dQO/8h3yjQgBXuwqQbCCTLReFTG3P9B++ar8g4nEuv2OKlL73K6Dhj7htz3+dWWkx24L
         agf6c7ytzvOlatAwKKkeNO7aKfZzNH0a4/tBU0Eb/g2ZBQFWjH+opVb1vOjfquoGN1s0
         VOfFNShx7hqiDrrpqd2H3egwgx0vO0AoXHXNdvmxCvhyeC1Cc0SJPVwMERmM8hpUjW0U
         WTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tDOXiVg0+h1h6bIO200hP40p0eMZwTt7k6rDajhWCvM=;
        fh=HB5Aq1fvgQ2lFLhm3VAYhjRMYiL9iJjmWnVa+qyj33Y=;
        b=lzNfNKEN/Jz72MF6rDJqyd0ivgQZU8CmMZV8KgCxvDdlmnJymUym2Ik0A+KNBDuRSF
         x7DqFCTqKmuTGazQgKHX8lsZ0YJj2bPUxrgyhzFAmxs7EaEEEmlarPrAo67GG05l1+3/
         Iht6Wh/lOtGgCuuk7MGavyE4YaAXtwqWwaJjEVBkEXPklRi+7TwZqzLO7ja0zFEn4C8q
         Z5EkcULcmqTIbAcTrfJgu4EW16Uikc+nUSqF9OzITtGFWsv/4Min/sc6LF8pgZGArGkE
         t4CkiYJb25ZYO9KigiHZVKjss6pPuIhSyzvsyi+GTXr2wYj9kLxivXcO+SA9ld+8bz9w
         WQqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786352110; x=1786956910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDOXiVg0+h1h6bIO200hP40p0eMZwTt7k6rDajhWCvM=;
        b=QenO65i1yo37nFW4Zp9wL9ajszlkxK4+/mdsf0p6dDHy9RAbVSuuqiCJBn+0qn0GSE
         S4KUF8HbHqGVYKW7D4JFE7clHIrlvzzgbgM0GC97J1l6Ho2lO/C3/rDyyDzhks1ASeU4
         DTniIuiyAd7kxg+RXpjA7zI71scAo2RVHNmbDhfvT/lmLhrWeGtDAL1C7ID1lfdc1Gck
         GCFwNwvrL/Ee0eTPInCGWw0PnwM9gMP/K59usuGCS1gV4cWOIs9TjuewEX4kmZtk/I7/
         xLq0A2GyziYjRe75EEjyZ1azGF2BSJtrTYudyLORoiYVnj6Dap0jeiFVvHDTQ+CBY6s/
         nHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786352110; x=1786956910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDOXiVg0+h1h6bIO200hP40p0eMZwTt7k6rDajhWCvM=;
        b=iBkDQeejc23QzPIZUVyIw9X+9WU8VUu/Tuo+p3AhVwYezwQ/aCAUWFksod0DouABwO
         rgrTS0Dw8IALo12Bn+NfY0mE6KGARWeVEaTm78R6ao5oidDVPs9Ir9T1nwl/GV4jLms+
         sEGrc9IxeTSnNncy3xEhQ7BTfuHGu9dTU1z5FK1nsCbtB/1BQKmoqubEebNbyydwxcm1
         X09kwBdfUKWacIX0CXK9l4G2kpCpjkHQi3cDnlMKazIxg0qCwk7mmhmQYjAaOEOPNSbs
         cKPpT75feH0mCQd4l6AumZg+Qw049MESSwGrMN6xsL2IJTpKuFeyu6/D/TQyO01AnMKR
         gcwQ==
X-Forwarded-Encrypted: i=1; AHgh+Roo566xWrTBufm3KvimlFhkf5jyahPscuD6kP3UgY8h2uUB9+Wl5l9apg4Ok81ivBUITIcVb2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYr1gsMqklXvHHqkjOh5JjMfNBq/gjSkNd+AfcAPc3/6UnKZCP
	Yq9z5JG9sPFCn6zRy9hum4h+BL/6JfQjmaZ62HRGErAH1SEkbiRIuWYbpgwPKa9d4y3tjIxLOs+
	AnisHdkUBExJRvjaMCWpl5dMYe4OnpIBZG0cDhnwZVgLyj93xWduFQGZm
X-Gm-Gg: AR+sD13o5tVmNjjNZTRCGbXvxkM8iR4KYq6UEtSg8AiVCI5tXsswgANT53M+HYT7ImE
	ko9CqjnflOrABysF5LsvO2xQpFmsOQPQ9M2EOC/Gsuk7dTh6ncohoNjm0AW1v9wheNUI4ZBnVWP
	EF0fPv8q4lLByP/NHUgQapwOF/H+0lhTCwMKJZ3thz/kqAhHnzTXgv/+Wz2RxrrbVvCWWsY7s5r
	BinKhfKa0ta4CoJC1jsQf2NB9eydxqqAzrwh8jsVpZ8wMgILQDMPaTEQbRcRX+kn4sdpyXckYNY
	YRBtgR+Ef4Wb9DixjPxMpV21bEziJxBF/nhQ+iN3vNO22WjpHh8GcPRFvmff6i1R3nSF2OEP0jP
	fDyMKoONs79Rr6RTHgYxH3uiB04JUsKwy4As7FKAFa9C2uPHG6XT7
X-Received: by 2002:a05:6214:4306:b0:8f0:4e44:79e0 with SMTP id
 6a1803df08f44-908a6f63f06mr248133046d6.1.1786352109674; Mon, 10 Aug 2026
 01:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807131300.2677228-1-pimyn@google.com> <20260810095136.GA2582170@shredder>
In-Reply-To: <20260810095136.GA2582170@shredder>
From: Pimyn Girgis <pimyn@google.com>
Date: Mon, 10 Aug 2026 10:54:58 +0200
X-Gm-Features: AUfX_mzeFnxMLcy1L81sTY1-qh7OQ_ghwVT3wmFd0bJN3PpKGbIqieXYq9LY5wg
Message-ID: <CAJWNTGyLJubRHn2KbqQMeV_jqexSgaLbzTe+xJnGzUw=RUtntA@mail.gmail.com>
Subject: Re: [PATCH] ipv6: addrconf: drop "BUG: " prefix from pr_warn()
To: Ido Schimmel <idosch@nvidia.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 8:54=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Fri, Aug 07, 2026 at 03:13:00PM +0200, Pimyn Girgis wrote:
> > Kernel warning messages emitted via pr_warn() already have the
> > appropriate log level (KERN_WARNING) and should not include manual
> > prefixes such as "BUG: " or "WARNING: ".
> >
> > Explicit "BUG: " prefixes in log strings can mislead testing tools
> > like syzkaller, which scan kernel console output for "BUG: " to
> > identify kernel oopses, panics, and fatal conditions.
> >
> > Remove the manual "BUG: " prefix from the pr_warn() call in
> > __ipv6_ifa_notify().
> >
> > Fixes: 2d819d250a1393 ("ipv6: Handle missing host route in __ipv6_ifa_n=
otify")
> > Reported-by: syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dded267b328e950a7c0c4
> > Signed-off-by: Pimyn Girgis <pimyn@google.com>
>
> I am able to reproduce this (there is no reproducer from syzbot, so I'm
> not sure if it's the same one) and will investigate if we can avoid
> getting into this state. If so, there wouldn't be any need to touch this
> message.

Hi Ido,

Thanks for looking into this!

Correct me if I'm misunderstanding the code comment above that check:

/*
* If the address was optimistic we inserted the route at the
* start of our DAD process, so we don't need to do it again.
* If the device was taken down in the middle of the DAD
* cycle there is a race where we could get here without a
* host route, so nothing to insert. That will be fixed when
* the device is brought up.
*/

It seems this state is somewhat expected/handled and otherwise
harmless. The main issue here is simply that pr_warn() includes the
literal string "BUG: ", which leads syzkaller to treat a non-fatal
warning as a critical kernel panic/crash.

>
>
> Currently busy with more pressing issues, so this will take a while.

Thanks again, and no rush. Whenever you have time to look into it!


--
=E2=B2=A0=E2=B2=9F=E2=B2=93=E2=B2=99=E2=B2=8F=E2=B2=9B =E2=B2=84=E2=B2=89=
=E2=B2=B1=E2=B2=A3=E2=B2=85=E2=B2=93=E2=B2=9F=E2=B2=A5 - Pimyn Girgis
Software Engineer
Kernel Dynamic Analysis
pimyn@google.com
