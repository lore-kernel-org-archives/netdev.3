Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39281F942
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786278667; cv=pass; b=RFkzspRiyzu3cNe18+nUl2fNAzYyyrYmoqtv2C+6AnsSucDy2yOBI7BZPN+1wvxI4eL1zNOpr35+on9eMjTDcYawcZuciNc7VrQyrVzmhBPiTqasZIr1HOP5Lk7wwNjZuMHOSOB5HI+Th0wBW0j1ownfE5VFprYia5xB8YKDZDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786278667; c=relaxed/simple;
	bh=HT3vo3/zV1p+l+nVtI0/0qwtWPomW6WUQNX2aSf2RZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUzpPS8iV7P2ZRH+Z4OPXBAJ/AnSA8dT0PDbagQY+lUOEEr1wzumeUEMEfDjIRLU88MJsVP/iRXbaFMmNLrom+ian74BokWkTfrk2nv8jOwxA0tXjaNDNhYB1y7dVBJ84YkYXHsExrduAzUaUw1VAxyg6GC33Ke7WUhiU5ugO54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjqqEwjy; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjqqEwjy"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c95395230so7881811fa.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 05:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786278664; cv=none;
        d=google.com; s=arc-20260327;
        b=VGAt86NrbZCKyhTK3gb4eG2Mv3xUNctcxSd3cEnlte5sSqnPFRrfKpf92RQOVoZlwX
         EAjEpZudSjxjYSXxGN3CAfEeNpx5EpgDB+cS1wKAcy+ta+VEsrNYJxUYtffWYHbGIuYT
         O6piQOPiCPiixpEeI1PLy3dSMdBBjtpgCVZuu5ygxzAG8zV3Pnrm9uQfiII4t2qyIJgZ
         D/v2jRLeDC1J0YwoozDQTL2XXvTa0Cmks5RurmocXaAkHt8MH/zcc6jriWj/fYYT5a4Q
         fstakKC1CGscOuIo98ydw2aSqNh+B99dK1z0yUaoemfzZrhPlawQA72QskwjUtEEE8s+
         H9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HT3vo3/zV1p+l+nVtI0/0qwtWPomW6WUQNX2aSf2RZc=;
        fh=zutxzr1jX1Vlwo9UCbuXAtSOoTyERJpWDQ/43+ZU1/s=;
        b=Hp5uDUKBOxZKn24uDJkYCAhZQ2WfNF99KAro4v9I3O1t5El8Iyql0f0/XIaVkph0A5
         dYnbZx/ZCJTtK9JsA0gO43pTuVDFivYu2bywI4D8CSd9KR+RH8jVbB9MZQe8+zYgkuC6
         LAOLKNIoXWsVBnirkS5uMnX3U1SgGHHVOsj3Ukd6f9OENysBMCq5pq9xFYVyLKcA7zc2
         H9baOj4upMebRUFVSQUAM+y5gcRCS1xwEA1rv1a90bC7hR+cCdmhEaGK0M8Hd0Wr1rg3
         R5/uSN9FiqTYqioIS0/vWzQuYWsDTvRK79LFlbXBck+du05fsFsTxD2nI+0ZrFe5Ee+E
         qdmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786278664; x=1786883464; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HT3vo3/zV1p+l+nVtI0/0qwtWPomW6WUQNX2aSf2RZc=;
        b=jjqqEwjyLccib5qsPXZbXg/FV1EswzQM96rSJpdtVoEEaLGib0pCgTMwH6nbhB1jCv
         9JqossYXSv4bD2vJ5aJq3oGAQ4m+EMGWxbyGx8z1Ei6m6v/FAeixhZZzry+2T+KxWf6r
         KCXFFEFpZD6yMR6aVG/E6GWpmJ1J9K2nkhUkwjH894Trlz4XMbZKV6WmfMCeikGCmRmy
         O+0dp6iJqEs43e6WoFrT5cSCrOtwEbIj3KrN4Ufe20nbGXyjG5V9Mh9mRGVco/G/y373
         mS04VhQadzMsrv4/VA/QEqDML3Q701/iHl3sqgL83WjKG64KUtHb4WOunTUGUfMmg9VT
         X+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786278664; x=1786883464;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HT3vo3/zV1p+l+nVtI0/0qwtWPomW6WUQNX2aSf2RZc=;
        b=eR6fULJzve8/mxpptaGkIXFa/qYr7BS0+VSKVYKCloR+ve+DMYzxfrFJsCF/UdCcPz
         QdGPBW4PMdTOSmbpkJEDvnDHcwYtGsmBXf/C8oB+XYC1XsGC1mBLMy9okd/I3HWVzupR
         DA6frzZhV4oGoHXfHayBbsA0G8fuwxgaTKamKPgLk34dAfC2qVoETcwzcqEUKdnZ/oPc
         nV0fsYJOzuhKKmHJI1UCb4HuOXF+TG/wAoF9GC+HuhSAVqRpHXwL5gp8b34BQcXrpegw
         rBlH67HsGmtst8ldbTJ4ER4eMGgbSxCMc1TNXJvQjTzEDtp2c9bSfh3wBqysjYW8l8ys
         /Q+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpMwtM/FDq6ebH0pefFAhakrlf8+4+vGo6fWoXiFKh4FaA5LDSZAyQcYfz7tREnO/1T6s3BVQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwOnQuB3DTn5CIM4gxFDDCKH4RhmMxvzgv8/2TS/Pu/cBNIyC
	9vGM3QNzHJ6J7N2VzYCsEX1eXsZ6Fc8SdGXYYJo7XaiT2u5PRYnFBcE9Gte1EE/pBBwkt7sTwoo
	sIgEF03M6YAmFbXxiP/IWmEMhgl12YFs=
