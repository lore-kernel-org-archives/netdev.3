Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066D36CDF3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749079; cv=pass; b=Pkag7W2HTND1dUf+npTU0PtJw2zoE+TYQwTr5B7vMVXoYjLJi4V2tPGoI9goYvHTew2p67b/61T4iPRjjPc9lEw+MW9LWzaa2sve5jTpbzEjImGvcC2Le/ad0ey4KkXiiOTaAra9rZLZxVfN/yUYiN3aj/ZOTcXwdTkHp8qdOuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749079; c=relaxed/simple;
	bh=JQzdvO2/c6W6zyFtYE1jtZo85b0xGeOpk8OnYL3jNs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyt5G+HPfEpUv/SywKdaxUTIA5cB3WSJmklo0OpddKOvEIV3dt0l4ZW1Nm0U9yaEx/BQW6Afd2EJy4yqMCBRi1mPQl7mr8LXXjCGFanJYv4bXFFa86K0c0MeC3kzvizNyVE6CwZYvUGndreziM8P95Jj3uSxNsGvcbDmIz4QApc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9F02x+Z; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9F02x+Z"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cede6375caso16135ad.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784749077; cv=none;
        d=google.com; s=arc-20260327;
        b=KYmBc/J02fYRQcTES3Cu7GuV6NDA+nwrUpe4KPpZuPkrvFFhlcG6ZWhVIQfNLpfvOh
         BIlVE+yHrwPSO2MYK5+/e+Nz+ahtNr4X3wSBTIciPJ7kaW3AvLfOzYrFzg/CLyWs9deT
         RS9sk3vPVUAtmRNYG5o/0X1tvpDO8hyhpoqKhNIiScFKyHyN6wfa7C5tAo/kctevnvii
         8+HsJCiQBK8HxCa8JwuBNghi5X04B2Fuvl0KUObKXTm9Jp5eSydROyBwHF1TBBU6IGEY
         /W3HupDUqo4p4CjzeUOQAS+s//W8b+lv+nu4xzhD49kmCVUqKltVF/U1W7fFdSTWuz69
         95Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQzdvO2/c6W6zyFtYE1jtZo85b0xGeOpk8OnYL3jNs0=;
        fh=I6CpWP8C+DDg0ckW7707Pk+5vuHB6Lu2ZTDRv0Sthok=;
        b=qeL8Daggo6J7TTKxCnbLwQWylVfX0LoaepG50uNtsG2wYbMQ3TqYCNdtRZGm63rcXi
         nCJVDbY2kIjuPLbk3dliiSJTFeELjtxZBD4hhJSnxFQ+xHQUV2WrQ4wxbhO1j22NtFVd
         bRRVaRQtpfhSWY/Z/L56lGXUOMkt3vqU1+QrwlIwppL9TTCy4rtN1ockd6Y+8UJ/PHV/
         fENM4nYcggj32Vx7ttJgveBz3mFNkP9dHinuwvx37uPtaP0FTjIPzPBNSg2YXuKYKns5
         HzUiv3e2LIa91CzdEl7yUvtKLR/7QQd2UTqpzijJsN1IiBxbQ7NFHN8v1y+nVi/fQzXT
         Jmnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784749077; x=1785353877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JQzdvO2/c6W6zyFtYE1jtZo85b0xGeOpk8OnYL3jNs0=;
        b=m9F02x+Zsij3Cm1Yoz5t2A0G0qjRiIdpl2Jui/4FK4NKhEr+udoaHujkmIQfU5S218
         bsDFwTuHWG+9HBiEA/dao+MaWgeNMJxIcoJs973afLCPezcZEU+GlOVGVi73roC4kd+g
         qO4bcfb5O8ddKbg8SK513ORKjIgBM8cReQYr2i9hBTW5Jg8w2Sd+L1qc0THiCJNby/CM
         +u3JKZXpXiTTWxG0SBeuj0297pm8a2y/YL6JLreuDLyvalkLXdfiaW+l9Ooes7NV49P7
         aDo01oX9SOTnJuLa0PcDjgl54TakM/OO2SWH1QukNV5E2DM6DHc+h+y6ZOBVtvSbw1xk
         3I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749077; x=1785353877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQzdvO2/c6W6zyFtYE1jtZo85b0xGeOpk8OnYL3jNs0=;
        b=rrC519VkN65R6ZBpNUnOhl1R9aKHsUNdx4YgaUxWN4UWmtjiGl79JjeIk8sPPd7MoA
         0ey0PunzIas/SVkqZ2dkLpGVE8EqAL9BoB3EDn2/YuW6qyX+SWYTbBF7nMOjWtGl3ym0
         LzjeyOrR8rBDDK337TauxZEp9iR4hlwRBwiauVDBNzI+FJEpkccx0pEIfEApRgg2j42R
         7D9sqcc0KGVGJwJDOJ+CLn4lQN4+7Z/Zfs4IUmOngd/hai3wqJol9Kxja8QgZSzQ2Riy
         P63uEVuqX/1sxSObVipMy/Yu5sV0Ib2Y54xaVnsv5kYa243fwkDCrXABgZB150Ef//4S
         ZBpw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8ltAslv0TijdO1ltUjaF2pEZuFa5aXLSScojPqgYEFZIRaVEPTdnP2JK5tmb/6MHmhheTXgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrcFBdYBzlYl2jibDFv6UMS+KUyIgi8qHCUjlb8tBC3G5y2Wl
	ySxiHR4zYsb44nAUKqXmRKDa1nBL+wMDEGVwdEfpPVT+p9hLGgxllbGgwxhtyWe2Wp76OsTn5dH
	0V9z6j1e808B4cmOwx7La3nmiE0A8vNNC1VkkiGVT
