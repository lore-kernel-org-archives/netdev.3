Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792435640;
	b=x3/B/iwCTqNybtXV4KML82HtGwmUzQx8l8AL98HgPOlgPFSciu3UMH1bmIEm4dQgZiXo
	 vWPl3fyHEueBKbvlmAPIkj6lXXZGJwW0k/G24JWyR5m1cf4eWNQoBeQjY0wCXwfICt0p/
	 Q9fQwHvIG1RBdvaROB8dXQ1jJOdmrRRs22KTd1Mxc1giimvVWjZs/w7YL9loARTKNfywa
	 22nnP9BIYJfIor9zOytyt1O3NFwd6+I7QtC4ajSY7ZuCsa84BQApU0rcToUrJTpKi6SRK
	 ocuED1jJx8Vs/XbQpc/sBJxY0AuVCCslMQBYEo5sFZNCDd3u133EZJAnfGqCXdqsfkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=V41ZP6u0L0y50jwnS09ezlAGGz+bWXVLsjSU2rSv7VE=;
	b=3djMnESl76BWODy/5slHHh1a0mfxdvENdjUUqC/HgbyRcAUiOYdf8e+Y68z52pMs+1yt
	 qL0Bv11E06g7NB6N+Z5V8O+JA48senreYRQur5Bg5cwju/GHWcGZtY9kwS+y6s3xxRT9S
	 R/SS/8G0Gyx+i3jhSKdAqryVcwe/LQd6cM4Lb8kAnFNkBdVxRCzUGL8J6fuOyCLOUPci3
	 pMJ4sEz+TSwNXQz2uNxvu8UyjCpi+plji6GLsUhTD71qVjdG9St99OsTWMxCp8MT/5Lji
	 vQQ7ZGBG/ThUne5ldZUZoVbETpUVskpbz8aK8noYZTXV3z7o252MLYXrhm/K1lbuRpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	dkim=pass header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=HdbbqcsN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46103606A32F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46103606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=HdbbqcsN
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514b90bb89so6346759eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792435638; cv=none;
        d=google.com; s=arc-20260327;
        b=N7o82bWPNzB+GeFf9O33icpSqIAirIiAFsXDntRNOmwAFszqPiWCtigMJIwGFoPKhb
         slA3VACV3hXFJjP50ohbQRIH/5GJXDFG1nHbF+5NnTrkNN2OVkfbNzGHAebt8EqSPjl8
         ScWok2gok+w10MgUKhqHwNyc1Ynbg7caUCM35lE9HC4Ww9EeIM0nth3KzcgvJHiov8aa
         kLOCvNfd3Kwmzmo5DR5WVGQxeswgkRMGkOgkNdSVakHBDE2OcwfICbBYZbLqd1eDu2Ae
         FwRlzL8B+12YYtiagbsHrg+9pxYliknjfPFRRRTmJxvEPyLWkh5onpDda5JlWoMC476c
         WznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V41ZP6u0L0y50jwnS09ezlAGGz+bWXVLsjSU2rSv7VE=;
        fh=g08+9vh1/MP1Ck6l+7DhliWxsk2afdR2+6nrlAYFSxs=;
        b=W6F0kYWyyOBE+kv0towEYQi6qrRzdb1rGZLnkrxfaNCE1LqrDf8cU7XA5kjY+uR/Jc
         o09uI6HKzGL8SLXo5KV0vjk18eRHFibc9L+eXOgp5xwWVTtSqEVJDYTQ3opr4g1mEI/C
         W+K+fczvE4zAaS8Xi7njspzCuA0h/32HPAvNM7VItCS3OzFcHxt19+nA/VHMIL+w84WB
         oR5gPKX4UIIpVD/Js2EOOw8gRFROJFH0YcA93j/xIlPH7Cz611gSD2XQ84bsvSZYM34g
         Dx9ac3zyFQ+GGlcTGxd6Ygk0JGw4Ma8X+QWxiYpGNrotJy/K+fvLU16C+bPIGLNzrgEC
         SvKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792435638; x=1793040438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V41ZP6u0L0y50jwnS09ezlAGGz+bWXVLsjSU2rSv7VE=;
        b=HdbbqcsNlbSUxrGK0SmNnBo/A8+7Z+3bpX9YyDHWAVZxEML6XAINgzSNRLVOOXEUQs
         Jt2tpwaSToRL6P1ArM6DBqs5sUhi51b83zmoHDlV5dJYi8u/bxfFd+/X8pWrH2e7e5w7
         ff+XriQfkNLGt/CxhAm/5mtuxZFMI5a9dquBpqYz4sqUy8nzhTxEZqYKJl1FPBoiAXME
         3tmvJCY8a7O/j2VLR/hdUrJMpOhbNikLiFTQRH+ysGzJNaVi6Kx4Sd2jci6bNu75rBGZ
         P7f9HWxX7+q9YalVM3aMYcs9Z/N8wc7HGRjmIUdJNbdkpodeuQUWDgh2xdUUNv5y0cpX
         gdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435638; x=1793040438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V41ZP6u0L0y50jwnS09ezlAGGz+bWXVLsjSU2rSv7VE=;
        b=Ti2Q+/Do/n0lXaQbTsEgc36MNwCzU69a2UwU/aM4UVyT+0APkqrvgSxz7ip/co6NT+
         hJpkc7WlvvOmVjHZTRRbLsq3YVkBSyEMkW98o/jGKcxv7cjsAfdTW1WMefXOSFjv/wgI
         ajis3kEu6Ve9Z3bFCwbMLVcVuL9yevc76ITRcB/OZpayhEN4yq+PYkwmSGM3IjT7FXEx
         QrYj5/7erFAyaKOnsDV2ZbHaeDSRvxIIZmnkY0p+Sxv+RCuATmqTkcxrWurZkOFwCU6b
         qBlReMZfRiSbqmBp/CA1Srp2WlEO8oZHCEEi1jjitLKUxr5gGQ7dG2Ch/ZhowmCQ3XHp
         VYFQ==
