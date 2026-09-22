Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28564423E8B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064617; cv=pass; b=WB5vCzLNaUEHzR7dRNCxSIvRvfcYreWMOJlHC7POCoc/e5C4TeJt2MgAJxaBhlenlbXiEVNAnx+OS8umEauFGIH7Ja18WPQP4GmFWgQCyAEqVPnXssJ5Ec/OqADulmxfe89fYeLkvploaKJJG61x08+qtVN9YGrdKeknKrixZ1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064617; c=relaxed/simple;
	bh=0TPHr2wjc7lv7i9amMHXALYK0m/OfGIqKy9VfsJQwbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2AVHh0E0YiZhJrFBF43Xt3JUAhK+RbVDz6pxrEsiFAAjqUI2dFYEkiw+7YSMLonzF8JqF18LYNY6t44OOyFJR+3uwNfRg4MSjG27vT2oQAgLlbYYInmv8fyT2KJRLD0MrrZHWT3rYh2Yh/i7pWBIVbJv8eNPkC4OyqkjRVeP1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UI78I7jg; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UI78I7jg"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb767d286so35478871cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790064595; cv=none;
        d=google.com; s=arc-20260327;
        b=BxRXT27aMcap+g768hntDpusyxvl1hWoLORjRlDBZuyI+1FZ5x2i0bIg3OWdkQg8Zy
         B6JTIyc5Vbm+qNZmaJGZOhl4UUUdeJcbWbeSuTZuc6pDt1sZuLZgqzUJk7A6SM5H6QhN
         lbWXIXlN680s/QOB1ANpYOOnuKBNTK1xcQ5bziqb2IuIFH1p3I+76JS/7a3tBW/qJ4B4
         e/n7azzWe9qpSVBx/ejpRBBdMApuqqEzv4ustjx03HVKj4tdMatXe9gzvr0VDJRbVdf6
         i91k51sblrwvBHUVcaviRiPzBhxejx9gUcvcs2/CtUD9muxjgJ90qKnoEUcaM7hRG9xV
         xjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0TPHr2wjc7lv7i9amMHXALYK0m/OfGIqKy9VfsJQwbc=;
        fh=6zfc34g9dSC0U+f8Tklj1Fl9FF2409hSLYzYwy9S3Cg=;
        b=GmmfLdcrsEQ8B+nG8EUZ5UFTVt4DL49wnoVkO3cgU8ll1pQmZrylODs4kChkkdSQOt
         7OjDqh1WwZeGQAFC2q6SN23NcUYLzrx0HhQGsN5+r+zx2gyElavKkgzPC1wkBr16rcQI
         kD0E0loM5hzigSxNZbXQwVq5ruJKH0nO7cId6gs9BUDSR5/HXubXb1famA36IqNl7Nv5
         sivR3E5Ga4NhmTxCD1V1uPraI8EmyECAxXvRwXFFCprrTnmUKTxbmnpqT5acDEPoqz+x
         Eax+ptBUNfi6l/gEgaXO13MyD5wSKI7Ms1KN1IgDmd88kaSAZlaMCpiWkQ3mevzXEe6R
         8o5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790064595; x=1790669395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0TPHr2wjc7lv7i9amMHXALYK0m/OfGIqKy9VfsJQwbc=;
        b=UI78I7jg2WcXtLSBRhot0Ibx1hwI5uqdSXP9L0/P9Ngf2Wf2tNiyiQJfV0rrLgGMLu
         IJu/JLXLNDQIYa09dB+7MS+wmonGDrQeiaJK1vsnwgq6V6QWOVc3mpTvLwhbxNyWX0Mg
         vre9548+kquflevrnvMByBzcn8QWU4AP0SihQKwfeD2mTRm9eYn0QPBY8UMNYUNPuMQP
         ATuJK9cUr3eA0hU19PIRmOamZ3616OJgOdDCtqVczw/3hUVDlCiJdEXE41W//BVlnMEI
         /SPWl7MLxYS94PfP+CVQPRjGQtBGiWRU5Zxxitz3Htc/PVpRTXJpuq15YZ+WWMCEclX5
         pGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064595; x=1790669395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0TPHr2wjc7lv7i9amMHXALYK0m/OfGIqKy9VfsJQwbc=;
        b=L/sAf12U5LjtJrWkCl/ZjDkqM1T2ips4jKSdVNEp0E9jVZfNeOYmiFt+KprAM8Q2HK
         rqyWLL72d/KRW6dx6wNMbmWVd5fir0TKT60pzxntvO8nTPovoxziKUVHrcyJ2Y3oeR7P
         z/mPiThbGOYLmn5RZqnXd03gqAyl7E4feS7kQKx3v9nUpfQBKTelhtw8Ai14aShunW7V
         rUz80dYt411coHFlzch39aukojWRuPLhdzvTKmk83WmXWUMa1s3sMNfxgUrPX5aU2ThJ
         OOPU+rHgILshyxJOFaXvwiATTdATNc+Zl2yZLocsgS0Y1KyGeAe4oXeTRlENYbA22H7s
         rJig==
