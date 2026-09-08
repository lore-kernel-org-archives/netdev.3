Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BC1FCFEF;
	Tue,  8 Sep 2026 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897172; cv=none; b=qHm1oHtFFx8EQhUQ6ny1FQagOwc4dxS3oj86VoLQnek6T7N/KkHsggr4qQJ05bflmDpw6t94rQCVTAsGRhshVAj24i2/gLWGXXCwoY8QemGrDD3VVJ4h7uC1W5ihHtl9+OVbbgUvsyTQszwA+azceBGtqmu1hFlSrHs/OYwtchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897172; c=relaxed/simple;
	bh=MdAIDH+RInb3sJCDn/Lfb6qkkm7jdaxVszyWjHPrkak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ou41xLJdH60mVNOWdmwA7ljh6FQTtPmZ9hw0ODaCkxmUrVZKp95iaoA7ueGoZn5iUK/PsgyLEgD+kD9Il8ur6glxInxSjeT/OxDuWhye/YDZGEO/31eWmc5StTugRmkwU9rqCRclm0J/esH1fvvrpALcL48FwJIk0xN6QhroR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.10.90) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 8 Sep 2026
 22:52:45 +0300
Message-ID: <faca06b3-0d16-4add-b2cd-2b87ce2d3710@auroraos.dev>
Date: Tue, 8 Sep 2026 22:52:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFT] ch9200: return error on failed register
 writes in ch9200_bind()
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20260903201842.62338-1-s.shtylyov@auroraos.dev>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260903201842.62338-1-s.shtylyov@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/3/26 11:18 PM, Sergey Shtylyov wrote:

> The successful register writes, done via the USB control requests in
> control_write(), seem vital for the normal functioning of the device,
> however the driver's bind() method ignores error codes returned from
> control_write().  Do bail out of ch9200_bind() on failed writes...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace
> static analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

   Scratch this patch, I was sloppy... :-)

[...]

> diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
> index a206ffa76f1b..ce2e62f85c3d 100644
> --- a/drivers/net/usb/ch9200.c
> +++ b/drivers/net/usb/ch9200.c
> @@ -360,32 +360,44 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
>  	data[1] = 0x0F;
>  	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
>  			       0x02, CONTROL_TIMEOUT_MS);
> +	if (retval)

   Should be (retval < 0) here an below, as Sashiko pointed out.

[...]

MBR, Sergey

