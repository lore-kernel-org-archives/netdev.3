Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620941;
	b=duN01wt2HgPNfcHpa4FpWgYiOFG26RFoz5Sz9WO4HYrL3MwNTDgIRLDvl3rBhDmy20LW
	 zmcGNtLe5dRDCH4YwKeDDU19XxNXrTh7YtlPXGZ1kIjFEbGC9qN9zZtZ3IdOvBdvibVkP
	 HykLvyWmqAEn+s1C3zO1UwvLf3L1Kee6Ns8qqGrsi3tWp2icce59ZC+p2DdBqOsAw8iuO
	 6q0ur0VMGrW2bc142pjC/Joqc01cUlBIvO/wLM7MX9yUj/jJ394jw9NOLJ+jMAXsSsObO
	 uhfmosDg07iiMyl3E2NV/Nq2ue5D8T79osA+3H3bx3ZbbN5Y7QQ5lLsExVUjOnBr9Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620941;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hZXlQtMRwJoMC0setD1vs2sojkITG2Hqi73DKlZte5o=;
	b=V3NhiIdGwgyfwVMppcFd9ZT613BtfsIBnFlOPKfNs18bR8O7Haz6nVa7OOL7mOkdulx6
	 gC+U/B3LmLJenFwNIqQ2t58JS1uMExX1I0J89ANxq6fzC67Ehkpc8rbG1gQU5HXPy/2US
	 rv7GNRcPp4W0TiPzP+aE0axmqzl/j50rZLLueuMQvPKcowgPoYbkml55MzUYEooA8Bv6A
	 y9LOg94AA52x1aqtB/PZUJdRm6CqBwKrXI5P1mgvuYQiliJt9H4yAzBGJDznZVhOuw9Uq
	 7s4XkyyHpVKsWGov9eGkqDUOLP1DDsjMpVlEXurOhYn6N4+4h8aYtcNpu3hWxl/0Eqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLTAQJ5+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02C606A32E;
	Mon,  2 Nov 2026 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLTAQJ5+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97661F00A17;
	Mon,  2 Nov 2026 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793620940;
	bh=hZXlQtMRwJoMC0setD1vs2sojkITG2Hqi73DKlZte5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iLTAQJ5+cbgBERicuwswMxfV34uUHNqP4YNFhMHyHkyXL7efA9aADqK18l3Ri8izG
	 g2ht+swiELcSL9tt3KGOqLKEgBYVmO74XdmrKhSSK84Pc5Zj/DKzRh0TBv+c9xZ37p
	 HAtLGZl4WRJ1kEcZDj4retfSUBs26eJRhyMUcPx6UcLGZ+bZ+4bNIqSnQI2YascR82
	 FyWClhjo16phQhJ0A895gEFhGY4V9HSD7wpvSt8Js8PlUoPtAkr5UXPgtvO48A2HIg
	 uK1MJlWrg1FlbIWlvsDq2zSoNluku7FcBeUXYx6+E5D82yhCbkk26tIKlYBUFhv0uK
	 SqE1Q2cEc+uBA==
Date: Mon, 2 Nov 2026 12:02:16 +0000
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net 1/2] devlink: param: do not dereference a missing
 param item
Message-ID: <20261102120216.GB257209@horms.kernel.org>
References: <20261030033332.3685172-1-xiaolinkui@126.com>
 <20261030033332.3685172-2-xiaolinkui@126.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030033332.3685172-2-xiaolinkui@126.com>

On Fri, Oct 30, 2026 at 11:33:31AM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> devl_param_value_changed() looks the param item up by id and only warns
> when the lookup fails. devlink_param_notify() is called with the result
> regardless, and devlink_nl_param_fill() dereferences param_item->param
> in its very first statement, so a driver that passes a param_id which is
> not registered on this instance turns the warning into a NULL pointer
> dereference.
> 
> Every other user of devlink_param_find_by_id() handles the NULL result:
> devlink_param_unregister() and devl_param_driverinit_value_set() return
> right after the same warning, devl_param_driverinit_value_get() returns
> -EINVAL. Do the same here so that a bogus param_id costs a warning
> instead of an oops.
> 
> Fixes: ea601e170988 ("devlink: Add devlink notifications support for params")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> Link: https://lore.kernel.org/all/20230126075838.1643665-5-jiri@resnulli.us/

Reviewed-by: Simon Horman <horms@kernel.org>

