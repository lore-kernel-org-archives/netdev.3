Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6704A689A;
	Mon, 21 Sep 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003274; cv=none; b=BeuUDbNwE5DYST/Qya0MEPqrxD4ZHqoMUsmOaUPK63ys++QvFoeItoNmVGaP04So9jkBNxN8i9tYHGLJKfkJulRXpqQJT2OS1MPHrotOX0zWdAbmj5QEoLBYXVBDY6whjdNa9MiBiQIbGl7maxXJSTzw6NUWI8UBph8OFZeipb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003274; c=relaxed/simple;
	bh=77vYYqxxfot4h942hItqxS5kQkj9h0SGZQLt4UhvaUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK2OH1ewQrK9jEkrzkwKQgedNjMSy0PumN1MZliuxghclHsgR75O4inlLYRylAFYDgzbAd/CF5pK5UMIi7gKPIuf3augjbSu/5ZFOR2z9J32j6n1Yv+akqsdGD+26YbsjvFGJgRL2Fi5rHfWEbOssgltebY6OquAgG7RkZBJ0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLNbSNUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLNbSNUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BAC1F00893;
	Mon, 21 Sep 2026 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003272;
	bh=/kxJdI60imaNRsgwIs9O+2/lppLAQj6941Uqe30oxv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MLNbSNUzJ3OCt4FbXqWp20u+UGK09qNsfE44pN76oiflwDXYZ/XcNNA6ScmPahcdk
	 /ukhWOihscCU4FVPbdb1R8/WXC1MkWNDjugCr6V97NBDcNf8OKu3Hm8r99Zyci7QzF
	 5r4Dh14MO/Y5Zi7pmgr2Ij5UfRcOO15X9mPlZy+WfUtTLpFQ+rgNHNYEQpYiyhog36
	 +Y9dMOkONotB77rKrVEAdv8IXjgmvJFkKGW0kBsKm9EBXrIPjG2USeE0VaxKKdqOsL
	 onTosdDtBfL3O3zr4hGb7j4mj//9vQvrzXZYkplXSoUgclhqVQ/KQFoC5Xgy08ntaO
	 usOMCiCPIP89g==
Date: Mon, 21 Sep 2026 16:07:48 +0100
From: Simon Horman <horms@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pcs: xpcs: fix clock reference leak on
 xpcs_init_clks failure
Message-ID: <20260921150748.GU13925@horms.kernel.org>
References: <20260919172021.2336748-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919172021.2336748-1-coiaprant@gmail.com>

On Sun, Sep 20, 2026 at 01:20:21AM +0800, Coia Prant wrote:
> xpcs_init_clks() takes references with clk_bulk_get_optional() and then
> enables them with clk_bulk_prepare_enable(). If the enable step fails,
> the function returns without dropping the references.
> 
> xpcs_create() handles the failure through out_free_data, which calls
> xpcs_free_data() but never xpcs_clear_clks(), so the clk references are
> leaked.
> 
> Add the missing clk_bulk_put() on the enable failure path. The
> prepare/enable side is already rolled back by
> clk_bulk_prepare_enable() itself.
> 
> Fixes: f6bb3e9d98c2 ("net: pcs: xpcs: Add Synopsys DW xPCS platform device driver")
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

