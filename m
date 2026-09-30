Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98152234964
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733435; cv=pass; b=tffD7slZ/91TP4V4B1XXdlQql5N5bzp5YkuJC/+giEkhrHAvNJCFjUKcutVPvi30Q3XG97xi7bitWAd9l/uutlJOb0km/6NMavQMQDKUfsURcjWibasVqj0jNZRKiteM8RJw4H9HNQmMaPCT0ymh8n6WJZPIrLRjmVgTP7kiSME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733435; c=relaxed/simple;
	bh=EJBmLtlA9CbcZFNhGFhs+lZO9BwH5Y8mEKEymm64wHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7m70RaCqcA5ljZb6CSAxpQMXnvDVoOzxyKuWBxUGjCmFJJmIflg7KwhgJmOIxMzAI656tCn0b0hO6iuKbn8DL0M9USNlZhI6FmGZ8H56lKCLXJsyzKWBJajYoV7m1AWc6h9WH+izgMtEH85TrZsAC/c5jwmkzeu2hoQEoyJ2zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3xozSTN; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3xozSTN"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a773960275so458391fa.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 18:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790733431; cv=none;
        d=google.com; s=arc-20260327;
        b=EkLQq/zoE5Nzq7mh1v1Sm/iiGDGTSLfnE4Y0mqN47xDaBIExMMtI9HBCtR0DH0jtQn
         tBuvclBssmdMPxIH7Q6J+MQS2HrEVpfnAC4F0u17DKrSgb0zkQV4Da9DQB1leYP5uSvY
         HpVvIBG+G281BFy2JdTywB/JaZHcMQALH/BkrJX50ddlD3Be3GNCfiCjce3w5Nmvc1NS
         CcMa5PHPXRe3h0ZwzmCFof0LzS6NhMaTmq3do0K4sUEErkVZdf2TeLZPei2N96xICnrv
         keuddNRioML2QPD9LikpojzBKCih+WiOE5QMCldq8Z0CRn4o8JCv4AlbIMzs2rw8PaiG
         OYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/rjuboVBXDuh3R0bX/1CQ5MpKEZd6zdJiNiGF/rA1gE=;
        fh=I38VmusOUaOQGvWoY084drwW4PjjuOMipnLwG65bu6I=;
        b=b8EYt5Pgiijmt9zuPGys7ZjO96FPKY79vsnD6ySF9Jdyl1vHVzXljfpuB+MoX6P/gV
         Xs9lwt8G6BIaRhCS8MPoTw1v9hjQINfxWOoPYBiBRDeJy+t6aE/GwjDAVqKafMgSU8u3
         Of0hjW0Ey8ZduAWXcbGfqnyMoy6z9uslgk6p3p+DVFedhQuGly1c8iwWiVYw6jt76Ykz
         dIp4htYYETNID2FMeNAy7kOO/QqnCShU+dUK7NVwvkmakC9iY0KnXcSUdVtH5/tJzrDj
         c1uK7tAvy6yFGmhqLPzn7v4LlZZMszV53t+Ym4WAnKcxUh//Uy6wvAEwVkpUWBGNrL6P
         iIBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790733431; x=1791338231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/rjuboVBXDuh3R0bX/1CQ5MpKEZd6zdJiNiGF/rA1gE=;
        b=b3xozSTNt+7/uNuQ4mIPzto6LPs1bsaP6pyzz6L48ITpjqxuDYz+4FtRzuy3SKb4+F
         GDJauUFk63Sk2FXqyjpWEsPHPWeGvXMeL4+4WtoQOx98cFzCzQWW57JoY5FcI3aIc5S7
         T4cn89fDdKZsqAM06dynX2AQ/T5cNVvtrnIJIcQlXQKFk4srAtdxeAx3ygc1FeD0hOuv
         5l12p6pbN8n1DCoOPZbVKKHcwFaL/s+lK0ioOmdlvYzHjf7gKY3rPcZ6d9KAXfuhVIeJ
         W088YBrt719c/FaKjBgXx6j7pHTWkE8FpQ3sHTSvO1a168FlYZvOHHP5ALmI0iMe4mbB
         rIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790733431; x=1791338231;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rjuboVBXDuh3R0bX/1CQ5MpKEZd6zdJiNiGF/rA1gE=;
        b=BW6AuFTN5NiHXr8QwPssu/jPeZ8cOHZ38llmL8y+Ur3ohmPN3hp1K/zyy/v5jESuvh
         dehlyO4ziiFZKZyH3f2+SEUHD5zC29jjNNrhBNlkt3XzjW+kQNlUinuc2lw2ezCwo+7D
         3+c4dllpzdjJJfArJuHjT1lE1iJ43oztPruM4ya11hOUxjTtHyuOZfTpMkNnYAro7vTk
         nR3xC0KZSisGVkv+f2mR75ixcAsibGwDUREm+LjFWpDIsMpub0/O56Povp8JCc+HW22I
         PKL4yIji/ogEnPbfWUKQGr6wifzcsPBmwuK4euBHRH8nfrPOeQ9FW9HzIrhoep81tZ8a
         gvBQ==
