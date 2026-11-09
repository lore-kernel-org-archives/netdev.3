Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246756;
	b=qKxhxo/u4P95m5znpPwyv5qYNCYBGOhO3o+Vnz7x2/74dBf5Frl2l6nFE4twNxGt3asM
	 qYnwUg56Y9WpWucqqD0MRExYGOwnvxbaR7BSNoy/S592bvNkmCJAXDXAUDTcN8omonDOU
	 1e0dGs/Kw9nB1us4nP8aIGijz9XanXyrql+Wj9L8qknrCqi0CyPEI9vgwH27PwntWLAQu
	 TW/pm0uqBb1g3sCLvFTDPwgzv5joW7guRHyp3LuDzZMYWkqC53Cit8Eekopt0AtBkOJDX
	 LgsSoflCjiZ8MGBtktXM5/idIXIWkbV1FPICQI34Y9Xx1H3i84btfPR1qkcesx+WLrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4sBEPiHYc3BJQwDWhViCZ5SdPdYAjuKHDf1BZ6d/8Cc=;
	b=NQwlNiz6Q9olczp0g6Nq1xf0EKHMzdmacMMPPaQlUwE9DPl0xQalWwW46BcpFpkPhbIL
	 LouM9IxV6a/AR6Mg0Q9avmr63jIaMUzKILmqKKPJIeupxAWODZMAYYgZjwS37WO5a3sX8
	 F82hpvxbZ4UDeTor/yo0ZlBXLd22JPNsx0BFyEZJXXSnG/XQDtoJo8PXY3Alv52PX6fqc
	 GuTzku4zxhIfdG88b/lePQ6UQ7YI+JuUQ48xAegp173V2m8q0EMfjz64Xp91GG8QiK5bN
	 nGrFsVxem/diP2QSVoIzEUKs1rtjQ3R4u7+uRENlsFFDrJNaafR1/WeH8o6fCdd/lqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DQ2qO23r;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F53606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03F53606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DQ2qO23r
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f30660e69so91633685a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 09:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794246755; x=1794851555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4sBEPiHYc3BJQwDWhViCZ5SdPdYAjuKHDf1BZ6d/8Cc=;
        b=DQ2qO23rLRCxTwArR4DG4vXeeFRmR1SKfqDS4cs/mHywHhXP82ZX0+4r0dF47rRQNx
         dUSuDpDr77kXqm37trKgjvdvEve3dmQHtrrbkbf0DuS4KRveEhhUQVMMOj9SPNbLrCdV
         i4Iq3O7zuqiCV5iJAwCGa5Ox8ZiNa5xlK+8Dn7VDYmfOtY6NEUg7dAWqSCktxt13+Zdk
         KHvdxxvtCAD5TayDueK+2ZCcxjNFpeHfNKx01jw59iWnwGNJQkBxSV/13+9jIJ9SH5F/
         JrddyFPUH2f3IRV3d0YSBwdj+lygthj77zleUfVcI/7IVuxFhtlQRWDP42KhmUGRcQE/
         Iatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246755; x=1794851555;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4sBEPiHYc3BJQwDWhViCZ5SdPdYAjuKHDf1BZ6d/8Cc=;
        b=23MKjVMBdYiA1pphUcmnEiFq8uGDZdOnYao9C5Z9fH5pUyeIPLjNf7KsOBv/LfBNe6
         4sJQunh/7UcEP5HK9wkVewAAhWGZvRyH6LTLvbkg5kzUvBPQSDL9pMV2JPTLX6aGrNET
         KkH47VqimrHf69s8o7XgSLKpmpM6wQUVukO+NcMwpuh9ICupFtW43lKGnt0lzF3TIRpn
         STD2sz5tkEGICleHO1i7vPG8eYXNAcELm7aF/yURBHwh6UpgEyet928aV3Ir5x05U0zN
         ixud5CRIsfYK5e1Dev6Sd4kQm9PEbNkqp2/yfskTOTlX/zc/gQyIJ4GH5TBxZEW2NqUX
         9TLw==
X-Gm-Message-State: APuU4Z82b6hwgle8hACONbesF7McMrzzjlt/SF+j1HDDo6CDy1XK0QNv
	JdnZuscBlIBjihc/YsD7o9GoCM7v1a6Ts4KlaKMlnbV/ZxC+M+xIdg8/
