Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610431;
	b=Htzo7xrnVFC6dkxge7OdSNJ8d7xla/oANAfFmiurIVUKBKM6iyFN+rpsTx9HZfZ6tQ/R
	 BnVUSMijPNK/rCsweIl3m87fdEMV4beSm8w7Y2ZINyd+M8G1sfmtQvyzHOS4zjJHziJIX
	 VQkjkA+G5JknddNkoeiNEsh4DucgOke2q8O3/z+Psx/EFvxHV97g+fwp+TbzMX1Qbbkur
	 1hlVVx54YPDv5EDQjRiA1CoHBvzncWpVYSJNbQYwWxS+Xo/apivCxTHlWPfs9Ou4TNapJ
	 A+oi7RX/fmI3QOsOOCoHd4Xc30+KhUTnqgM+VX1+7RnuaiE6g7uXrccyGab0eJ9nfQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RNiRiiyO7DJqjfqrX+rUB/oye1h9Xb+o0d5qxoLsqSg=;
	b=CpZ2TtZTuXSgA6SFE+PydyssDyKCXk4rv/QfVCnxdY5Ixe5E5GweDp5kxMP1GEnxgoYS
	 0ZunkbGmOs/9qvRpKMz13h2UDl66ph80aBrlhu7k8xzYD15EmmHZwh1m68hdGBiqu5L3+
	 WqRQOjQTeGtm+YFSGQtaRDzzo5+NHwEZKuLwMKIDctJOhVkVs/JIlNxNJJIKMNuJtRkIy
	 69vvhMQO4LtfgUwN3MB2oEP5FRl6XbMvyH5ipAlkbx1CuXU4v//61iSk58ogTjVbV2j0P
	 +HTwYMILLOKS17U/ZqRc92mxUecRVfG/CP77V7+3ZNWUi7fjDcDr7JFVAcG+76pYFrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k3ubY76j;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8685606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8685606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k3ubY76j
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a0a87595so626934a91.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792610430; x=1793215230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNiRiiyO7DJqjfqrX+rUB/oye1h9Xb+o0d5qxoLsqSg=;
        b=k3ubY76jKx5pTSepYJf8MKrcdHMsRSQrrqC43Og/urmHTQZzF6tbSnKTTX/HkkkUWX
         +YcZnydyfvxRZ+s8/7YGJTkTrfxsBZcPxOlCS10dziV92E/sYdS/YhwsSNpBEuy147dl
         hodDOD7QMzYKA833dr1pvan1+PN2dhNNwo+KfdV6rCuogw9HkRCQ2gGlSoJQdGpQNid0
         Zmoev8k+Duh9Z4RDWMUsA14eS61ZoUQQbl/3XOqyckH1n+el2UIkAXhMST6MsXve2yxV
         T/H+pydL1M4bw4xokzsSv+2tkl6/SLxCsWVUABOd14WvAob/fAJmHgUuPy/kM1a2hcIg
         YLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792610430; x=1793215230;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNiRiiyO7DJqjfqrX+rUB/oye1h9Xb+o0d5qxoLsqSg=;
        b=NC186MSdUDm0etxreq8E5jScjnBUnyRu/QVOheT4rjzuz8DqTdFdLocBdrYJywn6cH
         9wiQ2tQaLfCiuPmMfggizTHFN1VkD3xB+gO5a/hccnPXDzpi5XrTbi3HBYN8UlA5Ec3l
         uxsFrOuiGQqNU3iZlYUw5hHi+mPP8MXpAlXHD3oCyhS/rkc1MQ0kMXpyyBLqPsMUVicC
         6GppwNM9DQ7RWsYFzpXM6wa6fQ8dMTauKNqP7dSZI5sABd7P+DK16XIIIRwi/PEjuAh5
         OFl8kogDl+EsDWnK/frOg+mnNTy7j9SSLLFcZqDlMbu6zD5neF/96yb+eMyqDyAB+h+7
         GMXA==
X-Forwarded-Encrypted: i=1; AKwUvBypgK3odVUa40qzLMe+mmLuYZmoHubGZVQVq3rC+h8M4ZIt5wW9c/A6ly77NxHXng7/+3YUIGw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqABNpe2rj+/cxxpcKkUgDcgWvSYuYuAqxclzb40U+Whu4Z3Ru
	scjyVgDJSfdGrE34FVOfQFhRKOALVgQTNQCDg5Em5ueMsjK+w4J5g6wN
