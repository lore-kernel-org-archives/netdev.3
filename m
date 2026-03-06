Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C83A256B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807364; cv=none; b=i0H1nKrqtyhnXy2H8RBLfki+/YhuHHYXcSXzSbJqL6AmDlwu+VOIq4mURHE5Ux/ghqjBfahuWv8wM9UGUlsy9YElz2pKHoR6djAnqpHS4L/7vO5K0RFZArSOUffVkI7w15hGnIv9oYB+Y6/xmi+CiLj4gaYCxIn8VLxZwvzIlo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807364; c=relaxed/simple;
	bh=ru7BcOy2QGPb1lxmwW935BBVkRhCD2QUq5jqUemeLX0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=biAaT86nbL3LtDogILM3vcc8uUDZGIDb3H1Ub4cu92zIZ4GVv+J/MqjQS6+tUlV11KetBG7YeXDzXoxHmc9pzgUAbffVPdKRqhGDLuP5d2wuDDr4hGTHtzpTlffc4ZLD+sJdDy4PeX6RQOA6T46vRlICdLvBm7iyb6DTqWY49+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6RGWysP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6RGWysP"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so865437f8f.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 06:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772807362; x=1773412162; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ru7BcOy2QGPb1lxmwW935BBVkRhCD2QUq5jqUemeLX0=;
        b=l6RGWysPT8dKMk0aiE2wq0dtj39o+xkvUM4vj4yoJHfYBKk6Mf68bwB5dLrjILSSil
         VFdGrtcyIC6yGLYBHWSWH8CC8MgDTsjwRddf+GhwbT5f6E+qdRhoAYn9OyN6i7cDY7kS
         6kI8ouJxlO708TcywyvUTUROgei1cL+vns66Uj93LZa1l81nkII2jSG2FYiuKbdkF/1h
         Oe8kK3niJBEDh1Zb1EzXEYivIDXlJ9z/USqHogkRSw+UfOQuHt0jrbowrKie724+qSvk
         oNWuRvrdnWld51NVeU+iYq5DJrvFx0jBebzxfrlaQazyzIR7dPXHOzaI+Tq8HfNCfFKl
         K9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807362; x=1773412162;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ru7BcOy2QGPb1lxmwW935BBVkRhCD2QUq5jqUemeLX0=;
        b=T99oOx/L5yl8xCm4kU5OPiAykI1ncDw1a9pooBMfCZvE13rWC2pCqVu5Cm5C0BiKZc
         stgO4JSU1lil3asD4qndb1Vn6P5+jG97Ml4dS8XNHebGnQs8PBl8S1L7KwfUmOtdeQL8
         GD+dwHFYsFatNO6I37XgIrpr41Q95j3j0bx1qqSzNf0QbMtIuH3TWX4DTQhyZjYEloQS
         MgqqgTW6JYmFYTwIzdVWzc7aCcVWm5FA37yEEHmqJNPUEz3fjMghSj0uWG3sPiiAFab4
         izO+8pWuWati0Pv7Ehiu6pN9gPzbDQwoN50KMwLS/N6p3yWFAlXyStgNckBl0Fmkx0DS
         iYnw==
X-Forwarded-Encrypted: i=1; AJvYcCWA5udqZSYDAbitze0+wKgxFyuxDKAr2CDxTIPwBM56AAG1JQWTQake2MD3Lvj3CuL/5EY09OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynqYHQynY2rmtmFu+JpuJ3fdC3z3EH6/IXgo58c1fviZnhTg9U
	HyUu2iWrOcqUpd3LlStv7vOws/uSdSLw//YikiGSwDfeg7X4pwaZIMgr
X-Gm-Gg: ATEYQzz9LQ4vo3EgPPzi9T9ZX2eYRT98spXIX6KYuNQOuBBCceLG+wn+5hHNm3MQIZX
	Ib4eMILfvZxrVOceSM8GcQPPbcQJ2W7sZ84qd9rGMXR482j/gT/3Jfqq+zM6jVKb0CJ62R9Vf0i
	ARD9jz4sMdMbyB/csqWzFhpIO31l8WrZKw4BONgHkaP0xiAmCfPo3Mc7TudUWDfLr8rTH1jEmUx
	E3CmGPPW1xO/NfseL/XOfTMCEWg1JJJVwC0P3ZGpGUK05kepG1tZwYxxTnBtaHiPs/9YGrMywkw
	3mL993sBg3+WxLkM6HXK08FRKarOHujp41r0eTe2lp2wQ8323tI68KiAMlEokcNnhglmDVryMYv
	8HKhczDNCH/Sx5D4YwggFsqXbr9+8SRbDVraQg/x1dPsjvpraQ+wdG5+XpPnk2Qfixq6hesIN8f
	RubdWTVNQJFx9vgJ8udqLtP+u3ZoN5NKZEj4QI
X-Received: by 2002:a05:6000:1a8a:b0:439:d755:a895 with SMTP id ffacd0b85a97d-439da86f787mr4105638f8f.42.1772807361864;
        Fri, 06 Mar 2026 06:29:21 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae36785sm4507302f8f.27.2026.03.06.06.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:29:21 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  liuhangbin@gmail.com,  matttbe@kernel.org
Subject: Re: [PATCH net-next 06/10] tools: ynl: add netdevsim wrapper
 library for YNL tests
In-Reply-To: <20260306020901.524105-7-kuba@kernel.org>
Date: Fri, 06 Mar 2026 12:23:26 +0000
Message-ID: <m2a4wli1tt.fsf@gmail.com>
References: <20260306020901.524105-1-kuba@kernel.org>
	<20260306020901.524105-7-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Some tests need netdevsim setup which is painful to do from C.
>
> Add ynl_nsim_lib.sh, a shared library providing nsim_setup and
> nsim_cleanup functions for tests that need a netdevsim device.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
