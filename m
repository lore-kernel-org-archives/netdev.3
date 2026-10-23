Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792764781;
	b=vQvRxKCZUdtIlwdHRP3AZk7MXGdKAcWMdaFOc1IQH+dGoZbcxPAOUrXL4Tyk6mWreZpe
	 kxf9Y1R7aSqeq1IDvu60awIEjZL5iFipVl0kVLIyKP7mUrgH4gkT5XGW99nbxmPDygKeY
	 ud9LAIDz/5iTgc1qZsLC6OOGskd7n/kcWiKWudON2hFd5ks7TqSz/cbOBlkVuXJP7qCij
	 TkLI53OtDfxbeSz+P+kp9nJyTTOB4ReI3SvTeJf+8fGmjY4it+WDHorykoFroujXIwcJR
	 +6uwEqEULlAIaXkvMiDEpy/WE9VXOlbK8trjBm4QqA/L5kuYOKUuYkQnMelNKYBB4tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xkLt3lfrbsQ7vfYdIskLImlrhPYw2t6MqVNHm8RXqsw=;
	b=j6sbuNAMMPRiYhUMA0TgsrlNARVgSMv8QsyadIJwymzM+DcXfwyw5sQI8TlOHKMjCyY4
	 NCAA7D2A6qC3Rbxjq+vwjySMt1JDCrmzDk43htl1kRVJ+bMMfV0dFgBth8c96ZAem2CK7
	 nF8r3Bir5HVJ9T/Bt+FiK19LfpXkXMKcOQ5yK/6+mzEUfsiH0O0cBKQWLyBGo8rUPuab+
	 z4XtydaRbzzf0ItlsKAmdFTsWfRd2gbs5CUfI1nWwWiKUGOSwWA6qjlG5w06gA7Pk8EuZ
	 9OiaIakyypyIARB4Om8T/G3LoX/iB1J/5wpNQfkzr1S9nbTaJiXuOUrAXdp1Dagpv1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gx+2fJ4+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE10606A321
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE10606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gx+2fJ4+
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-150ef97e790so6672c88.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792764780; cv=none;
        d=google.com; s=arc-20260327;
        b=HhfCxI3ut1YnkGcFdV7rjyITe/Yu1JKnADl+AI49wABY+6GpUb64eGFMeoDKI9RtKK
         XR+Sf2WLGtRa2ZXajFmsCouWe1JFEWLL/NEc5k/OBGnY2g5tgrMv5PVxuVWVwkRgBmdh
         kIKrfR79TqVaZ6jEwwijU5joI5ksXtk+FPl7YyiO7HhLjY7YT7zmpssJsll1YIGOerdP
         OkC396Ivygz4ti0I9ReIh8se0IUNOkchUSyEnEF5NsRYHUY48og/SIiKqYyvrqYOKOOu
         JM9ikgWlzILFB+dxmEWwPc+bgPS6AVhcVmfvBpskOslKX5f9FRTKcKad1RYt2d04yluU
         zwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xkLt3lfrbsQ7vfYdIskLImlrhPYw2t6MqVNHm8RXqsw=;
        fh=I0b559lHL5EuXxufIJFl2Vh8EwXze0tBA2iHoLvo0eQ=;
        b=CAwaF+OqTIycb0aLxl585pnjn1hdnRybgFiF0V8AvcYtB12TxVEztKayCh1BUVzJd7
         f6PTI8JIDq9UA47JGxYJJUyv+lqVLtYKtP0YhxB0PR4xoljpqjFKVJEGKXjVDpYP9cwB
         Sz74+J1NiP6+W5w89smGrayWx3SSisM7LNMJ/AKY1jYfqdq2nmhEIELQ8LCfuzx2otth
         qhs7rBdYNtO0/QgLVUki69bUKTy/plUal6x+Q3NzEO0NH1ribgzybcqeDMLBSNrU+mzp
         hH9J3glTMMpEo8fZOyq6hgyRkXP90ONG8/+UdavKutU+fWMvIe78NSjqnfZSluD6mFIY
         /cFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792764780; x=1793369580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xkLt3lfrbsQ7vfYdIskLImlrhPYw2t6MqVNHm8RXqsw=;
        b=Gx+2fJ4+NKa9V81eYgp8m0URc4qAsxD2kQONuD8C3gU3DKEMmYWkze5ZkF+25eb7k5
         aJGLgMQ1njzitVBSXwao/PI9cFuVbA3V+OU2/c/WnRIgzDUX8Ssvlhg5TbB5stkMYq9a
         cL/RYKe4QUfUbEBvxU9foBBEs/D72SoOtTFatlh3oP5n9OwgJueXcH4OyxGqIsxeLyUi
         cn5JFVvIE8U0q9IU5GkuJCFRcCBkPacVOvILN0m8SRMy4kKFtw3gakyxz/FrnYb3VsqD
         jJOfHPA8rbQe/+yOLnt5UwsDBdBFTZSW2OebdR7wKoWscqAM8rExKV7y0scb4qClSwJ/
         YS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764780; x=1793369580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkLt3lfrbsQ7vfYdIskLImlrhPYw2t6MqVNHm8RXqsw=;
        b=OueAX+5qtAaPPcn27h3VtjVXdqwZb+JKbHSvm4+bs3wBq9jz90SsoMPFvRPGTmJ/RU
         wJ+pRw6TDPYMXeiLi9EC/NSk3BW0Cez+HD7SMsfhJeh/IVhd3ssws1VjZXLnQ9uuUjgR
         3Lhl9+3UX9iUR97YMuya8VHiSBEsloJbbX0ofL2d1T+OnbaFpIj+x6X1I7Z6XN70364J
         SUsUmyqehGQfYVAnTYderxo9BdTupvGX8qPwT4Psnd+BGwNhANGyXdxDLVSB1si2ZQ9b
         IgXdHQwtR8a89e3HxC3m00LpCzxoZsJDUi5G5uf2Dw2SqJWSJxkpZaoKvJTlcygM5r+P
         vYPg==
