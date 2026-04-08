Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77397349B16;
	Wed,  8 Apr 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666082; cv=none; b=G1+NxJ6TVwun6rIctfVHJq18RlebHMa9Db0fdfa7RXR2qClQ9v4apEASwAmC60hwOu+3OBq4WO9opHVNIvj225gE7h0MvEXV2V0TQxfZoQlz9Q/1AuFd96ynpCBFCEedY728+Qf0US9EcrU5j05k1mmj1LvZzwTBIpy1x98wVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666082; c=relaxed/simple;
	bh=lZiW9wnvIQ5z1GIGwWPDRKIBOo0jR+9C4AkQvBOxj2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8oYg8LioyaIxKtm/23PDWcwSMZ3P4d3tpguBK1fwNIIJOdl0WLvAXcMssGR+tX8+/FUbNb1oOF4/5t9BMlwtKkQWJ0m2j/7hd1DDRsut9/GxLJAS7Qij5vU19KEMK7LcONKT0pDRbxaEhd9gMmdBMMg3Yk2BFX+n5EAC1NGFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAyoqdhz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAyoqdhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1B2C19421;
	Wed,  8 Apr 2026 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775666082;
	bh=lZiW9wnvIQ5z1GIGwWPDRKIBOo0jR+9C4AkQvBOxj2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAyoqdhzuIrbzJn3tXGCb0718n1Z9JXjawhpHRBN3Yc32LsjcIniXJp/LLTmaZ2r8
	 KN+4VUxsUnIXmvV6YaIGhz+0meSBZUpPVw6BZBp8Oa8UGNah73DHqsg+qfjEAG/xz4
	 hK5HfxflMK6h+s6vdvMzRKJSENZ/gYpyPJYG3lI3aa9wPX53Uvk39SP/Gpl6gvui/e
	 P2vwIS3SO3VskQD5C5uFCT3NGIYnpcXVn4YdilhQ2pZFbay3FH/KrG01xH43Y/eND/
	 Ao9AVCek0sZk/xkSBKTPrm6hfIRF/44b9TQvKHQGOGuwRsForWzqLg7l1PeHBlAAN4
	 hshMEdCHTMouw==
Date: Wed, 8 Apr 2026 17:34:36 +0100
From: Simon Horman <horms@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Alexander Koskovich <akoskovich@pm.me>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] net: ipa: fix GENERIC_CMD register field masks for
 IPA v5.0+
Message-ID: <20260408163436.GE469338@kernel.org>
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
 <20260403-milos-ipa-v1-1-01e9e4e03d3e@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-milos-ipa-v1-1-01e9e4e03d3e@fairphone.com>

On Fri, Apr 03, 2026 at 06:43:47PM +0200, Luca Weiss wrote:
> From: Alexander Koskovich <akoskovich@pm.me>
> 
> Fix the field masks to match the hardware layout documented in
> downstream GSI (GSI_V3_0_EE_n_GSI_EE_GENERIC_CMD_*).
> 
> Notably this fixes a WARN I was seeing when I tried to send "stop"
> to the MPSS remoteproc while IPA was up.
> 
> Fixes: faf0678ec8a0 ("net: ipa: add IPA v5.0 GSI register definitions")
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Simon Horman <horms@kernel.org>

