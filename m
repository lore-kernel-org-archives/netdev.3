Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E7552B1D2
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971740; cv=none; b=NmUi8yYHPXyJRpmnRjhdepUnWEiUpnPBFKsPxnR5Ne4UCGgn2ZXBtmbTR1tszHCESVMZHctXMCw0lFXmth9JblPlVzcO2x1rJZgRsl+mxfihSK2Inmj8MPmWM1H9p/f9nXWIBe6PbDnx6XW2+RKa6NacczAX1kSUyFFRU5dxsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971740; c=relaxed/simple;
	bh=ITiuVoieKTQOWZnGToTekTb3oEaE28KkiGWSmsyA07E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv9fzugM019KGFQq9//MSvMkOsBdjPluY/vZ5ih3/qqvnhudcwAlqFPvzEL5j07CveN1ySRiogC+67eyK4Rwv185TnclH/B3HmXtzIimcWW2V0fB5jsbA/HOuKxvt1zxDIkl7eWxLpFKPdDSSKrrNP+NQGCy4d3VrGZkLhx1nv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeEFFabt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeEFFabt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso59565925e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788971737; x=1789576537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ESyFju7TbbiKWIaiTGCNmAIToQRsP0nTPwSbd9PY2d8=;
        b=eeEFFabt+hpzsNKPJeWzA6A9mqgHJedckm0JuXWyomIh2yPDjHZ9fwhe6qREysvZ8S
         ge57zmB8jbPft8TctKacresaXFRsOO+DCqK4MJKEekp5q+LhxZO+1524Y+aQWTF1B9r7
         aTqXFxHmraGwyDmdoahBHOLKiaddZe7Vpm1e6pv9tIjdC9sB6K7vl0L8GpGUAjHOP+bq
         H3qrau2ybX1+Cc8ivrFS3gW6Nw7Q1LBRZmqmjOJbfmf2UMXNT+PVLBzHCVmCURtkIDZW
         0Lm4dt4u7Y3rWF26AKCxIDz2nwPDdLE1VcX1O3TTDoIrOL5KoUW0iU6o84RLFNk85aeT
         FhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788971737; x=1789576537;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESyFju7TbbiKWIaiTGCNmAIToQRsP0nTPwSbd9PY2d8=;
        b=nGytWfe9AogXyYMxjpmPJUaubOafJQscbKXq/vOTNgYp3vrCKjOQYHZ8TwHvWCcJK3
         mk7rucZu4ffsds/VkCs0DhDoeGMT0vnRB/MDc9RV2/W7tsJsaCo1qen7ENhzJ0s3tJ4J
         hYLpF3HvrQD7Vo36C4C9EyEdJcf3it2yU1HzCy82Ezk4KGj3Ttc8JXIjcwMTgkdD6U4Z
         Fkqe2G4PAwqPbPVzJI6wnr8+0Rc3RrAzv1vsYKdDfb2TDrcYeWH1sjRsrSPJtvHxK4Cz
         /9Q5t5/e8iSEIqm6WTcRvzBWfRZw/mUxZobehnF+PpTHN3TU1yxjbiC8YFEvd+juKU33
         gC0A==
X-Forwarded-Encrypted: i=1; AKwUvBzd1ZMaPWBX1hn1rPXyHRdJ1+LL35297gehWYGO9wbxutStPpTXYzQvF5Z/NIIWlhooRDcOw0k=@vger.kernel.org
X-Gm-Message-State: AFuF++m+h+Hrr4xaXS/DHRiGxzXNtgfS5hov6GGyrMxEUD8ZOg0ghkq6
	Jg2BAViv3wwv3AKmKOQ3U+gS0siMtGQWNareiA0X6Zi4HzcG3Qxuaaj1lbtXwg==
