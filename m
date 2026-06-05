Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F13A3BE628
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676517; cv=none; b=OwG7I8HYNUfbxUBaxHS37GXJTrioY2OnpNiOAn9YIGffXngqP78lV+YlLMtQv5BQYMyWkFLDCg/lKJZ/OuadMYj8lueP13KS/Gq6UarsXB442yolVuGTzVfoIZ0949Zj5I0jxCrZoSEq4cVLbkRIOL5oYCKFjTeakk+tkw1dBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676517; c=relaxed/simple;
	bh=aOkQ2IhBqwZL6dzu9b6PmcXNKNwJXTLtzMy77q2A6/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzsieWsXEdW71E+RUhbSxLnXJ2077qbWPyWZQ59pDIk4N17IwcEbx+8dcRESJu7rEojwswHE84Ik5R/Di7CAWN5jR9mBttwdSjwDVmvej/pS0GXr/Yec0AksJ2LUE3B43YpdFnR288Rp5vSMiuIke/mGJGh8xd//1R0Mhha0hU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGn72R9g; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGn72R9g"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2bf114b0cf9so18155295ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676515; x=1781281315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qRAi/oi2KpemqqDHz6KIOuHk1ZV+n33AkcPfFDrk444=;
        b=MGn72R9gGeSjTylP5Il1NNajTtTXxWIOpW0gbKM2lkTFoT41hmhmX+UhoNmlx2syVL
         TMbnWv+pGD+yJ+EkaeMEu+2/s92VJkwLpuyw9x5+JvDwTRpDQY92o8B104je7mUoGWBJ
         4vjpo/Wn6pqtHPv2D8qbxLzVInKfO51ndbai7EbiYipkaT6xGrZ/I4qq6/DBvCC9raDl
         OMKqOcky/D97K4tQoX0H8uKYj4Oc4n4RHZ/cH8LAJtyvbeT00r0Xx11EpC8JSmOLKCJp
         quXQgnQ6OSEIWj5oPKxuCTyIYrbeLy4K3cnXkzn1Kni4eEjYqI+dj77BgoKpSTulOWaa
         fQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676515; x=1781281315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRAi/oi2KpemqqDHz6KIOuHk1ZV+n33AkcPfFDrk444=;
        b=s4B2yKQDx6P5W7aBzPpFyIiZ2HfVJO0+1lYt+5vcZdJbmNLnkn4rnZ6glp+jcQjFrH
         G0eEvWw396Pis+xtipKfF8Z3BgCdw3H8mFIE72m4YBHHm3EWF+tKNKrFyR4HK/lc9N7P
         tCjOaRqE0XRV5W+RNIZvFDZTjK/+YB+9Fb3dVW8o6UadEF597bMGhT8AzvjGH2sVQQ+S
         9BDWeg/RkjretgAy9TtyO2VFtClCKz6F6dKi4aTn8tDmd7XwDnCAgQyBvZAkoSeV++L4
         zg6Oej9j3YLxTJJ5iVvpvkEtAzzkTP9eW8zu53wSpy0Z7GfLhQ4zLkOqR7i0ph58MPgg
         hG/Q==
X-Gm-Message-State: AOJu0Yz8CK/g56DLYYah12mM+IhOK71+fCissjWVI+0iyxJurRVpezIa
	iEkqaDJJpVcYI6UgODR5NfNtPe+L/wyqwTn3qL0GjraBgQTOfIhHq4/c
X-Gm-Gg: Acq92OFXKaTA/pdrFhhNH+/FlIx9SdYy80UQRSxNKCIxxXiFs/7txwD+/cTPJrNjzNt
	hGbOkYa6jbxrW8IATsZQHvEByopolw0ZUrSrlCdnqfOzxFlhwMonEpvRhdQ2nqWo40ebeKfSrIt
	j7cGr2kxKf64P8GtsZlJClczCz2MJ4l5w8NJ7e8VIHmrf6h6bU0DiIeHjbiWG2a+ACAvMOpjT87
	g0r7t2s5Cy5yD34Fzt3p2wTWfS3iLVR7VCI+Gb9NIP2laKaBWWzv5Vn3OTHi1+6wJxhLf6T256w
	kibVUV+CrLqjA/gqBjJBqlge2me96y8uBB6e2w9txGnFjBjHuY4BHkbCgBbuc8JbspoMFPumgCh
	wahDtgNDQJ2rqJOKOTZZSxErz87/O6PzdD/AqpwQFngAdATgIBORWHT9/z7jeCrBOH4ixqEbr2e
	dHYiWOfG9hcIvgVlyU8EiplcM8vck=
