Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECF233920
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 04:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261451; cv=pass; b=JkAZBjZiEIs3dkuFlHHke1i1mXzZ5XipxSGwWVCpGPBTvF6HHutgr/3vPxKk1XN0D8THooiWKytZ0dph78r8sEV+QIpHoOEiSLAopFZQP0i59cnRFN4m4Iv23CtwS/QJ7iIWe7AWkBcUFJMSV6j0tNXq5WMJiJdbGf1TsSA/xeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261451; c=relaxed/simple;
	bh=0AndkzISWXJsmL1SMyRIFmSUfipTv5pei0zq8nnuLEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTszOUPRgmgZXX0fefoYoU8+Y4H73zpIoM0BTWndOJ63y/NJQv3mlatZzosmzh9PFJbtGbJA8zUbQuzlc27hUZ229KLlRG205MVqP70yFxBj9yY0HBGfmlLxu2idHmF51tjWJW6v0bgjsVNq7DzjG3JnC3Cj+JrzSWNVLJiHxU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfTmvTjY; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfTmvTjY"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-78fb9d46f0aso52052137.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 21:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791261449; cv=none;
        d=google.com; s=arc-20260327;
        b=U4csIdYXliGBMLnpiWyk6O0Gd+UAQLKuN6gRFxFw7NhUdGl0jaPcu7XOq8qOV516a8
         9/AZsBPsg3r58gfHNCNvpHspPnrJb98hOQLyqb8H6dju8H31jIz7sNsTmxnnso0s6jws
         TMI7oWvIEe/XiF0ISP4uEjtquNJW48DNkkPE/+LRhei7Yfi7WdF43bbuV406GJ3L6FMb
         4IHybJIJwt7bkFzI03QyruF41odsFgnfe2bOFewqj5roYtvYPsVS0J4LIbuzAL+f2oJN
         CElUaNsp9KrLuvmejfWue7+1/+kbqvTOpvGDc6EbJgPPpp+2H34iIERVxBGuPiM/UZO6
         kRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AY/4/mZt0eY3/2zGQJ4VfDnIKBzDcXDkb0pfkxHi03Y=;
        fh=HdMEk6zsym3pSBIbZaJSkpz2GZD4aOs7KYCIQy6/058=;
        b=dyZ/ZviR5+VR1zn9ahI03b9y68DJRPI+8UFQw4QZftXxck80adWzs7iE1EN/LpaXH2
         euAC3fMr+FJvE2GBxakRbRMQ3UJNVgFa5oanmQnRctuxNYLnYs5yH6Yr9dO/EB54LQZJ
         7hdIkEOcizu7MaODEbnCNaBVNffF3PxAyDTYJkWATvpraLqLUYz9Z0CFHkdlaRct+HSp
         /QQM2A5aHmnDNqWT3Ebaa8xOBEEK4AAOyARm32/WaBKaKbJ8WSUdA2ZkiCyy4rTNgJ7x
         WZPXVObX/WUuEZsptwddJdOLm14LyhhI+WxkrCgGEpOg+t9K0+FtR8e+tZwszXky5Uin
         DPIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261449; x=1791866249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AY/4/mZt0eY3/2zGQJ4VfDnIKBzDcXDkb0pfkxHi03Y=;
        b=nfTmvTjY8Lbl9tWgkjP0EvD7OH13VNxrkrkQrITwbHmUH32shShBasCmrT/vrjZQKX
         6jVkDDRGNQdyN7iqoHLz20P0DBhxQXXQfwwc+SWu/5H2rpjsvJ2yU39e2cvj2cIvwnWq
         xLEyofjFxvACsOYf0XhAlC0ZlARag/XBH8Bf6gYvG9kdoegUSYItwYd0Pqz14KilgpiP
         todinXfi2rAofdv8NcYMn4KswBO9LNip5SO3PK7k2hfRc3E5BlmsBk8EPv0a5HT084AZ
         gyFaW7XI2USyr7OoJKQU65wymLk9aC19kINKck7Q4i7eH63QjJ5ZkzTrcrI3ZZ61oSpF
         C+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261449; x=1791866249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AY/4/mZt0eY3/2zGQJ4VfDnIKBzDcXDkb0pfkxHi03Y=;
        b=FyKU9GDEOekEC7vftda2R/wsyYHwI1hnDJI5Hvts3C5oskCHbyGg/PX+2PczQg3QyL
         U5Vm+efnvEo2M1bSWoHKFfDxN9Qj/wHsC275Mt4v5vjjNfAOPZ9OHjh8Zm6SbXSG64VD
         XJalZyicgEJXvUsoHLYKNP82NjKL9zcCSOjDW2H57/T39Q5ggcKHD7orjaS5d111BJBx
         DYe1yXuwwguvV4CjDBUV1cEIjbs9t7Uz2uamvYLILwaoFTfirOa4TquCv+e15Xw1OAFZ
         x2Em33rnl9/6+ind0qSh1UelRlRWiunVU6sYi1gIg5mCOjMQZ6Fb99+RsrIpXn8Su3jH
         TbKQ==
