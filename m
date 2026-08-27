Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EE4657C6
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855981; cv=pass; b=CDqqPJudS8Hx8/3ZB6Le2fP7jy+NHKGvTWkBCNe/L5FD2FgZEBBcfBgrUzYc9N2wKnm4pbCW0iMkJp/evizQlb8L6P8UYtNZT53ZJ88IxejUBEMJZIbjtvKanam/FTUWx9ZKwleDIAEKF7akmGMjLesjESy7HPKHS0ZLxdVrSSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855981; c=relaxed/simple;
	bh=445iCSTTCoBe15Hu3Q0tcs0o1U+eeAp83PGi5YJxTA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jmy/8Y6SADYzjtqIKfBrrNeXL2ucGG9nKoOcl3VlAG6TV+62a3R6kYBQlKN54UDVkmmnr1M52XjSlTlACi6aJjvIHkYh/5BlQkqU0NCC6d1rqAP3LUK2AhfsLIPB5mRTusFsWv9CC14aQ3yCzZW2SCs770IJxsVg9dH2xWnx/Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kM/LTmSz; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kM/LTmSz"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-936e393176fso10876685a.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787855979; cv=none;
        d=google.com; s=arc-20260327;
        b=P4dzu5R2cPy+ot8VcGlDIBXg29GynrBkwuaXhF3Kka4Da4Bnpu2GGP29f3TfPH9b4L
         r7NfmgU+HCzSPrrNYY9A1FZ4rj+wUWQN7JGZXrw010rHxJKQ2zsqxn2MUmlXO7aly3Ms
         4duGhsOcIC1YAzY7hb8g0tPpIQTrlDRdTwiu4RItof7X9i27XblZm2xJmEP8agUnP73b
         7nTnvB6U3Q3kIao56RUeGQIT95GDteUCTGwUlH4AC1Mvn4kz9RJsOA0EWQ+nar8z8T1X
         fr57lJUmVBkh4qHE6UZZvxcChrvtBN34dAyg2ETfAzFO8AUcuuS5mknHpUrUlsXkwxSF
         iiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=445iCSTTCoBe15Hu3Q0tcs0o1U+eeAp83PGi5YJxTA4=;
        fh=A8n998BmTyIJ/6LdoAbLnpCP1R3RaQ5x2s/UKy9f9PY=;
        b=AHQIh2kk00keH4pDUnPSkj7G70aOzRLJf5WX1h66MGSTaMgN9mazVHFlTyniLeFqMV
         llB3SUbYNd0TjROdgF050I53qQDIXvCSJhATzi2CrCvrE/UZhYEBCsaYqubFISURM3cP
         vna8PUMCV0HZj5jx/vc92AGRscUjrJ8vnwxAaV9JEmcOf4N6TR5XLXIfS/0mrSuFfKCJ
         BgOEkqKG2MxrHcdG34tpW8fR0XjREDslzHDxYnN3Jua8IfxiQ7ARFSC/PeDlbymd1YLV
         mHOX/25rYY1FLohH8K2MQ09aSUWUkFc3H9Q/wXXq7b0CkZVbQHE+arfkurzE7iL7+5Fc
         hRMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787855979; x=1788460779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=445iCSTTCoBe15Hu3Q0tcs0o1U+eeAp83PGi5YJxTA4=;
        b=kM/LTmSzoS6Y0PH8bT/wWDKBss0HJQa4+UtDuu4tsV+f8lcM/e59BQoVQk+TD3rHYf
         HRjMpjBdYA397FQ+PswQQ/mBIctZ0IAnbJEJMOEayRBlBCj7a+DHserTNqqBThW+pPVO
         oUpiCEwH3fQ01bqkvELj4mpZQe1HKZwpwrcIOoMOJWygu665SNII7aAbzMf3FJq+fc4N
         IH2Zo0Qai2el/M/3Q7BdQ7/U1GAFW/+Vk0Mc4dYRZRQV2M72Xcg7lqarVALQ8gqIZa7e
         gNF2tuGnFF5JYfncshb8qj3uKm7QHV9YpzGHxbaPfEqHAsyG1ulNX1BeuY+jUabnGWRh
         I8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855979; x=1788460779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=445iCSTTCoBe15Hu3Q0tcs0o1U+eeAp83PGi5YJxTA4=;
        b=ryGaqK4MDWhcovwldPAsiR7mRrKkQdwmlX+QfLoaTi7qsvdkxvu1RVsKNMy8ijh+0e
         I6dlDTFtC6HgqLNna+aHHuoKqDA+4k3p7HbkNygOambRU4HJCYMfshCnakYyJT1C7kbt
         hASmRDDAHpPiBgigyGRiQ+Dd2Oo2DkOgXjnMkJQFEgQzn2K+NCo2CliVuMuqBnGhajVx
         +T1BNANUSsSH7Hoz7KVjWPpYNIOjyZz3iWlgo3q5eEOQVhrgVlOmoxLGic38dHiBovrQ
         X7wpzegPa+MittmSpxaj5AYslPf4MTPY1gBQGtgzHRXC+gL+8AMUaXJtLEw4Ga/pmub3
         gplQ==
