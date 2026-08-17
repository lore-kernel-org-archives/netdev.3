Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981743B4B5
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974054; cv=pass; b=cKUrSeIf5D/qv4Q8kz+MTLTDdFR+zT4usTkUPyLfC2/F82pLGQN0Cf0jY9g48MiztUOI7IR2f5pF7/mvfqhQhD0GvOBCU/Ta8mVAEiwUwlBzfVPX6OrJfRxxEoL1xke4zMgjr0ioJ2i9YK/dSjWIcChIp+2xmfXsxFn4eiO70Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974054; c=relaxed/simple;
	bh=Jgm4ipKGLzxqeuyAPP8rkfOU9ykTsHDXuuiToEL2ITE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knuWEbT8su8e6IeriyfklWOcUZI5dzfhW9i5UxUXMx4HqPkZiJIlhStZMFrS1SvDHfDnp7jkBQLoGJEtAK5XvQbPGHHL6m32jQLjPKN+tBPeUIc27QLl+AKqOvTPEEuBSsXEn8doNFJEFASAmYYC7AwfL0/Ft1x0ViirpJ+nNHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VseObnb2; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VseObnb2"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ceab75934dso41518695ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786974044; cv=none;
        d=google.com; s=arc-20260327;
        b=QHWE4zCSpVc/e0zCSCmIeJMRD1Ab6CU9wMHOid4bEohF3jzR3b/tuFHn4sd7Bwz4Cu
         A6FuwHoTR5a3OfscXT9yx+jecnCyNn3J7pCIBl1nCWAFomJXFVIeGGjbrPwKAj384urY
         APqiPxXDrxR/I1v+6VW7cODMenLRHAu8hPPfuMfrPzfUuVVrgQUHMqczc8AkNXtE17G3
         qbtYiGpuVI+pWONLU2taAWvoA7s9MBBlJFqYAOnDtlfH6YYenMecl4ekx0pTIDPCtj4W
         JoZKAxLvRD67C/sUwjQk/zw2aubXqt8O01uptcWOv381i/M83yuQVsGngNipRRQscagt
         +5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jgm4ipKGLzxqeuyAPP8rkfOU9ykTsHDXuuiToEL2ITE=;
        fh=sx0s98sr3zXKOMFa1rCceeF/HPh5UZ1Cu14j8l1rW18=;
        b=Q2kE2b5N3H2uDg2FJyy8119kfmTq90GUFLT3VcK6cJD6uUejqZ89hTsZEr1WvX2ddU
         14tS//ooA2fUckyYEgda73vHAKhQRKcp5Gp8f5g6eRVZdRl91P+Qe6jp01AIc5X3N5vU
         tBY5EeTaE9SpLlJ9CeMMA7AdXNyQyK+oV+9uxj1cihiwz+eBLcrN60CzFgnfCldxvz8o
         TsNOCGkvps98bTRSqLwID0qAp34bPptx9e74MszIHVycQ/Pr9tb6q+b99ZulDyQGXkOq
         rhYKOog+eYiXKMvqIiJcU23+jBk5bhHnzXlAL61BBINeT7hGo21dq685VD/PEL1BCZ0h
         X6vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786974044; x=1787578844; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jgm4ipKGLzxqeuyAPP8rkfOU9ykTsHDXuuiToEL2ITE=;
        b=VseObnb2rChlduVm5D6l/mhAZgfpculidphTGJg5P5BI93U2Ou16gU+xxEy4XIFP5U
         UgoAOq8Xyp4q1sGxoDGWC1loXouK7UG8BD/UF3VFZmhSOdB85qpnN4uwwK7EaoONAfhf
         en1AQ6lYwBK6WFVSSBYeaGVl0b0Axu7phfcE17kDa7ae7PwpMgKeZ8WidKMiunWhTmYT
         S6c4VKZ/JteTZQpgh1wx9njCf5U/d2xIM0bjETvSocb99dIBBYFIXHHkYiqfRz2v9Twk
         AeJrQCOV5bW7H7EmjvvvKg9SNwxDtrUsmylDz+vGDlY+abkbNQlqe9ZF0ONNQbUaAmU3
         SMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974044; x=1787578844;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jgm4ipKGLzxqeuyAPP8rkfOU9ykTsHDXuuiToEL2ITE=;
        b=srtHP7A6gqJFzRViBv4VsO51G/kTY5t6Az5ZidEjPMtsU6cp54dGURXGQtxLCUe65f
         xEcwvY2caSR+GOdIHo99jywnRpztyR6TDzZScSb7+D4EN/EKBc1HpO0saNam2jpUybnK
         SqNSrRbkMrFnQ15lJwBH1LDCVx0j7kzdKc+M5oyy8omKFh+W2j10UQiuL5tXUSXYcH+L
         4vxKaFjVMhLdD5SKqgL0H4erCk+3jcUNWQEXVglZEav+6F3I68K/bF3tPnKDh1pPL1gh
         EcGNkgWB6d819L88lrZR3NAKaKtguRgRLbuzqV+oaO6rXO3tj+xEIxJzQ/VE1kad4ZoN
         AiLw==
