Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FC5237B5
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877630; cv=pass; b=Nw03rHRnQmD8eH8l15loecgz/McxYBgYAY7XULSL1eKOv7e8PPIIZONGR2qlope3AmU6o+rrzRAvUB71dx576EGwQ+EJ4kGpXWQteDiidUCYsJd56Ow1tvO/1dudU01C5yPzZx9gKakR3NTWQ6hYkkeaxf0coFLXWv70zrU0Tu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877630; c=relaxed/simple;
	bh=G40gAzXJ/KRD6Urj3yKZHUekRy6EMDt5/M2dwvTRP6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iT1WwsYreI76CbnNfcTzVV9kwtFFqXl7xRthbDBtgKFtfIAZqr87WKE4eBLJaD95b0thsK17yM0GDHoxA2BKnbNZe86GY+Kazeks6MgNXgLmKTQOWsF1eeC1n4sSXPsce4qj6hmsg/tU13qxkUIYzZLEXMDa8VuY5vWMF7jd9m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s92MVl+W; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s92MVl+W"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b6036e9c70so3584539e87.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788877622; cv=none;
        d=google.com; s=arc-20260327;
        b=hJ1kCWeBdoKV/SD22Vem2JaQC/C729A20LXPZxoMXbkVwgaXQoSMF7nNbjCG/GWfqv
         lSu08vbqP3zUAoewcsW9PmsvoLMxSqAD6OTDR1O1oglfiU8j3+KHmDxOQqW6O6lYp+W2
         CJl4kRe7TdGJ1dXAN1pEKOe6/21MaY0+uxlqFZJTXxa00mqB6T+67Ir3fhQaeKypiHQB
         APkze8+c57+dIJvRkIT8+7MxGyVzRx/SaPaq5R9uSiuGXvx9C8SrpUtB1LIHN+lxnu1n
         EW4sSomJu4xPj6aIySecmfsfTH6POHKbtvgYzb0w5YjNdvH7yjn7CVtgNsVjZ1PD3Jii
         6tbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dpd270tknPT/7fUd94zwp0IEB0jSoCHjnSje/HknrcQ=;
        fh=Arow8Q6zDPZZLWfzUzcXk8jalQofPNfq6jQHXIdc5ts=;
        b=Fd/SnprLZVjVDeOhupLWGmC/sOixtbm/oc0+RrZq3kg4J4RMfwZ44Hxb6EerUbzCsW
         x9Y1fvqIHgxK1j2zVUARN+tV2jQSCQXROKidMN3zgyLOcts962ksW8G3DUHEXvkNzRHL
         mntbM+jIu1dufUiqqBvOIV9XQ/g850OFjcolN60lJrvD2ymtKS0YGkyIsAuVuVl38WWN
         BFnQTQZBIWjGQTgdJuRG45iB1hGEj9oK75hfu47NCfvSxSBrGEdQBayqLhcnTvmZ8G45
         138IefcFE6G3hRDzFk1Es+1rjAmvQm7cT7g4cibgpCYOTz4LrOk7cHvHKXhD3Npoo2Ru
         47fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788877622; x=1789482422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dpd270tknPT/7fUd94zwp0IEB0jSoCHjnSje/HknrcQ=;
        b=s92MVl+We0I7bRSruOBeWLO/N6wI4qHorBGago/LfL5vqA7E/qxwkKevhKA+0Rt4a1
         QNERmG4PpoQC64/KT1KZWYeLY1kPS9DvIg80qajHeQGrqGjItI+oyKSVEG1bHpvGnAVV
         hdsWJDuQLiGr63ziNHu7nnQmpIMH50GfkvNBhFl3/o7db0CpeZMlfcj3M/1XtbQMRh/z
         o+PwEtRFQF9DP5H34PZq1liClOehK3oMtTsmlDHZ8nUw5WRVO93/hLSlIIzJMGR5wFpX
         yqdXEiqdOZCZ1v4+GN0hLK8VKoLEvmjHRtIs+3OZeLOLk2wZdLoh5PcKl2WTeiaxIX/M
         4j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788877622; x=1789482422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dpd270tknPT/7fUd94zwp0IEB0jSoCHjnSje/HknrcQ=;
        b=OHML618uGfMxFwxWoP35Q8MLSyt93bVwXG9aNz/NPRoiuDTUQh9CVfMyfnzOKvbK4c
         IHyUyPoF7ZsdcYi6o3fsCPxwcfo/GfDQAoi2a3q78M//Pf4szdoucDEUN3CX8PMyBRtt
         b91dTc6ay5NmbxvysBneYYwoj0byP1M7LnGUX7B1ehugtu6vXTdTd56Zp8G3Tb+FSgkE
         1Q+ZocspT7UugTImGdbihp0oBd4SD/CD3S2FH10kKakvLf2K2REKGwUDO3f1JlwBiiO3
         Ri4saj9xR2V5htRZwzy3dx5ha+HyicLC/m7e+bmx0AYwD2IKdzvSuryCw/no2IjeP28t
         NFhQ==
