Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF73B42CC;
	Tue,  8 Sep 2026 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892293; cv=none; b=AWJt1C11iGW+ChfFoVU8Mfi2Yd4BGuVg8B5HMv2Ncaxo4EJDMzThzV5Z0Y8vbnyfIEyiVxl3+TWtZUxHPCDRU7CWB4o+2FXSNL+c9AzxitU/7GS/JXdGMC2w4fd99WY+eQlmAp4ZqQaAV3GFf3Ae/BzxNCW0lRvSEHRN03lHKKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892293; c=relaxed/simple;
	bh=aVAGn4xIfri3FoQOQii2ogobOJcVUu0pX3OAeXIoRIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuKSt+XQT1GyDiah4L2ykWICv7Qr13rL/iGIhCs3iZUaOP/LWfbBBATSlgWkZyPb2fo+BNSm5iLX1s5OYNEO8a51XN5rpkEfISVyzkntqi/gEmgmyVpAZlTZH4ZX/Ot661NO20oVJQg2qpXrS7878ESc7qx2+3LPkz8UUwZ4hSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV4ymRzt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV4ymRzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E391F00A3A;
	Tue,  8 Sep 2026 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892292;
	bh=6cZDfge7+OG+kjdYRJde9UV0lkM6osQI8hAMk9OLaKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RV4ymRzt7Lu5dJwvFDAif4TWvHlfUweRaL6NQi+7IpectWu4m6w+olWMLLdtFyUQo
	 Aa8ds3802eo320xxDh4NF0WLV5JRin3mtYTfxPScWJ9xgXZWK62Oe/kfYfASEyiAH8
	 kMNbrCYAgoR3y02G49MfGZgfhkApjecFiKd3VtD4/2Bg8xwdkn2zdJ0WAsOCvQLR6n
	 ig6xDzA4jcd8tbfviDvLhMnBrYLbI4yIiJ53KF5lXraPp0QVu477EZv4G3nssVyt2y
	 ledOgk4d+9t0+s/4vieFxGAVHuH/DK3v5LUw0JRN6pETEnbeaWg01jESas7xOLTtqd
	 Mk7xpb5pAKmMQ==
Date: Tue, 8 Sep 2026 19:31:27 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Henry Tieman <henry.w.tieman@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
Message-ID: <20260908183127.GD40544@horms.kernel.org>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907115221.926007-1-aaron.ma@canonical.com>

On Mon, Sep 07, 2026 at 07:52:20PM +0800, Aaron Ma wrote:
> The firmware package and switch recipes are shared by all PFs of an
> adapter. However, each PF rebuilds independently after system resume. The
> resulting package downloads and recipe updates can interleave, causing
> firmware timeouts and leaving interfaces unusable.
> 
> PFR also clears package-derived firmware state on affected devices. The
> existing PFR path only rebuilds the driver's block tables, so VLAN recipe
> programming can fail after the reset.
> 
> The failure is reported as:
> 
>   ice 0000:04:00.0: Update pkg failed: err -5
>   ice 0000:04:00.0: package load failed, -12
>   ice 0000:04:00.0: Rebuild failed, unload and reload driver
> 
> This was observed on an Intel E810-XXV-2 adapter (PCI ID 8086:159b,
> revision 02) with NVM package 1.0.0.18 and ICE OS Default DDP package
> 1.3.43.0.
> 
> Serialize rebuilds across PFs of the same adapter, while allowing each PFR
> to complete independently. Reload the DDP package from its cached copy and
> restore the default DVM recipes before rebuilding the remaining PF state.
> Abort recovery if either operation fails.
> 
> In addition, stop the service task before tearing down resources in
> ice_remove() so that an in-flight rebuild completes and cannot dereference
> pf->adapter after ice_adapter_put().
> 
> Fixes: 462acf6aca85 ("ice: Enable DDP package download")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v1 -> v2:
> - Stop service task early in ice_remove() to prevent use-after-free on
>   pf->adapter if rebuild is in flight.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>
