Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7D4CE678
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387291; cv=none; b=WwA+hED+F0sZbUi5Zcs82HXmP+P4svR1PMkNy1ghViHZpRMLFJ1+TLPKvexB76E890nu8tpxPVx9RIK/VGscdmjqrwSF4XlHYywuHpAVyaTP8ysRx+2X5j6fyDiNxfpdKU/h++3B9KDuUArgeoAZDuIV3f2arJZDK+xXkmTTICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387291; c=relaxed/simple;
	bh=tJdieCpjZbXWsmq5JWaHUwc69+XVuuR6bYLW8nOFkE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/bq3PIpPyo/eucjTi4mDf5pIgpPdS5pZ6+vti4yFDhvnEF4kVnBGCnlzixwTDmL8OMPlCW38yM/UuWGY3rg6yrNIUh350hE6x7bSMt8HFQfGfxQy9yK1lZWeirN5NInUl+ZF3cHA0sa/e+Avhu8ZA2NXZHj6jLjoLwrZX03JBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khOzW5I0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khOzW5I0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158FB1F000FF;
	Wed,  7 Oct 2026 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791387283;
	bh=h3HLY/EAI+SdxN5vMsY1z5CGwp/bY3mIsQHk2DrrFf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=khOzW5I0GwxkFp6yOFxAUuXIquRYsar3CasBzZhxY1Oruz8EqcUHx45hmYLwkgi/q
	 whrCQxqSvc+IidjIEqkI7DIC1/iT5eEWCv6MPFyHJ2bU4Zdj75yN8UldcJWsa09pyy
	 4p/9kURnFCfK48c8CaLJUl2kVS/I8TlKvR/DX3M3Vc1q7oIWiRm1oyl087IOlh4OmM
	 5tdbYj1GI8hfeKmM3JO6ijoMT83BsmkOs7sdvRP+xfPRQNt+k0O6tF0BTqgKy+/EZT
	 DPAtxpUWEHViOC7dYy2WpAHcZ+fHvXsjZ7Pt+mwPnX3vMEoiHOiM1Xqc6Ax40gYp6V
	 UmDhmjWBNigxA==
Date: Wed, 7 Oct 2026 16:34:38 +0100
From: Simon Horman <horms@kernel.org>
To: iugfdin <iugfdin@proton.me>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/2] r8169: preserve checksum offload when packet
 padding is unnecessary
Message-ID: <20261007153438.GV83879@horms.kernel.org>
References: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
 <179098478410.1174319.5605355405318252998.r8169-1@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179098478410.1174319.5605355405318252998.r8169-1@proton.me>

On Sat, Oct 03, 2026 at 12:07:54AM +0000, iugfdin wrote:
> rtl_quirk_packet_padto() returns the minimum packet length required by
> the padding quirks. For RTL8168evl and RTL8125-family chips this is at
> least ETH_ZLEN, even when the skb is already longer.
> 
> rtl8169_features_check() treats that nonzero target as a boolean and
> therefore disables checksum offload for ordinary non-GSO
> CHECKSUM_PARTIAL packets on these chips. Packets that need no padding
> are unnecessarily checksummed in software.
> 
> Compare the skb length with the padding target instead. Packets that
> actually need padding continue to use software checksumming; the
> existing short-frame and transport-offset checks are unchanged.
> 
> Fixes: 8d520b4de3ed ("r8169: work around RTL8125 UDP hw bug")
> Assisted-by: LLM
> Signed-off-by: iugfdin <iugfdin@proton.me>

Please consider using your real name in the From header and Signed-off-by tag.
Apologies if I am misreading things and that is already the case.

> ---
> Tested with W=1 driver-target builds on net under x86-64
> allmodconfig and allyesconfig, and source-executing ASan/UBSan
> checks with modeled kernel/DMA/MMIO boundaries. No physical
> Realtek NIC was available; this is not an on-device test claim.

Reviewed-by: Simon Horman <horms@kernel.org>

