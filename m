Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FFC3B47D6
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217442; cv=none; b=ZXT786eKaaqMn00aDNvO2FuMByLjSqQs8c0EtoCqi1LT85TOitjB1fc/GtKKHq1k9r6fw4DpEBwszOv7cEitWvwAK6Ow7vuuBGlrbCSg9NO4+SLF6i61bESZsC+6HKc3U+paA4p9/tWEQJ6hzhF5VZ+xRE5/QYg7IjOa9itvNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217442; c=relaxed/simple;
	bh=VjgFV8db6btXlJMtpaJs6zrS/uJaw/zYgbIK73hXvps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy4UDq4PZoA9aC44ZuF47RKdIqhrA8t1o9eRrQzNJSqJYS297hH/OOsjQy1Tuv3G7jr07OCw15lPQUW1BmKHfIH1rYaPI1rAiSdA3qDX8HNp71VHO7yB9AMr3u5nxtjTm9Iy6doX1qi/lM5Ggas+PcWqIXwG1rgOlk/m8vTlY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBbJLO8I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBbJLO8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8BAC4CEF7;
	Fri,  3 Apr 2026 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775217442;
	bh=VjgFV8db6btXlJMtpaJs6zrS/uJaw/zYgbIK73hXvps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBbJLO8IEdoKJxNnlOMVdrMotFMVpBMsS6PHYVY+Ck2Yji9VjL59JSBa7d7rZQTmB
	 XsKVpS1GHyu9BcOwiDoTvPSrEJRLlYyhAdoioK3clbFjyIak1L7mGLFYubMHyfnuhN
	 UMSU8B4l0jC9RzJOSC1LLk4egMIVAkdlAPsZIF4YJfSo7LTYqbnBMl054qrhddHXJ2
	 JaVGQB0hfxOFBsSwBq1wIbFdACbzF0Z5Fr6MCAjA+Ru2t1qUABukP18Pm1fvdtCJuW
	 fec+B/ls6K8R/G20oNpmEEhKIxIFn4qFQ+DaSpUy+Dn+b+NPdswf/356zdtnR0R1YY
	 9Y3GUw5ZVDVuw==
Date: Fri, 3 Apr 2026 12:57:18 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: Re: [PATCH iwl-next] ice: fix FDIR CTRL VSI resource leak in
 ice_reset_all_vfs()
Message-ID: <20260403115255.GA60103@horms.kernel.org>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072236.129802-1-aleksandr.loktionov@intel.com>

On Fri, Mar 27, 2026 at 08:22:32AM +0100, Aleksandr Loktionov wrote:
> From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> 
> Resetting all VFs causes resource leak on VFs with FDIR filters
> enabled as CTRL VSIs are only invalidated and not freed. Fix by using
> ice_vf_ctrl_vsi_release() instead of ice_vf_ctrl_invalidate_vsi() which
> aligns behavior with the ice_reset_vf() function.
> 
> Reproduction:
>   echo 1 > /sys/class/net/$pf/device/sriov_numvfs
>   ethtool -N $vf flow-type ether proto 0x9000 action 0
>   echo 1 > /sys/class/net/$pf/device/reset
> 
> Fixes: da62c5ff9dcd ("ice: Add support for per VF ctrl VSI enabling")
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>
