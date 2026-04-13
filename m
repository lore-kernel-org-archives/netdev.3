Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93335CB6A
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095435; cv=none; b=rhGwiNp1gDMxC0YFoseBnRGF+mYn2yYLrpCla/w7bNu4cXp8E9zanwlJ8QF+7Fxm9jT78fTGgaXUEaX4HhwYF49sCpIE4+Rg6id9OrrrOkWvEwtAYw588KTj/Y7dVLSxuv1lqFo2Lce1lS2c30wlctKF22zt9VeB0qfkb2y9kBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095435; c=relaxed/simple;
	bh=GbXCe4AZJ6wicsCGLe6ipRR64a2u6eUyDZXiLtFO9C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4QRqtzSiYl30pFxo85yP+Ok5B4hsVCK9nRmAQLJg3J8o9+IVY3EjRoO/nXpmHUulCwhkLqsLsDC5AeqDhKJ4EFW2wq4JW83Kzd396ZXuxFsE0fU5CJ2w59q1KW4d/pC3JENDN8e+690DnrWuk7AYrBsWXwZmxCou4EQdBRZmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcB1Q6HF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcB1Q6HF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12803C2BCAF;
	Mon, 13 Apr 2026 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776095434;
	bh=GbXCe4AZJ6wicsCGLe6ipRR64a2u6eUyDZXiLtFO9C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcB1Q6HFzfWN5mQxagsPV2Twyxs6kE63fmDwruq2yPhAcNZiuAf2K2qPW9czREmRs
	 Yd+VIsJDMzpcMDxZhgG8jyAcCd0YS0+ty7nYe9ydr+oSIAIJHVRpYNuc5+1F7ebXbv
	 gJDsDqxleYITPzEgwf73UU+NyFTJd4nO74W2hpqcoMyZy0XosS7MmcKEgR3fymJjGq
	 aM/8nzbiip+XIu1TGO/sZjameXp8ejJp0qRTacDbVim6HoEvjan/lmtwQb5xOGBuj5
	 ZW3JoaLjjUFC4ileF3rqK8UgjxTrV7Q8vNHuwK42on9XK2lc8047j76ONQMaJB6+7k
	 2v3clHkAsXK0Q==
Date: Mon, 13 Apr 2026 16:50:30 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH iwl-next v2] igb: use ktime_get_real helpers in
 igb_ptp_reset()
Message-ID: <20260413155030.GS469338@kernel.org>
References: <20260409075523.3728506-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409075523.3728506-1-aleksandr.loktionov@intel.com>

On Thu, Apr 09, 2026 at 09:55:23AM +0200, Aleksandr Loktionov wrote:
> Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> ktime_get_real_ns() and ktime_to_timespec64(ktime_get_real()) with
> ktime_get_real_ts64() in igb_ptp_reset().  Using the combined helpers
> makes the intent clearer.
> 
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

