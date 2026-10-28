Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205210;
	b=cArC1qmIzXZwwj7waPYAj2qlvm8DjSfueWe5+K8A7Nc39vdI6NgJzIG30trsN/pWaDID
	 N0p2pQeGr88e8ykIRN65kVsp2OAQElKBZukqGRQ1OXiLJ03OLR3oDUjY0Y/tmjOsU8FPh
	 ZzSKLH6gSV7GvTKQUYFImWYMQQtsXxX48z1uLCF9wbNQUJRvKlEE/MLBh5Y/UUWiUR6lT
	 815pO/A9my1mPh0cHeEv5HQVvazpgskZjGiPS68zsA/wUHSZ2u3LZYUwL0ZZQQhrpwGGT
	 8IfUcpMcheu0TgaqkzF2rM+4tUfOWEYPKXyr2k1esFrpr48Y+Qm75cyAo/FA8laSiwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205210;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=F0ZbMX9EeyLfy26pKyFOUMN1PmtyM/y56Mw7EBfzcA0=;
	b=XmAumylBJUL8NKaP9wxgiBzLFjtXXUboy3ohe8mO7iJk21zxpubmUyib0ol49V/jLn69
	 dqeKhxrkD94o00UWwJbeb1AWsgynJ5gDTqjXjpPbS2OhYKf1bB0k0WqcMliGek5BjJh9g
	 VdhWUN1ea59+hFqHCR63te7mfTU9c1cPQKtWjo2amP4b5YtlZqaURbjLsf0b11WMSq2yU
	 rOt46Mj48afeKZDW28ffT+py7vUBYxuFkfHeCdrCd6LPZyvuXvO68EhC0s5seqFT0Ab0I
	 Qg4ShEZ1uB7kfaJnoMZ8DwP5i3t+pptHQHeEUNv+olo3n9m1ecuvvsodsnUm1mEWOXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=S4vN2VHf;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC59606A31F;
	Wed, 28 Oct 2026 16:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC59606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=S4vN2VHf
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7A2A167136;
	Wed, 28 Oct 2026 17:33:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793205206; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=F0ZbMX9EeyLfy26pKyFOUMN1PmtyM/y56Mw7EBfzcA0=;
	b=S4vN2VHfYH/567vYQXf/ucDXOnWMiJ814HImMPur7WVAj5dxDevqFvw2rsuChHsm9izAVd
	DUbVFVZj7+uNVf+2gb/gRrTrMsbNDzVulLQz8KpmCsGB6xDV6Wx4uKhvgLE6xiZw0z1QI5
	S5t2G08BYUDoSLTfZHkE74XBJkp0G0/2FEmJEGSSMYAPVXi+uN8UbvKFMcwLXX49Zqq4MJ
	x9HxNYW/Zs3D0HILWMbXAb3BLQaWDx35BT3Un2+SRVji2hrZw56h/YACqwfBTln3un7jRj
	OF2piLTzT/wYcYIFAL8IYDht5/iF3+0JKyZK1PiupBn9mjI5vvEiL4ExQB7Q8w==
Message-ID: <c157df9e-b70e-4ba6-b808-5d13379b762e@cjdns.fr>
Date: Wed, 28 Oct 2026 17:33:14 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 0/7] net: dsa: mt7530: support EcoNet EN751221
To: Cristian Papa <pcristian292@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028160353.4239-1-pcristian292@gmail.com>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20261028160353.4239-1-pcristian292@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Christian,


Thank you for testing!


On 28/10/2026 17:03, Cristian Papa wrote:
> Hi Caleb,
>
> I tested v3 on a TP-Link Archer XR500v v1 (EN7526G: on-die switch plus the
> MCM gigabit switch).
>
> Setup: OpenWrt with kernel 6.18.44. I took the four mt7530 files from
> econet_eth at 3a8bcd2e6398 (they contain every line added by 1/7, 3/7,
> 4/7, 5/7 and 7/7 of v3) and booted from RAM over TFTP, nothing written to
> flash.
>
> With the DT from en751221g.dtsi in openwrt#25330 (MCM "econet,en751221",
> no "mediatek,mcm", dsa,member <0 1> on the on-die switch and <0 0> on the
> MCM):
>
> - 18/18 boots: all 10 TRGMII lanes found a window, no "calibration
>    failed", "TRGMII inter-switch link initialized", DSA tree set up, ping
>    over lan4.
> - The chosen taps were stable across boots (+/-1): SoC->MCM 15-22,
>    MCM->SoC 27-29. In the SoC->MCM direction the window always starts at
>    tap 0.
> - 6 of those boots ran iperf3 for 6 s each way through lan4: 0 RX CRC
>    errors on on-die port 5 (~1.05M frames) and on MCM port 6 (~1.29M
>    frames). In 4 of 10 boots MCM port 6 already had 1 CRC error before any
>    traffic, probably from the calibration; it did not grow.
>
> Following the binding in 6/7, the MCM does not come up on this board:
>
> - "econet,en751221-gswitch": mt7530-mdio.c in 7/7 still matches
>    "econet,en751221", so nothing probes the MCM and there are no LAN
>    ports.


Whoops, I see I made an error on patch 7 and did not update the name to 
"gswitch", I will send a v4 soon.


> - "mediatek,mcm", which the binding requires for -gswitch: the probe
>    fails with "Couldn't get our reset line", since nothing provides an
>    "mcm" reset yet (the TODO in en751221g.dtsi).


Also expected as setting "mediatek,mcm" requires specifying the reset 
line, and reset for the MCM is on its own unique register and is not yet 
supported by en7523-clk.c reset controller. The OpenWrt implementation 
is a bit cheating by not bumping the reset line at all right now but in 
my testing it was not different when I manually bumped it so it seems 
okay for now


>
> So I think 7/7 should match the new compatible, and the binding should not
> require "mediatek,mcm" while there is no "mcm" reset for the EN751221.
>
> Not covered yet: cold boots, and the other LAN ports beyond link-up on
> lan3/lan4. I'm happy to give a Tested-by once the compatible strings line
> up, and to rerun anything you'd like; the full boot logs are available.


I'll send a v4 and I will synchronize the PR on OpenWrt to it so you can 
test easily.


Thanks,

Caleb


>
> Thanks,
> Cristian
