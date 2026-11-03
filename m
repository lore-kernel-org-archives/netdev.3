Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793739226;
	b=Hfj+JQqPKVprxQELPUVo98V+hd/5hKckSJam7NNWUbxC4aw4g5CY0Yqt4Ld3BIgz9muy
	 30CJ46+4ob6PA5Td/EJWv55AAgkx+iFrMxUgDXJT4qDjgL+TUA5P21FpTI/2o8tuRIpS+
	 KWoye7y4FBlMosMyD3hFqm2uWW4u7qFARSsQEbecrPGM7nnPs6XMqS3dGmGnMVQmOZBQ4
	 O2A6el2IYNakqxQh5aYC3juMNRFuwZ5LFgNMFdntbibyJzQny5tIjuRxDJnGfbVYIC6w/
	 g77JpkO/s1MstlfELqmuKTsujQnOIlxh12vI7M8AkuiqbHrDt7NITb9/4Ph06BxDOVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=HU0IDlTEWZ/Nq80LY/Y8bonUl8UVtmzIsUjZigKckck=;
	b=UbRLqk3Yj0N8We5MROJhC9kVlcuBYp2n6v2E7q8uLwSXp6pe8nbqgoVBfSjaLJyncGeW
	 vkhUyt23E4+orGS1iwWzy6asKNr3FWGAeFk2KVC8gNE19hR99sFG3jdS7uYkcAqouJgni
	 W0BLLen/64NBj9qJulleJVflDXRa2RamGWw9E4ciDd41GKScC/gH/7fJdnDpJeszi34NX
	 MsCyhMVEQHm1sjIMle5X1gpFcLDHCtgJ5uSInY+tk5tlRROB+TCPJl3rxbtzWO3JCwDzq
	 G5rW69ASgw5XnrmXkGddEMbACSDH+Hw7o0OgMMtGJSbUxlGL1UWHCxGrBRFo5dkqoTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=auyMeNme;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00E606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 20:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E00E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=auyMeNme
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-483a66818edso54341fac.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 12:53:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739224; cv=none;
        d=google.com; s=arc-20260327;
        b=e+Ftz4uzr3QEVmnZgFjoMh0MdTSRfCk+9WD8lTC7axRKItdx7l+hhiSdbySOm8FcwQ
         uM2WbMpQILCoro8VX2zhvySa9IYDJVXuQpQjkD1QAyCjWIUq/LPlp+O4uiVVqK6iY5et
         3/l60eVPkvcYmSTZh9PYef7j4rlnC3uAPiNblwCcw2umQ525kTrhIux5mN7xExBraSb+
         6T4ZieiXvlV8X8JMe2ifVhI8nErv4F1gs9gwX/JK4RXSu/tY3o5McONCV7HEqcIx8Ecr
         13i91wSb21Gk3ZoEw2wkFp3gNj4SkoNl/MCnRnYjwMJa0TDEmI/OYRKI0paquNsieuGB
         7F6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HU0IDlTEWZ/Nq80LY/Y8bonUl8UVtmzIsUjZigKckck=;
        fh=jUbMi8EaVJmaHkbGJE4zFu5etZzQ+6Cjl/vAB23nl2Y=;
        b=D96onySlqPtB2ukdZuayE+CwEE/wj/J2lrCGmCqxKpdXu14rpa+Q0ntt6BejXZJjFL
         e7Qr9vopmsvhlLsbXaA31WTZDJ0L+XWd7ZsRweXTqVkFp0BeTj4G6STXTwIB3fjyC8MW
         4/6ZEr158Sz4EsfYkqv42CdG8SA9lw8RElqlp+CUxjCLYr7cgG5n8ScrKTOcu5RvjkXS
         5vTNcq8EESJmRwSp/mK5pYYCx5mFd1goE58KuIyCoEugLMo8iaXp2j5vWcFv/UbfBCeU
         1zULfLHqxJLAb8x2abRAKIyRQKopFsC1Ga9XmDx3RcZ31KwRh4m0ldyb/GE5w+58Bzfd
         V9Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793739224; x=1794344024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HU0IDlTEWZ/Nq80LY/Y8bonUl8UVtmzIsUjZigKckck=;
        b=auyMeNme4/2d01zzCWqyBDt/BzGNmz1TB0h3Ud+kIp+iV12/l8l+8oSCKuUj676PVq
         aBVugEhproylVMbxZ7jqq9EoEq0DaylN3bZe83HxC63yinS4CVEx+Fl497C9Hk9Feu5V
         X7YX0LQsolMtep+IVhOVyBefbxcZQDq3tAga2gRse5wioCQHAteEB2xjOC0Swqmbbq1u
         7vakZI0vFXnqKTQHHcfgr9Khsq03VzDmMwUASgXd2/k1nJSUEAGbYp4ac+KsSb6xsEvo
         GL46Z3ltFuZJbQj7hXahyilz5WzR2KwydmZJHQnpDiPtwSX1ANt31TnNEbJVh3nSc95B
         +ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739224; x=1794344024;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HU0IDlTEWZ/Nq80LY/Y8bonUl8UVtmzIsUjZigKckck=;
        b=kFfw0TvKSQiP4D7YabD0T7c017akrT20w3fxzbmQIpQ2h/lZz9qXfwDwXop8sdn9hC
         QgnXCrca+LfbESerVs9sYmtqRsRZc4FieSMjq1xj1ntT3rqgQlnpjqcpn3cqkVvMeg3V
         EYrbCc1GhWZ8TIG8J9ozSOJwtaqgKM2XnH8XQWDg72HIiEc49ItrJ7aMH7h5mz88Jr6H
         jrypxYk1FWL29fL9XXsWsB7KZermdZ0IK+Oo+iZUNqOunaBPzgml/XNKUup9qRCfFK8p
         raWGKkXmX+4hjytn+r3RUGX1FPnr2WLbkcP4EsRic/KXh4C5Kq8YvfainNL+9AJietR6
         npRg==