X-Gm-Gg: AR+sD10a3yzoLvfXV2SlqIm3i5D5KkQDr28WHY4EWlNYc0IlxaPYW6pZNMIaHoUEMoS
	lB12IYHFjTlBQZKWdZuWr/lEGzY1lgDzfDdJWDvVtErMUUAgkAvdm5NL36h7pfMqm2aJrL8eLCf
	c59cPPBbrD0ZN48ifPZBBazStclkCB1pPzryLsZ+e9UveNvh/X1z0Kj35rqL+0gHF0OsgSLA9lf
	c0Zrco2rnZeoyYd09kfIUUA4HXv6NIHvTy8AnbQaqApSDbGoSPAJI+xJY8xbPEHQ2J3ceQ9iK7E
	8lgRE22MgkFo1V/84sagzhSoNwpf+3NsqTI4XNrLaMSmiFBChTzKznARBUjNcKoLCLghUybA9Tj
	HmpXoK7uTLZxgH4zHloD3FMKjXPRAJ8Oy+R1THON+UuBU
X-Received: by 2002:a05:651c:50b:b0:39c:628a:5c9e with SMTP id
 38308e7fff4ca-39fdf4c7159mr16729681fa.19.1786278663583; Sun, 09 Aug 2026
 05:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808005642.26901-1-sigefriedhyy@gmail.com>
 <20260808005642.26901-2-sigefriedhyy@gmail.com> <20260809085043.GA2339479@shredder>
In-Reply-To: <20260809085043.GA2339479@shredder>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sun, 9 Aug 2026 21:30:50 +0900
X-Gm-Features: AUfX_mwo6B4semUt36dKvyNKR5MqJ_kwj5w307xK6PG6zmt18TOQVUDOZzOYmao
Message-ID: <CA+7S2vJ0rFcXgGxVUw6X4k8BdAbLWwk2W9APQW5ZYXVMHa0J3w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/10] ipv6: add ip6_del_rt_reason()
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Chris J Arges <carges@cloudflare.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>, 
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Nitpick. It's accurate for IPv6 which is the only address family that
> currently emits the new attribute. It's also accurate for IPv4. Other
> address families (MPLS / PHONET / IPMR) can start making use of
> strict_start_type in their policies, but it doesn't belong in this
> series.
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks.

I also went through the two Sashiko runs on this series:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260808005642.26901-1-sigefriedhyy%40gmail.com
https://sashiko.dev/#/patchset/20260808005642.26901-1-sigefriedhyy%40gmail.com

Most of the comments describe the intermediate state of a split
series and are answered by later patches. The remaining one, the bare
OSError caught around the RA sent in the selftest, does not seem worth
a respin on its own; I will fix it if the series needs one more revision.

Thanks,
Yuyang
