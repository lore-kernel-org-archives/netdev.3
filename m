Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBB3C5550;
	Mon,  7 Sep 2026 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800883; cv=none; b=jw29mwQpoEWSlOCpnHLCStaaLcuVo0NjRIzyu5+sgjMPeD4AgRs/HW+8ufds+Ll1nS9r1Ft9DTwoOiSx3UC//yPB5GiL5Af4CHT4AEvb+rTF3ww8YhcIc2EGpPF7uYo9VQnJAKJJU1JK5f7NnEAACAuwE+74tgQSZCbdWrnABlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800883; c=relaxed/simple;
	bh=1ifQzGu3Hf4b8ZqQCDKJvP8hspJ29GVdzYNzK8Asi1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2HkwY8Y0Zc8nP6bNDBhgdilDQibDqt3pyU48Sk3RrlkhXKv7DJTyGN3m7yNQbBT92T14Ko/GQgAcWKTcg69DsENOccnxDh7g+pRjuPNj/ezWrU5xGW2JZ9JDBPjYNhq5eFz1iCk05XqxsHAVK3GST6JNTYd/8AIC61w14xL9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qwMAw8d+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qwMAw8d+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=w16HbRTZNk24gYHENslvNzYjNJGR1RDXFGDxYomI30I=; b=qwMAw8d+42MYS2oG8Nf8XTmcEz
	evcY/5k4QE1GzQd8e+sml+VBEoNSv6zjnDXeutOfvKS8KPxfTcVD5SYeiFLhGfWDk1GnydiqagqGO
	Vqg7u7o2Yu8Aa1z4WClGpKVkKkUR5+zXPaXbV/6vw0rIiE6oJ+VmDg78BmpwJuxoe/LgUyWRTLPWW
	UrC+pI6O2EZ3Na3377iiJqv5uoxLtiAbNo37eWeZAI3OUEyoM0fgQcVn1hsgCSkhv99f66N0a+6Hm
	6HvW1vOSt/TuUdcoWubAc7DeGOhjO4Aj8tCtytBEhdKtEmI5+75nqY3UMJkNX6NGbQMLH6XkkOOj4
	f7IQl1NQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3cp2-00000007RIP-1xvw;
	Mon, 07 Sep 2026 17:07:56 +0000
Message-ID: <6fc6daf7-efb7-48c3-95d5-1beb01cc0924@infradead.org>
Date: Mon, 7 Sep 2026 10:07:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: intel: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260907064528.6602-1-hemanth.selam@gmail.com>
 <20260907064528.6602-2-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260907064528.6602-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/26 11:45 PM, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c     | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c    | 2 +-
>  drivers/net/ethernet/intel/ice/ice.h              | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c         | 2 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c        | 2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 8dadfef2c09f..026b35e5a000 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -676,7 +676,7 @@ int i40e_pf_reset(struct i40e_hw *hw)
>  	grst_del = FIELD_GET(I40E_GLGEN_RSTCTL_GRSTDEL_MASK,
>  			     rd32(hw, I40E_GLGEN_RSTCTL));
>  
> -	/* It can take upto 15 secs for GRST steady state.
> +	/* It can take up to 15 secs for GRST steady state.
>  	 * Bump it to 16 secs max to be safe.
>  	 */
>  	grst_del = grst_del * 20;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 3da9ec49cc74..ef9d1e78c16a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2614,7 +2614,7 @@ static u64 i40e_eeprom_test(struct net_device *netdev, u64 *data)
>  	netif_info(pf, hw, netdev, "eeprom test\n");
>  	*data = i40e_diag_eeprom_test(&pf->hw);
>  
> -	/* forcebly clear the NVM Update state machine */
> +	/* forcibly clear the NVM Update state machine */
>  	pf->hw.nvmupd_state = I40E_NVMUPD_STATE_INIT;
>  
>  	return *data;
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c..e5f940d324dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1105,7 +1105,7 @@ extern const struct xdp_metadata_ops ice_xdp_md_ops;
>   * ice_is_dual - Check if given config is multi-NAC
>   * @hw: pointer to HW structure
>   *
> - * Return: true if the device is running in mutli-NAC (Network
> + * Return: true if the device is running in multi-NAC (Network
>   * Acceleration Complex) configuration variant, false otherwise
>   * (always false for non-E825 devices).
>   */
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..fe47ec0ba809 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6202,7 +6202,7 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
>   *
>   * Features that need fixing:
>   *	Cannot simultaneously enable CTAG and STAG stripping and/or insertion.
> - *	These are mutually exlusive as the VSI context cannot support multiple
> + *	These are mutually exclusive as the VSI context cannot support multiple
>   *	VLAN ethertypes simultaneously for stripping and/or insertion. If this
>   *	is not done, then default to clearing the requested STAG offload
>   *	settings.
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..9ef1aa66fa2b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -924,7 +924,7 @@ static void ice_sriov_remap_vectors(struct ice_pf *pf, u16 restricted_id)
>   * is correct etc. Then disable old mapping (MSI-X and queues registers), change
>   * MSI-X and queues, rebuild VSI and enable new mapping.
>   *
> - * If it is possible (driver not binded to VF) try to remap also other VFs to
> + * If it is possible (driver not bound to VF) try to remap also other VFs to
>   * linearize irqs register usage.
>   */
>  int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 7ce46b4b4821..7eb4acf59dab 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -3995,7 +3995,7 @@ static void ixgbevf_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
>  	if (tx_flags & IXGBE_TX_FLAGS_CSUM)
>  		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_TXSM);
>  
> -	/* enble IPv4 checksum for TSO */
> +	/* enable IPv4 checksum for TSO */
>  	if (tx_flags & IXGBE_TX_FLAGS_IPV4)
>  		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_IXSM);
>  

-- 
~Randy