X-Received: by 2002:a17:902:f611:b0:2c0:bd28:bed5 with SMTP id d9443c01a7336-2c1e8214337mr49406245ad.10.1780676515517;
        Fri, 05 Jun 2026 09:21:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm96975065ad.31.2026.06.05.09.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:21:54 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:21:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next v2 3/3] bnxt: convert to core rx_mode retry
 mechanism
Message-ID: <aiL2qF6fmNJ98tTg@devvm7509.cco0.facebook.com>
References: <20260603223535.2504695-1-sdf@fomichev.me>
 <20260603223535.2504695-4-sdf@fomichev.me>
 <CACKFLi=xWQ88cdFxA96qEScre0jog9B1m4AikPcrc2TN3Xz2gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=xWQ88cdFxA96qEScre0jog9B1m4AikPcrc2TN3Xz2gg@mail.gmail.com>

On 06/04, Michael Chan wrote:
> On Wed, Jun 3, 2026 at 3:35 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > Remove the driver-specific BNXT_STATE_L2_FILTER_RETRY + timer + sp_task
> > retry mechanism and rely on the core stack's ndo_set_rx_mode_async retry
> > instead.
> >
> > bnxt_cfg_rx_mode() now returns errors instead of swallowing them. The
> > PF-unavailable case (-ENODEV from HWRM on a VF) is normalized to
> > -EAGAIN at the boundary so callers can match on a single "retry me"
> > errno without re-implementing the VF/-ENODEV check. Other errors
> > propagate unchanged.
> >
> > This removes:
> > - BNXT_STATE_L2_FILTER_RETRY state bit
> > - BNXT_RX_MASK_SP_EVENT sp_event bit
> > - Retry trigger from bnxt_timer()
> > - BNXT_RX_MASK_SP_EVENT handling from bnxt_sp_task()
> >
> > bnxt_init_chip() still calls bnxt_cfg_rx_mode() directly during open.
> > On a fresh open dev->uc is empty and the call effectively cannot fail
> > on the unicast path. But on FW reset reopen (bnxt_fw_reset_task ->
> > bnxt_open) a VF may have a populated dev->uc and the PF may be
> > transiently unavailable; since that path doesn't go through
> > __dev_open(), the follow-up rx_mode call that would otherwise drive
> > the core retry doesn't fire. On -EAGAIN, swallow the error and call
> > netif_rx_mode_schedule_retry() explicitly. The unicast filter loop
> > truncates vnic->uc_filter_count on failure, so the retry's delta check
> > sees pending work and reinstalls.
> >
> > Cc: Michael Chan <michael.chan@broadcom.com>
> > Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> > @@ -13758,11 +13762,8 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
> >                 rc = bnxt_hwrm_set_vnic_filter(bp, 0, i, vnic->uc_list + off);
> >                 if (rc) {
> >                         if (BNXT_VF(bp) && rc == -ENODEV) {
> > -                               if (!test_and_set_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
> > -                                       netdev_warn(bp->dev, "Cannot configure L2 filters while PF is unavailable, will retry\n");
> > -                               else
> > -                                       netdev_dbg(bp->dev, "PF still unavailable while configuring L2 filters.\n");
> > -                               rc = 0;
> > +                               netdev_warn(bp->dev, "Cannot configure L2 filters while PF is unavailable, will retry\n");
> > +                               rc = -EAGAIN;
> 
> Note that bnxt_hwrm_set_vnic_filter() can also directly return -EAGAIN
> if the FW is busy and retrying is correct.  It will drop to the else
> statement below.  Adding an else if statement will provide a more
> proper warning:
> 
> else if (rc == -EAGAIN)
>         netdev_warn(bp->dev, "FW busy while setting vnic filter, will retry\n");

SG, will add, thanks again for the review!
