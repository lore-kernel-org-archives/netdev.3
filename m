Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B091346AFD;
	Thu,  2 Jul 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988924; cv=none; b=C9jxVWYWwv38JOMuioJdtbp4LFK+uAVFVuFVHsB1fq1zuBqvrsfJcAhLNeL1ap/uuopbX88ogp9IpfeGLOUl5MVdFpRjE75Ajya+mxmDORsSybTkfFuk1ZzgEBkRWIS+iBQw4qwcbCMeiJpVljYAOApnQWuTRu7MbnR7eRwp/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988924; c=relaxed/simple;
	bh=ZTJT2hjndXoRBW42ItThyNmVsx1YfrckV9mCA+ebnUM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SBGE6Oh+XV5RZ0ECj8Glk3v14CmMb8BbYMMtZPZwBvmJicz6g3qa1Bm2H/zsWZXMBn4YXbX/j+afjT4lJO3PKmoaz8WWJGTR8kH+9VdSCGALCFmBnX1iKRqS8zLdIMz07+b9dpmjsDrCHaCREUZEkrcpnGNbQUS0UkWu3f/vTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lerQauZA; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lerQauZA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A69D5A47FB;
	Thu,  2 Jul 2026 12:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782988920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mpu/mcsJSHG2Y3mlE+gvuHm5xxIjonMHnGChU44aj60=;
	b=lerQauZArbl8U1kkGmf4cpgN/GttDQpQyC4AMoIkkTfGNqbBbcO5mHOLFsNF9yrtRCLLeS
	xEsKk/KjxlX7qvG4zPkeGCOryveoxIvqTYV8veGDgjfdWFE7D4lSg4UqfZFLnPmPqarr/q
	GdlhmdRX0TtDoAzPHn40iKB8a/zgJoC3QO8+aRcfi+jagMWNXJlA12bhHkBWVOkNvmFYGq
	UzzVU6SX0MhvpePCZLXi6K7LoEv7L9Cf3wvmbEryc1GAi0adZeIaCez4KyZx01QKANmKie
	pT5z1qrXKIGoZqKUGNp0vm+SbCuRU5WrInFo2UGc8Ah5jzfTFrkaD26xXKoahQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 12:42:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 03/15] net: macb: unify variable naming
 convention in at91ether functions
In-Reply-To: <20260701-macb-context-v3-3-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-3-00268d5b1502@bootlin.com>
Message-ID: <af9c06abe55f09b77df082779decbb15@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 1.7.2026 17:59, Théo Lebrun wrote:
> Follow MACB naming convention throughout on two aspects:
>  - Always name `struct macb *bp` rather than `lp`.
>  - Always name `struct macb_queue *queue` rather than `q`.
> 
> The latter is to reserve `q` for queue indexes.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
