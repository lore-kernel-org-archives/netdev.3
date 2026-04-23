Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E083770B;
	Thu, 23 Apr 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965185; cv=none; b=Ye4dIr8jmwfTsFg+LS1a4I/5MnYITktYUdxSu8lCiDArYEiaAv0dWSJoSbsH/gTMr/Ik9kLue+RD2ZaHbz8xjNSU0fDxBT06HRNhbqQ0ApDYK9xfjoDul271258FmxuZFREOoqJ+FNQFhrsy0/LLI+O0zVXpCp7dROFg45KZ2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965185; c=relaxed/simple;
	bh=CiUhr3+0FahWgH56+muDl88e4mdB/EH/RfWfs7RNfNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4fzuXTllmRydnim8CuPN4dqugeGn6+zcQS5AvSlDi7UyCxJaLW6iSg0cOcHBRDiIDBrhNAtRa8Pf40pmfK0hpm4xYYZX3FRxKQQ9vyPAHvPqAHFKLsdpjer61ux342JDCx1+vtS8BjJp9YS4H6PtYBfUUOOfvit9Ux7AAf9thA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvHl1IXn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvHl1IXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD0EC2BCAF;
	Thu, 23 Apr 2026 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965185;
	bh=CiUhr3+0FahWgH56+muDl88e4mdB/EH/RfWfs7RNfNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvHl1IXnWxfLgxhHWQRwVcIJ2M5m3ZcPETKdJ3KCJ3nD7Oc6Af+kVBV46E8mFfiBI
	 F6yCha9/rzkVB127KiS1JkpRsUH3NNmTIQnSzop6+5PuuI1VaBBQ8/ENU4RrbaSHkN
	 bw1EyDoF+5pP7BnOy8+ZukUIN5YF0bwJBUeJxBxqo8KqHgbBJEgmXxSqoqeghRkY+X
	 vqJR9lJJeUl6ZpHGFtU2qI+pHEatdk8+GYupK7setqfiCf+rGN8XtH1r1ZjuEqNwHs
	 dDOZ8KSHoNtfwYO6lqSttaz5N1f9ebCPBo63oNasY4iSM6ka5omznq2uAU2x6gIgx7
	 8m/X6QcIWDOWA==
Date: Thu, 23 Apr 2026 18:26:21 +0100
From: Simon Horman <horms@kernel.org>
To: Ernestas Kulik <ernestas.k@iconn-networks.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] llc: Return -EINPROGRESS from llc_ui_connect()
Message-ID: <20260423172621.GH900403@horms.kernel.org>
References: <20260415063457.1008868-1-ernestas.k@iconn-networks.com>
 <20260421060304.285419-1-ernestas.k@iconn-networks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421060304.285419-1-ernestas.k@iconn-networks.com>

On Tue, Apr 21, 2026 at 09:02:26AM +0300, Ernestas Kulik wrote:
> Given a zero sk_sndtimeo, llc_ui_connect() skips waiting for state
> change and returns 0, confusing userspace applications that will assume
> the socket is connected, making e.g. getpeername() calls error out.
> 
> More specifically, the issue was discovered in libcoap, where
> newly-added AF_LLC socket support was behaving differently from AF_INET
> connections due to EINPROGRESS handling being skipped.
> 
> Set rc to -EINPROGRESS if connect() would not block, akin to AF_INET
> sockets.
> 
> Signed-off-by: Ernestas Kulik <ernestas.k@iconn-networks.com>
> ---
> v2:
> - Add note about discovering the issue
> - Make rc assignment conditional
> v3:
> - Fix commit message after v2 changes

Reviewed-by: Simon Horman <horms@kernel.org>

