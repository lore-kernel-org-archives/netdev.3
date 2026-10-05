Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036231578E;
	Mon,  5 Oct 2026 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244628; cv=none; b=msa9ud8fAwaxauKizIFPBVl9L2fFcaXk3Kjd7nH9bqIf0V9XBLH7u53Z07YbBTyBRoyIexPfCgw9e+04Ai48zGRh1i20mPH44m5E1RlwBYbwXdOp3kpeiDmKFPekJJecemnSNEUKH1esXSN3cLXqvTW7GvNuQdODfoRMQCasSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244628; c=relaxed/simple;
	bh=mzvhT9VdOoeMNhMFeiJNMOXX2f9Ig+fN7V6ip3R4JEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbfcB5wmzDDhkuwfaT75V0crQll6CA2aQ6BI2cZaDHyQtcqlPv5xYIlwEUiT0sMotKND6TJc0EgdH7FLaFveSaV2c3C4DHp0O7qq5yIHgfJ7GcWjcu1BPm3sCyXoFOxvMg/dY5iAvkdzL+iTEzqR524mkw+BM4zCWI0YWDvEnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzbE3kSU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzbE3kSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE33E1F000FF;
	Mon,  5 Oct 2026 23:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791244627;
	bh=RZOVUE7Q/MJisn72GAMtXr4LMb0TYLk7EzW1SDxZ08w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jzbE3kSUhP+o33M/QW75DfDK8mt3EDnp4+9EHc4rcrBrvFQFgtRlqbNLOUIoAedNI
	 1GrFuQM1eMmdZ+OVFmO9oTEPacTZfyyXNnqLKw8GOpidCFyeD5KkioiER1hMawgWuQ
	 L2KVckHtSUGQ7vKeD8OhynoCfHKxF612TfyQWCGoBGrla6MjXKjlE9cR8BFjqvHTa9
	 TN2N510PbIj5tUJyjXCRuPztZimvVfl6HqH5M31/h9tzMnxpTYq0cJbg6FPeyXHnc3
	 XhTlk8MtxE8kLa6UPuF2EwkP1mew5Y/W11/o4e085Xdijm21LTldZjfmiKlSbLkoTD
	 qmgPcElb5CG/g==
Date: Mon, 5 Oct 2026 16:57:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] ipv6: fix address publication races with
 addrconf_ifdown
Message-ID: <20261005165706.6ca89a76@kernel.org>
In-Reply-To: <20261004183639.3773498-1-4ncienth@gmail.com>
References: <20261004183639.3773498-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 03:36:37 +0900 Daehyeon Ko wrote:
> The first patch serializes address publication with device teardown by
> taking idev->lock before the address hash lock, as suggested by Ido. It
> rechecks both dead and disable_ipv6 before publishing.

Please slow down. We don't want to see more than 10 outstanding patches
from random "LLM people" in the review queue. Please look at your
outstanding patches here:
https://patchwork.kernel.org/project/netdevbpf/list/?submitter=223024
