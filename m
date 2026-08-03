Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FB35E1A4;
	Mon,  3 Aug 2026 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750842; cv=none; b=cw+KLLAT0e58+NbOpDzhIpcuIo5m1rVW8LxenhscxJbeBCw2Rw4GC58uQJDSoTQM7MNpUz8HiYs6W61Su4XP8eNev2iVjxT/oHwVVBKkg3fLE1LmbwDr8Q+//gqVCa8ms8XpmCw7kWbi5xgsdWuiOlxp2SLencgLltKZa+5z0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750842; c=relaxed/simple;
	bh=z5yjw6yhQ+vZ1Nh1YjdeAo5r1ghpqqWlId+GU3RLznw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bcbhi3hAibee3pFw0Kdp1A6Qm5IG4o4w7ROAm76Au/Qr9G/pzcv8Xh3aAjpEYxFYSZKVuh4uoCi8RIFkBh/ntEWndQswiXhLgsvI5sDIjRxteqF6JFT1Ai9Rd1qSVnV4fVGzwNBEWscX0NR89A+OKgUSR5SLolyH7HP9r1HY27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=F6MQjEoo; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=KFNmZErA; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="F6MQjEoo";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="KFNmZErA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785750838;
	bh=z5yjw6yhQ+vZ1Nh1YjdeAo5r1ghpqqWlId+GU3RLznw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F6MQjEootu8IqgTSZ6um9F+ryTI/BPKD9I06OKOysqW3RVMaXYQW26U5Nm+pGOcxw
	 FYV2U1VZFf/45ag6Tmb/IghQfnLeZe8iM27sNhzrWBmAiOSFp4+mBHBlsKpyLPdMKu
	 9/8JkuDyxiedy8gj521QNs96Of+K38i/tbua57fPeqKmQWEQS/PSQHm2TFW//wl9Hk
	 b4x0F4jfmH/hMpLyfRLtuSC2CzOsgry6G3UdxsoT8BOTZXJQd+JnZoJbigVG+q/jFr
	 umgZYV+htVnKgtlIr8j5tJZTjbhj0NqU4CT1B29Lwt7JUEjuPrZQ+CCKGiqwFfNhpf
	 fdeE02pSHAlBA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D7C1149652; Mon,  3 Aug 2026 09:53:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785750837;
	bh=z5yjw6yhQ+vZ1Nh1YjdeAo5r1ghpqqWlId+GU3RLznw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KFNmZErAuZpDVnu1da/Zg+tTLWep6v/kPaxQlNDFV2GiFL1R+wZXtq83cqFag9/XP
	 Fhnzh3fhUjiFMvdH0R9Hgf//UVUdUjx/c4355C9T1MYgQbxYvd0bVY7Fjy/tc2FXa9
	 pLOzwVcAIdrv7Xd3jYCvGIG8XqS/xsD1Op4TG9mVglqecp9klen1/rLP7BB8+Iyjsu
	 gZaf5x8yc2m5dQoI58i7ek6FivU1fQuPj4pzU5wjRANUgIVG6Msg+ps+qTIth6wy3N
	 TSA4tKK/syW7sQQaBpzQtb5E4qNb5dj2ei1P8Isi2MJ6qvpX3RyMY5PWdmEqEs1twb
	 KCgH6vCi0xDKQ==
Received: from [192.168.1.146] (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 242864945D;
	Mon,  3 Aug 2026 09:53:57 +0000 (UTC)
Message-ID: <82acabcc-7b98-468a-a989-cb95f620fe5f@birger-koblitz.de>
Date: Mon, 3 Aug 2026 11:53:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/13] ax88179_178a: Add support for
 AX88179A-based chips
To: Jianhui Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260803073348.2190800-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260803073348.2190800-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks so much for testing, again, Jianhui!

