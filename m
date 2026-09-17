Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0274ED1B9;
	Thu, 17 Sep 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680296; cv=none; b=C0KeytHrrGlYXTXvVoICA+gFgp7N2zaZ0iFgbFBZ7frlAQ2xDPIiffljfprM0HkYv6tQys7488oroOi5nVRZd1cBuqXUdCyYf0swcAS4XKFXs4OAxwxqsooB/9mwyiO3Sw/326Is+/tc/59oaWKMx7OVlLY9ktasETKteFR2t3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680296; c=relaxed/simple;
	bh=LWXAzzJEAtiLkyJurfnDXZjFKNNgzKmkML8HIZik1W0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dl71GugSkEEbTCY7DrqhhajJtBOUA+EerR4DhrslanQf5YeuayelKBcS/JvfuB3+cK8wTgpGyHUF41UWeN5oqtU0FDHcp5U1PNEojV2gogCUHXBJO0V9J7cOHuOTbvoxlLvRR51GCVpDXB6SKjCM2Hdst/60MNMF0txCxSK8BOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgLcRi6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgLcRi6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470FB1F000FF;
	Thu, 17 Sep 2026 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680294;
	bh=fPMiwjxT8Jl2v+zAQyegXkHN0cMDxU8TGvBfNHM6dIU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZgLcRi6fB8NUvWLmyx4dHG+wqjF8anzubAeNTjeERGtY5jkIb/elpOnX6A7H0rJQ4
	 jyFqJaiEPOpwLUR8w8Ll53ei9clOFXlwSJsvYQGYB0aPASn/3LkCWUELk4hEwpR6A4
	 xHGDTTDik0cjE+7+HO36AVcOI17dRypfaBoqt283xWgiBwRS6Z+GZLhaE3CbeuxdIQ
	 C5olWZI1hhGi8LcrE1YGVpdgPulwWk/0nnO9ndQj13gWoMRPSMu9RVbrFytsghh+9x
	 oVNLEjkLkeuatk164xahAd5C/OJsroq16MAvYhLxJArJoOLb/lWuawZlT3rZftZASu
	 WaEPAbNKGq1Ig==
Subject: Re: [PATCH net-next v12 03/15] ax88179_178a: Fix endianness of pause
 watermark register
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:24:52 +0000
Message-ID: <178968029284.22033.9805083282551581110@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-3-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-3-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Commit subject/message mismatch: the patch is titled
  "ax88179_178a: Fix endianness of pause watermark register" but…

--

ax88179_178a: Fix endianness of pause watermark register

This swaps the register addresses bound to AX_PAUSE_WATERLVL_LOW and
AX_PAUSE_WATERLVL_HIGH (0x54 and 0x55), and swaps the two call sites in
ax88179_reset() so that the same values keep landing in the same physical
registers as before.

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 81d8412ce8e2f..2ed46ab62c006 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -32,8 +32,8 @@
>  #define AX_ACCESS_EEPROM			0x04
>  #define AX_ACCESS_EFUS				0x05
>  #define AX_RELOAD_EEPROM_EFUSE			0x06
> -#define AX_PAUSE_WATERLVL_HIGH			0x54
> -#define AX_PAUSE_WATERLVL_LOW			0x55
> +#define AX_PAUSE_WATERLVL_LOW			0x54
> +#define AX_PAUSE_WATERLVL_HIGH			0x55

[Severity: Medium]
Does the subject line match what this patch does?  The subject says
"Fix endianness of pause watermark register", but the only change is
renaming which macro maps to 0x54 and which maps to 0x55, plus a matching
swap of the two call sites below.

A grep of the tree at this commit shows the macros have exactly two users:

  drivers/net/usb/ax88179_178a.c:
    #define AX_PAUSE_WATERLVL_LOW    0x54
    #define AX_PAUSE_WATERLVL_HIGH   0x55
    ax88179_reset():
      ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
      ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);

Both of those are size 1 writes, and the endianness conversion in
ax88179_write_cmd() only runs for size 2:

  static int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
                               u16 size, const void *data)
  {
          if (2 == size) {
                  u16 buf;
                  buf = *((u16 *)data);
                  cpu_to_le16s(&buf);
                  ret = __ax88179_write_cmd(dev, cmd, value, index,
                                            size, &buf);
          } else {
  ...

So before and after this patch the driver writes 0x34 to MAC register 0x55
and 0x52 to MAC register 0x54, and no 16-bit access to 0x54/0x55 exists in
the tree at this point.  The commit message itself says the change is
behaviour preserving:

  "but also swap the configuration values used in the code in order to
   keep the current behaviour"
  "The endianness is relevant for 16-bit writes to the register."

Would a subject describing this as a correction of the register byte-order
definitions, or as preparation for the later 16-bit writes, be more
accurate?  As written, the "Fix ..." subject with no Fixes: tag reads like a
bug fix on a path that is not reachable yet, which could attract a stable
backport of a no-op change.

>  #define PHYSICAL_LINK_STATUS			0x02
>  	#define	AX_USB_SS		0x04
> @@ -1619,11 +1619,10 @@ static int ax88179_reset(struct usbnet *dev)
>  	dev->rx_urb_size = 1024 * 20;
>  
>  	*tmp = 0x34;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
>  
>  	*tmp = 0x52;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH,
> -			  1, 1, tmp);
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
