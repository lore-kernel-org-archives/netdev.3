Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793003761;
	b=SOUqvZF0Ekremvmty0OWtTOUJj4Eu7XL2n6fPt4KND/FG4tJTcuxdeStRAGA8hc4j5VG
	 8tqvpO5bEIWu2i88eICEVQb7jNx6/T9KTXzZ+Rd373wtQ0weY/crPrDfnwDhRoQxOJZc8
	 tlyACVdW2bSVanysvW3m8Em39ujs4fEWHIx2mt0vplD99PY8YsSTUAKjfsvsHjGTiNsJC
	 FxPJS65VVEyX21ok+j3N5Ey+Q8npe7oc8tEh8qsqpBVrHHVfqXhtZyX9rhgVMVJHwJkU1
	 UGg4cR+uz46PcCDllohfi7NhlL5XfOxcHJb5ms+ZPmHVv9FEIQtRnzHNH7fBtx+Q0Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=sPnjwjR+QK9Dk/w8gbYkbbIU9b+DRJJdLLT642WnysY=;
	b=lU5a5xMAerUE3X9Q87VrayZGJFBJAKwtKDkLWYofPncPLNpdKJ1MVSaV3FqWXRwQe2fv
	 3yMANpPAj81Ne002G4WXQ2/D+X2NsELbKbr5QNqyz20lxlmFDwAI4KoLlzYHbNQMk+/rx
	 ylP2d9+l/Dqh+2aRQiiciduhnrScuoyYjU4R9ndWYvT9VEmPeEaOIijvG8DiQu0J5T1PW
	 2ALehSk3f7lFxXF6ReTHF6YI/IxYO4308YqORVjxe/G3hOiuopb/28rymEJyAqBZi028a
	 Xm/6ppu1qPsX0MGmMrFzOWnsNBMC324TYsooEYR4Cuy8lWsYLmVVYFNsaLzYaXie4LA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="YCn/AeQ1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE75606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE75606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YCn/AeQ1
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53ec92375d2so1244314b6e.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793003760; cv=none;
        d=google.com; s=arc-20260327;
        b=lH9UluTonXkKQUo0zHw7n+vMNYGyRtFm/+s9wDARtDVBXT06iLPjUE9eVXmNuK+0Aa
         +MsaV57w2qfuCTSwWz9qUV4T8lgzRz9NUUulyBUs8IEbuse1BTwOAx4G1Xx6eB5zdWIc
         ufbccfrI9vyJaoBLXGNcPqtSAQZdCQPLEpNCRvPYkqGZ67o0LCtW8Jfeail+pEUABuee
         rsgxQIA9PgzGZq2aRix2kQHqEkq0/Nkb0TKRagPsPG3P/Q/IC5oe/bpLo1tDhk64J+Gl
         44MNud8peJOUMmbq3b6ixnZ5R2zPu9CutuJWVDcCleie53cyXaXcSuEWOIn5WcDBJm53
         CNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sPnjwjR+QK9Dk/w8gbYkbbIU9b+DRJJdLLT642WnysY=;
        fh=YGPmnbT5iHb84eZ/YeHcCo1+/rX48SlK194wGLbQIU0=;
        b=c4YRxzA/3TVKyzbrv7/IYqB7J1MsUL+nUj4+MHL/gZa4TTQYlmJi0kRXA+OiZmlNPA
         2LjKKdRL01DQsUGvJuNYsXXnN307YWc9G3WldUIWL7/LIoOTvgpMqqJhA7gKYm2S596/
         cOKQdpnCnpQFanjwSCeeHSslzFe/R97sJjG0RtqOIPLfcU/IcyLTQ9GJSvD8BTFxsNui
         Ev3jjcG2c+TpaOzXWe91yvg7SSr3JarRSW+Qw95+M+acSAWcaeT5imxpBPmGEQu2/Dwd
         JoepbdwO5BVY/O9420aamYh+98bIIr1mVAnVV2eKY6ciyACJ+OVNig9YfRftAt50VQg0
         qyYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003760; x=1793608560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sPnjwjR+QK9Dk/w8gbYkbbIU9b+DRJJdLLT642WnysY=;
        b=YCn/AeQ166/qZAt28aGak4/A33BlqMdpPB+gSVQNTXcpYIHLizALy0AgHE51r5+n4M
         aOgp8d1+9Du5SCf8UiCVBeRKaqEyhUsxwszfpYdGmrLB8iJSrMuu6PhqGAgG/hcRBVOS
         2G30nEHT+EbPJCNHDYqo1qjWt59SK7irA1m2AH8DdXGvp74WbqsvnAwl4XlHFCz6WQdr
         5wCNCcdRY1lKDjRvzd7RxifVf11GcTkaHpjK8cgx+VR5BjA7GwhN1I7Q0QZV3TuYV4Ym
         KZ/9oVjEwjDhRnIrlr0Z7OCNDNFGL+j8hVNxyp+xSVFkoXfAiPxSEZWV0jrS4l9j9hDU
         7NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003760; x=1793608560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sPnjwjR+QK9Dk/w8gbYkbbIU9b+DRJJdLLT642WnysY=;
        b=nqkwoQTqImSMBbngzvIUVpIxSi1jeR0jz77ekZW19zsp8PMbcLecGMVlfNR58TqMxe
         AePzFdAv0TM6G0ug8gv2XGAvFw6U9oyPxc+V83A3RbGDYZVvfROu0sWrd4j6BBWHux+/
         mEy4SKm6LkhfJRhCwiARrBe0vosB+nNPDtYQMYtRwoDWxla9lHkMuYAjmJCOU8U6dSti
         p6xMJeY7HM2kBcs3rn9YtPcuReLEi8miqz61eG1rrWvcId5vhTWJ0+o+qL2SwpXIUsI3
         tmnhRFLbrLgcKfpbaVLhC8ULtm84qBlBGjRwXNzJ2bIXQbxZJA9pVNMFoaBM4C/Ses2c
         qiiQ==
