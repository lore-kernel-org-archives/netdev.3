Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B04CEE51
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572849; cv=pass; b=cnFpYvt7IqSiYsRPrdNhIWRWvMUSz3OKbcOwlNosBofYyuPcSKcvIyIfIfAG43RTQMjKBT9ZxWzxQRAqKjSTD0tUgE/LWg5fdGXaoebG4ZzdJ3lHVDszUueEhxNMFatPb0nCtuWEWjoeasiOrfudc2HPQ7eNOx0Jp0BWT5pkvfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572849; c=relaxed/simple;
	bh=zZktuYM5vkbbaJAwKYlDDzrEkMORd47SKIFSfpXwcLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMNrogwPP9oKTVVi+ZDAqNPKyM/js5CELO2sZ1EnXCBs/WdyBOW6MkcYVi1vAXqtnfRdgdS/Sx09vb28kTN5hTGUYUNhz9nFn+hQcuhGePeL8o12UgLwatlHFZcfZi1/KcerWWEwNcIifx2g6uS3+PULQBM7aOSwJM54z7P2rAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3E77TLb; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3E77TLb"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a30eac5so656009b6e.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789572837; cv=none;
        d=google.com; s=arc-20260327;
        b=QDKLnbcru1vREe0H4zV3rfimTNZcB7dx7wkrqh0n39BubNwxHhYWBd2rfzFcLjwXrK
         XJkL37ldwWr0EP3byAm0UdEhZxHCssfnRZiYv4Gq147plImi10TOiPfPqq4MAwD+7DT/
         fOtIZCwUVFT/QExp6Goo3rx3MCziBkTcbc6IcrJODEQn9vfk1kQvQ+mljnSMWLk5q0+R
         xtpyvq1A3SihHK/PHHMpHu4FdT3OosDtxGaELQuw+zxBOPAB7qa+HOUGu386aiGKhocv
         KX2+Azk1XTtjGlgT/S2R6xnITtLFz/Nl4LooBcdN1z3oRXJ5ZyqNu9L84X4e/klOgxWI
         e4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7nXkNJ0W9DbPmL6Zr/GJxmR4Go8S9Arg4OF8y81et0Q=;
        fh=wEvcC3P4qWViI1SRGZsuIfArFn3ZbxxNbZHtz2y/5j4=;
        b=bTCRSbzLRtC0xmWOd8nNgGd+b96/Os80pa3FKDjKxA5Rgn5zAl1RlMZ+Xp/Mboy94j
         z9EhuTpdpNDcO231ruGn7uPowTvb0Aec/zMURhrGlRoNYbcIOfU3kpniBJmHWYXy7rqr
         7TX0S+D+B/teN0FIEvhaBBFw5GG3FKmXDieDx1AzAOWKHiBixkaes5sRL0YZu8LVqAr+
         ZaJEPBQ9NxeyhPT57QX4qfpKNFgiuWIhAcsDHxphkCLEdXgn7QILP5WUppZ8Y8GqffyR
         u3NJQXtRJWh64NqE3P2pSIeh8Dxz+GFZA0sehmrHrXQfGTXfOmZW/Xguq9ju9q5W3f7r
         KtDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789572837; x=1790177637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7nXkNJ0W9DbPmL6Zr/GJxmR4Go8S9Arg4OF8y81et0Q=;
        b=h3E77TLbuA+xKn9DhvAVsPAK3/GSck3MHKLPyfLuzqhW4DeqnWeH1DIb/16b9FaytU
         aXE+ONNiSIDmVzIIsDgCQvw8IqnZSNFc+tC6x3Q/v9BLz7zOweIANakvGHuN29qXm6ZD
         cv/pqUBZg4OUV6WVlz3FVm1aWVRhth56upbmPatJlTdDKW3ivvJsNaQEevuF4gAzpuZn
         SUfvDqzBkwTOQ3a0nk3mMKxWeaHFeSWKPn/GcQpO9xNyhlSV5FD8cuyYG4qkXYodXG8C
         wW6gOVhbgIqR9/tWs6qPbI1Z26Au8J8RoOZ760gomMpTKN6AQq9GrSR+pCUrLa8JiMor
         Vszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572837; x=1790177637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nXkNJ0W9DbPmL6Zr/GJxmR4Go8S9Arg4OF8y81et0Q=;
        b=cMFY8aoKVKk5ZVfUDbODkMlA+s8jM6MCJvD8/nLhVTs8ANVwXrVaGUojitD+LvnAFE
         bnV4d/Q/EYxi9XDh3hUorhAbyoACfXIgwCzxP3OAEV1nZrdXglBgyLn0ogjd59+To1Xi
         gWMvVGlZikym002VGL22iPKre53OGnCbnLcHsXVY4DPyZgOoMReoWNyG+R/3FU6rxMt8
         HlU0Hu0xr7LgCNLfHlynfTyAOmsM+7Y7aC1MMQwUmBOs/qLycc7aXCiQwHDX/UNW8BLp
         NeYssuzETROTVW4zFn81aCcsa0ghElrH8bu9aSrtGniN0yhE+7T+prqHK7F4d+MlkBaK
         pSpg==
