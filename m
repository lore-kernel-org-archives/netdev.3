Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93663214
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906058; cv=none; b=rumzZjIEuQ68ifghqTgoKSRWQAoRxk3r+kme+nBVf+8b84fW/rQr33wmnd9nsEdG04H/wFN4Z5eTKZotErW4P/U3z5Sloum6kCgBz4LeuqW/Ub0lFfr69DUDoz2hOj9rVC832QxNXj0trohdoDrmQX2Oc2l27VhIPRExqkU7imc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906058; c=relaxed/simple;
	bh=NuUhausAaGQmEIJxOVY/Jkka8pSmXTbqb3674EzUlo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eG69yyg57DUaV/zgFG/C8X0HZdzfdLoy7+iM5ey6TIXQkpsZpiQt0rk5T7coLRopOz/IHlKcaggQeAbCIf35dQI2aMJJUpkIHLQ21JmpkWpmHRsVu13lu+3s5hGZtBAU2KXAV6iH+5LvV5pDJUFfzbcudBmfcGOj5dZZCsxoUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4Rvgq4y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4Rvgq4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB7CC4CEE3;
	Mon,  7 Jul 2025 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751906057;
	bh=NuUhausAaGQmEIJxOVY/Jkka8pSmXTbqb3674EzUlo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4Rvgq4yV9QTLTcL6UUuCQqjFoHK1sOttf98ulWsJtAJILKlZDRxf93Tw/+v5tXPV
	 qIc+Cc/BNmPqVoKfPMf+zPeWvwMwDppJ7eqdLeqGL9Sd0Q3Mx009ZjnPCtppCgpy7L
	 YlnvcqunMXtrFf/Nxl7pM/ZGBVY5oTm5eqq4JHzuDvziW88unNRfVMLXrMsn5dBxoH
	 pLLJARC7VJXO5yh4VpOFlBTKEau1m3iXKPS3fzKhfPu3hk5MSyg7/sq8fQsx4W4cnj
	 v/ZDd908Qm9CR6OMgVGgXZZ3v6sXQgTOB1OZ4f0KtWG+aZ9hFkKaITU0Fr1DMuNh06
	 p8HiyqKGMvNsw==
Date: Mon, 7 Jul 2025 17:34:14 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	andrew@lunn.ch, pmenzel@molgen.mpg.de,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [iwl-next v2] ixgbe: add the 2.5G and 5G speeds in
 auto-negotiation for E610
Message-ID: <20250707163414.GP89747@horms.kernel.org>
References: <20250704130624.372651-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704130624.372651-1-piotr.kwapulinski@intel.com>

On Fri, Jul 04, 2025 at 03:06:24PM +0200, Piotr Kwapulinski wrote:
> The auto-negotiation limitation for 2.5G and 5G speeds is no longer true
> for X550 successors like E610 adapter. Enable the 2.5G and 5G speeds in
> auto-negotiation for E610 at driver load.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