X-Gm-Message-State: AFuF++l5kr8og1fFEloPJ5kNxyxxmjPX08sn+lekeSyONfwc/pVrJqzK
	A8mgzoGJCcEJNlDMcp9NlySgBfwPXo3tsnjVy8G1GAfbrRylV4h1D3OCWugkNOgwDa3rMSkvDr7
	ydZrxpXsuF/n43W2C2FTx5PbM5t+Uzy0=
X-Gm-Gg: AYBFou1lJlxYpldIi02U77Uh3A/C59PRBwsYKHDQZUSPMCTKTg+kaeX2bQoQdUcR6Kt
	VUqJ+AFmnMNTgzGGygQlgCMU3hgTh4Xe90ocNWbfOdhUTx/FwRVfG+hQH2W8POPYrb8ICRq1HTT
	oMOxwIjeZxIOAfnFvqqJNJxStfSf7K2ZPMTdaz11uGk1NvJ2QYFiPukMmA35vZzWSQpG/N8mlIo
	af/qrJsf0o/OjKF15hwKTSyO2ke/dzDgu3LrgbcSYAd1yiHEl8PAzppv3oEzid7Ypldm51asZez
	gIYFtXkso9isCD+J1R3JTrq+Xv6WoPZoSE5kZ+6f4H1t4c0B1pAHJbP9sfX1rY2U5lh1WCXDa1v
	dk1PPjp1Mfx+Mh0UIXpupE5IsL9yVIV9O6QOkJFdYid26Wg==
X-Received: by 2002:a05:6512:3a8d:b0:5b4:a836:13f3 with SMTP id
 2adb3069b0e04-5b6170525c5mr4837266e87.19.1788877621708; Tue, 08 Sep 2026
 07:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908040041.124640-1-singh.amitesh@gmail.com> <6ec8d359-727a-4fbb-9ef1-3b96d05c2942@lunn.ch>
In-Reply-To: <6ec8d359-727a-4fbb-9ef1-3b96d05c2942@lunn.ch>
From: Amitesh Singh <singh.amitesh@gmail.com>
Date: Tue, 8 Sep 2026 19:56:22 +0530
X-Gm-Features: AcwNN1UERuSBYnvxD6bD9Ff5BlTxZcUPv7qXF6g19NK6FwHipcorUa0YckBsslk
Message-ID: <CABKcAmV09OY8fh-iZOBMzqjfUuTqsnTmKOnMxevAF7fi4SP02A@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: tag_rtl8_4: push VLAN tag into payload before
 DSA CPU tag
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, olteanv@gmail.com, 
	kuba@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:20=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Sep 08, 2026 at 09:30:41AM +0530, Amitesh Singh wrote:
> > When a socket buffer has a hardware-accelerated VLAN tag (skb->vlan_tci
> > set), the upstream NIC (e.g. imx-dwmac with tx-vlan-offload fixed:on)
> > inserts the 802.1Q header after the DSA CPU tag, producing:
> >
> >   [8100 VID][8899 CPU tag]
> >
> > on the wire instead of the correct ordering:
> >
> >   [8899 CPU tag][8100 VID]
> >
> > The switch reads 0x8100 as the EtherType, does not recognise a valid
> > CPU tag, and fails to strip it on egress. The raw 0x8899 tag then leaks
> > to the peer port, breaking any protocol (e.g. batman-adv over a VLAN
> > subinterface) that relies on seeing clean 802.1Q frames.
> >
> > Fix this by calling __vlan_hwaccel_push_inside() to move the VLAN tag
> > into the skb payload before prepending the RTL8_4 DSA CPU tag in
> > rtl8_4_tag_xmit(). The helper frees the skb internally on allocation
> > failure, so returning NULL directly is correct and consistent with how
> > tag_sja1105.c handles the same pattern.
>
> Please take a step back. Rather than have two drivers do this, then a
> third, a fourth, ... should the core be doing this?

That's very good advice. I will do the changes in `user.c` and test it
locally, and
send a patch afterwards.
Thank you.

>
>        Andrew
