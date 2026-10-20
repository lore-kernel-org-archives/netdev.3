Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792464426;
	b=i/sTgHoklLhzXwpiCUu0Yf6Te4La74F1PX3qY5euhIdMOxBx+dPi5T90zAofNCJcVFrf
	 v5uzEb3xe4DEtDnivmEVPlEknu9Z1NAHOO4mh1jw8nE7HYBNsYiAg9CKXb2wlFuH9Isvm
	 2kzRx46bM/NWU2g/b66Q5KZTuF+FSFCBto/RZE/i5UjbSLxGnFaDsl3bhhd1q1vmV+Noa
	 wtUV5D3byP/1HZp/apPU9WU1DIAs7h/Jk5LljA+AvZMZG7mNiUh0wP/0LsKvg3C46O8EM
	 s1ERrXw4lgQpM4GOXVKr8p0G3umtsQg0xKV4adCtuiagHbcn5NVUktepq4+ZyrCPe1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=250okx3Y9wdrZTBZhOyD68J79utZy7MePvsB8fpNCy8=;
	b=CpUO5GUw3qzVbxQ2OhatD16k4n6SVtKHDmPnhmFVcLLhpkoygQEO3xlQGKfydSPS6wtz
	 pN9ko6yNIe151R8N3XJTveoAROp413l4Ugrea/bBmZNNyZd0fRrJ7edLWUYyodscSLAWc
	 mTX7P3ZIF+DRL85VvpqC1JKCfc2LXljMEqS0xu3GC4lM2iSw1hGoD8wrZ/+bU1HOOq1Uu
	 sfW3TVi4uWp/Nnw/7Bo/eXkSK5EIU3twS8CsD3zbgP7wQS3KtuJaYgkmzIqi2dCwrs1pF
	 Q09QSolmm0aoxLXM0Tm7G1+lOguAFas5ARnyczOUczMBQvocP72WCYlU+NV/Ip+Xmzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MYGyRYYV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5D606A334
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF5D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MYGyRYYV
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f2f2edb19so226607985a.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 19:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792464425; cv=none;
        d=google.com; s=arc-20260327;
        b=pXUTia1LGnYWUp3H6v+2ep/Ncu6/okQWiiiyvchbo86QqJB5FnISWMqK5FWyS5psFe
         4zifd/mz8orN1xkrNH/LhsE16Aa0XuER4st4+afHVJq7f9jbDPFN/TeXrgUHNw0gLcxq
         WVaEbmbODzhEC9YDON72z5SrXJiXy6jREV1XFTpAWTTo/WXHMztVz8wEsS6f0XdPqDom
         1Ap8bxJbHwFRYdhVz0ibMVkD0SCChVOTjVzpcr0Dp29l63jXZoQi1abjsVmtFHKakoVq
         cgDGO35BQj9RWcU0zeSLSLAM6iBlljXQZhtWdjovnXGEnMevYSW64P5FBnKwR2G61cld
         6F2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=250okx3Y9wdrZTBZhOyD68J79utZy7MePvsB8fpNCy8=;
        fh=VVTPkkCdFwothPa/C8GPhD6VrFYKA7c2VpRfW9w0AO8=;
        b=OXxVq7TJFkVP1wHn5OWbmJdSOvM4h+vKyDTiuSscLD/jxeN/9kUjD+4H9iZBzhMKy3
         3/HlEh04F1eX6QkXeCCozwpRekU65PpZZ7dQVVtqrw85UbAKuiKmHJZQZkdxvRyb07YC
         TwxTM6yx+UjqzTyKh/W6eWZvlA0jVGvkOqeGcFTxzdf20zMOLlLoSs+j25nV8bH2dvZg
         EiMnxQMO6gs8epLNVawiiko4cnXRCS/PNHWG7037bQb6HEdMKNMaMN4sWvrIaShQgtAP
         m65FoNlhyFmEMRCgGVaEYm0/nutdMHJ/LwAmgJYjseWn3uqvXxDeGohFEAECyLFeCSQR
         RmMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792464425; x=1793069225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=250okx3Y9wdrZTBZhOyD68J79utZy7MePvsB8fpNCy8=;
        b=MYGyRYYVkmb1FkoYXA8qPP6aQdJMY5pWOIcHwI9fOVtXfkgQdMXXur8QkK/hmKez1l
         OQsmopyOlZjMYaH8j5y6ahzkowFypHhMRH5Rvqc5SeOC1l/ddDNupOwZZ/Loat29n/d/
         XuhCgB5AICPGTrolvam1yzaDqFwZr2bQC/zrnaJdD7hTt4AkcWJox+gJwH4Vb4oGTvtB
         ava4azRJaCfDfbmBSTt305eMzfnUSQov9yFuByYf3sW0C243NVonM4Vau8eSU6ah/+Rp
         mWdr8nGGRhNeijYHu10DV2SlTkcoSYuTXasJoLnli8psufEide+a39uxb1BIAzK1yX98
         PFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792464425; x=1793069225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=250okx3Y9wdrZTBZhOyD68J79utZy7MePvsB8fpNCy8=;
        b=Z32lqnJHKqIEG9klmuubp6C7rtL3fJLh/LBYsegK/5CD1l757+Gnncq9hN5g7t+YZ+
         dSolU+BiVxUrc/c7jyi2ObYuXP0Lh87JSm1wmi2tUrkpibEoYe5M3SdTRNS3yWAAIDPw
         BDQ0ZFnJC7+xbi7RtjcYM2BbYag7WvSjDXpTHjwgeySs/xiSytOQkQ6h2H+PIqKax0gG
         UneC1LEZ8dGeuT3GoJzbl2essjeJdlXJhOJIq8Z59qkac/ZCplRtgnyvjm7jdyqchjg+
         V61Vqc60m2ZskAUI9OepXCcqUAQBL2j+XdbQqZT2w+RO0fBEDUKEB8wQKgA7y0hdYjv9
         dEyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQ2yFhirS02kRe3zKRDsJyCsmRgD5YmXJ5SJ5vAUHAHOhaAd64PawybtOyaxObsbASZigiPKk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdCNMx9WLvaXLaVXuf6pUPZZwi/uG6dxWY8u6uav0fTXZCIgEw
	n7/4Eaxuf9UiGFyNJvyzlFIyd857YKSK2An+UB1FOhz2B7X+ImNDuBb3HXef7KVqEzVFwMlT4GF
	/waPrukpSqxLhqY6Puu9ChXmJdUXRskA=
