Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D13C0601;
	Sat, 17 Oct 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258379; cv=none; b=PbrlXyQIQswfD/hDE8TVKo2Gbc7isUAE3iyZuJCWTwTxQ6cXFkK7z8J5dg7wTqw8PPiIOHx6FVLlP48Zwxg63swHbjQTGhp45y5QBvFoOO6z2OayeAy1Vqa6aUTMiNGwHyMXk6hXiSFnKn2nBI6tkZL4oQoi/gSxwouLWtgA560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258379; c=relaxed/simple;
	bh=PoZDbh8zFZHGT0bnSvOo3abVC59c2ysCz0B2lX2dt74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8+LH1M+bzENRiLpKAO6RkLzxqOWbZLzrgC5edtyf5qlDPCEC2tx3UTl1KceQRHsvbF/5z9Z44VEHdymW9+PyyZ5ChBQ0vZRrGekPXgoyEND1N7bYQcobYbS32DomW+2JlpRqguYuZx5qg/pFGhb1FSHr2596ITujK5aciSVyzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=bYit+MJr; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="bYit+MJr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0413109C7B;
	Sat, 17 Oct 2026 19:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792258372;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0PboifeeUBu+En/QUnp8Dze9H/89JQuESMLCW2nSTi0=;
	b=bYit+MJr1x/TFwh8IMEuyMS7y0hQzeHzdvc+wxFOClJEgGlZ2xFrqX0Gsy/uxeqFVO66+b
	joHDJ4BBaEypkc8u8iVW6fOBJEfOZ8tpFhoSqqKFlpsICoa5e6b4XakyisLlGXQfH6gHHg
	bBZa7EyiOiqQa/dYNYB6iwXJ9mDbHRd09YwHoRa+jilLYMYkHL7liejfjEFbalR7F0B+MW
	cFfHcgKJKy+FTE3jDkjKjH9Z62rVtb7aZwnrOwGqtaxGLmyh3dvyMhijQVDiB/FHyzNUHA
	6GwoK9Z+xorwKfo5C592zxEVbAR8E63pIeFN6+hLO1NEVuw/NkCZjEXvO3Wh3A==
Message-ID: <32239c97-e1dc-416d-8570-f681f91df0c8@nabladev.com>
Date: Sat, 17 Oct 2026 00:26:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable from
 DT
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com>
 <725fe351-bdd0-4b53-b551-0f638d02f98a@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <725fe351-bdd0-4b53-b551-0f638d02f98a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/16/26 10:59 PM, Andrew Lunn wrote:
>> +	div = ((clk_get_rate(enet_clk) / mdc_freq) - 1) / 4;
>> +	if (div < 5 || div > 0x1ff)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Requested MDC frequency is out of range, ignoring\n");
> 
> Returning -EINVAL is not really 'ignoring' the invalid value. Since
> these are optional properties which are present, if they are not valid
> returning an error is good. So please fix the message.

All right, done in V2, thanks !

> Why is dev < 5 an issue?
The clock would be way too fast, on MX95 that would be over 33 MHz.
