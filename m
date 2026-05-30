Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB135966;
	Sat, 30 May 2026 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780122915; cv=none; b=f8FGZpb51wwNAwyE9GaVqvF1Oz6JAZn03H4RUvTHkJQ93oxd3likRAjK6YTcZVxYdfoOALVgh28vbZC1AEkqP+SakyIN9tyRLs+wHEwmWJ4fEBm9dyGJlZ/TcozDRJcViZcPHU92zSqSZsPmnhVtYrc95DdkV6LRdMwd/sfld0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780122915; c=relaxed/simple;
	bh=JjWknotOctVN8Gy12LZ247WkBs9Ik3JWzePsFwb3bxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCITudgZKAI8bDIjVMBIMEqRYLP6eQ/hXPin51sY53SN8XhewH1gCPcQOnRjdUfdLc3gYIBMoGMQJ7GBP+iguUBlRCkoy75Wy/xx8OxShC5Vnp0e+KnjIwilkPHBX6EjC1IlLm3zUx2EBE14GKqhG0Uvm5HBz+bul+nTh08zwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IHshW6mF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IHshW6mF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D2BF54E42D86;
	Sat, 30 May 2026 06:35:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 886006073B;
	Sat, 30 May 2026 06:35:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98DF510888054;
	Sat, 30 May 2026 08:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780122909; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hQOONos00b9vgJBe20WuaFQrNsDdFnNkgPcoPy8oB7U=;
	b=IHshW6mFoh2qhhZU3+8sMWcWAbbYXh8nY15GQWE+PjeH2PDqOpMh48xyiLHQGAFmf5PXpS
	f3ychjDlNjpLlCxLXxm7RyuEvCSWWhWhogh27bhb1so97QmF+W1PU67bU86IDTVdqHSVIT
	Lj/oHzFdaagswr0HBPCw47CkLB4ayCM8E0p6WLn1iBt7HwfVItdnq/MtYpRLdNsfx7fJud
	ZwG2Ba1bGO6pVXU9Rz7qYNQ2eZXAP8jZWm+n9FaTbWxcdG3U1D01+kGpw9vtcCJKXwsKkI
	Tsv5R9ab/5gHFQZeoSUqD2h0Wt5Ang3QUaY8EDqTcey/o+B8I+eBHMpX/ld60g==
Message-ID: <801daa51-48a6-4c02-b987-1fcf1a51def8@bootlin.com>
Date: Sat, 30 May 2026 08:34:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 10/10] Documentation: networking: Update the
 phy_port infrastructure description
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
 <20260521121040.1199622-11-maxime.chevallier@bootlin.com>
 <8833e5bb-3618-4733-83bc-bb3fddba5c6a@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <8833e5bb-3618-4733-83bc-bb3fddba5c6a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 5/28/26 03:21, Andrew Lunn wrote:
>> + - The SFP cage itself is a :c:type:`struct phy_port <phy_port>`. It's special
>> +   in that it's not an MDI interface, buti rather a hot-pluggable MII.
> 
> buti ?
> 

heh, 'but' + bad vim skills lead to "buti" :(

I'll fix this :)

Maxime
