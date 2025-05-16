Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533223BCFD
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398436; cv=none; b=An3/Vky0LDtYYzPzXazVWeFO89ojHwuq4nmFKA2FR5mHmxtPidwUIVVbeDEZ94EDFB+eAj4voCwXAF8GhT8J7po1FBH2nd/oIxyjWRQP0ImVa6CX5BqdfDfHmQmT04xvEugArx5aST6f0k5ZbK+JKk/DNOtCNI0cmSDHuZLNHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398436; c=relaxed/simple;
	bh=XG/Rv0GxCqWfPJpWGHIom+iVku0hii+lE4hwd7p6DXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp1p+PfVlffGOL4F54LkRnu43Y7eFqBVHl5nq1LjEYerFwWTHGfcCC/Xp1Mdn9SCL3kTmGqcRg195M2fi2mZmq5To1x15VemWAG4oY8zvu2PL89Fp/W7qj8uvPXgo3vkmwr8zkaQ+OUzFImwffZ9RMOtmxgZezcIz249tmd2woQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVY9Ob4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVY9Ob4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD500C4CEE4;
	Fri, 16 May 2025 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747398435;
	bh=XG/Rv0GxCqWfPJpWGHIom+iVku0hii+lE4hwd7p6DXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVY9Ob4r0pI4KeT4eN1KS8ge5DbBBs49PcON3OnZmswbKFSGgrSLkZdc01oHlMbv4
	 IbDoZ5onhFVYHmiPDIef9WZDgKP3O7NfZOFqRtJc1HqHiEAdAo0I14aoMwW36yElD7
	 3HV1PBFvQIfysFPVlkCOZEDPihMvv3I6uzRcCXlDJlcTPFttlh/HgBc3era/UGudEH
	 IhsHJlM0JTOVXmkmQCr5opPgATJb5e1u1az6m3Vipg2LfN6SUTHlee5o6orfLshCHH
	 UhvUP3atCDU9hif8fCBjO2rGd2u1WQwOSi74R+VmRU8P+e80Y5a/7peFWAil95cX9C
	 L1NGSWjMAp9jw==
Date: Fri, 16 May 2025 13:27:11 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH iwl-next 5/5] i40e: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250516122711.GD3339421@horms.kernel.org>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-6-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513101132.328235-6-vladimir.oltean@nxp.com>

On Tue, May 13, 2025 at 01:11:32PM +0300, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the Intel i40e driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl() path
> completely.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>

