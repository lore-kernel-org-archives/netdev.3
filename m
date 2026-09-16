Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9974A7C9D;
	Wed, 16 Sep 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577943; cv=none; b=HVIXVKm+aDDwmh3roe6G6gFNd3hR6p/Vs4+bA7E6Q1idLkc0HS9TmF2dIDxR4VIYFvOZtKQtt0RYq3VJ/Wky7j1WRxx3SdANE6O7yB+phDC38byLMJok2kHVli1+fBtXCenxij0SSfAT17VUrsO9jkILvdaYREsVORw5lWXkN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577943; c=relaxed/simple;
	bh=nCOkKQ3QYNmr6YwW0KkBrOquIDT5V02Kc3+70ny9WPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JiWAWPZ7cq0HkWX3mncu6uIv4DJ9Vnhpe4Tjj4UQaz1AjTkvUHg6vYg0q7HEWOmlr76+PEPKfJl5MHEroAc7/7q5PUAzCarL/cfKaB3ZOu7jU+olFofYN5cpmj9wcbShu7wPTCmxI1OzKc9WBmEuYlMTl1reJEPNjavMSj7xVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.42.68) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 16 Sep
 2026 19:58:42 +0300
Message-ID: <9fad10fc-dcd9-437e-b422-018638524632@auroraos.dev>
Date: Wed, 16 Sep 2026 19:58:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ch9200: return error on failed register writes in
 ch9200_bind()
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-usb@vger.kernel.org>,
	<netdev@vger.kernel.org>, <mjg59@srcf.ucam.org>,
	<linux-kernel@vger.kernel.org>
References: <20260914202503.52920-1-s.shtylyov@auroraos.dev>
 <178951445003.22033.8083675025384414442@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <178951445003.22033.8083675025384414442@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/16/26 2:20 AM, netdev-bot+sashiko@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> - [High] Ineffective fix: the six newly added `if (retval < 0) return
>   retval;` checks in ch9200_bind() (drivers/net/usb/ch9200.c) cannot…
> 
> --
> 
> ch9200: return error on failed register writes in ch9200_bind()
> 
> The patch adds error checks after the six control_write() calls in
> ch9200_bind() so that a failed vendor register write aborts the bind
> instead of being ignored.  It carries a Fixes tag for the original driver
> commit 4a476bd6d1d9.
> 
>> diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
>> index a206ffa76f1b9..ab3cd3902ed72 100644
>> --- a/drivers/net/usb/ch9200.c
>> +++ b/drivers/net/usb/ch9200.c
>> @@ -360,32 +360,44 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
>>       data[1] = 0x0F;
>>       retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
>>                              0x02, CONTROL_TIMEOUT_MS);
>> +     if (retval < 0)
>> +             return retval;
> 
> [Severity: High]

   But why? 8-)

> Can these new checks ever observe a failed register write?  control_write()
> in the same file discards the USB transfer status on its normal path:

   By "failed register write" I meant any error in control_write(), including
kmemdup() failure (which precludes the USB request from being sent at all)...

> drivers/net/usb/ch9200.c:control_write() {
>         ...
>         err = usb_control_msg(dev->udev,
>                               usb_sndctrlpipe(dev->udev, 0),
>                               request, request_type, value, index, buf, size,
>                               timeout);
>         if (err >= 0 && err < size)
>                 err = -EINVAL;
>         kfree(buf);
> 
>         return 0;
> 
> err_out:
>         return err;
> }
> 
> The only return err; is at err_out:, which is reached solely from the
> kmemdup() -ENOMEM branch.  All six patched call sites pass a non-NULL
> 2-byte data buffer, so the only negative value the new checks can see is
> -ENOMEM from that allocation.

   I kinda noticed. :-)

[...]

> The sibling helper control_read() already returns err on its normal path,
> and ch9200_mdio_read() checks it with if (ret < 0), so the convention
> control_write() is expected to follow already exists in this file.

   And I'm extending it to control_write(), but in another patch...

> Would it make more sense to change control_write() to return err after
> kfree(buf) instead of (or in addition to) adding the caller-side checks?
> As it stands the commit message claim that this makes the driver "bail out
> of ch9200_bind() on failed writes" does not seem to hold for actual
> transfer failures.

   I'm getting bored...
   If any *human* maintainer insists that I merge the 2 patches, I surely
will... Or maybe I should resubmit both against net.git (net-next.git?) as
a series?

[...]

MBR, Sergey

