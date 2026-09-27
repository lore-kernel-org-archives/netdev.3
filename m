Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC934B1A3;
	Sun, 27 Sep 2026 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790500730; cv=none; b=Rv8wcfKXNP4SSIeYnrKYTksWT7K2dCQzEsYM9c4eTR4ri4+92+knYNm0gQysafzao6YuILSSnjYAzJXClw7xuMQ/LECOK1qBwOtsbyWqqyiRVf9O8n+ex1qC3vJx9yM1uCrp5MYFfryQqA92EjnsHra8zu6gyUR0OXIyXnQncbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790500730; c=relaxed/simple;
	bh=5KKxFXVCDkHnaqMqq8MF6mLc2nqJJjH0UwR4Vui/CZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2uJDvMrUP4o7xVG/Hwusc9Wx1ntsxn0Vpq/9jiBKkFmK1lMIdVUqLuzzw9a7siZgOsQ7y69WeZvJSTcbqoKcbmoeN37bXSL4En3kyGBnGMLnVcOF4+0czoaFa4muVuAkD/0ORPNiSNTtROy2Izv85g/jHCo7+xq1o/vt24Gl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=XwNJjr80; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=GaAc+8ME; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="XwNJjr80";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="GaAc+8ME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500726;
	bh=5KKxFXVCDkHnaqMqq8MF6mLc2nqJJjH0UwR4Vui/CZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XwNJjr80EL9H1fpJB+ZqzBuLPvlvrXis4KTG0NiFa+UyZvekKVh8bFSQFnFYYBSqi
	 AviCfcy/+UWMBsq2nrgak2FuCvVUzMl8C9yrkMHww6ldi/T0IKtIWGrg2lwjvBVlje
	 lgHKvVKsD8SaW9mUM0aUdHuFVayd+cnarVCi9yVrheiW5X6jEpkhfPSQZT2iWAp5hu
	 bukEkFEv4s2Rr/jA5AKg7wRo3dnirMlsFT2MvGqCE+cc2S6pMBCszUKfpBtr/UGPI4
	 8FQm9tHv5UNSmVNLktXz5NJ9IBbK5vHug+X0cR32qOGFpUN1Rjz5fF8zw4v9l1ru3X
	 SUrkji8njblvw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 518AD4130C; Sun, 27 Sep 2026 09:18:46 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500723;
	bh=5KKxFXVCDkHnaqMqq8MF6mLc2nqJJjH0UwR4Vui/CZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GaAc+8MEXAHUEq//1eOTxPwUd9KY6zYapPoqxDSwehzxy7DfW/DnLIBt6Sp/BsQeM
	 RUkxG2DzcMfhTUZ5n2qdgNSRlOFGakfSgqjs8oZDu3zp01DhVs1cufIUy+LR/ziF7n
	 RvOH4mue/BO8EXJ80Qa7xAkF9t+fgzN99bIgOg7GPSknGqsXiXLLvLWqGBQOzzC016
	 uyE0BGxBN6g4AF9swe8tGzFxX2dunnZ6Hs2JGuSResY9G9EYoV4f05NNDU8fASm+Qg
	 1e2wZJNzZGDEf8tArUJAwka270eaOhoeOWPVhsFMSKGy95c4pOf0xulDfqTr/FecK7
	 fMdjsSjyebZdQ==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 590B8412E0;
	Sun, 27 Sep 2026 09:18:43 +0000 (UTC)
Message-ID: <e0d46169-2eea-434e-8467-8dbb14138650@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:18:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-6-60c04c9924a2@birger-koblitz.de>
 <178968029668.22033.6092490845837885048@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968029668.22033.6092490845837885048@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 27 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 4 · Medium: 19 · Low: 4
> 
> - [High] ax88179a_bind() advertises NETIF_F_HW_VLAN_CTAG_FILTER in
>    dev->features/hw_features while ax88179a_netdev_ops provides neither…
The relevant functions are added in a later commit.

> - [High] The three new device IDs inherit the single usb_driver
>    .suspend/.resume/.reset_resume of the legacy AX88179 code…
A later part of the patch series adds dedicated suspend/resume functions 
for these chips.

