Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12076331A77
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699615; cv=none; b=jW2OKrnTxPSl8peJMcr9AhuCaO4OexnB5Ww4nJ/5IPn2/PbD5szYR8dk/QTqVCStjiEXBc40C11lx4yPYoShR65oyEPGPuoiF44+6MlvYYpx3yipUbJQ6fTISFWlFvfu1wPeasz17Feb7R7bCFiZgZXs4pgtFSnb2r9Vl7VxD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699615; c=relaxed/simple;
	bh=+DeC3NJ9949CsEjMNzlTZbIE2sxqoybq0YGyXABSEXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3g37rtZk/13SecJn3UMXmjzk1cQYMwZ3/2vYbte5C9axxBp5dGisS7t5HxpgJIthTkqgfK3ug467WbcGF0IVNGK8fYPsRHB2btQXsl3RMvF14Vp39QHBB4YPEy/6a5/7ide2mphQOkI86V6E1ywZy80QfcVJWD2mcnBYvVqjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sx9PmYZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sx9PmYZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC70C19425;
	Mon, 20 Apr 2026 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699614;
	bh=+DeC3NJ9949CsEjMNzlTZbIE2sxqoybq0YGyXABSEXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sx9PmYZBn+xekVj3wilMLpVG2kR/QHchoIukIJWWhTK6RklK+XBbfbhtzfDxtFW3c
	 kAtYRDQQyBR+iLTk3yGSPjjlVkzjTndg/4EfQ9TrskYptv/GHvoSoJl7awGTdZ4L3P
	 M3gSFU5zLYAN87YyriBPUjkrf0uVNcwon/fm8A3PQ1ZrpUeHmzIR+2EkuPKO4s3JBA
	 IG0VuX3sZNqLQDMOdjw9oDUecCANPYV6uxOFcP6sn/v6QYpFOXqs9HaGFQf2NV6dWM
	 v35u2GWBfLOUJj8edot6n5JW6jvmT2qW/7kAkm5hAPZmcI9ioAp/XGWWW37RwHS7TE
	 E5Vm/5tuasWGQ==
Date: Mon, 20 Apr 2026 16:40:10 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: Re: [PATCH iwl-net 1/4] ice: fix asymmetric pause negotiation
 reporting in ethtool
Message-ID: <20260420154010.GS280379@horms.kernel.org>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
 <20260417062954.1241900-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417062954.1241900-2-aleksandr.loktionov@intel.com>

On Fri, Apr 17, 2026 at 08:29:51AM +0200, Aleksandr Loktionov wrote:
> From: Tomasz Lichwala <tomasz.lichwala@intel.com>
> 
> Add Asym_Pause to the supported link modes so that asymmetric pause
> negotiation is properly reported via ethtool. Without Asym_Pause in
> the supported modes, 'ethtool -a' incorrectly shows 'RX/TX negotiated: off'
> for asymmetric pause configurations, even when pause is properly
> negotiated and functional at the hardware level.
> 
> Fixes: 5a056cd7ead2 ("ice: add lp_advertising flow control support")
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

