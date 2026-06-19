Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE111CAF;
	Fri, 19 Jun 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849198; cv=none; b=MEzHvcdrIG7Ic2D7aqRkltGGF7QZtouXUYfB7CZHIqz1wbv6Yhf7Kv5yAtB7lYl56I9ifS6eGvvfyzNmw2Cp6HhUEQR5fa1GXqOr6WpMa4WC3Yxg1uZG5mavLVbx57SJtT8nuvxcF3icJjoLL0qDCV9TX9j2gotCv59sSmeBRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849198; c=relaxed/simple;
	bh=zgsRyLpRVC9vxmXYGpA/T8bEznI5U8RkG6bHHlBtQHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pinwp1Ft8L1YAP+KjEGhS44QaMSasl7g8Ng5k+QkqMMBJgsHMGT3z58aAAh9ypoozYMfmf4dqukf7JD7YSBtVmaBlopHKa7h7s2TXvgrvPsrmhBJOtiuXm4yft2nOi4RSloNJkG5FazJTJMZObn4Xb/MsomnTtll3k6xxhNzv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L0eSI04B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L0eSI04B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B7hUKPB7971LTFRuZGDT0SxAkDRZ6LJO96FqOks5zx8=; b=L0eSI04BZl89ojx7+DxSdYGVA4
	2W/AZK+I5eOt+qmhrbew4aol52/sW9lQehZlzd5lHKuGOjWRgkNINEOCCxg8iCGAPZYVAHBGIa9e2
	+Mq2RZlvuU2PsxFsuRI8x5P/RABUQrxTyYRdDpTduM5Kki5C4ZzkTEqZFHD9dk/h7Vag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1waSN3-008SVk-Vz; Fri, 19 Jun 2026 08:06:29 +0200
Date: Fri, 19 Jun 2026 08:06:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 3/4] net: dsa: motorcomm: Dynamically allocate
 port structures
Message-ID: <f9234e83-e9e1-488d-93f5-1f3c20634c87@lunn.ch>
References: <20260618202716.2166450-1-mmyangfl@gmail.com>
 <20260618202716.2166450-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618202716.2166450-4-mmyangfl@gmail.com>

On Fri, Jun 19, 2026 at 04:26:31AM +0800, David Yang wrote:
> With support for LED introduced later, struct yt921x_priv will be 17k
> which is not very good for a single kmalloc(). Convert the ports array
> to a array of pointers to stop bloating the priv struct.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/motorcomm/chip.c | 95 ++++++++++++++++++++++++--------
>  drivers/net/dsa/motorcomm/chip.h |  3 +-
>  2 files changed, 75 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 6dee25b6754a..d44f7749de02 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -548,11 +548,14 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
>  /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
>  static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  {
> -	struct yt921x_port *pp = &priv->ports[port];
> +	struct yt921x_port *pp = priv->ports[port];
>  	struct device *dev = to_device(priv);
>  	struct yt921x_mib *mib = &pp->mib;
>  	int res = 0;
>  
> +	if (!pp)
> +		return -ENODEV;
> +

Are all these tests actually needed? If you cannot allocate the
memory, i would expect the probe to fail, so you can never get here.

	Andrew
