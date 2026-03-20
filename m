Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C723CAE87;
	Fri, 20 Mar 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023717; cv=none; b=jDNH9fmpxtq+VsRphOCshMZTyylWDBFpx97g7sFGsZt1LY2ZhyDtpJ8dRlHlH52t+lEJsqpWwtdCBNfnJ2AqXUI/vd5jrFcrLKSfQdegtvkqZcG1zGK9+ZlyXBkEeq2aSoIWuViKzUx7OXSzg2ustb+fb56kw63Rr1boIpPbObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023717; c=relaxed/simple;
	bh=zmy6E3ZEz7O0Ry0kSSa8nMBddWSwjazWgQ9IjTZQnr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCwgcjNKqMiHsPPtj1koWBwHILX0jyBMN6BtFaxhBygdYxhQO58WAWQoOVwwusRRcC9MQj9fmFDAwbIRF7tPOspFkQ6aBwzK7gdumSml/YdCmmXgtmxwv6A+sgOURxgQvzYAET+I0uZ3OTABMvdEN4Le7CiPgIo5jMUfdEvciz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd4poCo5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd4poCo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063C1C4CEF7;
	Fri, 20 Mar 2026 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774023717;
	bh=zmy6E3ZEz7O0Ry0kSSa8nMBddWSwjazWgQ9IjTZQnr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hd4poCo5lCD2Wrt8cdRSInpfgGb/s1fSopRcBA9k7nb+aEr6/ovaW6L8thQIAhKBd
	 LBdPJu8Cj3w4CemWMvr8xOYRUZDpos+R+1aZki/KpYOmc4qDwPUkfnPMMp8I8qGepN
	 Za+yuiICBd9ycpgOxXhR3/V6uVFamEDHQgfh3FcnQKjXNXH75nBaVCor4XvOXfWFcg
	 v4O9dTk60Xv0S5D59gXKPOusXk8H4xlxUtGHYzVeRNfVsFgwR41bd/isnmwYYPpg8x
	 mO6CAVt7aOPAEfs/RmzhhsT56I0dHg9QqYlJtSMPJS43SNMalleYcWM/S8RRay9zso
	 kYhHln9hG2NaQ==
Date: Fri, 20 Mar 2026 16:21:52 +0000
From: Simon Horman <horms@kernel.org>
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
	quan@os.amperecomputing.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH] net: xgene: fix signedness bug in xgene_enet_get_fpsel()
Message-ID: <20260320162152.GA79627@horms.kernel.org>
References: <20260319091106.1662-1-mohd.abd.6602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319091106.1662-1-mohd.abd.6602@gmail.com>

On Thu, Mar 19, 2026 at 09:11:06AM +0000, Anas Iqbal wrote:
> xgene_enet_get_fpsel() returns a u8 but can compute a negative
> value when xgene_enet_ring_bufnum(id) is less than
> RING_BUFNUM_BUFPOOL. This leads to an implicit conversion of a
> negative value to u8, resulting in a large unintended value.
> 
> This can cause incorrect behavior when the result is used in
> bit operations such as BIT(), potentially leading to undefined
> behavior.
> 
> Fix this by validating the value before subtraction to avoid
> underflow.
> 
> Fixes: 2c839337520b ("drivers: net: xgene: Add helper function")
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
> ---
>  drivers/net/ethernet/apm/xgene/xgene_enet_hw.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
> index 2f534f9d4416..fe563c396773 100644
> --- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
> +++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
> @@ -405,10 +405,16 @@ static inline bool xgene_enet_is_bufpool(u16 id)
>  
>  static inline u8 xgene_enet_get_fpsel(u16 id)
>  {
> -	if (xgene_enet_is_bufpool(id))
> -		return xgene_enet_ring_bufnum(id) - RING_BUFNUM_BUFPOOL;

Hi,

It seems to me that the existing xgene_enet_is_bufpool() condition
protects against underflow. Am I missing something?
