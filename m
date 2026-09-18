Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F7331EB0;
	Fri, 18 Sep 2026 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789705072; cv=none; b=I/UyOR37clCc0XHVqpEW/LD6MbqiZU+8/svUCqroKOjAF3WmWzt3KNoDY5P0bGFDXt7jUWdDnFsuLQbb7qLmfhB2wklKh7oSzlbHAAbzLx1r0IeLO5jruEHFzXHFrLcwVS7DR/qhLCaUHEF2e+EX88OgX9p/N/j2HpxrkZPT2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789705072; c=relaxed/simple;
	bh=Ae2y/7Lor9GXygTSiajiM9tRdhivw8M0DHKfjYgiGjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bS4luwIuk7XcSVNREVpkj4xwMBITpJ2BK5oB+iBEUw9UbAxI3Wf/6w2a2D7Js5/7MtPF7hG5WJW59ftTIDYJ++rUHUQcwHJACfORlslw4I0VyVjSCakq3oE+roUED8AavU+xV2K5UruGK9SnO3n/AZgtaY14xCWFVq2/g3r2st8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=t6Nhw73t; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="t6Nhw73t"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 0669540198;
	Fri, 18 Sep 2026 14:17:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789705055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x5/5jYTk97QiuhKteVx/RjbUQ68rvY/RzcvH0sprR9c=;
	b=t6Nhw73tsb751+JJrDIUFANMISU+10SS6C8/C1CscNgtzDyyuCWuxLVaswC6gcbeV0qQjT
	Rv3HtPDW9OY4MLkpBlMtFgeJcwXcvf6sMe1w2DNBs0V4e5MOPeHVLbingPYipMOF3FhjuV
	LeP/Iicnqyg+SXFSOvXG185o+m9izR94q9dqR7uQTTHad4a4SgB6NoK7505D2IHmaLo02o
	3dobayPCvzblQXD4Y6jYKEG1jd1aF4H2vIhwGi/1tu+nik8YM1HJCvKXezXM/E2vobV6la
	4R/iC55Dm5GhkXX3jL739q4h53C5JHZjRnoOxx95TAxx3fKQ3OiM8fkabGUEqw==
X-GPT-Reason: legitimate_transactional_technical_discussion; the
	content is a highly technical Linux kernel patch discussion (net-next)
	regarding stmmac driver support for Allwinner H616; the sender
	(alastair@d-silva.org) matches a personal/professional mailbox
	and the technical depth, including iperf3 results, kernel logs, and
	specific register offsets (0x34, 0x05), confirms a genuine engineering
	workflow; the URL domains kernel.org and msgid.link are standard
	for kernel development and do not exhibit phishing indicators.
Message-ID: <9cd900993fc385ccffcf743f629e87071be9820a.camel@d-silva.org>
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: add Allwinner H616 EMAC1
 support
From: Alastair D'Silva <alastair@d-silva.org>
To: James Hilliard <james.hilliard1@gmail.com>, Richard Genoud	
 <richard.genoud@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro	
 <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Chevallier	 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Fri, 18 Sep 2026 14:17:34 +1000