X-Forwarded-Encrypted: i=1; AKwUvBygdFAG8X9lNE72n8v9iRNls8e/zHcLkfL94QBCr0Yu2sxCSfFLCEHIZAuadm6T1pwcyXhdvx4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2N1xVMrduX7X4HVssZKRilIWgG0cqNoUMEhFfxsZGBIe7BokU
	gNmmDM0e6zGDjFJr3dD87H3ScnpYS3yUKaeefcdw2WOog7KUBhrVAVaPZWmQoZr+FIBbG0bKCIn
	VX5S3BmaxFYEBL03HhOknALv6mH5dNvE=
X-Gm-Gg: AYBFou2PUOO1NUP9vknWYIWy/PJS5m2BPDbYHe9igaJyAJjpqMR45AnaeLKbCTakKdj
	yqPTFnp70bj/GdjlaT3SRF9JVBHba0+FXfnewY8TPQtMIQ1X2wKjDhG2/uA2N5y5QXq370QLXAn
	xrio24iQf2he865uoVeLhmzqhBNDI6HM/R8jgNUX1nmQ36pvbsqx5D/u1uF3icX4buY29kLKkHY
	TEJ3YyWlBwVo3356DFFiC7o6U0ttFKA/ciO1sFDMVQIMxmezcjwuBNdWRohNskHzsGmIiHFFWjr
	FuOqU0hAcykUvrtMyA72EIItoLJpaX9YUG/IN1qIZH0UtnruEBGc5KU3d5DAmHshblfBTVkNWJ4
	EeWCF/I/wgPg1YlndvyOnP8DkcyMoZ2oSJq3R6Z36VuhsETcyvr5/eKLcdjzOvpQtnwq1/QZmkJ
	N9XRGx
X-Received: by 2002:a05:651c:2214:b0:3a6:4739:2008 with SMTP id
 38308e7fff4ca-3a7791f4002mr77551fa.0.1790733431098; Tue, 29 Sep 2026 18:57:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924152529.5689-1-kerneljasonxing@gmail.com>
 <20260929165318.6690d427@kernel.org> <20260929165425.53ee002c@kernel.org> <CAL+tcoD4MmRxD_5b06u5toAmBv=6HsbetEk3oZY337DjSS14sg@mail.gmail.com>
In-Reply-To: <CAL+tcoD4MmRxD_5b06u5toAmBv=6HsbetEk3oZY337DjSS14sg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Sep 2026 09:56:33 +0800
X-Gm-Features: AclHuK83VEgYUR4mcSUli3-Ys4F73gNWruxNlVglBapQadBustJfgP5Jf-sWNNg
Message-ID: <CAL+tcoCsqeF92T_Kevucveg04qUV+YADescKfqJVTfZJOUT0Xg@mail.gmail.com>
Subject: Re: [PATCH v3 net] tcp: preserve timestamps across receive queue collapse
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Sep 30, 2026 at 7:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 29 Sep 2026 16:53:18 -0700 Jakub Kicinski wrote:
> > > On Thu, 24 Sep 2026 23:25:29 +0800 Jason Xing wrote:
> > > > When tcp_collapse() rebuilds skbs under memory pressure, the copy
> > > > process doesn't include the right tstamp and hwtstamp from the
> > > > old skb. And memcpy(nskb->cb, skb->cb, ...) copies has_rxtstamp,
> > > > but nskb->tstamp and hwtstamps are left at zero, so
> > > > tcp_recv_timestamp() ends up emitting no cmsg at all.
> > > >
> > > > In net timestamping case, if such an skb happens to be the last
> > > > one consumed in a recvmsg() call, the application receives no RX
> > > > timestamp for that call.
> > > >
> > > > Fix this by copying both tstamp and hwtstamp of the last skb to
> > > > the new skb, matching tcp_try_coalesce()/tcp_add_backlog().
> > > >
> > > > Note that the has_rxtstamp flag can still be inherited through
> > > > the cb memcpy from an skb that contributes no bytes (fully covered
> > > > skb left in the ofo tree by the tcp_ooo_try_coalesce() ->
> > > > coalesce_done path), so set TCP_SKB_CB(nskb)->has_rxtstamp to false
> > > > which makes the new block the only place setting it.
> > > >
> > > > Fixes: 98aaa913b4ed ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE to T=
CP recvmsg")
> > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > ---
> > > > V3
> > > > Link: https://lore.kernel.org/all/20260917132742.87117-1-kerneljaso=
nxing@gmail.com/
> > > > 1. revise the commit message with more accurate description (Eric)
> > > > 2. fix a corner case (where a skb can contribute no bytes if OOO ha=
ppens)
> > > >    spotted by AI and Eric
> > >
> > > Looks good now, Eric?
> > > https://lore.kernel.org/all/20260924152529.5689-1-kerneljasonxing@gma=
il.com/
> > >
> > > (Jason, please see net for the up-to-date email addr for Eric)
>
> Will do.
>
> >
> > I meant to also say - I'm leaning towards net-next on this one.
> > Please LMK if you disagree
>
> I'm okay with net-next. Seems like I need to repost.

And it also seems unnecessary to carry the Fixes tag in V4, but I will
mention this commit in the message.

Thanks,
Jason
