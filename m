Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0733122A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677570; cv=none; b=IjbRNRUVGJbK4AFzfJZgSWJ44BNfjOnr8+NZmf1Tz1mlFpv9TGLUSXQPhyePCOC6a9wbHGzd6EwYFV8PetuHM/EFrhpLDXqKaz3/2UP876uKbbEb+p/tYcRQDYRy4MKCvEqbIidqlMDZGlk2XSayD+nJ/fdMDRl4z08vAjQ1Nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677570; c=relaxed/simple;
	bh=1os1L2GB5e5KABJZVchLInn0k8MY7FjaIxR/3mzuh2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYQG3e8BcdfDhA3SGMisx6jcwriJ1mj9ryXGx6iaDB+q9xkL6k0KTXc3bLGed5dYL+X06yg8Yxgby9OnZmPhANVSZwQmQ/4fUl9r4YoKJCzZJnVLxLqVQRX6tT/Bo49WdgZe8hNaBCcWr5Fzkxj6EAV9ebNV2Ws2BhN6XnI2+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=CMyj/Wxg; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CMyj/Wxg"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c0bcd8f194so2227277eec.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773677568; x=1774282368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsecIzGgCaThD+yeP8JqmssP2YGG5y45IxXsgulV0ho=;
        b=CMyj/Wxg/LL7FkLXUHnYRNIefBVd/hwbrrgSRU+OBhoRUJcbWmpOi1oC08pndferMg
         Q3lus/Xm4DNyhVX6seBh8RqBlfuaJccPgjgBta+NEF+Rgh+Z7XVhFc+t4Dgm7EC+4xIa
         xMLcCnQnCxIXozEFbFw2DILn84mD1vjQFhwh4l04PZeXcAwsn627fSPJDcjmbHJ2YbXr
         tl3NvTRUzO94+GM+0Tgu+Xpp4ze4y0RSBwx0MbfmlKGpVHeFIJ3NFhn7Rsf6cTGp+qXq
         7Zot/BgFuJIuUw5Pbk8rTtU7LgTzfPm2zwLyh9XCsdYLjt65FHqizCPBe6Vp/UwjRQ/L
         OZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677568; x=1774282368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DsecIzGgCaThD+yeP8JqmssP2YGG5y45IxXsgulV0ho=;
        b=mMWAz+VexDnZF9uCoe6DtxpIzs06ZR87QYa7s+3CTX89WiNoRKhhA0L0+H96TLaMkz
         cDcJqfTIS+Y6eNQNCx8NeN5KgvOliD6GUJDDoZi/icy/69x2qJTelkttd74Dz0IVPK4J
         FN0vT647yQ4CL99drClkxtWz8Revm9C3vKie7ODuY8Iqvm9cOcayIOoZHKkQyFdYd6Hx
         RiaWBRvShIz0XXMFNv3DlzNRZvrDSiBa/fEtpTt4Chwii98qWYX48sM9mX73Jo4CCSYV
         t8h4HDwpJy5dVF6rp6IWWJnC4r/l+rgFIHqE/2GtuLouMpjkcLlOr0ni3BN4vDdBWbLy
         PiGA==
X-Gm-Message-State: AOJu0Yw8V4ziGeLmKnET6CdgvhyrDaFObnocbnVeMH69yH45fn6bmAWT
	AhPFPtO+RmU3ZixSlVv7y3ZAQSlWAzKe624ZrwTw5V7rAZRi9Ptv54TKYkwheJw7Mwc=
X-Gm-Gg: ATEYQzzcJGrvYe3/ybrtcStaQ4htafzN3s3Rochl+hMSrfof1saqtzFN/moIXjlg4zU
	UjkFLO7FRcFW1PYU/jfiDld0bMbTp9nOr7fPptNDANZoTYkm2HxkjmaOSM4/MfBAkxY67uHtkDP
	8zWxU/Z5pRqcWemgjwrOq8Ms7Guo0QC3iodu3NUc8eokPnC0hGQ5tcftZQgshLLegYEqhQhsTWf
	Qbip9LqKAE+hsGivBvsSSFtC3mldpvZmMI8VzdqbqgVNf8dlTr7hqE8E/CbnnM/2jtoqgzcQvzs
	AADzmp/kV4iWvniaoYoueifaaynP99iAOmynWyxuhJfks9wfwpa1btFCQPVGeoiN39wUrc4kzP7
	zh85qVzFC4qFNJufnLqTzZPW/7BU8oIE/dXfSXGxPyyDLlJY54OV6RiAtK/wEWw2JfQLiK6inGV
	7mOXjc8Kkd89evfHyRvOIeh9+AJDKXYTTKI8I9A3/x8sQqhA==
X-Received: by 2002:a05:7300:fb96:b0:2c0:c482:7ed with SMTP id 5a478bee46e88-2c0c4821a0bmr1947041eec.7.1773677567927;
        Mon, 16 Mar 2026 09:12:47 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3e4a54sm16779795eec.10.2026.03.16.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:12:47 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:12:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next 2/3] mnl: add fallback implementation for
 mnl_attr_get_uint()
Message-ID: <20260316091245.05ac89fe@phoenix.local>
In-Reply-To: <20260316154418.625026-3-jiri@resnulli.us>
References: <20260316154418.625026-1-jiri@resnulli.us>
	<20260316154418.625026-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 16:44:17 +0100
Jiri Pirko <jiri@resnulli.us> wrote:

> From: Jiri Pirko <jiri@nvidia.com>
> 
> libmnl introduced mnl_attr_get_uint() to handle NLA_UINT
> variable-width attributes. Add a configure check to detect it
> and provide a fallback implementation for older libmnl versions.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

How far back was this? If it was relatively recent would
prefer not adding another set of config tests.
