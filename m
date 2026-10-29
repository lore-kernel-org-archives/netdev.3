Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261303;
	b=ZfNuOIJtCSprPp2JgaDuVnkm9LiYLsSG5xYivXbNDCoCFdU8pRorCTB6h80wSw9x06Fy
	 gAIqVoEOCTbXKhYvLyvJgYGwisQpPFyacJaPTsIm2G4XV6Pf/ViaJRSe+kfyouykWwPE0
	 DVzFSi4RVCFHbASrl6dqfplEZhIR8KVBQShfo5Lkh2fndkQ/oct/0tFuz1Hgw8Sv+SPxl
	 vvgugs1iYwIObnuPKHIXvK+fzZgaI6lyBwGdNj7ZerWC7dR3Ce8EDz4wkZplxgJL9BDVb
	 UX4Q8cQBKi8gWgCMcWN9YIfH595QYQQ7g9TOqgNQeEw1oRnRvLfHoFnHeaRO9nsz+iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261303;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=eOuijn9PgMv6riyIyWWQRIh5Cc6DVi7OfQ5u48jI3VQ=;
	b=Snxt6HUJiExxytdFva66Am/gHOJPJhHyrx8/asx90gKTqZmQMSFk7C70aF7iea5HsuO+
	 sS0Otx2xZfi5Kv0OjpnvH68ZizjEBn7t6Fr12LJk6U2ABF4iuMD0cujK4HBNAK6b9i/+5
	 uiAlU8VDEJGDum1VZq1tCIvjaojrlsFM4sDQsFXEKrO/mSlWTtMVs/SuSzk6wrSZ3XuNy
	 gnwb9EylyFAXNofbs8XhEE7nwSlJTdj7Av2/11ecJ1IY9IrBeld7VKV9JWN53if3HR4wd
	 9STaoNs+GQgA/ZhEuvAdaXn6+BIIIlmM+0p1TbeAC1aYCttEft6D6BOgmpclOSu8EHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mV5QDOdV;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F94A606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F94A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mV5QDOdV
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 980441A138B;
	Thu, 29 Oct 2026 08:08:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C71160360;
	Thu, 29 Oct 2026 08:08:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 046A1103290ED;
	Thu, 29 Oct 2026 09:08:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793261297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eOuijn9PgMv6riyIyWWQRIh5Cc6DVi7OfQ5u48jI3VQ=;
	b=mV5QDOdVzDfl4NIwYDrDcY1+KRvU/6S0qUUQfABjFDGmPmboTiIQtG/U0mLR6Hm9eamKcC
	KufXt7HXmWRyDDQR/LsK9rBG/g6qGtLYjSQ0Fw4vkA0HGdi6tjfkLxgmxIgs+g2GibnUX0
	1hFSBd9kwzVJxSxcDi950sVPJc/DjaUqIRI7m8BQBwZVMMMo/Wd7fGRNrV91dk1JBerhr1
	dL9QsVmgfMcuRfLE7QFmzgtU2r/XUbH1igFjY+BftdQ1E24BggW2uVz5CCtK3BhVNlljY6
	LgkWJ0W6Y9PUVF27wVXMFtZ5+Nw5qAnRcKi1HRkATNqws3atXh6DLb7Y/zEwWg==
Message-ID: <a71e5698-1ab3-4032-8905-3ada901d799e@bootlin.com>
Date: Thu, 29 Oct 2026 09:08:09 +0100
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
Subject: Re: [PATCH net v4 1/3] net: stmmac: initialize est_lock at probe time
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jose Abreu <Jose.Abreu@synopsys.com>,
 James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
 <20261026-stmmac-est-fixes-v4-1-999dac4de44f@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261026-stmmac-est-fixes-v4-1-999dac4de44f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/26/26 17:55, Lorenzo Bianconi wrote:
> priv->est is allocated with devm_kzalloc() on the first TAPRIO REPLACE
> and priv->est_lock is initialized in the same place, which ties the
> validity of the lock to whether TAPRIO has ever been configured. The
> lock is also never destroyed.
> 
> Initialize priv->est_lock in __stmmac_dvr_probe() next to priv->lock
> and destroy it in stmmac_dvr_remove(). This keeps the lock valid for
> the entire lifetime of the device, independent of the TAPRIO state,
> and removes the lazy initialization from the TAPRIO configuration
> path.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b20e5038eead..9e09e11cc35e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8204,6 +8204,7 @@ static int __stmmac_dvr_probe(struct device *device,
>  	stmmac_napi_add(ndev);
>  
>  	mutex_init(&priv->lock);
> +	mutex_init(&priv->est_lock);
>  	rwlock_init(&priv->ptp_lock);
>  
>  	stmmac_fpe_init(priv);
> @@ -8337,6 +8338,7 @@ void stmmac_dvr_remove(struct device *dev)
>  
>  	destroy_workqueue(priv->wq);
>  	mutex_destroy(&priv->lock);
> +	mutex_destroy(&priv->est_lock);
>  	bitmap_free(priv->af_xdp_zc_qps);
>  
>  	pm_runtime_disable(dev);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index e137fb9012d4..aea235a69105 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1028,8 +1028,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  					 GFP_KERNEL);
>  		if (!priv->est)
>  			return -ENOMEM;
> -
> -		mutex_init(&priv->est_lock);
>  	} else {
>  		mutex_lock(&priv->est_lock);
>  		memset(priv->est, 0, sizeof(*priv->est));
> 

