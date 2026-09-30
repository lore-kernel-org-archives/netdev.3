Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7658D2D5436;
	Wed, 30 Sep 2026 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734889; cv=none; b=Q3yqvAt+fRY6gQvRdoMmJi9pmeKXVrBD3IjX5q3EB5YQzNrtPKd8i5H9iawnwIzCPZWdY9OYAjNqHWqObaZuas1GcY1hdbgXQSUi2OWl9pTckuH+l9AyqoTKRH/BFcKiUpTP0nSuptW6I2SuDEyW1INw1tRPlIGZOkDJiphjs6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734889; c=relaxed/simple;
	bh=LRNN6oFQJjirvRJJzGnN3zADb/iCHL7J5N5Wgqs4cnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sujbYXXip+MyWq6UcAbz4D+cdwbAOWc9EI3tsrLacmHUtjkJNXlpWnfrrIji/yhHLaK+etY/DpyNBS1Gj7fPJBtuz90j52KxpPUyRw+l2I5WTrPXYykzoZvWMIceNZ229dgdMoSIpR6B8wFOIw4+UtyhzWcR0dXaw8oYB8dHmKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=OYHbJ6Nv; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="OYHbJ6Nv"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84625106D70;
	Wed, 30 Sep 2026 04:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790734884;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=GIBDucrk0eAQMkKja9ydff/0FXwdYj22k8e2eNF1trc=;
	b=OYHbJ6NvRFZiDTw88Ktyf7QCDLeCX97Ho+dD9ZS9o8YUBJsDuz5uOM22tTpKG7zBTdHB7m
	ZWw10llMzWSoPvOozhhcm55p8ELL0gEgTLugouH40Sl04dj0Qj+vyq6V5E1k8yqmz299RK
	/k/mAWcn6Js9eypab2h/GTXDIJ8Fy9PtkTQVCONuz2jzNGazJDYCm9uv7rNelzy+H6jw5x
	jScJ7t7/+h5OCR60O5KbFlyqLIPxB3cirisaCa3hpJP6MgIinpSdDs/EEpgMHYQSRcBq6E
	A3UFLGzf+viXNc88tRQ9+qzSmOR5s4x+D7HTx7lCwVpyiaqjJKPp9wl9Cpp9Jg==
Message-ID: <c3b7e841-5eea-4431-b231-44659e1605c3@nabladev.com>
Date: Wed, 30 Sep 2026 04:21:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
To: vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
 claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260924180607.60932-1-marex@nabladev.com>
 <179073420852.1211220.2021094445984738152.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <179073420852.1211220.2021094445984738152.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/30/26 4:10 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 24 Sep 2026 20:05:19 +0200 you wrote:
>> The current eMDIO MDC rate is 558 kHz on i.MX95 B0. This is very low,
>> but also very compatible. However, for example NXP TJA1120 PHY needs
>> at minimum 1 MHz MDC clock and 558 kHz does not work with that PHY.
>>
>> As a minimum change, increase the MDC clock to 2.5 MHz which matches
>> the 802.3 specification. Also, even old PHYs like LAN8210Ai, KSZ8794,
>> DP83822 support up to 2.5 MHz MDC clock frequency, and it covers the
>> NXP TJA1120 as well. There is no known rationale for why the 558 kHz
>> was picked when the eMDIO driver was added.
>>
>> [...]
> 
> Here is the summary with links:
>    - [net-next,v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
>      https://git.kernel.org/netdev/net-next/c/587acb86d646
This should have likely been applied only after someone from NXP looked 
at it.
