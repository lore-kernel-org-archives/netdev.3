Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D840BCB6
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764879; cv=pass; b=J8dhYoQPa2l+NBO4WZpioQ2TPv1/ZPe3f9SuMs1xW69l9ETJNws/rCdmF9Nc+q27GlUHY5orpHp75IgVndMAfBsOcRPKteSz2n4QT6KjcDPjVdaBh+OZnQEGq5lRA7sYo5y/Ft+oyTZ3GZwYLslSgRlY1UQB94+frB1UpF3x660=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764879; c=relaxed/simple;
	bh=Y2ur+9djzyvL32htqpN4jDktQyKA4StfEKcENrbnevU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQSO5s4vvfQQ6A39XJX4g68YO69hUylkFC+J+yCefCBcTzjCaSkMsJFrV5ZnTzKc0pvXps8OLiLpBLw0taWqvdm/CskdLZk/DP0w63is/CJuusZ+ZWJ4bhadgN7Z1IFZv9cz8EYRe3kK8ehunwlTPlpwJKNjAQxvFciBl56W/4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5WmuwoE; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5WmuwoE"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52ff7e275e0so33550871cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788764876; cv=none;
        d=google.com; s=arc-20260327;
        b=pyvxNqzAVeF+iBySlpVIkR8NI1dQ7hpCYxfsiRobokJkv+iFfmFOkmdR2FYo3Og7fJ
         nLIECLzsfN1/gLj6ama+TC0bJ8eBvwwONKlSazcTJfSncYqwHitvNaRv2AglCXG1Kqvq
         956jOFAJBA+xRqE3Smh0fLCqyqavyed6wUAkQ7JBLd7YeuC/rUvTLxG/LV8hkWZpBEwi
         1DpRqE7PIQNnmnCNRQUL9FuI8y+dDN/HIy259oXlUCqmGxIrpcUXXRXW1f9DXmBDd/Y2
         KTRleqkk+IDjhD87iqrA24UUdxO7YfpElTaXyYtSFc9U+8h5/M9V0VpZmEoUySpfTNnw
         hKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hqvu5zoZvKKDOuz/BamMJAjw8ii3eTJFwC7iUaWUsFM=;
        fh=wXlIZ/HaVBTRQfb+MJOOLSW1QUqFAb3oJXGyvF19CGA=;
        b=dnh2tukG+AIR86cghMNAzbou6Nqr5bDTjdaAt/evXorUvb9IBLn3pdKTq7mJbe8FAs
         O+RZ+CRMqDrx9B9o7W+CMzdmC7cX7y/ZC8tOgeHjAKH1uJYidivGK9PnGp5iCPUepsYr
         5f8COqllfadZT7PXLhzgAJhvtWcL5VCD6Q2au2/oq4do9eT2Ae2yKSWBiHqdxHypPKEd
         O5MUPO7HxPlQ+ngEPySSbPCQZRtCYZdHLKjQC0fZ9KO5pWtpkAMPXON3Ud974ybJ9QHA
         6WpN5JYhKiIsJLL1r0KKRKtPDxZREwwSwReLD48QsrxVB5JVWhyJRUU+0scm2hz6ivkV
         SNyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788764876; x=1789369676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hqvu5zoZvKKDOuz/BamMJAjw8ii3eTJFwC7iUaWUsFM=;
        b=T5WmuwoE2Wmkif6ZHlr7z75zgfDcYmcQejKwGE+psT7vyXnOrEs9W5puKXDeat0PNp
         fvicIfeALAW5jAcrtvsAomYPHv35SfUAQlCf7dTKVFkKEwLJoKgUkGgj2/iLsMUNEfBQ
         RuINvu/5htOfsXNvzOKPPOB2ihCv4PFBS3lK2NE2z/SSSUiTqCs0EHA7PEA41Q0moMwU
         Mz5wLGFmBJlZ0SK26WVihBEEkZG3RzoRwjMHB1DyVX/tn/NsiWI9HA7vaocARvMZ1828
         pcTRCLmY9ooj4sYd1gKHcnS3J1BhHZZ2Of/1HoDE5XcfCSXDuuIxeGMpZZ8ma8iLFuRc
         dhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764876; x=1789369676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqvu5zoZvKKDOuz/BamMJAjw8ii3eTJFwC7iUaWUsFM=;
        b=RDHQ3b2DCXnDocVZc4pxMZArTx9q3XN6yjc5FQiyVNXmHNJ+iAGPoD2PbcnVsrURxJ
         cLc1tGn7rz+3ea31Zh3+6xppovx8gNVw8lElFwpog7k73pgl1gSTPtfSVquRFWljJ2J4
         AkVMFQNjdI9rwn0CUZJ5krg9a75nrhFyYjYypSycuB9+qQ4UuomjV2+Ov4U4Jd9sz1dn
         FcpQueRGKYvA+BXYlhCYZBIveS0u0yd5XtdXuQH8Ph9BQ9xflPTsBqvjd/3oVHUF82qO
         5PBaCjMx6fd7dzYGSl0RSSQgYEK6ipU7j6QqbNZENIycgC8cV8JJyFn18kRItYtW4uvq
         99Yg==
