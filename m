Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E5B524F
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096663; cv=pass; b=ksQgVMKHBWNsxxOZHBj9TKqqDFzSgvn7IkmFtvI+DG3CJa2krmT+ZZrqPQZ7Xr7ugx1oHR7ywJPQn3HqutyYttiwiL+oaHNx85KByZmcicgpSbeJKOjqiic3ReR5undkL5ioB0wB2Yc8vgEpzK/Dmnn7HcZQh+5KN0DBfcfwACo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096663; c=relaxed/simple;
	bh=kWd2ZlnaGIqOzhBDtr6CPo+wqxbzhTWntedFRzAihME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdLDemwrQuW51osbEC1x06+3PXYYcdg6LBcMB2kS29MkB0poGEXdbo6dGWYSaRKi0DCdK5g7vQNkY+F3R9TneWPy9tBxuM9z6xaEjcvANcLx29+9juk1BHFXtOmCGYBCgV93fFbzGPqnNKdy3PnsdI5BnaJj0QtOTDlNxbmDR2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWjNmrzf; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWjNmrzf"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2892274a91.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785096661; cv=none;
        d=google.com; s=arc-20260327;
        b=YyQzw3ax8DkkXZ1dTQTL4eQ1OTGfIMAhyXUKey6lMIdaRV/+r59H/3QYongJPLiHqO
         e1FCY5QHpqfqhk2mxFtBNzA2AESw5tqquo3xPQ8wFlEwpX64n4i47ipNxgqdRwHqCny6
         4cu3y1in0BiYOM//o0f+isOiDRIHpzMxXk3rHzRfFSdwJbNRAqCCp6Ue0a9e4LsdJPGU
         NUGkUe+56D2005qTyqLJKLqnWd9914KMN9c24KuFGYQRYCzoCZW4WPyXdHp6ptzkWyGt
         j2omHICFWyT/nTTX/EpVR35SS7FEPe12ZZgDuZ3PTKgpdWmU7ab/dTja+nadRMoNusOF
         05Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2+Bo0viCEB2m22FDhwGjICfsYsQ1DUFzTfnhxFo1SU0=;
        fh=aXDfrw8Dt6LmnavW99XW81NZ7Z3AefLkG2MYAWcPMqY=;
        b=Tk6K4pSNKXczhmsOrvJpL25k6M/fhmVLbAsuzdiMzY0wGE1hylUZxY5iE0jP2KEAZP
         QCCpE2cdtwawQR8xuKnOsDaHF5nSreoU3X9gk4aEFVQMgfXUFTgDa+8YP7wBZvE2M8Ap
         08GunL7UzmGMP8TbC30JKN2zAFS8/ZglG0Fft9kSafMng4kEjFsN9tqIHRGqdVkyKFIm
         rDPMRd4jcvAiNNlBMS7Jiph9Rg72ngcJ+f2bKYg3Seng7AZN55G2xxW3ifqP2UWV8Sfi
         tDDAaKasPucaUUjT02May2/tabDr7i1fZDH8vR4mw0zT7LZuPMH2f5EPy7fnBAX1zKVP
         bGyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785096661; x=1785701461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2+Bo0viCEB2m22FDhwGjICfsYsQ1DUFzTfnhxFo1SU0=;
        b=bWjNmrzfOcznBPitgGj/HS0xLXFm9c9EvME+U9Y38WewNosDqzxcptmAggNl6jtEYm
         THi8L8kT7chED9bWcXg7+qUv/N7TMowQCnPZL3LwK7fkr6tym+6FhlhoxdYN4k1BD/Uf
         9qaSxmxHi4Sjq3UYpbzBwI0DQFesqVWoJqU2jiPsnBPApLeCtmNo0OUMuH18+2f9+5LA
         oo9hGHabcykOJDdvexQexzB4IBppCw9JBRQRZdnqM2zqJLAfzdlDvLn0nywYK8qtiGOj
         x9pUhyT/uAItjv0TDjAWjuOVo5/1tolIctW/xUEQ+wdpDz9bPsJdIrkZuxbm8Nu+sMBL
         pOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785096661; x=1785701461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+Bo0viCEB2m22FDhwGjICfsYsQ1DUFzTfnhxFo1SU0=;
        b=VMrHhoTNKy8eyotUL1fA97wXLqD6GFlfiajruM9JQunBIAunlDAorNzAqA3mx9mJaN
         JSYAHEaLIzgsjkmOGA2xSn9DTa9d6ilJCiRMwlPz2u2YsvxJDjdeewYy4XBIGzML+rdF
         LXM0N5Muim1bxKLIGy4qA4qp/iCcbEKV+rgYMUQMVy8kZ5VbKE6XQJ1AM4yW9nBT+LH5
         pKwwRfLMiOecXIfHQHCDKSk69cbFpfnFSkFwZljUjeHKzXe6p3av4fIpD8W+FTwyngKr
         aAlYLx9SSWByFku8uCdVNqVU/Cdvvo/c9SMPmyEY9XuNMtp2O8TJJdi1dlejtM3xMRnw
         AtIg==
