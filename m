Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938E3CA481
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068804; cv=none; b=iEQvLx1E/v4feAEVLmyy4iS5Yz6iOznEzKcHuxvWkwRQX7pvy75A0UnMJ1soeTAN902yQKSG98xdXJIeRKndOEJDAtkWG2pe0nitpyZ5L0ciV1F2UDCjCxOVDPs2YeiYNxQVrEApUXOlCbii6i9syiEJT0P+Q401G4fr+AgUJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068804; c=relaxed/simple;
	bh=z/ntw6rkZ01hf6p5sHZuJQruPYMKRq0GuPPT61YKsXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7n93sW94p7P27c/R7H3FfPq+0rWyZWZLP68n3nP11XLYLzlAkqRhUz1VMlXXCAGJQzQcj14qTNglEO1OBICbXSFIvAjy37dlbhAfj/c7WVMpZKJjbrNPtIxCj1afI96sif/L56LnL1zpnit6RcWMGFGRdsM53jwEJjkzURioNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLrUzNVB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLrUzNVB"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-486e934b0c9so39167f8f.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789068799; x=1789673599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VKdmL79F/q5jy1ukzo1sZIwlgRGg6y+i6cYUbNQ2MJk=;
        b=YLrUzNVBJRxSjduF6rkjEH/J1HsxBgX8Mb8q8OqDHdVuokbWtXhA/OXT56dcWiupEi
         nsAK9yz0H3PE17ekZ45QDfpd/MV9wwcZ7cPJePo+y3B5PkxDtU4c0Qbqor/kqM1SRxiC
         QIcEzwNqzfqquUJ1Hd2rdFrM8oNuoLP/+Df2Y7CJGub7vZZbCGyn9CRn40/WBwQPociE
         kzXOIwaWJlgXm9edYOIaWw319V/wbMB9/Z92DFrKYHmc0w8t0+pbnYdoTmDpC2DKDepY
         l3nZ1uHDcoPGlAK8uwwH8soRwzZ9d3TR/zbvr3S9Y+YGApny+YwIs6xpnAD53v0s0uYf
         27Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068799; x=1789673599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKdmL79F/q5jy1ukzo1sZIwlgRGg6y+i6cYUbNQ2MJk=;
        b=n1lGt3bcYB285KxiAbM6zwKw1rAeOubijCcLUp5RZQErw/kseKmP/oKMoUPFRFLRtf
         hT0I98CHomUqun5QxL4z+JgU0ESNlZsjnxwbl4BTykLSg0N0RzuS7eFHQ3sY4URSiird
         jNfgx16ichYB7ma89xT9T1QxUsj0TWhjL+6JSw/7ZJ9J832c1VkuMHHCXzTIH8LcvwzD
         GlOso/w2TugLRYR4Iwqp3aGl40T2xkZ8HswaFWraKrjTcDnF/cYZmeXEcpFwX3AgGhxX
         p+MicNqcXMGN+yfjXyQ6773kc9w9/5Rkvg5k+T4uPfIEchcBF1S0JXl3js27LSrn1yPt
         Vmzg==
X-Forwarded-Encrypted: i=1; AKwUvBwhqiPjYpinuO085AeztibfTXvwIWMxyF/kx4sxv765Vv+IT1Rq12niKjh8RA69O9KThxEiflc=@vger.kernel.org
X-Gm-Message-State: AFuF++n8sgRf65pqmPw0tOE9ShPJs9avJcx6oJ4V4xOUWbHsSBto/mtZ
	L0mx2tViVV7L6Xx8TsHfJVQwh3PV4EW3pQw9scUju53GU20o0zYReuGy
X-Gm-Gg: AYBFou2ZTV/uFbiXbJNbf2s3sWLGW10Xjdl5W2AOK/jJEV/YVx2ADpJa17edMXittwO
	xfujqybCE95kDbpU4bTrSB1q5NzAfxf/t3RLR+0GM2myxM8myuNZsDbapnVLdrZGtJhHzFFd4BG
	xCLG329juCpmxTOcxD55pfcjOZ22nBpw8CwaAwausm6vY/u+p6I62/AujzXKHs/3bYci1c7C+lf
	TqiR0K5mhwoAQ+eEyXLV4brvrzOh79dmiW4Wl/Xlr8qs2gKcvw8lriunYfkC+8jQ+IAP23WntXp
	QjqrZZn6Z0OTicoPWITuPovGHzcQppExRpHxCBUD66UmTUGYpCQmsXCgrgBaT5G4DyWZsaKlG3j
	eGHqpZPoJcI0CyugtSzmXw16wZzibAKj4br32I4xQXTr/I7BD8jESqx8koY34DXOStpOXNfmqcy
	mFRQtmd3bpt4ef9U/Pt7QhTBQ1RQudqrh6OiYEWzrKS0zDrLLU+Hhl/f4skImW9gSP3wehbP57y
	iNT+8Q9G8VfhY16DVC3lcBaSZ/loxjUrDptarXojSOIUdOnzRitcMgnSytF/92tcDnsKx/voUG6
	fS1FFVPZZ2SeDpVRRjuTb/7nkpygh23DGlkE
