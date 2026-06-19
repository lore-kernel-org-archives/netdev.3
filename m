Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D9EED8;
	Fri, 19 Jun 2026 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854803; cv=none; b=tImK3qNDPoZpg4wiRQIPYeJGe6nCcTmuup4MTnfSQNWS4dCfz2g17IGs8JKyobnjTFKj40Ud3Sj6OdkjHMnPnmc9/RrVmkv0fwaX0yKVTQr8YV4hh9BXe2exQ1r3DL3OmeDyZHaRREurovYCDZ/R8nJxfGl6Yix2ALpjpu0n7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854803; c=relaxed/simple;
	bh=b6TPHQRuqZR4c7BToY2SyoOs8RSVriP8oHPVkCUxoqw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cJ3tsDolvMsX6fiT19ir+rpDWVu4FpVTUQdK1AFK4nhwomBcBY/2rMRw32N38Wq/kfRZWbIBoyHUTcx+awM9KFG3GleAzk9wVlwWf4exBpm1KLOqjdk74MVDUz7YJAbqaJZo6kI37k/jLkZrGopm2Gy1oIgx927ABS4TSkkpivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=qjewW0t1; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="qjewW0t1"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED8D2A3F88;
	Fri, 19 Jun 2026 09:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781854796; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4p4Y6WbmGM6SMda6SpZT7a84alwNhxR4Wy40ZV3+bm8=;
	b=qjewW0t1zJDFTwlhI+N8vhSyyfjwpD+4QboNyjzo9CRm+THyWm5+e5ypPccEO4ED2aCh8U
	VAQNf9YWhYNn1wtaBxUiQA96pn9T1Pk4ehDzI+lD45mArtx/xQ0+bv03L3qmCnpmTLAKqD
	1Qj9V3xPLPK4Bkwzo+qK3ckWyqTx0Hz4OFX1JIMgwdSrxeLELxnr/zeLf869nWYEVxn4ek
	IAT5ZWsBczBy1bxTxemEwc52qe3B0PcvT9rejYvdkPfn+BNquFF/9yJccBeJTes9bsbCk/
	FmlGUep8JuFQrj50rwv6jih761uFopwThuCW2EvF/HOshptevpvx+vhhDFPHng==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Jun 2026 09:39:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu
 Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Lukasz Raczylo <lukasz@raczylo.com>, Steffen Jaeckel <sjaeckel@suse.de>
Subject: Re: [PATCH v2] net: macb: add TX stall timeout callback to recover
 from lost TSTART write
In-Reply-To: <ajTtF2xy3WS6NfBi@apocalypse>
References: <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
 <DJAKGHKZGUI2.29AHYNFX4LGBJ@bootlin.com> <ajTtF2xy3WS6NfBi@apocalypse>
Message-ID: <9dec2aa9fc7669a1f86ceb1c2c9de68e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 19.6.2026 09:17, Andrea della Porta wrote:

> [...]

>> Any news from the Raspberry Pi community about this bug investigation?
> 
> Not from my side, unfortunately.

If I remember it correctly, the downstream kernel carries earlier 
versions of Lukasz patches,
which he also submitted there. If time permits, I will run some tests 
with mainline kernel
on Pi5 + downstream kernel with reverted patches + only the upstream 
patches.

But realistically this won't happen before end of next week.

BR
Nicolai

> [...]
