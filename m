Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E1329E44;
	Fri,  2 Oct 2026 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953238; cv=none; b=GmpPNsBY0lg4BQ3NPnheuoSVhuzHeucHaqw7FkQiBxxJlgw5QSQDxRRg7TAAl1XJK+B/ap2Nx00itFqPkkNAVvp+M6NmxNWO8B9x9aoacnm1mzis41/PKAeuPZM0IzXBRfAdDJi+Q1rxlApW1OCNi295TzTB6aMHkSyP6A+4VNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953238; c=relaxed/simple;
	bh=k+LnDfVOwdwPLG685fl0/2LQDwYUmMLSJOta84dL5zg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IepF4aeftJyVa+2JboC6puWE+sAmwWqvQ/g2bd5n/nT29G++WS6ZWIB5kHFHbnb1apznf3rauaOzQAUPLC8DmtWiXzk4if93qJJUCEX3TpYGqJgoevuIq7FO+J/Lt0TzXYa9aRqpxNvckE2rP8SwkbsnAjRMwsWG9udZnIwsXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=QhT7Di2l; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="QhT7Di2l"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D32BA4A31;
	Fri,  2 Oct 2026 17:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790953231; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+nB922UuEUa2aNvfZ9Rwg8/9ZbT8bdXDl98KbCYYgE8=;
	b=QhT7Di2lnErJEzqLGduQsyEl+eHO+0csh4NCW4kZysU/Mj0uSE6jZNAI7W7U6Q1oYIh25Z
	7EQLOwIP/sszABElfYq5GK7uW6EYoLKRskLYBb9orROTdcpEHgtOp9YhmE1oth19mBJKIo
	LhP5A+NVs8I/F18WpXyf7FbbqGNn7ydQ8W1mYwtjN9uRdcCIxm9LXnXbowcDXi1t4Ij/gG
	3t8aMnf9DQ29mRDZ3OC+lq5G00qt/darj58n0m2MpCVgROsj8kzqRVOctqwnNF45k1sfdL
	pHre+lb3191ttz9CHy2+yHO3c+XE4n9NlMGE13DCoT5a6UR6saDEiZ0PrDRIpQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 17:00:31 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Jitendra Vegiraju
 <jitendra.vegiraju@broadcom.com>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Peter Robinson
 <pbrobinson@gmail.com>, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Introduce a helper to check
 RSS support
In-Reply-To: <20261002142806.1299041-3-maxime.chevallier@bootlin.com>
References: <20261002142806.1299041-1-maxime.chevallier@bootlin.com>
 <20261002142806.1299041-3-maxime.chevallier@bootlin.com>
Message-ID: <cc63835ed924d0e1c10ec89c7621159f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 2.10.2026 16:28, Maxime Chevallier wrote:
> The RSS feature is only available in stmmac if the hardware reports it
> through the DMA caps and if the platform glue sets rss_en.
> 
> Introduce a helper that checks both.
> 
> For now, no platform sets rss_en, but there's interest in the topic so
> leave the door open instead of dropping the feature altogether.
> 
> No functional changes intended.
> 
> Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
> Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
