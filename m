Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3C437452
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751596; cv=pass; b=C6W5GDDaSTDUg94g8341xzc0zeaxQdK1cZrBkir+EkE7220D+y2gk3xfEBvs8ySuD5+uvnAPibWFjHZ+Bsim1ka1fzZgjFLdidIS/7QC50Q1/RWQWGC6jwWBq7LDPoJ6qe792XUFWjwh2+aALprP7/4Sv2HDP5z2b2WiA6IWTGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751596; c=relaxed/simple;
	bh=KgGZhsrPiY+ReOQTpKZCXY9p4PoAkRFroGl54YICe+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbAYGF7YX0JdZ2F9sVAV9fJ71StAYuBo02mWNqx3nYqKRR8WinYHkwphnYW8zzmYSJkmxyyIVphSUhdVE5VCD+QrkI8LhH/4bciSqJ69zuPuAdJbn2CvpuJ9d1Q6N21aCulfC1kBN097/9Bmdy/mEJrXyJzqe3mOLqIqp15fGyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRVwdX+/; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRVwdX+/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso23665ad.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784751585; cv=none;
        d=google.com; s=arc-20260327;
        b=cNLU4A6m4ZV5fafOK17ZgdwHGGk+FKqrgmDa7/6Vw0bjkCK2MbxbSdGVq52axXY7la
         jxfOvEslLuPvHCoVLNAAyuJ1/NOROZG8IP8hdKzhOsy2hufY2a+QHa+YffnJDM6YXlI+
         +JDVh93JPVigfmVxQGHF+VjypI27AbV7c2wWTVKTbDhQW/l5ljBLHoDdHsyl+S0iAQh7
         8JdNzVDBe4orUNmpZ6RwFYzjE+dL+g7MRmNX65ExBHpnqrTxpNr9SPs/iQl3e3bb2z1X
         d/vQ7raCLjoPk7vy0wVGE92jL3Wc26wECw8NwD3naqpJnw8xRsZI3rA/YMB5YDOxNGYS
         dWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KgGZhsrPiY+ReOQTpKZCXY9p4PoAkRFroGl54YICe+s=;
        fh=TcadXJnb4SWDMGd/LxwHHwgG6F83X0bMxwA108gKBFk=;
        b=I7u4+dhwPnOs/RbSIWBPrVnuxVkmDpMNnxmoiJWKIkEOW60HUh06T4PJ0aXy2mUSKk
         /4sJJa47wUlqR+IbRhG+bIydLyun8Hg0NGnjE6ZWps5UpSI90vkJ3QjtBJdss02PUp50
         Uy2PhEFeO5jSmOg2MlB1wFRGcc+SIxZLMz+eG6mx4dBch1BksH2e4FpHNZ2X0geYHHpC
         +V7UYMQiAiTwDtVMAnxGeDKDPCz54C1PXKtfLc5Soq5L+jJFQQiNIZij0NyJAZxTRqaA
         MmEDss1nXPzlzCXGSRmHSIEEtL/dGVXCzsxnh/u2B2f24QR3Ecd2otkhnx+AzF49oIsH
         UbEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784751585; x=1785356385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KgGZhsrPiY+ReOQTpKZCXY9p4PoAkRFroGl54YICe+s=;
        b=ZRVwdX+/Nip5IKj4HMHufADleWfppU+aeynMqe+A8/zcrTznU3EKFG8ZD+ehL8KrEh
         bxbvCpktYI/K4aBa4QxdYYr/T3b7O8L+aPOt6zOs/Kr/G7M5L1xnWz/MdZShPwLE3IbI
         aSBp9E6bmDB43p0FYkICYpCbHw4xX4cmYqrucGOFCWYxIoQJESjqcPkylvOiJFIyzwjM
         MfDWUdXEK24QxYYBhpFoM1mr7RiAJ8P7+JbWkiK+xgODHF8uylxwJ/BjsRYIHFStTNGp
         fM/RWqRPzI7D90eRYWu9HRK0v2IlcPccV6W7nO0Mcc22G03itSxRs7m8I/rYUG67hgC0
         OvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784751585; x=1785356385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgGZhsrPiY+ReOQTpKZCXY9p4PoAkRFroGl54YICe+s=;
        b=Ug93xpL1WbTAJqk9Tu74LlzCTGbqsd8di5KkdBGovrvEUjmSXpQfVklog9Ry/Gnj2s
         KIFFMbSYZrhz1q4Qh1UFtRu46qZe8WluuYWQINNXlIhlWgj5bQEUo8CSpkRRHpYmtFKo
         Riuw87aLBNlfCo7k5IeqPoEgo+y4wwy86EBiulqjbs4zOf+S2F7wqjX3hTixvNH6hzEp
         Xm4bMh9APgvuplAPyKXQYhhcFn/wb71iwW7npHO7wmSBoK/FHF74GzSsKrUDC+cfXsYV
         nho/PQkMrNaJDKI5GGaH4yhnOBBbLnlAp1d5dcksLnIcNu88wYL8mZWaElidLTxBN2e0
         Q/Rw==
