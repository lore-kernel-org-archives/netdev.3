Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AC35200A;
	Tue, 23 Jun 2026 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210597; cv=none; b=CN2AD3C5PT9XHTDeXd7oi7WViQEXGFWPFCrlH9YdNC84HwZL7jc2I66PE/tFPIlqlx43ecqO6lvpkQvI2FAG3kMxc6ji2fm0vly+2fwUKDqDX9y5nXheNsoK72huo1dkSvg6tKW48kbC1IA+FXvbU5cSdVqE3lS6WSOQLwxbxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210597; c=relaxed/simple;
	bh=sAG2e6gDVhDw/IMNqh2cES6ptv4l5e7DQ7s0H/IcCeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEE18QeDX003mx3c18MZw4ouZibFnngiyVCbpQdEydoG+dfQExvWtSNDOwikVp+4B59qo7kbMPtw8USM7PELqOVh8dEmhDq4svqNGE7idvUkQ5oxhJesZ6/934wOXIuFeKM5OjK2IjQ7ZlgZAbB4wdY1YQ1iPtVUUJFp12eE4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hldRoK8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hldRoK8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985471F000E9;
	Tue, 23 Jun 2026 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782210596;
	bh=7T1CU5SSShDw0aJ9KVYUgQhuWKn/RhlR48iRi5suHSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hldRoK8vcpn7kEthG8alQzSf9gF2SaT6ZvQLwwP/WpSnZHbTrSJaeQzykQjKQv4OW
	 bUk3ic3Ua2enzhh8wA9tt1SSv86e7xsKb9LBy6yLxffWTqULMaTzer1ETP6W4vGL1C
	 hsO7N28i9oeDbDpZ5AC4HiBfVFcJUMJiFAIQyRINGAXSwAJ5NofUv/Ne2jMoVuCYS2
	 130Rvc7zknfhC3MlmVDMZMlV/goMSXobtzsFcBvLmGpSpakIwJ+6fyWQeUW/hNBbVl
	 laEx8Rix5+b0CxuyEqDSh+XwszZqPej60MvjCQnWvdsH6hPMxTX8UNWukO+lYefsnt
	 5UcKC2eGY0H+g==
From: Simon Horman <horms@kernel.org>
To: poros@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: clear the default forwarding VSI rule when releasing a VSI
Date: Tue, 23 Jun 2026 11:29:34 +0100
Message-ID: <20260623102934.1072800-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622081030.2312129-1-poros@redhat.com>
References: <20260622081030.2312129-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: clear the default forwarding VSI rule when releasing a VSI

This patch restores the cleanup of the default forwarding VSI rule
in ice_vsi_release(), clearing it when the VSI owns it. This prevents
a rule leak if a trusted VF enters promiscuous mode and is then destroyed.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2871,6 +2871,9 @@ int ice_vsi_release(struct ice_vsi *vsi)
>  		return -ENODEV;
>  	pf = vsi->back;
>  
> +	if (ice_is_vsi_dflt_vsi(vsi))
> +		ice_clear_dflt_vsi(vsi);
> +

[Severity: High]
Is there a time-of-check to time-of-use race here?

ice_is_vsi_dflt_vsi() acquires and releases the filt_rule_lock to check if
the current VSI is the default. If true, ice_clear_dflt_vsi() is called,
which acquires the lock again during rule removal.

If the lock is dropped between these two calls, could another thread
establish a new default VSI rule before ice_clear_dflt_vsi() runs?

When ice_clear_dflt_vsi() executes, it appears the rule search only matches
by l_data and flag:

ice_switch.c:ice_find_rule_entry() {
	if (!memcmp(&f_info->l_data, &list_itr->fltr_info.l_data,
		    sizeof(f_info->l_data)) &&
	    f_info->flag == list_itr->fltr_info.flag) {
        ...
}

For the default VSI rule, l_data is empty, so it might match any newly
established default rule.

And since ice_remove_rule_internal() does not appear to validate the
vsi_handle for non-list rules:

ice_switch.c:ice_remove_rule_internal() {
	if (list_elem->fltr_info.fltr_act != ICE_FWD_TO_VSI_LIST) {
		remove_rule = true;
        ...
}

Could this blindly remove the default forwarding configuration for a
completely unrelated VSI?

>  	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
>  		ice_rss_clean(vsi);
