Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E352480DF5;
	Tue, 15 Sep 2026 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464911; cv=none; b=lRGHTKwwYeWYyyiURrO2wHlTNZfGQ2NBqAJOEJXtzQk99RXroYF2oh4ygYjkkNcJBgnS4IJj/kJj/qPyLtGLVArHv9yv2m1Gx20IYYCqZqCBJVYZx+8lUApuNw3pk2tqPfS2By1MP0bTpnOCP6snOLaXd5raYCIWYj8wNCRMjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464911; c=relaxed/simple;
	bh=qvJOg5IBmSXXwu7Qu2OOSp0r6G4ZbNyDHNqrUa0rvo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERpyQ/8zCz3YosQlj56IGz2KEii05rLtZlM0oadliNNAYsDs0vfj1OonCbpPanUMiEbeYZZDLZbpI6ywLDVRAYLuOAHXwZJ8QRs2/c7dp+pLF1jvv45AyrqUrSMeEd3Wf/YgjeibByuADVsbd2ud7X12p5Pd/bKcrz/NXLMumY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miKh1MDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miKh1MDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14F31F000FF;
	Tue, 15 Sep 2026 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789464908;
	bh=FnGc7eDC2q0I7u5ov3usFLL9w4BG2AFI3UjliKj80+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=miKh1MDz6XHOW3/kuiPxKPYSNcTJ0Wllz2uD93VktNxrk/ylTZ9SmiqcysJkuUxGY
	 c5rUBmASANrw3kL7XDLrPJFl/7rf8HxPdQJeH7GE69yklF3UO3aog9T2Dmvl8Tf259
	 ncf2mavEFuPeVhZCxbeYtO4yGoTCiSaMpP/kq4VGz1xijHEi2aqxkT1H9z7PxH3gzp
	 TtVkc7I6B2g9II90l1TWbL4j+4JYKisoDJtt6rEz94kOyk0TPwQytoEqfIFaDWs8zS
	 4ZRJFur/qvkJBKaTyT6zU62ZF/McE9OwXkTQwyvqHJtMJBPPouMIiuNXNBsBEzqk5Z
	 ObUenSubTY4+A==
Date: Tue, 15 Sep 2026 10:35:01 +0100
From: Simon Horman <horms@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ae878000@gmail.com
Subject: Re: [PATCH net v2] net/qla3xxx: disable the PCI device on remove
Message-ID: <20260915093501.GD314999@horms.kernel.org>
References: <20260913204534.53825-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913204534.53825-1-mhun512@gmail.com>

On Sun, Sep 13, 2026 at 04:45:34PM -0400, Myeonghun Pak wrote:
> ql3xxx_probe() enables the PCI device and balances that reference on
> probe failure. However, ql3xxx_remove() releases the mappings and PCI
> regions without disabling the device, leaving the enable reference
> held after unbind.
> 
> Add pci_disable_device() at the end of ql3xxx_remove() to balance the
> successful probe's pci_enable_device() call. Keep the existing manual
> cleanup and probe error handling unchanged.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 5a4faa873782 ("[PATCH] qla3xxx NIC driver")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> v2:
>   - Add pci_disable_device() to ql3xxx_remove() instead of converting
>     to pcim_enable_device(), as suggested by Simon Horman.
> v1: https://lore.kernel.org/netdev/20260911033219.34566-1-mhun512@gmail.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