X-Forwarded-Encrypted: i=1; AKwUvByjP+iRRY7TumTs7/gdQE72ECCileq03Sf00aBdmncrAfNee6CWKBj62cbScO3G6wVmmFgBmnA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI77l+tg50UtmK2kbtdp94tK8mOcoDxCohc/9GDp2sOrGhD4UJ7
	w0FVZPoOEEdg85bFeqr4nqf9Z22Gg+vqD4nR6aR8UH0rBi/73WgvbgXJNp+jHnotrgNmEKOfRdT
	ryuTvBm0eHc3Oy9K5g3v/b+/g10sAZpdDcZvAsvFp
X-Gm-Gg: AYBFou0qSPX4Q1bDPk6jh8g5DB/05/J4kCPBx31yHlIBK4wCxCu53D+nLDJZwr2KMKR
	+/h8mGmXyickgmMwuQWIhprlP/F5L/TfaJVZm6eWQlxoWZpo2wQ4KFtiJzZnssLJUqNSWuK/CQy
	cqYyDLUT9NLLV8oV3mv7EDVcdGxIILf7yW5uRBrxJaQoZdz2YBtcuZfdtPJllFnb2AGZtTiIfNY
	0bvT7EKWKcyVokm6bx0Gv050kggQzC2+0NfKtCa2qVuGxt5z6N1agHg1gZ3cWbzizDo0z99ioxU
	q2QJxBBkdYr8wFm4c+XX4vgwQ2htnoISEV+dz0VxKdfBuIs2XtM2esBx6YxZ4poBLmKNuSI2ICr
	bYMMNAejnuRdg4HLusDj5MCUEsRalB22Z/5dKLd7hj/Ow8VY+UuX3TUUhKuaLHgg95dii
X-Received: by 2002:a05:7022:6ba5:b0:144:f802:8bf1 with SMTP id
 a92af1059eb24-195f96f6e3bmr421525c88.18.1792764777402; Fri, 23 Oct 2026
 07:12:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-skbuff-bug-on-followups-v1-3-41dbef50b9f7@toxicpanda.com>
 <179273111951.3134.3452028799437573017@kernel.org>
In-Reply-To: <179273111951.3134.3452028799437573017@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 Oct 2026 07:12:39 -0700
X-Gm-Features: AclHuK-tcTcrResIEJF7frxNES1XOTcAYvLS5iUmn3CVJsSLoqeepm1x0REGvsg
Message-ID: <CAHS8izMBEkxtS_s2t9uX4-RLxxM5249U_y=G8_1qtr+y3jL6=w@mail.gmail.com>
Subject: Re: [PATCH net-next 03/15] net: skbuff: fail checksum validation when
 the skb can't be checksummed
To: netdev-bot+sashiko@kernel.org
Cc: josef@toxicpanda.com, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	jgross@suse.com, sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, 
	fmancera@suse.de, david.laight.linux@gmail.com, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 9:52=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix does not hold when conntrack checks checksums first.
> - [High] __skb_gro_checksum_complete() (net/core/gro.c:794-813) has the
>   same false-accept defect this commit fixes in=E2=80=A6

Both high's here seem like legitimate issue, al though the latter is
maybe pre-existing.

--=20
Thanks,
Mina
