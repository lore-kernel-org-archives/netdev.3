Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2FB2F1FD7
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138751; cv=none; b=VRD+GqfzrUIyDENi4hkbABH1vpIPXzopf8dasrxStcXI6gekVzcangYsumaELhDEEOy1cAsUfGCGno4EmSsV2sez2hXFmP3eCLqm1pZcHPdAm2r0Ett61mqEDYeMUKrDOtRrSqB6B1jU+dsn6faenc4Ni6VrHum5B4r0yXB8BuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138751; c=relaxed/simple;
	bh=V+FExOiJTWTRtAQ59Hr44MgOBDt1mmiCqgWNRJkZrVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVXp4DL4zpeXmohkQ1Du7b9nqjLVec1n1eihx9mIkrDSpx9ihbfZxl/0BOvcq9tJQ6h4E+cmdnSu/F1iZiIm1F5E6VyVws6jR8uWPckafYoVkp7z88ot8hGwvO1tnGl5MM62aqjNsWDQEZVMmN32Hg1hTc4hzaPC1mSMCjEB0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1qjwoRJu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1qjwoRJu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 806524E40F92;
	Mon, 27 Jul 2026 07:52:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 538D9601BE;
	Mon, 27 Jul 2026 07:52:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08CDE11C121C4;
	Mon, 27 Jul 2026 09:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785138741; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Gb9ehwG+RAuxSlfdGMmX+ZVKPgs2t30UZ5xibFOL5b0=;
	b=1qjwoRJuQyvizIXms8dWnEjdEXwrThAny7ZpUD2xPGmKyIMDZPiEniIYQLcxdOxvx+RDOp
	sJLAG8J3NBzViciaiI7nu6iFyY0GH34gMzY640+UDCfmVyCAsGxgM9/8qhOIwI2yYB7jmD
	lUKub1R1DeRbVBdHivhxKichQRgwyiarD3/9ghAApa8s5iwCYlRCs8byaBVSkMEzmHA03W
	aamE+2qlLe9bzbtfaLrJGG1d3EB0VjiZUAwxtEx09xU4pQiauwKbz77gOLL15VnplF0KVv
	BguxuQYPiWSCgJf4Yxq9UMFqtw/0SnaejeEx5VDZkjhug5ozcB9pxKiYw7Sdug==
Message-ID: <1af74c3b-f717-482c-9715-7f91f14d86aa@bootlin.com>
Date: Mon, 27 Jul 2026 09:52:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Fix E2E delay mechanism
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: rohan.g.thomas@altera.com, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 richardcochran@gmail.com
References: <20260727022524.7521-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260727022524.7521-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 7/27/26 04:25, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> For E2E delay mechanism, "received DELAY_REQ without timestamp" error
> messages show up for dwmac v3.70+ and dwxgmac IPs.
> 
> This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
> Agilex5 (dwxgmac). According to the databook, to enable timestamping
> for all events, the SNAPTYPSEL bits in the MAC_Timestamp_Control
> register must be set to 2'b01, and the TSEVNTENA bit must be cleared
> to 0'b0.
> 
> Commit 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism") already
> addresses this problem for all dwmacs above version v4.10. However,
> same holds true for v3.70 and above, as well as for dwxgmac. Updates
> the check accordingly.
> 
> Fixes: 14f347334bf2 ("net: stmmac: Correctly take timestamp for PTPv2")
> Fixes: f2fb6b6275eb ("net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a")
> Fixes: 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism")
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Given the original discussions that took place, it seems that this is
the correct fix. As Russell suggest, we need some timestamping selftest
to make it easy to find regressions with this kind of patches, but
I've experimented with stmmac selftests over the weekend and they are
in a sorry state right now...

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


