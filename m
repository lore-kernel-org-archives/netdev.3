Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0753876CE;
	Tue, 16 Jun 2026 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594377; cv=none; b=G7PGcK6REw1T5DxSdD2SS1kj6cCvKVBBVhwZytvkY+GLA2V14iYdr5/WR4GLYe74v4DLvzPGK0V4cjQDACT7YMrsWD98IBXkSHdFdHRHuLvnJ365HlyFMU3CByilOJKc97NE8k6A2v5pWWkHJ7mca4kuX4M5qgIEfQwvGxxwiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594377; c=relaxed/simple;
	bh=OjZSrMkiSIp7LbPR7fUcK55aPedbmI5jh4t4OYxCu6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcbRfy9VUubvxScexbmQ+kIz3zyqQd8eoDEtSjDmoBgT7VKUfb2+nfzZbMP2AMDzimXalgVxFynIVmj34gtndHMze5givn87v1oOmkrLfIdfMkk4tZ4fZ6YOCngABoorWnjRk7JgH2cch/E2p4iUTWSAICGGNi8grryqf4OHm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyAV8wZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyAV8wZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5BC1F000E9;
	Tue, 16 Jun 2026 07:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781594369;
	bh=17T1ggvtubOKsfWfaYQ0f7h4/cF2wrBz/6e+ppZmoao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZyAV8wZuE+uZlnHci03q+0sgDIrFm3CyAiZdHQRpktDdoeWkEmbwm1kW24pWQF5Ur
	 Q7CjNSjqcNWDjCon8UWp9ficvznMU10BCG+fPdEHwW9iSbNVar/3Kw9Ew77YAqZ21k
	 uz+aBLH5f4B/2tSbs2gCayXaTYA34As8f5gBbTCEFVf77tm4te2PBU2N2z9Q/jR/B2
	 2Jzs2cNz/75t0oySOFE2uBK85fytoRd5RRaZcX7N4POAPG5Ql80Y1T6wNQq2j9lwQN
	 6DNthOW0CL+KVVWAXZK6L56kQWSE1tqMhMTGEoBxfO8vBEPg0sg6HHsfBsbo042n/W
	 Gl4BlJs+TfUbw==
Date: Tue, 16 Jun 2026 08:19:25 +0100
From: Simon Horman <horms@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	vladimir.oltean@nxp.com, faizal.abdul.rahim@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Message-ID: <20260616071925.GA800687@horms.kernel.org>
References: <20260615072436.26128-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615072436.26128-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

+ Vladimir

On Mon, Jun 15, 2026 at 12:24:36AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The current FPE verification retry count is set to 3. However,
> the IEEE 802.3br standard does not specify a fixed value for this.
> A retry count of 3 may be insufficient when the remote device is
> slow to respond during link-up. Increase the retry count to 20 to
> improve robustness.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Vladimir, I'm wondering if you could take a look at this one.

> ---
>  include/linux/ethtool.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index f51346a6a686..9a1b1f5d37a4 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -23,7 +23,7 @@
>  #include <uapi/linux/net_tstamp.h>
>  
>  #define ETHTOOL_MM_MAX_VERIFY_TIME_MS		128
> -#define ETHTOOL_MM_MAX_VERIFY_RETRIES		3
> +#define ETHTOOL_MM_MAX_VERIFY_RETRIES		20
>  
>  struct compat_ethtool_rx_flow_spec {
>  	u32		flow_type;
> -- 
> 2.43.7
> 
