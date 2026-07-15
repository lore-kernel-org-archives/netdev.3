Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2D376BC1
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140698; cv=none; b=RB5CWgAZW3/QAZMmnEMLhGuM1DLlY1Y8AhrvysB5bKo7Bz5ux9XG9UAx9SoCd6KAPtYsuYTbBPgqkxnegtCuMP79nBDzGFoYG/XZwp2eY4Lvifk6UoU4Gye98Ii1lSUH7AKpj7/1vsHAHJZODqef4+6PV4GlslhPWuqobBt2Kjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140698; c=relaxed/simple;
	bh=aHRKuYfdGA4je8MPf0OSACsXhQS/zkGHNXx557Obyuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixs4YNc4mPVXZjHmOpFdE9sPavpqtV5rt17G36wqE2cJi/ZfI0OI1saQXftTjIuEatv7ZH23KrbXsA+4z//AXw5IrG3GxTapDdB8knfVk3327IWB86mmmudKTbOp5/Hi/4tfVSECgUYcOJtFToGYpahDEFAcxA4pdKnlbF9QyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsTzqukM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsTzqukM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5051F00A3A;
	Wed, 15 Jul 2026 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784140688;
	bh=+bHEnrQXV1+bZYgHREYIU2VMLxynzms6JFzaI2d89eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FsTzqukMoNWOyJY6cPGdDbmlbRMk/gt+RDbN9VNBN8bMTnsKFPJl4rphu/6/U337f
	 4Jc3bmUibDTjRAWDmvsrLTeCUj2lX5uLHS+2cLcN9CM/z/v5dXZpHI2av/T3IOJand
	 ivItNZ0YqnYtWOKUIzXzW6VfeAHzznMwRFv6m4o1JayVIEB9V2gEVFqwfgzAPoIbzG
	 4d/iWF52RGjTYu5Owe8eNyOFRggYOHjklmvyoN/EUHrD88T1iuhou9amSqVFPqEp8s
	 qQ4EbH/1NZGDZdoYkzcmSbSxi2dCkBmrL7cToIoHBYW6Vy2FUHvdach/adafZRHJSz
	 h751TGgx8aaHQ==
Date: Wed, 15 Jul 2026 19:38:04 +0100
From: Simon Horman <horms@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
	eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] pds_core: reject component parameter in legacy
 firmware update
Message-ID: <20260715183804.GB95246@horms.kernel.org>
References: <20260708163649.128620-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708163649.128620-1-nikhil.rao@amd.com>

On Wed, Jul 08, 2026 at 04:36:49PM +0000, Nikhil P. Rao wrote:
> The legacy firmware update path does not support per-component updates.
> If a user specifies a component parameter with devlink flash, reject
> the request with -EOPNOTSUPP rather than silently ignoring the component
> parameter and flashing the entire firmware image.
> 
> Fixes: 49ce92fbee0b ("pds_core: add FW update feature to devlink")
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>

