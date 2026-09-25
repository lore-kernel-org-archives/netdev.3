Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1942395AF0
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356992; cv=none; b=uIJoISSvYCO/oe35UB8A1zmImw+7RTbBEyGXEgF/3bDlUrPln9LpgyC0kCtDBfUX+W2/uYzk1nv3sW58oUX/IE61FsL8vWSp6Slu1JIhElfWZG+V6tNE7HiyxS3Z/mgtEad1SZeiSf8/iYn/4C+6wxU85tsdPPjHZpnqVczj4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356992; c=relaxed/simple;
	bh=SoBwy9uL3l/7suOL1L7AsZnlORZBke0zyYJ9as9CFTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIyEVd91Y1mgmm8pPGXd8URDypRuynzN/VsvchSsnDnfscE/ffHBfsFBisFDIC2jWfZAsAxRcjvn+ImIRm4xKlvlDJoIQ6c+qARYHoi9VupoWKOK2Bl4kcizhYWSBA5UIEYuhbRlCdeAZgYY8cWemMC4EbyHqaXEwcBgP+tdVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM+Q2N7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM+Q2N7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC05B1F000FF;
	Fri, 25 Sep 2026 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790356991;
	bh=DTh7DNLRr+3CSPxIbFtt2TL5Gzzya7YGrc2URbuFKeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jM+Q2N7Fb+9d4JXOOtn53QTBZKoG67uwoulY9YOd8JU7gKKWo/hN299LZaFgmSLc0
	 2UevsDahhyu+cvcnNim4Y/X+biqjblson2vAfq7zahpC8fxM2MUezud1mhEh/Eiw2E
	 Z/OCsr5H9+8uf7NewWnaryB2GslngZMndvQcsE8JBHwXUVF5IC9yO7GFL7LKLe48q1
	 o3sVmzkkYL1oXtFrzpWzPWKmf93C73QwzF2nYIIrftmCW40lYnJoSolhNpjN0q/RZp
	 5yxENE1XAASg9HpYH3peu2v+4OTHyeBiC7k5HcCwKZIXLItUcIoxqCxz7jus7qY5/l
	 GArDIEOpP6vqg==
Date: Fri, 25 Sep 2026 18:23:08 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 2/4] ixgbe: Fix FCoE refcount taking for
 unsupported adapters
Message-ID: <20260925172308.GT13925@horms.kernel.org>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
 <20260922113558.2288111-3-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922113558.2288111-3-sergey.temerkhanov@intel.com>

On Tue, Sep 22, 2026 at 11:35:56AM +0000, Sergey Temerkhanov wrote:
> ixgbe_fcoe_enable() increments the FCoE reference count before
> checking whether the device supports FCoE. The unsupported adapters
> shall not take a reference while the ones which have FCoE already
> enabled only need to skip hardware initialization.
> 
> Fixes: 27ab76065c0c ("ixgbe: add a refcnt when turning on/off FCoE offload capability")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