X-Gm-Gg: AR+sD1194Vdsnri5c8xDWvly4yjzGD8DdqUnLHEYYY9eUMuAA+PEcfw6emCAWOxM2dN
	i/ilbRGgpbMdNGFjzHEBDcKsQ1TO0CK07T2sJEqeLV53mtwoZX/ZhWnhDWahV2ic6j/MAlzxAdj
	1j9k/Cwxdae/K0sPA0dRJcWKx3Vk9/KRyPGrc2r0IfPAInQzZJE89SYzFpDjZUJY/ZuYY59gAQv
	2U9kWgNMxuAWMgzqxZwHU3Q7hvq6NM93p4JlAxGk4rU7VtAbQFnVriVmbnkFd+T5hmh1piYi2Lc
	Q69qCC22lRzEflElV5VySg2F2iU=
X-Received: by 2002:a17:902:e802:b0:2cc:a859:d404 with SMTP id
 d9443c01a7336-2cfa55cd5d1mr863615ad.23.1784749076764; Wed, 22 Jul 2026
 12:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784726895.git.asml.silence@gmail.com> <f95ca6717da3c8d3649a1a7f0d883a563f545052.1784726895.git.asml.silence@gmail.com>
In-Reply-To: <f95ca6717da3c8d3649a1a7f0d883a563f545052.1784726895.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 22 Jul 2026 12:37:44 -0700
X-Gm-Features: AUfX_mzp4a2QkcqWlT4Ddz69fyMJJIoO4GRgGyV2Y13YRwziHrdNsQQhoVl1-hA
Message-ID: <CAHS8izOhJN0YzQ8ybYm57Hd-Mu8PMc2a-NZ-K-N504LzEeTpfQ@mail.gmail.com>
Subject: Re: [PATCH io_uring-7.2 3/3] io_uring/zcrx: rename notif to event
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:51=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> "Notification" is too long and the abbreviated version is used in
> several places, which is inconsistent and more ambiguous for users.
> Rename it to event, which is easier to keep consistent. To keep the
> change small, only change uapi/ + do necessary fix ups, and the rest of
> internals can be adjusted in the next release.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Probably a basic question, but isn't the stuff under uapi/ supposed to
be a stable user api? Why is it not a concern that you're breaking
current users with this change?

--=20
Thanks,
Mina
