Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D7476CC4
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132487; cv=none; b=Yexpv4o4h4ChJGGIoNrBeB1oxuOowf8xBYLNCPGT3r7pSuS4ZUJjOa0hRVivU8lUs7jGJsZcOo0PmzTF6xtGxd9CviLlewXyU/uQu0OJeZc3Z/vfan8J+tID4MAwTlMrCA+mzYT5Zp+xdzRrfOHb7t1/Q7xajPysuwW1udNJqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132487; c=relaxed/simple;
	bh=/bnlFAePkZ1na0mCv4sfAxjApdpfgRD7l0afJ27iyW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVJUcC0SBx8Xx6folyaub336uI8nadHC7tnTulDNVP5/Fkfr5s4Y8lR1B1jgKtRyh2ndblkqbXGVHR3OJREkWlWazan6aZsFGoeGRqbxu3HOrJZ1OIejrbBdElrXCLxBdQ3hsuSYyZhEgVc9uMY9HpnSOH8weD08hd+DyXmmWjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbJG0AhI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbJG0AhI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-486e39e007bso406594f8f.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789132484; x=1789737284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mp5ib3Fs9DH1L5FAP5/ujPlgaD7DQh9Zjtve4GxBeA=;
        b=LbJG0AhIrfDHaLBNvqVHVepiPUhvvO09jWlFlpDQDAYAMmyEqQNAZxpj7YTbsrAnHM
         AcMZlm8De7ZhlzjmelE0gnDHzQ3PG2RJb3ifMIYUk2sceky8Fa0mTR8jMtgkFF8SMI3s
         TgZMZBQwJq/nP7FksNjDPwdB0ug+IS4nJ3lTRpEtL9ZQu31kjb9/jd1YsAmP8jNqdfU0
         QrtudKG2l+wfnmaFfd5C7RhWTJV49DY9WD+/hwfXaF/8FCZUuvJmB/mu9Zs4nBBWthNk
         lTzrcBCKciMDJHrKa5LDPQ9y0bUgt1cEWpZIsfq4crIvJvCtsx9TisQwAMM+GPHbe++u
         dnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789132484; x=1789737284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1mp5ib3Fs9DH1L5FAP5/ujPlgaD7DQh9Zjtve4GxBeA=;
        b=fRQMGXsM+PzX/MGuCmQd/KWHuLR4GUj/XF8bTcLJB8UtT1WdDWWgjAQ2xT/OcEx3mO
         vMUig5sAMSzc3IeBZlkPC2egkg01vF+o0wLDubRC/7xeWEc1UQ9/Ob4F9egakQgRW6df
         6Am6buaIN3/8Kr9OVz93+D7SSw/IiDchyQKsXUgPDxHdSVYl8SFXt0gFvm7FGaUUR7Qp
         rhkbQi6kTaFPI0XhqKvk3ZAIL8aITCpkU5aWVgYLN0IBviQBV9pA/P09p/4v4nlcVnIu
         Psmk/GIzi7mrEickgiBz1XFy5Yow4o6VCKmrktbp7OFIbLIWWSBBBTRGaWIp1L07SgKO
         qn8g==
X-Forwarded-Encrypted: i=1; AKwUvByMipF8qk+ooa6VgvdnVg33LMmX+3teXfeGdVgl9KRPAvGF7Jqcn9Y/DoqbAlwvHmgDd9tzf7g=@vger.kernel.org
X-Gm-Message-State: AFuF++kdo+jJ6i6llkI6/Ilvt40ZIrzFIhD6bbqYTk9kAdkSSUlwfGPp
	jFdYmCnNQYLcYyhpmvAy6waqLQg11HKogiRR1swOnKotm+ijwUBAtxvs