X-Forwarded-Encrypted: i=1; AHgh+RpjyahIpPAgNWXM3dWxqDcDi0dOHe8MVARKnIJ5Zel8OlsazlMtMuOs+vKSUnNi/ZpvX1o4PAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziy2BfPo6VhWNnw5T38yqJqblfVJLuyRjN+ZkHlH2uKWDwN6pq
	IETUMSxgniMq4Zu6cTIZNFXwxFNEFPlN9sP0jKOXgXxiK4Stkqi9LQAD9YTD4fziCdVK713ra1v
	W3c8dum/C1KPFjqCDLvu63fqGooCt8tk=
X-Gm-Gg: AR+sD10c6HRHzglu/nMq7CvAKm3Da+tKteIlAZ6lnPkSYDTBW05zE/APj/kD1V9+T0E
	LdIzt9VbNjLqBfMo1rYxtkoWfSNJrIkCl0K5stdfP12NNWGa9xyKB83NRlBusvNsg5pOatpiwWM
	7V0FQaxfSPe71BccAlLWyk+FntGDVvYnqeI3n72smtv+k+2gWmoFOEphaTOWHupXcjGc1+GWxA1
	XvAKAEnh25ZVWrOJIZ6263nxSp7I3aDwA4sUmG7UGs/kDrVOpHs2MkHz4Cm4viBHdECgY4aANUj
	XDlQ+84F3fZp2vXLUggeq3qKu5CpeB4N+GVE67DwkWar86xUPrvwQAg=
X-Received: by 2002:a17:902:fd90:b0:2c8:248a:5dbb with SMTP id
 d9443c01a7336-2d3b0d16339mr278108355ad.7.1786974044402; Mon, 17 Aug 2026
 06:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729065035.1591985-3-steffen.klassert@secunet.com>
 <20260731021544.789075-1-kuba@kernel.org> <anDIQ9-8Sf_6StfZ@secunet.com>
 <aoK8Xl8uTm4MW2Mr@secunet.com> <CAFQ-Uc8abYE4ZuzEa0bZNmEw5Bx7DE7qv+gRxUJvUM26Ceyknw@mail.gmail.com>
 <aoL60d6utaU0vkRQ@secunet.com>
In-Reply-To: <aoL60d6utaU0vkRQ@secunet.com>
From: maher azz <maherazz04@gmail.com>
Date: Mon, 17 Aug 2026 14:40:33 +0100
X-Gm-Features: AcwNN1V4jqv_iHJCKnio8xwbDM3L1uSmJNw2y5qR6OQ94kFBCqT5K79S1e0n3hs
Message-ID: <CAFQ-Uc8ek5+KFQ+3BXnNope+NoR-XMMz-u2xL-pL2aHdww8-Vg@mail.gmail.com>
Subject: Re: [PATCH 2/8] esp: do not unref managed frag pages in esp_ssg_unref()
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, herbert@gondor.apana.org.au, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Steffen,

Thanks, the review was correct on all three points. I've sent a v2
that addresses them:

- It now calls skb_zcopy_downgrade_managed() before ESP mutates the
frag array (in esp_output_head/esp6_output_head), instead of the early
return in esp_ssg_unref(). As the review noted, that early return also
suppressed release of the ESP-owned trailer and destination page
references; downgrading fixes both the underflow and that leak, the
same way __ip_append_data() does.
- Corrected the Fixes: tag to 753f1ca4e1e5 (managed frags
infrastructure), not the 2017 skb_cow_data commits.

One open question: for the stable floor I used 753f1ca4e1e5. Would you
prefer the commit that first made managed-frag skbs reachable from
esp_output(), or an explicit v6.1+ range?

Please take a look.

Thanks,
Maher
