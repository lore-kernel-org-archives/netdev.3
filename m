Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107E3F2115;
	Wed, 20 May 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289711; cv=none; b=jxNS3nXAwtCYBMcCO2uvByl8ucjY5ruGXDntOW4kbSbfPMjKcHm4FVq8ALiFXXot+HJUrTniT0B+luO9IDFKjJAoJ9OJ2lxNXe1M1wGI52MdBjEJ3CKMxYc/7RjXKQrNRUq5r5sNe6Hbb3KFdj46GEMFPJZiRub4sBJ3ug2Lq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289711; c=relaxed/simple;
	bh=iwd3bci6J9zZ/APhwbGkT4+SLwwRy7nxJaMUKZ6Llhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxfuVr++E2Vv97pbzamhZ0aY2qQkoer1HGdDg4NxcjHXVS/1TRte7yQxdPMgA/ocqlLA5dykfcQKot3bpPQbhjptR63OQJc3zVXopMJzCEatOhW+RPF5TDe0tvzxlC08kgg8gLeE9sf+t9eEswWeEyhY7xntq5AyimaN+rtezDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=SuR9font; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="SuR9font"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96C481159AD;
	Wed, 20 May 2026 17:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779289702;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KMPZHz8s3zuc5m+dAfGa9Et6A0mOFmoCxo6Io4kBoF8=;
	b=SuR9font6MHtd+7tPWA71YbkN/j6M95XUhmz87Rbli53iYYC9pksQx5LvYiyTqL1erQoVE
	ZQ2NULqwpLJ1RrL2DATKmF8kyy9NptEJ24ZBpKX26CaZPI90otqcqMBqjcUhn8FmfRzVs7
	Ezb8GkO4Y1y46Axbu+BG4gMltRxsDxLs5VUp9l6a68kyuc/D/gn9MOze6Sqfox2XFD1kZQ
	5HW5N80AIkPX8DwaVI66mL9E5wECPz2xDdiqA94Lckkd2KdY67gRwDEy1u3zFcH2uN5b/h
	xmHvTvK+N0Wh4+Is9nhGyOGGFUN5cB3MlUsS6SQCihgz3bDBtkj/nraX4oxBZA==
Message-ID: <f8c53143-4aa2-41ca-b57c-58e04f3402d8@nabladev.com>
Date: Wed, 20 May 2026 13:53:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] net: ethtool: add KSZ87xx low-loss cable PHY
 tunables
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
 <20260520-ksz87xx_errata_low_loss_connections-v6-2-43f33d4aaf0f@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260520-ksz87xx_errata_low_loss_connections-v6-2-43f33d4aaf0f@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 5/20/26 10:48 AM, Fidelio Lawson wrote:
> Introduce vendor-specific PHY tunable identifiers to control the
> KSZ87xx low-loss cable erratum handling through the ethtool PHY
> tunable interface.
> 
> The following tunables are added:
> 
> - a boolean "short-cable" tunable, applying a documented and
>    conservative preset intended for short or low-loss Ethernet cables;
> 
> - an integer LPF bandwidth tunable, allowing advanced adjustment of the
>    receiver low-pass filter bandwidth;
> 
> - an integer DSP EQ initial value tunable, allowing advanced tuning of
>    the PHY equalizer initialization.
> 
> The actual behavior is implemented by the corresponding PHY and switch
> drivers.
> 
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
Reviewed-by: Marek Vasut <marex@nabladev.com>
