Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4C37FF46
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300506; cv=none; b=arMcdVOSW15zNQ3vkOmoyrUvKoXy0PO7xkYrYpDwKuZ4zWMwUN62UGRJX3nJ6yEHcJusfpMpY4KJKvtjplt1l2tSD1ViXPNQ0IvT2apBzPIlCd9UnIdYnrLFNiEgLKtx1IW6DGHLveBIVP8dDyrm9cxzPe0+hfckwvHlbdEtG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300506; c=relaxed/simple;
	bh=BLd0ZSi6AYEzF6Z1S6jhxHqmJ/tVEdxhmTaij18Onuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWCa6zpHVMy0iAqM+E1I05yfiARTt2E8xyA/3JZckud2PtBLESoHrGpkyD2U4PSAcq6WnFFkoc9z4nEK62VjfhLZqKWc9y+Q7ptfpR5k0CCtp+dnHjcUTbPrkM0bHKSmjHYu2TEM6fhlhgKuGDQ9aSqUsI2ndohrbyw2WDBGH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zge95CWJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zge95CWJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 457331A114B;
	Tue,  6 Oct 2026 15:28:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1708E60553;
	Tue,  6 Oct 2026 15:28:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A148B103303AB;
	Tue,  6 Oct 2026 17:28:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791300495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BLd0ZSi6AYEzF6Z1S6jhxHqmJ/tVEdxhmTaij18Onuw=;
	b=Zge95CWJorrmzM4yUowmuOkxRgpEyfxGYa2/sfKipV7dd+RjsKMy/oaGCJ/mVs5Pzo0eEF
	QAvqalpkxByxwJKXE5vyKH5kFSUwYu2xwYqM4H22Gg37EqMoVQPaCoVQg1pwSTO1lx6V/3
	Vlba435uh1H4ftEgJSuP+lH4zK400PqocG4hEyzBxYsnoXtQg5EHCs8c/6zB6t0Ce/IzsS
	zc24HAe/gkebKe8qWRsgGTXAIxZzqeo6jh5cRaaxVEC8RvbhI9cXK0HSSF2/J6ZyylYtTw
	sQGayXcUHQwmPGI2afJ4QcT9d7FjSH/TXieM2eordIciOwm0Sdwh2ldqsJ84dg==
Message-ID: <72e19e46-3a14-4a07-9b50-01e5480bf1a3@bootlin.com>
Date: Tue, 6 Oct 2026 17:28:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Drew Fustini <fustini@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
 <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
 <asQcQIh56MV1OJur@lore-desk>
 <CAEev2e8+fr1tJnSErD+2TtLDw5fGJbQOMcM5eefMnLyFUR+m7w@mail.gmail.com>
 <asSb3RNcityVg6ia@lore-desk>
 <CAEev2e8c6hZQQom6NV-URgdSoWiafCcRR3BtA6yxxqy7T-me8g@mail.gmail.com>
 <asUGoxyJWVcsYBWG@lore-desk>
 <CAEev2e_+Dcj60Rj2+_UD=3_kNQxLK4rmWTGK-dr-Ve9mGJBARg@mail.gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <CAEev2e_+Dcj60Rj2+_UD=3_kNQxLK4rmWTGK-dr-Ve9mGJBARg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/6/26 17:12, Anirudh Srinivasan wrote:

> Maybe someone more familiar with this board/has used PTP on it before
> can help out understanding why this is happening. Maybe this is some
> issue to do with clocks.

Good point, can you give us the full dmesg log of the board booting ?

Maxime