X-Gm-Message-State: AFuF++kgyncHRPCnZffamyGJRyN0sDATJCV2Vodwd0fi/gQn6vXqVYSR
	sRdfUIm7muzrPjjFsCv/nw2qig7mRGpD5N6rizn+mzx+74RPOtPzSLSdIuw12NKADEFNrLA7wp6
	x04ytyy0/6PmMrkldShs0H7a5NDlpnT+q9OBt6AAa
X-Gm-Gg: AYBFou1Hc6F+LZZK2oxhoaul3Y96hoiESb9UHA+9RIdInLjXxxKV8wUuwKRhWaLZv0g
	r+5lWEhWZKB9ArGxM7JgQSM1R3KoBgSKcX1OTEr2UlVUQ0HB3Iayf1oKJyZTeo4qi2e3VOjDROg
	5xmVfvSf/XoKYs/wMMaMoBUfEVB9VvFrhvX3xsp/vHonofqLHGjThZ8ox8ZQZOroqjq+AQU0p6I
	UfIUpOcifVuUx2/vUyNjADdR7fV+3TNykZphwX2EkYQbXddeUbkbk/QFJTAMfBeJdxhBL8gdrQA
	ffxmNjUhmhIbL+O5oiyGBDcABlgtSsQQscGpHcZM8PhK8Ygd7O23nguaG/mcjp6sfKXt4c84KSy
	s/Rl5ODb4poBXrsMnwXf7qfs6ZAMm84zUgbIxn0+TaNwK7hF1sZsHy9V+Ew==
X-Received: by 2002:a05:622a:48e:b0:530:42e4:f280 with SMTP id
 d75a77b69052e-530549f0484mr242761321cf.41.1788764875411; Mon, 07 Sep 2026
 00:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788668475.git.zihanx@nebusec.ai> <e8782427d0b3cd1854ab8d141eea224b53db55b9.1788668475.git.zihanx@nebusec.ai>
In-Reply-To: <e8782427d0b3cd1854ab8d141eea224b53db55b9.1788668475.git.zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 09:07:43 +0200
X-Gm-Features: AcwNN1V6FVySmL5DFqzL_7zCey1PZNw_Qi_Gx6_T0FzTqcJVGcZG-fCSLd-LjtA
Message-ID: <CANn89iKdX2-a+VhWa4CyDODSZByk=r5VRq38yQhLYBFRQ1Wy3A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] udp: diag: bound bucket lock hold time
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Pavel Emelyanov <xemul@parallels.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 12:35=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> udp_diag_dump() currently keeps the UDP hash bucket spinlock held while
> running the request's bytecode filter and filling a netlink response for
> every socket in the bucket.  A large filter and a heavily populated bucke=
t
> can therefore keep bottom halves disabled for an attacker-scaled amount o=
f
> time.
>
> Collect at most SKARR_SZ matching sockets under the bucket lock, taking a
> reference for each socket, then run the filter and fill the response afte=
r
> releasing the lock.  Resume with the existing (slot, s_num) dump state so
> the next batch can skip already-walked sockets.  Leave bytecode filtering
> until after unlock; unlike tcp_diag, a rejecting inet_diag bytecode progr=
am
> is the expensive part of this walk.
>
> Fixes: b6d640c2286d ("udp_diag: Implement the dump-all functionality")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
> changes in v2:
>   - Drop the hash-list cursor, dump_done callback, extra module
>     reference, and inet_diag core changes.  Dump state is only
>     (slot, s_num), so the existing handler get/put around dump() is
>     enough and udp_diag no longer manages its own module lifetime.
>   - Batch at most SKARR_SZ matching sockets under the bucket lock
>     like tcp_diag, and run bytecode filtering plus netlink fill after
>     unlock.
>   - v1 Link: https://lore.kernel.org/all/133b6aee9e2c908c9da37d5585b3d2cd=
016906cd.1788187473.git.zihanx@nebusec.ai

pw-bot: rejected

Please limit the complexity of filters.

Anywone needing complex filters will implement them in user space.
