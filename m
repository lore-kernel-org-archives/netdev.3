Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECD37702C;
	Mon,  3 Aug 2026 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751525; cv=none; b=S7iUheqYLVOaldZYDXcfCbZsZprN1hk160BSHS4LBUrNBkjrePpDscoqiazaic14IPjNcNYV6AgRUlekw67sk2KzBALdE/zoW/LP+728yULWCA6DKkfZPN1/sanZNbfoCeEXMAxilAWvRUzmojPuXgriB0QIMn6VkJNlB3jhetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751525; c=relaxed/simple;
	bh=XAo4DAYZzBUe3nOpgZa+4cRRLUuo1rQA/pZfXkcJujs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5g+4Dk7S38Vs0I14qZby5bZTBNhwRuemSjA46KIrq9EWl9ulybPPnIdA6PuagLZiKsPYBGfH3T46Ng+ds0noNPVK8lj3YLJ97Pc8ZeqdGR+p7rz0CyQY/MRIh12OLi8MF8samzEYJSraAaBQJFw//+8YACp/360ACIbeVqB3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjcpmDTh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjcpmDTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785751523; x=1817287523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XAo4DAYZzBUe3nOpgZa+4cRRLUuo1rQA/pZfXkcJujs=;
  b=LjcpmDThNgD1/PicARQ0/vybNRUE9nQRFyhz9+JsYCo0d3OuH5XmvLT/
   5nTe3UpXxz4FhtKSLX3XicAMh3D7VlXLoFw3MsmC4G5vV3mnEDBtOQL0v
   nebj1WRhYjJS16v7eVqUo36YBsDxrvzdN0jIohPGQ2dfp5OoEVu5tyRjn
   TrplnJrfmpMeYjCeZxGJCG/5I0lXz99GiaHYY9cemPdonmffJT7wOmw4x
   LBskfVNikCEDenLfj2xjn7tqz7VN1KTIHxXJ8HMogxVWhi8DIDykBpK4L
   Thj4KvyaKcfNGPMgWryH34EurCiklIn4Z8M13OxS2PYPi7RhmSVOEVE68
   Q==;
X-CSE-ConnectionGUID: zti/vw7AROC3QOL0Cqkj0Q==
X-CSE-MsgGUID: utOHc6ImQ0KgOfY2NLJNoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="103684278"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="103684278"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:05:22 -0700
X-CSE-ConnectionGUID: gXCx4fPeR6SQAAJBmo+avA==
X-CSE-MsgGUID: zFixKgjkQnWDHIypS/VPUg==
X-ExtLoop1: 1
Received: from unknown (HELO [10.217.160.239]) ([10.217.160.239])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:05:19 -0700
Message-ID: <2e3101ea-13ab-4c9a-913c-999eb15207be@linux.intel.com>
Date: Mon, 3 Aug 2026 12:05:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl v3] ice: acquire NVM lock around
 each flash read
