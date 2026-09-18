Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24134E01EC;
	Fri, 18 Sep 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729219; cv=none; b=EatyC4Snxwd16NdqVa2HDg8XrwOiupiz98nUaquGfnP3nl30QjFDyLKCkVZD3fb0sCogjHGWCBBEf81VGa2FEzZIC9DYfa6CuS9Ek3XEW6cGyxSuvRUAmJ5FrvqA76t2H4bYjMMkNOO8m4/Sg3ju7rDUqDn7/9SkhmA1a9yquJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729219; c=relaxed/simple;
	bh=NS4fGbANKphK6JQB+dGaH5aA7OWUMehYWv+i5//7lQ8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hygMdFUAiCiOIeLF0O2Sbvl8n8H/QZLt/YkfX6YmvL0KafYJIY/9VV/ErBiiDkaoObV28fLZVkleeVs38HRCjybpiExgi2SAIdRRf4XpoZohQ2pP8+vsmEg1HqpkMslHWkMM3f8U+VToq8OA9wbDXYpFoRUGe/VbnL5bukyMvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=sk2hkMkx; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="sk2hkMkx"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E66AEA9002;
	Fri, 18 Sep 2026 13:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789729214; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B5bm9Lnqeni2x171qc2CycGUoE7qJlNcyPEqd/0tD/4=;
	b=sk2hkMkxUM4pqO8H+ytYRovE0BWV0LQyUBWlWfaiLghNTJEX/T4vtqp5Q32X43gqLdV18z
	gWGVNz+ClmrHP9uuOA4dTXtThUrAbC2cZFQuXJwjmVJRqE7SujsDE7NOJYIUuaBopXdWjS
	tc8XmvRrdflTDIL258rJBLrsC1sSEqRWZ/E92CxGbNesleSW60qUTvQcmRfoEoLsFQLa+o
	RbJI/ExHXwJV1V2f/pKicmvyagJ2i7pc/I7oMCdaARFMAvRU/y9mZDkavuMQ1sYfT6Y57R
	uWz8Ov5y8HcvW6ccJJM+pObRF/R7aQylMJPRXfCXu4q4Mh2vqRSYDAbrKLUeWg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 13:00:13 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Cursor <cursoragent@cursor.com>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 6/8] net: bcmgenet: validate Ethernet address in
 bcmgenet_set_mac_addr
In-Reply-To: <20260918000732.276506-7-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-7-florian.fainelli@broadcom.com>
Message-ID: <486f79b9a0435e4cb4ecf2f8657da262@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.9.2026 02:07, Florian Fainelli wrote:
> bcmgenet_set_mac_addr() did not check whether the provided MAC address 
> is a
> valid Ethernet address before applying it. Userspace could configure an
> invalid address (such as all zeroes or a multicast address) while the
> interface is down.
> 
> Add a call to is_valid_ether_addr() and return -EADDRNOTAVAIL if the 
> MAC
> address is not valid.
> 
> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> Assisted-by: LLM
> Co-authored-by: Cursor <cursoragent@cursor.com>
> Change-Id: I1cae9178ff2c9243510556f42a194058c10aea7e
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 799da63e3a4e..90ca4f220cc7 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3635,6 +3635,9 @@ static int bcmgenet_set_mac_addr(struct 
> net_device *dev, void *p)
>  	if (netif_running(dev))
>  		return -EBUSY;
> 
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
>  	eth_hw_addr_set(dev, addr->sa_data);
> 
>  	return 0;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
