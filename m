Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D990B3B4EB5
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316649; cv=none; b=HzHswwVndkRJU0rmevLT9/sf/h7WYOvl8AHEdQaRTEBZBioYDYz4GtgKqlIurGC6fBtZrtqnkWK+E6Yo8cZTZAGD6NbeNPdQoLa516Xmcrzy3zqC9zewbYHPR1xXO56PfkEH2lPORAV++Crv+HWjVJ0vaDhGya6KbP8s2GSrsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316649; c=relaxed/simple;
	bh=xPi4Rv8XyiGFZvx2zQ3gRlsuHHPzhPGuzz9AHq/zRgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+STiboEB4Oa+ndbo8GCR91CI6KrFhk8Wo9xPgaZ2kh8VW8tAYcIJySE3LkeiFxINkP+YSN9srDkjVXiO39mckEQP9lLjD2ExSvnZnHDpiE3RhvIjl7VBnZK0hq7fbkc3d1pcxh3BC68AJG0OJG9DEAzH1MYwIBEExnnf02eemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X8nPK6SL; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X8nPK6SL"
Message-ID: <d469bc41-c3bd-4442-92d4-ec2b87e7ad98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785316633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gS9b9/29h4glEuyPhOv6fnYDYfTo9zKm2g6AHt+PlKc=;
	b=X8nPK6SLDuaDBCPtkYqJ2vd2UjWvagyggaPA8YOx2o8y3dVmEmlS5OqdKrGYZox87JN5gu
	UtKSrDnYanyZXJwpji8zOfEirkmBoBW2wVagMeZsdGJKIIiPcOUp7CnvhORoXHa99lH33G
	56nc57NYdMK2eLCsZAXs0R64kuOAGMs=
Date: Wed, 29 Jul 2026 17:17:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] net: stmmac: dwxgmac2: configure INTM for
 per-channel interrupt routing
To: Zxyan Zhu <zxyan0222@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260729023653.1162763-1-zxyan0222@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260729023653.1162763-1-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/29 10:36, Zxyan Zhu wrote:
> The XGMAC DMA_MODE register has an INTM field (bits 13:12) that
> controls interrupt routing behavior for DMA transfer completion
> events:
>
>    00 (default): sbd_perch_* are pulse signals, sbd_intr_o is also
>                  asserted for each completion event.
>    01:          sbd_perch_* are level signals, sbd_intr_o is NOT
>                  asserted for packet transfer completion events.
>
> When multi-MSI is enabled, per-channel TX/RX interrupts are expected
> to arrive on their dedicated lines.  In the default INTM=00 mode,
> sbd_intr_o also fires for DMA completion events, but the multi-MSI
> handler stmmac_mac_interrupt() only processes MAC-layer events (LPI,
> PMT, timestamps) and returns IRQ_NONE for every DMA completion
> interrupt, resulting in a continuous stream of unhandled interrupts
> on the common IRQ.
>
> Hardware verification with XGMAC and multi-MSI enabled:
>
>    INTM=00: 5.4 million common IRQ interrupts in 3 seconds, ~1.8
>             million IRQ_NONE returns per second.
>    INTM=01: 0 common IRQ interrupts, per-channel IRQs work normally,
>             10G line rate works correctly.
>
> Set INTM to mode 1 when multi-MSI is enabled.  This matches the
> existing GMAC4 implementation.
>
> XGMAC multi-MSI has never worked correctly since it was introduced.
>
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>

As someone who has written an out-of-tree driver for the DW XGMAC:

Reviewed-by: Qingfang Deng <qingfang.deng@linux.dev>

