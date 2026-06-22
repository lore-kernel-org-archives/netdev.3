Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97D3491D0;
	Mon, 22 Jun 2026 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124445; cv=none; b=Zv3f5T2mYWuEy+LvJc2GufnbFVKwKS5OKvPWd9sBCwP+sLuuZCuOMq0yW5xVDLBEu6hTk6DeyJEk5yBNCiSbuYjZHT20KuFDQzfv6nouJ/xQ0rRQldvpz6WZZPoMo9Jta5m6JvUKAE/4XG0Q8hzBdQ05Ovr962KUAUcrzOLTUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124445; c=relaxed/simple;
	bh=dLWCFMXElJAimOVvnulujwYsPKAab/rtBHijkyJGNfM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aJGz+HahUT/2Jcabc+5Yjw/LB3819gUbcp7FXuly1cvaHlRPIafmvPP/qynYYiDioFG4GvEMs8nFyTlwzXHpxLDlrJAMeYq9SXWnKbt06TDBF2BSfVT9S6P9r15MF+tgcH9/0cci4IhQttk601/+StZs2RiVIGY2KH1MklF6g+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=vSbDrnBP; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="vSbDrnBP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD3BAA02DF;
	Mon, 22 Jun 2026 12:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782124441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dx/B2m4epnkAcHaC7egWzuokCQWHPyJnQKfGd2yfeTY=;
	b=vSbDrnBPqo5QeqIpa+C+G7d7FrD6k2Ox/Xymoys4Zuq8QzL5wFxjOw8SO0I2VXLMf8gJly
	JPluI1++N1vVPhcqr2BS2me6QTORRUkrL8yvUYNTpKvueFDwDl4LehXeurCtbywV37BpCl
	STaQhm6AZu+ubiFr8Tmaqb+ZkEvddyv1s57QWfqKQFhA+81yt3zpGa+ZZnaufjXROzwtyM
	B19zaTfQBo+I+FIsSZee7IKlF0ZK0gm9NwE95PmoiSygtuGsj+HuYFOyl2k4y+szQt5P8t
	1jBxpPkxuOi+GqEhhbtPYsMM3HFX2xs5Dz2UZN8QI0VuY9jaGir/Dn6GwD1Aag==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 12:34:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan
 Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: AW: AW: AW: AW: [PATCH net] net: usb: lan78xx: restore VLAN
 filter table after device reset
In-Reply-To: <BEZP281MB22457C80F9D1AC7F788EC008D9EF2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <20260618191109.4086598-1-nb@tipi-net.de>
 <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <6d638042ad07a8bfb09ff3ee923e7b3f@tipi-net.de>
 <BEZP281MB2245422BB9FBFF4AFE081451D9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <4abfc9b1e8860da93c03639863bd0232@tipi-net.de>
 <BEZP281MB224523ADACDB48D8E3974D4AD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <f76711d2f45c527f9ce0f5d288631bc6@tipi-net.de>
 <BEZP281MB22457C80F9D1AC7F788EC008D9EF2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Message-ID: <3964f6655b98681b9aab92593b5ed3ca@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Sven

On 22.6.2026 12:07, Sven Schuchmann wrote:

> [...]

>> > looks good from my point of view
>> > (Calling the lan78xx_write_vlan_table() from
>> > lan78xx_mac_link_up() and from lan78xx_reset()).
>> 
>> Thanks.
> 
> Just to be clear I used this patch which is looking good:

> [...]

Thanks for testing! I've sent a v2 of my patch with your t-b:
https://lore.kernel.org/netdev/20260622102911.484045-1-nb@tipi-net.de/

Regards
Nicolai

