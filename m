Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4C3BE16E
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173958; cv=none; b=QB84qA2g3rfK50Yjbbb66XFfTyiWy8OXlH6yhKhuXHuoa0ufZ6cKsXmi4XfKV0oF+1gnbEeihYyAY0YkbUgSKW9/SBpJXODT53wOt8jfma48DFNdjUMdUJLA+lCbW282gITt4zdZRB4ugNn/uT+G0tjuC1kwaRQ+xTGXLRqwc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173958; c=relaxed/simple;
	bh=GxgktiqAzN+ecCt/BjjOH/Bm/IukkGQZuCK/Zhh0l9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1qn/M3GOLRbc/Jg5way4s2nWFfEG8+WtZdkfJ2L25fO3Hj0BupTJYv1qh5AMSRfgympeKJjYZCt1efM9MxKqMoELOAdaVDCTTP8vNIxmM6qDY9X1OyN6mhoCBmXbWmp3vmtzP2ee+MjXv7C8Ll+SDALv0sMH0H5FnyuoEABLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Ucx/o2lO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Ucx/o2lO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so44466785ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785173956; x=1785778756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZxVdhROmsZCB22C0ul9NS5T6lEUR3SmKQdrqPP+L6gg=;
        b=Ucx/o2lOuB6FjfP13OaMld8lEh7ExcOeinVgvkVyuYI8lqgMkRoIXSk1PoxUPFdDQx
         vuhcB3tW/kpROXzlV2AGIXchAjQHO9w2FkyYLZIFDxrurdGhi46t8uhAUmk3MFX296FD
         6I7T1I3ed7SWJHoDsyb4pSdfvJK/zM8NQzTLLrM19abbSFQeEhiene++xUS4cgZo+rlF
         suwkxxS/ZKPuXkVAVcAEybC39TPzYnhfrmylUjtM1N8HXr3wQM/n7fZQN11Zl4wolOW3
         8/Gsn+yhoC56OvndJhinkqdmEKPGcXZC5ForwscM7DbU8mGMZtg9SfeFaAZKLQUbmVRT
         cSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173956; x=1785778756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZxVdhROmsZCB22C0ul9NS5T6lEUR3SmKQdrqPP+L6gg=;
        b=Bpa+ripElKiyRtjtES9oSWaygXokTQZwSRM993qiP/lYSrbedrGMAgfOrGxdcW6Fep
         40AlewP/JZ+w/ovlGnmiH11T2uBKStDOuQFav6ouqtHDpWpteetYHuSu1zZRKc85+9t+
         ucFNxii1i36hV2bqRbLunPCZzm98+JhNbTsdeyHo2XxuMBXrC4qV+Fl4KMpwabbXpP0R
         QcDWgo27uJJ/sXVATB+NyT7ESKPIgABLi601TaY5BLVhO/XU5+jBYFxlSUAaQPVaasHv
         ZrEQOwc3MeaQLhiG8zPKZeUBNZ1+5Ye3HYZtuV+csuB+sY34XKrx0upicorH/C0kTwj5
         z6dw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2QnTcSaPe4VrWdXbufbAjZCJDkfyFRPRTL5ZEPbCNK5/8KDIaaoh+96R0OuDJthEZqbhwPBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEj86HFMhcqmh7eTjXOhaRy6LNfyPrJ8KbvtcjxtEC/afFr+l
	tcmRdJkpn1HCKoUFCWhnSf9GJvLl/dFvEC+b3bUOFyCR7WPkwH7ANd93egFwxtwPqrU=
X-Gm-Gg: AR+sD13UuYaOvd15POfWJFZAMA9Gc7qOZJJsyRyqlR7eodavS+k1/FGYw6YGlQFE45Z
	v7s3/rQSiqGQfB7OC7/kU9AzExIMKpONbhnf7PMJEe8k9KdtxECy//qttq2YmD9YH+YoyJhools
	wQrgJtPO0krhGDBsfmou2sspD9PvrCmlMzstb8Zvr4RhYT5v0nY7rTiG8pNpvVAOKSd+QfZFthy
	7enFJd/+fh0ay7gDXLuToAORoIsrGJNXfbmUmxvjOXsqDdnN6pcLf82QzW2llkdvFgQosB7/JQQ
	uwuIQ9wreyOm86soYFyUeBn6XuA0IHx6zannxI/o+gbfVs3Bv1Oe8+s9JBS39Jf1mFHr/uOshun
	uGSxhGo61QLVF9cTzZ+v3SB1ddHJ8TK7LB6vcYZUMqlarYbosLE2NqErMUnE=
X-Received: by 2002:a05:6a20:6a09:b0:3c3:935a:af2c with SMTP id adf61e73a8af0-3c67d9b3f83mr8904886637.3.1785173956413;
        Mon, 27 Jul 2026 10:39:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660daf6sm3541156a12.2.2026.07.27.10.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:39:15 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:39:15 -0700
From: Joe Damato <joe@dama.to>
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sln@onemain.com,
	jbrandeb@kernel.org
Subject: Re: [PATCH iwl-net] i40e: fix napi_disable hang in i40e_down()
 during firmware update
Message-ID: <ameXw+HOp25Q68R5@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, mheib@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sln@onemain.com,
	jbrandeb@kernel.org
References: <20260727115756.105038-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727115756.105038-1-mheib@redhat.com>

On Mon, Jul 27, 2026 at 02:57:56PM +0300, mheib@redhat.com wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> i40e_down() expects its caller to set __I40E_VSI_DOWN before calling it,
> as noted in the comment at the top of the function. All callers do this
> except i40e_vsi_reinit_locked(), which calls i40e_down() directly
> without setting the flag.
> 
> Normally this doesn't cause problems because NAPI drains cleanly on its
> own. But when the hardware is in a bad state, like during an NVM
> firmware update, the ring descriptors can contain garbage that
> i40e_napi_poll() sees as real work. Since __I40E_VSI_DOWN isn't set, the
> poll function has no reason to bail out. It keeps returning budget,
> napi_disable() keeps waiting, and the whole thing hangs. The thread
> stuck in napi_disable() is usually NetworkManager, and because it holds
> the RTNL lock, the system can end up completely frozen.
> 
> Set __I40E_VSI_DOWN in i40e_vsi_reinit_locked() before calling
> i40e_down(). i40e_up_complete() already clears the flag when the VSI
> comes back up, so no additional cleanup is needed.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Joe Damato <joe@dama.to>
