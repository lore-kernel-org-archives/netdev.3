Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784CB39BFF8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265797; cv=none; b=pvR0btee7CJO9K8GU/57v4v1mXa2XgaT1nPeO0SrXMZHVnCnOuL5aUa2sGAIrWp3WNNp9deyAtafhjDRRH+8cCvrNmZCQ8Oq+sDFbcU58+j+da8mS2YC/wg4aPHo6reV3EnxqvgOYC1l1tGRQ2lT2D+oq/JwWwUsqRszfTWFRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265797; c=relaxed/simple;
	bh=S7k9208LS8xDosIa/qVz7IGt9xNmACyFePN52jb1esA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQcJmMryrLHtkljTRHVWWXM4bsmd1tuPlTYPhvta5tEuuTQHU3aHSUhB5rFLosiPDHoSckcHX7xPF3+Nu6jFnRX7taLojQxRMn/FvgIMGQh+op84zXiJz1AauKS3Utm1ZNepKQDNljV0VgpTEi3KeDF6iySNLu50uq/X6Ef0Ss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+iyo8UK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+iyo8UK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8061F000E9;
	Fri, 12 Jun 2026 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781265792;
	bh=5s0sLbTVEJUqmAbNC363C2J0ZEHwzh9hQIqzMh8rB1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S+iyo8UKbkRy9wCXXcVHzh96dLpwbNhhb5qQbii6OPPoyHi3AbavOPqf51iQirqCB
	 FRSxVJBSHxEIXVA2wmqneS+kCCASFwDDPLrk/BfvVV6xr7YELKgAesYb5OUvXSlCBB
	 Eq46CoM5zY6tI3843j7JB9W0+5Xs2SiS7C3e+K02SdUHB+gVJHrqoHdPC0r/2BK8pw
	 a7GXWJe4OZAEJsDb91FUBkMSPyXtjYuk/HnvsTLDfEv0PNg/DcTKVCst03dZJwBwKr
	 tvlqlRqD+F1A3jwIRg7AsSDi1aHKtQDCAl/dzaV2iNqFtPYbLDIGN8ttBEblfh5I5p
	 KnJ++qx2tS8BQ==
Date: Fri, 12 Jun 2026 13:03:09 +0100
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2026-06-09 (idpf, ixgbe, igc)
Message-ID: <20260612120309.GA671640@horms.kernel.org>
References: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>

On Tue, Jun 09, 2026 at 10:24:53AM -0700, Tony Nguyen wrote:
> Przemyslaw adds needed padding to idpf PTP structures to match firmware
> expectations.
> 
> Larysa bypasses XPS configuration on XDP queues for ixgbe.
> 
> Khai Wen corrects offset into packet buffer when handling for frame
> preemption on igc.

Hi Tony, Przemyslaw, and KhaiWenTan,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/

I would appreciate it if you could look over the AI-generated review of
patches 1 and 3.
