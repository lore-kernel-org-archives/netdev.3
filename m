Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779691;
	b=GVEYOZZYsHKGrp9Jk560m2rAsdnYf0buFuXkzW2QX7rpC6PqDXni+e5wBTR1DXT/1H7e
	 wJc2fcYKxVHhMMojM7SU/rAxYR0KESlNKDpCQpP90uWGZcsTYNKw2aHmYMuNxNmi9lloq
	 T0AYzm9nR+IduLUCsQdAyZG3nB96tJ+KwsYN1HbelVDZJB6aOEw49c11HctHzNvp0a3yn
	 XyQz634PTQlj4rIN98DKnHTPVeQNoKRfhdr4sJS1xoXnxUNdgnp0NAcoLUrcGOwpJouWu
	 3So+CE3jCUtYWYOSMjJsfBjO2iGLY0Xs5xU6vdB0MVUHqglxslwnJdSVNbXz8R6lcYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779691;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IOB/DMG8E0H1LG/g/S6WJ7zKwN49Fb8gn4W1dEispPc=;
	b=WQwfLCf30VS/FClJ6eK5UdbugYuV4iO2Kilo2o+ZuDM+jXbqWR+WsZnaoCgSbE59wuyZ
	 d2Sk5CYPErEijfrKFf4C7KG9Ac6pIBC1jtDetS1IxHYBWLvE2DH3/nvrcJjUCU8suyg4h
	 MQIosARtUiIbBhgSk78Bn/rrlu6jT/sjHJxoJonXy+9Ko1Gxs8cUWVbXPuHS5ciCJpgFV
	 YXX1OJc8VZCh6bwcutqkWdzokYsqMW5qeeqEVqmQadT0c61QrrrUtHIAnnWDea2w+E24Q
	 znU5GyS8aktSyvJ2irQxre2q4HV69Z0s0pMlAxUP1GipyCkgt1zr8Q1H0yw4a0yiCzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C473606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C473606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7ccb2ffe333so266067137.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779690; x=1794384490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IOB/DMG8E0H1LG/g/S6WJ7zKwN49Fb8gn4W1dEispPc=;
        b=QwoQMCXTpUHwT0+eFA1ePzPq9SXj2i54aUqXVsdUloGf2iJ5FIXqQbFjFRNrzlvRYj
         +Dwueqz1WyX+7TNCMkMeqT2ZSjdRqzseAK2h74Ub3vv2RNis94UAoJJqETCso2U+urkV
         ttsfD+xidE108MhMXOi8Rb2TF/Z+ucWvLSkylueQ2jfL7nWTspkkBPyW/9K03r4aywXi
         Lk0GQwKp8chAHR4lY3l3myNfTidqscjilfG02u014U+BEZxkkKPIDFqTwt4rvzJjSNJh
         OIdA9MfqcIrTtdMTN1EVxXYeh1rD7gu3RT9IuRAxznsXPMRKJz77QsM53FZD59raDQxm
         Flfg==
X-Forwarded-Encrypted: i=1; AKwUvBw9X93Jj8URpoKhBJtvPSoiFI83pLy9lr2xmqmf+ScVqsqLoGizqs65zKDyj4V2hv6bBFRJ1ME=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lGmq0U0VhtQjC4wnd+3v1f2aJXWLWn3Kq46HfL/CwWjPtJiub
	7twVC0DCe6dV1PDtaBRUaJtD/EEVbxw+X4VavZiB9mE99OdKcqnvCo+vs9fjzBb7
X-Gm-Gg: AYBFou0X/Gz1iqFz83+2tlOAoUHgpNdheVjWrsQPKpHdlVgmjkLafqUbiELM63ZMOwv
	by0CiTRMQkmlH71SaHP5Uj5Q5mnr0zDYcFwRFVVnp1MqMm4EQRyvA5sY3VD+4vELt5ixetu3PKd
	hJ/PAtK3ca73Xd9QdGxcHtGSj4xphNE+gQK7bDqPg+LDdrYO8aUE+ErVa8eg1VjEZ6QYXNjRdUG
	LgfbVNl0UBUgn2jnBg4XZfoFXDN/2+z+OvAtdEItcORqV0SH0T3ni17I5JoZy24RMNgtYcSFdkf
	3ljPhCbkZE2jMN3Aqi9LsBBrRNSgMCvlbTEITXs9UXT3f+NVtmcttk7qGgPztoUqBtKbSuQjAhs
	W3J5bgL6s5j5dPNQfVrMpzpGWGq4C1sItILwN+9ocrK0AdfBOHwKq0eYmgqioPa+IaOzJVaGvPf
	FHrI+ktouifKfqDl8TOEb6NVzgKN+1451EwvBEQ5ZejpFQxDfM6VNdlUEMWWvbozzaZ3WrHq1XA
	uY0Y0B2gTQCLr+MUu8cSLcS4VdsMjYvOt7A+f2aGwUosspetuTF7qj/vZk6NXmcOunNHzNG9tFa
	4H9fiJcWJCMPuiAOBqr2KEi03n8R8GAlTYHPyHo/4hMVjWT/UwVIFDaF6u1QrQ5MMk5VhkjZWG0
	yipPBwavsnGRFwoU+t+ZsrmyO1eKC+AqChNVt/mQOXRe/
