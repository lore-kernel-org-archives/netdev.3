Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2C1F4704;
	Tue, 17 Dec 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445889; cv=none; b=mCL3PqPbRAkhtAvpsz3oEctjYJR2CXCtpBSKiUppuXq8ZFt+k//wCDERWkJ6jgiL9065cnUtSaTfm1wtgEi4eQCetqX6V8XVTh/uNvEfm8Lm40hg+R9C+zyjSIE/aJn5TEWeHdFDGzz7T607L67KbacQ7YqfRb/1e2tkZAg8aRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445889; c=relaxed/simple;
	bh=vD3zrbD2evPWvBGabFn+Ktq2P5o6KsUFH7FMZshwqrI=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVppoLyESBsEui8KHVXHuT+/6p050u5vqwZVHy9JW2q79iClZgvX1gsp3vQpEJGPghzfm5hv+lyw/kpTGTGhBtFgzpBR/pFP8zqYaVTe0CTXsCRdeOrYdNl+opS1s3arFOdCdZSgL62h0uSbe4BCvLVxzrR0v3jyKhEfUmqdl7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DljYsuea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DljYsuea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B734C4CED3;
	Tue, 17 Dec 2024 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734445889;
	bh=vD3zrbD2evPWvBGabFn+Ktq2P5o6KsUFH7FMZshwqrI=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=DljYsueauFj+WJtYVPv5HbfcfkfwXPdYZSDwtZvMn12IM/vfyShmcaK70gqu7Oek8
	 tt8vFZ+js7VPq7WmiVsRIR1igNrxSL+9/5lgp3VAr9fSb3Hbmf7Ag1HudGFa/BMtwu
	 St3E0a8HzRjkeUjAipUydld/2eqRU0kbPOBXcneVTuQW8i8HStY4XcJFKnRMhgTb+w
	 +aePJ0kXIfy0exISypSTusgGtNxKafBXsrdVThxvhpMWPBrtRiUdQLYLLnfHWkQ53D
	 CEBNJ0tb2YkorujQAYZIjYV6Fkl1pMvZpc1f8d83a6Qn74sJG2HavGjaquiudMfSvD
	 LmbxXUsKYDZBA==
Date: Tue, 17 Dec 2024 06:31:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] netdev call - Dec 17th
Message-ID: <20241217063128.6356b9f0@kernel.org>
In-Reply-To: <20241216082150.34921299@kernel.org>
References: <20241216082150.34921299@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 08:21:50 -0800 Jakub Kicinski wrote:
> Please speak up if there are any topics that need to be discussed
> tomorrow, I don't have any. If nobody speaks up the call will be
> canceled.

No topics, so canceling this one and the next one since it falls on 
New Year's Eve.
