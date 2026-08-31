Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7543F1ADA;
	Mon, 31 Aug 2026 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170716; cv=none; b=ksXcs8pRv5ojRwK+4kppF7++Eew2ZT/4trU+Pkquo8+Vj2J2WeARg/58NtEqaMr/7BQpeN9st0PmI5U5mvTRIelT5bYdfKooBFSSsbt5tTOx7H4bpZ9EDhra+Cu9u/q91I/cW85obRPOYVqLtS6E1raeS7D/yQss7Tkrr5ufiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170716; c=relaxed/simple;
	bh=jXsbeuFI30h6iDLIDYk7FOAO5bTZkbeOult9tyW5+Hs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lTBp4VGuD4vkvNYP2r835srRKXI3K3BPGRvWulxdDiKXq1pOJ1p/iZ8jXLBoadSE3PCxgGyKwMEbjTGmrmKHoT87kuXiS0mMz9bk04OoQGgPmOIstPNo8XQVpKVcvKw1tdkDgVvsW5AP6Fz90uRu9xZ1hpQOt+aeYRAztE8g8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=s13BgZQ0; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="s13BgZQ0"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72DF4A4186;
	Mon, 31 Aug 2026 12:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788170702; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FoLv7LEjxARYAKAq9uH/3qq6k22KMG9MkYq2nCuUQcg=;
	b=s13BgZQ0rECSqEiblradKykwAmrKRTOaxOWXrnlQ1K0hOH5hRj/gimtEFZcGV3WHG3LyU9
	N1mKXSDXS4Q71wA3/zseAs3i1AdzLmWShOdLf8odYRxr3GCfj4/miG1Cs8wTXBLYn0LtY9
	YWOP/eWZYbOs9AsiJM+cDJK+eJcE8UnGldIm6AeXF8LCZi2jxiGG36OXL1kYL9EowHyMrI
	1+BqLtxy4LSPOllCfsRd0t1JGZDPfU3MoTvQwxLDoRnSb6i6fbCTdbawoWB9P4x/iC3PWZ
	aQ7ECBdtKjjPkBwiV4TQRUSbuIkeAlqfMKeTVESob9EC2UADB+cSOGN0vLb+0g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 12:04:59 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Conor Dooley <conor.dooley@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jonathan Bell
 <jonathan@raspberrypi.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: exclude software FCS from TX byte
 statistics
In-Reply-To: <20260828140242.7c78d4cd@pumpkin>
References: <20260824134703.766708-1-nb@tipi-net.de>
 <20260824134703.766708-2-nb@tipi-net.de>
 <20260827115601.6bf0b18a@kernel.org>
 <36165fe4a906b07dd9f92a73a72a05f1@tipi-net.de>
 <20260828140242.7c78d4cd@pumpkin>
Message-ID: <fa6aacfb1ed9caaad5370acab5f12de2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi David

On 28.8.2026 15:02, David Laight wrote:
> On Fri, 28 Aug 2026 10:20:24 +0200

> [...]

>> > Either way, you only need u8 or even a flag for this,
>> > not a full u32?
>> 
>> Agreed. skb->len at completion should already do the trick (minus
>> ETH_FCS_LEN).
>> So a flag would be sufficient.
> 
> If you make the 'flag' 0 or 4 it will save some maths (and maybe a 
> branch)
> in the completion code.

I will make tx_skb->fcs_len hold 0 or ETH_FCS_LEN directly, so 
completion becomes
a skb->len - tx_skb->fcs_len. Anyway, I will split the patch into its 
own
as suggested by Paolo and you.

> [...]

Thanks
Nicolai
