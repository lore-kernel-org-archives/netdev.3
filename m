Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FCC3C3F67
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273581; cv=none; b=XxETUiDnZ//lvsKX+bvnj+m+eduAhT8wfvujUArrV26ZwdXtTj7y4dvihACdqQm1PnKN8Qs/LtYUcCgdjUNfHcveJOoozi/KTpdekMg57ksGkBNDxGEtBM7c29EdVkzdrePtsckx1JzgA94DGYwFm1UYZGtemSYk0mZkN+WLmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273581; c=relaxed/simple;
	bh=jKA2w0gKTi/Ivc3d8KgLwzjWwu6n5UjLW4cY/YMxtzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtF0uwBqQC3X0bPOKmtvGAiYA4xVua+iWOU0EmVWTFn5PtTJzI4g1mqB+xAFmgnZ9CYDYX5RJQuX5KFtMx5XWdeyQidh+PJhzzWBCk7+BVuMIaZU4jWusfBGgfnsl3LjDajff/Zf1da9zgTgmtMyloDI7qD3tAdDb8NzoIZ2PMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DaBqXNsq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DaBqXNsq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 218DD1A1154;
	Tue,  6 Oct 2026 07:59:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E50D260553;
	Tue,  6 Oct 2026 07:59:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AFC0103308A6;
	Tue,  6 Oct 2026 09:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791273576; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=9UADx5siGKeK5KCATSLSOTyedeT0k/fdcCEK1ZVtIuQ=;
	b=DaBqXNsqHxGDfFPoYUUv7E2wCtlmm4y/KS3i8vfonuSiH6cqiVL3+otxLy9VfNEpNh2pj5
	tL63Ornt/T7WteOWMPXk0iy5lBXfRqkXC3DAtR2Ana3t+EUP1dgRU4ygPo+aRAUum0NRto
	h/jXGFvvVyGPbfhxCIq3PX1jwRUZpuOg08E+Rd5s0SKLk0WfJD+9tfTJvf9VqK9EsoEAXg
	tDYjvV6lUEa86kWa3BtrqVIB9C1cS+j+wV4G+qnEeH2AIY5nrO7pATdGICiLMO2plcmRGP
	+NQFhhxKcf01ecK1yGS8CxKW80/++DTNsiwcOSTrxH3LdxZfCVqly4sQVAjvjg==
Message-ID: <d6e61c8b-cd3d-43fe-b4ac-19ff5d790b0f@bootlin.com>
Date: Tue, 6 Oct 2026 09:59:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] net: rss: Require indir table size or
 hash key size to support RSS
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, lorenzo.bianconi@oss.qualcomm.com, nb@tipi-net.de,
 jitendra.vegiraju@broadcom.com, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, pbrobinson@gmail.com, joe@dama.to
References: <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
 <179121059086.434549.5364767976780818051@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <179121059086.434549.5364767976780818051@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/5/26 16:29, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1



> [Severity: Medium]
> rss_get_data_alloc() is shared by RSS_GET, RSS_SET and RSS_CREATE. Does
> this drop flow-hash reporting for devices that have ->get_rxfh but report
> 0/0 sizes?

Yes it does, that's the intended behaviour here. RSS bits are all optional,
but does it make sense to report hashing params when the indirection table
is size 0 and key len is 0 ?

Maxime
