Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273417C203
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042173; cv=none; b=tbzpqcO61rm/dzyae1vJDjHif+PyAufV2VHwArIhENQtdJXEPGt2fDXc8k66GQz9Z2YGjva2u00hPbFhW0XIMp0b4XTq00vv74e5tGAJgD6VcMHaP4Dpo3XsEDLp6JJ/Klga3byiTHlDcn1Ft5+xZ0JTIZKYHr3kME/AvCUS//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042173; c=relaxed/simple;
	bh=T6FVsSqBb/G+/WihgvUHbT4c+3rlTjbQNT00GZLQ+EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKiU17loI/+z0YY/ig23n1K+jjG/R3ucXyNubQjf+YJnQjO4mQWcyqBYpPR3Bg+DTLGSKIMX+anbMUixdBPzXMmAU7VD1HSgxKTvcrEbeAaNI7NCD7EGvJJUE7C9/IVv249SaduNFqJyKnsG7ocRpEEAfayRDT4ScwX2LRn4ojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DDgjgpqy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DDgjgpqy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 253204E41134;
	Sat,  3 Oct 2026 15:42:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9F80604FF;
	Sat,  3 Oct 2026 15:42:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 229461032827F;
	Sat,  3 Oct 2026 17:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791042160; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KZyZDLnfwvO5kk2IUmjVxda6yTo4+rC+T/RbkzEatd0=;
	b=DDgjgpqyyVsAVzp23/SzSFOH8X0fG8JmMnd5s1lBmutM+/7B1C/A2n55Hb7Geb4mo1XCxq
	guOW1s0Q/AAeEJ0Vj1T2pzPBbzUIjSudnyJ1/Me+nr6zHQQD8QpsetCImQRsEwHkl8DKks
	su1EDRuvWdzQ/JjGGvx3srUsZ0OIrYspT7Jo4y/APJNohhSPgRDLgMTzC28dcslznvd4nC
	zCufdMUGo7/io0D0nmnDoyY1MyTtu2jhUG94u0/DAl1F65YqIdos0wMFY3lDqqRGfpkRFt
	sB70zarHOyPnGN9bYw5v2UEIpKvf1s1yTBoSJM74vI81MQMSmUb8CngGrzeCig==
Message-ID: <54177bb2-9fd4-4639-959a-2126f4ab4b04@bootlin.com>
Date: Sat, 3 Oct 2026 17:42:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 3/5] net: stmmac: Rename double VLAN references to
 svlan
To: netdev-bot+sashiko@kernel.org, ovidiu.panait.rb@renesas.com
Cc: recv.jo@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, jun.ann.lai@intel.com, yi.fang.gan@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260928203441.34876-4-ovidiu.panait.rb@renesas.com>
 <179093026338.434549.16397575185437884627@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <179093026338.434549.16397575185437884627@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/2/26 10:37, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The self-test renamed to "SVLAN Filtering (perf)"
>   (stmmac_test_svlanfilt_perfect), and likewise…

[...]

> 
> This patch renames the test but keeps it in this state, and the
> remaining patches in the series do not touch the selftests. Should
> these two "(perf)" tests be reworked or dropped?

FWIW I'm ok with dropping the test. It's still in the history, and
if anyone is interested in bringing the VLAN perfect filter one day,
they can bring the tests back too.

Maxime

