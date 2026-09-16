Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503894FC8C0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567420; cv=none; b=ip02HTtyxpcV3CGc/5Hjzm2IUlRfVsf1SPYHYymnX8P1g1Uhg3tq8Oc5R8soZf/jQ6PX5fIR/rf9ubMOIjbT1+CCY7lciQ/donpkr1dNG5qai8pLzaY+uOkbvA2n1IuiBvneayJzpLHcE65i7uI72r0ueqbzovjsIvs6LikanCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567420; c=relaxed/simple;
	bh=cbdjm6FcKDeMJ2zd5ULrTHn2uKJhKmF34kiAMgpUFP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqlwnM8Gr22B0o9JfOH6ANqcDlTbddAVWnXxNjMGV2nnChf9IAwFWup0vFfYRd2HbasK8pJf/+2HSOWNhMof6AUnBe5mQ07pWeQ0dmHeDTjrX3RJFAjnlb9WH1MSgFpCz/FkPi4S6b5PUho8TLFT6ukmS14Gh49Hu6DGiAmeui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW+dmqcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW+dmqcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26F91F00893;
	Wed, 16 Sep 2026 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567418;
	bh=RTklNyDdELG8FVUaFwZXb9SLYWWCJlJMJdzl9fP7xeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OW+dmqcHQLmsEkBdECc+bbk+IkuZWniisIeqhZ+g9FgphOgH9kxhmwB5iEvY7mq9o
	 FNLqegOEe/PfBNsNytB2zQL78BlgUggnLWDFMU9v6xVqbv/dlp0bmx9fuB0Ey2Gutr
	 fy3Ir4vldF/uKJ1fpKG6SVnUgPdaucqJekOK9JZiL1Ir9dbJJYfKVaMEMDMK+LNoTB
	 2vVnAYpuhaTJ7Vs/4sIhuCVMgqbb+Fx3NKbeLZlf05N/dZ8agDBQXN5OVoDvu+vrRE
	 rlnlYRVOw8kM72iSa3n9ApBB51yevQTgVOnksZfOW0UOFM9WzubgJx09MP0H+LWjJi
	 VH/BFhpX5qiAg==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	lukasz.czapnik@intel.com
Subject: Re: [PATCH iwl-net v2 3/3] ice: support RDMA on 4+-port E830 devices
Date: Wed, 16 Sep 2026 15:03:23 +0100
Message-ID: <20260916140323.243046-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
References: <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260915125529.3975723-3-aleksandr.loktionov@intel.com?part=3
---
ice: support RDMA on 4+-port E830 devices

This patch updates the ice driver to support RDMA on E830 devices configured
with more than 4 ports. It modifies the port limit check to skip disabling
RDMA capabilities for E830 hardware.

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 04633103e3e61..d85ae6d1c309a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2510,7 +2510,7 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
>  		caps->maxtc = 4;
>  		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
>  			  caps->maxtc);
> -		if (caps->rdma) {
> +		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
>  			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
>  			caps->rdma = 0;
>  		}

[Severity: Medium]
Will this still log an inaccurate warning for E830 devices?

While this patch successfully preserves the RDMA capability for E830 hardware
with more than 4 ports, the code immediately following this block in
ice_recalc_port_limited_caps() remains:

		/* print message only when processing device capabilities
		 * during initialization.
		 */
		if (caps == &hw->dev_caps.common_cap)
			dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");

Because hw->dev_caps.num_funcs > 4 is true, will E830 devices incorrectly
trigger this warning during initialization even though RDMA remains enabled?
