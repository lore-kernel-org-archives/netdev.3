Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C984302EC;
	Mon,  6 Jul 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331482; cv=none; b=ItoHvrwIE+zKq6gEZFlqWzKESsGZE/we02/3GIPPKDji641KGR4JLcG+qtxWUp2K1lEkm2lZbA3aENleZl3BKnIWvo4rAIwyapMdlcNzM/loT1nsUmawBEzw3bUdDHEs5Ati6fbDofHfdeOLGuNXGSa4pw5JFVWhnsE9Bns7b6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331482; c=relaxed/simple;
	bh=1cw2dtvKWTaAGRljDiJTLFfP1+KQjkYN/p7W+Z6InYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBMTGNV2i19AiZKytGJ6TDH3+Sn+aDRJWPemQXPhpv82yNAtARiWzyzdYmZAInvkpx3jgJhDt39muGOB0EgD979MuxgiVu/T9HQNhXNRZwsEt3qZLO4hQD3VM1HEMLEpKYrBTvCnxQdiKKGKpXHEAdyVTL03mjpSFCDr5qlVwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5pycLWg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5pycLWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783331478; x=1814867478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1cw2dtvKWTaAGRljDiJTLFfP1+KQjkYN/p7W+Z6InYo=;
  b=b5pycLWgAoWDsTAbhtFrl1qhK0/jqOhgcwyXcDNWzjuhO2YzmaJbz6Xx
   G1cDYijL/8EYtrlD50DRlsvKqvClJ7faKDHPt8Xmz54ApcavbBNjyf8pX
   4uY8ly0lqi/YuKTjCb6BOCbr503hlzHdJkXm9S1PZ22WgIdsOwyA3k6BJ
   E92PuwxWzdMdbVsEOLc5UFyDrtK0Bs4z/Cuw4Q0+GfIGp0jnI7G1WQ/TH
   V3V4EabEnljzp2PwGjciQmauqvMfwNwUGXRFN59OO+G0+GC33Hgojy6PJ
   scTBFTen/d12CUve3RQHHCKxS2YGx/gl6a9yv3CCRHfCUpY60wnpPHhy0
   g==;
X-CSE-ConnectionGUID: Z1lH+5jGRcSDsCDQn5TvoQ==
X-CSE-MsgGUID: 6ooY3/LKRw+IEUZuk+H2NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83824464"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83824464"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:51:11 -0700
X-CSE-ConnectionGUID: z9CLoUOsTy2VFlZjUx6WyQ==
X-CSE-MsgGUID: w0LGO3M/SGmg5pUekZArgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="276884555"
Received: from unknown (HELO [10.217.160.239]) ([10.217.160.239])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:51:08 -0700
Message-ID: <a0fd140e-9c0a-4cee-a692-2e697bd4762f@linux.intel.com>
Date: Mon, 6 Jul 2026 11:51:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] idpf: fix lan_regs leak on
 core init failure
To: xuanqiang.luo@linux.dev, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Joshua Hay <joshua.a.hay@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260703104132.47419-1-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260703104132.47419-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/07/2026 12:41, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> idpf_vc_core_init() gets the LAN memory region layout before mapping the
> regions and allocating vport resources. Both layout paths allocate
> hw->lan_regs, but later error paths return without freeing it.
> 
> idpf_vc_core_deinit() does not cover these paths because it returns unless
> IDPF_VC_CORE_INIT is set, and that bit is set only after core init
> succeeds.
> 
> Free hw->lan_regs on the post-allocation error paths and clear the
> pointer and region count.
> 
> Fixes: 6aa53e861c1a ("idpf: implement get LAN MMIO memory regions")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index be66f9b2e101c..da49bb7b7e671 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3479,6 +3479,7 @@ static int idpf_vport_params_buf_alloc(struct idpf_adapter *adapter)
>   */
>  int idpf_vc_core_init(struct idpf_adapter *adapter)
>  {
> +	struct idpf_hw *hw = &adapter->hw;
>  	int task_delay = 30;
>  	u16 num_max_vports;
>  	int err = 0;
> @@ -3550,15 +3551,18 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
>  	if (err) {
>  		dev_err(&adapter->pdev->dev, "Failed to map BAR0 region(s): %d\n",
>  			err);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto err_lan_regs;
>  	}
>  
>  	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
>  	num_max_vports = idpf_get_max_vports(adapter);
>  	adapter->max_vports = num_max_vports;
>  	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);
> -	if (!adapter->vports)
> -		return -ENOMEM;
> +	if (!adapter->vports) {
> +		err = -ENOMEM;
> +		goto err_lan_regs;
> +	}
>  
>  	if (!adapter->netdevs) {
>  		adapter->netdevs = kzalloc_objs(struct net_device *,
> @@ -3624,6 +3628,10 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
>  err_netdev_alloc:
>  	kfree(adapter->vports);
>  	adapter->vports = NULL;
> +err_lan_regs:
> +	kfree(hw->lan_regs);
> +	hw->lan_regs = NULL;
> +	hw->num_lan_regs = 0;
>  	return err;
>  
>  init_failed:

Does this apply? struct idpf_hw was removed in 9f4334ac4a5a ("idpf: refactor
idpf to use libie control queues") [1].

[1] https://lore.kernel.org/intel-wired-lan/20260608144127.2751230-10-larysa.zaremba@intel.com/

Thanks,
Marcin
