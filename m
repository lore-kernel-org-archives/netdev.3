Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE1A42123E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473656; cv=none; b=BQPBqbYWNcm9nlpiq69HkEhbb90c1YQNtHBEJPWEsDvCUjM5PLJY4N7aXxByTL/SYrohjIlPWmIitcyAJpMBdkV6PCaKT2LYk2Lone/r/gNwJnNtS7TXesFUXW5cFvJH+wCgP/iFmKo6LiPV/GEHVWuiV4ZCn6RN8Xtwi5+I5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473656; c=relaxed/simple;
	bh=BFp5gpV2O1TDpaecJCx+ypFhfWihx4C3uw6fm58Nz94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g39pXoMy3DIViJJvwOYEn8rNQcpoA5jrx6qVnSeTp5m+84CCg3THHbLKcDyo4mWNsE6UOEyHsiJijwa0z96MGZKBGoWBX0Iu+t3ieNeSnyIsK4U6yfPTiOpYIhU2tUGBBbIsllMpstbYLd10w5ayFDf9Rvtu8MA15e7uDd1dU2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHucIXP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHucIXP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9734D1F000FF;
	Thu,  8 Oct 2026 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791473653;
	bh=PmiBS94RhRYgkmDoyiZb+q08HHwxXf0dc7aXfJhOhW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hHucIXP/GAdTZh7q6uvGIR5RDdIS+phmIrn6PnLM4XJ9LfCLAS4UdUnZ/vXFfZNPr
	 2qc5ALdRNel4hS9Cgz5G1eQbddqw9Q7JW2Q8xodK425XiOJ3pQU9X5Nw7wHKLaqtAL
	 qjyoaA0PVOyuMgCI+Pw0NCNhmf1hFtlE+UcAbEoOutHG04zE5SDnZKSg4Nw09I3bFm
	 l/3/JYfTou2SWYkfst00jHTU9E22Xi2Crtv7pFoWp2plm1pTXD06c3f+cm+YNID0Ma
	 /XZ5uF5M1sCBQavi2MYOL6Pt5aPeR+OBkspk62uqRdxNvPHpArR4rHIEQQjcEiin1a
	 nQHfFKn1O5fXw==
Date: Thu, 8 Oct 2026 08:34:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, pabeni@redhat.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: Re: [PATCH iwl-net] ice: keep the RSS hash function on
 indirection-only updates
Message-ID: <20261008083412.23481894@kernel.org>
In-Reply-To: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
References: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 22:03:11 +0200 Maciej Fijalkowski wrote:
> The ethtool core passes RXH_XFRM_NO_CHANGE (0xff) in input_xfrm when a
> request does not touch the input transformation, e.g. when it only
> rewrites the RSS indirection table. ice_set_rxfh() tests input_xfrm only
> for RXH_XFRM_SYM_XOR, which 0xff has set, so such an update switches the
> VSI to symmetric Toeplitz hashing behind the user's back.
> 
> Once symmetric-xor is reported, the core requires all hashed flow types
> to be symmetric for any following RSS set. The GTP flow types hash on
> the TEID, so every later netlink RSS update fails with "hash field config
> is not symmetric", including the one that would put the indirection
> table back.
> 
> Keep the current hash function when input_xfrm is RXH_XFRM_NO_CHANGE.
> ice_set_rss_hfunc() then returns early and leaves the VSI as it is.
> 
> This has been encountered while trying to run xskxceiver within drv-net
> tests where one of the setup steps was queue pull out of RSS indirection
> table.
> 
> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Hm, not seeing it on the list now but I thought I submitted this 
a while back:

--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3681,10 +3681,10 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
             struct netlink_ext_ack *extack)
 {
        struct ice_netdev_priv *np = netdev_priv(netdev);
-       u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
        struct ice_vsi *vsi = np->vsi;
        struct ice_pf *pf = vsi->back;
        struct device *dev;
+       u8 hfunc;
        int err;
 
        dev = ice_pf_to_dev(pf);
@@ -3703,9 +3703,12 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
                return -EOPNOTSUPP;
        }
 
-       /* Update the VSI's hash function */
-       if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
+       if (rxfh->input_xfrm == RXH_XFRM_NO_CHANGE)
+               hfunc = vsi->rss_hfunc;
+       else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
                hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+       else /* input_xfrm == 0; core rejects any other value */
+               hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 
        err = ice_set_rss_hfunc(vsi, hfunc);
        if (err)

Could you double check if we need the trailing else as well? 
Not 100% sure now if I added it just in case or it mattered :S