X-Gm-Gg: AYBFou3AwxZ5EkZZK/PgQ1ACndSV2PuOkXksEqypXEF9voVDZ9ZBfX3fyXYIg1/GNfS
	u89XvzpRU6nXWopF0Z5poLImPzlMn5a4rjD69uxgjJ6LMKAKLGlvJueR/l+GGYymInihK2IpMhu
	OIqpRpLaqvXtGSIQESmeK5u9km2+gjH0Q4sYvPRxzgx1YSjIeX6kd/egouE5lhQywGM+zivFyvs
	paUkfGX28V7LijanHrXOL3H7aPblbUAw3Crh5Y8rvm+gT8ZxSKhb9/T1pdIJAatr3XCB8kjbQ7P
	Jk5jE5pg6isfZ1b/RFhRmN2zJFJVGVOiJGDJVCYH3KAjT4Yeo/C/DqEbFKYEnnursZ22NyhhB07
	RNuxxMCUBpzC7vmc1fAJqU2MidbwE3MmRE/Y5W3D+w6leG1ZsWOy12TtxZR5lutbl144xg+Jw1t
	pOe4xJofMaI2RN/Wpa2O57OWJhrnTz6LOAi25SO1GHHEvROFcDhQehAWjofYo+ZnXU1m6nWAV/L
	nR3q2FD+zNja27+Bf7YXZVAPQd9+3zf9dmKnsKyeeVeC7T0s6ZCF4DVhnKm7+YvZ+Vko3QO/tzx
	rUikZWTLwJzEbfPT11hMUyipl2nYbOBxZtaK5ivf5DbSxMiFCe/bveY=
X-Received: by 2002:a05:620a:3194:b0:93f:1936:b229 with SMTP id af79cd13be357-9479f415639mr29264485a.77.1794246754939;
        Mon, 09 Nov 2026 09:52:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7d6964sm25568285a.34.2026.11.09.09.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 09:52:33 -0800 (PST)
Message-ID: <0f3510a1-a22d-409d-ac3a-854c9746eb81@gmail.com>
Date: Mon, 9 Nov 2026 09:52:30 -0800
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
Subject: Re: [PATCH net-next 2/3] net: sb1250-mac: Advertise and honor RX
 checksum offload
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, macro@orcam.me.uk
References: <20261105193435.2050321-3-f.fainelli@gmail.com>
 <179422063443.994134.7898125324608942943@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <179422063443.994134.7898125324608942943@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/9/26 02:37, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] sbdma_rx_process()