X-Gm-Message-State: AFq9FYJiEB0tSz9WB/yT0TY9eU7CePI0UuRUFxTUdOZfqt8DOoeEcmSx
	nrmJZnfBxm48ti5LjLCneNJIfBcRS7RXeMZ2hQEEh9oxNaHP+y1ViE6l7yPjVLiZxdjUED9tto4
	cygZie6Pl09UfQdMHZ8eQFb1yuLn+4O3egSyLO64Y0g==
X-Gm-Gg: AYBFou2gp/wyBBgrEb/T6xkrbBXuFNBGSSR+6vzY2IBdjUvuTaRfbYSNOOjHpx4I5mP
	bSLJ7EG7FFZWhHDWRj2+TROBCLjqYh4YR2UiOZ0dnBH610c4d2AYVm4eq8nZeSCQqnxaLo03XAs
	u4DYER7IaBsXBUxqaGiWcoR14Rk2QmlPxVIsf7vFoei3zT09h3LRermbPtcH3DoT/V5HXzOyRlh
	g7LmK2NHOruTVQF2KBuQSCb3gd6TF7IzkleiTGy6189b0ny9uTr34MT8lz0sYJiYKzeMw7w/UCN
	0xKZt4XHVogXNnpqPcufafkiPKiSZucuSYEaPtycGqNrX5pDUlMSfG/AK9Rq9ILZHQ==
X-Received: by 2002:a05:693c:808c:b0:353:7e28:9c58 with SMTP id
 5a478bee46e88-361a3323b50mr13739930eec.41.1792435638102; Mon, 19 Oct 2026
 11:47:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019174258.1375583-1-jkain@nuro.ai> <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
In-Reply-To: <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
From: Joseph Kain <jkain@nuro.ai>
Date: Mon, 19 Oct 2026 11:47:06 -0700
X-Gm-Features: AclHuK8UH1QOH2EFc3ZT-WkryAT5MFnjmPJLltAW_ky2Q_LYaLtOPSHKqrEXEko
Message-ID: <CA+Y90PjRyR2czC_Y8G3wdttj2YoDMb+OfPDR1_KGhbu0rDquxQ@mail.gmail.com>
Subject: Re: [PATCH net v6] net: schedule a purge when the defer queue rejects
 a free
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, 
	kerneljasonxing@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:58=E2=80=AFAM Eric Dumazet <edumazet@kernel.org>=
 wrote:
>

> Say not to very verbose changelog, that nobody will read.
>
> Since commit 844c9db7f7f5 ("net: use llist for sd->defer_list"),
> skb_attempt_defer_free() increments sdn->defer_count before testing
> it against skb_defer_max, and keeps the increment when it rejects.
> __skb_defer_free_flush() returns early on an empty list without
> clearing the counter.
[...]

Thanks, I'll use this changelog in v7.
