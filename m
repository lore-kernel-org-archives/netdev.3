Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE32C86D
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706172; cv=none; b=MgAr/0ofqqRXPdu4xnSChG+72SLZVadLRx14Sg0mTXXau5lzXtFpL83z8OuSQxPDHLaRDEnJTbnd5IkIGUgkE7kHauptPUuKCTdXYTNpu8zH3y3sEJDcJGlC4ysjSUD4YiJx+SRP185HjC36jSGkJQUJXK7v4JZLW5DsNWej/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706172; c=relaxed/simple;
	bh=pBBEWSiMf49jslYnPFwytDruyiiglb/OMToWGB7S42s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQXgTXbp9q+e5uPixNzYM91EtT5gDv6bQXlsdoAky0mmfMwVdpIU5eM8Y+jmgAlie2cz1Xapxt4C9mYL3kpXSfrtu17XIKQy8Xg4JhPi7qbH41AiDy/7A2i/1WtQxiXapS/LdQ3jMHW8uEkhBCSINK42L8Ruz23iFivKKMYPU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu383U+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu383U+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CD3C19421;
	Tue, 17 Mar 2026 00:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773706171;
	bh=pBBEWSiMf49jslYnPFwytDruyiiglb/OMToWGB7S42s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uu383U+76kwAiejYtpx/LfVRKghv0poVuLZnaxmrc1QjWBCjHwdan9lU7uJZl9+2h
	 EhIQjdBbyBfPlc5ar2AhW3p0ORp5BE/neMw+r/C9hvR8HkjsnAipMn+/h10cMdzL6Z
	 WB3h90znM4VR5Kiqb4+xzrSe51UdzA2ORVKrb3xZ7Pde9oACqjL2XHqdjLx8a4vGdt
	 +2mTW5CCA63b2trmQRUZfcAVWFnOGfFVm375vdwgkErVf790TkLhFVv233IThbXwgJ
	 +5062wsbeNH7RPEhU3baLLB37pCuyXCAEZS8No54ze5Fb/aE0mG5q3FcGo0qXGDsJB
	 9w6DAgBHXVkFw==
Date: Mon, 16 Mar 2026 17:09:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v5 1/2] ethtool: treat RXH_GTP_TEID as
 intrinsically symmetric
Message-ID: <20260316170927.11e7fa70@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260316072053.1241987-2-aleksandr.loktionov@intel.com>
References: <20260316072053.1241987-1-aleksandr.loktionov@intel.com>
	<20260316072053.1241987-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 08:20:52 +0100 Aleksandr Loktionov wrote:
> A GTP tunnel uses the same TEID value in both directions of a flow;
> including TEID in the hash input does not break src/dst symmetry.
> 
> ethtool_rxfh_config_is_sym() currently rejects any hash field bitmap
> that contains bits outside the four paired L3/L4 fields.  This causes
> drivers that hash GTP flows on TEID to fail the kernel's preflight
> validation in ethtool_check_flow_types(), making it impossible for
> those drivers to support symmetric-xor transforms at all.
> 
> Strip RXH_GTP_TEID from the bitmap before the paired-field check so
> that drivers may honestly report TEID hashing without blocking the
> configuration of symmetric transforms.

LG, thanks!
