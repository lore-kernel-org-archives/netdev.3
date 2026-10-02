Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715041B8C7
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971403; cv=none; b=ehE/Mc3iAItg6Qx7bGrNMmKfV6m7nyeaBullctFtej3kKSNEOx7b7KwBAflBRwIZqB8BLJwwYTOB+U/cV72jJbFZmrHLR7f2IS2Ef08Fuzpdk6VBrUS5Atft374x07e+gq1yr9DE1JuE4+4nSMmKHXyR5Vq/HAOtDVJGaM6zmTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971403; c=relaxed/simple;
	bh=9N4uXc55oTSBP7+m3XEcdVOf6NU801rZ0252eEcQPX8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHiOJtL7lbCLbNxoy0wz/8LiyC6w9lpduu22M+0Uhmgs4Ahe0N1v2fnDnagijcnpcBlqY+u9gDkajT66LlWY9867KPxKRDe+dX1JoYHYa1CfJIJdmFhXlSo1VEESQkxGEQKaKY58QdWkEPcZK8tgxAPakl9J01PuoQ4UHwoO06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X76LODGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X76LODGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C371F00893;
	Fri,  2 Oct 2026 20:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971401;
	bh=c8dMNb0DeIZJ2iZVnGzCJALVllV+FqyDskqryk4KDe0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X76LODGmfPLCM1sz2FShE6Va2rnxprIsKfwdaND6iowHceaNSmRfN/f9xHQ+aMBnz
	 bJ0GkDq8fmWcRKo/VybMkHNEvtMx+fDDlBCTWpv2s9PH9BX50zfUvrxIYFp/jusa7Q
	 Zc3hqdJ2vbB2XmMlLH0Se0/ofHgLkDuu5haIJaVkOwI3MF+Fgk5ve58yWpNbozwmO8
	 cXaFFDFXHz4huLjfcKb+5b50BPtJSUu0p1nLbz1Rmil+Fx0iX3oHtqK4CkAGjv5UDX
	 /X1lrYmlwr9sx684gXc7R5ntf5VeRKQf5pMeqRA+BRREBl3PeUjCAwhRY7DWgZQmOw
	 kw2zpE7a4x7EQ==
Subject: Re: [PATCH net-next 04/10] ice: increase OICR interrupt moderation
 rate to 20K interrupts/sec
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, marcin.szycik@intel.com,
 jacob.e.keller@intel.com, przemyslaw.korba@intel.com, xiongwm2026@163.com,
 ynorov@nvidia.com, horms@kernel.org
Date: Fri, 02 Oct 2026 20:03:20 +0000
Message-ID: <179097140029.434549.3609808182599344490@kernel.org>
In-Reply-To: <20260929224153.1455466-5-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-5-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch removes the only user of ICE_ITR_8K (the OICR ITR
  write in ice_req_irq_msix_misc(),…

--

ice: increase OICR interrupt moderation rate to 20K interrupts/sec

This commit raises the OICR interrupt throttle rate in
ice_req_irq_msix_misc() from 8K interrupts per second to 20K.
The goal is lower latency for VF mailbox messages and Tx timestamp
handling.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 707c7431b91a6..73f69d453542b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3428,7 +3428,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
>  		     ((pf->ll_ts_irq.index + pf_intr_start_offset) &
>  		      PFINT_SB_CTL_MSIX_INDX_M) | PFINT_SB_CTL_CAUSE_ENA_M);
>  	wr32(hw, GLINT_ITR(ICE_RX_ITR, pf->oicr_irq.index),
> -	     ITR_REG_ALIGN(ICE_ITR_8K) >> ICE_ITR_GRAN_S);
> +	     ITR_REG_ALIGN(ICE_ITR_20K) >> ICE_ITR_GRAN_S);

[Severity: Low]
This isn't a bug, but this change removes the last user of ICE_ITR_8K.
After this patch the only remaining match for it under
drivers/net/ethernet/intel/ is the definition in
drivers/net/ethernet/intel/ice/ice_txrx.h:

#define ICE_ITR_8K	124
#define ICE_ITR_20K	50

Should the now unused ICE_ITR_8K define be removed, either in this patch
or in a follow-up?

>  
>  	ice_flush(hw);
>  	ice_irq_dynamic_ena(hw, NULL, NULL);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929224153.1455466-1-anthony.l.nguyen%40intel.com