To: Robert Malz <robert.malz@canonical.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260731111008.1266444-1-robert.malz@canonical.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260731111008.1266444-1-robert.malz@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/07/2026 13:10, Robert Malz via Intel-wired-lan wrote:
> FW caps the NVM read lock at a maximum of 3000ms regardless of the timeout
> requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into
> multiple ice_aq_read_nvm() commands, one per 4KB sector, all issued under a
> single lock taken by the caller. Reading a large region can exceed 3000ms,
> so FW reclaims the lock mid-read and the remaining commands might fail.
> 
> Move the lock acquire/release into ice_read_flat_nvm() so it brackets each
> individual ice_aq_read_nvm() command, ensuring the lock is never held
> across more than one FW read.
> 
> ice_release_nvm() issues its own AQ command and overwrites
> hw->adminq.sq_last_status, which some callers inspect after a failed read.
> Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> capture the failing read's AQ error before the release; callers that need
> it (ice_discover_flash_size() and the ethtool/devlink log paths) use it
> instead of sq_last_status, others pass NULL.
> 
> Callers that previously took the lock around ice_read_flat_nvm(),
> ice_read_sr_word() or ice_read_flash_module() now call them without it.
> The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> dropped.
> 
> Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> ---
> v3:
> - Log the failure via ice_debug() when ice_acquire_nvm() fails inside
>   ice_read_flat_nvm(), rather than silently aborting the read.
> v2:
> - Replace the save/restore of sq_last_status across ice_release_nvm(),
>   which could race with a concurrent AdminQ command, with a new optional
>   read_aq_err output parameter.
> - Add missing "Return:" kdoc to ice_read_sr_word().
> ---
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
>  drivers/net/ethernet/intel/ice/ice_nvm.c      | 79 +++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
>  4 files changed, 59 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 22b7d8e6bd9e..5a1ab9654fb8 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
>  {
>  	struct ice_pf *pf = devlink_priv(devlink);
>  	struct device *dev = ice_pf_to_dev(pf);
> +	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;

RCT
Also scope can be reduced.

>  	struct ice_hw *hw = &pf->hw;
>  	bool read_shadow_ram;
>  	u8 *nvm_data, *tmp, i;
> @@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
>  	for (i = 0; i < num_blks; i++) {
>  		u32 read_sz = min_t(u32, ICE_DEVLINK_READ_BLK_SIZE, left);
>  
> -		status = ice_acquire_nvm(hw, ICE_RES_READ);
> -		if (status) {
> -			dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
> -				status, hw->adminq.sq_last_status);
> -			NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
> -			vfree(nvm_data);
> -			return -EIO;
> -		}
> -
>  		status = ice_read_flat_nvm(hw, i * ICE_DEVLINK_READ_BLK_SIZE,
> -					   &read_sz, tmp, read_shadow_ram);
> +					   &read_sz, tmp, read_shadow_ram,
> +					   &read_aq_err);
>  		if (status) {
>  			dev_dbg(dev, "ice_read_flat_nvm failed after reading %u bytes, err %d aq_err %d\n",
> -				read_sz, status, hw->adminq.sq_last_status);
> +				read_sz, status, read_aq_err);
>  			NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM contents");
> -			ice_release_nvm(hw);
>  			vfree(nvm_data);
>  			return -EIO;
>  		}
> -		ice_release_nvm(hw);
>  
>  		tmp += read_sz;
>  		left -= read_sz;
> @@ -1945,6 +1936,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
>  {
>  	struct ice_pf *pf = devlink_priv(devlink);
>  	struct device *dev = ice_pf_to_dev(pf);
> +	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;

RCT

>  	struct ice_hw *hw = &pf->hw;
>  	bool read_shadow_ram;
>  	u64 nvm_size;

...

>  /**
> - * ice_read_sr_word - Reads Shadow RAM word and acquire NVM if necessary
> + * ice_read_sr_word - Reads Shadow RAM word
>   * @hw: pointer to the HW structure
>   * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
>   * @data: word read from the Shadow RAM
>   *
> - * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_word_aq.
> + * Reads one 16 bit word from the Shadow RAM using ice_read_sr_word_aq.
> + *
> + * The NVM lock is acquired and released internally by ice_read_flat_nvm()
> + * around the FW read, so this function must be called without the lock held.
> + *
> + * Return: zero on success, or a negative error code on failure.
>   */
>  int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
>  {
> -	int status;
> -
> -	status = ice_acquire_nvm(hw, ICE_RES_READ);
> -	if (!status) {
> -		status = ice_read_sr_word_aq(hw, offset, data);
> -		ice_release_nvm(hw);
> -	}
> -
> -	return status;
> +	return ice_read_sr_word_aq(hw, offset, data);

ice_read_sr_word() is now a wrapper - can we remove it and use
ice_read_sr_word_aq() directly?

>  }
>  
>  /**
> @@ -856,20 +876,18 @@ int ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *net
>  static int ice_discover_flash_size(struct ice_hw *hw)
>  {
>  	u32 min_size = 0, max_size = ICE_AQC_NVM_MAX_OFFSET + 1;
> -	int status;
> -
> -	status = ice_acquire_nvm(hw, ICE_RES_READ);
> -	if (status)
> -		return status;
> +	int status = 0;
>  
>  	while ((max_size - min_size) > 1) {
>  		u32 offset = (max_size + min_size) / 2;
> +		enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;

RCT

>  		u32 len = 1;
>  		u8 data;

---8<---

Thanks,
Marcin
