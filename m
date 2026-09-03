Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAB3FF89B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422960; cv=pass; b=dHLMsWILinQ8d4KfWeMU0tB3Zxsy5fhOMeuYPsJya9T7N5tUlaMSzRCWBDxNBdHySTCU9zUtw7XWnAjS95TiwXBKjHIIT5mpA3lNFm0cBhxdxhbGjTyqXLOD8XIaAnQWUjC1hZMbdUp693opBJkoTMv8n44LhEKWvAifSoVyb+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422960; c=relaxed/simple;
	bh=dWEo3mp7frOFVKITzORF+6HHk5U6mbYoC8XrjT44of8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVubYV+oYBGbsnL1HsfcpsPTcsXMqHJn6juoXcyKNbCAOyd8YxFqVn9ywtDfS9HCgE2kLJpPSau9VZUzIWEpof+rtQc19YRwOz8iMSBMhUICK7uOLFebai34DV11y8/75vpiciG5pLV7dkbOs7sxEUFFZLeN1U+YiOfC1nXDbn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=k+HhOoMk; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="k+HhOoMk"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a2e985245eso15305041fa.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788422956; cv=none;
        d=google.com; s=arc-20260327;
        b=IxI4zS9NFFtouRFn+eGuP0ubuf5vvvdKIp044ww/cBejN6kHPKjBk87HWL+BjTiRZP
         7Li/eYR6LLPTPxQkVaCmDZVVOSVHtWrwZuqGI5NziqLnfI7IPX3cfPp6wpnvNN48BPwk
         mpxG1lXUw1zgpma+5fJBadBus2KZX2h9TNS8Xyl34IohfQiIy3r75+rteVaNkI0tJmnw
         Gw3qWLTf/iOY1aBzDNb0ErxspXLN4ijARZu5loNW7kzTSvcS8qXQqwg7ZqIdX0nTgRGx
         ucHsYbt6F/MByKJCmHp6Ht3qKoCykcOEWrkTCw9dnqt+yMAmIAJ+3xhe6TQ+08s35FIa
         H3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XTfy45raSGSmQ3CPJ+k8R7TpaweRcKOSHtZadmJbOaM=;
        fh=ZjgBDvJKSttC6moKaL1J41sNQdFe/mZ6Qsko95gfD6w=;
        b=RVEZ9UTlapah/BCm+o8VlzgJXEbYWRksiOLbSI8nw54rQeald8w0VutJFkTYclUaPM
         UcWc+AQzYIP1td3PvMtNdbIo4M86fqTTA1Z+BWvqWAGo3tufO6MArBqFNjpdh/tTAdxZ
         CrOF9EN84Dk5I/hmnQtt2p3X+Nemvd43D62WsrfUgLhg1UidWaoyClctZQzn+sIRTUJk
         ZH791lCo/2tBZJk8dMvwMIF3pzE1wHcv1a9+XeQgvdptOnLmev9Pr37wL4Z8qW9lqUdL
         mxlvoG9s0eu5S4t+3XjXfWoFsl0xx2B0i2va0ZggIJLbrF/+OyVNFY4edDjyYP/PYDiv
         lr2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788422956; x=1789027756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTfy45raSGSmQ3CPJ+k8R7TpaweRcKOSHtZadmJbOaM=;
        b=k+HhOoMk6tLRoMus9fcYwhdY69VwLNTc+4p+IDImaI4AoiK3BLP67bD4OJY3x17luV
         tZDTqDifOEFMu4J4vHkZwLZMr+HsyumkVqzkU6ZI3pMB9g8U0ltgFtrlxD2e2/OxHa0+
         iO6VWeVs5t2Yg9zM0mVufn79jPdTNOC/ffoVl0tSVHCYcm+oEHePv4JGolDmo7ARLW7s
         eDNd/OkC703ZRdRC0/T7I+OwjmecjtMnyHyvq6E2rbRLgW9o3YmVn654PbY1CDt+8NTB
         WMItEVfAcnlyzJkdSY6t2/9TlgxJtmbjfOXDXgRHiSAe4U3nJf0XZjZgTkFQqC2nsnJw
         0jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422956; x=1789027756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTfy45raSGSmQ3CPJ+k8R7TpaweRcKOSHtZadmJbOaM=;
        b=P1y2WjnDmyHtcLs2dob3uhJmeD6EPYanMRVEn+LBqlIoC6lzO1MB40ep6D5i7O7c0B
         W2AKDD0WjU3f4ELPVVkFVuRcoQhIPH8lV9S3pM2D04cZkoD08j50N6QNkCud12Zpt2hq
         9Dxtwkcr6+DNMoqA4n3uMBYEi2P2mNNKaKpQpNeFzy6cMHNafeheBlIsoqC5blyQM+zu
         z4YnUsDXeohbyX6ut7KsJ2b2d7xNL5pz2v8sShBhwiNuieoutcfF4BKWL9+QIIgH3W4j
         rROQn7Y3NpoiEHgwKDaWykaitWkSg/BF6VYMGpzpdOxssqcv8yKaQhDvgzvSlcBlUMRK
         suPw==
