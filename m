Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223173A4F4A
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786216225; cv=none; b=tkYdzpf+aAM+En6n5JMIajqNREyUUoMQLRrY4gB+nkGgUwGpKGI3Gs9FpNbTHAlfS0zrTVEgAZp14GFwOVrlcvPrCuwfHrJ6UOCj/23u5LVIoQE4Mhjs94Huvmu6zaOloxTD1HMp2swlXhHMPRbsY4ullmy4Ji27qnDM05ADuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786216225; c=relaxed/simple;
	bh=S4mpYqMd0/Ct8+6tq7W2kh+rr/6yuokdVT2g6hiCips=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSGrGWTymsuzy6RTdEve+Y7Qphj77WWFjXATUTiGPJytGGkHALyN7pjDuoOQmQF5Yx9MWpitBU6IlkXOSt1aYQnVubyLoQQkMYZJaVCgONhzx/UfP3VKCuXWoodsDSIgkG0jTYB3Xak0W7V6tScNh5whtaxt/4LjN5My8961bkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmUDyGLm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmUDyGLm"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84830c774a0so499526b3a.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786216223; x=1786821023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4wD+x2lcQbQxh5BgV6YYsoRTfpHiShzTcIKLPwOniI=;
        b=cmUDyGLmg/dHkWn4l0LtoZ16S5mt8bv0axPQqMehxeOTlKiHT2nLk8YPPZccRZ6q03
         PMlMnElunlKlEbyAiyab9rb8fqT75iRgmFmgGmHHrWQhK+onGuKypcnfS5LeCcGVf3Nj
         bBNNHuebM7JrBLsdr57eD4IG30/U6w+K6IC9ywHzAq6Hdl1A2/Oxv0o+jB+7FRFgwEZT
         mtQZg1ToHaW+XiLpBrDXDMm8aNrbxQHqa3Q8SyQsSgbQ1gwy0E6FIU6sTe2ALhS4ya+X
         nixHV5OUiBvzlLd86XxcxeB+rA23UPnadFuvLCup5Rov165QEr3vjPA7SfHqptjRCNW9
         I5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786216223; x=1786821023;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4wD+x2lcQbQxh5BgV6YYsoRTfpHiShzTcIKLPwOniI=;
        b=VGOFv/iPLiIfYZ6b6N7Ed7M/dNKsWYCvH3PwodiCngoqBVQk2CZ3cGEcpEdJBqwRRb
         S4XjRGosjwTCdCx7eMSazoj+h2zlpLKovCqofGbwEDondQ2Wsr9lwM+iFCzL7Tm9LjAX
         Uu+F/Lgw4C1Ov1HeskHGpJQiPHuHpNM5wujiDH8n1NNrUQKPlfVtNi7/0GNWfVNLU2MT
         cndNgCxNSK4o2SIZqC9oELwPd34HW+8/bhCbsFD/SR2ScuJMZFdwTa9aqHDOHXjUEN3u
         GMeyjthRLKBSBmIhGQjMGKZdvgsk5E6zU7/0Bm64oV6ALOmnFofAR6/+70EqpcGrDSOK
         ejGg==
X-Forwarded-Encrypted: i=1; AHgh+Rps0hfS8J8mRQYcsO9ZmfqSknd8m6LvqC3y4YDo53IGGCKoiNK/CYAf7GTGWoaZkLz7ps+WxiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUw49nzAgJ8MBhgL0eY+PnwieNmgSyptz6O63U+rbRnHqvoa6h
	1DKotGr1WrYKLuTD7hjozQa5s0IwyCluspNAjVCa0XNF9DeZwHXm/VG1
X-Gm-Gg: AR+sD12zOMvNmzTBgN/ddyoAUBIsqOUvzlfc6JiyU6GrmqsIiEbqVyjymGPUbu85ym+
	Mgco1bUCOWbui1Fzx2ODOck1gmmT+GyPIVZZqD4siYjLTrkL79AGZpwUlYTmTS109c/k5get25p
	3PLo9TOd98Y1WYh4389yRrTwCOoYOb3tlC3uUYpQ2BXpA9BYTc24z8+OM6b7wsuQoih/GAtiKid
	9B3Z5Zivpe93zGdKVPGnKQrZVu8V7jSgqMJqcVtk50RY/8sFeMTwWva5BYRtA4AKxPpao1op1MJ
	bpZ0YRRh64i3ZHLGgnIquINEK1jO4xp0s9gh1kNx5Mn9AgajeHcHf4d6icYD9T6X3LgElHNuulY
	Gp6LPv+PFT5JP4B/2IGuQbAUW4iS4KcCa/X0qhGTQVsnVi331UVAbeBt7qSvh61k+maEs16ncLu
	ujVkHnDifEfzWD1DszKHdPe3r4kh7EphLX+dCqf2Je17+4smzua3VDirvqvfPLPVEx
