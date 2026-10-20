Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460489;
	b=T7SAkcD0hfE3rA+nMPv8v4KIOoEcJsqTUH7a+DrqsbS5z6f6Tld8uRXpRmE1djBnOY+Q
	 khtzBvXlJZIPsT0mjXpcUcpxIqR8dtrMQzzeYbvQT6p66MdepD9AZNf/qKOhRy2Iz26+L
	 f/TeLTuQuHmO7mQem2GqF88rItpkqlqMYdtaYmD3m1Pj/VxZ3tBsiIjoayW9DWAM/vo87
	 glqTJaM4Y2WbXqYFk0Y3BoIYEnPJ2JwuUFH4kUoHnfLa2/eB7YzskYuQokugQDB1ZkkbO
	 BrvBNXVV15+hi5fmJEvKwJ2+QmgtqqRT2hI05Ri8K7zFqHZ8UQDGE0s9s76Ka1sQ9UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460489;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OSYF1NwugUVOIfmyavH/lgXJtnbm8axpRYf+453IfXI=;
	b=AxwE9+e3xGcRFGLQ2shBMOizy7GfQ4NOzOVQ1clUulGz+xn5PIuY92V3gm3YRC/wsEzf
	 FOnUmc8xYgNTlhYkTXMoFhHQZU4HEWWJOE5CV748ix4pvKOTrCWwMvaQY2/2/nXXFytsK
	 eO9qBK65QBKCObn4okFTM91vtypwB2NTRt4MoJmaFf/92j4+8ia5O0xg7HO+g9QHoEwvm
	 NOkkLrmrBoS4P3wrXAESxOFZkr/HkIPabs616qC3QiLd+6k2UiUn9mowjKlAh5G0/H1au
	 Fw8TVfbW1FtfjXprAgLIewL3zXLvE7tiwNpeoGNQ+VwXz0g9uBWTD46eLUlbncX3vag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rmr/Y751";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F8606A321;
	Tue, 20 Oct 2026 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmr/Y751
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32871F000C5;
	Tue, 20 Oct 2026 01:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460488;
	bh=OSYF1NwugUVOIfmyavH/lgXJtnbm8axpRYf+453IfXI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rmr/Y7518FkX/XqrQBIxXgYFQMLyu5szj62mX/3lkC+wHy8/FeV7itYT2wi5T/EAF
	 jbt3TImbq0MIowaI5AGM18Uu7NwGf/o27hqRjQ2HQqExshhdhzNXe+zkU+g3LI6Nos
	 9IZhM+AxeBJ5rA8urC3XbcrYO+J0ujMiOkY6HnZW6M/Z877SxdqH9V/q/p7diJTtVg
	 RsfLD1XU5yVxTPu47IML4Ief4cudPa+PC02eOVhq1aqXsb0LXJgqhkisPVFIcBzUfo
	 DhDyEFf+aonhRuk8jXb2Nn2Zo0btdL4NxLjNZI9gUrcHhqB5dB5wUncvgmO5qDOEVF
	 bCtYfFz+I1KZQ==
Subject: Re: [PATCH net-next v6 3/9] net: dsa: realtek: rtl8365mb: set speed
 for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 01:41:27 +0000
Message-ID: <179246048740.3135.14592585398817212074@kernel.org>
In-Reply-To: <75829f0c-69d4-4c16-8300-142023f840d7@yahoo.com>
References: <75829f0c-69d4-4c16-8300-142023f840d7@yahoo.com>
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

- [Low] This finding was checked and rejected as a false positive,
  because later patches in the series finish the work.

--

net: dsa: realtek: rtl8365mb: set speed for family D

This commit adds family D handling to rtl8365mb_ext_config_forcemode().
On family D, 2500M uses its own speed value (5), and the top speed bit
goes into a new FORCE_SPEED2 field. The forced-mode configuration is
written to a per-port register at 0x12c0 + port, and forced mode is
enabled by writing 0xFFFF to 0x12c8 + port, while family C keeps its
existing behaviour.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 840db5ad32efe..2dabc4da861f4 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1646,23 +1669,32 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
>  	u32 r_duplex;
>  	u32 r_speed;
>  	u32 r_link;
> +	bool is_d;
>  	int val;
>  	int ret;
>  
>  	if (!extint)
>  		return -ENODEV;
>  
> +	is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;

[Severity: Low]
This isn't a bug, but can the family D branch run at this point in the
series? Every rtl8365mb_chip_infos[] entry is still RTL8365MB_FAMILY_C
here. So is_d is always false, and rtl8365mb_ext_config_forcemode() only
takes the family C path.

Later patches in the series make the path reachable:

  "net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support" adds
  the family D SerDes setup to rtl8365mb_pcs_config(). It also makes
  rtl8365mb_pcs_link_up() return early on family D.

  "net: dsa: realtek: rtl8365mb: add support for RTL8367S-VB" adds the
  first FAMILY_D chip, with extint ports 6 and 7. That keeps
  0x12c0 + port below the 0x12c8 enable window.

The other preparatory patches in the series say that the family D path
stays unreachable until the final chip table patch. Could this commit
message say the same?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/5a4715dd-89e0-4868-9ffb-c8fb73b18d04%40yahoo.com
