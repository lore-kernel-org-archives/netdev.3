Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640B4B488E
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271669; cv=none; b=jDxIGHr4dpdOYQWEh+ecX0aEqhEov9C7hPfeTzm17ZLrt6h/B0YwHL3ACRATr/pGkrpPpAYsbgXg8Bz2GWKz+gpO48LidVUDmqr3453JEOCnPQGDcV7xHlGyoBxTStRVY/kjCMau8J9+CGZ7iiq5Mi9A0lhsmRW1PJ3jX1chbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271669; c=relaxed/simple;
	bh=hXEcH6B3ccS4e9wy9ATb2cb7MIxnwVYgsDksqTmBs+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOHGYRgcBhK/th2cbc0wtKOLVlY1Wj1+YvEmy3Chqm+DTI+q75fE23U5Azc14hLg7M1OaoQO9dkyPPJKMBVtZQTVH9wy/EuhaB9I86ngHfuMzSyeKygi4O3movsDFJL3sN8t8uqwMinAUMnBFt/rrxJSK55dmE19aoniCk7xbmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=xmiAitzU; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="xmiAitzU"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2df8de41d5dso96505ad.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790271667; x=1790876467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDwwqIv8dDcJdDjnvziu6xjH0tPukA8ioumKbkDzNZ8=;
        b=xmiAitzUfR2syWSMbqFgRw9j+EkYZpYG8WqhF3LtLQq30NutO2mgEEMztWjfg/PQoo
         hkZppxFX5S3RcJ4J8S8KBoNEGi7DV/US3LBs4Mx+3zx2LAI8/oba6TINtLzv6S6/Xxnn
         w9LttKtSM9Q9G25Jp3df+HqskeUzD1GMmwnq0cbwbZ9bgeKZ4ljURFk1i+IjqOXzJTU5
         i3FmEtQf/70WwZN3yo6raAiXZrIE0Abx4qgffDit5Wve0+0f/D8gSsrokFpgJMRbtMGU
         gtGO/7rbmR8CCxRelgRKb3r0ciikwcENN4MHIS+3oHqFKaHOXHQCdK9ejd0NA/ixs/gL
         ucjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271667; x=1790876467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uDwwqIv8dDcJdDjnvziu6xjH0tPukA8ioumKbkDzNZ8=;
        b=fQxNazg08vF5mBNol6qulGiLtFw9HT2FCVjyedI2ep4RGH3RYuIZYJTzAvFqKdaK3B
         46m194qjLMLCgaVJ498+u2wJC/U7YncphNpJuVoE+xCtS7zlE38cmlOHwU32HXKIo5JL
         S+d/Ni1dx/R1OfDUXstSB1AwHKadGHq7Zlq1jIV7FIb8MqMWJhPuP3dU3ynPVZWZU4dF
         JbkeQA5qKh6fqtAQCosqy0bkRFri6+adwNJwN1q6WjTOy4dZJEXUErlYoDQqgArkxGUD
         LUo9fR8SbkbdJGQpoEciaoO4FBIQXVyHnBBCsTdOw3t1HMNR8ujalDvLglMUOw6Fl1ST
         SRBQ==
X-Gm-Message-State: AFuF++lF3GvmrK51dL6cGZlUwycxVE7WagjT2kK2/ZiFSSskfdeHkY6N
	zUcue5OV1Vc3dlIGEDvQgen1v8yRIxj9b52rEhz3T655uLe3BTf+l9LbWEPvNSHVTks=