X-Gm-Message-State: AFq9FYLTeDfdHr9Gv4/Ds3QM7v4vJxaNU7ZOdzGReL+GhWZzq3JVNAvD
	x7i4cGoAneSQW+LFdzHskGIP+ECp699GH+q9TaNtfXGXFyoAX+QxJkqec99FixIw3QJKFvvplHD
	GsF9Kf/wpwD99QnhhTN7MRCcbnnUXFKM=
X-Gm-Gg: AYBFou0idm5hFyRmdv+kOfbyu4HjjaALbQeQKdJXMNjEzp3dl8WJHmhOSOVIJb5jXR8
	S4zVdJgjBL+rVQyj5ObHGNwonNZNsOOIRH1rjO4nsXwHayMgEsmaIpPg1MX17CyNzXs1vtfYcOp
	oeNyKrokTcvABXVSwizdSw+iUW9dZ9Y9ntn1R+Ib4/yN/pvYlQ3O023lHy693xP+6aDmdAnaldY
	F2wDW71QT0tMuavJ83u7EDEjJCWnYGkRGPHT9ZaA6pTQtNRafbeksjTyoBBFf+QjFyD0dON6ZzH
	2M4U3BbEJomtE1p5qWvPlx5e41ibnbaRUG3KY6Dgj7XDK6Wus8961Lhr01cX9aObTH0JexCxQ5o
	2+JwfLWVuaWsavO0FHgl7WlX6StUDcDz+QKayixSZFKKDvIrWh9Ly7KJIrIutZV/CnwubdFisZg
	b24PFWG/xiwE/mK7AhFzzpCphO3MfgstW4bMGbTYPJ61Bz
X-Received: by 2002:a05:6102:915:b0:7c3:9b2b:7efb with SMTP id
 ada2fe7eead31-7c87a31a2demr29458137.16.1791261448899; Mon, 05 Oct 2026
 21:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
 <179082834895.31693.4009727999698761506@kernel.org>
In-Reply-To: <179082834895.31693.4009727999698761506@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 5 Oct 2026 22:37:18 -0600
X-Gm-Features: AclHuK-ofFt6slNz98bqVopfHARNnkiLXB8RVY7WAXdbkjgJ1j-2L7i2_F7ye-0
Message-ID: <CADvTj4okT50YYV=t6ZHD12K+XEBpz2B-FxE6C8ApkQeKXLyt5A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: stmmac: preserve and restore the
 installed EST schedule
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, Russell King <linux@armlinux.org.uk>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Simon Horman <horms@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Richard Cochran <richardcochran@gmail.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Rayagond Kokatanur <rayagond@vayavyalabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:19=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

My additional replacement/error-path fixes were found by source review
while integrating Lorenzo's EST work into the larger stmmac MTU/resume
recovery series.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

These were source-review findings, not failures observed on an
EST-capable device.

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I have not tested these EST paths on real hardware.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
