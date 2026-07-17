Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335603ED5C7
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284947; cv=pass; b=itk+Z9NbwaqnPw1CgFFHa3B3wgKSKTvpszpFpOL51f+rqvNSMz6h7CO43wnE9ooxGFd6ewfNIlIsZeHJXFbkXPHUoebBjAcO3RbdfandoVU5/sY/GaZAciFDS7s/Gu4oj4/1uUR0kalmLMPAEOWrvNfvxRnam/oHJU4ggnfO3u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284947; c=relaxed/simple;
	bh=0R8llm0EFrqZ2IbxbCOlkG+jKbWRlRuWRiKKZa1D7l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzPMBGNTWZ3cCKqMWvqSnlE1fTI++NoSHDkJIKuRbpR5FJopyM4g7iuHmW8oyORt8WwnpzitWygCXHqhxWZy1gaJuM2HQbjcnxy7Y+WsI0C3dxixVhrkvHKT4mvDhlrRBiGzCmRGGeIgRgkLC/tS5gsoA5RYZrPwUoz1h1PTLVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUG2sDLg; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUG2sDLg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so898833266b.3
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 03:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784284943; cv=none;
        d=google.com; s=arc-20260327;
        b=dL4cEX7NxGqAIS/13OmmPTd4TRnS83MbWvFnQ9olNvkXUogjm5RL/4FBjd+s482KfP
         P6zlUfm4ulI98c8Qym9QG/dEHRzpB3FLKgF0lZilf/RLsaa8vMPq1c8aHw9+fUX88g3Q
         28kPFc5AqZxmewtG5c67HFdvjsaZGAoybfGOUsF0tR0RNkwI3l/0i0nYJZY9DHtyElGu
         REzFZ3PLttgJ0wU+i4fSAQjUFGRyZ1k/6BuJHHZfcwGc6M6I9TWK8LdFxuQpLZYD3TRb
         nWrYcjd4WNwxdGbsyhXhgJLniZ7E1OCFbTLfwVQb7VEEYBQUHvNlxSKpF1YM6Q9IxvCe
         xcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7CDNeDBUT2qdP6O3Gq1ihGrb8xj5GO5o5nq7iOfnSkY=;
        fh=X4HrmjOaa06tRgs0uKbioXOs8fm1ySrhskSUpHuhBhg=;
        b=MZ51Z5Ejzc02DMsVlacprX/6FKAhqcvrBwyuPU7nlXppX/BNRGzK4Tmy+ecs8GKMDd
         yJTOSy9deVoAXr3bNI2GU5DwTEtZBKafUq6eSm6CwuJkYDLMrlcodCi3V4YDCM9C/2wf
         xIENgIjZ/zYYEXc3ko7KKdbQmkGXZYwWb6pKAb8KD7I0ZIVKJ3IkWQeSVM8rROU36l8T
         Z+Z9LDBmbhp0yZ7iJbXVSQJNe33ar4gDjVSrYw9514DftLYszk8oP3grTHELK/0TggXo
         A4PUjcTgnOEFmPnDREWIYLg7N4mEz7hagxkl/CnJ7qHzchfI/YUF5NI1zDbMtnagKREY
         XqzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784284943; x=1784889743; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7CDNeDBUT2qdP6O3Gq1ihGrb8xj5GO5o5nq7iOfnSkY=;
        b=nUG2sDLg/vTGqGSqzl+Pj/t2uyyoF8LbAtu2Hlo72e4UAjFEG7I0B0PWPWk4VvQU0q
         OLjYiu+PLQkfjItnO32+DXUceU8qVH9JiQwu2zVSiTNTSj1fmAbpB41J27ptXEx5I4KQ
         5nXUXbRe5TXBpDWMMfGN5gZF8p2etq0VeKV7LQPubWcbGPb6wijajz8kClSbxuV15l90
         uyC36fbrTc6ey0n9x99A5GjfMw2ppvQ0CJ4x8k5FGdajiodU3w3AQ9a5I21Qf1oBB8Sn
         F90NB+99gHDCJwTTrBwMYCmLc14Qlc7Qp3n2S5dcx0We6KAL0ti380i1lflIfO9Df/15
         3YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284943; x=1784889743;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7CDNeDBUT2qdP6O3Gq1ihGrb8xj5GO5o5nq7iOfnSkY=;
        b=Qt/nitHqSl2UJyyarzrwzyLH7YS1Y5MgBMW7+i9EOLiAk+lDTKZpRQ16lc5amPYQrO
         SYHGI8hk6HEtM1y5cmavUsE0MAcfGdRPIfvgx8+cdkcgyK7Vv3sZixDvLW8BJid7Y2yx
         Hyn8+UXYC3EcL6h5nUlsMn63TnQJRuOPrHV6FB6HpGV9DHQnYz3pUwKHVbRSWM0gGzQU
         vks9Q7vbzKdwyckyfgmI69fNK0/PZ7va8Ss5ctNR7TOjwzQtYpr45qtVGTjsBLae7tM7
         7M6zgvf1JT0Fahv8LgNcB0ZcfWR30LyxPh5OZ8GG4i4iTBjTCMq2sTDJ349wn9oTgg0h
         r1GQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr12i4dTL87gSPhC4LvcgBXi+F1jwRc9muauZdwFio1RI0bpGEO6dT/+oPcJMQxQxPW/n7Rqxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MkQ8xncJuBB1rf3+pGOmE0qzpKL09N2JL2nACLZoZU42CNVB
	wO7otuFokyL2KU0OiNdOhsB5Na9y3g5bL9SU88CtbMevJl7iyUJ1ahVwFxRZYsHxqZ1Q05Vp89d
	72aV9IgYYXtYb2L6fl0p17VLqTXtMAwY=
