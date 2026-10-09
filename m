Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21A3C7692
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584659; cv=pass; b=Muys/QCexIrea1Yx8F6hMCmvPxXD9HKykI2DOUEQZjZrk3i6vZCSsnb40jd8pNrz5Mnl1xiEjCKrO1QX6ZOMkx6mBKXN1rWokk3LLPdAD0SfTbAI7DpLnajzcy/l+jBXR+Nnnd1REq9gKWqjhRT+0jlULTtbW9b2936cz7kFnYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584659; c=relaxed/simple;
	bh=wkk9g/cv0bTiuOUVnmDTIZSymAhfjBKG4zEaCsZqHls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIzAOPeNCE4OlNAZnbQuFAak03KGYctFkvPOl5UCmFE/6ThDp0C20MK1eodGmOkAyrXMuc1qlK+tzLTuV0Wob7g1rUs865pj0c5UiMjOxZ6O1INWEQl5+p5MPCrRXUIYun+dSCcq2gyhSOUuQi6EU8cWbdKs8q5lfDeASFXGq+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0+FGfJU; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0+FGfJU"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2dc8cb0decso37428966b.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 15:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791584656; cv=none;
        d=google.com; s=arc-20260327;
        b=nXQWX/2sKl9eauhLaxhAXsLkPieB9WXYjRaRVzpK15t6a3wpe9O+G5CG/6V0pRbvRn
         xrMoki0tfbVXV65bBfBvop4zPaX3TZn6gv/Gwrneh7HQbnEY4gZA4EemN5eRQXS4P7t/
         L1nOrA6qGZ05T0J3XnoqJxreb9yxyWPad1OLEVrnDmRGznT5oWz8fqqAOOCissqMjhia
         ev4zvoDXJSdI3ui6lbHdEUuE8vCMtQLzN8D7ZFRgArVOkSOJD6atbeKxUlYHf9d+0uxW
         FaANecPxtdmWQYdGOFn8jkr/TUra2+e9Fn9jkzsDHnIB+XN4JfUmlJXyWkjUDkdaoKl1
         /5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nTykBxHYQFwv/AfiJaRR8cL8wiizEDbLgP3Z94SeRcw=;
        fh=4pAzjZM2pnz5M6tasf9cVnMxxKom/SHRAzN6VshHjZw=;
        b=qtfvmwiexKjPmgq4n6NbY+utuK4f1xaK341mUMd4FTQqAUALXruLbPy2lqDJcoe5W7
         LvS3x7je1I4iAb1dlo5lvVSSNiCvggVqPNg8/H9YbNEOedAKi9kuvl9jMRHDcCBTtMna
         vSUfrNwnx9JHRkw9zKm5kLn93JfWDqyNRlr0HXBRL/cRLSPGuvfsaYyRanQUxqeYc5CW
         +GkD/BygL8ZygGQQR3xwduwZEFjujvcAc3MSCTBPRC1NYlBuVtI6W+WCJSr559ZJCC0r
         DfhQ+PhC/Vsu2ItVRW1UdAQIA6GnZACQqK/ZVW1pW4f6PtQXFYtGbXSOWRNhMySeDSC4
         WsHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791584656; x=1792189456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nTykBxHYQFwv/AfiJaRR8cL8wiizEDbLgP3Z94SeRcw=;
        b=B0+FGfJU4oGDH2QzGee7LwoLMFKfDFXzvHiUuHpkXtZeJLZGvJC4/aBDWKpB+1Ob0R
         c51hclIIcuqWA9M3ODHhX2yjSd2c+bxCUTVVoW8A5x33ItV7lZDZUS/Yt8Lad5hHBmFw
         s+tpUQFz2mUIhJ1ERawnPOF3efRCtHtAyYNVBeA+ujxtsTaOIBgJjUFXsAPRpcFmKsIY
         S9bHCC0bfQQe6OQbyFAFy8Zx36HAQupzHBK/bldYX8GR0JznoZqBS4ay9HPZt+8ZBQsc
         aSZdSfJmTpy7cJDXnAtxqhh8y3UvhSuDZRNvOlGGbxvhi9kRC1ztynbe1WL6P34Do8Ur
         BjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584656; x=1792189456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nTykBxHYQFwv/AfiJaRR8cL8wiizEDbLgP3Z94SeRcw=;
        b=T+ZCv8QCiZPmbYVzaMG2+XGGFdAyyW6/tQe+75bUIXDkBcZAOt41VG+SujI9Ygtihg
         R/0lG8+CpJYh24yfPwZDR4s2d8lS0O+T84NJmiMRjzWkNL6aKZ/CeJ6vFS/7+qm9QKCB
         6WTblBcIALfNmVsBydRHb3Hymbnql0s0VkPx1Q0WWc65VfOOZJRGi5N02I7QXEMl1K9m
         ab08OrJauP5jXy3gV5rNt/RDoZK9P5IWbafMYmRQJjycd0v2eNN2ldc6EarjJ4ovH9P2
         gH6X9gERwLhNFezzfV6Owtui9oV0WfhcyVaU85EBo/otqka+x4Ero9Vn5+7PG4nzO5Ww
         aXZA==