X-Received: by 2002:a05:6102:580c:b0:7af:fef2:8ecf with SMTP id ada2fe7eead31-7d072bc7564mr6389183137.8.1793779689868;
        Wed, 04 Nov 2026 00:08:09 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998da178b59sm1252958241.12.2026.11.04.00.08.08
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:08:09 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eafb65e163so280753e0c.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:08:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByoefwk3Dorg9j9WKKgPD4xaw5gmspWzQSvOW1iVbEDgjq9tvuBEyv4Woz0+Of2f/15GjhUg3k=@vger.kernel.org
X-Received: by 2002:a05:693c:42d3:b0:369:faa2:1fb2 with SMTP id
 5a478bee46e88-36a4236a650mr23219527eec.8.1793779365508; Wed, 04 Nov 2026
 00:02:45 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev> <963ddb89-fada-4340-b767-285ce9362d1e@bootlin.com>
In-Reply-To: <963ddb89-fada-4340-b767-285ce9362d1e@bootlin.com>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 4 Nov 2026 03:02:34 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ4Y3Zgq7OV00LedV=wty-pqR=4t70XgWYTbdfzCeaH-Cg@mail.gmail.com>
X-Gm-Features: AclHuK8VH8JEq69kYaCOOBuUsCrdovmtS3uWzk_R-GaR7GJ1IVUq8iGvFERmNvs
Message-ID: <CAPY4CJ4Y3Zgq7OV00LedV=wty-pqR=4t70XgWYTbdfzCeaH-Cg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: stmmac: Add the Siflower SF19A2890 glue
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chuanhong Guo <gch981213@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 11/4/26 08:53, Maxime Chevallier wrote:
>> The MAINTAINERS entry that covers these files comes with the MIPS series
>> "MIPS: Add support for the Siflower SF19A2890"; this series applies on
>> its own. That entry is also why checkpatch's question about updating
>> MAINTAINERS for the new files is left unanswered here.
>
> hmm not sure this is the common practice, usually you update MAINTAINERS
> along with the driver introduction. This should be part of this series.

Makes sense, v2 will add a MAINTAINERS entry for the glue and its
binding.

>> - the MAC address from the factory partition, and ethtool reporting the
>>   link with no PCS workaround.
>
> no PCS workaround ? what's that about ?

The OpenWrt driver this is based on set STMMAC_FLAG_HAS_INTEGRATED_PCS,
because the core reports a PCS whose link status doesn't work in RGMII
mode. stmmac now only uses the integrated PCS for SGMII and the flag is
gone, so the glue needs nothing for it. That line was only meant to say
the link is reported correctly without it; I'll word it better in v2.

On Wed, Nov 4, 2026 at 2:59=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi Joseph,
>
> On 11/4/26 08:22, Joseph Telaak via B4 Relay wrote:
> > The Siflower SF19A2890, a MIPS SoC for home routers, has a DesignWare
> > GMAC 3.73a. Its interface type and RGMII clock delays are set in a
> > small configuration block next to its clock and reset manager. This
> > series adds a binding and the glue.
> >
> > The glue is based on Chuanhong Guo's driver, which read the RGMII delay=
s
> > from a factory flash cell in the delay line's own units and always
> > applied them. Here the delays come from rx-internal-delay-ps and
> > tx-internal-delay-ps and are applied only when those are present. The
> > interface type is set through set_phy_intf_sel.
> >
> > The delay line's step is not documented, so I measured it: sweeping
> > each delay register over 0-255 with the link at 1000 Mb/s, the working
> > windows repeat every 145 steps (TX) and 144.5 steps (RX), which is one
> > 8 ns period of the 125 MHz RGMII clock. So a step is about 55 ps. The
> > TX eye is about 3.1 ns wide and the RX eye about 1.75 ns; the delays th=
e
> > bootloader programs, 17 and 10 steps (935 and 550 ps), sit inside both.
> >
> > On the GL.iNet GL-SFT1200 the GMAC is the CPU port of a MaxLinear GSW15=
0
> > switch over RGMII with no delays on the board; the GMAC adds both.
> >
> > The MAINTAINERS entry that covers these files comes with the MIPS serie=
s
> > "MIPS: Add support for the Siflower SF19A2890"; this series applies on
> > its own. That entry is also why checkpatch's question about updating
> > MAINTAINERS for the new files is left unanswered here.
>
> hmm not sure this is the common practice, usually you update MAINTAINERS
> along with the driver introduction. This should be part of this series.
>
> >
> > Tested on a GL-SFT1200 with the GSW150 driver:
> > - each of WAN, LAN 1 and LAN 2 links at 1000 Mb/s full duplex and
> >   passes iperf3 both ways (160-205 Mb/s out, 262-273 Mb/s in, well
> >   under line rate; I have not looked into where the limit is);
> > - 10 GB each way through LAN 1, after which every CRC, alignment,
> >   error, drop, overflow and underflow counter on eth0 and lan1 is 0;
> > - 50 link down/up cycles, after which the link and traffic recover;
> > - the MAC address from the factory partition, and ethtool reporting the
> >   link with no PCS workaround.
>
> no PCS workaround ? what's that about ?
>
> Besides that, nice and simple glue, thanks ! :)
>
> Maxime
>
> >
> > ---
> > Joseph Telaak (2):
> >       dt-bindings: net: Add Siflower SF19A2890 GMAC
> >       net: stmmac: Add Siflower SF19A2890 glue
> >
> >  .../bindings/net/siflower,sf19a2890-gmac.yaml      | 110 +++++++++++++=
+
> >  .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig        |  11 ++
> >  drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
> >  .../net/ethernet/stmicro/stmmac/dwmac-sf19a2890.c  | 158 +++++++++++++=
++++++++
> >  5 files changed, 281 insertions(+)
> > ---
> > base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
> > change-id: 20261102-sf19a2890-gmac-4fb4808f869c
> >
> > Best regards,
> > --
> > Joseph Telaak <joseph@telaak.dev>
>
>
