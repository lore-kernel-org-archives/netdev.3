Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD736998C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789018321; cv=none; b=sMcPxO58mqwW8egCXTUbjt3I5JzT4GueGTiByDDY9HFpdnfwbwMuYSRF8sJpM79E9FWe+tmHNl2dxQOs41rozDgPJpJKhVSApFKjKtUrxzKAMC9DP7hSJU6Kqx91p3gIeNorrvcnKiPnTcdXOPpzvH6Ri0iBGQgtn+r8HuIUGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789018321; c=relaxed/simple;
	bh=XHT0fni3sj2VLW9gxafSt9NhAWBm2+740tKSjtr/6no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To; b=BL7QRA2VJ90SRUiAC4wHZGx0hpMsSQZuWwoyFoGWfzZRYHL1VRNtMF0QFFx4+LZI6r+tVxjVP1TqG9ljEtnnzjwMKgP3P4bt61BO6ZfUCbieHd/4gmSAEjBF3aRIk6PDawXYFkT3sSYwzTdYddhSdmF/KczWdTjVjn6+w7GCf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=epJ+/gVs; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="epJ+/gVs"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38511175ad3so5063629a91.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 22:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789018319; x=1789623119;
        h=user-agent:in-reply-to:content-disposition:content-type:references
         :message-id:subject:cc:to:from:date:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vODhNi36VwytgJE8sudYkSwW5tA6KB5dxLQCwteMucs=;
        b=UQ8ZI8iOxc97YJ1aS1yU7pjbawbK99CAvlplXJyiBqnJ4kK+5ehO5FKAkaFSnvoRQJ
         B9rcgka2nXE8bai31MxC99U+WD47IdbWiQsTjJAzLiNvXs0GyNKe2nyWCBMyaGsDHv1l
         thtIqjJAwmmert3WWGorVDA2qEMHI4aw9tFBtuZJX/2ycNmLtthwuPCekCn1iders+cK
         IK05wwfBaf/kupJRmjCQzYb/ofakZNJVlcVLsz6R7oIMPezOz0yGD7ouO1pkAM9OL2n9
         QyVxpnlAFO+Y1+Z/hlxpSZ7znU+1M5WwRVDi9Le+nooVoRGM8DH2jauvjdHPOVNlu6mQ
         FVjg==
X-Forwarded-Encrypted: i=1; AKwUvByOyfVVKWNInWoLcSLVaIN3N2JL5uELDaZ4sJDHxrjOszrYvycETUGB1E7mHILUiIVtKqAvhNk=@vger.kernel.org
X-Gm-Message-State: AFuF++ndM36oXu30Qe9FVdM2LdAKlE2DDZ5JEr1Pya7vOnod+R3bt3H8
	PUyGtUsEQiO1WgY2p7LgSROAuiZzJZY7VcbWArOcKI/qHaXf3OE4N35cB2RR3kQEIndmyKb/Loz
	aP9dwXjfcRvAnJY69y1iB8x+Rgm2nc/Phww==
X-Gm-Gg: AYBFou14x6XKaKctF7FOWl8tLGsUWwll7j5fAt74cbwVBfWRo65sT25gntH5EV2mkrm
	CNjnX3fG2enhzl8goAJbQtOwAHboaZiTqvF7CgQynOFZxL/P+kGyhN49fp9mf6LY09yG9AWpFuy
	5oAKDUs+htOwwFoodYtrBAMV9tIBfzjAVB4x0WvC5NQJk8BDs2XU3SGJYcURAKItlQe7UsbzKaL
	9wGKsOPDE7RM83OZhFK83rYHTq4lwpMHCtuLo5FqejonIFiKzp7LBfnpXP6plIFreiKVHRYWuTJ
	D6WtV1qfc7LWOZJm3rXvQ1ZsCDyyaBrKqpfsqgEpw+OKjRpDLP+gWxAWXfFr4p/umJQ1z0pQEkZ
	VdGrZ70CXkZJFPS3q9HIpjRgXdJv/UOg=