X-Forwarded-Encrypted: i=1; AKwUvBwszWfDcFU8T16jqptJtGpBDE95i1xqo4ujh/p9tqELFIw8GMm/Rd5eHkPI9vXHvicIFGo1xoE=@vger.kernel.org
X-Gm-Message-State: AFuF++nqkQtpbsbdGkGafhLuBiDtQGWUKLT8ITQyaTSRfBWUOW2lw0KC
	eGtr52BVzX2f9hw7hmQNysB9foRktd/iD2lBZmlFe9ioPmjlSfgaQYmXOgyDv1c1XzuBW+/rBYy
	tyiHLesk2GfUWZj1e9ZcTy9iMsbk7hSjmfqthHVJtzrA=
X-Gm-Gg: AYBFou3uEP4pesOiF0qqjGsskVhyNMEoD5wYgNRH9BOuxAABSfoaXPUWBxKVruB/whT
	xh3zfLq8ojraCX+2+HRU5xVEhooAITB2frPXhz94JPRNz7p+69aIPzu+G6GlsiU0SQ6qNITp884
	ryT4zID7XtSspg3kKuCaiORGa2lLXMwsjvVQIWaZsHyQwbbSlbhc3CRt+4a7KAjRb3XIWLzlRnK
	2xQstWUsjzfveASLr5LusE0dOwW5ywRGplf836SNRIABigEANZYTIy3gfI3LDhpoKTNnqZ5pu/P
	AWJ/nQJyqERZ/0MuC504vNVZRnxUTO4DBWGmxK1r+kAFyKjaWm8f4svGGYiANXZOMe798EQKApQ
	=
X-Received: by 2002:a05:651c:4ca:b0:3a3:115d:daf0 with SMTP id
 38308e7fff4ca-3a35008931dmr18616021fa.6.1788422955902; Thu, 03 Sep 2026
 01:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787903722.git.zihanx@nebusec.ai> <8e45ea5d0cf764267a90d959fa40f0f831aabf08.1787903722.git.zihanx@nebusec.ai>
 <apKl65BbdyWCtre7@strlen.de> <CAANe3eT8ycDkomgpzZmni7hMrUX1fr2dE4QvQOcKCPEcw=J=2A@mail.gmail.com>
 <apkahwSdQhuE6gRV@strlen.de>
In-Reply-To: <apkahwSdQhuE6gRV@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 3 Sep 2026 16:09:03 +0800
X-Gm-Features: AcwNN1Wd0FgsqLjcXjqWHA6w1DrMXZKkBLBFaJpau8ih4FBDSOgZEW2Xg9zNQoQ
Message-ID: <CAANe3eS22cFoqz1DWAkLXkskZqO3istpX6ARSKvBKBBVKKKdtQ@mail.gmail.com>
Subject: Re: [PATCH nf 1/1] netfilter: nf_dup: prevent asynchronous duplicate recursion
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:58=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> zihan xi <zihanx@nebusec.ai> wrote:
> > If you do prefer to keep a small nf_dup-only change, I can prepare eith=
er:
> >
> > 1. disable IPv4/IPv6 dup in network namespaces owned by a non-initial u=
ser
> >    namespace; or
>
> I think this is the better option, someone would have to explain
> the use-case for DUP in a user netns.

Thanks. I will take this option and send a v2 that skips IPv4/IPv6
duplication when the network namespace is owned by a non-initial user
namespace.

Best regards,
Zihan Xi
