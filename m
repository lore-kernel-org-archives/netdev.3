Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90104E4C4C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846305; cv=none; b=Qi+UEQ8VnHr17szZ2sHHdV9UogdkOs5FaAa5/D+SH1hLYlfPRSHj9d+L+jxtN/s//vL2Rvr5/b+d9eA/WimqdN+fglC8kPZm4W4JfCSVHLN+XwX64EeU1GpdMAJol5jcn06ko71Xa12AonONNNqRy7DngYjHoT6bnpE2Y3Ee9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846305; c=relaxed/simple;
	bh=7LXflxi4hrBkgzWMnIpoaMBF7jvDww4sLpN/8O30Zoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTHdjPWxEt52+DbjzXTfN44rTnT1EqQlWteYSzIwrOBY1KlebiN2q8LutsHFP6zunDq6o9EVQVdTEhx6wRmcAIlsLoEWzv4OF4PMZK2+qo20JWjUyxi8FLuQ0LGg6Q4EAvDD2Mdg1xcNC0LdAMun3j5THxE0OWmNQ7Mf4f56Mto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mklAmku1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mklAmku1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DF5CD4E410EA;
	Thu,  1 Oct 2026 09:18:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A1C8B60341;
	Thu,  1 Oct 2026 09:18:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12CCF1032989B;
	Thu,  1 Oct 2026 11:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790846299; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lebBIPbB/BBbKsr8+CagAXggQBPA0B122eAEgpfMh5o=;
	b=mklAmku1L9j4jxEGEYeaz5xKAc7GnKmjXPB4EhFw8ZQXCmES2qu4X1GTw7Sugi3/+CXE4D
	EF0HpF24Cg8mSm7VyLbCo+4qqW6kMYxeMlZMDxhkDvphEpgs9xAWCgTTeY2VgLCJL3wbeh
	ZQFGF4Gn8HkTqX2UIdPYWYJ/e3TSUzi9+4wAjC7Gz/m6TBwGEcBcnpGkyiKDND4j+bkaHi
	ksN2jBTmKlw859wU2lOYkpUhPnEaso7lsLhNefWdc7DvgGHF70fUTe8+T21PBjNRCU9wu4
	CKTdhWuz+SatO++nEjviuTpy9kPxmX6y1QMY/LHMr6s8RRs8/jq5ZqtY5QYHkg==
Message-ID: <993cebd8-2a98-411e-b8d6-d2088966d9a3@bootlin.com>
Date: Thu, 1 Oct 2026 11:18:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 9/29/26 15:10, Lorenzo Bianconi wrote:
> stmmac_update_subsecond_increment() ignores the error returned by
> stmmac_config_addend(), and stmmac_init_tstamp_counter() discards the
> addend and system time programming errors, always returning success. A
> failure to program the addend (PTP_TCR_TSADDREG) or to initialize the
> system time counter (PTP_TCR_TSINIT) is therefore silently swallowed,
> leaving the hardware timestamp counter in a non-running or partially
> configured state while the driver keeps operating as if timestamping
> were up. This matters for TAPRIO/EST offloading, which derives the gate
> base time from the hardware timestamp counter.
> 
> The same hooks are also called from the PHC callbacks: settime64 and
> adjfine drop the error and report success to clock_settime() and
> clock_adjtime(), so a dead PTP reference clock goes unnoticed by
> ptp4l/phc2sys.
> 
> Return error codes from stmmac_update_subsecond_increment(),
> stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and the
> settime64/adjfine callbacks instead of silently returning success. On
> failure, roll back the partially applied configuration so the hardware
> and the driver bookkeeping stay consistent, and report the reason
> through the devlink extack. Also guard against a zero sub-second
> increment, which would otherwise divide by zero when computing the
> addend.
> 
> Reset the persistent timestamping state (hwts_tx_en, hwts_rx_en,
> tstamp_config, systime_flags and tsfupdt_coarse) when (re)initializing
> timestamping, so a failed init does not leave TX/RX timestamping
> enabled on a counter that never started.
> 
> Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp to generic HW Interface Helpers")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Thanks, this is nice.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

