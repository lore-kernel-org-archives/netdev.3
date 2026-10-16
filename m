Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6503C9EDD;
	Fri, 16 Oct 2026 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179066; cv=none; b=XHE+bgtCsFgJ4rhyTAXXZc8k5hv7ksp7dA3jZChWTUK0Ra9mgPiccafGK+51j5dOZQaa+GCY1gIRbYW3RCzJQpGLuucc51ukJCu0U+3G7e1zJAStI0T/qUOkzj22PQdUDqQIEdQah5JonN6/gxn3cPLlhWXOCFRALgh6LjbZBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179066; c=relaxed/simple;
	bh=jSXmpReOEzXUc0JLxH//R7dvy92YyevKFQJHdUiv4Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6oxpONgXJRYxnFsY1GE4lnal/w/35Qk9ocHyqq/gtVX09y5Xooz98A1tL29/FP/DWVwZU+bif1/UW9X3r+M7azjLHexkuQVQXrQ+uZiUWcZdCdyQ3FbfwSqbMEpd/3Ra15ihlbBTgIgys4FKA0yVDWXV7D3w6Ue6YM2Y+SlGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=T7Ztns9D; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="T7Ztns9D"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FF53106175;
	Fri, 16 Oct 2026 21:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792179061;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=yMIPWPPkArNb9QBk2Pp7fUcT9jQ4pAJbPTXYT4LYX0I=;
	b=T7Ztns9DPAV83p6VQfRINYMKx3JnnbG/KKmRFAGl1TbX+2Al7o2Z7KLbkrOzNpb1cCSyWn
	5IbNqAUuRoWSkvtziV39cvVFlcwvUD1dN+Krz9nbhN/76Wd+6hlFkglwRh6bLMxOIy2xl5
	eWLGNn6f2cKA5l8r7clhU4WE7CSZzEoXrmwCRHcIyMiZQ2zp6Yg/92z7Kkf2/JQZWrS3iS
	f+bSeUsgBKkYFmhAkIwLogegO+WbkMy9O0eESd5eQJPd/A+5F/HFUAb5+SLrLSUFqGkHks
	JesplQMwRACEK2XcSe1cbktoP8ucSUmWiJscu9KmrMGWfT8ZZjOuG1td1YUfWQ==
Message-ID: <39d85490-d6e4-4bd1-a539-94cb34c31cea@nabladev.com>
Date: Fri, 16 Oct 2026 20:20:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH] enetc: Set eMDIO MDC rate to 2.5 MHz only on
 i.MX95
To: Wei Fang <wei.fang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261001223947.60189-1-marex@nabladev.com>
 <AS4PR04MB93382E107F5799E9FAB9010988932@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <AS4PR04MB93382E107F5799E9FAB9010988932@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/8/26 5:24 AM, Wei Fang wrote:
>>   static const struct pci_device_id enetc_pci_mdio_id_table[] = {
>> -	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
>> -	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID), 0, 0,
>> 258 },
>> +	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID), 0, 0, 66 },
>>   	{ 0, } /* End of table. */
>>   };
> 
> No, please do not add the divisor to the driver_data. All NETC v4 devices
> use the same vendor ID and device ID, but their system clock may be
> different. So the divisor is different as well.
> 
> In addition to EMDIO, the ENETC port and NETC switch port also support
> virtual MDIO, which uses their own MDIO registers to access the external
> PHY. Therefore, the modifications go far beyond this.
> 
> If you don't mind, I can add a patch set to address this issue later. You can
> simply revert the commit 587acb86d646 "enetc: Increase eMDIO MDC rate
> to 2.5 MHz".
I am tempted to do that at this point, but the MX95 would then be 
incompatible with TJA1120 which does not work for me.

But isn't the PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) 
compatible ONLY with the MX95, so this would restore the behavior on 
non-MX95 and fix up MX95 only ?
