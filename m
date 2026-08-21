Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BA3290AA
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344614; cv=none; b=O12yvmyl03ToCsBYEzJ7VKgqyMcW+5VWm2XWj1AV1lLckUpjK6X05FfgdfT9h9cRnu1//tDMO9ederVmS9yuHEUEDKYs6bSfWyfxCZ8v7tIcjbh0sxJlIei8GRAgpdvuH6CwSkmYPc+GMc7Fz4XyVufsfNDEB2la6l2R/P9ybwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344614; c=relaxed/simple;
	bh=juFzRqmgnp4GrYjLQBzkac0XkXptzzDEmGklZO07cHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfVm+FNZ0ZNBI+Gy9J0ombxQannE4Dt3PP37B52ZDeV/t3Zvflv5tj24q7ewKtF5eLDtxGytEm8SoExBU3MuQKlDIxtsajvn29wY8946Fd6kRA39Sid2HEs74515W5xZmnK2mDUFL0Xp0S7IzVo845YCzN3nfR6K0+ogvA+93TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBtKvkKX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBtKvkKX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso9816295e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787344611; x=1787949411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7GhATLDXR0r37fdF81Q936jYQcN6+SnW0C5ynuRsfMc=;
        b=cBtKvkKXWPBpUuBxWRcb/WC8RIBDyRKGDeJc8c8YO+FrTXBJDnBtndxe1M4Cn/qdL4
         sAqZ//y1gw72c6w7CbZrkm+qfjprAQWy9atTow5cSBboDUNWbG+1+Gig4sZ3CmC/6S2Z
         uOij++eJaO8xJZN/piKtKEv4Cdry853qdddTG3Rrhcwj5f2fbfQi6QguT51k3VikviD4
         n/UwnhuvzNNUYjAPzBmmrS5KORldqPNxt8VDdgscTZtAkCjLX7EZl1OIf1W6cGvnn70v
         x+uY0Q0ibYpX2GdMSdsjLFKD+bd7geWzR3/HHzp0AjY1MwDuHbIiuvXzJO6nmq5ImTU8
         o60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787344611; x=1787949411;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7GhATLDXR0r37fdF81Q936jYQcN6+SnW0C5ynuRsfMc=;
        b=GIL6+Lr6R9PfhmqfqUKwiCcxZlBnworS8+Brn/dGPQ9hsMMIBH7c+Ns6AarTAopsHX
         4Q6xjRsjWLpaMb6aQV2Ux7UCzXPZBEJ16L5LBwgI9FOLY2ULipVahWcYTWOhM6/NRs+m
         W7+TSlwWYIhHb29lEURkfjgdGxW0i03VxcTZc7PUcuzNSRidfWXY1Wa4M0C/FljssDuc
         3xyUQWPWHLXWKFR4MKcRZ6lxqfWViFqk2ptu2mC61pTrg4sHE7AZUYhDLutfn0yn7WG6
         bprBKi8rr5g1Opwe7ns8uphmS6TV7faDKHofF37Uq/oziA5I9MV7lLEl707KjiPkZ8HS
         Z4Rw==
X-Forwarded-Encrypted: i=1; AHgh+RrMXMq5MDm7ZnaLDtPP7+Le6oYSthHbjeDLlYyhb6Pyz+DwjXhyVssW5LJkxp701jCSnMCMvWg=@vger.kernel.org
X-Gm-Message-State: AFuF++mXACSq1S5nEmUo9n30637k2S2oo1z+uCu91ejhyWI+3qwQJuHw
	SmkEpd6GLSBXmYgHUp5SWn8x0T0CtmiG2XLfv4wVOaRRiqscnIZS6Ppf
X-Gm-Gg: AR+sD11uhqImoNMCJPx0MJjgwE3qVFo18x5D1J8npqeSgMqZfvGXOtPJlWVfHYNRIcH
	TzEEXjKw2MMZxFWxg66S4rsQ6uMwDdd4bm7spyDrjSgVQpmfZbDq4cGqJhXHSJEzM1eTkgHVO1t
	VI+vfDBUtdQ2GYjnAZ1CZoFUvIKGTrmKvgY1xX2rFmATLCvoHUqfh20QGzUqRhf0d/d7E4+eWfl
	x/sFQv1Ghqqf1IPj9f/mTAGA7fo4j+59095Q778nVt4nkOMiogYY6Y2DWBZZR8V3O7AVPxlDt+L
	4zIJIoN7/9hpr294x103D3WPaAi2Qsb9NlXhccXKdx6PIqTiiV7gFZWt+HaWwSeaijzho54s4Fd
	s1Hs7VqKoracZz43nbdSKIr5WYSUSUHy+xnAWnOCo1kIs0dB/3/0miLsqbpKGg3JvTYSvYTku/U
	tIXhEKNCAhk3OT/8BHLY9fH+ztSlg164+b2x+ggdrDvb8XAAiZwGZQJeiv+LfHjARifK3qqrsl6
	ciN6EGB3qDJxxdWBHssU5xaFg==
X-Received: by 2002:a05:600c:4f0c:b0:499:80d0:8b73 with SMTP id 5b1f17b1804b1-499b8324cebmr141784375e9.4.1787344610835;
        Fri, 21 Aug 2026 13:36:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b915c6ccsm39410185e9.13.2026.08.21.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 13:36:50 -0700 (PDT)
Date: Fri, 21 Aug 2026 21:36:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: James <aslan.jnn@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, netdev@vger.kernel.org,
 Thomas.Lendacky@amd.com, Simon Horman <horms@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH net v2] net: amd-xgbe: support receiving packets with
 bad FCS
Message-ID: <20260821213646.7bbb94d6@pumpkin>
In-Reply-To: <20260819091656.23943-1-aslan.jnn@gmail.com>
References: <20260812091616.35811-1-aslan.jnn@gmail.com>
	<20260819091656.23943-1-aslan.jnn@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 19:16:56 +1000
James <aslan.jnn@gmail.com> wrote:

> amd-xgbe driver currently sets the MAC_RCR.DCRCC bit whenever RX is
> enabled. This disables hardware FCS validation, causing packets with
> bad FCS to be accepted unconditionally.
> 
> This change unsets DCRCC so that packets with bad FCS will be dropped,
> in-line with typical behaviours of many other network controllers.
> 
> Tests:
> - Verified that packets with bad FCS are now dropped.
> - Verified that receiving packets with bad FCS will increment the
>   `rx_crc_errors` counter.
> 
> Signed-off-by: James Nugraha <aslan.jnn@gmail.com>
> ---
> Changes in v2:
> - Eliminated DCRCC toggling via RXALL: now it simply sets the
>   correct default value on MAC Rx enable
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index 2de974213..3ceb130a0 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -3400,7 +3400,7 @@ static void xgbe_enable_rx(struct xgbe_prv_data *pdata)
>  	XGMAC_IOWRITE(pdata, MAC_RQC0R, reg_val);
>  
>  	/* Enable MAC Rx */
> -	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 1);
> +	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 0);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 1);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 1);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 1);
> 

You can delete the line in the disable function that turns it off.

But, really, you should be setting the required MAC_RCR bits in a single
write.
Doing RMW sequences on the hardware registers for each bit is really wrong.
You also need to start with a known value for all the bits, otherwise
'silly' things can happen is (say) some bios boot code set bits you don't
otherwise change.

	David
