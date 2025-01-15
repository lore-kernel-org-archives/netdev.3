Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DAE3594F;
	Wed, 15 Jan 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907601; cv=none; b=bPG5YgiwyxKphEMpfOHabHjVpHowiShTfVU2El1qCTNmzcclVSAcGOwrt0AMpCySnBIsYGUkeQM28oGiyUs+fjX/md5aE6dNPUvWh5LndhnOXF1qPbQHRy19+WW/zbG95E9Ddg1dnj7VKkjXE+nREfpB+QbjuGh/aTc3+jjMlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907601; c=relaxed/simple;
	bh=k5zcdfRd+dirvcL8WCDgycvlSRDQLgmbaRl4EKUNh8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avIR0ogshtQNIhFEc6vSVe+Ten3MCoGABpfiFAhWSsPN3M5sB60UZ0xb8SZ1d5HITPMFdC38x4iaMwwCSElyQiC3TwCpdwImDGE1zRP0a7BoXyrLPlmmLMJLcND3oTyEgsbnU/a+FQquAU6vR+B+9/ukTP5ivuFTXPaUDpaEmxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F18nyyAY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F18nyyAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379E2C4CEDD;
	Wed, 15 Jan 2025 02:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736907601;
	bh=k5zcdfRd+dirvcL8WCDgycvlSRDQLgmbaRl4EKUNh8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F18nyyAYLuvENyVSSD71xF45K2a6V9tKMNA9Jg5utrotWZdfHvUhkle8ERQPMAF/j
	 9X2YVem+hIZKDHX+CHUCaSP6kW3XEbjsX5mky8Vn6aLbtV64WIqrAGZrJjMtsjnGFV
	 5WbNyMLFhHYZBf5qz7P5JbXLAqZkSKdbBIb9aBJ5Sfv+VGkc/i5LchZZeCX0/w3uMn
	 Kve9q964/87EekbJHWGGPpvg55HqskaqJHZHXsn9kEkCMjJ2u9A7+WVPXrWxqRZdER
	 yloi7L0GfaMhe0P/MDptWxXLeLmsW2lHzpEUmYIOcKRo3nDtt+qF6jCBpotrYlorde
	 FXY4LTwo5Yu9A==
Date: Tue, 14 Jan 2025 18:20:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Optimize cache prefetch in
 RX path
Message-ID: <20250114182000.4ca2c433@kernel.org>
In-Reply-To: <Z4bzuToquRAMfvvu@LQ3V64L9R2>
References: <cover.1736777576.git.0x1207@gmail.com>
	<668cfa117e41a0f1325593c94f6bb739c3bb38da.1736777576.git.0x1207@gmail.com>
	<Z4bzuToquRAMfvvu@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 15:31:05 -0800 Joe Damato wrote:
> > @@ -5525,6 +5521,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
> >  
> >  			dma_sync_single_for_cpu(priv->device, buf->addr,
> >  						buf1_len, dma_dir);
> > +			prefetch(page_address(buf->page) + buf->page_offset);  
> 
> Minor nit: I've seen in other drivers authors using net_prefetch.
> Probably not worth a re-roll just for something this minor.

Let's respin. I don't know how likely stmmac is to be integrated into
an SoC with 64B cachelines these days, but since you caught this - 
why not potentially save someone from investigating this later..
-- 
pw-bot: cr
