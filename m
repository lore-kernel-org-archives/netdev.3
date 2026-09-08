Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFF4349B4;
	Tue,  8 Sep 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896978; cv=none; b=V8sV5CSq/4BH2jIY4sdQSWWCkxpcW2Ooyvxq4oW0KBTG1R+LqJFhqN/p4EZSucb5COb7cIaVrImhACt+wcxEmIvPZQVIJep6ajsyzdFQj6NxhUjQkAIDkF2TBNRNipeJvlZdC6Oma2luVPL232/f5d3hq68IR1pCdrPl6+/kl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896978; c=relaxed/simple;
	bh=QdTLUrQyznvfl3CCE4Wdr8mDYMmo9yp6WP6VvNi8nLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YioJJngWd3R4w39X2cPooVlg0ZhwM0hA79AV7IrBPPF+hZJrtzbH0bIhc1t/B2PJwJDoKkzfZ7OnNe0tl1ZzMdMgQj40fyz55YH2fZk1zzh6CxHf7myaUQyvN3BEYRm61wTANPaAL9n8p2dmk2LwLP6SGFs2ZLwRBjTWI9MB5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.10.90) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 8 Sep 2026
 22:49:22 +0300
Message-ID: <62ea73d2-cb7e-42b4-8008-378a226a1c96@auroraos.dev>
Date: Tue, 8 Sep 2026 22:49:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net RFT] ch9200: do return USB errors from control_write()
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-usb@vger.kernel.org>,
	<netdev@vger.kernel.org>, <mjg59@srcf.ucam.org>,
	<linux-kernel@vger.kernel.org>
References: <20260904200108.85165-1-s.shtylyov@auroraos.dev>
 <178885449964.219967.4487690524073410201@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <178885449964.219967.4487690524073410201@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/8/26 11:01 AM, netdev-bot+sashiko@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> - [High] Incomplete fix: control_write() in drivers/net/usb/ch9200.c now
>   returns the real USB/short-transfer/allocation error (negative errno…

   Allocation error (you mean -ENOMEM?) was returned before this patch...
> --
> 
> ch9200: do return USB errors from control_write()
> 
> The patch removes the unconditional "return 0" from control_write() in
> drivers/net/usb/ch9200.c so that the value computed from usb_control_msg()
> (and the -ENOMEM from kmemdup()) reaches the callers.  The commit is tagged

   Error from kmemdup() surely reached the callers before the patch...

> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices").
> 
>> diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
>> index a206ffa76f1b9..3a81e9e96fd33 100644
>> --- a/drivers/net/usb/ch9200.c
>> +++ b/drivers/net/usb/ch9200.c
>> @@ -168,8 +168,6 @@ static int control_write(struct usbnet *dev, unsigned char request,
>>               err = -EINVAL;
>>       kfree(buf);
>>
>> -     return 0;
>> -
>>  err_out:
>>       return err;
>>  }
> 
> [Severity: High]
> The commit message says the intent is to "propagate USB errors to the
> callers", but do any of the callers in this driver actually look at the
> returned value?

   Well, you're correct here...

> There are only two call sites.  ch9200_mdio_write() is the void
> mii_if_info::mdio_write callback and drops the result completely:
> 
> drivers/net/usb/ch9200.c:ch9200_mdio_write() {
>         ...
>         control_write(dev, REQUEST_WRITE, 0, loc * 2, buff, 0x02,
>                       CONTROL_TIMEOUT_MS);
> }

   Indeed...

> so the BMCR write issued by mii_nway_restart() from ch9200_bind() still
> fails silently.
> 
> The other call site is ch9200_bind(), which assigns to retval six times
> without ever testing it, and then overwrites it one last time:
> 
> drivers/net/usb/ch9200.c:ch9200_bind() {
>         ...
>         retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
>                                0x02, CONTROL_TIMEOUT_MS);
>         ...
>         retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FIFO_DEPTH, data,
>                                0x02, CONTROL_TIMEOUT_MS);
>         ...
>         retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
>                                CONTROL_TIMEOUT_MS);
> 
>         retval = get_mac_address(dev, addr);
>         eth_hw_addr_set(dev->net, addr);
> 
>         return retval;
> }
> 
> Since get_mac_address() returns only 0 or -EINVAL, doesn't every newly
> propagated control_write() error get discarded here?  If the three MAC
> address reads succeed while, say, the MAC_REG_CTRL write fails, ch9200_bind()
> returns 0, usbnet_probe() only aborts on "status < 0", and the netdev is
> registered with MAC_REG_CTRL, the FIFO depth, the threshold and the flow
> control registers never programmed.

   You're correct again...

> Would it make sense to add the call site checks in the same patch, e.g.
> 
>         retval = control_write(...);
>         if (retval < 0)
>                 return retval;
> 
> otherwise the error swallowing that the Fixes: tag refers to stays
> reachable and the change has no observable effect.

   This was done by another patch:

https://lore.kernel.org/all/20260903201842.62338-1-s.shtylyov@auroraos.dev/

> One related detail for whoever adds those checks: on success control_write()
> now returns the transferred byte count, not 0, because the short transfer
> test leaves err == size untouched:
> 
>         if (err >= 0 && err < size)
>                 err = -EINVAL;
> 
> So only "if (retval < 0)" tests are valid at the call sites; a later
> "if (retval)" check would abort probe on success.  Would it be preferable to
> normalise success to 0 in control_write() instead?

   You're correct again, I was sloppy in the patch I just linked to...

> If the intent is only a preparatory cleanup with no functional change, could
> the changelog say so and drop or justify the Fixes: tag, given that stable
> and AUTOSEL will otherwise pick up a no-op?

   Yes, the Fixes tag shouldn't have been there in the 1st place. I'll resubmit
the patch for net-next.git instead of net.git...

[...]

MBR, Sergey

