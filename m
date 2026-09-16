Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB24534AC
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566848; cv=none; b=erojXiQWySIt4BOiWCsAg0MDRLJrKQMwEi/CR6J4tFTZWY47Ee+u9rm4MetNjz29Fvc8m3eDyEk3+imK/9cguvDhCLbn1FA8cKeQ6IiqqzUB1AEYIoaqSxsZcAA+y4qbOj4cwu6/5HGVh2wL/85C9CyLyiWp1ue5BJqOcKFJFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566848; c=relaxed/simple;
	bh=xXPMzTivDyJyiGQ/g83hUg4bBoMGbHu/Z5c2HLCvhR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkrOmT/W+vRF8TLH3MSsXq8EhKqdps2FDfiwW5AltdxuaHVQh89uMcwZ4BIBgIT6wT0yy1vwu0N2RkrJGV9KNXeCmZgXe0zP4wtsSwfXsJ42TRTFQONTvqPXoPRgx+FytHqJmMnm0MMsafzqpJ/TDF796xxVMaitWqZUJZveRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4YJsVY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4YJsVY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB7B1F000FF;
	Wed, 16 Sep 2026 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566842;
	bh=T9gdB9pKTrrQAGFKq8sKZdE4OBE6MPiU4pD/VQNGsl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y4YJsVY3AfN3egOYzaErN6dchwdXROQmTBk6VUcq1ev0N6iulsL0ROP3/rLHZgmYd
	 oRa3iFjuhfKHT9QrNTulS1CLCezu7Mf+wrQyft1zu5sMQXnyr+gpQCtaMcLnuwrGto
	 0S3aQ1V2cur/qTlvePBMXZ/4/EA5/DKZHy7YicY+A3JyJplpeNPcnAFS5Jj1rv+DKp
	 hMWiE2ORab3lGeg3PXQ0fC7H8w/jpG5eDB1ui4eFsqZLnzYC0fmQ5J3x0VthTqv3n4
	 ITFl6NsPeqT0u9fMCrja3qjULZuDbST+XA6bxqjQnwfC5VorGcclIfPgofNUXMrbo7
	 DYdlBLDCn+Tog==
Date: Wed, 16 Sep 2026 14:53:58 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] ice: fix LLDP AQ filter fallback not working
 on E82x and E830 hardware
Message-ID: <20260916135358.GJ51261@horms.kernel.org>
References: <20260915125525.3975646-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125525.3975646-1-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:25PM +0200, Aleksandr Loktionov wrote:
> Commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> necessary") restructured ice_vsi_cfg_sw_lldp() to first attempt a
> generic ethernet Rx filter and, on failure, fall back to the specialized
> LLDP filter control AQ command (0x0A0A) via ice_lldp_fltr_add_remove().
> This fallback is gated by ice_fw_supports_lldp_fltr_ctrl(), which only
> accepted E810, causing two distinct omissions.
> 
> E82x (ICE_MAC_GENERIC, e.g. E822/E823) support the same LLDP filter
> control AQ command with the same minimum firmware API version as E810
> (>= 1.7.1). On E82x systems where the generic ethernet LLDP Rx filter
> cannot be added, the AQ fallback silently returns -EOPNOTSUPP and the
> port is left with no LLDP Rx filter.
> 
> E830 has been supported since kernel 6.9 and implements the same AQ
> command but requires a higher minimum API version (>= 1.7.11). Starting
> with NVM 1.2 / FW 7.9.1, the generic ethernet LLDP Rx filter path is
> blocked on E830, making the AQ fallback the only viable option. With
> ice_fw_supports_lldp_fltr_ctrl() returning false for E830, no LLDP Rx
> filter is installed after a firmware-update-triggered reset (e.g. NVM
> 1.1->1.2 on an E830-CC in HPE DL380 Gen11), and the interface stays
> link-down with complete loss of network connectivity.
> 
> Replace the single-type if-chain with a switch on hw->mac_type so each
> family's version requirement is explicit. E810 and E82x share the 1.7.1
> constants; E830 gets its own 1.7.11 constants. The default branch returns
> false, covering any future MAC type that does not implement the command.
> 
> Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2: rewrite as a single combined patch using a switch on
> hw->mac_type, instead of two separate patches (E82x fix, then a
> follow-up E830 fix layered on top).

Reviewed-by: Simon Horman <horms@kernel.org>

