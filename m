Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2742E737D;
	Mon, 12 Oct 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823903; cv=none; b=LJD3LY18LOBu63OdgOVcU8U21vcIfg3jwYIUI7Ehj700JtX08qlu7G870kI8wCptUPJmHTmKmWVioYwuPPOLlpHKMOUS/7xfPowxQtJz+TtcpE5RBYT72Y5Dl5DJdhL3npsoh1SCjfjmQu0L/2WCF92fzh/ts59NDhVG3PRANjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823903; c=relaxed/simple;
	bh=RQydqv4XJcasiRQuUFPvomHpu3S+M+YdF/tmAgc4t00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TBK3pribfF15U3HALttorKcr7bjeXrMQzwdM4BKImlYnMk13dnmIF/A+NjHLZlHiR/GU5SPO30CFl9fJ5xx5fxrZt1Q3YqRtLXsMAPjAE5x5l2pHu7gRepRYOzFrxV6bY3l8D6V/3+jDjxa7Qk0apoVudXf6TUv+vXchsBrrcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=aCJvWEq3; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="aCJvWEq3"
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=aCJvWEq3;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.2/8.18.2) with ESMTPSA id 69CGZWEc790305
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 17:35:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1791822932; bh=nHOetBiDekJwWPGeGPktITGpQNmqnuv3FWLxPY57pPs=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=aCJvWEq33ThyxGcgvykeF24eHjFSIln8357sLW74qJt9qmu21hG2zoZxYBn+Z2HE1
	 /Z6xkZ3UOgcgYbpC8nE8k6rPREVBMYkx0lf9MMfUqsBuIf5BN2DwcnZ8BLRRKYUdJV
	 1KRZBb0ul1kl22HnJAox9twwuc7POS/pmTHIrf0g=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.2/8.18.2) with ESMTPSA id 69CGZWcL894584
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 18:35:32 +0200
Received: (nullmailer pid 905597 invoked by uid 1000);
	Mon, 12 Oct 2026 16:35:32 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, daniel@makrotopia.org,
        dqfext@gmail.com, SkyLake.Huang@mediatek.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
        sean.wang@mediatek.com, olteanv@gmail.com, yangshiji66@outlook.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v3] net: phy: mediatek-ge: disable EEE on the MT7530
 PHY
In-Reply-To: <20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com>
	(Vladislav Karmanov's message of "Fri, 4 Sep 2026 23:28:00 +0300")
Organization: m
References: <20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com>
Date: Mon, 12 Oct 2026 18:35:32 +0200
Message-ID: <87cxteri5n.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

Vladislav Karmanov <vladislav.karmanov.dev@gmail.com> writes:

> The MT7530 internal GE PHY advertises EEE by hardware default, but its
> EEE support is defective: with EEE advertised, some link partners fail
> to establish a stable link. On a 2-pair (4-wire) cable where both ends
> advertise gigabit, 1000BASE-T training cannot succeed, and instead of
> falling back to 100 Mbps the port loops, so no link or DHCP lease is
> ever obtained.

I realize that I'm too late at the party here, but I still want to state
this for the record:

I just tried to reproduce this bug on a Zyxel NR7101, using a cable with
pair 4 cut, connecting to the I219-LM controller in my laptop.  Without
success.

EEE enabled or not does not make any difference.  The link is negotiated
as 100Mb/s as expected, and it is completely stable.  Absolutely no
issues observed.  I even added a .link_change_notify callback with a
counter and a printk to the phy driver to make sure I didn't miss any
flapping.

MT7621 side:

root@OpenWrt:~# ethtool --show-eee lan
EEE settings for lan:
        EEE status: enabled - active
        Tx LPI: 30 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full
root@OpenWrt:~# ethtool lan
Settings for lan:
        Supported ports: [ TP    MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
        Link partner advertised pause frame use: No
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Auto-negotiation: on
        master-slave cfg: preferred master
        master-slave status: master
        Port: Twisted Pair
        PHYAD: 2
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
        Link detected: yes

I219-LM side:

root@miraculix:/tmp# ethtool --show-eee eth0
EEE settings for eth0:
        EEE status: enabled - active
        Tx LPI: 17 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full
root@miraculix:/tmp# ethtool eth0
Settings for eth0:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Auto-negotiation: on
        Port: Twisted Pair
        PHYAD: 2
        Transceiver: internal
        MDI-X: on (auto)
        Supports Wake-on: pumbg
        Wake-on: d
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: yes


So now I am curious to know:  What am I doing wrong here?

I primarily did this test because I wanted to implement a smarter
workaround, without forcibly disabling EEE for everyone based on one
pretty obscure configuration.  But that's hard without being able to
reproduce the problem.

So let me ask you, who seem to be able to reproduce it:  Why is it
necessary to block EEE for everyone? Why can't you disable EEE by
default, but let me enable it on my systems - where I know it works?

Or even better:  Why can't you detect the link flaps and only disable
EEE when required? (this was my plan)

FWIW, I have been using EEE on MT7621 devices for years without ever
noticing the claimed issue.  I have heard the rumours that the SoC is
supposed to have occasional link issues, and that they are related to
EEE.  But reproducing the issue has so far been impossible.

> MediaTek confirms the hardware is the root cause (Landen
> Chao, 2021): "EEE of the 10-year-old MT7530 internal gephy has many IOT
> problems, so it is recommended to disable its EEE."

This is BS. I don't doubt that there are bugs in the MT7530 gephy. But
the EEE feature of the MT7530 internal gephy works fine for me.  And
always has.

Vendors have no interest in making older hardware work. There is no
reason to ask them or trust them when it comes to hardware they don't
sell anymore.

We can do better. And we have, by for example bringing DSA to the
MT7621. Please, let's try to make even old hardware work as good as
possible.  Disabling features is not the way to go.

> Auto-negotiation then falls back to a stable 100 Mbps link instead of
> looping at gigabit. Tested on ASUS RT-AX53U (MT7621): with a 2-pair
> cable on the WAN port, a single clean 100 Mbps link comes up and a
> DHCP lease is obtained, where the unpatched driver loops.

And no I've tested the same configuration with EEE enabled, and it
doesn't loop either.

Where does that put us?


Bj=C3=B8rn