X-Gm-Message-State: AFq9FYIGVlaUkMwId+J4FnxTzKv/o08uWJ/fwuqcJWugVEQl5ItnBH8Z
	GA4qO1osr57wbw0kzGp95yWUxLD2c5/zCZNvmnDnZIcprpAD2RZtSLntP5l/x4ZWi+f98Vo0oAM
	jqBC1cjhMXpC1Gt+EaKLAacC4vZEzras=
X-Gm-Gg: AYBFou217ERHkB5YlZMVfH6g39a4p3o2o3WhPk/kSr/tpXlZIAwWyF1gtwNhqGKBFsb
	NBVx59VMR5hcBECreviZc/Z/VqCd60s2VeWO3MltoGrraO6tkUlcOHLvPd2hXoygSfvhFR111xM
	NiLA96Q83rFkJXqn17uOkEsoV6luaGaaPgAZN2tmvviV1c/KZGvrir68swvY4Jzkij/Nf5Oy5Yv
	nuCdkSaj59SM8abiPzcMQll3PDXnmbAZ4Tqux4reSfLGapHYB16K+63Hz6EqHIC1Sy0hLuC4Xij
	HvrUz9fFC79SumPPyofAwyd+uq5C5HToq/ELZ/jGeg9S7Mw1I8o2V6AeCCzF3Vx1YZs2yssnjEA
	dCELdqNpyzkSJCVBpSz3QAFo2baeKaXyvS7hHeLJM1i0Vax7pbBtqIKbGtJ8yolebIRuwxw==
X-Received: by 2002:a05:6808:138c:b0:4d6:92b3:5c8d with SMTP id
 5614622812f47-55c00426714mr3601843b6e.67.1793003759591; Mon, 26 Oct 2026
 01:35:59 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025024114.1955782-1-mmyangfl@gmail.com> <d841a56b-1ec4-4095-9040-cc67f4f91956@lunn.ch>
In-Reply-To: <d841a56b-1ec4-4095-9040-cc67f4f91956@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Mon, 26 Oct 2026 16:35:23 +0800
X-Gm-Features: AclHuK9B0zK6RkB8B1KTCp3XjrUylRhgO9yQ4J7sUttU6ozFjpO7qEQI6Yw6uKU
Message-ID: <CAAXyoMOfDKR8iRi21w+h3RrobOFTAHcFgVDtKJ6O0BZm3iP4dw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: motorcomm: Report error when FDB fails to add
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:44=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Oct 25, 2026 at 10:41:11AM +0800, David Yang wrote:
> > fdb_add() ignored any errors returned by the hardware (for example,
> > table is full). Return error for that case.
> >
> > Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921=
x")
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
>
> I'm not sure this deserves a Fixes tag. How many entries does the
> table take before it is full? Typical home networks have what, 10, 20
> devices maximum. A small business network may have a couple of
> hundred?
>
> What happens if it is full, and you don't return ENOSPC?
>
>       Andrew

When full, the error was silently ignored -- the bridge kept the entry
marked offloaded while the hardware never stored it.

May indeed be too minor for a Fixes tag -- could drop it in v2 if you prefe=
r.
