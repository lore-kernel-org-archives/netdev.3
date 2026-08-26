Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB71392C46
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724871; cv=pass; b=b6yeVSfImdDVtmP2G0WLKRheDWk469P3jW287FOQ8y8qvii+bkojUy6RzssIqawlpj8X6+i08DGdgQU220D3k++lbcs61emsBBw8edly8UumeZtgrN0A0i8swMMx/mf56/mDid2SeGw7JfLsnVk7ZDKqizr++4Fkm32ug/4c9EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724871; c=relaxed/simple;
	bh=sgwPHEyJVpvFcUadwCHn2S7IC1vBXiMJjKzN/5ObH80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1yeRiuMmJUoTohhTHbK9tRgIXNUJriMKHgi2BVDRjPZXQx2Dng32/JEqF6lmEebP0VSSE/v6anyrqCmui02QwpLjylbjIvGmJAyjBdTWluEJ/wLuUPap7xoxy0uTOEBWrEzg0h2rI5i+c8TOX57b5VvF1MKJmNzA2RrKFdsbIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYeujDHq; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYeujDHq"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c0c45c580so2011141cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 23:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787724869; cv=none;
        d=google.com; s=arc-20260327;
        b=RtmUSGrdHtxKcw80eb/BwGoR1tPhgsFl5An0apuaWolWE0ZL5u2AY1GbSuPNPYWPt7
         o8ALSsksA9jQ/0QMVXZRxhXPU3KJ4gXzMs/B3jmMcEpV61rXBFZWphj9ipGQtDQ3x4zu
         4v0IbqEdpssCwmd4L51IypGoRyJQKViqXlyOHlYDHOjzQGISVCDLyywRo5Si7SSnH35e
         QmyRM8dRUD46tl2kgF77wNQrW9prqubcLD80EiI1gwjiRt57cmm1fntXV/2U28efq4Qp
         RugUsiKvqYfwOfk19IY6r9WdqTmsqxN7borV0QmLSjx/b1Akcv3N8ISTxj5DjQo6oaP6
         JdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sgwPHEyJVpvFcUadwCHn2S7IC1vBXiMJjKzN/5ObH80=;
        fh=78yp2U6WKz8V6B0bGqmUOSU6vRqus0tDB8EiUhi46Kk=;
        b=UVDGFR9OawSKBC/DYok4E+fWBGzC+b3Nx2/SM3m1jcVfTDTCZdcw2eimMT7OvoEYIb
         jEf6bXSz81+mVa1M5c926i1j1Yl/RiZrS4LikyZ7XRTD0m7cSJ6FDwupO4HqR7l6MJS0
         I0pQ7pIWYWdPu4+o5wJiFZ/d/yq6pnxZ3i2gFF8eyUrBp9xHDEAEGrXOC5MgjySCb+cn
         iTsFk9iG+5XnE+TiU9U06xj8YKZxX6+Iil6MLSLp80p57wUsJb0bVSjdN5MIkKiTWBhv
         gM98BwusZY/G1YVFa6ubgOaZwj3CxMBVdIETPEXai/fqrqtQGvDXxcuptEtfCuy0iQdX
         VHHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787724869; x=1788329669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sgwPHEyJVpvFcUadwCHn2S7IC1vBXiMJjKzN/5ObH80=;
        b=FYeujDHqNzmbaMfeKMj+MXmLa+kh7ZbBtKvmvLYaAiRFcfa8+HkKg2uBeivxgN5omt
         UGn9UXV6nWTio2c/bfSGZKF7r6PF515ko2JNkxqnSfPVoYbxHavK2F8yE/qDgVkhvxvc
         /AabQKXJxa0rWaD8AOwjTq9BcJ17mhoSSJt97L9u2aazHBA4o41H3wX7NkB4IZj8u8Yp
         sJO2OB7AoP98iHtD/AdM+qgKXKj7kMhAn2P0vMVKs9T0dnHoahc8T061CLQuVQVfTqj9
         Nz1UwLC9HnpyloCgZSQ2XkjDKAcgNHHHF/1sZRtVbI3RhbIfrf/qIKRAzDTz4fYBTMxt
         iGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724869; x=1788329669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sgwPHEyJVpvFcUadwCHn2S7IC1vBXiMJjKzN/5ObH80=;
        b=Neay6l9Dzjabnc03ds2O5yEGoZBVyY5KuWxJgzcna1pal3eIYJ8UKKm2/R+EXD2fhu
         GzA/PAw/QR9+gLVkD0TohTNjGWQJRV1H7IRptkcYAK6hhVhw9/oPWgy20H0ABr9MmjEr
         b/QtAr1DRaVFmG0lnqLtO8vAbhCAuJ9heFkzLQj9LHqXPuPp9GgN/MUbmendDIgEK1Xn
         J3KRlDRW2pR/qbNGLO/cMkZmE6qYppeTZtj4xNkt5Kj9QueIjzabOxgprbxcSJ2Uybby
         df5B9TBJfNDYXW5vS0GGIhCi8ZCsowwbDWjC860sv2Q5hZcpcsZghJyjZkNCIOZG6VEo
         dw9g==