X-Gm-Gg: AYBFou1qeUQKv8JUB/vxZ0OFWDU/bC17QYDfM9uSHY+FFfGVfaR+Ggnf8hLmEnYKfts
	ZnJpvq6PMBcRJXTDMME7BAtnNYqEcIi6KnbcccCPfYUN1WyKAZ0sb2Jt5O5xj7cy5kRomH7v8If
	yVyoeuqbwgHQTp2TocEwSFW05pJIZTKpoyis8ZAI1KKwDtu8VF6+UzvM+1bKS8J7t/Td/oKmI1j
	zUVEf3LBbQpt6+zhwIumU3cKRMiXPrqTkTZBPBaz6WXCOAzmYsL0qc/ThBBNaTPnKhqUMg3Yt1e
	gWNnL/nq+lBbBrn4zpJXMgUfsE/lu5zpcjmLZrefBIOaSIxkAc6bJ9vWbRJ/InmIzL8RFegV/ah
	SGbs6WTbYARFS+C6+ju/HHcN5ovmVO6Q4Me5u9y5jdjIoa5d6BDEcHjzS0c5LlCE2SdNIRziMC+
	mljpFwIdCPgA9uoG1AOuIEmg0YuggEj3GHMYHrvLBdnKyBW1aPZ11A0Jz8TH0g4LzVWdEAr2Tj6
	+bdWsuHegbfBvcwu8UdXF0Gvmd1tMO5GZI+8BobF4EPXVgSpWdjzIw88cx0p3Qm5+bS05k0riJP
	j5+C+2eYRxRhjxnrZ75p0s8dnR+vg9Ix3SUl
X-Received: by 2002:a05:6000:1a8b:b0:485:956a:1607 with SMTP id ffacd0b85a97d-486eb340eaamr5437449f8f.40.1789132483823;
        Fri, 11 Sep 2026 06:14:43 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f48:7f00:eca9:807e:6ba1:9814? (p200300ea8f487f00eca9807e6ba19814.dip0.t-ipconnect.de. [2003:ea:8f48:7f00:eca9:807e:6ba1:9814])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bed0sm5761987f8f.32.2026.09.11.06.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 06:14:41 -0700 (PDT)
Message-ID: <dc33c0ec-ae64-464f-b656-8c55bb17cacd@gmail.com>
Date: Fri, 11 Sep 2026 15:14:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: don't enable chip LTR when the platform has
 not enabled LTR
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Javen Xu <javen_xu@realsil.com.cn>
References: <20260910130140.910-1-yogeshgaur.83@gmail.com>
 <46807790-6f07-4f0a-b50b-375cc1c9b061@gmail.com>
 <CAG6enPy441a-cyzsP2_WoQ1+4rj6gikWzOrNmX6yXx1mOo-M1Q@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAG6enPy441a-cyzsP2_WoQ1+4rj6gikWzOrNmX6yXx1mOo-M1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.09.2026 15:00, Yogesh Gaur wrote:
> On Fri, Sep 11, 2026 at 1:03 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 10.09.2026 15:01, Yogesh Gaur wrote:
>>> rtl_enable_ltr() programs the MAC to generate LTR messages - ALDPS_LTR_EN,
>>>
>>
>> Empty lines, mail formatting issue?
> Yes, I would correct it in v3.
> 
>>
>>> LTR_SNOOP_EN, LTR_OBFF_LOCK_EN, plus LINK_SPEED_CHANGE_EN on
>>>
>>> RTL8125/RTL8126/RTL8127 - and rtl_hw_aspm_clkreq_enable() calls it on
>>>
>>> every ASPM enable, then goes on to let the chip trigger L1.2.
>>>
>>>
>>>
>>> The only gate is tp->aspm_manageable, which records that the OS is allowed
>>>
>>> to control ASPM. It says nothing about LTR. LTR is a separate PCIe
>>>
>>> capability that only works if every device on the path to the root port
>>>
>>> supports it. The PCI core works that out in pci_configure_ltr() and
>>>
>>> records the result in pci_dev->ltr_path; per PCIe r6.0 sec 7.5.3.16 a
>>>
>>> function must not issue LTR messages while LTR Mechanism Enable is clear.
>>>
>>>
>>>
>>> So on a platform whose hierarchy has no LTR path, the driver tells the
>>>
>>> chip to start sending LTR messages nothing will honour, and ties ALDPS -
>>>
>>> the PHY's link-down power saving - to them. A report against RTL8125B
>>>
>>> (rev 05, firmware rtl8125b-2_0.0.2) in a mini PC shows the effect: 291
>>
>> Did you verify that this is caused by LTR messages, and not by any other
>> root cause?
>>
>>>
>>> link down/up transitions in one eight-hour boot, with repeated downshifts
>>>
>>> to 100Mbps, against four transitions at boot and then a stable link on
>>>
>>> the kernel before the LTR change.
>>>
>>>
>>>
>>> Gate the chip's LTR programming on pci_dev->ltr_path. That field lives
>>>
>>> inside CONFIG_PCIEASPM, and without ASPM support there is nothing here to
>>>
>>> enable LTR for, so compile the function out in that configuration.
>>>
>>>
>>>
>>> Note this does change CONFIG_PCIEASPM=n builds, which used to program
>>>
>>> chip LTR unconditionally: pci_disable_link_state() is a stub that returns
>>>
>>> success there, so tp->aspm_manageable ends up set. The PCI core does not
>>>
>>> configure LTR in that configuration either.
>>>
>>>
>>>
>>> Fixes: 9ab94a32af70 ("r8169: enable LTR support")
>>>
>>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2529752
>>
>> Did you verify that your patch fixes the reported issue? Or do you
>> just assume this? Because in the bug comment history I don't see
>> a statement that issue has been resolved.
> I don't have a board with me, hence have not verified it. I did a
> compile check only.

