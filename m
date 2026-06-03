Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567D3AB285
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518612; cv=none; b=HoxXK9r/bAdePgix/O3KsQUpV9pVeNHPsJ3FXaxQHlYKdwwYGWfr4yGL88Nz+X1ts3wYj6xAZoyn9uiLzgy9T0HvNwQpyB9GKi0bKEVI6VbSLa+K5BoI1mHyDdz/NSr9yG8DRaG80BDrNUjaqoe/OR2f9mMNaQiN9Lf6Lt5VXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518612; c=relaxed/simple;
	bh=Zeayzk8r43Hq1gsadJMRR/dt7upamT3z1Ql5DLFiDIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNV+N/jE8sv7NuCk5Gb5COUNpGxBgdlJxEIa6uOPI3zcsUEZOpANCyiTaof4p+sqTY1yB1UQZgVrvi89xO/y6R2WUmSB9xR9juxTvFOoCIMseYKBemyokJChVA27Loc7GWL1BWTmbl0nNy65lIK8Q9OWsm7isBwq3LFZQb58OUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qj8XKPBx; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qj8XKPBx"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-842273a2c4dso3413988b3a.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780518610; x=1781123410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MxDKS4wAFrkdc0yHOkBCz57iJLosNfZ61oxZlM7cxc=;
        b=qj8XKPBxyOO4visFdlnO7RhM2o5xBrrbD8nHuKfVIflkRoznL4fGpMpOq9FNM/Np9I
         Dob2fIQWzYjCCMyzeQKORFwKqnKhwK0PokxB3WPYGuMUBsdfVZYb1uZI52qageqLncn2
         i8VP+UzV5i2z45YesSjoz9oo8zvRPPTAFFLsqffOdJ0tE8lZ+nXIRuu6uxrQvsejH59x
         +AfZZU1h9ihhko0CNWuI1hDtNOJKmbu2pGayajKrHFCl0N+dvOCs9CNiUxSQDAXkKOP9
         aXw+qU/LQL/5tsPbyInMYNGacJc51S9Z1Tq494RpGTT/oESdAdKsAvMvw+u5p0XPzXjj
         ERIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780518610; x=1781123410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MxDKS4wAFrkdc0yHOkBCz57iJLosNfZ61oxZlM7cxc=;
        b=Lnbn5xQsUjL45yyt5dBvBmbzk6xdy98R/BxpMYhWuDGSnQk718YitL4xO8+A6mIZrk
         ZiMFPH1Dwh41vF8JLXazGqkmNsBoA31Vgo5kSC2mEqB0bUsLxdsH+E6iOky5VPwvu+gA
         leYg19Nj7NQCRK5y9iRRyOC32l9XHcJfas7/flPhsPATxXHlMeFcCXUg7ewXd+ZlNJwp
         1MHcUm6MO2Z+HbiAKBiIBQFqIOSIUiEnymQJpB1Q9lnJx1NPYD/CNxPmxDQG2tUTnOEQ
         Cl1rEBLJzwlAdRHxkdjBPBaShnpYNaKwmwiOP1hYYB2F+TIggpd4pxO19I4Chi7lOOIr
         YK1A==
X-Forwarded-Encrypted: i=1; AFNElJ/MuA2p5PYzLh1v3XkHS86VrajHj6wiCGUybYnBOKxpfJs2QgZYKQfF5bCwoano3jYpjDyrFdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2CLsWm3PwlEVZyzlPk8cgKV35FAFl9RS0BCh51jJEuGo6J6yw
	YyaW64j+Jy3+/SBlpPxWK+Wq71ZYVcB4WoaaRfEMuKHpxfieQnCxQJsg
X-Gm-Gg: Acq92OE1q4UT4kX2w5euMEi3oXEzeG0ibGL/iQofk0kHeoABtBdeEJgUEQYNYfQ6O9i
	JD2div9UesfkT13ySqpRGuHWf2x1ZBh3hRsTHv24KZp9byCS9HDGxVoVdUt4ihBaDxOFxMXa4LG
	Mrmvb1DPXFJsF8DaY6EVXmTZyLJQ5D62qo5Fqb1C4WtBqfsNgTLuFfut/CE8qFtQUft9gVGxsjH
	2xnBBkje+WhmDYP8o4UleoIvkuSuKT4p36RbxdBGWc7G2TH8ArolVqvzsowmikt3eY5CISncwXU
	gGJRAf+tdCdPJtCFZNqCO/YZ6gGBspC+Rk/YWbSRvjWujPvKv3r5VGnyCA3G2JIB39IcU1GjAhB
	4520LabRheBOijWqDeUiBwbRXFttZF92gwA7dZYIrbrWHEQP/BOR5ARbuKpaXPeko7CAgbbnTK2
	3VTQerqUcJf7gvB9i0NEyPWXVvQJ0=
X-Received: by 2002:a05:6a00:3695:b0:842:48ae:1d43 with SMTP id d2e1a72fcca58-84284ee8c92mr4908287b3a.23.1780518610339;
        Wed, 03 Jun 2026 13:30:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282880050sm3762295b3a.29.2026.06.03.13.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:30:09 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:30:01 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Breno Leitao <leitao@debian.org>, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	sdf@fomichev.me, aleksandr.loktionov@intel.com
Subject: Re: [PATCH net] Reapply "bnxt_en: bring back rtnl_lock() in the
 bnxt_open() path"
Message-ID: <aiCOkGESivcRZsR1@devvm7509.cco0.facebook.com>
References: <20260603195845.2574426-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603195845.2574426-1-kuba@kernel.org>

On 06/03, Jakub Kicinski wrote:
> This reverts commit 850d9248d2eac662f869c766a598c877690c74e5.
> This reapplies commit 325eb217e41f ("bnxt_en: bring back rtnl_lock()
> in the bnxt_open() path").
> 
> Breno reports a lockdep warning in bnxt. During FW reset the driver
> may end up calling netif_set_real_num_tx_queues() (if queue count
> changes), so calls to bnxt_open() still require rtnl_lock.
> 
>   net/sched/sch_generic.c:1416 suspicious rcu_dereference_protected() usage!
> 
>    dev_qdisc_change_real_num_tx+0x54/0xe0
>    netif_set_real_num_tx_queues+0x4ed/0xa80
>    __bnxt_open_nic+0x9cb/0x3490
>    bnxt_open+0x1cb/0x370
>    bnxt_fw_reset_task+0x80d/0x1e80
>    process_scheduled_works+0x9c1/0x13b0
> 
> The reverted commit was just an optimization / experiment
> so let's go back to taking the lock.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Link: https://lore.kernel.org/ah726OtFX-Qw3U-R@gmail.com
> Fixes: 850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: michael.chan@broadcom.com
> CC: pavan.chebbi@broadcom.com
> CC: sdf@fomichev.me
> CC: aleksandr.loktionov@intel.com
> ---

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(Let's do a full revert for now and we can revisit once we sort out
netdev locks for qdisc paths)
