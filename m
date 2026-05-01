Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41019366079
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678855; cv=none; b=GDn0xNVt5W+ou1ZFe3BhIYEEBlkcvy5fg0GKPV4fZm4bv4PuD1gv05TaIq8lZv6eAkTefw74KTuMBA2CQ+M29jhh69BR+lQDpsF5iWSadx/Yz8HWtVeZjlK0flBMPouz73Fxl2mmlXnw583mvVDrjk1zpT7koCIeo+yupzWya70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678855; c=relaxed/simple;
	bh=WExdvJ9e3UJXKudyOxvJ7IX9xdwi3Wg7H+r/lMC8Pm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e29tFVXV2mSCoZHMqQOtRhvLJQbIidY6kaMyGC7ZD6ip51tMEgc9d+mgwtBJjVYKirr7I0LKFUHrqnLZGkWANm0c9hMPyXXHMNy6Y8VXVaf+4L7D3oGtskva4u1+lXzxjTw6WfadDJAWbvHkEVX+WvN6UuwapCrddR1rt5iiAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwDgQio7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwDgQio7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90255C2BCB4;
	Fri,  1 May 2026 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678854;
	bh=WExdvJ9e3UJXKudyOxvJ7IX9xdwi3Wg7H+r/lMC8Pm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FwDgQio7/Xp0q7WgJeIVCEXEjOy/bgXXTxqFrbZHAY9fzlbIA+1hBVhroVeCcHPJA
	 W/2blfo4mTfQY2+WDhh1Xl1cUOMbiPmt4yLbui/jK5LpIuwNXjWOczjPOX0EiMptbE
	 O5vhvOwYLLZqQz/EXeNKPwJR/3jLEr/SZSKTbSG5ThH4xEjjhIfS8RVW8StRhJ9XsY
	 FYMxRB9TM0yg4mMDIvw1AE21xR0vdUygdZIs3nTzYckXoXA9wlFPfgMbHleKY9g6Yk
	 t3SBhenvmV5PcKZ/3bmviFiU+vSci+hodC3zgZynykKnHsQ0bmmWyr7yHAo/VI9sBa
	 izulWEyP+18kQ==
Date: Fri, 1 May 2026 16:40:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/5] ionic: Update ionic_if.h with new extra
 port stats structure
Message-ID: <20260501164053.23312056@kernel.org>
In-Reply-To: <20260501031555.43259-4-eric.joyner@amd.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
	<20260501031555.43259-4-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 20:15:53 -0700 Eric Joyner wrote:
> @@ -2951,6 +2959,7 @@ union ionic_port_identity {
>   * @sprom_page17:    Extended Transceiver sprom, page 17
>   * @rsvd:            reserved byte(s)
>   * @pb_stats:        uplink pb drop stats

Looks like the removed field is left behind in the doc?

> + * @extra_stats:     Extra port statistics data
>   */
>  struct ionic_port_info {
>  	union ionic_port_config config;
> @@ -2968,9 +2977,7 @@ struct ionic_port_info {
>  		};
>  	};
>  	u8     rsvd[376];
> -
> -	/* pb_stats must start at 2k offset */
> -	struct ionic_port_pb_stats  pb_stats;
> +	struct ionic_port_extra_stats extra_stats;
>  };
