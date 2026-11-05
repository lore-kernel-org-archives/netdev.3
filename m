Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872062;
	b=g9p9xkHkZdliBzW4hLsndJmewi9aVpvnByh0alJe9Vkiw5mnq1F+iXYSavC+bPxTZlIa
	 WPAUNmdzymCRXQxkABxqUHzsJFlCBPGMQfj5bITApjf29Qb/uhIgeWxjA3OPvaaVFWssE
	 h/f/51k9cvriD/db84ol02HFaxGn07ckgKNqZFx1jMeG4AOIzvxDkpu6KHYVre4rjO0P5
	 JKNmkw4RThibyXgMa90Bc6+ns08xDZaNVjemGfIjpctxF5dbeJu3l5QQjSvLDGCR/SHZO
	 DinLc2b1iXAFEgYD64Dvx/IWRosW+YrqW+uBHcB4oimza73DibZ9EIHZHK3Bu8plDhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872062;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=l7Os9ez/f2nG03fyXsvnvcHKNao5k86xMqMGxwTc8as=;
	b=kt5Szg6CB86aMikBvQn4EBsF2JWMHcp2wzEHjNvgI0buz9H5gwAMtMt1zo4oguQn5c0M
	 WfPjQ/kIO+mQesmgkGvGujQlMSmQHbUl4gW7TX7xkY8/uzeJT++5wHkftPXnQSAueDuyJ
	 SEjl7trOzc4hTuXdXL8BnRr9aTogwMQtsiFcEKBMkGYeugIo+olFOvlwlEMnsybl2kPB7
	 RS75YDdWkHwbELQ37W8nha0uo4EDCmX9Ip9MGGS4Qy3fE79q4bZo3L6NBw38OdHd6K6AH
	 3/stVJA6iFOGhQ3pUUynjv9EJh1qk4sQoAT4FwKjf/239jRI9iviGFT8itO7rYiHt4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jE8oY2mN;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAD606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CEAD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jE8oY2mN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 800111A0830;
	Thu,  5 Nov 2026 09:47:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4EAF55FF85;
	Thu,  5 Nov 2026 09:47:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F01C210329267;
	Thu,  5 Nov 2026 10:47:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793872057; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=l7Os9ez/f2nG03fyXsvnvcHKNao5k86xMqMGxwTc8as=;
	b=jE8oY2mN4nKEq03VZBxogYPKnuGNkPH/G7LfkQJVWaRMDIJxjesNGFQOdQHVg0pE4ypf1+
	u1AD0n00GJIz9nUMGD+FetwWYZyAB6lmvfIsK50lOD46qW+7mgNjLUX6xNQ2xUpMY2af3E
	6T5JyRoqJdOb4E82aF1mkem4MqTYz65XxKRVKDvAsNC2WbPPbmOXunFMQae/3g/XoXCxV+
	Vyj4CG+zzOXYY1o2r2PWrkOTMts1n9NdM2LIyDOXcGpnIiWvYWmfqNOLRzD9pGT4n+U+CG
	w6BeDO4XocWGJBZ3p3d2K/M62PKTod9FEAYDxCTJFg10ejcCTlGVgaCn/Uw3aA==
Message-ID: <b7102713-8bc6-4a5a-bf33-b79a646f4126@bootlin.com>
Date: Thu, 5 Nov 2026 10:47:31 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: keep est_lock across PTP clock
 adjustment
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/2/26 18:37, Lorenzo Bianconi wrote:
> stmmac_adjust_time() disables EST, drops est_lock to step the PTP clock,
> and then reacquires the lock to reprogram EST using a base time computed
> from the new clock value.
> 
> That leaves a window where a concurrent tc_taprio_configure() can program
> EST enabled with a base time derived from the pre-step clock.  The gate
> schedule then runs across the PTP step with a stale base time until
> stmmac_adjust_time() reprograms it.
> 
> Keep est_lock held for the whole disable/step/reprogram sequence so no
> other EST user can program the block while the clock is being stepped.
> 
> This does not introduce a new lock ordering: __stmmac_setup_est() already
> takes ptp_lock through gettimex64() while holding est_lock, and
> stmmac_adjust_systime() uses readl_poll_timeout_atomic(), so it does not
> sleep under ptp_lock.
> 
> Fixes: 23d96de472f7 ("net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

I couldn't really figure out why the lock was released in the first
place, LGTM :)

Do you plan on addressing the sashiko pre-existing stuff ? seems to be
rare conditions but still :( sorry you end up having to deal with these...

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