X-Received: by 2002:a05:6a21:6816:b0:3bf:6237:4d49 with SMTP id adf61e73a8af0-3cbce8d8e50mr10397119637.23.1786216223277;
        Sat, 08 Aug 2026 12:10:23 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:e5fc:7669:b85:3eb7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm18817125c88.3.2026.08.08.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 12:10:22 -0700 (PDT)
Date: Sun, 9 Aug 2026 00:39:21 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Subject: Re: [Intel-wired-lan] [PATCH] e100: prevent shift out-of-bounds in
 e100_eeprom_load
Message-ID: <and-4dPXVkwerqZU@user>
References: <20260807145626.52692-1-pavankumaryalagada@gmail.com>
 <andBqsDhcLG9vDmn@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <andBqsDhcLG9vDmn@x1>

On Sun, Aug 09, 2026 at 12:12:31AM +0900, Kohei Enju wrote:
> On 08/07 20:26, pavankumaryalagada@gmail.com wrote:
> > From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > 
> > When reading the EEPROM address length, e100_eeprom_read() can return
> > an invalid length (0 or >= 16). Passing an invalid addr_len to bit-shift
> > operations causes a shift out-of-bounds, triggering a kernel panic or
> > UBSAN warning.
> > 
> > Validate addr_len after reading it from EEPROM and return -EINVAL if
> > the value is out of bounds. Additionally, use 1U to prevent
> > signed integer overflow when calculating eeprom_wc.
> > 
> > Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Tested-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
> > Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > ---
> > Tested using syzbot c reproducer.
> > ---
> >  drivers/net/ethernet/intel/e100.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> > index 29960762e64a..1de5cd41ea0c 100644
> > --- a/drivers/net/ethernet/intel/e100.c
> > +++ b/drivers/net/ethernet/intel/e100.c
> > @@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
> >  		 * complete address.  Use this to adjust addr_len. */
> >  		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
> >  		if (!(ctrl & eedo) && i > 16) {
> > -			*addr_len -= (i - 16);
> > +			u16 len = i - 16;
> > +
> > +			if (len > *addr_len)
> > +				*addr_len = 0;
> > +			else
> > +				*addr_len -= len;
> >  			i = 17;
> >  		}
> >  
> > @@ -765,7 +770,15 @@ static int e100_eeprom_load(struct nic *nic)
> >  
> >  	/* Try reading with an 8-bit addr len to discover actual addr len */
> >  	e100_eeprom_read(nic, &addr_len, 0);
> > -	nic->eeprom_wc = 1 << addr_len;
> > +
> > +	if (!addr_len || addr_len >= 16) {
> > +		netif_err(nic, probe, nic->netdev,
> > +			"Invalid EEPROM address length %u\n",
> > +			addr_len);
> > +		return -EINVAL;
> 
> An invalid address length here appears to indicate an unexpected
> response from the EEPROM, rather than an invalid argument. Therefore,
> -EINVAL seems somewhat misleading. Would -EIO be more appropriate here?
Agreed, addr_len comes from an unexpected EEPROM response,
so i will change -EINVAL to -EIO.
> 
> Also, e100_eeprom_save() seems to have the same pattern. Shouldn't we
> fix that as well?
yes, i'll fix e100_eeprom_save() as well. 
> 
> > +	}
> > +
> > +	nic->eeprom_wc = 1U << addr_len;
> 
> The commit message says that the U suffix prevents signed integer
> overflow. However, after the validation addr_len is in [1, 15], so 1 <<
> addr_len cannot overflow an int. I think what prevents the out-of-bounds
> shift is the validation, not the U.
Agreed, I'll remove the unnecessary U suffix.
I made these changes and will send v2.
> 
> >  
> >  	for (addr = 0; addr < nic->eeprom_wc; addr++) {
> >  		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
> > -- 
> > 2.43.0
> > 
