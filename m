Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E5220F38
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760952; cv=none; b=sZsMwiKXUkCjD8gDRZnGRxboU899RjDvD1Ks/FUcVxyliCoIJtHQoSog+zuiLqzVjk9FqTXvGBSApfN/LFJEfsdfdrD4chq5CARr/50/9j8icA8JLZrMv2u76Z6lR21t54ejpzlJ/6jmVh+E8oJrtbC5dKUzc4UZDk65V/vKlw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760952; c=relaxed/simple;
	bh=jn94j8Dkkq0L10+W+0ic6S6XOyF6N1Tgz5rSZklKZgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mstZUi0k31SsezBc9imhmJ+I+jxZl2YLgNBQFy/fhmYgcmYNIoA2iZH/cm3T89P9rYvI0Ltb6T89bvBEYNsGNmEmVRNQ9Z2qoG8z96yxzRzLiHXM6KDMGZW7Nan382gpZJPzKdjSHEWEDXUHQJ7A1rWg2SdGzAgXGgAX0dA3nlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpxkAVfH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpxkAVfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5EBC4CEF7;
	Tue, 17 Mar 2026 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773760952;
	bh=jn94j8Dkkq0L10+W+0ic6S6XOyF6N1Tgz5rSZklKZgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpxkAVfHsRQ7VbIjqgvzNYAz0KfYl8xKx7LQgSAdG6bfg0S2DLv2C21h7MSWxs6Ms
	 NdYuUbUerDz4xA5SYt3+nh6jql9HocTiwF7O5kfB8e0XbGh1JcKylohkyd8gYxungX
	 XMbagSos7JagXYt7VlnyPrV9lUOjhE+a2DQEueaUrTwt8dgh22a8Oyw2Y0b3EgAJ1y
	 REt4CUHveSYbslhMvL4jGWW5KCjPTPB8gnACPFnR1xs6QQmJ/9hJCAoZoJGWEWbWxT
	 3TSFm4i+cnMMFuTkUGp6zeT8lZiHLyQlk5vqjUn2p5FFCFN7chQ0kDbO1JIg+IQkqu
	 FJGFFXougJEgw==
Date: Tue, 17 Mar 2026 15:22:28 +0000
From: Simon Horman <horms@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	justin.iurman@uliege.be, willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v9 08/10] test: Add proto_nums.py in networking
 selftests
Message-ID: <20260317152228.GC1710951@horms.kernel.org>
References: <20260314175124.47010-1-tom@herbertland.com>
 <20260314175124.47010-9-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314175124.47010-9-tom@herbertland.com>

On Sat, Mar 14, 2026 at 10:51:22AM -0700, Tom Herbert wrote:
> Add proto_nums.py that contains various python definitions of
> common protocol constants
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  tools/testing/selftests/net/proto_nums.py | 231 ++++++++++++++++++++++

Hi Tom,

I think this new file needs to be added to
tools/testing/selftests/net/Makefile

Likewise for patches 9/10 and 10/10.

...