X-Gm-Gg: AfdE7cmPtqVmP491jr1LjrueWTw8nPGZ6/5wYzt5JsPsj1NtnlLusttY/Xko5Gxa+Ud
	3qh3Rm+P0SR7vMQHmfMm6tYOL9dP8uWYHWW4X4Fr687a0GegXDhlgM6KRt7Cl3Y7iNAKIIhkoXj
	bL34EfUBGQ/W2rRv4RrfVc8qjLO4cUt+EUFjjBr5MOM6tRq7LokLrhgLgpc7vXHSEm4KDjHRbz7
	vmBMX3iZQNsD4UZ1LYlVr5GUvYnzGTX0JWo3Qo6IVL9PTTMbOzDhGjdZWMg9Yej9anTOhk=
X-Received: by 2002:a17:907:c0b:b0:c12:6d25:2c7a with SMTP id
 a640c23a62f3a-c16b46e02camr92779066b.17.1784284942904; Fri, 17 Jul 2026
 03:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch> <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
 <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch>
In-Reply-To: <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 17 Jul 2026 16:12:09 +0530
X-Gm-Features: AUfX_my1PzHSS8WAMVOk58Ferv5AB7ZeFGvF439u5znvXo9fyXEAn2XHzEUmwqE
Message-ID: <CAE2MWkmbdDrCw1HUKm17QG7dyihuxg_1VGTUNeBq9v8NVwJV3Q@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Stable <stable@vger.kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It does not force the users to use a value < 128. You would need to
> return EINVAL for that, which i'm not proposing. Returning an error
> could break user space.
>

While I understand that clamping avoids breaking user space, silently
modifying the value might lead to unexpected behavior that is
difficult for users to debug.
Because of these side effects, I am hesitant to proceed without the
Multicast maintainer's input. We should raise an open issue on this
topic to get their official decision, otherwise my preference is to
ignore patching this for the stable kernel versions entirely.

> By clamping to 127, we don't break user space, but we do avoid the
> kernel bug, and at least to my superficial reading of the RFC, we are
> "language lawyer" compliant with the RFC.
>
>         Andrew
