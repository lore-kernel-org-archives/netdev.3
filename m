Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172B47D94B
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244148; cv=pass; b=Ichho6Em1Aq8GYk+UtytyKTKcombTZlOToq0TNF5Tg0F1fptpLuLv3dwWZAkaXeCDr0v25A4QLuK5dINZ6qJkpy8z8NZaMCqZlvJtnGGzZnpoY5eIuUMXj6ZOEdoBOlCwnJn5IZYoL9HzWrkzwIXzHh3orE5lthzExTVOUNiWt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244148; c=relaxed/simple;
	bh=IDBX8VXLQ9hx2WC8woOhAZSlbEQbCQWrld8aiY2TGYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHP6SJEak32IQ/7TJzcLirx6OC7/kKRYBz4ClfWnYILWlGKE4Fz/ySqTB8+nwIL4ieVeIGL5MGB1QLQvH/mEQwHiAwEoXfxo0Kyc9ybg/MKCu5X7/TfIZfcsEu+vKoNLJnwVGkgYRJwEfpvEyn+1wJf0NEHEGPe0DV9om6mBPuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Z7vboocO; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Z7vboocO"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso109511a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787244146; cv=none;
        d=google.com; s=arc-20260327;
        b=UgL7y+LmAVwqdq3+6OIf5wEAnBHqoLzK515rhrxJrmD0Ero6nKu0kQmeh21UJbNlar
         dQCZiz7hiAzNKF5BWih6SuRC5a0Il5ftMRhrlsgxiag8kzmfoxv+KGYwbyzC4oQyeJVI
         PYEPQtHXcubAnpvTEHIKGbuqJBu44GLJ7pQx8HzbgYAha2BghLGGY0KeAWV7BljVswC6
         MzpqbJN09OYWqlg3+L23/5C6bOOqMlLN73BE0zG+neEc1kTritZkTysEv8aNPbRNnRaX
         N8r2tn8EpEOM5l6vQT6qr8n4x5rqsOQFLpd53a/yePr9JtTylcsldgE7fsjqrstFoDXT
         CDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2yiP+LhZhC/qZnEWNXj41fXpS/L9buScLyFoFglz2o=;
        fh=D4KZ5Ohru90pleFtQIlYZ/nRnLVaougvxGKb2H8ndLA=;
        b=Dsok7U+TvmD9LgIJs3CaL7GBKLXmaXsFaygkFEmjCm7QDg9Rbg2X4lg5SY7sT1p3Ky
         hQx4rWQ+8xlu4e2B5tuRihFt359x1j4yo+JBjEjR1bgqY9bQgW7Y7tJVM6cGY0od6P7O
         P1Yb2BJmOw6bMOGtwxCoM+YtALsECZgXlPjsq8sVpL+Un6PqY73Sg5vllg/NK9+7y4Lh
         YwSaRlo/+wtvZyDwUb2EOJJYKDpYJ4pB4XlTZgs/ea+6FEw+Q2nHFw8XAabVxQvcEh/+
         NDj7hHD/HH9kyYX1OCi5+yH5q96ckX22oQGOGowMVrGqIDnqVUC4IHzliA3+n3ne1nBE
         JXJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787244146; x=1787848946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2yiP+LhZhC/qZnEWNXj41fXpS/L9buScLyFoFglz2o=;
        b=Z7vboocOBuJHP/N28j13IKnXK1QJUSsVZWZADKbDIhcl28w3ixc09A+iQmLB6y4RF0
         pIbUx1kUyN9umAoUWWXLsybYAM5+65N449BnACPx4gMAhSwySW7EGw6s3Mvubx+axIdY
         A7k0FsZgQgMh0JAofd80VyLEPlxi2l57N5doA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244146; x=1787848946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2yiP+LhZhC/qZnEWNXj41fXpS/L9buScLyFoFglz2o=;
        b=hK8RE23AJeGTq/eIIzmtA0Ec0kDrx176jahSYALfg9mhko2sFKjRHNNETrALB/WjMi
         pRIQyTyOs+mXJjjy1hUlqUspFn40DvEIvq7k1Mqe8Y8Jutw0M0DShOeqj8IB8Em0q5fY
         Z5ud8o4Nu+TSW+lAxDHM2739berEkYIhoC8rw5NDxKI6s+guqHkowZvYBc3oxgs//eZg
         6DIcvxAWVu2VX0f49UCuk5J0ieI+TczEKL0jgkcYhJC1Cag2L4hoDObWqO0pLg87xFyl
         RaKdZNTGSe/Le6aY5zAHeNhpzUJTCKa90Utg5gAB9eKqo0qB2BqlCfRtQZp4yD855cVR
         V4gA==
