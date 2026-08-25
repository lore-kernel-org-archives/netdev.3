Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1847FAE3
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664677; cv=none; b=ulWSN9nJNIT7sL2psECI/NTFLQJIbwA9R1UBZXJ7XwnhBdeFt9hf70kJ3/BJ3SvRkWDvGgDgG460STYZGisPPrpWy5DdARhTeMfRBcodlTLWu63vZeIKcTihEvcCZr/9e5HVj0HeuyfXOVrOMGCQMJy1MZeV4uHtGReDjTWvx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664677; c=relaxed/simple;
	bh=95j8077vyuta5qckJwAdUkAm+sNUHQdHpZ6ReHr/V2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihU27n//Ua6agWwHA8D+UKpuwjKSxBBPRNfQVjCwhcJuL3f6tz0xgCQwS3xetIURaAOY8vpOxt2FvNu0rnwKFsYJDZyxM3WkOfjW8i4mEteqimP7QBXGg35S11AcCI7qcy9+NfNDXmA2FjTd1rBsR1m1et+8CQ4x+UGLa/9Fq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lU4e9zl7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lU4e9zl7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 435371A1816;
	Tue, 25 Aug 2026 13:31:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 14058604C4;
	Tue, 25 Aug 2026 13:31:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3BFA11C792B6;
	Tue, 25 Aug 2026 15:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787664667; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=obQKP09CHzI3oI6cWTnZgbb3Pr3kwiToCNqXpKlHYrs=;
	b=lU4e9zl7GduiDG6itsz7WGWMhIR9hmzqzkwulLrSONC1ikgrt/goD+8xEa+yY7ae1XnoUx
	O3wZVfUnQD89chgOEtgsuL4hXTagSWGF82EBqNHwqVByvMtJV3JA9LVmRyuN60VTuder2P
	mQwOlbn4+2d1YgKLM+uSKSUjYDmxjqD0YWr/TTysnG9oaZWSTEJe4+SMEVXtfOcdPmyph7
	367rVe/8RjNzr0FXKyvrDR3zGNF3yWvQM4PGa45dCBZDxr1qmTNxtBa7+gg3uaiYktT2yw
	iyYbvv8T8PgkABKItpZaiagsWjuVAlNWgLCoCvPJBmNPwX65ip0ikXZyws6eyA==
Message-ID: <324e6485-633c-4a2a-ba62-661f75dd6c31@bootlin.com>
Date: Tue, 25 Aug 2026 15:30:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: re-apply taprio offload in
 __stmmac_open()
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>
References: <20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Lorenzo,

On 8/25/26 11:24, Lorenzo Bianconi wrote:
> The core soft reset issued in stmmac_init_dma_engine() clears the
> MTL_EST registers, but nothing re-applies the taprio offload after it:
> priv->est->enable stays true while the hardware EST block is left
> disabled. The TX/XDP paths then keep dropping frames larger than
> priv->est->max_sdu[] and taprio is reported as offloaded, although the
> EST block is not programmed.
> 
> Re-apply the taprio offload in __stmmac_open() after PTP is up. The
> base time is recomputed from the reserved base time and the current PTP
> time, since the timestamp counter has been re-initialized and the
> previously programmed base time is stale.

I agree with idea, but the way I see that, this new reconfigure method shares
some code with stmmac_tc.c's tc_taprio_configure() step (the base time computation).

Can you also take a pass on that, so that we have a single helper (your new
stmmac_est_reconfigure) that does the base time computation and the EST setup, that
would be used in the .ndo_open, clock adjust and tc_taprio configuration ?

Maybe rename it stmmac_setup_est() to keep consistency with the stmmac_setup_ptp()
that comes before, this would also open the door for an equivalent
stmmac_cleanup_est() if we ever need it.

Maxime

