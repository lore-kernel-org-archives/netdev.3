Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A1306B11
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561213; cv=none; b=bKu1MI0OPGXl7CWat5UYGEKY4xzMTG1JgfjE4/bzI+fxbmiijl1o0rFWOg/xvAo7LgNIbohewdY+K3Kv4xSNOvWjg8+DV84xRnZVRP1Ylcr/FVZ093ETS/E3H9mSdCKRJBp8tHhOzggyuZresxwBrgF8pqwIPafKVXL4CLrMFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561213; c=relaxed/simple;
	bh=T+vUabHb8ThQm3gxYr+D+KCExN9uc73ymsd40v5RhWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji/wCnGmdzDK94tjZEtryJOwkut+t5ZdVv+/Y9ynQ7kOA+bqAAcP14/WfzOcM8ZNp6/3xRPbw/a+sfhmN1vO6qfBoGbAzVJTrvBtqCa3Fux1u3vWoJfvTeFDsMe0ixppQmgNwxqmItlUadVMQTau7/L5HNe2iBYLIMu8AYBI3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=O5D1ycEK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="O5D1ycEK"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e08baf860so7831653a91.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784561210; x=1785166010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3VTZ9zHl9OoQneFVX7eJwf/WovVc3pD60nK1eidpzDA=;
        b=O5D1ycEKcQJvCSqvWXsPcqJgLOI81o/TboZ8MO4H2UOEbrIx632WWIaDzk8TrMtROw
         idLirXqHs8/h7tElUIfZv23XyuoLo2Tla10FAD1NTawHTkofM/HCVpdWGAY495oFJ/1e
         ebih8NrikSw+xIODfe9QUYThfVcnfdyKzw4ON0JFBVkHx+Zr+BH4CLo2LN2z+ba1FowM
         I22oUlae3/PSO55M5kOoSe77hoU30wU2VQJ68pDBI7EHMiCPSQAEPWxLa/1CDd87KCrM
         WkFjf6Lffi6d8c5NBuHWFOEio7vY3YZdEKe2rk+2HRI0HUZ97xuBFlHwFfgTDUckX+0Z
         ssOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784561210; x=1785166010;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3VTZ9zHl9OoQneFVX7eJwf/WovVc3pD60nK1eidpzDA=;
        b=D1bvglXmdbE0yJSbDhc4Fl8o0H8FUGyJpz+NbaAK27+74l6dh1J+UD/eFlwM7AVxzi
         gcjOj0izVgacywWP+ypq0VwYT4MOq8Zx7frTAwCR4FD6oi7u88HzC7XM8FuJC9S6ynSI
         2iEk5iuCdR7CcZDUaNN0NLQ3RHHVXckniUymu7Mcd62eeREjytBZuVRp4CBpqyRQyzSe
         FO7SbldaIRhkgeD1LipBOt15wZZpwGZ2rNOB6fmaRQA1RFL/vZHpW/Yjf7vbvxAWt0hI
         nr4/R7n6xEbe4uriup5f5Yacsbx4hvcpybB5dFVFZ1nlo1UcohMOujbMJKIwJIuAo9uP
         5Hzw==
X-Forwarded-Encrypted: i=1; AHgh+RpWqunZXocNS8llHjESVgoDEzPt+X1oPTBK26R9bKxR2KlmMS9uBjsP90Q6qPj1hzmrVcArCD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6RrChv6Fbk6bcI4Vqw9/O2BGW4x4aCzhhzBFiUqAAniY75A5J
	IoOgN0PwSiS830w7nZETLhErsBAKAHVyxjvzYPRPPxtnVG17aMb7C9F3QnLE7N0wZnA=
X-Gm-Gg: AR+sD11Z2JRQ0o2+yqjmUinrcYz0qX7mx02jLRPXIB1lqjPqpLcjSipm062CjXkmnd1
	YRroq1w6POZiUp+tybMqPqq8yNeTPsSjKbNOUvchBx3ywbRotrVQ6qDHRY/acU8iDOf+9U71wAr
	kFExyUIuvTD0ezFvfFLmjaQmr6UVzNdtfZ8dtDdUN5GzAOoGwi8PahHw+sgwrbBBR22fOXSY9Yi
	EV0OWDU6pqNcAkynACXU7gP50QhD0fHJVUNCQSffZqHZZdwilhTVhZ2R0VTsRrXy2/KuZ7f/WXj
	DE3fzy/lrWscMEb/mt2o8dvs/oV6+nstCSFJqkg9GhIaSZ+1/3pZZMd5Ns1hAeKPFQg5RdbcmNa
	CRUDKlU9cCSVK7ie91GlUyvhXSw9BU39qoMcv/bNqWYXu5Yh2zxmp1bRkoag=
X-Received: by 2002:a17:90b:58b0:b0:38e:7239:b945 with SMTP id 98e67ed59e1d1-38e7239ba36mr4798636a91.21.1784561210391;
        Mon, 20 Jul 2026 08:26:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:55::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcd3fesm6080875a91.2.2026.07.20.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:26:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:26:49 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 09/14] net: enetc: open-code
 enetc4_set_default_si_vlan_promisc()
Message-ID: <al4+OXBo7rVJiLb0@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-10-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720014317.1059359-10-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:11AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The function enetc4_set_default_si_vlan_promisc() is only called once,
> from enetc4_configure_port_si(). Open-code the loop at the call site
> and remove the single-use wrapper.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 859b02f5170a..505e4abf6c37 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -307,17 +307,6 @@ static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
>  	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
>  }
>  
> -static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
> -{
> -	struct enetc_hw *hw = &pf->si->hw;
> -	int num_si = pf->caps.num_vsi + 1;
> -	int i;
> -
> -	/* enforce VLAN promiscuous mode for all SIs */
> -	for (i = 0; i < num_si; i++)
> -		enetc4_pf_set_si_vlan_promisc(hw, i, true);
> -}
> -
>  /* Allocate the number of MSI-X vectors for per SI. */
>  static void enetc4_set_si_msix_num(struct enetc_pf *pf)
>  {
> @@ -361,7 +350,9 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
>  	/* Outer VLAN tag will be used for VLAN filtering */
>  	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
>  
> -	enetc4_set_default_si_vlan_promisc(pf);
> +	/* Enforce VLAN promiscuous mode for all SIs */
> +	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
> +		enetc4_pf_set_si_vlan_promisc(hw, i, true);
>  
>  	/* Disable SI MAC multicast & unicast promiscuous */
>  	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);

Reviewed-by: Joe Damato <joe@dama.to>