>    (drivers/net/ethernet/broadcom/sb1250-mac.c:1146-1149) reads the…
> - [Medium] The RX checksum engine's IP-header-offset setup, which the
>    probe comment calls necessary ("This is needed for PASS2 for Rx H/W…
> 
> --
> 
> net: sb1250-mac: Advertise and honor RX checksum offload
> 
> This patch adds NETIF_F_RXCSUM to hw_features. It also enables the
> offload by default on chip revisions where sbmac_set_iphdr_offset()
> reports hardware checksum support. The receive path now tests the active
> feature bit, not sc->rx_hw_checksum, before it marks packets
> CHECKSUM_UNNECESSARY.
> 
>> diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
>> index 1843b52e96f51..546415d3134c6 100644
>> --- a/drivers/net/ethernet/broadcom/sb1250-mac.c
>> +++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
>> @@ -1142,8 +1142,8 @@ static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
>>   				 * the kernel
>>   				 */
>>   				sb->protocol = eth_type_trans(sb,d->sbdma_eth->sbm_dev);
>> -				/* Check hw IPv4/TCP checksum if supported */
>> -				if (sc->rx_hw_checksum == ENABLE) {
>> +				/* Honor the RX checksum offload feature setting. */
>> +				if (dev->features & NETIF_F_RXCSUM) {
>>   					if (!((dsc->dscr_a) & M_DMA_ETHRX_BADIP4CS) &&
>>   					    !((dsc->dscr_a) & M_DMA_ETHRX_BADTCPCS)) {
>>   						sb->ip_summed = CHECKSUM_UNNECESSARY;
> 
> [Severity: High]
> In sbdma_rx_process(), is M_DMA_ETHRX_BADTCPCS tested against the right
> descriptor word? The header defines it as a dscr_b bit:
> 
> arch/mips/include/asm/sibyte/sb1250_dma.h:
> /* Note: This bit is in the DSCR_B options field */
> #define M_DMA_ETHRX_BADTCPCS	_SB_MAKEMASK1(0)
> 
> In dscr_a, bit 0 is the low bit of the RX buffer's physical address,
> which sbdma_add_rcvbuffer() programs:
> 
> 	dsc->dscr_a = virt_to_phys(sb_new->data) |
> 		V_DMA_DSCRA_A_SIZE(NUMCACHEBLKS(pktsize + NET_IP_ALIGN)) |
> 		M_DMA_DSCRA_INTERRUPT;
> 
> sb_new->data is set up with sbdma_align_skb(sb_new, SMP_CACHE_BYTES,
> NET_IP_ALIGN). The address is therefore cache-line aligned plus 2, so
> that bit is always 0.
> 
> If so, the hardware's TCP checksum result is never read. Any frame with
> a valid IPv4 header checksum gets CHECKSUM_UNNECESSARY. That includes
> TCP segments the hardware flagged as having a bad TCP checksum, and the
> stack then skips software verification of the payload.
> 
> This decoding seems to go back to the original driver code. Still, the
> commit message says "The driver already trusts hardware RX checksum
> status". This patch rewrites the same conditional and makes it a
> default-on offload that ethtool reports.
> 
> Should this test dsc->dscr_b & M_DMA_ETHRX_BADTCPCS instead? The same
> loop already reads dscr_b through G_DMA_DSCRB_PKT_SIZE(), so the
> hardware does write that word back.
> 
> The later patch in the series ("Add ethtool autonegotiation restart
> support") doesn't change this check either.
> 
>> @@ -2214,6 +2214,10 @@ static int sbmac_init(struct platform_device *pldev, long long base)
>>   
>>   	/* This is needed for PASS2 for Rx H/W checksum feature */
>>   	sbmac_set_iphdr_offset(sc);
>> +	if (sc->rx_hw_checksum == ENABLE) {
>> +		dev->hw_features |= NETIF_F_RXCSUM;
>> +		dev->features |= NETIF_F_RXCSUM;
>> +	}
> 
> [Severity: Medium]
> Is the IP header offset that the checksum engine relies on actually
> programmed while the interface is running? The comment above calls it
> necessary, but sbmac_set_iphdr_offset() does:
> 
> 	/* Hard code the off set to 15 for now */
> 	reg = __raw_readq(sc->sbm_rxfilter);
> 	reg &= ~M_MAC_IPHDR_OFFSET | V_MAC_IPHDR_OFFSET(15);
> 	__raw_writeq(reg, sc->sbm_rxfilter);
> 
> Because of operator precedence, this only masks the register and never
> writes 15 into the field. S_MAC_IPHDR_OFFSET is 8 and the field is 8
> bits wide, so the field ends up as the old value's low four bits.
> 
> There is a second problem. The path sbmac_open() ->
> sbmac_set_channel_state() -> sbmac_channel_start() writes the whole of
> sbm_rxfilter:
> 
> 	__raw_writeq(0, s->sbm_rxfilter);
> 	...
> 	__raw_writeq(M_MAC_UCAST_EN | M_MAC_BCAST_EN, s->sbm_rxfilter);
> 
> That resets IPHDR_OFFSET to 0. sbmac_mii_poll() also calls
> sbmac_channel_start() on link changes, and nothing reprograms the field
> afterwards.
> 
> So while traffic is flowing, the checksum engine uses an IP header
> offset the driver never intended. NETIF_F_RXCSUM is now advertised and
> turned on by default based only on the revision check, and
> sbdma_rx_process() trusts the engine's status bits.
> 
> Could the field be set with something like:
> 
> 	reg &= ~M_MAC_IPHDR_OFFSET;
> 	reg |= V_MAC_IPHDR_OFFSET(15);
> 
> and kept across the rxfilter writes in sbmac_channel_start()? This code
> predates the patch, and the later patches in the series don't touch it.
> 

Both issues are valid and predate this series. I’ll send separate fixes 
for the descriptor word and IP header offset programming.
-- 
Florian
