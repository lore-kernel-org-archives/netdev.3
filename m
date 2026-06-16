Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB0331EA5
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646722; cv=none; b=g0VsddeFIXmMJmqtGAITVpFvQVRwOZLpkUAu6vxXji7b9i3719cIs6XN4urfmJ61AagTRmUN2+A6wwqF10dA8VybIDJVBDa6dNn2bWovHFEjyMVE7WSa7hXL4m7g22IsAYOOntX4sHWb9gxkZaUl/E1rJ39XOl3H9oXOz4GeJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646722; c=relaxed/simple;
	bh=obOzldN+LQsjeklG6LrCuEPhtTiDzSyhkMGybJq7nzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT51LIM4o8VntyPbJZO+BtVwlMTm/C3iFwbo1Z1lCgV2mozlfCahVfNmN81wZYf9RCKrAx6gjzCFL+tM100NC9bbHd1WcxALuaI/XGFKqphjqBPcR6Or6NdoDoG4CF3Pc27ihiuYnbo9RmnoZrE2GoAVjth29POAn7QrpqfyxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BkQPM8Ff; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BkQPM8Ff"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JMh2DGgeekcuM7pXyDPRogcytRWKrPwaCauLBLQ4ra0=; b=BkQPM8FfBpHKaPv9mpBJm6UYVk
	M6dcnNLuYqKsNMR1SvbB0GNQOute76XtHniy0LzLuLB/ENTTmetjDRm3AHEB7Iti0Pn1RgL3mFess
	xkJsf6bq/G/I+WTFrd/yVNeBRBqNlOpR1ku2vkAk7OrDcIPNvLQ467f1B1cION23Np5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZbhC-008277-KT; Tue, 16 Jun 2026 23:51:46 +0200
Date: Tue, 16 Jun 2026 23:51:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] e1000: Remove redundant else after return
Message-ID: <ead7bfc9-3978-4442-9cd1-23c2182b36b3@lunn.ch>
References: <20260616210008.109635-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616210008.109635-1-lovekeshsolanki00@gmail.com>

On Wed, Jun 17, 2026 at 02:30:08AM +0530, Lovekesh Solanki wrote:
> The else branch is needless because the preceding branch
> unconditionally returns -ENOMEM
> 
> Reduce nesting by removing unnecessary else
> 
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 9b09eb144b81..3d97e952c916 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1546,11 +1546,10 @@ static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
>  			      "for the transmit descriptor ring\n");
>  			vfree(txdr->buffer_info);
>  			return -ENOMEM;
> -		} else {
> +		}
>  			/* Free old allocation, new allocation was successful */
>  			dma_free_coherent(&pdev->dev, txdr->size, olddesc,
>  					  olddma);
> -		}

Hi Lovekesh

Please review this patch yourself and tell us what is wrong with it.

Also, please read

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr
