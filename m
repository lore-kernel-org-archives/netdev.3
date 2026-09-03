Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A0400962
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429802; cv=none; b=YABS7CjOGs67mN7gxnwNvtJsewM6kDG3an8aZrHmt3D1qqi6P1f7YZ0+/lYSVSvtqu/L/C8Tf0O3kumSi4Pk/vIBOJ0v7DOyumsnW6qfoADH2soNtRfM4ns9I97ueh4RAIh61WGUf88XKke4NKAE/RXZCwTFxPFjiGqBR25YlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429802; c=relaxed/simple;
	bh=mXvzaTzqMqFmqIfIE+ID/4lSzXdcbNgs5wDNDwkuixc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQvjDOUheAytxayG1g+jxc3K6KEuZVzSQqESNIqZuiJfcoHtvCbqt3L8UBP//XiGTM6oEWLhLDntL3ilfLlO/kLAKGeU5JS30VsxKuXIB9Otxb4Khz6Tzz56liYn1SOJmy3qeGjldvnE/NN0O7SY8kso10XrJa/xWWRNrThVNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x4AXSsvZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x4AXSsvZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5BBDC1A1977;
	Thu,  3 Sep 2026 10:03:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D78F602B8;
	Thu,  3 Sep 2026 10:03:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48A6011C792CB;
	Thu,  3 Sep 2026 12:03:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788429790; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=54Vyq7TkdJY+5dYhg6T/6D6Toheh277V8fD+wL38QnM=;
	b=x4AXSsvZ1D+R4c+aolY13sCLKa6WA/pwdy1pAL5Sy9PLHUH+gUdEKst4zJ/Wy8lw7zzGm2
	Z8aOQEQB4uX33I1lcn6VUBB3/ABL2kylBoUmdYeUOe1CzZwZXfSxGlMKpvizWwdRn8WltI
	ZCLPzJG/Yt03UoZ/wb4DiDCKoe+lRDqs2Z3/30O8pxTfd7C6WezbkA+CowfdRQ5PNeV7fN
	uwxWofKipwi1IwzQLE2wfTl3kgd0XG0nfua/9n9MYenTeuBZ7odHXDQGBEcmntrXnj4DvA
	4X4ESajCdmQZkz56KuPRzShP7NfepAh7qsIdzAJ3S/R///7BnriFaQeMIwCY6Q==
Message-ID: <f24fd4ca-dc49-4008-a482-db6f30e46131@bootlin.com>
Date: Thu, 3 Sep 2026 12:03:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: dwxgmac2: add XGMAC
 timestamp interrupt support
To: Zxyan Zhu <zxyan0222@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260902131441.322167-1-zxyan0222@gmail.com>
 <20260902131441.322167-2-zxyan0222@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260902131441.322167-2-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/2/26 15:14, Zxyan Zhu wrote:
> DWXGMAC2 uses XGMAC_TIMESTAMP_STATUS at offset 0xd20, while the
> generic stmmac PTP handler reads the dwmac4 offset GMAC_TIMESTAMP_STATUS
> (0xb20).  Before this change, the DWXGMAC2 and DWXLGMAC2 hwif entries
> used &stmmac_ptp, whose timestamp_interrupt callback read the wrong
> register and whose config_hw_tstamping callback never enabled the
> XGMAC timestamp interrupt (XGMAC_TSIE was not in XGMAC_INT_DEFAULT_EN).
> As a result, auxiliary snapshot events were never reported on XGMAC
> platforms.
> 
> Add a dedicated DWXGMAC2 timestamp interrupt handler that:
> - reads XGMAC_TIMESTAMP_STATUS before checking
>   STMMAC_FLAG_EXT_SNAPSHOT_EN, so that the timestamp interrupt status is
>   cleared even when auxiliary snapshots are disabled
> - derives the pending auxiliary snapshot count from the persistent
>   ATSNS field instead of the transient AUXTSTRIG status bit
> - generates the corresponding PTP_CLOCK_EXTTS events
> 
> Also enable XGMAC_TSIE in XGMAC_INT_DEFAULT_EN and hook the new
> handler into the DWXGMAC2 and DWXLGMAC2 hwif entries.
> 
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

