Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572B25C818;
	Sun, 27 Sep 2026 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502153; cv=none; b=izFZEYSqQZPPmI6DiU6GhWuj/0Raa2gM5ngiF7xvJV4d+vOoh2z9/O7v3/svZrdO3zL/voK9mr5V0gecxsjO+BB1A77nGz/tiLkc7RtwUREAFeCIUfzKFzT90r+6VZEjVInSJJfxOO5pl7P6TUsMh0otADiyzIIL5pXxq0Z0ClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502153; c=relaxed/simple;
	bh=mxK+/ueVP5LngDu0DZWjLyh5mJIf3J2f5r87BKB9GKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhYuoVOloNUgYW/drCeMaHkYymRm7iEYs9CdYAIXsJEJVT7lej6PEhp9hV5WWZiDglxd/mkc85J0k6TYmYcq8bamLvel+zli9QYpqu5cp0GSDneX1ahA9WIIdA1LOOHEodWJBHXI9dgwWrxVpX74DcshwueEA6CHAblMHi8/GiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Nt/Hsul9; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Nt/Hsul9; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Nt/Hsul9";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Nt/Hsul9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502149;
	bh=mxK+/ueVP5LngDu0DZWjLyh5mJIf3J2f5r87BKB9GKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nt/Hsul9wFs/gH5MQ4heCagVTc4723Tn1nGrbJFpzyZ5G/mpg5coW0VUEmObAc7d3
	 tfZQB4uHHsMW0l2Dek9qWlY0o3k0Crl0xUE73k2RZF301TIl519DBxcGg+KH+ra8Z3
	 XaygaSCv5a9WA5Yr0u41ppN73oe/YWkjlG4RuSFKDFM7vzFUUXheCKs5mTi0rRTaep
	 +k+/6LQdOVWtEuuKdpZbYtL6v5M7DMywdNkY1UD7S8rFfcpjLoQIvCoTw45iCGFHBk
	 8ppAjVlGAxa+WrcR7s3mw4BTgrUj0b2vnWbHkEcmAIawu1cyJS4qACFHWW7Qy4VhDF
	 ZeBPAgD6xSjxA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E52D041312; Sun, 27 Sep 2026 09:42:29 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502149;
	bh=mxK+/ueVP5LngDu0DZWjLyh5mJIf3J2f5r87BKB9GKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nt/Hsul9wFs/gH5MQ4heCagVTc4723Tn1nGrbJFpzyZ5G/mpg5coW0VUEmObAc7d3
	 tfZQB4uHHsMW0l2Dek9qWlY0o3k0Crl0xUE73k2RZF301TIl519DBxcGg+KH+ra8Z3
	 XaygaSCv5a9WA5Yr0u41ppN73oe/YWkjlG4RuSFKDFM7vzFUUXheCKs5mTi0rRTaep
	 +k+/6LQdOVWtEuuKdpZbYtL6v5M7DMywdNkY1UD7S8rFfcpjLoQIvCoTw45iCGFHBk
	 8ppAjVlGAxa+WrcR7s3mw4BTgrUj0b2vnWbHkEcmAIawu1cyJS4qACFHWW7Qy4VhDF
	 ZeBPAgD6xSjxA==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id EA074412CD;
	Sun, 27 Sep 2026 09:42:28 +0000 (UTC)
Message-ID: <4b43c4a0-16bc-474a-a775-5a09ec54a54f@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:42:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 15/15] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-15-60c04c9924a2@birger-koblitz.de>
 <178968030887.22033.2787971070924550661@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968030887.22033.2787971070924550661@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:25 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 6 · Low: 0
> 
> - [Medium] asix_ax88279_config_aneg()
>    (drivers/net/phy/ax88796b.c:146-166) programs the vendor 2.5G…
This is tested and works as written and not the other way round. The
firmware of the device seems to initiate autonegotiation on itself when
link-modes are changed in the device (not by the other end of the link)
in order to optimize the link. This is the reason for needing to rely on
link mode changes by "interrupts" from the MAC layer, instead of reading
inaccurate link mode registers.

> - [Medium] asix_ax88279_read_status()
>    (drivers/net/phy/ax88796b.c:108-121) does not check the return value…
Added checking of return value and returning this as an error code.

> - [Medium] asix_ax88279_read_status() (drivers/net/phy/ax88796b.c:99-144)
>    has no `if (!phydev->link) return 0;` guard.
Will add this guard. Indeed it fixes reporting incorrect Speed/Duplex
   values, instead of Unknown/Unknown.

> - [Medium] asix_ax88279_read_status() hard-codes phydev->duplex =
>    DUPLEX_FULL with the comment 'Only supports full duplex'…
All erroneously reported modes are removed, this is successfully tested
with real-world hardware. Removing further hypothetically reported modes
is not necessary. If such modes were hypothetically reported, they may
actually be valid modes, anyway.

> - [Medium] In asix_ax88279_read_status() the link-partner 2.5G capability
>    bit is only ever assigned inside `if (val >= 0 && val &…
Added clearing of ETHTOOL_LINK_MODE_2500baseT_Full_BIT in lp_advertising
before modifying the bit.

> - [Medium] net: phy: ax88796b: incomplete clearing of 1000baseT
>    capabilities for AX88772D
You stated: Only ETHTOOL_LINK_MODE_1000baseT_Full_BIT is put into mask 
and removed
   from phydev->supported here, so if the hardware also sets
   ESTATUS_1000_THALF or ESTATUS_1000_XFULL those bits survive in
   phydev->supported.

These other bits are not actually reported by actual PHYs, which are
anyway just something accessed through the controller firmware. When
hypothesising that they may report e.g. 1000X fiber modes one would also
need to talk about hypothetically reported 10GBit modes. Where would 
that end?
This was tested on various hardware.
The clearing will be shortened to just:
linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, phydev->supported)
as for the ax88279-case.
