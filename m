Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D5644C4EA;
	Fri, 11 Sep 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127181; cv=none; b=DuLlgzId3vNmfYP4gNyvQLvg6mdfeBbZd6/SbKG4LlvxqyeQ70DLcrf24gQ/2tUN1j71qs4s5ayS5JKRxkX3L9+CC147tuF8SmHpisa8Q1ysEDnIdbcSVNqgWsYxvIKCQFr8p5q/QVcdTObGAfsO2tk7tkMtbpEM9wVOOv13zwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127181; c=relaxed/simple;
	bh=7/ABCwSBwMMpeasUmORhfP164RO5xe82KeiClgrI1pM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GEYTV9j4Pu6Q/K8oahHTuXEmvk2I9qQiaOXQ9VWcvAUPuB2rhLkJpbzhYqaxPVna8Je+QZntJv2K520Dx2y/4jJNmNvD06NO/78GMLESSoc9z6T75FKg2Z/9yKjO0pCntHXgwwvJ99/Crc+TJjlwadn058sQJSvrHGc73/YaTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=UCRBgxNI; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="UCRBgxNI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE0BFA379F;
	Fri, 11 Sep 2026 13:46:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789127175; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zxPnQIazV8qoWcjnPpuJi4EWHSazV4LFn9jV+FJ9yM8=;
	b=UCRBgxNIvFi4YQ5kqI3E7U3tH9OKRHtIRXTa+ItbmNQqpUk/UmPLiTbaEwqJUj9+HGJoaL
	F9Vr4lu4yL8kyCkf9Nevj6I8lZ+JikMUOzPY668hjhkQeyuIS2wMva3NekSPDQJtTpYva7
	TYvhtIbac3o9ua3X3nzV8hvY27kf9WxYUY/6vJNwoosShBmHSDI2xOHgJfX12+ecJUC4rK
	z1JiFMbnXKwvpwm6vSI//RziBmCq+D+hyG6XZit0u30rhd40b7DphbG4OUWkL3aTvN2dxL
	FSA8g8L7pLEXPaunVd2shmIjAOO0jipY+jvM0mDOtXWHyQ9YLhnLx78qxx855Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 13:46:14 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v12 2/4] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
In-Reply-To: <20260911-ks8995-to-ksz8-v12-2-5c3422d0d72e@kernel.org>
References: <20260911-ks8995-to-ksz8-v12-0-5c3422d0d72e@kernel.org>
 <20260911-ks8995-to-ksz8-v12-2-5c3422d0d72e@kernel.org>
Message-ID: <df9f07fa53c7c46debb927485138b6be@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Linus

On 11.9.2026 11:09, Linus Walleij wrote:
> The KS8995 100Mbit switch can do proper DSA per-port tagging
> with the proper set-up. This adds the code to handle ingress
> and egress KS8995 tags.
> 
> The tagger is used by the KSZ8995XA support added later in this
> series.
> 
> The tag is a modified 0x8100 ethertype tag where a bit in the
> last nybble is set for each target port.

Nordic nit: nybble -> nibble

> 
> Always insert a distinct outer switch tag. User ports remove this
> field on egress, so reusing an existing 802.1Q header would consume
> the sender VLAN tag instead of preserving it.
> 
> Push any hardware-accelerated VLAN tag into the packet first. This
> keeps the switch tag at offset 12 while retaining 802.1Q, 802.1ad and
> stacked VLAN headers as inner payload, and avoids relying on a valid
> SKB MAC header in direct transmit paths.
> 
> Rate-limit receive untagging errors so repeated failures cannot flood
> the kernel log.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
