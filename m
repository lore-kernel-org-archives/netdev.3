Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792658170;
	b=svmKBEsRs6zhaENSlP1WTImIS5LP465jDcxITbHnCmuT1q81Pkt51SFaCuWuGK1Kmhch
	 9ACna28j7w6ZHdS3gKUnOmV8ZJ5pfUrHi2hzvU2mgMSFJ4MVG2VVk5/YY8zS/KL1TUncN
	 UqKiIz372qzaquvLAp+kxpSCcphWB8KIahKA4W6lzbWimfB1epiYA9rV3PH9iqKSGACLn
	 hf52mqHHlzvxJQMPhNBCSq1S257j3ruG3XDxEnKy8kSZP+CCtbt+iGM3MMQcbl4mmR+Ax
	 1pL7+PnHm5zT/8NtgIdDANRkCMlySQSlltF9DNLtVaRwJPuYZqXTc22t+nR0eq+9dxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658170;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=4y1bO0yWIY1avAnVM6Yv6aBJIGT7qri+v5Fo5JrwfOA=;
	b=CRFdICmzKEt3mwHDavT2yUD7TkfYYV9+m7lIDQPPvpSafLZKWmI7cIxGmoxTHEq5tlyK
	 i/TvJUVn7KDaE4Whi/jsoAQm057k+4gI8a8OuXKJO49GHgs8WSx/wCphZx5eRzkjISHRH
	 97N1Q0XEKMWPQF//m+HIOQ78XLWUMXuEN9rXuXXOEMYZ4hXAXokV0mhVMhywgavwF1icj
	 XS/xYtR21sclkfULFGyzlk6QSB9mRiPIIQeJAoayay82bp+DAGdebxh2W5Anf84IvHt++
	 UJow28+OSYr2PIIqrQfHDzmUyHpMWUNZfag39KGQmTSbcEBLjlAQIxdcoWoeRn3INfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dhM5w5Pa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE125606A31A;
	Thu, 22 Oct 2026 08:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE125606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dhM5w5Pa
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C49C22004FF;
	Thu, 22 Oct 2026 10:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792658166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y1bO0yWIY1avAnVM6Yv6aBJIGT7qri+v5Fo5JrwfOA=;
	b=dhM5w5PavV9Nq564P6Slrq8GHT4IJCkW3R6mEwSmkEFqAoSrqXwjSs0FUCCOmT02aqlpmj
	WlkKOvaUp7tFzu7CZHCrkxLii1BQyRzd1xPuqGzxK+TRYaLtmPQGNjJgOko/OnpQ8JR31D
	pUUCmcmeKUaBm8/M2zBx1IVqpX0j+QmzNXsk4W8lPBsmmFLNCTtUpTxcQh0vD5wZUQTsAs
	Ex+3XyP26FdQBpzvh1ydLmEDk8sHa9ijdXgvV+lUwPHbrgG9JOoeMjvwSN8rOk3Gqi6j7u
	qqo6+a71WhyXDMMLPfMZ+JWyzU/KCt/ESrbpLzBOZ6ARobJNzomCe1NhzbmQrA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792658166; a=rsa-sha256;
	cv=none;
	b=g1B+e4OI7fShN+FYRQzknX2rvl7jIhSuN7liK8DgR85wMPgd7So/FygYUBCQCABCf7oT0T
	zJVinpH577eJnTeVwJgw6lgTwHpKCXR63fVTGiM0/lZBVgUm199WHMyqkR+hL6fEbQ8fr+
	GV9VCNqWGwlDNNQhFP+jRp+UiXvN+aTWT4Bk4kCECQuCdcHcOYxx8LbivJ14WxX6NuxqLL
	2/aEic623gYg58nyOlMNFNYC32vcaYFxioL3Upa2ME/wLsWEsPL15rZ7h+YwECvH5M+jp3
	hJwk29vZa7IQX22lOuQ4lBWvmgZy/X8ioV9kZyampTrxy+hLLNVh/K0dxMEr3A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792658166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y1bO0yWIY1avAnVM6Yv6aBJIGT7qri+v5Fo5JrwfOA=;
	b=VtfgbW7RNyYAhT9XLygj1GrJeWjI+uln5aKMIbL7Zo2dfOsPm1J1yskrkRr9enNdzvq7uY
	+QA/xLDrwl6Fj7e/w3qOnMyQMnT4JT6/SeDvFQJeVKZQoZRkZ6Fc5mjsmj7yrW5lqt/RO0
	D4RDurDG2lIXURQy6tJet/ZeLCH1eIvEY7X9rPf9PBFXy5nUugO3ts4cErWZR3s4C0urLH
	i3KRahyng4EDh/mYL0WMtNdcRQc9zEUHseilH3RdZ8v7XofU+f3uJSjMFUyaQUDz1e7KVo
	zYnKftT9+zXHjZWwavw5Q55DajJ7dw+hA8RgQUeMpyUHBw3u34Z83eDi3pxfyw==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJoHO-000g7W-2L;
	Thu, 22 Oct 2026 10:36:06 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJoHO-00000009RVw-2XbY;
	Thu, 22 Oct 2026 10:36:06 +0200