X-Gm-Gg: AYBFou37B9BQRQ/jq3QlSDsqvJRdxCRikKFOwZqfBFI2Grs1RHvdWTiP2HF2SZeIsOZ
	bGp8mzorULGmPEoPMmMJNY8wRxKs4VE7+0ulsBrSm8E+6YDGrOw34uA/+pwHTjNt+rZ6YiaKSUF
	S1a5gH7mZhe8XRTkNVS578loHktnaoW1OGXta+Zw0gMkRZLbIJYRDVNXkUUgD7uH+3Jf1dn0k5F
	5Ts6lioqSrFonhS2ImTDJEXwPkbPWWYDI4NB3+TWxECwM3l9Hvx/TbohRrK7+fcddS+kQIZMeu9
	KsqYl8yh0dyOi2CYiKPxqGWTIdLzjMo/IY+5rU4dbJtoqLsFAj9jSRo68+kURhP6dJD/wdzFN5B
	NH+GBZZwZlsaruvhumPQXYUVDsWrSb88pUMO9Hb3/Q+U1AYH7EEAtkgBdv633XniowC+TB6QQG8
	7DiMbvmAJwByUNOmu9gw7+8G5qQqt9nzSy055UMgQEJ0noQXySBa3w17skxKP1L58ipEMClisUQ
	+JfD07pYKiJemPbmctDFQlJ0sIuwEV0ebWL7lk/NE1YHOMUkpwK+0AnLvdfzbyXgbyunERWL61x
	12UHpCbpHJzrBw2AZ/Wm7IZsGTeY4Whvaksp
X-Received: by 2002:a05:600c:620b:b0:49c:fa20:cc07 with SMTP id 5b1f17b1804b1-49cff19cbf4mr306075945e9.30.1788971737114;
        Wed, 09 Sep 2026 09:35:37 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f3f:2700:d91c:55a7:4a6a:c054? (p200300ea8f3f2700d91c55a74a6ac054.dip0.t-ipconnect.de. [2003:ea:8f3f:2700:d91c:55a7:4a6a:c054])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c46b64sm2112395e9.13.2026.09.09.09.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 09:35:36 -0700 (PDT)
Message-ID: <9c34a1dc-6147-4369-8d12-9c5939d07530@gmail.com>
Date: Wed, 9 Sep 2026 18:35:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: don't enable chip LTR when the platform has
 not enabled LTR
To: Yogesh Gaur <yogeshgaur.83@gmail.com>, nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Javen Xu <javen_xu@realsil.com.cn>
References: <20260909110554.1977-1-yogeshgaur.83@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260909110554.1977-1-yogeshgaur.83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.09.2026 13:05, Yogesh Gaur wrote:
> rtl_enable_ltr() programs the MAC to generate LTR messages - ALDPS_LTR_EN,
> LTR_SNOOP_EN, LTR_OBFF_LOCK_EN, plus LINK_SPEED_CHANGE_EN on
> RTL8125/RTL8126/RTL8127 - and rtl_hw_aspm_clkreq_enable() calls it on
> every ASPM enable, then goes on to let the chip trigger L1.2.
> 
> The only gate is tp->aspm_manageable, which records that the OS is allowed
> to control ASPM. It says nothing about LTR. LTR is a separate PCIe
> capability that only works if every device on the path to the root port
> supports it. The PCI core determines that in pci_configure_ltr() and
> records the result by setting LTR Mechanism Enable in the endpoint's
> Device Control 2 register; per PCIe r6.0 sec 7.5.3.16 a function must not
> issue LTR messages while that bit is clear.
> 
> So on a platform whose hierarchy has no LTR path, the driver now tells the
> chip to start sending LTR messages nothing will honour, and ties ALDPS -
> the PHY's link-down power saving - to them. A report against RTL8125B
> (rev 05, firmware rtl8125b-2_0.0.2) in a mini PC shows the effect: 291
> link down/up transitions in one eight-hour boot, with repeated downshifts
> to 100Mbps, against four transitions at boot and then a stable link on the
> kernel before the LTR change.
> 
> Read the endpoint's LTR Mechanism Enable bit and leave the chip's LTR
> machinery alone when the platform did not enable it.
> pcie_capability_read_word() zeroes its output on error, so an unreadable
> capability takes the same safe path.
> 

Thanks for the fix!

> Fixes: 9ab94a32af70 ("r8169: enable LTR support")
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2529752
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21f..c1ff4e898570 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3037,6 +3037,16 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
>  
>  static void rtl_enable_ltr(struct rtl8169_private *tp)
>  {
> +	u16 ctl2;
> +
> +	/* The chip must not issue LTR messages unless the platform enabled
> +	 * LTR on the whole path up to the root port. The PCI core discovers
> +	 * that in pci_configure_ltr() and reflects it in LTR Mechanism Enable.
> +	 */
> +	pcie_capability_read_word(tp->pci_dev, PCI_EXP_DEVCTL2, &ctl2);
> +	if (!(ctl2 & PCI_EXP_DEVCTL2_LTR_EN))
> +		return;
> +

Can't you simply query tp->pci_dev->ltr_path instead of doing this low-level
PCI register read? When reading through pci_configure_ltr(), I think this
should do the trick.

>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_80:
>  		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);

