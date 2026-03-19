Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DF3DB62D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936705; cv=none; b=nFjdkKAVIdFzxbXTsrc3APNpNRNOwPmo5ML5VRpVKkCq+2PQy3GtHdr1FDqgOcYcFrzXWAk2mKbBAB8xPFEfNvnUDoWs0ieSE8XycO3tdubQhy5fYm4ZEIRkvW0jt/BL21o49k5HAWOEv7ExOIcCAcruBGIxIgCKRt3JsjXMhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936705; c=relaxed/simple;
	bh=DmPtrmZY6UcsDvB3lw9MrBjgn6B96H+aMlBoOISwdEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsyDrUS0jTaCq5VvdFg/+VeBLXEjKyA6vYqihBVc4fPY8E8xQIyJFE+4UhoX8tyH+Lv2KNM98R/UUI0HAgdO4ZlSMAtdl0ZnEMtRAM1jjn7YHYgaUSZM3Pn6PCu+bE8HM+I4OsK6tz83Z7ZIMno+a+6E9S9QQG9UeAvt8DsRlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfTAj4VQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfTAj4VQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11518C19425;
	Thu, 19 Mar 2026 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936705;
	bh=DmPtrmZY6UcsDvB3lw9MrBjgn6B96H+aMlBoOISwdEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfTAj4VQUuTajDs54uw7NsY40deWRP7gKiPAG14A3wTcb5vY79zkKzFkhQkGwMkqb
	 g098++lNB5X9KnjanuQgbjw4iZ1k4XquOytTb4IIWbKXiFlsFpQoRr6dEfXMEfbmEd
	 m0OgOoQQRFD+DaLGVGT6bC0IxNT9FmEBxvYzbVxmnyfZisj9sLCv99Ysj2FHs0Zp2z
	 G/02SxM1z6HMcUt5PVh7Xx8+gGeGqT752pHG9b77lsk3TmX/mHepb/g5UhqcOyj0VA
	 pfnR75ffzo7nEaLkczuSUDn+UbAesFOL1gGzKIzqzexLWP9ZW3O6YoNssLtCgafK/s
	 ZFAvWgHSwmywA==
Date: Thu, 19 Mar 2026 16:11:40 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	dima.ruinskiy@intel.com, kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v2 0/2] igc: enable build_skb path
Message-ID: <20260319161140.GI1753385@horms.kernel.org>
References: <20260317062205.39406-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317062205.39406-1-kohei@enjuk.jp>

On Tue, Mar 17, 2026 at 06:21:44AM +0000, Kohei Enju wrote:
> This series enables the build_skb RX path in igc, which is currently not
> enabled in any configuration.
> 
> Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
> path.
> Patch 2/2 enables the build_skb path when XDP is inactive and other
> conditions are met.
> 
> Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
> 
> Changes:
>   v2:
>     - don't insist on reverse christmas tree, reducing net diff in the
>       patch 1/2 (Dima)
>   v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
> 
> Kohei Enju (2):
>   igc: set RX hardware timestamps in igc_build_skb()
>   igc: enable build_skb on the non-XDP small-frame RX path

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>