X-Gm-Message-State: APuU4Z9tysVU/bXghQIiqbz3ReMj15IC3kl1SDuA4K0nQ2g2cb5PCdG7
	bVAQNe7O2ShJMj9cXJpw9BYiY75ddjN/VaF2m4HMYZoAgNnstbpQY2CSMd5TFly5CzoxusHvnI0
	JrIyIVsFZ1Yn0UlDhxrKcl1msjfXzdYW7GqlNsKfqsA==
X-Gm-Gg: AYBFou1/A3ypOHruQa6Sgp1VpcBX5EC8/7bx8s4LslOrGUmA68koYql2Gnut3FXEXTq
	bqH4bbC7Q3SWdPoauP93esNNRzSMSOmdCsJabmBhp2BvpZoVH7XhDW1H/8yRNDB++3rBorI/Xmb
	4XwfoVElV5d05IJCO1AcHN2GxC2SNu3BJlsKt23ZUP8/buCI/8vfkc8/hWrfVb6EPlKgg/WGg/W
	04rliU9PF1yeNq3iUgUjoi8f4zL0sUnZdluD8udesv4NS0jXziKMuEM5mcM4y+sRGVFZzbw2Ngl
	zK5SQDxXz09p1vU/QRJEdOfxgi1n9+Tnb4U3zc3hhzF90ID7oVfi7/pTS8Ab25OdkE06JFiD0i5
	Xz4i9Go66YOPaRQej6qWirgSJSyAB/r8d7r4jwzTQhiGHhSPWJgo+XDxC8W/FlfuNSyc5qtBYIg
	7bldGoQosFDdSYuDx4nyScL8nIh7NpXHw=
X-Received: by 2002:a05:6870:208:b0:497:4b0a:61f5 with SMTP id
 586e51a60fabf-4a90777511dmr8964664fac.43.1793739224442; Tue, 03 Nov 2026
 12:53:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103200036.65764-2-tianyi@cloudflare.com> <179373626776.488859.10701424242617832815@kernel.org>
In-Reply-To: <179373626776.488859.10701424242617832815@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Tue, 3 Nov 2026 20:53:33 +0000
X-Gm-Features: AclHuK_asYprUqDKWj4NTjMpDW40oUsEV9HAiqmCbg-4s8sP4_dIHmt3NG3pWyI
Message-ID: <CAG4wq-c32sQ2NiFj=9XVXuc5Eqa+5zHvTKcGRQ3ugAdXWnE9sQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] net: fix mac_len of skbs copied by generic XDP
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Toke Hoiland-Jorgensen <toke@redhat.com>, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I hit this while benchmarking generic XDP with an xdp.frags program
that redirects to a cpumap. TCP throughput dropped to almost zero.

Cheers,
Tianyi

On Tue, Nov 3, 2026 at 8:04=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.



--=20
Cheers,
Tianyi