X-Gm-Message-State: AFuF++lWslDObpLzDc5wptlOqzdZMDvl5lWDe5scHzc8Y2lu+fhjhsRq
	q1p5LYkQom/dDgHrI63sd1bZnH8KMyElQQ4GJ09m2UyEKFR430N0i7ihwIDLoqNuPnCffpFVDhe
	ucpwi+F8EQs3hgWHgdj11dZ7h3ZRzsoukaO20vGq4
X-Gm-Gg: AR+sD11iF+ense0oLwdNX/6LwyE52e8aYx7G8qBXuujeigVdHP6tXy3OrVBZdHaBql9
	1O5olcVkP1YI95uj1hIdZIBjs4wEjMKW2u22iNly/p+hbsN4SnQe3nmODJnnzI6Kc2cjcOzshBn
	6FY7vFUX8Cq5GTaDhr3JofWT1uAKdkseSEHwtJPYzz9QFBQZ9chbm0WIEz+PZCKB5YRZ04SSUUV
	EZK8qCbJWrxTM5NqKOuc0qH/WmoyhMjdGoOAHh/TUy4pniMCwLi7KTeAMz/6oj9kvM+WJWMUsgV
	7KZvVEkg3LGMpGXC1r1TpEumCEV852s8g4Z9zAslLt5xnTYYxm1iAst+XhSEXmDG+ST34Wi/lD1
	QpgYKrUVIRVAiq9l4iErc2GDG58LZyBChh2xwPolUBhmAVJ/C4vrP8Dw2Sek=
X-Received: by 2002:a05:620a:a913:b0:939:2e1:91b1 with SMTP id
 af79cd13be357-939139b0e77mr79071685a.42.1787855973945; Thu, 27 Aug 2026
 11:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827182514.4667-1-zihanx@nebusec.ai> <20260827182514.4667-2-zihanx@nebusec.ai>
In-Reply-To: <20260827182514.4667-2-zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 20:39:22 +0200
X-Gm-Features: AcwNN1VRhQVJWnUjimjnCssYVB-RsZLLiLw-RwPls-JFeJyYJ0GNI-z6p5Tnrm8
Message-ID: <CANn89iLL7g9iZ-pZZw321GFNVKKW=xs-6exMxeoM7=krsL2T3g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] ipv4: avoid divide by zero in fib_rebalance
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, =?UTF-8?Q?Peter_N=C3=B8rlund?= <pch@ordbogen.com>, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 8:27=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> fib_rebalance() computes the total eligible nexthop weight in one pass
> and programs upper bounds in a second pass. A concurrent change to
> ignore_routes_with_linkdown can make the first pass return zero while
> the second pass sees an eligible nexthop, resulting in division by zero.
>
> If the first pass reports a zero total, set each nexthop upper bound to
> -1 and skip the division. This matches the IPv6 fix in commit
> d2c26c2911dd ("ipv6: avoid divide by zero in rt6_multipath_rebalance")
> and preserves the lock-free rebalance path.
>
> Fixes: 0e884c78ee19 ("ipv4: L3 hash-based multipath")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
