Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793077866;
	b=Wl0QiAD3i4SodOLsFx4RD8m/eISKllh9x2ISwITEysB8eicNx2EEKbS16MslG48l94WY
	 nxJ2I8L3ReT5dIyM0iv4faifEEaPR/f00FqPlZTuCrKafsV0hUc1aEtDbsZnIbs8Wn4R9
	 ptD1mUsrjYcyav0YhpNq8dC6PGcCQTvt3QlS67cxift4DSGGmWE+7yauRile7yuQm3Pi7
	 VuORnc2XhC2iBJk4Q6NGqs1rocpXjhGBuyW0Hn9GY1/0urGHCvHw0izmBt7g1qVOsEevF
	 7VNkib1f7EYNGypR+NRezQhB/4idIX6AjYHayf4jRmY5sRxdLUFCWsSG2lsw98OOzMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hcNgqETn4qg51KIAcMQi3G8nxBEASfodX0BihEo8ers=;
	b=xfHliYd1iM89gQFkM7ka4fa4T3xyghoiXtl4uyL+9CNNOUQ79m3X2RAG80lXF1CYyI1x
	 z52t/TOgjlAI6Cg6uUQcDu9/gkwwmWjDqyxyJDZ9/wVlmNdvxfWEj7zMx0ywKgo1yxodU
	 WkoJkMNVzgCiXoLSIkQXEGu9x8/t5h3ss88CuCBTMn5AR45aIraGc3XCPjeymGAO+upnz
	 O/tX9WBw4VYoFrrHQ2J2gcWlmpReX3gtz3piqIQarvJYYuvAd6cZyj+e1F/ViifB3zhmu
	 5oj9miHcwE827MFXh6lOct18dg+2f8NJ92jDWxooWrYPy4JxX2tYZqfAWbEg8zdahFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rIng+qXu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB962606A328
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB962606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rIng+qXu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91befbcad6dso64163446d6.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793077865; cv=none;
        d=google.com; s=arc-20260327;
        b=lStMJwGaEFQHuN0FcA4Q188OwD70zMlEmUFDCFHFxXLg/dMiF/IaD9c7LNyU+pMAF8
         JzziCwycFC7aN/n8b1Oxdlj2dJK0myvlf2IyyYiEdeWPtlfsNhU6ZUJ6/BxzfyHHBR6c
         iLCGtJPuooTUOsg64YKjWQR99n4I5oDKra7J2lorqFo8LhOLgrVBilNsrNdq7Xags/2X
         m50Rq2Sk4+hWzBfWBb/4I6HB+HnsimEeKifasLuRXJN16WIxixbyk44Pqc23lkVlojER
         KxsQ4XFk7EBInNw19GGYoB0EKDBGUNrRTodkLQfzuchfim9nBl2Xb0jbuT1KLsTObM2N
         EnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hcNgqETn4qg51KIAcMQi3G8nxBEASfodX0BihEo8ers=;
        fh=Gr4Yc6oYa0MTlB7hjj7e5yQ1YYXnnCLLzdVmM/joqrg=;
        b=pKZvgOR2CIAj8sNin9NDrWdwpDkcZR80jZjBKobzaCOG14V2Y/Xv1TicF4nVaUliD4
         NgoqYHfiviejua5VR51P+x8x6pjeC0UdFM1xRYerJXiLAPnoi4kCvxd7tEbJ9xla0lnt
         wIdEe2/qgTD1Pv0Z2l96c24zr1ksFieorhySNjzy29tyybeeIDcwSG0dOUgTRqEhEVbr
         os3TN6E/H++SPm4utLilgfla9nNnnO7wQkMEy0eeigqHUy2XHUlnnQuV1lxwqHagh69D
         pjM2AbRtCJ/qkHgqCHJm61eRO859GTzdxCzvD4mGMemV7uPxQhQIVGmADHmbOEIyaGwN
         Wylw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793077865; x=1793682665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hcNgqETn4qg51KIAcMQi3G8nxBEASfodX0BihEo8ers=;
        b=rIng+qXurfJFZxT0RCoaYirVO3IL/w0C8jVHZFhFKiLv8JNAlFJMB8he1Buv5BFHNQ
         zQ1By0HSuQJqxazI7ykxj+3rSvVBJdgZN9hefkOCEIAKTxLyb9XDaff/wohWf1F1xS4T
         f5KcfTT6ieuacJXIOqpjAMpKaCpMDSTRe2UMnq6R0m3IgNONvfg/f1cY4iLIYyh4V/K1
         r/oKuzElfxGliQuG9/ji8V7DY9zVBl6Yapg7a3U0AqchoUJFnHSefMtgJt/L5L37K3NU
         uI5p110StyfiNjt1wuHu5+wV400lcxCToLXf8f1aIc56aAEfrXopKOjT/fCnfkKGCeeH
         T2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077865; x=1793682665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hcNgqETn4qg51KIAcMQi3G8nxBEASfodX0BihEo8ers=;
        b=BuSzfRybTRSI3PnL22JSwNLUHWn5eWvvcL4kKIqOSImoMu3Z279aMftR4A2/BwVqci
         Mo4hqYP48fhmRnJC8hgLlrJ/pu9HyQFhgG0H+vwiGwnRG6tdYAb9AUrtgCil15YUErTN
         XF/0kVsEH5l77tSSP+h4Z6Xd7iL7QHoYStTEl45oFU8oCtaqLj0KcjMu6FBLTwL4L03M
         nCR5er7RIbiyEEa5nYoG0QLih1tzmnRPYX9Q9E5W95umpcsnwBSvPtJXr9rWqGM9Dr4K
         U8cKVio3Ph1/PnXj0f9P3SvooCVvtKLKvAEVr0VQYTgNrag053R7LMPM6CAOlZSJ+mV9
         I42A==
