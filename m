Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4827CCE0
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324961; cv=none; b=gyw3UAydXSv4hqyRECdWgD3hS+ku3Bh7Om0Gw3kJA6razcXjJdCarRGHAGWFH2AyWtnaXjUxNhP58L1bRML+nZPZ0SZ/ruQ2knLA1PbwAjz74Igvj4uL5WkcJ1LEzJGOxfftTWPwk8eqmO2KsE0V9/eAGujmXKn6oympvFKWDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324961; c=relaxed/simple;
	bh=bXJ7F6cjL7i3dfzFRxLRXMG6H6Brq7bWk7utyAT/3oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6JSM6qdFqy0fAMVdg8JZWFjQTfGBOmWE8e7TXr2WfkKYtnEOltBZZP5Nzpn221zuyKMijC1mTqutMSW6BPMOQzY4tQ/tR1OE9s1UPstynVbDcIz0rI73IG3zsRgktUbc3tsp6ZCEHVUH5KBNY+lrqgpLPUkfmi8afrh0nRqAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Klkzrn58; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Klkzrn58"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6A8921A12EF;
	Wed, 29 Jul 2026 11:35:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 356F26039A;
	Wed, 29 Jul 2026 11:35:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77EF811C14D1A;
	Wed, 29 Jul 2026 13:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785324951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=U4x7GgBq+e/gvuJ5cyUD73Nhz+wFnQftgYUhrbLSnes=;
	b=Klkzrn58+OfHyVsct7f99ef2xFy2v0hvlDqUS2cYaCLTQPDb4AxTw+OoKsqcCXG7G0VS6Q
	qOkdauVNmLo6rXuia78LE20XMDkaxgw5Xeb55vig37AA56rujq7w49WHfeRdTi73Z7T32r
	/W00Y5+CPQTBTI/FVZfwDDFj/dPIJIXQPNO43OJZwmhdFT2ktNxh6Qs+LdhMPvz5uPn37k
	G7AD0IOpMkbKf39CKtuCfnd5DjxBdoFJisIBjhz2kH8ClViQij5pNNoWF8VKzbSF2t4Pq3
	2zm3TUEbOg7vbiGPgP+oITs4s+uRE9SdIA0ac66Yxw9srYaNIloAMIFHxQqzhQ==
Message-ID: <af97a4a2-9a1d-4b36-9055-d05124bf4ab9@bootlin.com>
Date: Wed, 29 Jul 2026 13:35:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag handling
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, jun.ann.lai@intel.com, yi.fang.gan@intel.com,
 boon.khai.ng@altera.com, matthew.gerlach@altera.com,
 "Nazle Asmade, Muhammad Nazim Amirul"
 <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

+ Nazim Amirul

On 7/29/26 11:51, Ovidiu Panait wrote:
> Currently, hardware VLAN stripping is broken for 802.1ad tags. vlan_rx_hw()
> hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rather
> than using the actual protocol from the packet. Because of this, packets
> that contain an 802.1ad outer tag are incorrectly passed up the stack as
> having an 802.1Q tag.
> 
> This issue was observed on the Renesas RZ/V2H platform (which has a dwmac4
> IP), when testing QinQ ping:
> 
>   # DUT
>   ip link add link end0 name end0.100 type vlan proto 802.1ad id 100
>   ip link add link end0.100 name end0.100.200 type vlan proto 802.1q id 200
>   ip addr add 172.16.3.2/24 dev end0.100.200
>   ip link set end0 up
>   ip link set end0.100 up
>   ip link set end0.100.200 up
> 
>   # Peer
>   ip link add link eth0 name eth0.100 type vlan proto 802.1ad id 100
>   ip link add link eth0.100 name eth0.100.200 type vlan proto 802.1q id 200
>   ip addr add 172.16.3.1/24 dev eth0.100.200
>   ip link set eth0 up
>   ip link set eth0.100 up
>   ip link set eth0.100.200 up
>   ping 172.16.3.2
>     -- FAIL --
> 
> This series addresses the issue for both dwmac4 and dwxgmac2:
> - dwmac4: since dwmac4 does not expose the tag type in the RDES3
>   descriptor, it cannot support hardware double VLAN stripping correctly.
>   This series disables double VLAN stripping for it, so the 802.1ad tags
>   are left in place and are handled by the software VLAN path.
> 
> - dwxgmac2: the RDES3 descriptor does report the type, so the code was
>   updated to read it instead of hardcoding ETH_P_8021Q.
> 
> Note: patch 5/5 was compile tested only, as I do not have the hardware.
> However, it uses the same codepath as dwmac4, so it has the same issue.
Nazim Amirul, as you seem to have access to some AgileX5 with XGMAC, can you
see if you can reproduce the issue on your side and if this series solves it ?

Thanks :)

Maxime