If it's not verified that your patch fixes the reported issue, better
remove the Closes line.

>>
>>> Assisted-by: LLM
>>>
>>> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
>>>
>>> ---
>>>
>>> v2:
>>>
>>>  - Gate on pci_dev->ltr_path instead of reading PCI_EXP_DEVCTL2 directly,
>>>
>>>    and compile rtl_enable_ltr() out for CONFIG_PCIEASPM=n, where that
>>>
>>>    field does not exist and there is nothing to enable LTR for.
>>>
>>>    Suggested by Heiner Kallweit.
>>>
>>>  - Commit message notes the resulting change for CONFIG_PCIEASPM=n builds.
>>>
>>>  - No change to the RTL8125 register programming itself.
>>>
>>>
>>>
>>> v1: https://lore.kernel.org/all/20260909110554.1977-1-yogeshgaur.83@gmail.com/
>>>
>>>
>>>
>>>  drivers/net/ethernet/realtek/r8169_main.c | 13 +++++++++++++
>>>
>>>  1 file changed, 13 insertions(+)
>>>
>>>
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>
>>> index ec4fc21fa21f..05f7a44aff01 100644
>>>
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>
>>> @@ -3035,8 +3035,16 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
>>>
>>>       }
>>>
>>>  }
>>>
>>>
>>>
>>> +#ifdef CONFIG_PCIEASPM
>>>
>>>  static void rtl_enable_ltr(struct rtl8169_private *tp)
>>>
>>>  {
>>>
>>> +     /* The chip must not issue LTR messages unless LTR is enabled on the
>>>
>>> +      * whole path up to the root port. pci_configure_ltr() works that out
>>>
>>> +      * and records the result in pci_dev->ltr_path.
>>>
>>> +      */
>>>
>>> +     if (!tp->pci_dev->ltr_path)
>>
>> Simpler would be:
>> if (!IS_ENABLED(CONFIG_PCIEASPM) || !tp->pci_dev->ltr_path)
>>
> I tried that and it does not build, because ltr_path itself is declared
> inside the #ifdef:
> 
>   include/linux/pci.h:443
>     #ifdef CONFIG_PCIEASPM
>             struct pcie_link_state  *link_state;
>             unsigned int    aspm_l0s_support:1;
>             unsigned int    aspm_l1_support:1;
>             unsigned int    ltr_path:1;
>     #endif
> 
> IS_ENABLED() is a C expression, so the member reference still has to
> compile even when the left operand is 0:
> 
>   drivers/net/ethernet/realtek/r8169_main.c: In function 'rtl_enable_ltr':
>   error: 'struct pci_dev' has no member named 'ltr_path'
>        if (!IS_ENABLED(CONFIG_PCIEASPM) || !tp->pci_dev->ltr_path)
> 
Right, ofc ..

>> Then you don't need the stub function.
>>
> You are right that the stub function should go, though. v3 drops it and
> keeps a single rtl_enable_ltr() with the guard inline:
> 
>         static void rtl_enable_ltr(struct rtl8169_private *tp)
>         {
>                 /* comment */
>         #ifdef CONFIG_PCIEASPM
>                 if (!tp->pci_dev->ltr_path)
>                         return;
>         #else
>                 return;
>         #endif

LGTM

>>>
>>> +             return;
>>>
>>> +
>>>
>>>       switch (tp->mac_version) {
>>>
>>>       case RTL_GIGA_MAC_VER_80:
>>>
>>>               r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
>>>
>>> @@ -3120,6 +3128,11 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
>>>
>>>       /* chip can trigger LTR */
>>>
>>>       r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
>>>
>>>  }
>>>
>>> +#else
>>>
>>> +static void rtl_enable_ltr(struct rtl8169_private *tp)
>>>
>>> +{
>>>
>>> +}
>>>
>>> +#endif
>>>
>>>
>>>
>>>  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>>>
>>>  {
>>>
>>