On 03/08/2026 09:33, Jianhui Xu wrote:
> Hi Birger,
> 
> I tested v5 on the same ASIX AX88179B adapter (USB 0b95:1790,
> bcdDevice 0x0200, firmware 1.3.0.0).
> 
> The 13 patches applied to net-next commit
> df13c1df8147675470213ffff29dd5762fa321f5 and built successfully as
> 7.2.0-rc3-ax88179b-v5. The focused W=1 builds for ax88179.o and
> ax88796b.o were clean.
> 
> Unfortunately I reproduced an intermittent cold-activation failure, so I cannot
> add a Tested-by for v5. In four fresh direct-kernel QEMU starts with complete
> diagnostic capture, the old lease was released before starting DHCPDISCOVER. Two
> reported 1000baseT/Full carrier but timed out DHCP, while two succeeded
> normally. In both failed runs, RX remained at zero while TX increased. Reloading
> ax88179 and ax88796b recovered DHCP, RX, and bound traffic in both cases.
> 
> Before this follow-up campaign, in the earlier v5 validation session, I observed
> a separate 100baseT/Full failure: the adapter negotiated carrier after I changed
> the advertisement to 100baseT/Full-only, but ARP and bound traffic failed.
> I then tried to reproduce that result with three new advertise-0x008
> transitions. All three negotiated 100baseT/Full and passed bound gateway
> traffic; two also explicitly passed traffic to the test host. These repetitions
> included tests both with and without a preceding module reload. I could not
> reproduce the earlier 100-Mbit failure.
> 
> That earlier v5 validation session also produced a separate guest ACPI S3
> failure: after resume, the adapter returned with 1000baseT/Full carrier, but RX
> remained frozen and traffic was broken. I then performed three new S3 cycles.
> All three logged QEMU's same emulated-XHCI resume reinitialization and USB
> reset, but returned working traffic with increasing RX counters immediately. The
> final repetition also recreated the earlier speed, EEE, and pause setting
> sequence and verified working gateway traffic immediately before suspend.
> I could not reproduce the earlier frozen-RX result. This remains a QEMU
> emulated-XHCI test, not a physical-XHCI suspend test.
> 
> While reviewing the speed result, I noticed ax88179a_bulkin_config() selects its
> table using ax179_data->speed, while ax88179a_mac_link_up() receives the speed
> argument but I could not find an assignment to that private member. The new
> passing 100-Mbit tests do not support linking that source observation to the
> original one-off failure, and the same pattern appears in v4.
This issue is not critically problematic, the speed variable only affects the bulk
configuration settins that control how data is assembled in the controller and
assembled to larger USB transfers, including timing and so on. This should only harm
performance, but not the issues with the link after suspend/resume. It was introduced
in v3 or v4 when the speed info no longer came from the USB interrupt URB.

The following should fix this:
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 37a55ff5464c..a4d782979c63 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -215,13 +215,13 @@ static void ax88179a_get_drvinfo(struct net_device *net, struct ethtool_drvinfo
                  priv->fw_version[2], priv->fw_version[3]);
  }

-static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts)
+static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed)
  {
         struct ax88179_data *ax179_data = dev->driver_priv;
         const struct ax_bulkin_settings *bulkin_data;
         int index = 0;

-       switch (ax179_data->speed) {
+       switch (speed) {
         case ETHER_LINK_2500:   /* AX88279 only */
                 index = 0;
                 break;
@@ -451,6 +451,7 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
         struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
         struct ax88179_data *ax179_data = dev->driver_priv;
         u8 tmp8, link_sts, reg8[3];
+       u8 bulk_config_speed = 0;
         u16 tmp16, mode;

         /* Stop RX/TX for link configuration */
@@ -503,11 +504,13 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
                 ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_LSO_ENHANCE_CTRL, 1, 1, &tmp8);

                 mode |= AX_MEDIUM_GIGAMODE | AX_MEDIUM_FULL_DUPLEX;
+               bulk_config_speed = ETHER_LINK_2500;

                 break;

         case SPEED_1000:
                 mode |= AX_MEDIUM_GIGAMODE;
+               bulk_config_speed = ETHER_LINK_1000;
                 fallthrough;

         case SPEED_100:
@@ -518,6 +521,8 @@ static void ax88179a_mac_link_up(struct phylink_config *config,

                 tmp8 = 0x40;
                 ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 1, &tmp8);
+               if (!bulk_config_speed)
+                       bulk_config_speed = ETHER_LINK_100;
                 break;

         case SPEED_10:
@@ -529,12 +534,12 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
                 tmp8 = 0xFA;
                 ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 1, &tmp8);

-               speed = 10;
+               bulk_config_speed = ETHER_LINK_10;
                 break;
         }

         ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
-       ax88179a_bulkin_config(dev, link_sts);
+       ax88179a_bulkin_config(dev, link_sts, bulk_config_speed);

         if (ax179_data->chip_version < AX_VERSION_AX88279) {
                 tmp8 = 0;


> 
> EEE disable/restore, pause enable/restore, EEPROM read, module reload, and USB
> detach/reattach otherwise worked. I also tried Wake-on-LAN in QEMU. The driver
> accepted magic-packet wake, ethtool read back Wake-on: g, and USB wakeup was
> enabled before the guest entered S3. QEMU was configured with USB remote-wake
> suppression disabled, but the guest did not resume after directed-broadcast,
> limited-broadcast, and unicast magic packets. I consider that result
> inconclusive because I did not independently verify the physical USB
> remote-wakeup propagation through QEMU.
> 
> Please let me know if you would like me to test a fix or collect a specific
> register trace.
Could you trace the calls to __ax88179_write_cmd (registers, values) around the
suspend/resume events. Since the issue is not deterministic, it is probably sequence/timing-related.
My suspicion is that phylink sends PHY-polls after the controller got the sleep command.
Are there differences in the sequence of calls for the successfull suspend/resume
cycles and the unsuccessful ones?

Thanks!
   Birger

