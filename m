Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF18351C11;
	Wed, 13 May 2026 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634393; cv=none; b=h1BIOjbBZrn764HKS+5GxJmreRvlmbBg/sip0VFzMSJc8BwFVqleGE0Vyuc+C2OBAuu/R3rhR/BVzJMQqSzr+LFBhn0nhOhRasIwuh4j3QMd/84Y9+VRQGEBl2r+coCpwCbZDddtxMgE2doKoSfetO5PTsc3H0GdWwFsjYezRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634393; c=relaxed/simple;
	bh=MKOlR0CS3ivkFfr1AO1Gtey/K8HXVBOdoGLufg3xubs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEoGzk9k4U+gawM1C61sum2CKmVz9ijIGaanXhyVcurQoGIL3RTVwxT1JRwIpeT6tTXeg/4INrQBdfAAuM8rExFdpeEhRVQi2WL+5GPURJ3IZGbvfHuQtfY4s9M+Cqop7sy859fZILjbGLI4sRL+BAZMWApap7XyhVXkh7IYvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAx04tkf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAx04tkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284CFC2BCB0;
	Wed, 13 May 2026 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778634392;
	bh=MKOlR0CS3ivkFfr1AO1Gtey/K8HXVBOdoGLufg3xubs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fAx04tkf/FHbPYi/qDBrfLNYm+w9oJ4d6nWQ+Bo9qK3gfolr5egFeaGNCbXl3oGvi
	 SXiZEMATuoK/IiIBaVbQS2X4lUpb9dsruxwrPR8AFLZITs5Zh0eLXqV2JCllGFh0E5
	 qzVHnxeyTMNbL6RNiYWddSoLRrvzmH/JHW1Ha+zyCQ3vDuJunsl+jC3jwZvwNkmSq9
	 F4YFET69k1rAgYK5ek//PZD3d/Xl8nZCr+QhuRkc48Fh9V6epPUs1hLU65i/cKfcrg
	 wl9VUNx05HlSXBaG5Fy8Iq2sh/LxSCV87lmT23QqtnT8l277jrxOaOI9OeG9O+GMj2
	 GishuMiukiPwQ==
Date: Tue, 12 May 2026 18:06:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] FDDI: defza: Sanitise the reset safety timer
Message-ID: <20260512180631.7c50adff@kernel.org>
In-Reply-To: <alpine.DEB.2.21.2605061216430.46195@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605061216430.46195@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 May 2026 22:04:50 +0100 (BST) Maciej W. Rozycki wrote:
>  		case FZA_STATE_UNINITIALIZED:
>  			netif_carrier_off(dev);
> -			timer_delete_sync(&fp->reset_timer);
> +			timer_delete_sync_try(&fp->reset_timer);
>  			fp->ring_cmd_index = 0;
>  			fp->ring_uns_index = 0;
>  			fp->ring_rmc_tx_index = 0;
> @@ -1018,7 +1018,9 @@ static irqreturn_t fza_interrupt(int irq
>  			fp->queue_active = 0;
>  			netif_stop_queue(dev);
>  			pr_debug("%s: queue stopped\n", fp->name);
> -			timer_delete_sync(&fp->reset_timer);
> +
> +			spin_lock(&fp->lock);
> +			timer_delete(&fp->reset_timer);

Noob q, why use timer_delete_sync_try() above ?