X-Forwarded-Encrypted: i=1; AHgh+RqrJD0Qj61yQMQV0phljDhiCAphKlw7Byb7rGgMnmpD9zGAgOefU9th0LhFOKIykaqjjFRfoKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjV5kFnFXaQ4LLLPOSYJmmzOaAkTnh+m+XF7if5WfiryXHXMrr
	FdQyIIo6ZxmNZnFMN6sq0uj1bdA8Kjr22+i3O3TBM/hkNccIScx7zkxEkNvCi6PrdUlKH98/TI3
	GF4epc28ru5nW2NyjNtPNNcbKzXxMipk=
X-Gm-Gg: AR+sD136hfmhzpQmyi5jdNj3PIWvxHBe2bsYwTw+JP8LOfFG5rO+AdBRgNt5MlA88Vj
	L/TG+NRMz6IBeCu/0IE4FOtmEzaQXzeFCdwNkk61VFrzGg1h5YBmb8If5q/Pw6MG7aP5kQ6Sy4w
	Hn//y5HjJp6p8oFjz72caLSXOCcM+2lzoq4Gc+ewrUA4R9sYUSeLa+EK5He6dpIRkk2M07UT3T3
	N/gOzIA8uguAX/etZHnfeTAHLCXQMk/hzC7WxHDFHCbxxnSsVV98J5lSWrrsTmjov9CjOWv
X-Received: by 2002:a17:90b:384b:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38f294ea3c5mr6088330a91.10.1785096661118; Sun, 26 Jul 2026
 13:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
 <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com>
 <20260725220443.GA41199@quark> <CAFLxGvyBGzfwh61F5YkYqctNPCQJCpFOwTtKfDs4L+iK8WJZpQ@mail.gmail.com>
 <20260726155024.GB1673@sol>
In-Reply-To: <20260726155024.GB1673@sol>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 26 Jul 2026 22:10:48 +0200
X-Gm-Features: AUfX_mwZurnXooec2A3FqadK1K8O_igYrMZGYhDFbqwtbTaFK-ATjGnI_bmWgHQ
Message-ID: <CAFLxGvzaAH+ZGr-OFo=Li1aOxgwBjjR76T7m1CjFaL-6w3KPPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, demiobenour@gmail.com, 
	Harald Freudenberger <freude@linux.ibm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ardb@kernel.org, axboe@kernel.dk, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, io-uring@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, willemb@google.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 5:52=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
> Then I would suggest that skcipher_bind() should check if the name is
> "cbc(paes)", and if so use 0 instead of AF_ALG_CRYPTOAPI_MASK.  Please
> go ahead and send a patch against mainline (for v7.2-rc6) if you're
> interested.

Patch sent.

> On cryptodev/master (future 7.3) it should get an entry in the new
> skcipher_allowlist as well: { "cbc(paes)", true }.  That would be a
> separate patch.

Do you mind a new field in struct af_alg_allowlist_entry which indicates
that  AF_ALG_CRYPTOAPI_MASK should get bypassed?

bool bypass_apimask;?

> With those it will keep working as root.  (And you mentioned in your
> other email it's used only as root anyway.)

Agreed. While I don't know whether others out there using it in
non-privileged mode,
let's be conservative. If something breaks, users will speak up, I hope.

--=20
Thanks,
//richard