X-Gm-Gg: AYBFou2bn8zLorHQ4+ODxjvdLDpFVZxanw4UKRWpMqWGlGP4d1Qei6BuHFuIhXp+PhL
	xsmXK6Ivv394uOd9LDR79t9JVAIkSeZZyOJKXV5luT98IDh9SUsW/KgEAgtglFRWZ/fOpy4IQiu
	ST9M3SOBGZbejqwNamFMU1EMkFc7XmS6hZBPgF8Fqybk6zGyCFfT2HZYIAqFZd7o1uBTa6YZZRx
	uo+yvLoCLfMzIKQXdYApIMTK6D2ILSsW1ZQAsXmP1AntobFklMzEHibR80QMCbdETwSCHsFU6Xl
	gwEhSMpDdas9oz9YJdANZEyej/LpITOL7Hv1XXg6TEm9Y71XeDEpOCg2Zo05fglU3e6LLqzW1yI
	1a7Lqf2Kgv+e9dAqjYHQMpxYYyXcvcpKC9El4jUDCOJtKZ1KWlGLwZOIlKFhl6Of7m6+Ct4VOaY
	leFOn3y7GAsIF4CyvGhSHexay+Ihuf0l6XccGdZIRcZMzI+RlrzYMjhGGsB7yCsKN0mH//rCSVv
	EooszYQnIqhqASSdF05ovjIVxJ/DQ==
X-Received: by 2002:a05:620a:1997:b0:93e:84e5:3c66 with SMTP id
 af79cd13be357-93f29d4e1acmr1674015785a.40.1792464424847; Mon, 19 Oct 2026
 19:47:04 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012132622.48550-1-jain.sm@gmail.com> <179181183946.2527009.5855837780305581870@kernel.org>
 <CA+FWx=mA0dsOSopCNBiA_8BrYSDYD7=jxMO7uLpxT1OOU-BkWw@mail.gmail.com> <20261019191351.0719a13c@kernel.org>
In-Reply-To: <20261019191351.0719a13c@kernel.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Tue, 20 Oct 2026 08:16:53 +0530
X-Gm-Features: AclHuK8DFXv_IzNcH66_Ba8wT464s-pDQOse4HLjbfnx3beeu2bxZQ7GEzd8p4Y
Message-ID: <CA+FWx=k7aMfwA7e3SwCjzyTuWaXXk+9KQ1GSdd2oz2UpjkcQsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] tcp: keep the route window metric when
 SO_RCVBUF is set before connect
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will check those.. Have been busy with some high prio tasks at work.
Will get back soon.
Thanks
Shashank

On Tue, Oct 20, 2026 at 7:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 12 Oct 2026 19:04:27 +0530 shashank Jain wrote:
> > > Please do not repost the series just to address the above. Instead,
> > > reply to this email with the missing information, so that reviewers
> > > can take it into account. If the series needs another revision for
> > > other reasons, please include the information in the commit messages
> > > then.
>
> Could you please confirm that you read and understood this paragraph.
>
> Looks like AI reviewer has some comments that need addressing.
> --
> pw-bot: cr
