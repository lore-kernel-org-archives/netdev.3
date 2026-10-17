Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACE4F5E0;
	Sat, 17 Oct 2026 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792218591; cv=none; b=IKumAZnUsCxVCvNOIjegLQGY32xoR9Kwj/qZW5XjUg3ZOU5TDTKUb6eC5sHcACWcfyIINFKEz5tFZWEy6JvOhwwmtBqJErsQ1DL6CW5HNWFsLGatYWUEFAqVz86TFoLZhTA2QPYFbtbcvTXakFTNMumy6JrzMtLHSD2+T8jYZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792218591; c=relaxed/simple;
	bh=kJURZ7e1xPCJy+mm3beZiyquZsemz22oiLFYRgkcK8s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VAOVxkebd9jUXpX6uajvyQnapoBSlx7oXT6WwRu7BUHl5RYvX8fH2vBHF6AV4EECHzJ7A6S9CQRN4YkuopuxF+XaIFfghoLvNvA6NV23NiFQ5VS/Y3ke+yuH1n/qAd1kp1xTQx5sK0oQsee/NJ96yUkfLGkjmn3lriBKbKOvxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Ld9YwnRB; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Ld9YwnRB"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B611EA1545;
	Sat, 17 Oct 2026 08:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792218587; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YkvrIbXSeJ4tHQ1/ngybmSshgi3TCb1zruHIEcBWitw=;
	b=Ld9YwnRBcUtmKsW+6eZIKW+FTWboK5aOf4fEzD9H/a480fBasGLKeXeRVJEAE8n7lUoJKD
	fE/X4j3h4sMl4oIF7PfjNWqxF+ePAbasqi9Cs3ep53NzLFqRArbiXiGXKPEth1niBdCgYQ
	zZ+3ag3GH9+445D2en85bUenoUluBarODU+jFQT6OcydkxP8ZS6EsMBnpWNK5UEGffG5Gq
	Jq/RnNIaaB5yOuj9wAVzCg1pBYcfUxEr6jMeuBXV82Eadqb4wdvCU3O4bh/O9EMz1TXqOZ
	P50akyhcYBm0Aea31X6Vr/JrPESpUqY37oaJth0+NT30Qdc4uTv8rYEqfo3fYw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 08:29:46 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v5 6/8] net: bcmgenet: pad transmit frames out of
 the packet ready window
In-Reply-To: <20261016182508.1100f391@kernel.org>
References: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
 <20261013-nb-genet-mtu-nn-v2-v5-6-076b6fc240be@tipi-net.de>
 <20261016182508.1100f391@kernel.org>
Message-ID: <dfbf28fcdac98687ab0bb49377657ed3@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 17.10.2026 03:25, Jakub Kicinski wrote:
> On Tue, 13 Oct 2026 16:20:35 +0200 Nicolai Buchwitz wrote:
>> A frame that ends a few bytes past the transmit packet ready threshold
>> stops the transmitter as soon as a shorter frame follows. Tx DMA then
>> refuses to halt, so every later bcmgenet_init_dma() fails and the 
>> interface
>> cannot be opened again. IP fragmentation generates that pattern on 
>> every
>> datagram, full frames and a short tail.
> 
> This is really odd. Sounds like the IP can't really support high MTU
> properly. Should the user be somehow informed that the driver will
> append out-of-spec bytes to their frames or better still opt into
> this hack?

Fair, I don't like it either. In the last days I learned, that the bad
window is exactly one 64 byte DMA unit wide, so it smells like packet
ready and end of packet landing in the same transfer. Splitting the
frame over two descriptors probably avoids it and leaves the wire bytes 
alone.

In v6 I will do that and drop the padding.

Thanks,
Nicolai

--
pw-bot: cr
