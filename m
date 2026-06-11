Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596A41C6A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208354; cv=none; b=ESYjaEGyJ0K3xkynsSLC7Xc+x9phxJHxV31ydYPBBnbCu2b80bODkpnwTHkkeWpO/G0XiKeHskFXZAqQCgzMmeh3Bz9ZngLlF38pmcp9noj9YH/wEHXeaZx7SXU+/+HQLkI9p9gN8pQbb3SGQYTOS/hAfLtMuNcMYcOnUbrFPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208354; c=relaxed/simple;
	bh=FtbqDhS0Pa0r8jYOj6VpnC+sRqg+URulBLrpRIaeTKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1ZjeY5WErPy5z5GA3YVWvgLTrKtXdAOn7+5KlKlZLMaGM8Sl6pn0KB8yjpYuH/RWRdCa9sBAXxHx7w59XxGWRNyt9C+we5tJ51ju4QhEXK4akA+0ZdxSik1halJFeN5PGrJJe2nu0RDUAYF5aoeaMc9E8rSpDdj36YmbWYNzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIqa7+L5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIqa7+L5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9201F00A3A;
	Thu, 11 Jun 2026 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208352;
	bh=vnIpqTeqEGomSv+6TVEDldbVU2+bN9ipwFUtdYEtb4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hIqa7+L5hy4RuhKcFmiu6jlBg6tL1mwrHtjXR+j3sMVRerNPkiRT7ZevUJ4oqg1nC
	 WfH2iF3dzPhzXWYEtvqKszHHgL3OoWAzIfwC3ZPOsUvClW9GShmw1xqZLXNsbUWQ15
	 L54+j6t2Jz5J1DUiA773OcVz9tb6TO3os3Y+y6sOAZl4c71nRBgVWwxe9fLCDvkyI0
	 AFjiVRaV2Pb27cKIpNzxEngx7oAjmBaRv3YfC5CSrpDwsrsN3sVRNcHKkexQtMMKIg
	 S41BtKyb/3Rc5GyJDd6jfkn3nML5vyX0bMqtm9RYQZZ0Eh1g8jGU+Oja20UmTWJqcr
	 d2eCmF8tvHEKw==
Date: Thu, 11 Jun 2026 13:05:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch, gal@nvidia.com,
 jacob.e.keller@intel.com, sdf@fomichev.me, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
Message-ID: <20260611130551.0af71a7d@kernel.org>
In-Reply-To: <20260611130520.350410ab@kernel.org>
References: <20260611200355.2020663-1-kuba@kernel.org>
	<20260611130520.350410ab@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 13:05:20 -0700 Jakub Kicinski wrote:
> On Thu, 11 Jun 2026 13:03:55 -0700 Jakub Kicinski wrote:
> > Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")  
> 
> Ugh, wrong fixes tag of course, should be:
> 
> Fixes: f9a3e05114b8 ("net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops")
> 
> I guess the GET side was also wrong but its harmless.

I mean -- so it doesn't need a Fixes tag, it's covered by the patch,
of course.