X-Gm-Message-State: AOJu0YyME9y3CytZ4tJ2waFd8+H7k7CsAk8vDXyNwxV1yTG0gLJx5JxP
	BQVVOD8Ng7PKhZ0k5/UdzW9hkH2Y+TwXy/rkbze1qzaMLZxPkadneepkhPDZkkv0kqD89L6swy6
	doa5wnoamREsc2cuyJYNKdG1PkBxKPiC7E/zjiNPdg/qMcKJe44Yu/RyG
X-Gm-Gg: AR+sD13uiKqGa8YHOWuS5y8RMwFovxqFK2E6ecnYVu6SsNco/DnkpvhDEI/6Cd0SbJI
	m3XeF6w00i3BE6gBzBk9Frfexc2CYItlFGFxaMmPmBnjorA2LjRQXNZh7k/scECH31x8HgDEL3R
	jrkOrC4NAX0Of96zRSw6DSY6n591XS7rAgHZfbYpER+oDPNt1DZWccbdw6EyuapAuwxQPqVyyWt
	cepECEweFEAXiYZBzhjwlzqVEGYXuJHoa/T00Q7H9lJYaXfN11KI2GW+24haOnfOz1v8+Ufp7Bp
	3ImrlAqo6w71IG30zKY40pAFNkV4QJoL7+tqF2cOtA==
X-Received: by 2002:a05:6a00:848:b0:84a:2c46:3fdb with SMTP id
 d2e1a72fcca58-851d3862b92mr23921664b3a.5.1787244146053; Thu, 20 Aug 2026
 09:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095236.68390-1-jhs@mojatatu.com> <20260820095236.68390-2-jhs@mojatatu.com>
In-Reply-To: <20260820095236.68390-2-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 12:42:14 -0400
X-Gm-Features: AcwNN1U6Kw-V4I0kWZuvf6ET2mei_Yx6Hn09_R_W7mFlT7Gfj3HR77holbziYwY
Message-ID: <CAM0EoMkRjG0-ssck6b39JA_439U3N=s3nEt3Av1PVZzvcA_E1w@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: tc-testing: add u32 node ID pool
 exhaustion test
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:52=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Add a tdc test case (7ec8) that fills the u32 node ID space with 4095
> auto-generated handles, then attempts to add a 4096th. On the fixed
> kernel the 4096th filter is rejected with ENOSPC (exit 2). On the
> unfixed kernel it silently succeeds with a duplicate handle.
>
> Fixes: e7614370d6f04 ("net_sched: use idr to allocate u32 filter handles"=
)
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  .../tc-testing/tc-tests/filters/u32.json      | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json=
 b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> index b2ca9d4e991b..b9019b14d05c 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> @@ -353,5 +353,28 @@
>          "teardown": [
>              "$TC qdisc del dev $DEV1 parent root drr"
>          ]
> +    },
> +    {
> +        "id": "7ec8",
> +        "name": "Add u32 filter when node ID pool is exhausted (4096th f=
ilter rejected)",
> +        "category": [
> +            "filter",
> +            "u32"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$TC qdisc add dev $DUMMY clsact",
> +            "yes 'filter add dev $DUMMY ingress prio 1 protocol ip u32 m=
atch u8 0 0 at 0' | head -n 4095 | $TC -b -"
> +        ],
> +        "cmdUnderTest": "$TC filter add dev $DUMMY ingress prio 1 protoc=
ol ip u32 match u8 0 0 at 0",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC filter show dev $DUMMY ingress",
> +        "matchPattern": "pref 1 u32",
> +        "matchCount": "4095",
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY clsact"
> +        ]
>      }
>  ]
> --
> 2.43.0

Some of our long running tests have failed because primarily of the
tdc test in this set. Will resend with a renewed tdc test. Hopefully
my attempt at this pw-bot thing works.

--
pw-bot: cr
