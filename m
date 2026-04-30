Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190033F8B7;
	Thu, 30 Apr 2026 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777520171; cv=none; b=FjES8yYN3EajrE4Tfc+M4Lu3r5cSeWQf9d/pnYRkNrc3rEN3DqCt7+xB+Wbk3KgIWZy1C27sPbeEQyqccixhtc31wO4SRhLMwGJ/bI1Bn/2qVay9Zv72Eqju7cahB+ZA2c1Yk09R8Mxh4mpZtQtcAiHc3rfmtmPtippmKagvq88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777520171; c=relaxed/simple;
	bh=EIUMW64YKkUisB9NbevCUPaNeOj2VAwAD+WcETLnVtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evrXuVTCe9H+gFadMWXHl5geKAkivLcnXUE+Kf2tBsIMArXb3JHOSGUgYQLx4P5/Y4QHCw3k88Bz/tUTYHLS37pDLdUp5SxIZE/h+4PyQNk6lN8YCPX9t+Pm8f9/tx+W8DNzWE/m+bTVwOLMheETUI7vjvBx+xuQXuDThR0+Eh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=bEkELu4E; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2W51MmQB; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="bEkELu4E";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2W51MmQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777520167;
	bh=EIUMW64YKkUisB9NbevCUPaNeOj2VAwAD+WcETLnVtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bEkELu4EAfFMVhP7kv1HqeWUB2ccMDO8x/VrwsNl9MEkn8cFpNR8zN6I6YVxEHl2l
	 +weKFZdre2ocRFlPHPv6baUZoZ8n+s+WU4HUpl5LFpFLRzDQkr2/JHTj/mJvbk/utk
	 HVOIihOWkkU+n7YsL1wRp/PlZQ076nH2/lUjAJNo/+5FkUfpTxCHb5kXoWXsn7/111
	 tNzyQLH/BrMp1CkCWxA+02grTO3GSCMskRxwf2aoOgZXsCr4OWiP/AKFFoQ5xJO8/7
	 z0DhtWq32RqBc30qfjegI9lXaZ10N6fhaAJ3vk+Dw5dkV/vTnPpgd4QoXuJsM/AfBh
	 YFq62B/IsyQEg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id ADFC3481AA; Thu, 30 Apr 2026 03:36:07 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777520166;
	bh=EIUMW64YKkUisB9NbevCUPaNeOj2VAwAD+WcETLnVtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2W51MmQB8PE+EPxE96FH8+y5vBnVIPc80RmXbBnJ/+8B/sSATeLEddHOzjVqghI2A
	 BTCddOrifCE1x6VhzoBSzYvBJGwn1VzeeEPUK7VGVeH9tl0e3VlYWWD/6Zzel3iXtO
	 hZViE5JOGjMO4m2U5iZEazEYutRJzS40dm5VEY3kHZw4KrRZNlV8ORgrQsqW0v8yIg
	 ErR2NkrDhp3eVh09nX4zb0B3mtVFy7O1ewnRUHmg4r2v4J8RAQNS6wa04Ipuyl0vvE
	 DUsjnpzpLBw10xOee9oq1ZVCUoT1c18mBx2ngmkC5SmUpvcWhC2OR82YQMSR5vCyTf
	 QEbsUAVlUFjcQ==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 820E841264;
	Thu, 30 Apr 2026 03:36:06 +0000 (UTC)
Message-ID: <4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>
Date: Thu, 30 Apr 2026 05:36:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
 <06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
 <9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
 <20260429200214.3e8dee67.michal.pecio@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260429200214.3e8dee67.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Michal, for your explanations!
On 29/04/2026 8:02 pm, Michal Pecio wrote:
>>> What does interrupt mitigation do?
>>>
>>> Is this a different name for interrupt coalescence, where the MAC
>>> delays interrupts for a period of time so more packets are in the
>>> receive ring when it does interrupt, so reducing the number of
>>> interrupts, and bigger bursts of packets are processed at once?
>>>    
>>
>> I do not understand what the mechanism behind this is, there is no
>> more documentation in the original driver. I experimented with this
>> for some time and the effect that I see is that it prevents
>> interrupts after shutdown.
> 
> What do you mean by "after shutdown", driver unbind? You shouldn't be
> seeing URB completions then if the disconnect() method unlinks them.
> And if it doesn't, completions may be using driver data after free.
> 
> Or maybe you have pending URBs while calling set_configuration() or
> set_interface(), which is dodgy too but at least not asking for panic.
> 
> Other cause of ESHUTDOWN might be serious host controller failure, but
> you would likely get other log noise with that, at least with xhci.
> 
> What shows up if you repro with this enabled?
> echo 'module usbcore +p' >/proc/dynamic_debug/control
> 

With shutdown, I meant shutting down the driver: the error happens when 
unloading the driver using rmmod, e.g. when testing different driver 
versions. What I see when turning on debugging is this:
[373042.499758] r8152 2-1:1.0 enx88c9b3b53125: carrier on
[373104.440114] usbcore: deregistering interface driver r8152
[373104.440141] xhci_hcd 0000:0c:00.0: shutdown urb 000000005501f8cc 
ep1in-bulk
[373104.440146] xhci_hcd 0000:0c:00.0: shutdown urb 0000000066ae4a92 
ep1in-bulk
[373104.440148] xhci_hcd 0000:0c:00.0: shutdown urb 00000000e9728025 
ep1in-bulk
[373104.440151] xhci_hcd 0000:0c:00.0: shutdown urb 00000000fa874ca0 
ep1in-bulk
[373104.440153] xhci_hcd 0000:0c:00.0: shutdown urb 000000006006ed5d 
ep1in-bulk
[373104.440156] xhci_hcd 0000:0c:00.0: shutdown urb 00000000a5bee1e7 
ep1in-bulk
[373104.440158] xhci_hcd 0000:0c:00.0: shutdown urb 00000000bc3a3ab0 
ep1in-bulk
[373104.440160] xhci_hcd 0000:0c:00.0: shutdown urb 0000000080a63692 
ep1in-bulk
[373104.440163] xhci_hcd 0000:0c:00.0: shutdown urb 0000000025af4e6e 
ep1in-bulk
[373104.440165] xhci_hcd 0000:0c:00.0: shutdown urb 0000000056d7e76e 
ep1in-bulk
[373104.440472] xhci_hcd 0000:0c:00.0: shutdown urb 00000000d8814536 
ep3in-intr
[373104.440790] r8152 2-1:1.0 enx88c9b3b53125: Stop submitting intr, 
status -108
[373104.479779] r8152 2-1:1.0: rtl8153_unload called
[373104.534682] usbcore: deregistering device driver r8152-cfgselector
[373104.534704] r8152-cfgselector 2-1: unregistering interface 2-1:1.0
[373104.534826] r8152-cfgselector 2-1: usb_disable_device nuking non-ep0 
URBs

In the past I have also seen the following, but am not able to reproduce it:
[371283.534041] r8152-cfgselector 2-1: USB disconnect, device number 25
[371283.534470] r8152 2-1:1.0 enx00e04c680023: Stop submitting intr, 
status -108

Also, I only see the issue on slow 5GBit USB-C connections, sometimes 
with the RTL8157, basically every time with the RTL8159, and so far 
never on a 20GBit USB-C connection, so the mitigation is probably some 
kind of interrupt coalescing.

Birger

