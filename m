Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94D3B42C3;
	Wed,  7 Oct 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791385898; cv=none; b=tMfrpx/4n4Mlfy1NkpzeTtI3T9lduj34HmfB3ekdHBLuTewkWuMml1j2ZgJ1Y/FFiVh5PzMIlD3fsAukV+uUbdImsd7BPmPCPC2JmzOL6x4fzWhVIVlo/BYnUQQxb8KvL3Iu/D9EDzlmK5/+2j5XSjJjt2nuHKpfMMijD8+gvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791385898; c=relaxed/simple;
	bh=2Tef9h0oLcPQ1yEjWBRUGUxYeuBBv4xPJNsTYm2XRjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSf9Mv+HMr2mIzJzyVrklKcuwe4u4APakICXBrl6p1wODbhf0jKCXfAw7sl45L1t2BZGPLJhlmQPR8nvx12Fv0EUNqk6VEqeFJWZbaXXs01bC2w0b9nRdHxmqOfFgW6N9VYIHhzJniZmyuwf8xMO9h+q9TC69A6Ra0t5YIvamLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlXgthFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlXgthFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1571F00893;
	Wed,  7 Oct 2026 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791385890;
	bh=7SiXP3A89mYIctTKF9NZJB+Cel5HhOPv+wm/AjXIxz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UlXgthFh+wZyRn0colHE4uL4qXhhpU3dnaYmStbnlDT+WzrrD7UhjNX9WIq3HFnRO
	 4QNJAeYgzh8htj+jm7ibqdyeM66JyvTUDWZv0/TSsI+aNnP1va3pCRJpYU65Dbz0No
	 T0zIFerl/WfJKDRXBZY9ajhwWn6R0D3B3Ko9LPE6i1u6rEmAHQ8iDxzqwvX3OJ93Yt
	 ZpBiRxncpAuX4iFjxB6kU99DyQ7UukIal92bX1QtFgCPut/Icw5W4wVd3JkgZKVWet
	 2GzImXgcRrFlTjvA57xVkMGqLipEugGE6it0As9P6eOPpItlC+Ark/EB/ToiYOXKbI
	 S/Lur4tjGvEtA==
Date: Wed, 7 Oct 2026 17:11:27 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Frank.Li@oss.nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank Li <Frank.Li@nxp.com>, Yicong Hui <yiconghui@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] net: ethernet: micrel: ks8842: use
 dmaengine_submit() instead of ->tx_submit()
Message-ID: <asZhHwzXU1sdk3TH@parshuram>
References: <20261002193022.168248-1-Frank.Li@oss.nxp.com>
 <20261007144334.GR83879@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007144334.GR83879@horms.kernel.org>

On 07-10-26, 15:43, Simon Horman wrote:
> On Fri, Oct 02, 2026 at 03:30:19PM -0400, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> > 
> > Replace direct dma_async_tx_descriptor->tx_submit() calls with the
> > proper dmaengine_submit() API wrapper.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Hi Frank,
> 
> Is there a back-story to this change?
> Is it part of something larger?

Yep, Frank has been fixing direct calls with wrappers with aim to
eventually start moving dmaengine guts internal and have a good
consumer/provider split of the engine and objects

> In face value it looks like a cleanup to an unmaintained driver.
> And if so, I'm not sure it's worth the churn.

-- 
~Vinod