X-Forwarded-Encrypted: i=1; AHgh+Rr10FYOHs+horJqRJ7lZW8Scs3SEcnZmy0DyiT+oBsgGF6R2RQOd7XgqbZvplq7mAceOgtAtYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHP1OYypxwIHoENvWbqtAIhHkjATfBGjC1YtuniGQ3G5bmeNgf
	yQyuDvc2X0LWQRBK78PEGp9PNNke8ql9DCiTYM41lWQTIquAvIZQ3tMzcYYBUrpckAFRG2Xy8M2
	jHSE3lP9vU/9lFi8qW9PeClERCfh+6XM9E+0DPRBuCv1Fw44YyaBj5l+w
X-Gm-Gg: AR+sD11oMPeuE204NpCJhLRedysu+rirlrA1wAHA2oPRN1jdfjjzOiy/XU/Vlz1TixE
	gfSVpqntGKwkwmkAdFcA/epJNyOTO86dDLgIPi0dOenlc+ahZh3iPZtebl6z7wjzMmxq7QX5zrr
	mwZkxGjwbS+eWzA+EgzP9hLRi2lZJBLVLUiaTlBy7FJm0DJF9PHGm4Ej9ai23RUAIEOcTCtG5Rn
	K6sGwSKx1CvGTCx6JmKXseOpUYBvFgsBAdCWQDrFy9LEN3CElNwoHEN/qNQc3wclhDljDvFz0Bb
	qHRw/3lWaJVxA5axwT9KXo8zgGI=
X-Received: by 2002:a17:902:ef97:b0:2bd:6dad:7ccd with SMTP id
 d9443c01a7336-2cfa807b694mr161795ad.25.1784751584053; Wed, 22 Jul 2026
 13:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784726895.git.asml.silence@gmail.com> <f95ca6717da3c8d3649a1a7f0d883a563f545052.1784726895.git.asml.silence@gmail.com>
 <CAHS8izOhJN0YzQ8ybYm57Hd-Mu8PMc2a-NZ-K-N504LzEeTpfQ@mail.gmail.com> <c3cf5d0e-103b-484f-956d-5f00c1e48be0@gmail.com>
In-Reply-To: <c3cf5d0e-103b-484f-956d-5f00c1e48be0@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 22 Jul 2026 13:19:31 -0700
X-Gm-Features: AUfX_mxYAdzUEWZSC3CkWFFDSKDOjuXZtOxgWOEf56xAG72XZK7cZejZegnjDi8
Message-ID: <CAHS8izNEr42=17WD9BdfzFMKKuGoUJhU=g_rUkr780fdKS9fkQ@mail.gmail.com>
Subject: Re: [PATCH io_uring-7.2 3/3] io_uring/zcrx: rename notif to event
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:11=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 7/22/26 20:37, Mina Almasry wrote:
> > On Wed, Jul 22, 2026 at 6:51=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> "Notification" is too long and the abbreviated version is used in
> >> several places, which is inconsistent and more ambiguous for users.
> >> Rename it to event, which is easier to keep consistent. To keep the
> >> change small, only change uapi/ + do necessary fix ups, and the rest o=
f
> >> internals can be adjusted in the next release.
> >>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >
> > Probably a basic question, but isn't the stuff under uapi/ supposed to
> > be a stable user api? Why is it not a concern that you're breaking
> > current users with this change?
>
> That's so only once it's released. It was done for 7.2, so it's
> fine as long as it hits some 7.2-rc*.
>

Ah, you're trying to switch before the release goes out. I guess FWIW:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