In-Reply-To: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
References: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
Autocrypt: addr=alastair@d-silva.org; prefer-encrypt=mutual;
 keydata=mQINBGactvoBEADBFM2HqfQUUM4j40ZQPyYzmnM8S6zrycO0ipDDPMs7nZMzyzGzOdqfS
 VB/tuYvZOOKVWzJuWJ5aT/YyHx54r3L+D5hTkEG0sXPVJky3yTS9sbHEMSLBHb8TVVuhPVPuieV4g
 Nkqg5POMTidk8xAw50WpV++tUlewXVSciehnuCQPXhXMP7FcCh4uO8LdN7E8m7ir1LafKTFfoWPah
 KVT8NGG9r+ucrFcN5F+VnHxTDaI68yRPkNdtUWmp22wIX1KwDCtKFrndYO4p5Hv2hlDKomsuIIHHn
 muQGRwuh0xpf0nVJNF8ETZHMzxQLfo3e/HvxBFOTkwY9w7CuuQFZchbhS0I3PfmGT0+jiNcdfqjDC
 fPPB5uhy+DkR6wO72vuwFYUrpU2mdliDSdKEtWBHulnXMJjpBOXetfIwhI8G2dTVg59lN5i9DvJZc
 7y1Sp+qfZQ4P9qpYZyQEKR4GNDOdnm6F2LW2cZkcyAU/Ii765zdDMTQMIzZNSxT/FcDd0K1voTNRl
 QHbQw+kmIMhzSv2JefcC9oNbE0XYzcBDNP5T3O/4itOQ90GCKQEPAbIPeBjlQif7kkyvo/H6yv4s9
 duuK7zbJD9AID/+KGLkpU3p68VDB/C2ZSb9rQz3p1CJNSfsX/CPk7sPqA7RKZ4a2B0hSJ2pJCncNZ
 KXtMlkkm/FmewARAQABtCdBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz6JAl
 EEEwEKADsWIQTQGemDFwqYyU/dBWv75AdnjVo60gUCZpy2+gIbAwULCQgHAgIiAgYVCgkICwIEFgI
 DAQIeBwIXgAAKCRD75AdnjVo60qHZEACJnLfpS71Hk8bX0CLCNJ5wgqdZD3pBHEdbv9Ux9kRlZp4a
 ZFwlg9ltwBjl2dZP3PLtD9xQdsdYKVippKd5a7ZZC2y81oDaHjeC9LnPYn8+ce3mGE/+gRyoNfToY
 N06DeUNJKSlZ9t11UIqZCgfp12u16/Yrigy8C4ihEeHXlLhNX6JkeJR5gsHXJnC7vSuMZY+Qz2R72
 ZidWg+cd2WDMGop5sbTvc+55q94A7vTMlWzaix5HdbEUA3sd2U0dMBju5QodRGGhDQMcCu64TydRD
 MtMzzOk9ThJ036ze3HASWGOppyQmaw58k+XNzbHlr9Sc1LsFUNF7zpWXac2rzlywbyRAdFIT/TC76
 hy9zOkwIo2nwA/tdIwLx1j0UZPpAMQmcDUvJqZh6sE+fv6HN0yMPr+sSYJmriMt8Z6leCEHQXOHVI
 SI5z5FvV3coMmHYRq6aXpfs/8SLiYgkV3B0HE/E18Y3j1OkeLYoqIH1VfzQZeCSL/S77NYvk60/MV
 1HFSyqLdUR3uWZI4uZzoEcMoB0GX33uCTp2Ntc00+wSntwekCUQLCMLUb7dZrbpVuobHoWWtkiD2I
 uE5kAiaVwwwzM0BUwiM6VzVoKbeECz93rdsNtwoDqM0NtzoISC46H/BKVQ9mRNXDO4ThEBpJ4H2Tn
 mPNRYYcR0u2mNy1EJII04w==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Thu, 2026-09-17 at 11:55 -0600, James Hilliard wrote:
> The H616 secondary EMAC supports RMII at 10/100 Mbps and uses a
> separate
> system-control clock register at offset 0x34. Add its binding and a
> sun8i stmmac variant using that register. A distinct compatible
> without
> an older fallback prevents the driver from using EMAC0's clock
> register.
>=20
> EMAC1 connects internally to the co-packaged AC200 or AC300 EPHY and
> has
> no external PHY pins. Leave PHY initialization to the PHY driver
> instead
> of using the H3 internal-PHY controls. The RMII-only variant does not
> expose the RGMII clock-delay properties.
>=20
> First move the MAC software reset from probe to the DMA reset
> callback,
> after PHY initialization. This lets the MAC and its MDIO bus remain
> registered when the PHY driver or one of its suppliers is not ready
> yet.
> Keep the separate H3 MDIO-mux reset sequence unchanged.
>=20
> The AC200/AC300 EPHY driver and package bindings are already in
> net-next. This series separates the H616 EMAC1 MAC driver and binding
> support from the earlier combined series. PWM, MFD and device-tree
> enablement are being handled separately.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v3:
> - Add a prerequisite fix moving the MAC software reset to the DMA
> reset
> =C2=A0 callback, after PHY initialization, so delayed module loading and
> =C2=A0 deferred PHY probes do not tear down the MAC and its MDIO bus.
> - Preserve the H3 MDIO-mux reset and propagate hardware-reset
> failures
> =C2=A0 through the normal stmmac hardware-setup error path.
> - Add Alastair D'Silva to Cc and rebase onto current net-next.
> - Link to v2: https://patch.msgid.link/20260915-submit-h616-emac1-v1-
> v2-0-322b32e40eb9@gmail.com
>=20
> Changes in v2:
> - Drop EMAC1 TX/RX clock-delay property support and keep the existing
> =C2=A0 RGMII-only delay descriptions unchanged, as requested by Maxime
> Ripard.
> - Clarify that EMAC1 connects internally to a co-packaged PHY, not an
> =C2=A0 external PHY or the H3-style internal-PHY controls.
> - Rebase onto current net-next.
> - Link to v1: https://patch.msgid.link/20260915-submit-h616-emac1-v1-
> v1-0-195de0bb1f8a@gmail.com
>=20
> ---
> James Hilliard (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net: stmmac: sun8i: reset the MAC after PH=
Y initialization
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: net: allwinner: add H616 EMAC=
1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net: stmmac: sun8i: add support for Allwin=
ner H616 EMAC1
>=20
> =C2=A0.../bindings/net/allwinner,sun8i-a83t-emac.yaml=C2=A0=C2=A0=C2=A0 |=
 13 +++++
> =C2=A0.../devicetree/bindings/net/snps,dwmac.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A0drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c=C2=A0 | 66
> +++++++++++++---------
> =C2=A03 files changed, 55 insertions(+), 26 deletions(-)
> ---
> base-commit: 26ee8cd69d46a14b37ba5e512084fe80d730127a
> change-id: 20260914-submit-h616-emac1-v1-143703842abb
>=20
> Best regards,
> --=C2=A0=20
> James Hilliard <james.hilliard1@gmail.com>
>=20

Confirmed working on the Mellow Fly C5 when brought in as a module and
backported to 6.18, tested in the Armbian environment, along with the
recommended PWM patch:
https://lore.kernel.org/all/20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.co=
m/T/


root@mellowflyc5:~# lsmod
Module                  Size  Used by
rtw88_8821cs           12288  0
rtw88_8821c            86016  1 rtw88_8821cs
rtw88_sdio             20480  1 rtw88_8821cs
rtw88_core            180224  2 rtw88_8821c,rtw88_sdio
snd_soc_hdmi_codec     16384  0
mac80211              929792  2 rtw88_sdio,rtw88_core
zram                   36864  2
842_decompress         12288  1 zram
842_compress           16384  1 zram
gs_usb                 20480  0
can_dev                36864  1 gs_usb
dw_hdmi_i2s_audio      12288  0
dw_hdmi_cec            12288  0
cdc_acm                32768  0
sun50i_h6_prcm_ppu     12288  0
panfrost               73728  0
governor_simpleondemand    12288  0
gpu_sched              45056  1 panfrost
sun8i_ce               36864  0
drm_shmem_helper       24576  1 panfrost
crypto_engine          12288  1 sun8i_ce
cfg80211              831488  2 rtw88_core,mac80211
binfmt_misc            16384  1
rfkill                 24576  2 cfg80211
sch_fq_codel           16384  2
fuse                  163840  1
configfs               40960  1
nfnetlink              16384  2
ip_tables              24576  0
x_tables               28672  1 ip_tables
btrfs                1441792  0
blake2b_generic        16384  0
xor                    12288  1 btrfs
raid6_pq               94208  1 btrfs
ac300_phy              12288  1
ac200_phy              12288  0
dwmac_sun8i            20480  0

root@mellowflyc5:~# uname -a
Linux mellowflyc5 6.18.52-current-sunxi64 #27 SMP PREEMPT Mon Sep 14
21:36:19 AEST 2026 aarch64 GNU/Linux

root@mellowflyc5:~# ifconfig end0
end0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.1.136  netmask 255.255.255.0  broadcast 10.0.1.255
        inet6 fe80::9aff:fea2:59e8  prefixlen 64  scopeid 0x20<link>
        ether 02:00:9a:a2:59:e8  txqueuelen 1000  (Ethernet)
        RX packets 5202  bytes 941999 (919.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 4059  bytes 431730 (421.6 KiB)
        TX errors 0  dropped 5 overruns 0  carrier 0  collisions 0
        device interrupt 50 =20

root@mellowflyc5:~# iperf3 -c 10.0.1.1
Connecting to host 10.0.1.1, port 5201
[  5] local 10.0.1.136 port 53578 connected to 10.0.1.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  12.0 MBytes   101 Mbits/sec    0    191 KBytes
[  5]   1.00-2.00   sec  11.5 MBytes  96.5 Mbits/sec    0    191 KBytes
[  5]   2.00-3.00   sec  11.1 MBytes  93.3 Mbits/sec    0    191 KBytes
[  5]   3.00-4.00   sec  11.2 MBytes  94.4 Mbits/sec    0    191 KBytes
[  5]   4.00-5.00   sec  11.2 MBytes  94.4 Mbits/sec    0    191 KBytes
[  5]   5.00-6.00   sec  11.1 MBytes  93.3 Mbits/sec    0    191 KBytes
[  5]   6.00-7.00   sec  11.4 MBytes  95.4 Mbits/sec    0    191 KBytes
[  5]   7.00-8.00   sec  11.2 MBytes  94.3 Mbits/sec    0    191 KBytes
[  5]   8.00-9.00   sec  11.2 MBytes  94.4 Mbits/sec    0    191 KBytes
[  5]   9.00-10.00  sec  11.1 MBytes  93.2 Mbits/sec    0    191 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   113 MBytes  95.0 Mbits/sec    0          =20
sender
[  5]   0.00-10.01  sec   112 MBytes  94.1 Mbits/sec                =20
receiver

iperf Done.



I did notice that the speed and activity LEDs on the magjack remained
dark.

LED Output Pad Enables (Register 0x05 - SYS_IO)
-----------------------------------------------

According to the AC300 datasheet (Section 4.2.5), bits [3:1] default to
0 (disabled):
   - Bit 1: E_LNK_LED_IO_EN
   - Bit 2: E_SPD_LED_IO_EN
   - Bit 3: E_DPX_LED_IO_EN

In drivers/net/phy/xpowers/ac300.c, AC300_SYS_IO_VALUE does not set =C2=A0=
=20
any of these bits. Consequently, the LED outputs remain disabled/tri-
stated, and neither the link nor speed LEDs illuminate on the board.

LED Polarity (Register 0x06 - EPHY_CONFIG)
------------------------------------------

Once the I/O pads are enabled, Register 0x06 bit 1 (LED_POL) controls
the drive logic:
   - Bit 1 =3D 0: Active-High (Default)
   - Bit 1 =3D 1: Active-Low

Because common RJ45 magjacks (such as the HY911105AE on Fly-C5, Orange
Pi Zero 2W/3, etc.) have LED anodes connected to 3.3V, the PHY must
sink current (Active-Low) to drive them. Without setting LED_POL =3D 1,
the LED logic is inverted.

Could we update AC300_SYS_IO_VALUE to enable the LED IO pads, and
configure LED_POL for active-low operation (or wire it up to the phylib
LED framework)?


Suggested patch for drivers/net/phy/xpowers/ac300.c:

--- a/drivers/net/phy/xpowers/ac300.c
+++ b/drivers/net/phy/xpowers/ac300.c
@@ -43,10 +43,14 @@
 #define AC300_IO_DRV_LEVEL_2			2
 #define AC300_CLKIN_PAD_ENABLE			BIT(4)
+#define AC300_EPHY_DPX_LED_IO_ENABLE		BIT(3)
+#define AC300_EPHY_SPD_LED_IO_ENABLE		BIT(2)
+#define AC300_EPHY_LNK_LED_IO_ENABLE		BIT(1)
 #define AC300_EPHY_MII_IO_ENABLE		BIT(0)
=20
 #define AC300_EPHY_CONFIG_REG			0x06
 #define AC300_EPHY_BGS_EFFUSE_MASK		GENMASK(15, 12)
 #define AC300_EPHY_RMII_SEL			BIT(11)
+#define AC300_EPHY_LED_POL_ACTIVE_LOW		BIT(1)
 #define AC300_EPHY_SHUTDOWN			BIT(0)
=20
@@ -58,7 +62,10 @@
 #define AC300_SYS_IO_VALUE \
 	(FIELD_PREP(AC300_MDIO_DRV_MASK, AC300_IO_DRV_LEVEL_2) | \
 	 FIELD_PREP(AC300_MII_DRV_MASK, AC300_IO_DRV_LEVEL_2) | \
-	 AC300_CLKIN_PAD_ENABLE | AC300_EPHY_MII_IO_ENABLE)
+	 AC300_CLKIN_PAD_ENABLE | AC300_EPHY_MII_IO_ENABLE | \
+	 AC300_EPHY_LNK_LED_IO_ENABLE | \
+	 AC300_EPHY_SPD_LED_IO_ENABLE | \
+	 AC300_EPHY_DPX_LED_IO_ENABLE)
=20
 static u16 ac300_ephy_ctl_config(const struct ac300_ephy_ctl *priv)
 {
@@ -131,7 +138,8 @@ static u16 ac300_ephy_ctl_config(const struct
ac300_ephy_ctl *priv)
 	return priv->ephy_config |
+		AC300_EPHY_LED_POL_ACTIVE_LOW |
 		(priv->interface =3D=3D PHY_INTERFACE_MODE_RMII ?
 		 AC300_EPHY_RMII_SEL : 0);
 }


--=20
Alastair D'Silva