Date: Thu, 22 Oct 2026 10:36:06 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 12/14] net: pse-pd: use each PI's own supply
 handle for the power budget
Message-ID: <atnK9lEinSLgx5yK@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-13-github@szelinsky.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020171249.853085-13-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:47PM +0200, Carlo Szelinsky wrote:
> A power domain shared by several controllers holds one supply handle.
> Its consumer device is a PI regulator of the controller that created
> the domain. When that controller unbinds, devres frees the regulator,
> but the other controllers still use the domain and its handle, which
> now points at a freed device. Reading the regulator summary in debugfs
> then reads freed memory.
> 
> The domain does not need a handle of its own. The budget is counted in
> the supply's regulator_dev, and each PI regulator already holds a
> handle to that supply, which lives as long as the PI regulator. Use
> that handle for the budget, and drop the domain's handle.
> pse_flush_pw_ds() clears a PI's pw_d before devres unregisters the PI
> regulator, so the budget is never used through a handle that is gone.
> 
> To find the domain of a new PI, compare its supply with the supply of a
> PI already in the domain. For this, keep a list of the PIs of each
> domain under pse_pw_d_mutex, which pse_flush_pw_ds() now holds for its
> whole loop.
> 
> Triggered in QEMU (arm64, KASAN) with two test-only PSE controllers on
> one supply: after the one that created the domain unbinds, reading
> /sys/kernel/debug/regulator/regulator_summary gives
> 
>   BUG: KASAN: slab-use-after-free in regulator_summary_show_subtree+0x770/0x9c4
> 
> With this patch the report is gone. A second test, where one controller
> changes its power limit in a loop while the other one unbinds, is clean
> too.
> 
> Fixes: 50f8b341d268 ("net: pse-pd: Add support for PSE power domains")
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Adding Mark and Liam, as this patch uses regulator core internals.
Carlo, please keep them on Cc for the next version.

Mark, Liam: the PSE (Power Sourcing Equipment, for PoE and PoDL) core
registers each PI (power interface) as a regulator, and the PIs on one
supply share a power budget. This patch drops the PSE core's own
struct regulator handle to that supply. It now calls
regulator_request_power_budget() and regulator_free_power_budget() on
pi->rdev->supply instead. The comment above struct regulator_dev in
include/linux/regulator/driver.h says it should not be used by
anything except the regulator core. pse_core.c already reads
pi->rdev->supply to find which PIs share a supply. With this patch it
also relies on the regulator core keeping that handle valid for as
long as the PI regulator exists.

Is it OK for the PSE core to use rdev->supply directly, or should the
regulator core provide an API for it? If you do not object, I am fine
with this patch going to net as a fix.

Carlo: apart from rebasing on the patch 10 and 11 changes, the only
changes I ask for here are the ones from my reply to patch 11:
lockdep_assert_held() in pse_pw_d_leave(), and renaming
pse_pw_d_release_locked() to pse_pw_d_release(). Nothing else unless
Mark or Liam object.

Mark, Liam, an alternative for later, not for this series: a PI
regulator has no budget limit of its own, and
regulator_request_power_budget() already passes a request on to the
supply. So the PSE core could request the budget through a consumer
handle to the PI regulator instead, but it would have the same lock
ordering problem the PSE core already has between its own lock and the
regulator locks.


