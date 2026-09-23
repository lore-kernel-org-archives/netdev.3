Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978C3A3E73
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200557; cv=pass; b=EM2diYV7bsAyw0M2jWnf9MhyNRtPs8wDIzKzH5fuq8DJG1bYsm9Jti2C9ZV9bkPfqtPbflAiYyc21qmfdb09gUwwNj81/PC5DpD0c/0sAzcZDEN9SI95Y24JYPpHSBRxmXSLAcmL+GmMMj5QnylO7iOuVwNvugPnpMumw3imA6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200557; c=relaxed/simple;
	bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRH8h3CGsTNzPHdkeT7jBsWHeB8nybZSOuXqJYe/q/IlG11ES4vBJdsTVHCM3Z1gnXsbIIrSLLUJ1VhWovO8tgjxYi3rA1aUX+n9dG24FljiuaE3XKAqsiHD4z9BYe8BcvyG04tUguH3I/TZLfQHfQad5vuZOADDb7FCTFZBBwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQ4W/vVt; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQ4W/vVt"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab50so5555c88.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200555; cv=none;
        d=google.com; s=arc-20260327;
        b=YBKKAep31JqGs6Z2VGZSYc0fVuZ+5wiN8KZ8fai0MhHV0TdkupRpZDSNOClqDPYhJY
         psoPxWJ2IZeNwQlHHzWDPjrWvCKgnJznE85lqtvTcNJYMtMl8MXDw3yNxKupAQLsUiej
         oinmI7B43fQdjamlE7tUmBKJIHC8nhtjY99pYZ7lBB1CDI+nJZ/r4qNSMOkA3jFOR/FV
         GETn+4VBFB28OHLlXY/uJTJjjnW/OB4bn5aobIPcw2x7OKgrvS/nS7DRXlUEtKj/iDZN
         78fyIylXLcZTAiYJL/iF4MlZu2KUKbXlaXnb6BlfKNdBRVelYOSVhGq/R7DXk3eGrtxX
         k74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        fh=N31HnDhO6Ox2yiG7z9fjtUEhWTjfUXHIlK1oFmcBbeA=;
        b=dfnTmX3T/jSXua8tqo8aRQyLdo1RZDVL6BnO8MrypObGtVZCeQckfWHga7bSVEDrfs
         78VTB8FFHGk69/ARgzzwHCOfokZCnwWKufWWxtHAlD2S0lWzldVRpuyMmjplcu4QCQZ6
         td/M/e7OODodRw013ZCTNTpfOYzNa8pOX8Em3qoDXgHmAxLSpyG/vDk8LQQwMHaXH8kZ
         dcHRnKo1V6/cQRuYe3nL5RdlqEjQDwdNR9xtaaRI52LWKrJRfMH8wTBMEBmoLZpphNGV
         NFXFe2q8MIC3yxDSDE0ElJYgam99MODqDSGB+C7YF4+Z9ikrE2+qb5+Z3Vmb7AlyYLkl
         fjOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200555; x=1790805355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=sQ4W/vVtcgYs08Bw1uW62GshBLFsCf+2SuhUspbAUl43fvAImcngsuVK/BTefam9sH
         iiU52ddr2/T92Btgc6OYIvgrlHQ8QKllVsahF/BK3HOgmOe/owQn2EW6VUDhaGuV6fC1
         c3HJhB1rwaUYsKXARIouV4OqsoQx2qx2+Hd7EVhh2Kue8OPSqgmM5KMUf7RXxiYaEbdN
         m4JEWs2xQ5HY1/grNFI2YFpPQOkg6S1R5G/63TqWZDUSA77T9qr76eXapKO3NB5tCPyL
         Uc59vU8a7duU3jGM1vx3p5z1ovijpZMS3U+6pI3Sza6Aj7W+WRBDbt5YMMCqcUPCLXnt
         53lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200555; x=1790805355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=jOLNDFPt82ZWXuby6t+zvz3DtW+vC0Y7vlnh+zCaMjM7krkhKEsrBtq5265f8UETIA
         6CgGlcZbXi8z5hJyolK5R0gqS98ek798UvOfiWK89o4ra0bHEBW4+EqkYqdndPS8nTxY
         Y0KbR9MMXBOGjjbkHRfIUsYpwkcuUdLvrwVEOrDalCf6iZRNdRBvR/A/+Mn1GzNket17
         h4w1p6m/exakH4yfgrSa6cTdYJOYvkGFzyXUrpdwa/tQ6nO6llufGVIyNchq6YX2N+42
         pZ0QS0lNkXjTB+/fVKMKA2tJ5gZOWyZXiYG4MY8lduzAjQhETLXby7gFcYaeSgHzYvUg
         BNJw==
X-Forwarded-Encrypted: i=1; AKwUvBySpLAGsPp+W/pRtZKM9ssbTInLu1rod3Td7mr9lexMZGdWSsHndflJIUamNiQJgVK+YfQ0ZnI=@vger.kernel.org
X-Gm-Message-State: AFuF++kDZG7uJJCSJto5CYcuvgZ3D0DmyRqXhiYn7LxPsQ9ZUMHA5uV/
	PEAL0AdI08XMC9liHLINV4tdOydF7i8BkLtAZKND+55pBMiTsAmCK5xzkfH/T2rzr9sGzD+RPM0
	9+I3JKTm9L4oJJnz2GoS+CsrBRxou6W0gS2joWv1y
X-Gm-Gg: AYBFou1OqK7A73O5R/uhrz4XsV/0q31OXQUZqRktfzSMmYgb2df4AzoDty96AjIWcQE
	YevPSnzPFbclZlOTFa7Cg03jov60+p9prKma0sIxsMzlmjF3xO5Kq2gNeGDnUxyexrcBg4y/8i5
	AV1x1iraZEPx8W3s52w5gMVvcVhGjXsd3RHaC8aMZu6VM3DX96x4D7iPGnuAWVVzAFZKNSGmFd/
	RFgIQu3YTRNyYnjr1VRS5a1/xTVQO9oyKQEmcyC9JvAONid/3aO1lNt+v0pwmgc41nS6o0rUSQg
	YsmI2M9TdfQw12Wrq1TNfZ/lHnYqfD2DjczY/ceo+db4xSpkb66Dbm5uxwpmNVb0I8QQX2RB1At
	/oCkICo0tUPij3HT28pjINYvhPXhK1VDBa3F6/zJav31JdfFSUMWk6xYt1gFjXRgUwE1hKAQeac
	/DUoqvuQt05F/Xg2t1/5QD/A==
X-Received: by 2002:a05:7022:7e05:b0:143:2983:ce54 with SMTP id
 a92af1059eb24-145040b94a7mr316024c88.36.1790200553776; Wed, 23 Sep 2026
 14:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-7-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 14:55:42 -0700
X-Gm-Features: AcwNN1XgHvs1i0fjUduZ4DuwABZEWBGQf5q6nvgGZ6wvR3_WR4A7LceYAzcnw3s
Message-ID: <CAAVpQUCp5_UsZpgw9O+VgONDL8Dkhe5Qx0svzkKKmodT1xUTvA@mail.gmail.com>
Subject: Re: [PATCH net-next 6/9] drbd: use sk_set_nospace()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use the new helpers instead of open coding the SOCK_NOSPACE
> manipulation, so that TCP can later maintain a cheaper private
> copy of this bit.
>
> No functional change intended.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
