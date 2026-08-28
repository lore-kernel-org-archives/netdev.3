Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97502192FA
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787949388; cv=none; b=YaSe+p493LZwarYjIY6MT6g/vQ0F8OZB4fIH2vi1FsBFCSF/8YEs2c6b+gbzGTglPwsB5gjSxxC5+iCkcaW5KRvH8Mx3wPWRQ1pdqU+1h+P+tSw2CTcbXgPy91xwY+QNgi1Wp7YB9vL4tVvDoaObZlgMja/1PxNtxhJsY217/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787949388; c=relaxed/simple;
	bh=qxnErit/6r4KPY362kHRjVcCBndDRDhfVu6Gk75x3UQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YOTepvE8MRF5Tj1hf55AB16iaE4T5VrZAjay6tS93U8BiHfb5d1cbZyOTIIDloV1h6VPhzS96fsccNHG3W/05+aqVWEZsRgonELmjwQGGg0hHNxuTeZsrqWaD/uz5ijQyKuIm5zvo3QaMrO0ILCDlBL49saM03MlP31NAH5IUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=SBUANxDJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J0JH8avK; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="SBUANxDJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J0JH8avK"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DF187A0070;
	Fri, 28 Aug 2026 16:36:23 -0400 (EDT)
Received: from ams-imap-19 ([10.64.2.39])
  by ams-compute-01.internal (MEProxy); Fri, 28 Aug 2026 16:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787949382;
	 x=1788035782; bh=grr5hkgau72H/fPgCw/qRoIvfcHsGK4U9MKvISLfesk=; b=
	SBUANxDJIuOo52Eulpw64uFNANq24v0i29vlvH0nxcvsEonsOy970CpwoRsrOyOQ
	krCbENbGAF2EIOtl/JQS379Xe1w92rZRvJulLzo9iW53mggWObhVgbLa6S2zeGyn
	DEvbjd0Z1cd6fbiX5L+ZmlS3wVRI9YsauX3YlkzXT9qVcGJbj3XY1xa/5z0s8pzw
	Jutp4FjMvXYSPp7i4ju8EKMAYLw+xSMFh5jiky1blq2vzc60gK/JTB81lVGO7zmH
	HM1PkuPSAo4r+45IviVhvJMXe42Z42pgmGABmu44zPvhtoyxBX0+2FHIAXwM/AXX
	pFbSXmGTcHroguwc95oK4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787949382; x=
	1788035782; bh=grr5hkgau72H/fPgCw/qRoIvfcHsGK4U9MKvISLfesk=; b=J
	0JH8avKYmpfbwJA+i1s87Oh69/l0YUgVTDZ929TJqkkYmB/rM67aCvl8eXBp2YLR
	1P/luNkJ4bevsOl7T6iyJ7rpl3VMqNBAH/6ETrv5PnzQQHGT7f3g0ZkcWArWKkeL
	G+la1fM7IPVbxoaOqq9gY100KQnyq3nMUKzmDBfhr2fjqfI1YYRqvT8qfFT6NdpD
	ktvQh5aoMzv1YmGkU/KSHIO38K7hliENAFtMVyjTDyCJEjSks1zVqVk4hEGhoyzK
	Yrfd6DEDIwuX+hHdEXu2y2lZtIpI0rPN+E75+E589QGqkmpDlpZeQobmewQhTb2A
	VKAHX7RnIKTZDHAMSrdrA==
X-ME-Sender: <xms:P_GRaudotP-yMYQvhLB8jmMixjdkuZKsEuJZEXzznqpS18Ug69MTDw>
    <xme:P_GRajAIk9iZtygRAUSRRNcHTJpDvNC1cGqbO1NRKTnKXOt_Ija-Z5UvEopkXwVPV
    Aus7AiD-Z1J1xM_dBxdw_t-SN4rkN1A570b-GZh5oiVymZ5fnPr9-4>
