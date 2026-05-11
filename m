Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38ED3FD15C
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513430; cv=none; b=AcmvfcYI1X+QdW643YeEPWR4T0oMuuQUMBUg7r/1afHuXe4wMM9u4ydZqgyTt4eqETVsT0GCiJeAlOr8DOteuTUv20fRVI81IVAruth8pn7Y4UQbvhsFLA5KPVn9jV9Tvdpxm55mIyu6fBzbv1ZVSLujvHN/JLcVRY7SGu1oVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513430; c=relaxed/simple;
	bh=4SFwl8HVv5AMthvQ+awcRUJU0OPDPhHPyYcwUIJe6E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViK/AromTVYV6hLMjl336fjdLV05vXbFO5Pw52fTlVNcD6q3+cIOo4Q8em1L1AZGiFft071sTSCqmq2EqUCl6rD8XHXejU1Ik9/JOGS/ClOJtbfRnwRjOLzc938DMoawtdpB0l0qcSVQzy8bSaHnQ/0iC5eabQq4/COE+cUJwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOko1oHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOko1oHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A495C2BCB0;
	Mon, 11 May 2026 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778513429;
	bh=4SFwl8HVv5AMthvQ+awcRUJU0OPDPhHPyYcwUIJe6E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOko1oHEK/J2Orn3jwKYrgaDwO7Q4rcya6ehxtm9zSqyvneEqfH3/KEtz0p/dAp6a
	 9ejKwAYEzh8Ai6Fsf6n07UAnv5eCCvcQCJqGSY9dJK3GYhHPq2D+wJWG/ur0CLSgez
	 AOpxUJnbXX7vdTf2zBL55xBrWD4E2G+R236oSs2TjgvkuM+29j4smkkFazO3Nu7Bm0
	 QmKOcUKEjCfcs8jyW3mprJV3pxx/9MpmMo1PnXjgP78t2Ld1HQdME73tLVsgiGQMGh
	 xRJdPA4vcGNMvL72+uk1tOSU618lHXwPRVosqfsCmcdiQ2ux07olfh9Gtir9eyF+ZG
	 5zpTsIHddxtLA==
Date: Mon, 11 May 2026 16:30:25 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 4/8] ixgbe: increase SECRX_RDY polling frequency
 in ixgbe_disable_rx_buff_generic
Message-ID: <20260511153025.GB27589@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508031226.3601800-5-aleksandr.loktionov@intel.com>

On Fri, May 08, 2026 at 05:12:22AM +0200, Aleksandr Loktionov wrote:
> From: Maciej Rabeda <maciej.rabeda@intel.com>
> 
> ixgbe_disable_rx_buff_generic polls for SECRX_RDY with 40 iterations
> and a 1000 us (1 ms) busy-wait per iteration via udelay(), giving an
> exact total wait of 40 ms.  On fast hardware the security block is
> typically ready well under 1 ms, so each iteration wastes up to
> 999 us of stalled initialization time.
> 
> Replace udelay(1000) with usleep_range(10, 20) and raise the iteration
> limit to 4000.  Because usleep_range(min, max) is guaranteed to sleep
> at least 'min' microseconds, 4000 * 10 us preserves the original 40 ms
> minimum wait before timeout.  The worst-case is now ~80 ms (4000 * 20
> us) plus scheduler latency, which is acceptable since SECRX_RDY
> failing to assert is a non-fatal informational condition (the function
> just logs a debug message).
> 
> On platforms where SECRX_RDY asserts quickly this reduces the typical
> stall from up to ~1 ms per iteration to ~10-20 us.  The function is
> called only from process context, so usleep_range is appropriate.
> 
> Signed-off-by: Maciej Rabeda <maciej.rabeda@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR: There is an AI-generated review of this patch available on sashiko.dev

     It points out that scheduler delays can, in some cases, be
     large, and thus the theoretical worst case can be somewhat
     significantly than 80ms.

     If you spin a v2 for some other reason you may want to update
     the wording of the commit message. But I am fine with things as-is
     because the focus of this change is on improving the best case.
