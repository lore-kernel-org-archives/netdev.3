Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023EE4C2253;
	Thu,  1 Oct 2026 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894593; cv=none; b=St60latvvMGUygGiuzfCvjDk/sOfXz6Plp/6TkbkpvyiQlkEJn8itV4VFQET9d+dFl6obP1sAfzT/mYPRnuWTOf1S423fxFKZVfKS9x1DQ6Sui3ii6eA8T7uW8X31AC5hPCNY9Kf70rLgSIo1on95JXDFZ8SeqQ3OOy3vx5N4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894593; c=relaxed/simple;
	bh=kJRwv5h9ToKisnexYBtEEVUM2jdUTBhoBGdWD/DfGjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpTsgc555vYHcnAVgjk8JirhQLFPFK3f7VgW4v8GKiZhHH8JY413b+03gq3kdOvyJK9nb0Ksi2z5ruJy7ucvF2uxjhVTHLv0G0Ast4yaf2xWC/3bxY40dHBnd8xF1OjmZztBvqCKmLPoY9UtmPs42CSuHqfxjSQJaQ/zXRm5lPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=jqVO5BGe; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="jqVO5BGe"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7D501073A4;
	Fri, 02 Oct 2026 00:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790894585;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QfWzBuq7EHHbTo+JZC5PGQqIAPDJwKfbCFtTqTNiPrU=;
	b=jqVO5BGehLf8HRgsZX3+ruvKIHSCIK1Anbwf/b/+hwnUMZoPBfmEtC1Byt2ejTaxi0lHsI
	XyZyHg72dPQizI8Fgk6/pW2qxDCWwdM/S5S+7mfaWfR3zFFDVAo+bd/XPaiKkFOtmrmK+0
	CZ6nRnGrca+6PIMAv3nswkxfEqK1zLwgdLGb55+DuHzNMj96eIKvG3ZMaN/0W8hnFG27hh
	AH4/KNQtQVYTIVUJnAP5macA2kOwW0BfZh+bTHS1pi9E+IMtJGJUHPTMw+fYotItoPIvlJ
	V9aYsK96i4ND9RbCKv7Zuquy4r7XRk7EoLmI2DRU64e42RkusV8lKSiky+kQvg==
Message-ID: <42f7cfb4-d04d-4782-b789-f291d393af2f@nabladev.com>
Date: Fri, 2 Oct 2026 00:43:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
To: Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>
Cc: Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
 <AS4PR04MB9338E76DB4A59D70F1D6AB2F888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <e7f574ab-5fcf-484a-a5bf-fc94d45b2311@nabladev.com>
 <AS4PR04MB9338B4278A2A5B94FA854056888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <0b1e6d29-5054-423c-bf7d-2206f2473579@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <0b1e6d29-5054-423c-bf7d-2206f2473579@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/1/26 3:53 PM, Andrew Lunn wrote:
>> Okay, but please consider Andrew's suggestion. Add clock-frequency
>> support for greater flexibility in adapting to different situations,
>> instead of fixing the MDC clock to 2.5MHz.
> 
> I consider this nice to have. And to actually implement it, you need
> to know the base frequency in order to calculate the divider. So i
> suggest the first patches in the patchset set the clock to 2.5Mhz,
> then consider other DT requested frequencies.
I sent this:

[net-next,PATCH] enetc: Set eMDIO MDC rate to 2.5 MHz only on i.MX95

This sets MX95 to 2.5 MHz and keeps other SoCs unaffected.

Wei, for the other SoCs, do we know which SoCs clocks the MDC (divider) 
from which clock ? And can we figure out the clock rates and dividers ?

For the MX95, I assume the clock that feed the MDC divider are "enet" 
clock at 666 MHz , divided by 66 and divided by 4 ? Where does the 4 
come from ?

Thank you for your help !