X-Forwarded-Encrypted: i=1; AKwUvBx51ZkJ44cjhdyMn3CnYb+4FxfaHf8RJbibdEHqN6BVGiMHpaZhYkt9bYq1dmI6IEGIUmCO5qA=@vger.kernel.org
X-Gm-Message-State: AFuF++n12Jx8TIAVN7UAmtkzxeqK6SrH67yLlqJkfVYLnnXnox0ZIA1j
	+J+xQIj80M6nvo79fMm/uPaURcQUKTIyoCIOjiCcQdFKWW+f/cY307DqGql7UIIDRq1tO2I71m/
	y6HjU33hfVDaLrvNQJWg+A2voA6t11QU=
X-Gm-Gg: AYBFou2NQuvK5Mohx1NZ8NQ6WhiAWuAjN6S+GRVN29bHrlFlPlMAPYLURDr7LwEunoX
	r0YuNUIm6rCdf+8wtGRPgTpIoLMriTuqXLLU7Ewn3vVlVBtNou8PgGDbIy1UFd4l64WLb+AV6oy
	AYJMe0LhlS+K84G+L0cvWRSv7/UWs09edZcz9eGnJyG+j9CK5NG7vrfwDJpCI1W87N4PGGPEdZl
	xVLdOvno31XyP/saD/lAkJwiwJ17sL0TjJ22/AYJKx514kNiFAYXo2yITpeyt351ecX/ZJLLcse
	xxHO8NGtmAaZfkv1u2ITf841jVK/ms0xDi3mdDKxwMZtvBjyyJ/2EmEvdHCut5d+60r9rdbYfGV
	kOMX+VS5Pzvgx
X-Received: by 2002:a05:6808:192a:b0:4c1:2b62:35a4 with SMTP id
 5614622812f47-4ca4b209c35mr7149752b6e.5.1789572837389; Wed, 16 Sep 2026
 08:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914103009.3007019-1-kyle.switch@motor-comm.com> <20260914103009.3007019-2-kyle.switch@motor-comm.com>
In-Reply-To: <20260914103009.3007019-2-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 16 Sep 2026 23:33:20 +0800
X-Gm-Features: AcwNN1Xf34H8g-kn4gOyiQSOVYNCT8nY_Xc0awS-9DZtNhTPEXcDEx2JStxG6x8
Message-ID: <CAAXyoMN6k4Qx8sJCw_t1W3mMrER-Eo=FO3ZjHr3BbaxJDeW5Ew@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/6] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 6:30=E2=80=AFPM Kyle Switch <kyle.switch@motor-comm=
.com> wrote:
>  static const struct of_device_id yt921x_of_match[] =3D {
> -       { .compatible =3D "motorcomm,yt9215" },
> -       {}
> +       { .compatible =3D "motorcomm,yt9215", },
> +       { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, yt921x_of_match);

Meaningless.
