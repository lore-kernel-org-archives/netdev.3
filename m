Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7532B100;
	Tue, 14 Jul 2026 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020260; cv=none; b=t6++lxRu9XlJP+FDBEr1sl2ZVIkjDLh2ZgzeFe0nunNOhjPflEeltHi/lKn+QXICuDPmeZS6gqzFPT7ILp6V7O1pIDpJT38BppStOVAJEskUwS+RTATIql424gSM+DXVI7MM61+RjrkALrFJkdYkfjv1zsH/BibcvqZJb/UgU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020260; c=relaxed/simple;
	bh=AcsmezHc8N1PpSEL+8yo1+RMpxLrDvsTJU7KAKATats=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxXHp5l5H1o62Q+sK8pKnF2Y4IoAqTvp45bccpUVV8JNNpfSqlCLvXppm9eUijttBbbdcwev9gVxj1JrqpQ+NTHe4VE8j9zg6TcvgyHDnHSdaDUOGcW+G9IY7JAp9fzAjKyIRIlQv1DVb7WXgRGCif/o3lIORt+f3aINFy4CsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZHW52ikU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZHW52ikU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C6DDE1A0FC7;
	Tue, 14 Jul 2026 09:10:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A7C060346;
	Tue, 14 Jul 2026 09:10:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EEF711BD3B3C;
	Tue, 14 Jul 2026 11:10:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784020255; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0V6kPtc4rRQElr+GpOQzaTc5pSVi++9lNAM8Sd86l2w=;
	b=ZHW52ikUD5MJ8UOUUhApwjq0KGsy1BcRZFrqnDePB1Z+7qsnaUFyeI/INmgLXVMz8EiN9C
	jwCi5cnjH+V+FZXAVivQl7QpQHL5to4MhfiQ1/Depr2Ss6VO7RATWFIkCHDtJBpF6sgvPj
	k0BXunu6D0i9ye9/mhSdFaFn/61FY7T7YmZiJBBAr66quRiz4N6kZIJWQqrRvi5eVKMadv
	xSKJGHhDCAWeSEmK/VvIOkqJVZTfGz52Qo5zJM2NA8qzACZN87/ppUkbsO7pHinSmzS47y
	1QMBFNalaga8/vRFiTAL6tjVQOLwNZIvm7vsTkv9EuCmOGgqFWK4UwNOOvEudA==
Message-ID: <9a4d966c-38a0-4d61-99c8-df0e3d137592@bootlin.com>
Date: Tue, 14 Jul 2026 11:10:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] net: stmmac: reset residual action in L3L4
 filters on delete
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260714023716.29865-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260714023716.29865-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/14/26 04:37, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> When deleting an L3/L4 flower filter entry, the action field is not
> reset. If a filter was previously configured with a drop action, that
> action may persist and affect subsequent filter configurations
> unintentionally.
> 
> Clear the action field when the filter entry is deleted.
> 
> Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


