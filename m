Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB6D38F923
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293200; cv=none; b=IwDFttiAFFzXPcnSea2LZrjgOB/jt1PTi+nydM4ZOAW+EqkQCQVpwyr/ABYqkdQWl3COrZNWbsMYEDdrMlFMS917pAOIBUGPPqpH3lB2kvOoMf3f44wADx04CXEAkne8QU4iVCQ+whwfWBuL08gDnL4bWRLWCYmTXDdewspuhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293200; c=relaxed/simple;
	bh=ga2Oc71UKiHByJauvwwdS3L1tRc9XCRZ/M0bjoo/n6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPW3gXKNzRtqR/+l576qxq6liBnk2NI5M+hnwwKSvQIZ8NUsW9b5b1ElJ+kuAnigS71BLmy8lfs0v4XBFycSskRKwrdn3D/qDONnU8Hlt+0Apb1zanQIYf9gEy2R6/Zb95GBbwoBvtRWtJhyOZ1//6gWHU5EwF20055J8uOzBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oLmilcZJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oLmilcZJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hv2Ow1ld1FBUX1iqO/T7CKESCohHcY+IkpgYqfsRrnc=; b=oLmilcZJHC5mGFs6JJJ0s6vrsu
	YB3UlQjW5U1FjMgov8M4nv45kbrx2hfZhqBBzyksSXOMmk+/Zk6Mc5k1Vhr/rjypTtmNSjiSdxBLN
	vvlWO++6qr9ZJVyfG7wzA18Q7wswivM42r1kjpPYtYFcUWvWxaMREB7AGEXPQxrU2Rxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wY7jD-007NEZ-SH; Fri, 12 Jun 2026 21:39:43 +0200
Date: Fri, 12 Jun 2026 21:39:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rongguang Wei <clementwei90@163.com>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH net-next v1] e1000: Initialize phy_data to avoid
 unexpected values
Message-ID: <1578c474-ffbf-46f7-b906-49da4ea48142@lunn.ch>
References: <20260612080331.120096-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612080331.120096-1-clementwei90@163.com>

On Fri, Jun 12, 2026 at 04:03:31PM +0800, Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> The phy_data variable is not initialized. If e1000_read_phy_reg
> returns an error, phy_data will not point to a valid value from
> the PHY register, which may cause the regs_buff array to be populated
> with unexpected values.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> Change-Id: I46071b3b21a566f8da650168d38d6968251b077d

What does this Change-Id mean?

> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index 4dcbeabb3ad2..f068108c5004 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -327,7 +327,7 @@ static void e1000_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
>  	u32 *regs_buff = p;
> -	u16 phy_data;
> +	u16 phy_data = 0;

	if (hw->phy_type == e1000_phy_igp) {
		e1000_write_phy_reg(hw, IGP01E1000_PHY_PAGE_SELECT,
				    IGP01E1000_PHY_AGC_A);
		e1000_read_phy_reg(hw, IGP01E1000_PHY_AGC_A &
				   IGP01E1000_PHY_PAGE_SELECT, &phy_data);
		regs_buff[13] = (u32)phy_data; /* cable length */

Isn't a cable length of 0 also unexpected?

How does this patch actually make the situation better?

    
    Andrew

---
pw-bot: cr
