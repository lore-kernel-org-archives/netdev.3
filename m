Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D3496D4F;
	Mon, 14 Sep 2026 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416645; cv=none; b=hm7TBTt5RFbKUDhJDfOofDafFTY0tONRkZwlDNiCqvywhgJBsorf6zwjBhzUOs4iasOI9UbbCB/Cws80J08t/yBP/8nZ0CS4br7nRhuk+Sen3qgBYGKyZQnXsnkDFdpzhFYZn6B/TT+NgWUnK6UVmBvm3E5i4tWHkCY5jYXGn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416645; c=relaxed/simple;
	bh=EYs16lc+M/ljFt1dPBaln9KK7rypDaywzMZ6hGy5UyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaSZee7Q6hAo38RaunKGUrw8uh/zV/lmxqN6qZDMug2+6YvmcogxQ4F+oPE/5tIJIDYur64eGdXSlIfV3cEtO0FJoj/OUEYUkqn2Kxw1lgyq1uI0W1FEIe5roR1mJF+K0cs3zVVXv4EmYZbxjBO08Vlmwi7MCnWFIOEw432udZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I6yof3Ep; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I6yof3Ep"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Cyd15aqCLL0C9quDANCZs0xeT7O/8tEjoydez/zTO+U=; b=I6yof3Ep5KUDsHQ/icDBFQXFnD
	p7QpgIOZJheciXfj6QK8rja0JdDVNFoSv//elPq7ISffQ2tLzQzFdBwvoMzZ2P/PFbZhJAmMl8Kxg
	GvKy77wQ9rjoVur9ohXSWXbNI16yQ5fs/rYi4UsEMOU1+0nN6u7Wm4dOH2BypBXfr69s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6D0T-00588c-Oz; Mon, 14 Sep 2026 22:10:25 +0200
Date: Mon, 14 Sep 2026 22:10:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] tg3: clean up PHYLIB resources on probe failure
Message-ID: <2b1101ed-ee5c-4a44-bdaf-a789964dfd0b@lunn.ch>
References: <20260913012148.9800-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913012148.9800-1-mhun512@gmail.com>

On Sat, Sep 12, 2026 at 09:21:48PM -0400, Myeonghun Pak wrote:
> tg3_get_invariants() can register an MDIO bus and connect a PHY for
> USE_PHYLIB devices. If tg3_init_one() later fails, its common error path
> releases the mappings and netdev without undoing those PHYLIB resources.
> 
> Disconnect the PHY and unregister the MDIO bus before the remaining
> teardown. The existing IS_CONNECTED and MDIOBUS_INITED flags make both
> helpers safe when initialization only completed partially.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 158d7abdae85 ("tg3: Add mdio bus registration")
> Assisted-by: OpenAI:GPT-5.6
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 73a4b569b..4662e0e92 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -18047,6 +18047,11 @@ static int tg3_init_one(struct pci_dev *pdev,
>  	return 0;
>  
>  err_out_apeunmap:
> +	if (tg3_flag(tp, USE_PHYLIB)) {
> +		tg3_phy_fini(tp);
> +		tg3_mdio_fini(tp);
> +	}

Looking at tg3_get_invariants(), tg3_mdio_init() is not conditional on
USE_PHYLIB.

    Andrew

---
pw-bot: cr