X-Gm-Gg: AYBFou2ir/Z/6LZPqA9i64jWoK4k5idARkoVmup0POeTEXMc6vGKn+1PmKTd539fUZJ
	fJvaEO1OM35k+jScVqk/EURlTqoNYxNojxbBjBh78xeVXKbMtgGcAQxzmq1VsXoRlPgl0gtPJIL
	SOUZkTFZzjXRqj2qgC3kO/H8YDB7x7irctxZoBMAOZojwSGaskj22JGNrz4qUrrA6qrRt1gcQbW
	CVX11ALGYlXbfhdX9Ujb3huaPLCXJML9wQwsl2Cfq9wtglTAqJrW3LvCWZFoX6HZiU6KHXp4Rl6
	WOMws9RkWF6a8Gq28nXnYDjskMQ7XwgMyK8kGveaYtLE9T9REVjvvI3G9Z5ftJqqMWhY9guTmjx
	iQlkVqrNq2t7VsgBDy0pAWxt9tqoZ7qIP0qOqdjZxsFo1no+GRXLaatWVVJd4/N8VdAELQ2l73G
	IXM9o3HSVs/uR+e5JFjwfMHTiV9absA9mwV77qUTUx8vrKhwItK1ioFTJKyGizwq8Oo0S7i+2fk
	J9m/8jjd9h4o0wmiCBCONI=
X-Received: by 2002:a17:903:2cb:b0:2d9:6db:9fcb with SMTP id d9443c01a7336-2df7da6100fmr29424525ad.11.1790271667303;
        Thu, 24 Sep 2026 10:41:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbbd2asm343275ad.12.2026.09.24.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:41:05 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:41:04 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net v3 3/3] bnxt_en: stop DMA before releasing rings the
 firmware did not free
Message-ID: <arVgsJAfoupBPoEm@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org
References: <20260923210744.3406861-1-joe@dama.to>
 <20260923210744.3406861-4-joe@dama.to>
 <CACKFLinDP66z0EA_1pL+4jbC_tr1Fe2mcsaan+xEFebORBcyAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinDP66z0EA_1pL+4jbC_tr1Fe2mcsaan+xEFebORBcyAw@mail.gmail.com>

On Wed, Sep 23, 2026 at 11:26:47PM -0700, Michael Chan wrote:
> On Wed, Sep 23, 2026 at 2:07 PM Joe Damato <joe@dama.to> wrote:
> 
> > @@ -7798,6 +7802,19 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
> >                         bp->grp_info[i].cp_fw_ring_id = INVALID_HW_RING_ID;
> >                 }
> >         }
> > +
> > +       if (!stuck)
> > +               return 0;
> > +
> > +       netdev_err(bp->dev, "Firmware did not free %d ring(s)\n", stuck);
> > +       return -EIO;
> > +}
> > +
> > +static void bnxt_stop_dma(struct bnxt *bp)
> > +{
> > +       netdev_err(bp->dev,
> > +                  "Disabling DMA before releasing ring memory, a firmware reset is required\n");
> > +       pci_clear_master(bp->pdev);
> >  }
> >
> Thanks for the patches.  The general scheme to more properly handle
> RING_FREE timeout to prevent possible memory corruption is correct.
> However, the corrective action here feels incomplete.  We should at
> least set some bp->state flags so that at the next open, we would know
> that something was wrong and could take further actions (e.g. FLR,
> etc)  to try to bring it back.

Thanks for the review. That makes sense. Were you thinking of trying to bring
the device back up automatically or requiring user intervention?

The automatic path is probably somewhat tricky, it might look something like
(psuedo code):

  #define BNXT_STATE_DMA_STOPPED  10

  /* bnxt_stop_dma */
  set_bit(BNXT_STATE_DMA_STOPPED, &bp->state);
  pci_clear_master(bp->pdev);

  /* bnxt_open, bnxt_open_nic, and probably bnxt_half_open_nic */
  if (test_bit(BNXT_STATE_DMA_STOPPED, ...
     bnxt_recover_stopped_dma(...)

  /* pseudo code */
  bnxt_recover_stopped_dma(...) {
     pcie_flr();
     pci_set_master();
     bnxt_fw_init_one();
     clear_bit(BNXT_STATE_DMA_STOPPED, ...
  }

That's just a basic outline; I suspect the details will be much trickier and
would probably take a few revisions to get right.

Instead, if you are OK with leaving the device disabled until a user rebinds
it, then I'd define a new bit (BNXT_STATE_DMA_STOPPED), set it in
bnxt_stop_dma, and then return ENODEV from the open paths. Simpler, but
requires manual intervention when this occurs.

I am guessing you mean the former, but wanted to check before I started to try
to write that code.
