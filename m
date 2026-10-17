Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C038A736;
	Sat, 17 Oct 2026 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792218401; cv=none; b=cLC1iiwmnsuXHXk6XqZNsE8fZC7WQIy3WVWJXvtZECEyV3wkRFqr97QFB5X/BMl/gJhXdDz04J5Cbnl57ncbUIJmDjBGpnOGYj1CvQdgz7zlF5jo4nKwx2szBk5YMQ+zKJM9LZypy3wqU5sGKd4qkC4KD+xSL0/BXZvY/GKne6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792218401; c=relaxed/simple;
	bh=3tC/kwj1+jForMsV997xcx23+SpH0TnehlSFeBpyMqY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eZeZoIYzzTwASoLNrUqPYn5TG1dBC+ElexjiueqrdWN7vzvye6uoOyy100nnKNB8lzsWv10NJ3h8qhVPtSNIDrikYTZZNC5RluQUwwQ0ELfLwjyxKxCykLQq5AvgzKGtiPFMyzAhJK5VxKXFUNpPTnXpyQiWOnuBEp/DdBfKPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=xrz/D6rP; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="xrz/D6rP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6542FA1559;
	Sat, 17 Oct 2026 08:26:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792218397; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BQ9FXDq4m62P+Va6Th8Mp8RVPxQeOXHkr4s1H69I9rs=;
	b=xrz/D6rPp+RxIIOp3clQM0Mr5Yao0B/npy+a9v0lw41Wxmea2DeEAFsttNF/DbhuEW4nZn
	e4YjVW5ZHy1BvqiCSnSNAFfclEQAWIMbNHaIKERKEhNkn2VUC9lyh4oVh2okokVUZi35vi
	/8pkeXJuRvtWIBfXEZkLEgunEFflVO2uAw5JcEcvKSK/w2H40hLinLLZ/ReFCbHcNjlmuP
	rBsle46Pg52BYbd07yWWAIwv9AR1W89F6HK/dXJMhtLZuF62mX2ne6DtZ0UH2nQX4+R3xL
	ktzSZnHezq2BW8qi50CmMZSACPPqRnhE/WzNjNhiI3uRbS0G+dyXr/bAkkVv1w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 08:26:34 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v5 7/8] net: bcmgenet: allow the MTU to be
 changed
In-Reply-To: <20261016182415.73f4f7e4@kernel.org>
References: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
 <20261013-nb-genet-mtu-nn-v2-v5-7-076b6fc240be@tipi-net.de>
 <20261016182415.73f4f7e4@kernel.org>
Message-ID: <2304cd9afabc6f9e62d588b45b94015a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 17.10.2026 03:24, Jakub Kicinski wrote:
> On Tue, 13 Oct 2026 16:20:36 +0200 Nicolai Buchwitz wrote:
>> +	ret = bcmgenet_init_dma(priv, true);
>> +	if (ret) {
>> +		/* Retry the size that was allocated a moment ago */
>> +		WRITE_ONCE(dev->mtu, old_mtu);
>> +		priv->rx_buf_len = bcmgenet_rx_buf_len(old_mtu);
>> +		bcmgenet_set_mtu_regs(priv, old_mtu);
>> +		if (bcmgenet_init_dma(priv, true)) {
> 
> This will fail under memory pressure leaving the device inoperable.

Aye, I'll allocate the new rings before freeing the old ones, then a
failed MTU change just returns -ENOMEM and the rollback can go.

> 
>> +	priv->datapath_up = true;
> 
> Hallmark of a bad design

Agreed, and redundant anyway once fini_dma() NULLs rx_cbs/tx_cbs. I have
a net series for that, on which I will rebuild this patch.

Thanks,
Nicolai
