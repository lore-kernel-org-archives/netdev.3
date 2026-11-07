Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.238.123.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074323;
	b=leVFDcwyhulZIO8AqsOofl4iTGVb2qy+UhtuFatvjARuNtJcyNithxV4uIjXVE0MbIW6
	 9zwUuqDfmWLA3xcudtK24SJUwOlSXSlNaE0c5VRTVLCDSPCuuXIZ8BOa0CBD39kaOcikJ
	 Lix7AZd1rXxXD46Sw7RXdECtqt46gnbX1iYAqMNAt8SpVihiflQvHEgCNb7IyqgBjEi3d
	 w3dpzNFhjCk0dk9f+r4fwN1oFNMu5OOAP6oXU8BwWvYNJfq99e5sTrSSQke4GLd9iUwmP
	 9PI9HTR5YiWO+7rqL4ud01u/+ogrIAGPqPKkW8fZI1pFwW+/44Lp2yJVb9GrySQjXBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074323;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=X3KKbePSIcNC7QkEyqi+sx/OEJ50cw4qv4mf8XSrOBo=;
	b=eDri0U/6XZL/0omp7Y6fmRByxS4wM2RNLO73CTN/v9UTN0bBL/DfFLLvjMHt78pciLry
	 /67fCGQrBCVxOEi5hrEQWaxhzLshq1qWzB5UD4egHqnQi5JoWH0fwfnn4Evs6Wyi/O/sd
	 McqWt+9rJ53b7EFelGje7vZAnVuDChItZs9ybrBM+i6t2BsItB7BzqM2lvX/yZFXQCg2z
	 6Ns38zQUo9YXu7ZjJjRt67AvG1rAIsTOS7q+HWQrzAVIXN0aJzfec8sylS9SIXyUwMBkm
	 nkSsuYjIVfs1S4vlnkiGbEDuSaHXdSkjPmTYkNkGu8ojHviaGWK8gPVxNeg3ImNcv2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marleb.org;
	spf=pass smtp.mailfrom=marleb.org;
	dkim=pass header.d=marleb.org header.i=@marleb.org header.a=rsa-sha256 header.s=dkim header.b=piB6QCaS;
	arc=none smtp.remote-ip=80.238.123.102
Received: from mail.marleb.org (mail.marleb.org [80.238.123.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93190606A326;
	Sat,  7 Nov 2026 17:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93190606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marleb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marleb.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marleb.org header.i=@marleb.org header.a=rsa-sha256 header.s=dkim header.b=piB6QCaS
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D085EF50;
	Sat, 07 Nov 2026 18:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marleb.org; s=dkim;
	t=1794074319; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=X3KKbePSIcNC7QkEyqi+sx/OEJ50cw4qv4mf8XSrOBo=;
	b=piB6QCaSSLPnB7x093Iu7/TESACTeYP5RHz4yDGhZ/v5WPwcGdxbknAPN9D7GlnifWctRA
	ZtgT1ktQ4avNE9pCrCtT3Cj0fcyEavlClU8dECa42Z9TzDwqYDMMnEmR9R/I6y1qFRnoGE
	KNUR5KVqe/gt72DMc+T4qSBTvOLBOrq61NLwpI2gBVbMJxATL/rIqQtl41ujgNXEv3PZd0
	/LJgFkDO3InoiY7t4pf+p2dnNXdqnG2+J3d4XxiF43bhkZX7QkiSqaRZGFh8QyqJoaQVOo
	C8nKTEgHfGgotOXVv++5OOOFyeKXAbQx0fhRToIAtWUaOr4yEEANI3R43TwG0A==
Message-ID: <bce539f2-9dac-4574-a765-11cf367bcbaf@marleb.org>
Date: Sat, 7 Nov 2026 18:58:36 +0100
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
Subject: Re: [PATCH net-next v2 3/3] net: phy: realtek: register hwmon thermal
 zones
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org>
 <20261107-realtek-hwmon-tz-v2-3-6b9a69d44470@marleb.org>
 <ed20a09c-e275-4124-90b7-8b1ada9fbf91@lunn.ch>
Content-Language: en-US
From: Hleb Shauchenka <me@marleb.org>
In-Reply-To: <ed20a09c-e275-4124-90b7-8b1ada9fbf91@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On Sat, Nov 07, 2026 at 06:22:36PM +0100, Andrew Lunn wrote:
 > Does this have any value for Mainline?

No. Its only user is OpenWrt's out-of-tree RTL8261N support. I will drop 
it and patch 1.

v3 will be patch 2 alone without the Fixes tag and with the AI note 
below the ---.

Hleb

On 07/11/2026 18:22, Andrew Lunn wrote:
>> I tested this on a Zyxel XGS1250-12 B1 with OpenWrt's Linux 6.18.55,
>> where OpenWrt's out-of-tree RTL8261N support calls
>> rtl822x_hwmon_init():
> Mainline does not care about out of tree code.
>
> Does this have any value for Mainline?
>
> If not, drop it.
>
> Or bring the out of tree code into Mainline.
>
> 	Andrew
