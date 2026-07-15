Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA675424D41
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118557; cv=none; b=MYihab8PH/Kvo1qAw3FiFrPXv6kHqkYm7O5Af35tCdA+NqOaduW3qy9agFipT5CklplR6IDYSgTJUwL1i5QlvBN9lQyavok5nj18BEOlwgY5Lk2uDUEXfcoHL+M7iXYpz6xlhJABk7H7NKtAd4dYOlGeqrB8BnOPZ2yxnT+4ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118557; c=relaxed/simple;
	bh=AVCeO1AiRmislj+12l/4ZjCvshaxkwNvXHhjCpyQtEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMaJoFyY9+hzdD0QGLiFH9DGxCSUEmmzWYgBZJIGvIQZBItnOpp07uHVbjgkt4K8/kSJI66dS8RxHRVEOQyhfPtVHwI+cMSJvS6FKpuFqSYVf6+db+9njsIgeaRhW+uZMgas5v7lwuF1OG67vtbmbgbIPRdMa6oHelEgjGDNVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibWP1me+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibWP1me+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DAD1F000E9;
	Wed, 15 Jul 2026 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784118556;
	bh=vCwQnp8htPs9Eh/MP3qfpJZkYwRAjQYwif3i4a2+SwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ibWP1me+C9M2e4B3J9HI6qQ9QDBKE7obHJnMhklhtLq72Ybk1GX2dMAkKHnTV/kyS
	 Zql0VyMkW1z9lIrcUmfWXZOJwU6G4dbEC1icKFEseTjUuiTNbxTKVEs9VKB5B8TzTM
	 DRRvws0FniLRxa1ei0fHlgkUALm7H6DFlhX7WAynb09XbzRschrKbUXD09fR9aW9eo
	 0yX5DQxrde8Vq1F72MH7goOubyyWPIBiTRB6VDU3RNRI6AjsQ3Lz8lsKSPglC+o8va
	 UfHQFV6VoM7NemgeICebjEfJYxqImB4BuDshnQ7qIPWjQjGyPjKrKlueNT7HVEyy5j
	 G9qlIuT/wmEyg==
Date: Wed, 15 Jul 2026 13:29:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, pmenzel@molgen.mpg.de,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v3] ixgbe: E610: force phy link to get down when
 interface is down
Message-ID: <20260715122912.GA1922694@horms.kernel.org>
References: <20260708100609.331976-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708100609.331976-1-jedrzej.jagielski@intel.com>

On Wed, Jul 08, 2026 at 12:06:09PM +0200, Jedrzej Jagielski wrote:
> For the E610 family, similarly to the E8xx adapters, the default behavior
> is for the PHY link to remain up even when the corresponding OS interface
> is down.
> 
> Add function setting down the PHY config IXGBE_ACI_PHY_ENA_LINK bit
> what leads to disabling PHY link.
> 
> Now ixgbe_close() needs to share some of the ixgbe_watchdog_link_is_down
> code so move the common part into the separate function.
> 
> Align functionality with the implementation of the ice driver.
> 
> Let user to configure link-down-on-close enablement through ethtool.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: apply Paul's notes
> v3: use e_err

Reviewed-by: Simon Horman <horms@kernel.org>