X-Gm-Gg: AYBFou15MWktdakgLgsqcasBUiYJXpT17IZECTj2jmeBT+IHDMKdRb0yfV3jGdUuCXO
	XayZ4HdHrg5slClJPNVLljWJqSEaG2iv6EE+cJBwNQdgOBSJcQv7Dzdh01Adtey0Em1sVXMnENc
	J1A9PBfYOROanbvgadHnSfcq6dHgttohJqQBAI6AWTtuL7urqTbesH1PKLhEED2K7blFPjY5uk4
	GpdVgkDZOwf5uX6MjRhB80IUGFaQS+7bK4WRQUz1F/m5bJth1cJjzavjt+q4ZFzclWyGis1fwu/
	SS4/D1n9LLOU107aKhIFk02MwuJlDDK2fGpWPl69uva33pEZwTn/rNQkLwifLkFF3E54w9HmcCJ
	s4sLT8eHNz1/qffOi552qwy9kbq3npTYyp0L3lAHdng+m1dRXLWOC9U5goAXjNzC7cIjU+6bUdZ
	nEXEKjqb382J6oy2lAeenzoWcl4rxL/aDP7H9oLao7YmrBwxcicCjhgj3Yz02MReJXdBEkfw8dk
	mztlzinYVLc60PDuGdhZISAI47kXpWJUBpmtE4Qge68ylQw2S99sq+0nuDj
X-Received: by 2002:a17:90b:4c49:b0:3ab:3384:1a44 with SMTP id 98e67ed59e1d1-3ad86f451a8mr2500980a91.12.1792610430130;
        Wed, 21 Oct 2026 12:20:30 -0700 (PDT)
Received: from [198.18.0.1] ([152.175.97.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f56b03sm2573981a91.3.2026.10.21.12.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 12:20:29 -0700 (PDT)
Message-ID: <38114050-123f-43df-ad74-6a27effd37a9@gmail.com>
Date: Thu, 22 Oct 2026 03:20:19 +0800
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
Subject: Re: [PATCH net-next v4] net: phy: realtek: Add support for JLSemi
 JL2101 and JL2121 PHYs
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261021170248.49264-1-cyan2254650260@gmail.com>
 <44fbfba4-edc1-453c-8e9c-8a6ddddb43ec@lunn.ch>
Content-Language: en-US
From: Pufan Jin <cyan2254650260@gmail.com>
In-Reply-To: <44fbfba4-edc1-453c-8e9c-8a6ddddb43ec@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/10/22 01:30, Andrew Lunn wrote:

>> +		PHY_ID_MATCH_MODEL(JLSEMI_JL21XX_PHYID),
> Thanks for this change.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> Since the merge window is open at the moment, patches will not be
> accepted until it closes.
>
>> +		.set_wol	= rtl8211f_set_wol,
>> +		.get_wol	= rtl8211f_get_wol,
>> +		.suspend	= rtl8211f_suspend,
>> +		.resume		= rtl8211f_resume,
>> +		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
>> +		.led_hw_control_get = rtl8211f_led_hw_control_get,
>> +		.led_hw_control_set = rtl8211f_led_hw_control_set,
> Have you tested these features? You have seen one register is
> different. There might be others.
>
>     Andrew

Hi Andrew,

Thanks for the clarification regarding the merge window. I will hold off
submitting v4 until net-next reopens once the merge window closes.

Regarding your question about testing:
 > Have you tested these features? You have seen one register is
 > different. There might be others.

1. WoL:
On my ALINX AX7Z020B board, the INT/PME pin is not wired to the SoC
as a system wakeup source, so I cannot test end-to-end Wake-on-LAN
from system suspend.
Furthermore, I probed the RTL8211F WoL registers (page 0xd8a and 0xd8c)
directly on the hardware: writes do not stick and all registers read back
as 0x0000. This confirms that the JL2121 does not share the RTL8211F WoL
register map.
Therefore, for v4 I have dropped .set_wol and .get_wol, and switched
.probe to rtl821x_probe and .suspend/.resume to rtl821x_*
(matching RTL8211F-VD) so the driver does not touch page 0xd8a.

2. Hardware LED control:
I have already tested the LED hardware control on the physical
AX7Z020B board. The RJ45 jack has green and yellow LEDs, and page 0xd04
reg 0x10 is indeed the active LED control register:
- Boot default is 0xe251 (Mode B with 1000M+Act on LED2, 100M+Act on
   LED1, 10M+Act on LED0).
- Declaring leds child nodes in the board DTS successfully registered the
   LEDs under /sys/class/leds/, and the netdev trigger confirmed
   hardware offload ('offloaded: 1').
- Setting register 0x8000 (clearing all LED rules in Mode B) turns off
   both green and yellow LEDs completely.
- Setting 0xa000 (LED2 link 1000 only) turns on the green LED while yellow
   remains off.
- Bitfield manipulation verified that the green and yellow LEDs can be
   independently toggled (e.g., single-LED blink and synchronous dual-LED
   blink cycles).

Therefore, the hardware LED registers and Mode B bitfields are identical
to the RTL8211F. I will retain the verified .led_hw_* callbacks in v4.

Thanks again for the review,
Pufan