X-Received: by 2002:a05:6000:4a12:b0:484:4537:95ed with SMTP id ffacd0b85a97d-486eafd6f7dmr650425f8f.5.1789068798984;
        Thu, 10 Sep 2026 12:33:18 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2c:d400:9135:d56e:c3ce:edd3? (p200300ea8f2cd4009135d56ec3ceedd3.dip0.t-ipconnect.de. [2003:ea:8f2c:d400:9135:d56e:c3ce:edd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf23sm620428f8f.5.2026.09.10.12.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 12:33:18 -0700 (PDT)
Message-ID: <46807790-6f07-4f0a-b50b-375cc1c9b061@gmail.com>
Date: Thu, 10 Sep 2026 21:33:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: don't enable chip LTR when the platform has
 not enabled LTR
To: Yogesh Gaur <yogeshgaur.83@gmail.com>, nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Javen Xu <javen_xu@realsil.com.cn>
References: <20260910130140.910-1-yogeshgaur.83@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260910130140.910-1-yogeshgaur.83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.09.2026 15:01, Yogesh Gaur wrote:
> rtl_enable_ltr() programs the MAC to generate LTR messages - ALDPS_LTR_EN,
> 

Empty lines, mail formatting issue?

> LTR_SNOOP_EN, LTR_OBFF_LOCK_EN, plus LINK_SPEED_CHANGE_EN on
> 
> RTL8125/RTL8126/RTL8127 - and rtl_hw_aspm_clkreq_enable() calls it on
> 
> every ASPM enable, then goes on to let the chip trigger L1.2.
> 
> 
> 
> The only gate is tp->aspm_manageable, which records that the OS is allowed
> 
> to control ASPM. It says nothing about LTR. LTR is a separate PCIe
> 
> capability that only works if every device on the path to the root port
> 
> supports it. The PCI core works that out in pci_configure_ltr() and
> 
> records the result in pci_dev->ltr_path; per PCIe r6.0 sec 7.5.3.16 a
> 
> function must not issue LTR messages while LTR Mechanism Enable is clear.
> 
> 
> 
> So on a platform whose hierarchy has no LTR path, the driver tells the
> 
> chip to start sending LTR messages nothing will honour, and ties ALDPS -
> 
> the PHY's link-down power saving - to them. A report against RTL8125B
> 
> (rev 05, firmware rtl8125b-2_0.0.2) in a mini PC shows the effect: 291

Did you verify that this is caused by LTR messages, and not by any other
root cause?

> 
> link down/up transitions in one eight-hour boot, with repeated downshifts
> 
> to 100Mbps, against four transitions at boot and then a stable link on
> 
> the kernel before the LTR change.
> 
> 
> 
> Gate the chip's LTR programming on pci_dev->ltr_path. That field lives
> 
> inside CONFIG_PCIEASPM, and without ASPM support there is nothing here to
> 
> enable LTR for, so compile the function out in that configuration.
> 
> 
> 
> Note this does change CONFIG_PCIEASPM=n builds, which used to program
> 
> chip LTR unconditionally: pci_disable_link_state() is a stub that returns
> 
> success there, so tp->aspm_manageable ends up set. The PCI core does not
> 
> configure LTR in that configuration either.
> 
> 
> 
> Fixes: 9ab94a32af70 ("r8169: enable LTR support")
> 
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2529752
 
Did you verify that your patch fixes the reported issue? Or do you
just assume this? Because in the bug comment history I don't see
a statement that issue has been resolved.

> Assisted-by: LLM
> 
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
> 
> ---
> 
> v2:
> 
>  - Gate on pci_dev->ltr_path instead of reading PCI_EXP_DEVCTL2 directly,
> 
>    and compile rtl_enable_ltr() out for CONFIG_PCIEASPM=n, where that
> 
>    field does not exist and there is nothing to enable LTR for.
> 
>    Suggested by Heiner Kallweit.
> 
>  - Commit message notes the resulting change for CONFIG_PCIEASPM=n builds.
> 
>  - No change to the RTL8125 register programming itself.
> 
> 
> 
> v1: https://lore.kernel.org/all/20260909110554.1977-1-yogeshgaur.83@gmail.com/
> 
> 
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 13 +++++++++++++
> 
>  1 file changed, 13 insertions(+)
> 
> 
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> 
> index ec4fc21fa21f..05f7a44aff01 100644
> 
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> 
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> 
> @@ -3035,8 +3035,16 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
> 
>  	}
> 
>  }
> 
>  
> 
> +#ifdef CONFIG_PCIEASPM
> 
>  static void rtl_enable_ltr(struct rtl8169_private *tp)
> 
>  {
> 
> +	/* The chip must not issue LTR messages unless LTR is enabled on the
> 
> +	 * whole path up to the root port. pci_configure_ltr() works that out
> 
> +	 * and records the result in pci_dev->ltr_path.
> 
> +	 */
> 
> +	if (!tp->pci_dev->ltr_path)

Simpler would be:
if (!IS_ENABLED(CONFIG_PCIEASPM) || !tp->pci_dev->ltr_path)

Then you don't need the stub function.

> 
> +		return;
> 
> +
> 
>  	switch (tp->mac_version) {
> 
>  	case RTL_GIGA_MAC_VER_80:
> 
>  		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> 
> @@ -3120,6 +3128,11 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
> 
>  	/* chip can trigger LTR */
> 
>  	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
> 
>  }
> 
> +#else
> 
> +static void rtl_enable_ltr(struct rtl8169_private *tp)
> 
> +{
> 
> +}
> 
> +#endif
> 
>  
> 
>  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
> 
>  {
> 