X-Forwarded-Encrypted: i=1; AHgh+RrETVsT6QwWmKPMXeoAFALSatF0pv8k3gzBUnByWkYpktcCJYCY6rab38ceIMlMy0l6CA/HfEE=@vger.kernel.org
X-Gm-Message-State: AFuF++l4bKFviT3Dejd0JzBrtQYgfKNWSBrZ4Tc45KUIzpwf3LqYk5aK
	ufbCJvqPDhBdbAA1aKHSSLuWV5eR78TdQU1BawOCwvCf2qJ8frQ9dBlpS0PtacDP5ihQuP22ppY
	mlKXcfpsvWuK18KK9D+nKUIhk5iYVPXLuHbf+BiO5
X-Gm-Gg: AR+sD11TgQ+ddYFFKq+WE14TatzBIFvL+2J429wAKh+XxCMN3lDKEzFPtWb4aFv5i7Y
	XvnmNUKdn4oIhRLuvJlH9fwSWpxQ1PtSc9ZecnKeWAuYdhuBnRtMicsog4y3TWrr/SobQYH3Bby
	QvRmACMgb2ilYAiZvBbBwjMG1LYnFgbLRlmSGoFoNleTyCI3iUSbYCJJC/XylzCECVPyxDR39qP
	gs2UChcQQE8f7MjsMgnnFK1GRq4FiQRTesH4Cj+UxKrflUz2Z+Ual3NVimIg/XvzcDrdChIk1A7
	3O4mvxtQ73gYYIlYH7tCmgkYks9P1AJzrwpdbdM5WDcNb6Oikq7jDyHBUCBAz50vreeb7Dzg91V
	uHGjt/lA9OG/APAWYp/Z3WKVH1UVTK4XNsGNL0GCVzbCV5hVEb/CkW5KNaXo=
X-Received: by 2002:a05:622a:2506:b0:517:906b:c043 with SMTP id
 d75a77b69052e-52e423ab010mr38816871cf.36.1787724868696; Tue, 25 Aug 2026
 23:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825150655.1450271-1-jjy600901@snu.ac.kr> <CANn89iJE_HosLBRhZGM-GVpgPCSNtHiS9vnCc3tEmTVaamcJ9g@mail.gmail.com>
 <8ea9c9ce-e1ed-475b-90d3-abf1bd86c3d7@linux.dev> <CANn89iLr7+c_Hgxgj-odS10LW7CR_aTQr6ozFezKtYC6=vXG+A@mail.gmail.com>
 <f68f55d0-b012-4ea2-9623-2b8a63b2d0cd@linux.dev>
In-Reply-To: <f68f55d0-b012-4ea2-9623-2b8a63b2d0cd@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 08:14:17 +0200
X-Gm-Features: AcwNN1WJCp0OJeW9chCW4yKvE-963WCoZ7bUBg882SOdNyz70JYn4uO8OOn6NEM
Message-ID: <CANn89iKUZm10d3mMU4ZxD18frFNhztczmU960UtbxecJ_Hdg_A@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in slip_receive_buf
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 726ksm@gmail.com, 
	kees@kernel.org, linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:53=E2=80=AFAM Qingfang Deng <qingfang.deng@linux.=
dev> wrote:
>
> On 2026/8/26 13:46, Eric Dumazet wrote:
> > On Wed, Aug 26, 2026 at 7:38=E2=80=AFAM Qingfang Deng <qingfang.deng@li=
nux.dev> wrote:
> >> Hi,
> >>
> >> On 2026/8/25 23:27, Eric Dumazet wrote:
> >>> This rings a bell; I had a local syzbot report for this issue a while=
 back.
> >>>
> >>> I think we should remove slip_hangup().
> >> ppp_async.c and ppp_synctty.c have the same anti-pattern. Should we
> >> remove theirs as well?
> > Probably, akthough ppp_async and ppp_synctty historically suffered
> > from this exact race, they added their own workaround: a global disc_da=
ta_lock,
> > refcount_t refcnt, and wait_for_completion(&ap->dead) on every callback=
.
> >
> > Oh well.
>
> Then the workaround should also be removed, according to the FIXME.
>
> Relavent syzbot report:
> https://lore.kernel.org/all/000000000000e8231f0601095c8e@google.com/
>

I can take care of slip_hanghup() removal, I will let you handle ppp :)
