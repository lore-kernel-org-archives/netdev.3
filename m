Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C924F646D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567518; cv=none; b=OHmcbMSVXYCo68tHySVsW0HzhPtHC5RJRZ79f5tvD1Kq5+TJH0YnMJ83OtC9Uh68G4e5dcmpJtIPY6Nvg1nmDyhrGMZ7m2n7zjdATiJOPTSXAw14WvWxmrbQbZICYJW7Q6QU5r7CHN8g1AniDCFH2cdrU0KcFlJDp705IZHPSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567518; c=relaxed/simple;
	bh=MehSZZLpoGBVmaM2i9+HGqD99QadOB8R1TrIpgE2Xcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz30A0dCxbWZRCAE09ipIfmC8lQhotw0Tfmok3PhGhq3x1cUIhZ6wpYqngVsDhjKlAB/I3IiOVFqoyhcKWmXMq5w/r8ZhAxlBmCM+O9quWptHmA7Bz/F2CfMGUcUcrsQqI4HV/gJDlTXr4PRhgaG7USt77G2qU6Q0IjE7rKYkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNwywOo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNwywOo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8408A1F00893;
	Wed, 16 Sep 2026 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567516;
	bh=Y8iCSrcNz8wtHNgVBNqPdLAWG2tsycKaP7DS/aKDN/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TNwywOo6Ti6R12nTlwm7mc5g7JwCjmsJrx3IVkd4C4s+tgUAJZF3nI5Z0mr4uxoYI
	 UNW3bOr3e6ejBd7UcO+wiH5TIoCja51uvSEPsqwqlnxoM5pJypMuBR+KZ39ID5BJq9
	 nihxWc6QfCNOiKxIPXjqNd9gPeLop5K7Dj9ZQl8wOmqHtKNLslnoB8FkXU/Mt33K1d
	 oCN1Jj7XEY6TTwZWNhYFPowVPxqQVpf7lFkZpafm3h/u+i8AfSzDlcYE14gN+U+q3p
	 fLR8QVu0c9/H84HlY4h35n4IREUQBG3LhFd1JJ0mtywzr1emZRJ/FeqAuRbOyy0BjN
	 XiTA2EVrVGO/A==
Date: Wed, 16 Sep 2026 15:05:13 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: Re: [PATCH iwl-net v2 1/3] ice: fix asymmetric pause negotiation
 reporting in ethtool
Message-ID: <20260916140513.GK51261@horms.kernel.org>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
 <20260915125529.3975723-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125529.3975723-2-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:27PM +0200, Aleksandr Loktionov wrote:
> From: Tomasz Lichwala <tomasz.lichwala@intel.com>
> 
> Add Asym_Pause to the supported link modes so that asymmetric pause
> negotiation is properly reported via ethtool. Without Asym_Pause in
> the supported modes, 'ethtool -a' incorrectly shows 'RX/TX negotiated: off'
> for asymmetric pause configurations, even when pause is properly
> negotiated and functional at the hardware level.
> 
> Fixes: 5a056cd7ead2 ("ice: add lp_advertising flow control support")
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