> ---
>  drivers/net/pse-pd/pse_core.c | 61 ++++++++++++++++-------------------
>  include/linux/pse-pd/pse.h    |  2 ++
>  2 files changed, 29 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 116ad2d1984a..15539dd75c08 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -45,16 +45,17 @@ struct pse_control {
>  /**
>   * struct pse_power_domain - a PSE power domain
>   * @id: ID of the power domain
> - * @supply: Power supply the Power Domain
>   * @refcnt: Number of gets of this pse_power_domain
>   * @budget_eval_strategy: Current power budget evaluation strategy of the
>   *			  power domain
> + * @pis: PIs that use the power domain, under pse_pw_d_mutex. The supply
> + *	 handles of their regulators all point at the same supply.
>   */
>  struct pse_power_domain {
>  	int id;
> -	struct regulator *supply;
>  	struct kref refcnt;
>  	u32 budget_eval_strategy;
> +	struct list_head pis;
>  };
>  
>  static int of_load_single_pse_pi_pairset(struct device_node *node,
> @@ -442,7 +443,7 @@ static void pse_pi_deallocate_pw_budget(struct pse_pi *pi)
>  	if (!pi->pw_d || !pi->pw_allocated_mW)
>  		return;
>  
> -	regulator_free_power_budget(pi->pw_d->supply, pi->pw_allocated_mW);
> +	regulator_free_power_budget(pi->rdev->supply, pi->pw_allocated_mW);
>  	pi->pw_allocated_mW = 0;
>  }
>  
> @@ -555,7 +556,7 @@ pse_pi_allocate_pw_budget_static_prio(struct pse_controller_dev *pcdev, int id,
>  	int ret, _prio;
>  
>  	_prio = pcdev->nr_lines;
> -	while (regulator_request_power_budget(pi->pw_d->supply, pw_req) == -ERANGE) {
> +	while (regulator_request_power_budget(pi->rdev->supply, pw_req) == -ERANGE) {
>  		if (_prio <= pi->prio) {
>  			NL_SET_ERR_MSG_FMT(extack,
>  					   "PI %d: not enough power budget available",
> @@ -896,7 +897,6 @@ static void pse_pw_d_release_locked(struct kref *kref)
>  						     struct pse_power_domain,
>  						     refcnt);
>  
> -	regulator_put(pw_d->supply);
>  	xa_erase(&pse_pw_d_map, pw_d->id);
>  	kfree(pw_d);
>  }
> @@ -922,12 +922,6 @@ static void pse_pi_power_off(struct pse_controller_dev *pcdev, int id)
>  	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
>  }
>  
> -static void __pse_pw_d_release(struct kref *kref)
> -{
> -	pse_pw_d_release_locked(kref);
> -	mutex_unlock(&pse_pw_d_mutex);
> -}
> -
>  /* Switch off the PI, give back its budget and clear pi[id].pw_d before
>   * the domain's reference is dropped. The PI regulator ops and pse_isr()
>   * hold pcdev->lock while they use it.
> @@ -946,6 +940,13 @@ pse_pi_take_pw_d(struct pse_controller_dev *pcdev, int id)
>  	return pw_d;
>  }
>  
> +/* Drop @pi from @pw_d, with pse_pw_d_mutex held */
> +static void pse_pw_d_leave(struct pse_power_domain *pw_d, struct pse_pi *pi)
> +{
> +	list_del(&pi->pw_d_node);
> +	kref_put(&pw_d->refcnt, pse_pw_d_release_locked);
> +}
> +
>  /**
>   * pse_flush_pw_ds - flush all PSE power domains of a PSE
>   * @pcdev: a pointer to the initialized PSE controller device
> @@ -955,18 +956,13 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
>  	struct pse_power_domain *pw_d;
>  	int i;
>  
> +	mutex_lock(&pse_pw_d_mutex);
>  	for (i = 0; i < pcdev->nr_lines; i++) {
>  		pw_d = pse_pi_take_pw_d(pcdev, i);
> -		if (!pw_d)
> -			continue;
> -
> -		pw_d = xa_load(&pse_pw_d_map, pw_d->id);
> -		if (!pw_d)
> -			continue;
> -
> -		kref_put_mutex(&pw_d->refcnt, __pse_pw_d_release,
> -			       &pse_pw_d_mutex);
> +		if (pw_d)
> +			pse_pw_d_leave(pw_d, &pcdev->pi[i]);
>  	}
> +	mutex_unlock(&pse_pw_d_mutex);
>  }
>  
>  /**
> @@ -1014,7 +1010,6 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  	for (i = 0; i < pcdev->nr_lines; i++) {
>  		struct regulator_dev *rdev = pcdev->pi[i].rdev;
>  		struct pse_power_domain *pw_d;
> -		struct regulator *supply;
>  		bool present = false;
>  		unsigned long index;
>  
> @@ -1025,10 +1020,14 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  			continue;
>  
>  		xa_for_each(&pse_pw_d_map, index, pw_d) {
> +			struct pse_pi *pi = list_first_entry(&pw_d->pis,
> +							     struct pse_pi,
> +							     pw_d_node);
> +
>  			/* Power supply already registered as a PSE power
>  			 * domain.
>  			 */
> -			if (regulator_is_equal(pw_d->supply, rdev->supply)) {
> +			if (regulator_is_equal(pi->rdev->supply, rdev->supply)) {
>  				present = true;
>  				pcdev->pi[i].pw_d = pw_d;
>  				break;
> @@ -1036,6 +1035,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  		}
>  		if (present) {
>  			kref_get(&pw_d->refcnt);
> +			list_add_tail(&pcdev->pi[i].pw_d_node, &pw_d->pis);
>  			continue;
>  		}
>  
> @@ -1045,20 +1045,13 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  			goto out;
>  		}
>  
> -		supply = regulator_get(&rdev->dev, rdev->supply_name);
> -		if (IS_ERR(supply)) {
> -			xa_erase(&pse_pw_d_map, pw_d->id);
> -			kfree(pw_d);
> -			ret = PTR_ERR(supply);
> -			goto out;
> -		}
> -
> -		pw_d->supply = supply;
>  		if (pcdev->supp_budget_eval_strategies)
>  			pw_d->budget_eval_strategy = pcdev->supp_budget_eval_strategies;
>  		else
>  			pw_d->budget_eval_strategy = PSE_BUDGET_EVAL_STRAT_DISABLED;
>  		kref_init(&pw_d->refcnt);
> +		INIT_LIST_HEAD(&pw_d->pis);
> +		list_add_tail(&pcdev->pi[i].pw_d_node, &pw_d->pis);
>  		pcdev->pi[i].pw_d = pw_d;
>  	}
>  
> @@ -1068,7 +1061,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  		struct pse_power_domain *pw_d = pse_pi_take_pw_d(pcdev, i);
>  
>  		if (pw_d)
> -			kref_put(&pw_d->refcnt, pse_pw_d_release_locked);
> +			pse_pw_d_leave(pw_d, &pcdev->pi[i]);
>  	}
>  	mutex_unlock(&pse_pw_d_mutex);
>  	return ret;
> @@ -1962,7 +1955,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
>  	if (!pw_diff) {
>  		goto out;
>  	} else if (pw_diff > 0) {
> -		ret = regulator_request_power_budget(pi->pw_d->supply, pw_diff);
> +		ret = regulator_request_power_budget(pi->rdev->supply, pw_diff);
>  		if (ret) {
>  			NL_SET_ERR_MSG_FMT(extack,
>  					   "PI %d: not enough power budget available",
> @@ -1971,7 +1964,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
>  		}
>  
>  	} else {
> -		regulator_free_power_budget(pi->pw_d->supply, -pw_diff);
> +		regulator_free_power_budget(pi->rdev->supply, -pw_diff);
>  	}
>  	pi->pw_allocated_mW = pw_req;
>  	*updated = true;
> diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
> index a917ac32dc0c..17738ffcd224 100644
> --- a/include/linux/pse-pd/pse.h
> +++ b/include/linux/pse-pd/pse.h
> @@ -247,6 +247,7 @@ struct pse_pi_pairset {
>   * @rdev: regulator represented by the PSE PI
>   * @admin_state_enabled: PI enabled state
>   * @pw_d: Power domain of the PSE PI
> + * @pw_d_node: entry in the list of PIs that use @pw_d
>   * @prio: Priority of the PSE PI. Used in static budget evaluation strategy
>   * @isr_pd_detected: PSE PI detection status managed by the interruption
>   *		     handler. This variable is relevant when the power enabled
> @@ -261,6 +262,7 @@ struct pse_pi {
>  	struct regulator_dev *rdev;
>  	bool admin_state_enabled;
>  	struct pse_power_domain *pw_d;
> +	struct list_head pw_d_node;
>  	int prio;
>  	bool isr_pd_detected;
>  	int pw_allocated_mW;
> -- 
> 2.43.0
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
