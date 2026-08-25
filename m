Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7423643F
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787628862; cv=none; b=iAoOgg+xsS7uRo+KUWieyx72QM7MMmi782KFUTXSjUnrgZjGzuO6Y1z0++T4w7S4CZJRU60AZs7ESuMjTXtsFGcDDmrnJgYmWUTxMD+rhc8FSlO9I/ycTrWindcjR6kMaLoVLbKROUfAQq2T2h3CP25xb71J6jqKYpsWe7hqjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787628862; c=relaxed/simple;
	bh=eSABOAXqj4oWn6u8Az5xzjeD/NF4DiV3b5/D4qwM62U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raplPVLdqAf7Zad82dtNND+vpXPxVJQPyM9pfB7mGIN7Skk84MVHTArhIpVslSo0NVZ1FlfXyEdc/kHCE4BO/GsGeDZ8oyczKzaqeBmLERqS2l/oFflqQVu5cHbGZpRDsA2k69Y5XxYZa8LuCKW5jNi5zRIMk6lGZllRNAdzKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mb8PjUTe; arc=none smtp.client-ip=91.218.175.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mb8PjUTe"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eSABOAXqj4oWn6u8Az5xzjeD/NF4DiV3b5/D4qwM62U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787628857; v=1; x=1788233657;
 b=mb8PjUTew6VWUEKNXhY8FDiHjcUVuTE3G2uCqbLKrA8EHCHH/5Jzuh353uHNxkMF7kyGXK26
 2+fYDrZ90HK4JPzbUPylEWYwCf1ZsuhFO0GL5hYN8Y7g3ywW1xgD3uuS7T9A7xbakQDN0rL0Fs7
 2ZXwj76czkTyyXcCsjz/R2y0=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 6881395ec596a024;
	Tue, 25 Aug 2026 03:34:17 +0000
X-Mizu-Trace-ID: 6881395ec596a024
X-Migadu-Flow: FLOW_OUT
Message-ID: <749d7a16-df31-4bcc-822b-3153fc69d072@linux.dev>
Date: Tue, 25 Aug 2026 11:34:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: fix NULL deref in IRQ handler after
 unbind
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
References: <20260824120703.107412-1-xuanqiang.luo@linux.dev>
 <e289a01b-d0a5-4296-b8b1-9b5935ee6854@lunn.ch>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <e289a01b-d0a5-4296-b8b1-9b5935ee6854@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,

在 2026/8/24 20:54, Andrew Lunn 写道:

>> The IRQ is requested at attach time and released by phy_disconnect(),
>> so phy_remove() cannot free it without a later double-free.
> So this sounds wrong.
>
> If you unbind the PHY, you need to also unbind the MAC, since a MAC
> without a PHY is useless. When the MAC unloads, it will call
> phy_remove() so everything unwinds in the correct order.
>
>      Andrew
>
> ---
> pw-bot: cr
> 	

I agree that the MAC should normally be unbound before the PHY.

Also, the paragraph about freeing the IRQ in phy_remove() was
misleading. It was not relevant to the change being proposed,
so I will drop it in v2.

Do you mean that unbinding the PHY first through sysfs is not a
supported operation?

The same sequence was used to reproduce the issue fixed by commit
c2b727df7caa ("net: phy: Avoid NPD upon phy_detach() when driver is
unbound"), which made me think that it should at least not crash:

https://lore.kernel.org/all/20200917034310.2360488-2-f.fainelli@gmail.com/

If this ordering is required, would the right fix be to enforce it
instead?

Thanks,
Xuanqiang