> - [High] ax88179a_rx_fixup() dereferences device-controlled metadata with
>    plain native-endian u64 pointer loads: `rx_hdr = *(u64…
Will be fixed.

> - [High] ax88179a_rx_fixup() enforces only an upper packet-length bound
>    (`pkt_len > dev->hard_mtu + AX179A_RX_HW_PAD`) and no minimum, so a…
A check for pkt_len < 2 + ETH_HLEN will be added in the next version.

> - [Medium] ax88179a_bind() puts
>    NETIF_F_IP_CSUM/NETIF_F_IPV6_CSUM/NETIF_F_RXCSUM/VLAN offloads into…
A later patch in the series adds the relevant functions.

> - [Medium] ax88179a_bind() sets
>    ax179_data->eeprom_read_cmd/eeprom_write_cmd/eeprom_block/eeprom_wen…
A later patch in the series adds the relevant functions.

> - [Medium] ax88179a_ethtool_ops installs .nway_reset = usbnet_nway_reset,
>    but ax88179a_bind() never fills in dev->mii (only…
Reference to usbnet_nway_reset will be replaced by phy_ethtool_nway_reset.

> - [Medium] ax88179a_stop() prepares `reg8 = 0` to power the Ethernet PHY
>    down but then calls ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1,…
Was typo: ax88179_write_cmd is correct function call. Will fix.

> - [Medium] ax88179a_bulkin_config() starts with `int index = 0` and the
>    ETHER_LINK_1000 / ETHER_LINK_100 cases only assign index when link_sts…
The restriction to ax179_data->chip_version == AX_VERSION_AX88279 is
dropped and for all chip versions index = BULK_IN_SPEED_FS is now set 
when the USB speed is FS.

> - [Medium] ax88179a_ethtool_ops mixes abstraction layers: pause
>    parameters and SIOCxMIIREG go through phylink…
Will use phylink versions of calls for get/set_link_ksettings.

> - [Medium] In ax88179a_reset() the WoL capability probe passes `&tmp` - a
>    `u8 **` - as the destination of a 1-byte control read, while `tmp` is…
Will fix latent bug: &tmp -> tmp.

> - [Medium] ax88179_mdiobus_read() ignores the return value of
>    ax88179_read_cmd() and returns the u16 `res`, which ax88179_read_cmd()…
Will add check for ax88179_read_cmd() return value.

> - [Medium] At this commit ax88179a_netdev_ops omits .ndo_set_rx_mode
>    although the shared library provides ax88179_set_multicast() (which…
Multicast added in a later patch of the series.

> - [Medium] ax88179a_tx_fixup() writes into the SKB tailroom
>    (skb_put_zero()) and headroom (skb_push() + put_unaligned_le64())…
Returning NULL to usbnet when the memory allocation fails is intentional.

> - [Medium] Nothing bridges phylink's carrier-up transition to usbnet's
>    RX-URB submission.
Removed usbnet_link_change(dev, 0, 0); at the end of ax88179a_reset().

> - [Medium] ax88179a_reset() calls phylink_start() but usbnet_open() has
>    failure paths after info->reset() - info->check_connect() and…
Duplicate of above.

> - [Medium] All three new driver_infos set FLAG_AVOID_UNLINK_URBS, so
>    usbnet_stop() skips usbnet_terminate_urbs() and RX URBs stay submitted…
Appears to be false positive and not an issue in practice.

> - [Medium] ax88179a_stop() tears the MAC down (read-modify-write clearing
>    AX_MEDIUM_RECEIVE_EN, then AX_RX_CTL = 0) before calling…
Will move phylink_stop before the receiver is disabled.

> - [Medium] No lock serializes MAC register access and the shared
>    ax179_data fields between the phylink resolve worker…
Will use RTNL to protect AX_MEDIUM_STATUS_MODE register, use
WRITE_ONCE/READ_ONCE for rxctl.

> - [Medium] ax88179a_reset() calls phylink_start() and then
>    usbnet_link_change(dev, 0, 0), giving the netdev two independent…
Duplicate of above, fixed by removing usbnet_link_change(dev, 0, 0).

> - [Medium] In ax88179a_mac_link_up() the SPEED_2500 branch (reachable
>    only on the AX88279, the only chip advertising MAC_2500FD) programs…
Changed to clearing AX_XGMII_EN for all speeds != SPEED_2500 independent
of chip-id.

> - [Medium] In the SPEED_2500 branch of ax88179a_mac_link_up(), the two-
>    byte write to AX88179A_MAC_RX_DATA_CDC_CNT passes the byte array…
Fixed by using 2 1-byte writes.

> - [Medium] net/usb: Silent packet drop on TX memory allocation failure
Intentional.

> - [Low] The commit message tells users to give 'the ax88179_178a module'
>    precedence over CDC-NCM, but the series builds ax88179.ko…
This is a user-space issue prioritizing modules.

> - [Low] ax88179a_tx_fixup() prepends an 8-byte TX descriptor and appends
>    up to 16 bytes of padding but calls usbnet_set_skb_tx_stats(skb, 1,…
Intentional.

> - [Low] ax88179a_mac_link_up() declares `u8 link_sts` without
>    initialization, calls ax88179_read_cmd(dev, AX_ACCESS_MAC,…
Fixed by initializing link_status to 0.

> - [Low] ax88179a_bind() powers the PHY (write AX_PHY_POWER to vendor
>    command AX88179A_PHY_POWER, then msleep(250)) before the fallible…
> 
Intentional: Better not to write further data into a chip that is not 
what is expected.


