Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C16380FD7
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199333; cv=none; b=UaYpp2wPfhIWOGkPtB+Wzuljxj7GDdy/BdZktwr920bXOrHC2oPX9aQ3oC78+iEFwvfHqNTMoGS3df5cj53RsTjD1mG+/Us5sgpd54SfBWRWOS7BkOp8sdy2t4MxY9PX6N10npYuBj48hG255Z4dpTui6SD1mdO8JKvLYoOAz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199333; c=relaxed/simple;
	bh=/kc7PYWlypYVZP3WwE3BLRaLams28RAM1V7UJYCZVTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0p4CnORcs/K+7ODOa69C2L/lLbYQUht8ZjGz5iG7LbSppGaMxpf+qeDq3ZTTu/CWhP6SG+Zd/Nb4YGau70zppQEuuPNCn0DeXRG0KtOyg4ySUSDH1kWGzXAicfr/BrdgRhhTrSccZL9ib3+d6ujhxBldNerUq5G/tj5sW6kj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHv7odrE; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHv7odrE"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66f883abfdcso518893d50.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788199331; x=1788804131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qFhzGXcio2yqCPX9oQAAIfIvI6f1pTpkLcuZuvtREFY=;
        b=MHv7odrE8SejtQpE1GafynAeRlP8HCsgYitHwn58KMTCPNJtsmJiACkoFWQmfi+j7r
         csneJbE5rxxI3RXjzKvworDy6oUKt3D7wvzpUHFOkhjS3JJthI0Ogw9itXOl7BIaYuqC
         RSr+u0UXNoxZqA8a+AU5GiFwa9UA+chHvi26rn9I984WnQ8bw+2Eok0qlWmTcshc9ffF
         V6QBcI4UJWjIopObC5DkUH56sy6f1SaZTswgn3jgqLVEUU7Xej2yEceoKT9N9Y0Clot5
         2argFZBAXVMVjwvL3C1BeelL7dVyGc6djBBeDRWYT5sN+qZQjHpNCWsg4dhZPnwTCKHt
         L7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199331; x=1788804131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qFhzGXcio2yqCPX9oQAAIfIvI6f1pTpkLcuZuvtREFY=;
        b=Kv3rU26Z8Q0z2NCMucciwpJxaG4bIHBYVpojUR27rYvHCPpfGJeF9E6OL0f8K9+s3k
         O/y2PHWdWoonPB0asiVmsNxMqyJoUkP7y6+kgKgnh8MFeS9W+xbMJWJPIUNz3kN9qZoy
         9H0dEloqT/8yklDEJ4r1pJ42pwyF8HewfpALI/ZWG8DSL8h7OoHZ/e9lKStaAYEwc+K7
         Vb8tM554G/aE86gTx5fqyjPJ1nIK/Cf9x36DG1K1I+rY+FJN18JYvgd1cTSQbO+6OdpO
         qsJhhi9g68wjJseeWcnJ/S9su+29yA4pcFNAL6+viC2OL8ma1gVlBQ+xQ2Vkq98vMBFs
         q1Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwr2hkBbnLZnSuM7B11mLPzsXqMPiaJRJBMdT293Kvxod4XjD2trBjCWl7JHFilPbkpoQ/EQNI=@vger.kernel.org
X-Gm-Message-State: AFuF++mTdOsTRvY8FtmzUTMYpuWyDdR5SZle32Oe2X4U2qGUPWnn71rL
	fM1R8JD+7/EysKVTArigkj01Hq5qdKc19CutoUA+u35DmyZrkJ6tJlr2
X-Gm-Gg: AYBFou2Cpn6d4+ClKAGfCEvSwmZMfWnklwkenMedi5ge8bgopTwb+AH4uYIwA2fqk9R
	8yGDcFD4jluS8MtvLs1kjaus7jzMEAfaIyiPiqUNt4RIRoVGEPO8EwqZzUdqeK9iAPyqixtatoL
	/yAW4Nos3A+NF91Dw0lKQ5s/ektOJ3FO9Lje7j1/+goD/NwwOI9w3fIVBlDiVf1fdjuqS5exG8q
	iXlr8jK89ZtWp8xP01/GxT3SM6mPo+mwx2CFgmSer4q2kBk2/asDCzeGyZSTxPjKe9eioNUA2p5
	dgg9Mj+ogIvxbACEl/qGx/adFo1A78GKZpEHziAR8rWsDwwvuwsNa2NJNZA0+tqJpuB/qfT9rJY
	Y5PAYQ8vs/WqoJtpwJrTqcQo7TlbuHt4U85NRlBmUEh+CU4l2FbSavBi6nvYEgONPSlueIkhGvF
	Jc3RyosBc7EPBwXHgAxU6P5BJ56gkzwmtLx9da42NlI1nPkMzofyFFryQ+wJchWG81GaT62f/cR
	acKCsuD0Y0BCRWO7ccXSprUT00=
X-Received: by 2002:a05:690e:190c:b0:66f:7717:a700 with SMTP id 956f58d0204a3-66f7717adeemr3379779d50.21.1788199326215;
        Mon, 31 Aug 2026 11:02:06 -0700 (PDT)
Received: from hoboy.vegasvil.org ([172.58.167.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ceb0a3a09sm73932946d6.16.2026.08.31.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:02:04 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:01:56 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	arnd@arndb.de, john.stultz@linaro.org, jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v1] ptp: fix NULL deref when adjtime/adjfine are
 missing
Message-ID: <apXBlBvh0vqSzhyi@hoboy.vegasvil.org>
References: <20260826101004.100979-1-xuanqiang.luo@linux.dev>
 <e9c97286-d121-40ca-b6f1-4c63641e7283@linux.dev>
 <ba8e71ce-42e2-4c92-b7c8-dd6ce900a5d4@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba8e71ce-42e2-4c92-b7c8-dd6ce900a5d4@linux.dev>

On Thu, Aug 27, 2026 at 02:43:31PM +0800, Xuanqiang Luo wrote:

> However, the PTP hardware clock documentation explicitly states:
>     Clock drivers must implement all of the functions in the interface. If
>     a clock does not offer a particular ancillary feature, then the driver
>     should just return -EOPNOTSUPP from those functions.
> 
> Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers
> 
> Therefore, iavf does not comply with this requirement, and fixing the
> issue in the iavf driver is more appropriate.

+1

Thanks,
Richard

