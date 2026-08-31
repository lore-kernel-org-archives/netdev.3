Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC33BED30;
	Mon, 31 Aug 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192233; cv=none; b=i9qPGNU4fRh7700/Z0XkiOA0YOhUiF4i20HG9oEG9IVV+CSzSWQXfvu/eD4L5Ao/rJU8IQZxNVOTi+ufpOKtIjfvkeFueoQxnD4Wutb4+yysChLGw6UwTNNyI6wG9UOk2pszB+C3AvQ8AzGddp5fHxXS4UjZBSRRHw0yRdbsqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192233; c=relaxed/simple;
	bh=iu2xRQDwbrZbuhsKydR44Ey/k/7LXVHvnC2Z96F7B20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty1PPsKpR+An0+3ujrc1UugFmoIBbf80I7e6KqiAwoClw/dUfaipclMXVuKz04z6V+HBM79NYdMNs4A99bb8Sfa2DXAg8NAsAxauQBTwrfscPZy4bn2aMb/7btd/HHM4nsAgeG+Df5IQi0QNa7o++FH4EnMAx/0WwV2h7OTHyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=g+4h03cs; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=g+4h03cs; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="g+4h03cs";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="g+4h03cs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788192229;
	bh=iu2xRQDwbrZbuhsKydR44Ey/k/7LXVHvnC2Z96F7B20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g+4h03csre1RVWFtS1jpPRXdF/qBcvxfVCNFi5g0HujUtOQ4TT7IeDfAf0Zko8UDI
	 8UFR6zoPOevDz2VCfyHF7spTUqXgbHsGxWM+14VtYAcB54PZhR9aA63iGvkXoFJurJ
	 ne/LWR6WcXutRptR4pnTo5QHFWRUtVMvWhUpAWY7zoM14e2ZhceFIg47U/coMLSFvF
	 ZaO/LOSaIOD3gpagQYGRRVZRyfJ/SGAYl58Foa2oFoPkNVuQOFc9YCpJAxwQ09kuIC
	 B4qL0gVxIdz7avfK5xLHSefhnB8puy/s/fPuM8INfJBtI3glFO4e9Sle3MSHLBg4eG
	 DbvhipXOFuQHA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id EB9F13ECAC; Mon, 31 Aug 2026 16:03:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788192229;
	bh=iu2xRQDwbrZbuhsKydR44Ey/k/7LXVHvnC2Z96F7B20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g+4h03csre1RVWFtS1jpPRXdF/qBcvxfVCNFi5g0HujUtOQ4TT7IeDfAf0Zko8UDI
	 8UFR6zoPOevDz2VCfyHF7spTUqXgbHsGxWM+14VtYAcB54PZhR9aA63iGvkXoFJurJ
	 ne/LWR6WcXutRptR4pnTo5QHFWRUtVMvWhUpAWY7zoM14e2ZhceFIg47U/coMLSFvF
	 ZaO/LOSaIOD3gpagQYGRRVZRyfJ/SGAYl58Foa2oFoPkNVuQOFc9YCpJAxwQ09kuIC
	 B4qL0gVxIdz7avfK5xLHSefhnB8puy/s/fPuM8INfJBtI3glFO4e9Sle3MSHLBg4eG
	 DbvhipXOFuQHA==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id DF67D3EC8B;
	Mon, 31 Aug 2026 16:03:48 +0000 (UTC)
Message-ID: <540fabbf-2f28-48bc-b765-e865de854401@birger-koblitz.de>
Date: Mon, 31 Aug 2026 18:03:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
 <20260831-ax88179a-v8-6-de905f2ee426@birger-koblitz.de>
 <af3f05e6-f5dc-459f-ac2a-5e7aedbf8ba3@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <af3f05e6-f5dc-459f-ac2a-5e7aedbf8ba3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 4:30 pm, Andrew Lunn wrote:
>> +static void ax88179a_status(struct usbnet *dev, struct urb *urb)
>> +{
>> +	struct ax88179_data *data = dev->driver_priv;
>> +	struct ax88179_int_data *event;
>> +	u32 link;
>> +
>> +	if (urb->actual_length < 8)
>> +		return;
>> +
>> +	event = urb->transfer_buffer;
>> +	le32_to_cpus((void *)&event->intdata1);
>> +
>> +	link = (((__force u32)event->intdata1) & AX_INT_PPLS_LINK) >> 16;
>> +
>> +	if (netif_carrier_ok(dev->net) != link) {
> 
> phylink will not like this. It is supposed to be in control of the
> carrier.
> 
>> +		usbnet_link_change(dev, link, 1);
> 
> This also seems to change the carrier under some conditions.
> 
>> +		phylink_mac_interrupt(data->phylink);
> 
> Is this not sufficient to make phylink change the carrier once the
> status has been read from the PHY?
Yes, indeed. This is actually the only thing that needs to be done
in ax88179a_status(). Will fix in the next round.

Birger

