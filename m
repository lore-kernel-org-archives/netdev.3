Received: from mail-lr2-f33.google.com (mail-lr2-f33.google.com [74.125.230.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1A44B66B
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558836; cv=pass; b=MoFPyF26GXttOv7ZlLPFPJRRX+19Abj7OLdSB2I6uK63LMMuc7C1dVJ/TGtQ33n3gb50osHfkgcoD7jmNRqGYp5UqUAhj40KSYTz5Vqqt27IFDVMhR27rmgSOP+EcvPa7iTcU9pfgjtKbGrWkkinFRCYHMxaU031A2FsuU/BqQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558836; c=relaxed/simple;
	bh=wMEyFjezcohw5i9hNyj9Q/Ko0db3fpn41JnBHJR+aJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=km+qBS4/DvkjvOyKY9Cwztestsv4oZz2URYojknrIczz/Z/Z6oGbIRGE0tcv9g00CECkWFTBDlyNBKls2TvW2LdKYpcNJT4cb4t7umBs9uHGzKWod9Tk3ksuyd7isjjzxdOuhj7TO8cisHRAvHMU7jo4lW7gBGy2XDPcADOKmcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ow5z78uR; arc=pass smtp.client-ip=74.125.230.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ow5z78uR"
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a2ff16c0e6so6420021fa.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 04:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789558822; cv=none;
        d=google.com; s=arc-20260327;
        b=jTbmuv9VhHxNqfr7bdfOPw+l46tx/RHLJxHcVQ2cpGqzMg3niC6Vsb6CkWWWA4QZEm
         mK7nQbohcQpAGuIOJjeWo0rKS/Ga4FE9bYp0IFIWKyyFArLTIxAu95RieijKaoWaE0/z
         8/Yys8IfO0ypM55RPOsllML6aUUCrUz2TPR9i0ze82MTT1xpXK0oXGOqE8VL48Hja/Ik
         mvjJkpF0qWf4EGU5THlIlW4n6CArZ+gZ+5jXXI+oueTkjtLO5rhw3eTcc1hnCQUR2GT9
         btygT5OMTEx5FO4GgeAugdR6/QT+hnp9jB+EJOW25OSEHgYWHrVBuW0moRMOuwhSn+lr
         ptEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wMEyFjezcohw5i9hNyj9Q/Ko0db3fpn41JnBHJR+aJY=;
        fh=Cl6TbWE1pGdN2UWhW0vE4nl6ATN5cgKlMQbtvc1uEyE=;
        b=YtmzYtAAZF2Sse1GKh1wwcKfg6a3XBF4NVJlZtVS4HhUs/GIFtihOCV/Ui9A5D/ds/
         hYjE0F5anTnlZA1JvKrFUVRfp4fLVBOf9z8SC9r+u17/nfXKKUurBdqNO4PLFalHuc0W
         1hB0iAsAxGh3XQ/xLaADfdOKWraWqWPYTLnuaaQA8LfeVdHKzvCckXjzEBedNtZsESew
         2y9Gfg5X0S3BPzhs14iG8UhbUx0ASa98XnaaBDGxe3bECGavnpJslXCcc+gZmCkirEIW
         aCdMm4D3o1+DGdC7Tv8ONIRWLZ3fUnTptFZmtqMoWZgu99h/5EsBNRkozT9+9TBGbte4
         ++ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789558822; x=1790163622; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMEyFjezcohw5i9hNyj9Q/Ko0db3fpn41JnBHJR+aJY=;
        b=ow5z78uRRsvrCxH5IvYoWD9Zt1t8AOjL71wdPNC5jb7P07zrWHOrFpJL7wRFhSf4P8
         rjqRl+wDUM6C3VqblXQYuNYsc1aPcVSuQNPqAgkl2ruR16V5joH+QMSNRQPOvNYGelaP
         +3s68aUq+uY21ligjRtaSaTDMUhzMo91CravB7nh3gtgIr0F4ATmnboA/I16sxzfsedF
         VTHwY73GPIpUYntoLMv0eVc5SqZnTMcrg/2qzJi9rfn0s1bHasJWZqKlPK6/ImPiyWPW
         lbEKqYK1nqZY9DoN6o0simfbillNyLPmURsSFcdmOwvlA2oWjF2YyXtL/nck1fRfD6ZV
         T85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789558822; x=1790163622;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wMEyFjezcohw5i9hNyj9Q/Ko0db3fpn41JnBHJR+aJY=;
        b=dAeT1yRePBbJZEIeDhbgJb2rU0rpz0sUcakjOY+TA7yVvG24OrdvMAifWulsJIMNE5
         k7tE6WkqA/fo9wme9Zio1aAvFmvYmC5IofcDdUO2yGXLgQ9qYJRP4y2zYSlECOqPYvqi
         0d7S2Xb893n+fLCmhdba9jYIJ80LJFcZgSryBZb7bCUfgzRXaTO2fir1rKTvSydY2nSM
         uZ7Cp1rzzV3tWiGzc+bYoy9LpkZH0i7/JSynrgosJ5B85JwHaFLeP/39EBT+4FrACyXJ
         eqg13mX1kF4FiUWx++y0wRih5+Rv2uDpv8kDPQ5p9SS/iAs6SQ7/LEknHM5c8u4S4eV7
         V4pg==
X-Forwarded-Encrypted: i=1; AKwUvBzj43lXEvh0VQFQbH1vAq2+7+4WFxmU/ajKIAoiy/lDCmZor+8zOgv7KO1jWYJ+ZPHGSfBIDGU=@vger.kernel.org
X-Gm-Message-State: AFuF++lEdLIKEACMDV95EgsNOwHRU612eG6IX+fo+gSG1pWoQ1hkgLbK
	HnxRBbT8wfhSECu9rJixjhmX/8kPNfHK5bE1jXingmU80691dceTs04K4X3yUewY+0s1/Z+T0Ww
	yVGSRWTeXYWgLEW21rSeqL/vOAUsrdxs=
X-Gm-Gg: AYBFou05QZqGN6Dib56JtlS0VDeUpDgz5/SuwTucguGDXCdvnO4ZczCstdt6N62kkno
	BDej7x3uQ3TvsxtqRDveFG0GV2l5G/jJysSe79y8naeHlQ2EX3bQUKNwW5QCkxMbH6ZM+KaozlJ
	WoGsQDjaDErN8TrRf7yjh0O520f7aceUIGyI20ElzxKpTTshErEYpDiTEMCp7sp3AvZ1drcFzzu
	MYR/hNX02x1mSRzIDha/yYDGsJC+ieQfyBBL3rZC7l8tlA1FCfs8lgR5iu4zPAmUyJ2iM0SEPdC
	9Rvvl/Vwq1Si3tDhy3DVsIyEiHkAxe/OYdBjBAFzZdscbXHpb4BRrTNqq9Nn+3DGxXHiMkyVpIQ
	N96Mp56Va+OuAOOvXyuGckz6OSU+Cm3V+iCZUkjHe2dDh
X-Received: by 2002:a2e:be86:0:b0:3a1:aab7:9bdf with SMTP id
 38308e7fff4ca-3a5dc9a7b2bmr4436121fa.5.1789558821474; Wed, 16 Sep 2026
 04:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914014539.5015-5-sigefriedhyy@gmail.com> <178949085358.22033.18209492388519439190@kernel.org>
In-Reply-To: <178949085358.22033.18209492388519439190@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 16 Sep 2026 20:40:12 +0900
X-Gm-Features: AcwNN1VmVXqC79iWucgVPrvrF5zMHqjVFQWTwIUaoH9hzNGmR7oOxMrBe8K1ybU
Message-ID: <CA+7S2vL7qS_0w_1x=vh+=XQKwnBMyN77wmDNmHDFUEf3qhyAUw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/4] selftests: net: test AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org, 
	donald.hunter@gmail.com, edumazet@google.com, idosch@nvidia.com, 
	jacob.e.keller@intel.com, kuba@kernel.org, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, pabeni@redhat.com, 
	sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Can this final assertion actually distinguish a dump of the peer netns from
> a dump of the socket's own netns?

> Should the doc mention that ifa_prefixlen, ifa_flags and ifa_scope must
> be zero for AF_PACKET

I checked all the Sashiko comments on this patchset. The two above are
real, but they look like nits and are not worth a v6 on their own.

I will fix them in v6 if a v6 is needed for other reasons.

Thanks,
Yuyang