X-Received: by 2002:a17:90b:5292:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39d70b7d864mr7544525a91.24.1789018318674;
        Wed, 09 Sep 2026 22:31:58 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx1.aristanetworks.com. [74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d7e83da5bsm617801a91.5.2026.09.09.22.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 22:31:58 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1789018317;
	bh=vODhNi36VwytgJE8sudYkSwW5tA6KB5dxLQCwteMucs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epJ+/gVsgWbqklmlYID8ebA4yY7jBS0M21ifSPHLbubnlXZrtFawEwSI5jNbksuJ4
	 /FCV3E++hMADRkI8mldVKkUIfciZ9b3m01TtELo0gdlRW8E1tjF6r9JVoWlAsyj0HB
	 PPSEqtXb4rI8p24oCpLx4JFpfUJngRYUoHXKL3VjK9N5NdmKezjBUQXpwzNzHINE02
	 QQX3SUTdmRB/jS3fqBvocdhPFeqcOf8WmC0f3SJgeVS6VkyWFl7nKBjuY2x32Jrs9B
	 idc02xdO2PVX2Xrugom9DjIlqWxwRflOsMOKQlVll/ic3uHgynIgOAZC1v8WlXLzZ1
	 9Lk5vqmIQV9OA==
Received: from visor (unknown [10.95.64.1])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 88B961018CE;
	Thu, 10 Sep 2026 05:31:57 +0000 (UTC)
Date: Wed, 9 Sep 2026 22:31:56 -0700
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Vincent MORVAN <vinc@42.fr>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Subject: Re: [PATCH net] tg3: check NVRAM and control register if SRAM has
 the placeholder MAC address
Message-ID: <20260910052913.GA17934@visor>
References: <20260903233255.GA4109366@visor>
 <20260909191751.651aa5c4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909191751.651aa5c4@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, Sep 09, 2026 at 07:17:51PM -0700, Jakub Kicinski wrote:
> On Thu, 3 Sep 2026 16:32:55 -0700 Ivan Delalande wrote:
> > Some of the tg3 NICs we use (BCM57762) reset the SRAM MAC address to the
> > placeholder address on link flaps, tg3_chip_reset, etc. We've typically
> > fixed it from userspace, but since e4c00ba7274b ("tg3: replace
> > placeholder MAC address with device property") was merged, tg3 just
> > fails probe as we don't have a way to get it through the generic
> > device_get_mac_address infrastructure on our systems.
> > 
> > Since that commit effectively made the placeholder address invalid,
> > include this check in the earlier `addr_ok` expression, so we proceed
> > with the NVRAM and control register fallback to find a valid MAC.
> 
> If there are so many cases with known-broken MAC addresses with tg3
> shouldnt we do something like:

I think we could work with this on our systems, though it would be best
if the driver also checked the control register when SRAM is invalid or
the default MAC.

I was testing a slightly more extensive v2 based on Sashiko's comments
as I agree tg3_get_device_address() is pretty awkard in its current
version. But I don't have access to enough different tg3 NICs or
Broadcom internal docs for a confident rewrite, so I was hoping Pavan
and Michael could chime in on all of this (should we just check SRAM,
NVRAM, control register, and device_get_mac_address in sequence and take
the first valid non-placeholder address? should device_get_mac_address
take priority over any of the other sources? should this be controlled
or overridable through module parameters?).

Thanks,

> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17914,12 +17914,13 @@ static int tg3_init_one(struct pci_dev *pdev,
>         }
>  
>         err = tg3_get_device_address(tp, addr);
> -       if (err) {
> -               dev_err(&pdev->dev,
> -                       "Could not obtain valid ethernet address, aborting\n");
> -               goto err_out_apeunmap;
> +       if (!err) {
> +               eth_hw_addr_set(dev, addr);
> +       } else {
> +               dev_warn(&pdev->dev,
> +                        "Could not obtain valid ethernet address, using a random address\n");
> +               eth_hw_addr_random(dev);
>         }
> -       eth_hw_addr_set(dev, addr);
>  
>         intmbx = MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW;
>         rcvmbx = MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW;
> 
> ?

-- 
Ivan Delalande - Arista Networks