X-ME-Proxy-Cause: dmFkZTFEjP/baf7GdtFILBnf3EkFJw/YT6c8W6ZxFKBT4NC9/bxirVJcW6+mE0X7XuUOMc
    U5z7brCw+TY7m43icCk5v3db1RXPKL4BRShYHAUEuj9RsBeLFUnW+hoRwdphbH2d4Ho9rA
    /G+7Mg9BtIXteQ5FRCNPmuqTjk6dS1Cvck9IWXTLQ2cWsh6piUKniKcufmjKgO0M54OOSZ
    WhV9RBdITfx5g9WVSTF5Y8woNAP9K6pBdyXWNF3GkZCJ8sF53H0Vd5TGidjqiGpWbIxmTu
    f1dEgpWU/AHemmEYI9iL/MPFezxnJRkBqxUsuAQau6LN5DTI1UvyErQDRWXl15Iiq8bqSZ
    Q/LBIJ+1+EoiY2zwBmQYacIHJ4zOuKFE6AN6DEM8uiWSetLIOIFWxPvA82a/90V/Y/Xwni
    DQSVbHJnFqxp9XoYWDd6KefAjVzh7AG8eNmsafNWKX2EQpV/Kj8Ssk+UDLvWewnDqWliVw
    OqZOjkUV+yD84apWUnwYPRgM/SZmmhO3VN7aWfHO0+MgqHUt2HBa+pAEq6i+Jxox/zyuXX
    57R2DjGZfbHFXgvhA4ql0yjD3RYTdyZ4Ayi+zMMmFpickMndIg5yl5CZ/D3kAHFm0aD+Jm
    BIEDvoxCzypiVqjlomxIZrQ7K5uVM7pKTRtXT0rUTPPawEqQB5/alMVFm60A
X-ME-Proxy: <xmx:QfGRalPSAoHpzHElncPrtSsLb89NLFQ8QPt5eAzkaO1c9ghaB-wkaA>
    <xmx:QfGRaue-G7vdPBdM1SDztqgPX6EOT2GkazFPyiGXqH6LgUNaWDQSUg>
    <xmx:QfGRaiTdMYD5S5efSksP4TJvHWhqvGDw9Xh_D3RgdTHgjfy5CNWpZg>
    <xmx:QfGRakfMw4RBsTpoJFzc39rBt6kHAXOtt2SBWjXQDLvbUiAYMKyrlw>
    <xmx:RvGRaj4yDz3teXFyzLCMQ1kKlShmGRiYbMI7Nd6PHNL0jQTkoH6LYKUw>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 249912F81645; Fri, 28 Aug 2026 16:36:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQCaIXmGAEe7
Date: Fri, 28 Aug 2026 23:35:54 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Jakub Kicinski" <kuba@kernel.org>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>
Cc: "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Simon Horman" <horms@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>,
 "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
 "Vadim Fedorenko" <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>
Message-Id: <e01d7fc0-cc3f-4a52-a587-f9087f1c787d@app.fastmail.com>
In-Reply-To: <20260827122856.4b6eeb96@kernel.org>
References: <20260825200215.90326-1-alice.kernel@fastmail.im>
 <20260825200215.90326-4-alice.kernel@fastmail.im>
 <willemdebruijn.kernel.3645a45d69737@gmail.com>
 <20260827122856.4b6eeb96@kernel.org>
Subject: Re: [PATCH net v4 3/4] selftests: net: Test UDP length overflow with PMTU
 discover and big MTU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 27, 2026, at 22:28, Jakub Kicinski wrote:
> On Wed, 26 Aug 2026 13:18:18 -0400 Willem de Bruijn wrote:
>> > +def check_dmesg_clean(func: str) -> bool:
>> > +    with subprocess.Popen(['dmesg'], stdout=subprocess.PIPE) as dmesg:
>> > +        res = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout, check=False)
>> > +    return res.returncode != 0 and dmesg.returncode == 0
>> > +
>> > +
>> > +@contextmanager  
>> 
>> Interesting approach. In ksft the built-in defer() mechanism may be
>> preferred. Not sure.
>
> +1 small preference towards defer() if Alice is willing.
> It's be more idiomatic for our selftests

No problem, I can switch to defer, thanks for the suggestion.

> More importantly ruff check and pylink --disable=R have to be clean
> for new tests. The test cases need a docstring explaining what they are
> trying to test. The helpers can probably get a _ prefix to mark them
> as private and silence the warning.

Got it, will do. I thought it was OK, because all tests I saw didn't
have docstrings.

> -- 
> pw-bot: cr