X-Forwarded-Encrypted: i=1; AKwUvBy0Oywk5n0fhGOrgYjZ2nvtSjFTJ7weDOwIgTv/zi7vHXL73P38vpp9yBUXItdjWuGux6xLfBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRxVAacDSorF0yRKx9VBnC8XINpIPwQ8IMdQq8HEzNBUXb/mKa
	mbbe8TSa63ExmElrg8aTXffRCMAyaE18p+88+w+jZTRoyZHS62gkQjmjbV1I58Jk0M3EtIRMMbZ
	ewx7bjxrCtX4cvnk76MpzTuC38fay6Fw=
X-Gm-Gg: AYBFou1YzkRQcoxm/iFvW+VGeQB4ECoEY6NVc9QXFeTqZ0gpFdX4fAVw2g9l04+J0pa
	Gmk4Stxf1E3ZDwwPeRerovz7Zxw1t+YXUrhwLq52brIiSHz/ZWlxAK0Er2NBK8Fbyx+kTvpYDzJ
	j4IyTrzDa/oRZIfhoIvI+XVrlkTRg1Xexi8edMiT3A6Syz+Ynwq8H8pohH6Jw6jOQLhtOTlNfdB
	8PpCwUaAqnoS232R+GBV+wm0BJFvwQLHeou4P7FfY6wuVAMnYLaellmSpFVfgJS99aVjDalI7SW
	4xBfGhRCjlEAiCZmTfl5pdPMSPbIZn0DJCdXSwfdhWWBzWYOmkykp0YI2hCQxjm/EhV+16NRNqY
	Y5vC1PlCb/JY2/zR+2ldkxGfc6H8g0fUHiD84wA+0m0rWa1hPg0PC9jFhtYv1Csu+mNN/LozRfZ
	S5BunFSh+ZKwT8an17wToers3vArOd0poQTEcgYGt9s5x8QdDb9KCTdvHdncAiF4+Rcg==
X-Received: by 2002:a05:6402:321c:b0:6af:9bef:cf75 with SMTP id
 4fb4d7f45d1cf-6b17c1e03e9mr3017169a12.4.1791584655827; Fri, 09 Oct 2026
 15:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007183821.928263-1-rosenp@gmail.com> <179139868898.2527009.7529803204490860855@kernel.org>
 <CAKxU2N8QddjJfx377npH94+Uaw4kG4GkAFh-6wofN9iXO-sNZg@mail.gmail.com> <20261008084246.03aedeb9@kernel.org>
In-Reply-To: <20261008084246.03aedeb9@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 9 Oct 2026 15:24:03 -0700
X-Gm-Features: AclHuK8b8aS8TctL0na76GkKIfshYPCXcVIs96gCmA0GZVIiKoz-U6FpaxG9OuM
Message-ID: <CAKxU2N_vk0bL_+12a5bq7KF1z4b5C=uVyTGkos+x5b7bQgZaEA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: emac: mal: replace devm_request_irq with
 request_irq to fix probe error race
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 8:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 7 Oct 2026 12:20:08 -0700 Rosen Penev wrote:
> > >  - How the issue was discovered, e.g. hit in production, hit during
> > >    development, syzbot report, manual code inspection, LLM or static
> > >    analysis tool scan.
> > LLM tool scan probably.
>
> probably? Are you being sarcastic or you don't know?
It was. I asked it to find memory handling problems in the driver.
This was one of them.
>
> > >  - Whether the issue was actually triggered, or is only theoretical
> > >    (e.g. found by code inspection). If it was triggered please includ=
e
> > >    the symptoms, like the stack trace or error messages.
Just code inspection
> > >
> > >  - What hardware the change was tested on. For driver fixes please
> > >    mention the device (and if relevant firmware version) used for
> > >    testing, or say that the change was not tested on real hardware.
Not tested.
>
> Please answer all 3 questions.