X-Gm-Message-State: AFuF++klY0vRpRG/E0MoSWdqiOK4SLxyrcvetqbPV8ZLz4vCe+p0JlIr
	scrX0eJq8IUEHrYGjSy9yu8NvzwDIkJCYyQ7G1FQ1yTz84OMCzsEoVA3T+UIItPzgB/3X942x/H
	VfnCrXDvz3lWF7YG/Zf7tZVwFfm4LAFjlVXQ0kNVW
X-Gm-Gg: AYBFou1rRGMTe1ZfnOsUNou7AZjFd11JAb+xJ8ge5HmIJ5PDIFdPZzN8HYmv3pI/XzG
	BLMqzo37ZjMRskQ2vWQqJ61tkdENsdeVTy4CUHNehsTaA+Y4r/lIB7/oppD9aj+wCiZODix4snu
	TEK8UV1iP7dWbPMeuCX+4evfw/boBPm5W5wsUdXMYIYc2Bkx1fzPsptaH6GyFyWWsV7kvsjrWjd
	3gt3lEUF1O10SINtvA3/oQfUoGN2XgTXPxphw6gv/9cSqEDskmdxjGtRn5hEyZfpxeTcIYnraXO
	2wkJMRyKfD2N2d3CsfvKqTwsYY97LnlBLUh9j5b/t/oDqZawJq+o6KeoCE6ysI3p+3G41pXMZ0u
	UETq+7b/Q8+7mYxTJS8DcrS3xPZEh7PNw+Qv8YLAPYe1LDtWQnCVf9YkPHNmfd+kczO25Sg==
X-Received: by 2002:a05:622a:8b:b0:532:9ade:b6db with SMTP id
 d75a77b69052e-532d8ec0addmr44120171cf.68.1790064594490; Tue, 22 Sep 2026
 01:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921222609.50824-4-jeffjo@openai.com> <20260921222609.50824-6-jeffjo@openai.com>
 <CANn89iK00zXGA8sdpH9Y1CkFK3n=uKG9Bci3+=69fGV0UDQ80w@mail.gmail.com> <arIE_i8Ysz5nOI2W@com-94485>
In-Reply-To: <arIE_i8Ysz5nOI2W@com-94485>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 10:09:42 +0200
X-Gm-Features: AcwNN1VZRZKeamW0woMTH2MljTZUPUykptvBQbfvKuUK7LNYhzxm8OhK1Dtip-A
Message-ID: <CANn89i+nY499TfuGMvMq3P=Pxw6vBxe+uYH1zioK=bhU--GXYw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: net: check timestamp echo after an old ACK
To: Jeff Jo <jeffjo@openai.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 6:33=E2=80=AFAM Jeff Jo <jeffjo@openai.com> wrote:
>
> On Tue, Sep 22, 2026 at 02:08:47AM +0200, Eric Dumazet wrote:
> > Note: Even with existing packetdrill binaries in the wild that don't
> > check TS ecr,
> > tp->rx_opt.ts_recent is still directly testable in pure .pkt via PAWS
> > (tcp_paws_discard()),
> > the same way tcp_ts_recent_invalid_ack.pkt works:
>
> Thanks for the feedback. I'll send a v2 series tomorrow removing the
> redundant SYN_RECV check and replacing the test with a plain .pkt test
> that uses PAWS for the assertion. I've verified that the revised test
> detects the bug with unmodified packetdrill and passes with the
> simplified kernel fix.
>
> For the PAWS probe, I used TSval 300998 rather than 300999, since
> Linux's one-tick PAWS tolerance allows the latter through.
>
> I'll follow up with a separate packetdrill fix. How does that sound?

I saw you sent the packetdrill patch for formal inclusion.

Let's wait for it to be merged and our runners to be updated, as the
kernel bug is minor.
This will allow us to get a nicer packetdrill test that exposes the
issue directly instead of via a workaround.

Thanks!
