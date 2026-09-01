Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC89476066
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255278; cv=pass; b=daTJsMS0V404qsvySJJnmzYjfa6tGOKc0vFyzdZb8w32oa/UPAvV6g3oikSGQ+TGMsw1ZxuHoX6vEp4XuXIHl/vVo1GxfAmryULcCRMyyqtv/5gt5PcU77m25FCXKtuI5QVkIIsCrKIuSKRTD+A9UGCWy0nZ0cvrpp3NZrY7uo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255278; c=relaxed/simple;
	bh=pn4Yi8R4MlFIS7n8aLufkBYgw+zaA6iEcjMtZetXLtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro80rFiZ7zQq1T0JPB3hGLWVWshK5tSxNo+QZ4CxH1Kc7D3TVWzaW1DGXknFc8Z+U3mjLiKL/duHLwbWbH0l0RO8EEt3beuyrZA5c8kfKdeGDan02UHBB5j3WCEEvbelwGOdh+0JoMYTB4zH3HD2EgR/p6AU/SfC5C95L663cS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=DS5n64aX; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="DS5n64aX"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a2015bbfceso5563711fa.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 02:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788255268; cv=none;
        d=google.com; s=arc-20260327;
        b=oO7c1vu5AYPnOpPBcLD062mN4jmGzU267q3b2GS96O4ZyPN8tQFPKJNlilRv+kjE6y
         rQjGDWaB71J4InPRxHAXUxGfnfIYSFdDHHDx7jEk1ZoV9pBwy3CTQWtw1mqY2dovL9HA
         nTkp7s7esEnpKL/LIdffrVwbinT/KCahbrT/Yq2CSnp9ssg69knT/EcmM+O8n4czjxEU
         TS4W0FwLNcKGDZ+irXijEUfAJ6nJ5jXJk1d9GbllkQPbO5xs0ArFEDVIN18eqZRqcooP
         Dcm3EPnQsrsjfE1q36BrprHJUlSsbsdVssFI8Ka7SKuqalgbuLdzYzsQex1UVmSMJ8Pg
         aD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v0sDCc0evcY+F1EcaXTNVaeae2Uf3EeOiPTVY1Pi1is=;
        fh=l/pSApOOsWwB10+wh17lpy1DzqlF6UGlTZpGCEGHc8Y=;
        b=G7/YQVDG6uWf9P8jo3asyynxZgaLp0GJLvX3Gn6CpY56NqdkmhYYE3D4n3X8Ht1vOK
         G3ZHCX1dEBO8kq/jkjsGvHLIqlL5L5n8+ETLS/TCm8/mHRnnxTX+MRGsYHbCw41c2oP2
         0fdglebLoschxHfHUlA/gwQ+6KXgYutAVZGvTtMHhCvTnoClHs9tBIq3KAr1lf4Ynolq
         PxMNpRh9IGgRyCLu/71GMEV7zns4biakYrT/eTLR6UH372UgRUwIe7uCDKJaQDiIBHBW
         qM2vOCkcsYBvWNb7mKI/ZarcIrYFZmRFV3ds11JQBua2QUajdyy1IufkTf0g08bDiOAa
         40Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788255268; x=1788860068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v0sDCc0evcY+F1EcaXTNVaeae2Uf3EeOiPTVY1Pi1is=;
        b=DS5n64aXf0XCRrLnZKPi8BH9JCKVRny0QwIRkOUkTnQppUIJyHkuewt2NxXR+3LecH
         lg+DiuQHgU62YAhoaMOVinXXVawp1lM5BFXbreaiA9Xkdzje8FYO1rhpM5BM03xkc3YJ
         tdLQrsSPi23KXyWN6CgRIT0Sj5ytQFwgNBCMb3cSz6jMBbplvZyVL+QPw2a0Jr1XjfCm
         ZqjRfRxOMfKSF2YfW2NwOHe8XR4dV9a5Xks5vQT3gY10iizjWGy4xn3GK2lv263+RFc7
         l5teXeDOAXR48GREUmjn9Bng4nvS5+pHjE9us/Bd0/buNo/ILopOfmFSDfeePjNBPQt8
         61Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788255268; x=1788860068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0sDCc0evcY+F1EcaXTNVaeae2Uf3EeOiPTVY1Pi1is=;
        b=ApWnwtH3+Rjw0cl151ugjw4IWIAIVFmfh2f/hg4raer3EuT8epKNt1t7l3/GyjQDzN
         /8Ju0k7TClChDgoYFHFRL3Ns1hiTznx2aV4gERRrbh85J1M8S4L88bDpoGMobQceenbx
         Hm0gUAe4Gb5PEWIJP4auCGyYJ6gcwxkq/Mn6MI4i40KlOrqwp+ILOSwV7zyzv9OzSKWx
         lSThW/uuKHQdA29xxWOVSGqcU3kLGBXRwByISL2+QC+lvnNonm8sz8vjXIHuvzjKlenX
         OOOJWhgDNg3+R3b2GKCy1/ARGwvTzzp8d3QnypisTFWh257q/lfc+Zdtc2DFCRlMvnu5
         GRKg==
