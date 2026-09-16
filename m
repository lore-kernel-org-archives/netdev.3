Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BF4BB80D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567570; cv=none; b=ngi6mxLqw7c6WkNRr5/GyCqaaXrRy1PMDT/rh0jjqblBJLZSf0K1XzadLBugvS+XZ1terA6gMKUdUkmnJPdUvIKvabS/EMqveXzE1dh1N4QuALFJc/ZMw2EQVCsyw44xw0hcf0qiaGXJhkeQ9Q/U7oj6w2au9wnfDXXBwGoW6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567570; c=relaxed/simple;
	bh=ryhSbscByAn8Eh+CW76izONnkYZz0CgrZvJJ6ElYMrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9tUOE8gidvb90tKYZoK9c6DR61In7FR3Msp6+z3gsOVd8PTz20It3Z4IVW/HEcyst0Cxq70m17LVczsIP9AW2wHFRDXqIoBfPCwCciUnb0KrE2v8FUyqDUpbdpMAPmsQiX3UwTxWrcHLNmGW9FAwAmuWTHYKNBWhM/6Bj/R7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeFc8GZH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeFc8GZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D171F000FF;
	Wed, 16 Sep 2026 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567569;
	bh=1ppyg6XHGvcBGxEGf9B4sF+LRFUB1IMBECg8BxRq5og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MeFc8GZHYaEmIe70KimSE1yPvHkOjjK0GZXu4E/Cd0PcXX06lRzUYROGarTn0GDoS
	 fjjvq97tKOHHL9JvUf/G9B13BcKk4ZN7yg5DwHdEtUR8n6JVdOffZ21u6rh73mW2z8
	 VANGFX8o+90A5Gdg81TDmUELqTXCrb1iJ5y6VOcds4xYQ3QccI4paVWEIbdYH25Cob
	 1xiSwOVt00NfN1pWVlulu23Yl8mTEyFcjsidOxd42K7aMjmdgsNMKxOGZD9Cr0+qwP
	 cxi3In7lg6ZKvtmrN4X6Agnc9EoU1wRb2nbWcvfr1KMdfPa6QzjSbMc8Rbu4ljK3hm
	 2qwPVwz/GgJVw==
Date: Wed, 16 Sep 2026 15:06:05 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>
Subject: Re: [PATCH iwl-net v2 2/3] ice: fix autoneg disable when link
 partner doesn't support AN
Message-ID: <20260916140605.GL51261@horms.kernel.org>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
 <20260915125529.3975723-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125529.3975723-3-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:28PM +0200, Aleksandr Loktionov wrote:
> From: Konrad Knitter <konrad.knitter@intel.com>
> 
> Disabling autonegotiation was silently ignored when autoneg had not yet
> completed (ICE_AQ_AN_COMPLETED was not set), leaving the configuration
> unchanged with no error. This could prevent link from forming if the
> link partner requires non-autoneg mode.
> 
> Extend the condition to also allow disabling autoneg when the link
> partner reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the
> ICE_AQ_LP_AN_ABILITY check on the link being up so that stale or
> zeroed an_info when link is down does not produce a false positive.
> Introduce the helper ice_autoneg_disable_allowed() to make the check
> explicit.
> 
> Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

