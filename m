Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096936;
	b=P5b367JYoeKSuYibQyRqDVv87MSw/XCVWQbC+C7HinJyZazgKUYfK0k4c2clMJVpgQic
	 E1IGrjVFFSDkDZXZl8zSKFbnubZM9khHfBzeC48to5lalvrT9OvjBjuZ1vusGN89blvAd
	 Yhgfdk5byczZ9dVM24B6N7QAdvUXliWWY9xeGlWkrIawSJNjJ+f6z8tfM6ACdmi6pTOY4
	 tvs4Qjh+YOsSIqPR9fRlUYVTUnkTNyXlSdSwkIpORm7r29q+GOvx9THZytaEwy4ts+dXH
	 2Q+W05hb5iTJBy6F3At4+ytrz8s3OjK/YcQmvss+42vdA8KVFnwJisksWD9Ws+tAB/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096936;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4NMN6NoxEVSmnHn/VpajSP2d2A03cJPGmCzL5Lr5yV4=;
	b=Jp+nYhXU6pB1SEtKN/tXOvw6WnEIA+Xt6XvuW+6DEfly8Qf7pNCgTkSmH7+Xry8GBMyh
	 oSOZFLl5+CQ0Zq1vRtZkQNM8yg6WG4jz3OfPzthKdw148vAgLoKJ0xoM+L0oN76p1IJII
	 ySweNY1sweJD2ePSgYYWJEoVj2KWQYJ1YWQaiIIH10GhEi9rg8NctS0tCr9EXKQSEeV8V
	 +M5XqjmbqW7P5VJrt6DBaFeYYNBHdairPA5wn6Q/KuwHZMVDo6LmMQ8+UE0WXql17zKMm
	 nNlEv91e+ezx437VnqhJQoHOAiQggnQ4c5gi5wAYTxSCqgQDrIhW0b9e2QsdQPAUFzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1Z2+BNM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDFB606A326;
	Sun,  8 Nov 2026 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1Z2+BNM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7B01F0089F;
	Sun,  8 Nov 2026 00:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096935;
	bh=4NMN6NoxEVSmnHn/VpajSP2d2A03cJPGmCzL5Lr5yV4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S1Z2+BNMlxcWX4a3aEFcg0bTCorgyq35+1BKuD+f/w483idSXAHs5uHU48/deYBTw
	 Q2JFoQKjMtydGlVavpAulFMAoTXZnHNZ739OoXcWhCTPROt/qJITJG2s1fdNpi9wug
	 CNV06mNbe4JZIYhplLa/Gu0EyO+HuCdcg/UdvXSLiV4vmDaI5Z5abi/qbaNVxiBZWr
	 4W2kWwpKs8B0DUGXdZDU1/ccc7VVbzof/3pTbxRZlx2joDiSTUzeGGRIKKP8brNLsn
	 olfbQQAeruwcGtN2awoNjFBgKexbSuiBK9On/FVAXeIsStmcAFdLdZTys2/XdIo2mw
	 p32LJBF6p2prQ==
Subject: Re: [PATCH net-next v10 02/11] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sun, 08 Nov 2026 00:15:33 +0000
Message-ID: <179409693331.994134.1742861805588596363@kernel.org>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-2-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-2-31b5a69b85b7@onsemi.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new framework duty bullet in Documentation/networking/oa-
  tc6-framework.rst (lines 156-158) gets the timestamp mechanism wrong.

--

Documentation: networking: Add timestamp related APIs to OA TC6 framework

This commit documents the new hardware timestamp APIs in the OA TC6
framework: PTP clock register/unregister, ts_info, hwtstamp get/set and
timestamp stats. It also documents the MMS based register read/write
helpers, and adds a framework bullet on how hardware timestamps are
updated in the skb.

> diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
> index 2545ef694016f..23856c4bfd691 100644
> --- a/Documentation/networking/oa-tc6-framework.rst
> +++ b/Documentation/networking/oa-tc6-framework.rst
> @@ -153,6 +153,10 @@ OPEN Alliance TC6 Framework
>  - Forwards the received Ethernet frame from 10Base-T1x MAC-PHY to n/w
>    subsystem.
>  
> +- If supported by the hardware and enabled, updates hardware timestamp
> +  in skb, when indicated by one of the three timestamp capture registers
> +  through TSC fields of the header.
> +

[Severity: Low]
Is this description accurate for both directions? The bullet comes right
after the receive forwarding bullet, so it reads like it is about the
receive path. The capture register / TSC mechanism only applies to
transmit, though.

In the implementation later in the series, in
drivers/net/ethernet/oa_tc6/oa_tc6_main.c, only the transmit data header
sets TSC:

    FIELD_PREP(OA_TC6_DATA_HEADER_TSC_OFFSET, tsc) |

The captured value is then read back from the TTSCA/B/C registers after
STATUS0 signals that it is ready.

The receive side works differently. The RTSA bit in the receive data
footer marks a timestamp carried in-band:

    ski->rtsa = FIELD_GET(OA_TC6_DATA_FOOTER_RTSA_VALID, footer);

The framework then writes that in-band value straight into the skb:

    hw_ts = skb_hwtstamps(skb);
    memset(hw_ts, 0, sizeof(*hw_ts));
    hw_ts->hwtstamp = ktime_set(ts[0], ts[1]);

This path uses no capture register or TSC field.

Could this bullet be split into separate TX and RX descriptions? The later
"net: ethernet: oa_tc6: Support for hardware timestamp" patch leaves this
text unchanged, so it stays this way at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7%40onsemi.com
