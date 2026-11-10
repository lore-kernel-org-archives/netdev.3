Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333201;
	b=hEbySvD2DmtSFCRLPqCqd5x4tKNt3MTsIEPaS0GiYytqDwn+s/JCouLu3fPDdrxrjub/
	 nzEGb8ksT/kJ2c4GwuBQUI3iFJiE50feCfTZlAzKq5BlUQhhwvmyxTWrjvWtWGr+o6Zhp
	 vMOsELKxlKtVTr4dI2joTSk/afYlqTwvUyOlHPQW3MHRVG/D3TWOIYqgyJATKRwryOvCV
	 u6ltNwEGUkrHG3lJFuloCqkn9W5+YdiIQKLQBquTv63eOigtvLNC5q2pIPgpPTlb5tcsP
	 Gymkzt9KhoNHJn7rngLnzstHFshsdzeZq7ejZDRwRb87JA9dUbUf3stuwmyo1+yQahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333201;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6MQvK9HWwZWHwV5/ACER8rs2MpoHm1YL0h+P0A0LB84=;
	b=qCZOFLpwkInAH1bfMxk/AzTltScWO/XdFdsecjnS1SPv6fLMRJC02241R+3advoxAt6H
	 kPH907rIL0IbrhZ7+JUBmYiNcIrpmwU3ReGih4N3Tem+mN0/Rb8dJ4MVVje1VOB27TLqS
	 0LaCPTw5zaOccYnHcJI3S21NEXYzKaSNmMuMTzI8+VV67PfBo8iqPr8TkOSyhrIcyFfu/
	 ttrtyLRLvWw/DHAkc7BPa1f8NUXA4F957Qo8+oVqYONHwV8vOayJPUnOF2cmm+z+Oj1Xu
	 Ugn5Myzh/F9P0s2C7xY/UGSTL7UfLhjHi3eGMs3x4nSefVxlea6qVZ+jhUz3UiBFoOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouneHihr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484EC606A31C;
	Tue, 10 Nov 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouneHihr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48D01F0089F;
	Tue, 10 Nov 2026 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333200;
	bh=6MQvK9HWwZWHwV5/ACER8rs2MpoHm1YL0h+P0A0LB84=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ouneHihrCG3paXR7Ptpn3Lx6Wvz8tQZc3rajD77OTxzog01M9G8DIlQrR0PlosCoK
	 dK7EBIK42+YA1f/e9BxrblvrbCvGoa7/BHbl32Be1QFK9DLFB+cLuOIB/T9Bwj66Yd
	 1jg+ed88eWOWGndCVkkrvrooV7/ZxiIDWdJ/28F+JOwP9Xt0kPepnEIRLcOLFOhZTS
	 PrduKLSb4RsLMNFFA9s8Q75OapieXdiIOuHMkBgFi98g5v+weyVxMMZ6fBTNA1GTq1
	 poTl/zVfvu98L5iPdhMnbbpzsxHW9t04hSJGoiqbIIWUltS02JrcGDGByzpoEY/kN3
	 RQIMYYmU0wQoQ==
Subject: Re: [PATCH net-next 01/10] ice: dpll: notify TSPLL lock status from
 the periodic work only
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
Date: Tue, 10 Nov 2026 17:53:19 +0000
Message-ID: <179433319925.994134.5092477928749468374@kernel.org>
In-Reply-To: <20261106121005.1327603-2-ivecera@redhat.com>
References: <20261106121005.1327603-2-ivecera@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch leaves the comments in
  ice_dpll_tspll_state_on_dpll_set()…

--

ice: dpll: notify TSPLL lock status from the periodic work only

This patch stops ice_dpll_tspll_state_on_dpll_set() from sending a TSPLL
device change notification from the TIME_REF pin callback. The callback
now only updates dpll_state. ice_dpll_periodic_work_e825() refreshes
dpll_state on every run and sends the notification when the state differs
from prev_dpll_state.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index ade1fb3dd0674..bdbcf7af296eb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c

[ ... ]

> @@ -2947,15 +2946,12 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>  		WRITE_ONCE(pf->ptp.tspll_locked,
>  			   new_state == DPLL_LOCK_STATUS_LOCKED);
>  
> -		if (tp->prev_dpll_state != new_state) {
> -			tp->dpll_state = new_state;
> -			tp->prev_dpll_state = new_state;
> -			changed = true;
> -		}
> +		/* ice_dpll_periodic_work_e825() compares the state with
> +		 * prev_dpll_state and sends the notification.
> +		 */
> +		tp->dpll_state = new_state;

[Severity: Low]
This isn't a bug, but do the comments in ice_dpll_tspll_state_on_dpll_set()
still match how the notification path works after this change?

The new comment reads as if the periodic work compares the tp->dpll_state
written here. In ice_dpll_periodic_work_e825() that value is never read.
The work recomputes the state from the cache and overwrites dpll_state
before it compares:

ice_dpll_periodic_work_e825() {
	...
	new_state = ice_dpll_tspll_lock_status_get(pf, true);

	tp->dpll_state = new_state;
	if (tp->prev_dpll_state != new_state) {
	...
}

The older comment just above the WRITE_ONCE() was not changed:

	/* Sync the cached lock state to what we just observed from HW
	 * so ice_dpll_periodic_work_e825() (cached path) does not emit
	 * a spurious UNLOCKED notification between now and the next
	 * PTP monitor tick.
	 */

That reason applied when the callback also set prev_dpll_state. Now that
it doesn't, the WRITE_ONCE() to pf->ptp.tspll_locked is the only way the
callback's HW reading gets to the periodic work.

Without it, take a switch from TCXO (prev_dpll_state is UNLOCKED) to
TIME_REF where the HW reports LOCKED but the cache still holds false. The
next periodic run would compute UNLOCKED, which matches prev_dpll_state.
No notification would be sent, and dpll_state would go back to UNLOCKED.
The result would be a lost notification, not a spurious one.

Could both comments say that the periodic work picks up the new state
through pf->ptp.tspll_locked? Then a later change is less likely to drop
the WRITE_ONCE() as just a way to avoid spurious notifications. As far as
I can tell, the comments are still unchanged at the end of the series,
after "ice: dpll: update locking comments".

>  	}
>  	mutex_unlock(&pf->dplls.lock);
> -	if (changed)
> -		__dpll_device_change_ntf(tp->dpll);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
