Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286022;
	b=rhuMZhJUxtYm0G8HGKf+wY/pOo7HCp1nbiyBvdYakXnDMQTIbB56bDJuO4be4zIIXhbq
	 +3ZfWXAQzcMf7u4ggpanRYOjST8OUgqrD7eyvrXTz6fw+Jt991TrpWQYDXYsZcwyFQT6a
	 2t1CJbu4dWmWhlLo/sy/BlsREe/XXzK7NrD4CJwX1VVaml5SnSaYCNdicgMpaQ0I3W9Mr
	 2PcTD2vWEMQ8Yc9R0lfagvej+HkXjyEq+OBo+l/Mb7wCTYXJ5qli/nVyVkKENAXtZHG6n
	 U89PYCFPyjJmaBAPdy9pGqQDnaVAq95h1+dkgkNiu2BN0KbnsToJW8FkGkFao3UDZtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286022;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qeHwILNQGply0KqQmlcAkFwCx/TwT+bJHyeDxiQI18U=;
	b=hMm+tKPmY0wiz9QQjPIFnBmYPKK9/5Vf2zcoxfAuenzLO9KP7XQYv2lnkQjIPwQh9md3
	 jlFJR+c5SPNyEwE7SVUe6aiKcHutziO0JMj1qT/mqjJh6lbB7HoEBrtxdj+2OovOZWjEK
	 5NmIZOV8m0e61iCwQOw/ERqklwYsjmSwiy8rvTTEb6SLJDHVsUQzr9H8ZqD99Vj7MHfuJ
	 tl0x+Iqnin2jbcDPlWNsizwKzqlRNiWMsIrrU6DKKzrBFQrBA15SGiACT+5Ev32SVh3CF
	 TDAXC6z1cOoh2JcKGKRsYJHvrRVBXcbSWiX0eoTZjhUZaCCMDLGX8Oadn/kLwp5KwAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=WrT1BvF8;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=WrT1BvF8;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E7606A325;
	Tue, 10 Nov 2026 04:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 646E7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=WrT1BvF8;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=WrT1BvF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1794286013;
	bh=ZB63gzCuOHYpjLLMilJz9otldB10xXorS9YPyJ3fmfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WrT1BvF84pm5hCTmr5G04ulNCFZToyJ8qH1j+W9zQI0i2R1GZl5W13R9u9R0TQtP0
	 6/2DeFbKxSj0iSU2mNyRHIM8heTSSjK5DDWIoclxdkiHSqS5RSEgEsb/n+i9hxNDhd
	 VIQ4eplV4CHMRcgRdQBDYNs59roQD/YX9aE2LEibl4mGyHSSD530QZw657S6ttedEF
	 oQVl3d6m2zgWEilUtdpMOoGqH+Tbpr01PCYnURdcBwmu0NS/FyV0WYv/WAXpcVuHKJ
	 41GHSJNbw6dtHlLceoC6JWJ2Iaf14ySRqN9WUYW9vs2t3uqIRm20AVXV4FIKWTbaPp
	 oCKLBPuBTDG3w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A517748C0E; Tue, 10 Nov 2026 04:46:53 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1794286013;
	bh=ZB63gzCuOHYpjLLMilJz9otldB10xXorS9YPyJ3fmfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WrT1BvF84pm5hCTmr5G04ulNCFZToyJ8qH1j+W9zQI0i2R1GZl5W13R9u9R0TQtP0
	 6/2DeFbKxSj0iSU2mNyRHIM8heTSSjK5DDWIoclxdkiHSqS5RSEgEsb/n+i9hxNDhd
	 VIQ4eplV4CHMRcgRdQBDYNs59roQD/YX9aE2LEibl4mGyHSSD530QZw657S6ttedEF
	 oQVl3d6m2zgWEilUtdpMOoGqH+Tbpr01PCYnURdcBwmu0NS/FyV0WYv/WAXpcVuHKJ
	 41GHSJNbw6dtHlLceoC6JWJ2Iaf14ySRqN9WUYW9vs2t3uqIRm20AVXV4FIKWTbaPp
	 oCKLBPuBTDG3w==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9EDFD48C07;
	Tue, 10 Nov 2026 04:46:52 +0000 (UTC)
Message-ID: <64d05861-c4e1-4506-ac2f-4109f1062932@birger-koblitz.de>
Date: Tue, 10 Nov 2026 05:46:42 +0100
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
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
References: <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
 <179427470922.994134.16776316201780098943@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <179427470922.994134.16776316201780098943@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/2026 2:38 am, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] phylink_mac_interrupt() (drivers/net/phy/phylink.c:1629-1637)
>    loads pl->phydev with no lock, no RCU and no reference, then calls…
> - [Low] phylink_mac_interrupt() reads pl->phydev with a plain load (`phy
>    = pl->phydev;`) and no lock.
> 
The possible issues for the series have all been raised before and I 
have answered to them, some of them more than 4 times. None of these 
answers are being referred to by the AI, so it does not appear to make 
sense to provide such answers. Asking nevertheless to answer them again 
(all medium and above!) constitutes harassment in my eyes.
At this point I am asking a human to intervene and tell me whether 
anything really still needs to be done.

Birger
