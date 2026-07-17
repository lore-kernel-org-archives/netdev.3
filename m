Received: from shout02.mail.de (shout02.mail.de [62.201.172.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361C2931DD
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327702; cv=none; b=IllM/isMuN/FYUx4l/czDn7jpOKkKmt9I626bN6tS4K7MqKjlisdt36Oq7R2XEB1SCT91N84clCU8NPRbMkdQ7VwXPXivKXs3h6tpTDAKF/qii/re+YxboRSoTsz4G3Pg4+CJ2cN+HUMPln6Or5AuDfh6CJ5SVzqbpuJD6ppYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327702; c=relaxed/simple;
	bh=8NotQG4CdBWPtqavS/2a/7gHmyZgPsMAHGrE4C+Hvew=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LxSRzq68If1GWlofA1D9pKypB1gDThJ3Ip1AbgufeRu8ErupPylc4TRyaekoP0ucsEg2KKHjDWq5yblIP+Yno9ASZ8l8CKSbbag/Egup/avXrT9TnUaxwATe8qI5P/XGo4IRmRnD6rkgiz/t2dqiB0mbbmbXMK9ky5jxC1jzaGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=okZWGwSH; arc=none smtp.client-ip=62.201.172.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="okZWGwSH"
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout02.mail.de (Postfix) with ESMTP id 151162409A6;
	Sat, 18 Jul 2026 00:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1784327693;
	bh=8NotQG4CdBWPtqavS/2a/7gHmyZgPsMAHGrE4C+Hvew=;
	h=Message-ID:Date:Subject:From:To:Cc:From:To:CC:Subject:Reply-To;
	b=okZWGwSHB9UE0BeS7rcmVehybth3H1kOqHYhd4ShCYr0BDNZNui8gZRGzteL4OXrg
	 nd+yclzAUoRDphJlUTbcwO9W2k5/OEzOYI/cDRFNSpM/Sm72a1Hqu6+4sjAXoi98kG
	 1H7xVvL+AnZFjzY6gcRHEs3L8m6M2ZID1APlCjyn8ViJS0dZveFM+Fg9qYwPBSfkmz
	 TL3x2pz7amBpv0Pz0MVP1TzJmwCzHXhNjD+QW5HQGdqlfT04TxIXwJLhDkiyp7bpX4
	 rS33z8DdsW4EHRgqFHZ/6hvum3E2FBLb3mFf6IXIXPTr5xge4lPtBu0QlO905BkyGw
	 tseLGOHuY/DQQ==
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
	by postfix02.mail.de (Postfix) with ESMTP id E62BB2400F2;
	Sat, 18 Jul 2026 00:34:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id E6811240617;
	Sat, 18 Jul 2026 00:34:51 +0200 (CEST)
Message-ID: <b0769446-5817-4330-a0d2-6205169b8646@mail.de>
Date: Sat, 18 Jul 2026 00:34:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
From: tresonic <tresonic@mail.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 rmk+kernel@armlinux.org.uk, kuba@kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
 <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
 <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
Content-Language: en-US
In-Reply-To: <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 416
X-purgate-ID: 154282::1784327692-0BC62780-CAF7248D/0/0

>> But i'm also having trouble finding where dwmac4_disable_dma_irq() is
>> actually called. It is called from stmmac_disable_rx_queue() and
>> stmmac_disable_tx_queue() but they only seem to be used in the XDP
>> code.

Afaict these are called through the stmmac_stop_rx macro which maps to the function pointers in dwmac410_dma_ops.
So this actually gets called from stmmac_suspend via stmmac_stop_all_dma.
