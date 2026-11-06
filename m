Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979159;
	b=WzjOtO0/xOwe0ljgZXszzjjt9FpcbsbSoA1N8P27KJfiJpI4Y2ohPx94JVMHF+K4Busl
	 TeijKUPWgEWRe7fQrhH2sM/OzMDdNP+g7laGZa1f32Cjro/nmEgB3v8SZAA08RdaccCyD
	 0YFTlMSeoc8Engs1W/Cnz196NRzvmtyLFOLBhGEqM22NEwr3MpzGUZ5DdddWGioLwViox
	 tG9EdlLSXenz83dqayCXo161tBKFB1/Xe5EsD+lg98e0FARDJaRtieNz5c/g3SFz98UwO
	 E2qT3RpT4BvX/LSZfLQpitc3VSjnpPpad4PW4NuLMgAslL5hnhBKPFNpgVJaefaNRKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979159;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=P+m9BQcu9O/FHNLOowWjO5xa3x2BuTOUOzKKSEpxq9U=;
	b=gvhmhDAU7Xdx9EQK3TbGO3RfHJMAFJ20Dumdtni7FBPXViSngFXd/qwLsDWR1xcps6vW
	 SpoX1Nt5hxYMxPplyCuZjInE1sRQWO8jtSTQIpJLRVsXGtdILhI+u9Y9h9X2MSoRV7rN4
	 idCZ81yGpvbT5ZW7oK6jivJ4LIoKfjCzFezPSIu/66tZH0sSnMO7vQz5QN32GZFaUZ11f
	 vJ8KVfMio5Lb1Lcv8HUckpL8XMfSVCSVjixXNiby8xgFtzhAIRZmgWxBua/csVjxGN0oe
	 95GG44WIV9bLPzf/zsfUiMc5I84fngva4IOP1f92j5XJKgec3s7QufPbxERk25VW1vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b="b8pae/Tu";
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b="w427/YYm";
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337E606A326;
	Fri,  6 Nov 2026 15:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4337E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=b8pae/Tu;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=w427/YYm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793979156;
	bh=xHy9AAwYbUNDRIPqlGFP8rBNvBDMvPDQk8lTAq0vRB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b8pae/Tuh1waK9UCpykRDAPc2iXoXOsKS242SiVWo4sBDNyaO/hUml89ptZvsw2fx
	 wFP76Ng3rzrTEDafJNx49BPuRsXg2pntDMuB4OYC9qgeueurSGZDOu4Bo6cX9Zss32
	 T0248xVN0/Z2GNI8pnxPySq67VESEN+BidDWMI8ukC2qKKrOd7AWCtsU99bj2Kdfm2
	 8DE8lPIQqtNtDQfLFtK1At1kdepFjAHioIWpBRpxCan7pHqzGAQ89s6h0fssGpjXWq
	 6TlruDjR0njrtExbRpcvWl8Nq0UNy1O5zDOYpuHImJs9xCVd4NiWT95mzff1MOTI7K
	 gnClIvaRCXt0A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 75ABF48BAB; Fri,  6 Nov 2026 15:32:36 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793979154;
	bh=xHy9AAwYbUNDRIPqlGFP8rBNvBDMvPDQk8lTAq0vRB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=w427/YYm70AKnIjmqwOeLkuvEfLMrPh841E6+W65j1YHuy0vePY4VMnrFWKFhiPAS
	 YutnMYtqG/7+CcBf3098NZ0Z+8xDb+pIyhdL6JWs9XrIWE5R1s2nmQ4VrAg2Tl2GlT
	 VlOHkI6u6L+GAFW6aTOJU6MXK4Rx2a3uZ9r41MraU0VheSksRmePDSiwf1mb21tf8Z
	 BMdb9AOxA4AzyOfKO4o5TL3SEY7ygL1bhm7C64V0GyBHl1UFh68BfFjKS4oAEqt0Vh
	 xqeGI8HsxepVkZd79lTyb/Ke1BSytnbzLY1hW+4SsW7IBV/xTjcQSE+6bRHwmfA/zP
	 rbyRfOqZ1lrjw==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id DDA7C48B84;
	Fri,  6 Nov 2026 15:32:33 +0000 (UTC)
Message-ID: <27119213-dccc-4c17-bf7e-b39a038038cf@birger-koblitz.de>
Date: Fri, 6 Nov 2026 16:32:30 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 01/13] phylink: Add phylink_mac_interrupt
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 Jianhui Xu <neuromoments@gmail.com>,
 Emir Beganovic <beganovic.emir@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
 <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
 <69be2cfe-e296-4f90-ad19-0bd48a83e287@bootlin.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <69be2cfe-e296-4f90-ad19-0bd48a83e287@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Maxime for reviewing!

On 06/11/2026 11:11 am, Maxime Chevallier wrote:

>>   
>> +/**
>> + * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
>> + * @pl: a pointer to a &struct phylink returned from phylink_create()
>> + *
>> + * Passes a link-change interrupt received by the MAC to phylib.
>> + * This function may be called in interrupt context, and therefore cannot take
>> + * a mutex. However, it is safe to assume that the reference to phy does not
>> + * disappear during the call, as only an SFP module may be unplugged to make a
>> + * PHY disappear. SFP modules however do not support interrupts.
> 
> I don't see the relevance of PHY SFP supporting interrupts or not here,
> this just re-triggers the PHY state machine. Looks like a comment to
> make sashiko happy.
Indeed, this is for sashiko. Unfortunately it followed up with: "The 
function comment notes that SFP modules do not support interrupts. 
However, when an SFP module is physically unplugged, the electrical link 
drops. Could this link drop trigger the MAC interrupt being handled 
here?", which is equally irrelevant, I believe.

> 
> Anyways, I'm OK with the approach, maybe reword that comment if you need
> to respin,
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Thanks, will add.

Birger
