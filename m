Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4C314B72;
	Tue, 16 Jun 2026 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593829; cv=none; b=JlTpeDm0QO9cKH7rsxea+md60vxjPR8mOJfKaE0XD63AiBWI2IJnwn+yoXdcbSvwPKdzEpXkgrXxJEMAygBCUCESe1s8ThZuwEzOZDe4+fOZZ0Yl2rdU93vrkwjtG8lBVwmOW7oK+4FRL/Xl0XStwaSP5drRlrq1Kww3F/8RLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593829; c=relaxed/simple;
	bh=lPsXz3THItiwUsdtY0KYzoYiwvKTFcgseJK+472k2Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLRdaWDz38mhW+/tfLslkwx7fwWNR1T4scvfz1q8ucR02zQoA6GERoPNC7lvJwlwwBdSyzCLAV424TBfRomQwVZA9WKNXONikmoDa+bYqJQ6LE9xT/ee7eby7moEz7vl3SYqIP/y3pJDDWsx8L0QFc8YqHmS/KG1MUibIYM5HOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2GNi4ym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2GNi4ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522E31F000E9;
	Tue, 16 Jun 2026 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781593828;
	bh=pbzFy9fhBPu0oSJO/iEHYJecZ1vKXPEOBile8sdpH/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q2GNi4ymNtyWF820l7fxI8vxh77SvwtVenkna9p15fzjxDSRthR9u3+U/0g11wje7
	 1CIx2hSXFl4x4Ci4ja1y3o0e2uAqjOzzEC97WvxeRP/w94qziTMzTEf+INxwd3sZs6
	 k2hhBuyDaSbDm2tJgU160Bvx+jJaeqA7Z5bcUAKAnb5TXFDzI+roGdLIDK8ny3bM5z
	 t2IftBg5UlCNjiuikgMQfpw15vGzX7yzJycJaIQTpvKFyKL2yDyQ4CofGel7tWQ5FO
	 zu+3z36wBStxm3OrrrrJKgtxQz5kmF9loyheL8JZGtoTKD2whBZnSC/BM+cfsg/hjm
	 Wkxlpr6JSFypA==
Date: Tue, 16 Jun 2026 08:10:23 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: amakarov@marvell.com, davem@davemloft.net, jesse.brandeburg@intel.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	sgoutham@marvell.com
Subject: Re: [PATCH net] octeontx2-pf: Fix leak of SQ timestamp buffer on
 teardown
Message-ID: <20260616071023.GP712698@horms.kernel.org>
References: <20260615030704.504536-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615030704.504536-1-rkannoth@marvell.com>

On Mon, Jun 15, 2026 at 08:37:04AM +0530, Ratheesh Kannoth wrote:
> The send-queue timestamp ring is allocated with qmem_alloc() when
> timestamping is used, but otx2_free_sq_res() never freed sq->timestamps,
> leaking that memory across ifdown and device removal.  Add the missing
> qmem_free() alongside the other SQ companion buffers.
> 
> Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
> Cc: Aleksey Makarov <amakarov@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