X-Gm-Message-State: AFuF++lM0OYDvO3Je7BVdEkuZpQ0LYiP9V847ffBVU6C9MnlRJSQVRf2
	kIVLQGS2Oxg1r5dYTLbzt97bGa0B82z04wsFRTP4Ddy19lmncS6wWKTliBaKmxFQdGxv+syZmOs
	K4sjDndPvFxokH+89CYylIbhPbXU/rtODpX8CJ2LArAE=
X-Gm-Gg: AYBFou2bX/lZe2UNO1ZC7haKT1uaPNhBAWeXZqpLqcePqlaTB8Ke0uyGw//Cgqq6Q70
	pAVdsEZLSJgewuoD8A8+f35nhSFxWH9sr74rzCdW+fLdzlbSQUIjfOV4UkPRPGkt9jW9F1vmPy6
	tSlcvLZ/G6i+mCEKZuwy3V1ka5QylAYhy+II8lJj+XKXV0oj6BD9iV+mUnJeFsfNOMnjICfFuCG
	mkzyGYBZAjmlZaot89extcX+IWu3vM1PS70L/7Zm8lmXd0vUf3IiJ+OjzxxvLUJJ5T/cCFbiIky
	hIN7IDSguCMaNMWSVZ9IB4NNHSf6LA3fvGgNm2zI0yTWh+bXGlOSxF8EyCm5R4S7AtsCo2kZPJs
	5
X-Received: by 2002:a2e:ac12:0:b0:3a3:364:f783 with SMTP id
 38308e7fff4ca-3a33e515762mr8807151fa.11.1788255268016; Tue, 01 Sep 2026
 02:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788223735.git.zihanx@nebusec.ai> <7b6bd9bb1bf6bd43db18156f42b2d7f83789a673.1788223735.git.zihanx@nebusec.ai>
 <20260901092135.GA3402711@shredder>
In-Reply-To: <20260901092135.GA3402711@shredder>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 1 Sep 2026 17:34:14 +0800
X-Gm-Features: AcwNN1W81ESOZ7FAp3XHS-uh8ENJqN1hRRIa6EY3HEt-t3T4rInt27-n8S7n6Vs
Message-ID: <CAANe3eRHfO+Q-3VYPJ6Ui9Sm1TzCA13DYd+1aFh7Qfg8ebbhbA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] ipv4: fib: bound automatic table ID allocation
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Patrick McHardy <kaber@trash.net>, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 5:21=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Tue, Sep 01, 2026 at 03:00:01AM +0000, Zihan Xi wrote:
> > fib_empty_table() probes every table ID from 1 until it finds a
> > free one.  IPv4 tables are stored in a 256-bucket hash table, so a
> > dense set of IDs makes each probe walk a growing hash chain while
> > RTNL is held.
> >
> > Automatic table assignment ("ip rule ... table 0") is an IPv4-only
> > legacy path.  Bound the automatically allocated ID to 4096 so the
> > RTNL hold stays bounded, without changing lookups of explicitly
> > specified table IDs.
> >
> > Fixes: b801f54917b7 ("[NET]: Increate RT_TABLE_MAX to 2^32")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> The bots will likely complain about the change in behavior because the
> commit message doesn't spell it out. I explained why I think it's safe
> in [1]. In addition, I checked, and both NetworkManager [2] and systemd
> [3][4] explicitly forbid "table 0".
>
> [1] https://lore.kernel.org/all/20260831110647.GA3202627@shredder/
> [2] https://github.com/NetworkManager/NetworkManager/blob/2e83a4082b22349=
9c4f1bba156998d0171071967/src/libnm-core-impl/nm-setting-ip-config.c#L2747-=
L2758
> [3] https://github.com/systemd/systemd/blob/9b62fd169e06d14cbab801c66f2f9=
c2006edb75c/src/network/networkd-route-util.c#L456-L457
> [4] https://www.freedesktop.org/software/systemd/man/latest/systemd.netwo=
rk.html#Table=3D

Thanks for the review. I will send a v3 that spells out the user-visible
change: table-0 auto-assignment now fails with ENOBUFS if IDs 1..4096
are occupied, while explicit table IDs are unchanged.

I will also keep your Reviewed-by.
