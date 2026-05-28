Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB63BED77;
	Thu, 28 May 2026 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988447; cv=none; b=ost3p19vBf4fZalqdgN6O/x84gfqiwLg4yaqY6AuRKIBjHHZS/gqH+9u60+P33HH8tir7mp4M6FPbHEUpe7EE3hyS1LIJSOhZqcHlLwsxNbMoZyZmCaNUQ80SWf7KHzqpSY0BK1xyvqHovJkCvTrL1v+qcr50Bs17C1WVe5ROMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988447; c=relaxed/simple;
	bh=XJgd9ppmCUGyMfkufTPIGkoO78sx70bqo3tXgkGSb4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzcKvAXteELpyuy4l1pP4pcXc/YDDvLDOq/WmF+IbG2xk72Nk9G/xCMmzQQ99worKzDW3hydpt/kF4XNHqAwLwemhyj6LJQoQr3I5sgEC4YDaq0EB2doKhzwX/jHuluVGWJ9Zb1iCWltRx1BYjw5rvG0YnGHVKYiBkfRPWCXh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdooFQ0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdooFQ0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE5B1F000E9;
	Thu, 28 May 2026 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779988446;
	bh=x3XecCey7V1jOhn3zE1GAiTBEWrdYTpPoYi4jvRTnPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cdooFQ0tmujdG4wbgACHhQWY7nU+DQjiOofHK77kakdcPnTvUlOrkTzlgFBK56u8m
	 T1mN2I/7L9oV1WmUv/090/d7j0P44pp/Np4HIDfb4xI/UmyGablZQV9/SjbePDwN8r
	 C3OQtuUCRDhNirwPdOnV2ODN4m2zgYtw+ZuVCG9opek5uyeuHfCa75gG6Uwu3pFF+s
	 i8vde1HivO3Y1DIKfy1BzUQN2B/ibVpjrE5XjMlIAcgyM7ErDHL/unEDDxP9OtlZ9T
	 /eo7ebv/frvML8UJQsy/517fldAj8GBsAFIIbQgG8uWVyKBpDnQ5hgtyDgKoINXTa4
	 Rb/FebhNCedyw==
From: Simon Horman <horms@kernel.org>
To: zhaojinming@uniontech.com
Cc: 'Simon Horman' <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: dpll: fix memory leak in ice_dpll_init_info error paths
Date: Thu, 28 May 2026 18:12:04 +0100
Message-ID: <20260528171202.2659491-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526021154.2774526-1-zhaojinming@uniontech.com>
References: <20260526021154.2774526-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: dpll: fix memory leak in ice_dpll_init_info error paths

This commit fixes memory leaks in several error return paths of
ice_dpll_init_info() by routing them to the deinit_info label. This
ensures previously allocated resources are correctly freed.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
[ ... ]
> @@ -4341,12 +4341,16 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
>  
>  	alloc_size = sizeof(*de->input_prio) * d->num_inputs;
>  	de->input_prio = kzalloc(alloc_size, GFP_KERNEL);
> -	if (!de->input_prio)
> -		return -ENOMEM;
> +	if (!de->input_prio) {
> +		ret = -ENOMEM;
> +		goto deinit_info;
> +	}

Simon says: Although this is a pre-existing issue I believe it needs
            to be assessed in the context of this patch.

	    If it is valid then I would suggest a separate patch,
	    preceding this one in a patch-set, to address it.

[Severity: Critical]
This is a pre-existing issue, but does jumping to deinit_info here expose a
double-free risk during driver resets?

When a driver reset occurs, ice_dpll_deinit_info() frees the pointers in
pf->dplls (like d->inputs, d->outputs, de->input_prio, and dp->input_prio)
but does not set them to NULL.

During the subsequent reset recovery, ice_dpll_init_info() is called. If
allocation fails here at de->input_prio, the code jumps to deinit_info
and calls ice_dpll_deinit_info() again.

Because d->outputs and dp->input_prio have not yet been overwritten with
new allocations during this init sequence, they still hold the old dangling
pointers from before the reset. Will calling ice_dpll_deinit_info() again
attempt to kfree() these old pointers, resulting in a double-free?

[ ... ]
