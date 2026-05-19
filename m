Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC532E72F
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191188; cv=none; b=mPOPgRtzPt0vDPB26t62GYl6I/Z1boc7xuHZ++P4osKLamoMIcghWyOU91yLmCPfO0IvdhmFWaAiWYtOGAQs2caG2oP4lWFo8i/casPcCZQWVE8JhY/sS9+3uUAp/1S6qPUpz5NfVlprI4l2zscFGso3VvL9dT3MZFN6eN0N0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191188; c=relaxed/simple;
	bh=hDncoP6wUhrOO7HNw6wBMZMEIPeuvOboSQoIXCb8/Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhyrR4WnwktQe08f5y3+GFt3S605SfOUzTlFbz0vr7ir2hScD+IVyoHoQeN/9193GTyuPFAfVN86eDn/oJhW5YRc8gSOFOqvyghc882NG4cXADS8n9yGW0KIjMegpJ1G9tQGUfkwCTkY5cXIYELF1Bl4ut8qDTMZPCzmcoWfUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyaIlGIj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyaIlGIj"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44509921fbcso2097310f8f.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191185; x=1779795985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PEw0M2zsj3EzjVifOGhWM0yGOgGSRULUyqR8ZQQHmn0=;
        b=fyaIlGIjcJTMQtNNbQX0Q4mberRuQh1PLGwE55LJ/YDnGWV3bDQ5VqU83WuKLQoWiW
         ytpcWE7G/EPE6JtzUaoZiSOWsqf0t+o6VdHjkkb3RaC76MvOnmhNLIwLiWC2OEAJO1M5
         Juc/VaV8V+5/QbV5zIK91RlAinU2nvnb5Dbf9D/wAEcrc3KP+EXz5pLxXY3I3WTB/VN/
         c1UmUiqRzUORy3mLAMxGmwJGTwq5eKqolQ15P/p186S2/NZFba3EF5FAu5rPNsOyOjz+
         bUO3msc0iykvWUXTO25tAS8RAyQazbj2PJH4gTU/KC9aNat7qHIjnDhjixhF0YZCRGS3
         GHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191185; x=1779795985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEw0M2zsj3EzjVifOGhWM0yGOgGSRULUyqR8ZQQHmn0=;
        b=U0wJFa16w/mUK5VV/BHTuXjm3sQTZeBERkjviM5NfwAp4QqXruQdyIWzCy/rmq+Q96
         pgg04aV3MihSoax/leX7g8CzOIsag5nLoMqZLdlPS5ED2O1dj/NhPh6tU+lorRlOANaw
         NUUOPIy24pg4oofKB5d4+iE/tWesb2VA+meeZG5s5BxdR9buogpb+ysMzz/4jwLqh2s/
         CzkGedoOvWeZjm2AmUmYnVP1DuaIFMU9QXmruytXqXkziRr0tXPr47hFkG3ZWQC3IDB0
         EYxw0acaYrsvB9gRh2lxNR3VurxO97j/QKuXh1J02gLB9l1210slobNkGGPJcN/VjP7m
         KxEA==
X-Gm-Message-State: AOJu0YwrsHPgg9IcBWoIcpgzPTT9Va5sbVoQ7vH7b+pRX/AK0UNK33dX
	s+8ZNQ1Y/jN1EeFQDX/qVm/zgCASQUaKImQCMMLKqT4ASB4wD4vLR53yEqMCcw==
X-Gm-Gg: Acq92OGgWCi0q1Kvns/EZm/7nIWAF23XtnDPaHREtY6rfO1GBsSUe1UxiERSBG5bOwM
	JEtt6IdNT5ZU2OUYBJRPuU2vaxuvJVXMxsqUGJaNOnO0FQvAuG1ghPqI9NXljE47ggyRZxd47YL
	+DEzvayjtizTCwQYmbCIJl9Z21hK4ZaK0GDPVRy17VS4xs9/Yox4VPT7TJ/aVNBTa6Hl9KU5HCA
	4Lp2YVcQhFpBtk7FU8DGlUy96+i01AARAHhy5YbqG9+UloKM79M+uKSImmhjSL4ixFslhZnoSjx
	06WbPEwQdMnsNKPg5ZPiyJDRnTaxw+XGu3u0MxySUljfuLGB9rEFHLnZZ8e5kY8GdIONLw9ya+c
	YJiNa9BSXUhp1zfd59k4FSis1xE+HjhclOhpm2yn9csiJMQQuT/jwHwYpQb+tdU0W8b13daKBjv
	0BhC46vtwEQan5qPWV84d5GJxtiMtkIPjmHrwyhCOJYMYhzzHHH1cz64XXFGbRP8dJLd1sCdQ9A
	JEAVGU70BOCSD9MKbRew2h2ODbQn8mTDrfNl//3cToUSDCWEU/f/HJWKQpaaDOT+iW+9N/6+99H
	nORfs/CHvP6O
X-Received: by 2002:a05:6000:4383:b0:454:1e65:32f0 with SMTP id ffacd0b85a97d-45e5c59fee0mr30666607f8f.10.1779191185357;
        Tue, 19 May 2026 04:46:25 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm47570648f8f.18.2026.05.19.04.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 04:46:24 -0700 (PDT)
Message-ID: <f4dd9cbb-c0fc-4170-9dc6-014cfc267f44@gmail.com>
Date: Tue, 19 May 2026 12:46:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] io_uring/zcrx: add ctx pointer to zcrx
To: io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <cover.1779189667.git.asml.silence@gmail.com>
 <b60514b3d1bd92f571e3bd91751166f8c3599256.1779189667.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <b60514b3d1bd92f571e3bd91751166f8c3599256.1779189667.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 12:44, Pavel Begunkov wrote:
> zcrx will need to have a pointer to an owning ctx to communicate
> different events. Reference the ctx while it's attached to zcrx, and
> rely on zcrx termination to drop the ctx to avoid circular ref deps.
> 
> Co-developed-by: Vishwanath Seshagiri <vishs@meta.com>

Vish, can I have your sob for this and the next patches?


> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

