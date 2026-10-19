Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426025;
	b=DN7rG6o6cHevp6LzMtSX416coXcc6YCKrx/1aQ44DQ2itYFF7dVwZVkgd+wmG7xk4vqg
	 aauhJIguklY8y9o8hw8nNcE9Ap4GCGINwRBJv3fTC1J0IqgdEfN7UQHcE53eBxo18SN8C
	 s72OZ2sI0buOCxFSc6EPSF5CiD2btX2neAGcrHoxGHnPgp9mOj2XvzT5xOJUV0zhOgsNr
	 C0nYB5aiGntM8sbSTD7SnhMZpu2UqY0/cQHdEAe3ocpt6Bzi00loY8BiidsZ4l6RTkz+Y
	 T71dEGV0v0u/TApphkw7Y3m+i7rh9qmxUfKsFKBAcdOcIwda69DEY7i7HMMWuqAbo5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426025;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=+fXoYYPPFUQaaDuz0Qo24rHf8v9fPo1eCSV6ID68YwM=;
	b=MdHhvlsHnN0tAgsetTnbsh5r/2UNp3u3lL8Whkydt6YueXepiz3jmTCug695vuozhxn1
	 Gr4ZAxCN/wxCehQlvVfEKh7vwmsH9d7fwsrZTrE1HqOlQqLLskbwTt3divm5rGEbq8zlC
	 L2hUpywqKp4NtDAOa+e+gAowBP+tZgR8s+DKK5dC9lFf5xb7tWhMQOpyaPpp/sEZlAvsw
	 j5F3NjxxYwxFAbIiq6G1UW2r3g0aDr0xmEFYf7QjckRwWE9FpNG8vmUWavWqlfn7lySWr
	 43o+7WOFoMEl9Kzy734ADkt9Dq2LNa8aNTLgZcp6cBM4OIRseGpd+8pHIe5ZXi1YI2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=E35Clf5O;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=oHrWc2br;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8A606AF81
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6A8A606AF81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=E35Clf5O;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=oHrWc2br
Date: Mon, 19 Oct 2026 18:07:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792426022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fXoYYPPFUQaaDuz0Qo24rHf8v9fPo1eCSV6ID68YwM=;
	b=E35Clf5OuxQQ5Hfr+dzaIZM+K5y4KKSDBqXueWdMtjxfAlqVH6dIhsoQSktUIrKuAZp/Wn
	nh5VfTe/hdTXTFcw5N6sSoM+IbYyv5nxZ+X5tDaSzRXtvPKdRBFZ1rRi3nwCFT2QWV0sEl
	QTB1cSp4m1M4R4uyIOz6K0gbTzyBF/ElpyWRvaKfmcb0xw4OiquWblfa+1Egw4GnYvl/yq
	sigChdGuEbnJoJ0r9f3lkN+XdSEsFB4/8tlA0rFPzJ8nY7rqHnIr+jDB5h8p/xIgkNXcvd
	t2hjhGoz6LmY/llaaF57L6omcGGJol+RkqaaJwYWlIp+TvcKENcThWRO0MxC3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792426022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fXoYYPPFUQaaDuz0Qo24rHf8v9fPo1eCSV6ID68YwM=;
	b=oHrWc2brkez9CLGegv5DRdsvOnIDOrXlq1Vu7TqFzzRFFLeX0fGYG7GEncubQVcnbPRxhq
	jxhvSy/KWB3b7UDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
	c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com,
	davem@davemloft.net, fmaurer@redhat.com, kuba@kernel.org,
	neelima@ti.com, pabeni@redhat.com, praneeth@ti.com,
	pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
	vigneshr@ti.com, willemdebruijn.kernel@gmail.com,
	daniel.machon@microchip.com, edumazet@kernel.org
Subject: Re: [PATCH net-next v9 2/8] hsr: Use skb_clone() while adding the
 HSR header
Message-ID: <20261019160700.oa7zrh8K@linutronix.de>
References: <20261014-hsr_ptp-v9-2-2d20a2a0f816@linutronix.de>
 <179233869819.3135.906589936438355086@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179233869819.3135.906589936438355086@kernel.org>

On 2026-10-18 15:51:38 [+0000], netdev-bot+sashiko@kernel.org wrote:
> 
> [Severity: Medium]
> Should the skb_cow_head() call above also reserve room for the skb
> metadata? It currently reserves only HSR_HLEN.

yes, it does.

Sebastian
