Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0D4A8A17
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858698; cv=none; b=JlYl0jBf589hkMxLd+urUSrFQpA8Nc1teQlCQCYrgGKDPxAR6GTX+FCxR+D+4PRDrqv8FITtf6gokyMKTFR0BPcd+1GCyxMFn4Rum15HmlxCnfH2BQZw/0LiunX3tMq8BXF/5EKaCoYwfgRsXlJPUBfHjTIl5b2So5vGUJn3LZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858698; c=relaxed/simple;
	bh=/ZyZ7g3c8QNW8v4IgX6ZlE3a0TN55N3ZA3FiDz+oVX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYsgXlmNY1TVuCU6Ych1lHtOKCMWviNBJXSu4xGMhCRn0G7N60nc/uPvacxJ9/Exm4HF65NJ+PhM6tpmC3WHvr02s/JvZHsuBfEDAvjvRAD2KsykwpiJXJTYCv25JjFaPqb4RlQWPnHZU7AnEeuj4zxAXTVF4IyiErk/z0QToAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DtXsaFJL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DtXsaFJL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 426904E41E84;
	Thu,  1 Oct 2026 12:44:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 143B660341;
	Thu,  1 Oct 2026 12:44:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 441271032809F;
	Thu,  1 Oct 2026 14:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790858692; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/ZyZ7g3c8QNW8v4IgX6ZlE3a0TN55N3ZA3FiDz+oVX8=;
	b=DtXsaFJLIvsmIiTNRUH9bnHqDM798SviRlTLvWsyCuv943cFNforimCQqx2zNSEhLYAdyQ
	iD89MEjsjn6XTe622JLW/36e4AZ0W2zJmd0/EwfMX7D/IQEe44DcuDL8hMxD85FAorWPYJ
	jny4VsfoIwVtdwT6whUoHdOl5954gW4XdlWlwI2oGLeTsL9+iy1q+4DzpirM6yIBB3fBIj
	ruNYoJou+/Ww1D11XvGDiB1jV0bBld/z82o8ZPc6ZAHqwKVwK7ajW3kHLa/uq1W8L2Vfu7
	FenR8iZFZjapkj/uzDvfEnm8A7p0ooUphOwvgqrXV9Yh0VRwkDK1JevegWMrYg==
Message-ID: <9c867ce8-ff4a-4d0f-a09e-a94b59d602bd@bootlin.com>
Date: Thu, 1 Oct 2026 14:44:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: Introduce hw queue priority
 offload
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Davide Caratti <dcaratti@redhat.com>
References: <20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 9/28/26 18:48, Lorenzo Bianconi wrote:
> Implement the offload of the tc mqprio hw queue priority in the stmmac
> driver. This feature requires the mqprio to be configured in channel
> mode.
> Do not overwrite real_num_tx_queues configured by the qdisc in
> stmmac_hw_setup().

I've tested that on AgileX5 with:

tc qdisc replace dev eth0 root handle 1: mqprio num_tc 2 \
map 0 0 0 0 1 1 1 1 queues 1@0 1@1 hw 1 mode channel

I do see the right prio -> queue mapping being used :)

Also checked that doing a down->up keeps the config. This is
great, thanks !

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

