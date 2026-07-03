Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C435E1A9;
	Fri,  3 Jul 2026 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064624; cv=none; b=bV4t6hhQ9+VMda/Y7q4AsMPIDdW0LaTxaBTmmG/zwmKh6g+v/OjKXx43IVdhbYbfr5o6mz3C1GFoBX9rfUE3ctImPBsZ1LPv/Z6YSczQ1gyTfNXWgngKYVrWGe091PunT2fcVFygu1gq2Y2pJYC36DydYRj8YWPmHM//T1j314s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064624; c=relaxed/simple;
	bh=mUfKOi4JmjBHr5VnLHW65bL7FNvUWm4YgWgzIORT7Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ouz+Jyv8wxQmIXtsffOovmfB/mweOCfz6ew/ImEkQiYvevgXPAoZjtzB3QGyi0YWkqJxI5IroCrTZlze2g9x5Rcjf8Uk6sJDguXTEsuzK65vZ+ad7XmBdEVaGRNUMyq2nUp+MgPtFpuYcLC/h6w9YTGXzrQ12qxscUznfXvmDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uGK7QXbP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uGK7QXbP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 52E234E40C55;
	Fri,  3 Jul 2026 07:43:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0F07E60300;
	Fri,  3 Jul 2026 07:43:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E421104C8399;
	Fri,  3 Jul 2026 09:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783064619; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zh6hDSaslt6aJtqlh66ET+WJ4WCWvxHGWRFktdTvwG0=;
	b=uGK7QXbPWOuZyHin44CISldvZy7LeqB96tmtqZMt6R628E90R5d57JOtkCE6QLYHGT0ZQI
	qIRQvE5jgImv3TM1VX+F9pElC1zemAou1WnC4HpcGadYhYWapjhdV/VcTkSheMxaZMxPPS
	0GmBqsGt/n3H9eBS7Hz+LcHKx6IgA7naiwh7dsJx1m+T9WABoOcCTq1TyVhUERQYul82gD
	48oek4CqochsxCLoGp65tkqQkmykGX91zHqDV31XvFgWjWoDh3NfVceiereT+vqZfrfzH8
	/LntO2LLLHqtCcJMYiXSoyzE0hfrp1k9/0d/e5LcphKB2wQtMrnbGFXWt5K6yQ==
Message-ID: <1cc04cc2-b3dc-4356-abf5-25645c38de9a@bootlin.com>
Date: Fri, 3 Jul 2026 09:43:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/4] net: phy: c45: add
 genphy_c45_pma_soft_reset()
To: javen <javen_xu@realsil.com.cn>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, freddy_gu@realsil.com.cn, nb@tipi-net.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, vladimir.oltean@nxp.com
References: <20260703071330.1707-1-javen_xu@realsil.com.cn>
 <20260703071330.1707-2-javen_xu@realsil.com.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260703071330.1707-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Javen,

On 7/3/26 09:13, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic Clause 45 software reset helper. The helper sets the reset
> bit in the PMA/PMD control register and waits until the bit is cleared by
> hardware.
> 
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime
