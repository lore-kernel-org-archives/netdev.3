Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4B33B6FB;
	Tue, 10 Mar 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159418; cv=none; b=ZihUGN4OkVNb0zy+MuTVX2fPPNlXYN+faiTc2eIweLkXqsxbgldjGf3uFO2PNcSJny9hSRaiBgKaPOZi0WAHiz+MZDYIPf2CzVdeeTRxvpjk6lqHGTws38XUEjQSlf111at/5XkvQsd8oZ3wfH153lFP1W3zh4TrqMEdOHNDfVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159418; c=relaxed/simple;
	bh=IafWGth0JNkBH1Xlh02d1foaZk4Un/KFq7HNNk/agGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baoBB/9W5dQUiGOx3XTfkNsDu0dU2Oq4Vj+15lA4B7xAnrRz/p6Mj+AJ2HfBYmyH1vievMRyWiXP1sXdc06EqVGBl7jnsYzq+tcDNSrxJyjFHQT2DjyH82oILWJm0i+fmRsH00mOjx5/ErSQl5Khm6/41KS3c6zaDlTyeDGiPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcWS6g7b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcWS6g7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D082C19423;
	Tue, 10 Mar 2026 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773159417;
	bh=IafWGth0JNkBH1Xlh02d1foaZk4Un/KFq7HNNk/agGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcWS6g7bXtLkAOkjuiWcs9ZA7IV4JJvVmdmaCZOfC+SLS6ivb/iLQO9Hk3lWuAqCD
	 UQFPk/tcx70F2Jb1LLzrl+37188RqeBDraeXK4zWJOErqBsXElV5fsjK9nbu82KvmO
	 oWZjkt1xcSEeAiN2auU9dwvg/3EjKr/Su2Nfdq7+IhbI+nGOla9foSl9qjbwU0wCnF
	 VlQ35CNgrr7fWbrGDNLzOEFI0J4UJmGsGrU75+xWfZff5uLFzwwbA4tzG3xaQp9CgE
	 KGQLRdXZPI0I0LhmRPUm6OV4TpCBRn4E3XUwAKn9y1wAi9nGV3AEX2Erhpfy0xsv6O
	 LzLvISXtktpsQ==
Date: Tue, 10 Mar 2026 16:16:52 +0000
From: Simon Horman <horms@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Vincent MORVAN <vinc@42.fr>, Paul SAGE <paul.sage@42.fr>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tg3: replace placeholder MAC address with device
 property
Message-ID: <20260310161652.GJ461701@kernel.org>
References: <20260306170657.39384-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306170657.39384-1-atharvatiwarilinuxdev@gmail.com>

On Fri, Mar 06, 2026 at 10:36:55PM +0530, Atharva Tiwari wrote:

...

> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 75f66587983d..b9950651b20c 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17030,6 +17030,14 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
>  	return err;
>  }
>  
> +static int tg3_is_default_mac_address(u8 *addr)
> +{
> +	u32 addr_high = (addr[0] << 16) | (addr[1] << 8) | addr[2];
> +	u32 addr_low = (addr[3] << 16) | (addr[4] << 8) | addr[5];
> +
> +	return addr_high == 0x00001018 && addr_low == 0;

Hi Paul and Atharva,

I think you can use ether_addr_equal(), or some variant of it, here.

> +}

...
