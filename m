Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6853F788A;
	Thu, 24 Sep 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273215; cv=none; b=DuRo3HjZaQbrwgzd0aGr16hTk6cF2A6WEqKX9SAVjIsBsVf68pC9F/Tg1MuznmWrGudOCumqesofkt8ag3izTUqPlez1olVNT1+muZbkwFzdJFEupBK9KXZGbLjE5UXNt5XnH352bo4ZQAv55d4yHlDvbbIvPfkG/h/K85zGxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273215; c=relaxed/simple;
	bh=uoa+BY+Pjz0Ftpezf6zE6db/o3Lriffv/vo4YbBUHjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9osMw1WVHXx7uDGN/nXMz845gIcfi3OBCVESaa1JgUg70sWUgzoW/1lhVVmyy9mzllTdwDBTOUWhjVaPoAWuXFpVcTImsmmdHB+XXoj2qpr4TKl/+29YzxhJSC7va0J3sTfOI0DjKM2RIfZm7rsc76Bd+cES3o2nt7c7gyIZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=YoqSBEY/; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="YoqSBEY/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16F8510320B;
	Thu, 24 Sep 2026 20:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790273207;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KaPmhYJiv2RWzABQewYUozkOo6tabw813JQAVpWnH7c=;
	b=YoqSBEY/5CblCjfirgKdznX0J73SYQKftEOzcit4FPQitx6y5iFQBitpFNERtVjnkxa7ds
	c6H+kjGo6CFltsjpNqYEPtwyqBYNx3KT1QkX2hANF75BVqex2wLsKPowF68K44o7wOcgjG
	fbGM7/6FmgyS0Nbx2sgnTheI1J9N+70H/svEitApB6PCmKZWD2Q7+dN9Q4JbgWTIDUo9Xv
	NELk1PUfEnm4NDj4/7dt009LtsaFP3K2U1b5YARXVgQij6ab7of0pBr4r3zbBJSVqrb6Ah
	ApdNLN3POX2k9ktRSfHqx0Drk15blj0pJBLRdsrbEVaE+LaxMh2Esaef6x/1Wg==
Message-ID: <d9cf3696-1615-4b89-b17e-f71945153e66@nabladev.com>
Date: Thu, 24 Sep 2026 20:06:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v1] enetc: Increase eMDIO MDC rate to 1.2 MHz
To: Andrew Lunn <andrew@lunn.ch>, Qingfang Deng <qingfang.deng@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260924003132.580306-1-marex@nabladev.com>
 <b49d86a5-299b-41a8-b65f-51f1aac2a1e4@linux.dev>
 <e1f3dcac-af64-4eab-89c3-3b79c3940984@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <e1f3dcac-af64-4eab-89c3-3b79c3940984@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/24/26 4:21 AM, Andrew Lunn wrote:
>> If the property is absent, you should configure the standard 2.5MHz rate by
>> default, instead of 1.2MHz.
> 
> Agreed. 802.3 says all devices on the bus should support 2.5Mhz. So i
> see no real risk increasing it to whatever the hardware can do close,
> but less than that.
Done in V2, thank you !