X-Forwarded-Encrypted: i=1; AKwUvBw8lfxE33Lrj6s8DhRiI6wDezIiJOu/w6lyM0JFACLdMUa7G/wq1ThFIDawlcbYwsDL1doeJK8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDkFK/JNqijUyF1rtKxju3srGjdDY1idnY7hT/pZ9q+wpNfJLK
	mEEf3XbBURAWCUS/U0r8LPJAwWXGTWPY450Rh1IGVq5HTEayVdR1jk0tQvlzNEZiK3kCM72IZnr
	NdP9TaTmcgsk4OHLCTNNTpQIgXFSgwus=
X-Gm-Gg: AYBFou2NKr0PpYTb41Km5E6GpELRcF0IX+KSTTKuy/mT/um7yzI3/X6KReWmMCA1JMx
	G6BfambkZafML3UubLPbW+5dP6a69wBHnj3dA63j19hLF7n/vEAwFnV88jpDuzXrlLkBKlrTsvs
	9pqTlIQbq5dII68FBUqXUVphmKM2HQjmsonWxx17c4BX1xD9SqT/lyShh04vEyncYDVtUlEJZDS
	nUBRvVtufLecZjbAlQuNk6yzDkfsR10shfHp+p6K4UlZhw26qZTwm5ayWSUgX9eLibHmSv8yevA
	l1/BnojgUu+omEMKaK3Zn1wqFRi3+9/FRneaOV891E4vh2pE5/ngM+2HGi05Um1qFIwuDJPRUt2
	4tH6Jt2AoiRYamNqriKA4nBJcqo0fG9exWtcSz979Cm/el/Fq0PdFMnx8NvjfzwbUu8tPcPnhAt
	xTJvFhmHARm3GHSjf9mlk=
X-Received: by 2002:a05:6214:48e:b0:919:8962:53f3 with SMTP id
 6a1803df08f44-91c48e41550mr169271956d6.14.1793077864886; Mon, 26 Oct 2026
 22:11:04 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021155629.68813-1-phx0fer@gmail.com> <20261022054811.35008-1-phx0fer@gmail.com>
 <DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
 <CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com> <87v76o63qv.fsf@cloudflare.com>
In-Reply-To: <87v76o63qv.fsf@cloudflare.com>
From: phx <phx0fer@gmail.com>
Date: Tue, 27 Oct 2026 13:10:52 +0800
X-Gm-Features: AclHuK-szubO8IzEfkitMXTwqSUXBlid_2AlglfmxC79PBz8mekTtdM3GkUQCq4
Message-ID: <CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data races
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub, Alexei,

Sorry for the long silence =E2=80=94 my laptop died right after v2 and took=
 the
local mail and the working tree with it. Agreed that the ordering fix is
the right one; please go ahead with the commandeer, Jakub.

I do still have the reproducer (a KCSAN selftest for this race, verified
in QEMU). Say the word and I will post it, or send it to you to fold into
your respin.

Thanks,
Dudu


On Mon, Oct 26, 2026 at 8:33=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Fri, Oct 23, 2026 at 11:53 AM -07, Alexei Starovoitov wrote:
> > On Fri, Oct 23, 2026 at 11:49=E2=80=AFAM Jakub Sitnicki <jakub@cloudfla=
re.com> wrote:
> >>
> >> >
> >> >  static bool sock_map_sk_state_allowed(const struct sock *sk)
> >>
> >> Code LGTM
> >
> > Jakub,
> > Could you commandeer it ?
> > Dudu is clearly a bot and doesn't care.
>
> Ack. Will drive this.
