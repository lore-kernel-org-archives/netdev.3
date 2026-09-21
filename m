Received: from mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C43793D2
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982827; cv=none; b=IYGVHmbBCJo3NoPn+sCS4NZBmZTGqctnPshdlV/w6PJs2FaFKHjC8VpZ3ryx6GzQvhAWsaBVHDwrZlZh+pY9jlgD6qa8p6ZZEPQBM2XxoKDyRIgkojmJM0OAUtJ7gMara5pxTZr678ksaTzk7dkgECftNcbznugkcp0OI0O8YYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982827; c=relaxed/simple;
	bh=JniXzAKE9lpfUkjCAlN/VixjQ/mB0ZFDM8/tNkDSlNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7I9qxvOKx4aBWBeRQ3SN5R7smiJGao4v6RLhthN46y7pLjL9zfMu4FzeAky+sNiZ0L2wf/4AldiElesIKNFvQGQa7dgLkmntgOgbj/h6/jQBaJPtuRoiI3t8oOGA0CNiRmn6TYXLpmqKWQryTW8aPH/z69pUrEoTCnrcBIMqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R8biPaaa; arc=none smtp.client-ip=95.215.58.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R8biPaaa"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JniXzAKE9lpfUkjCAlN/VixjQ/mB0ZFDM8/tNkDSlNg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982824; v=1; x=1790587624;
 b=R8biPaaa9MhhaQBKatfYtizr7gXq6775Lw62rL2rd+EJ7vGe2mzuicT9pJnZj/zn3q/rtBDs
 c9XyLkL5fZst0WjmBDL9t9IZlpYZpwihIkUDMUW1c/zEkgJ1V8aJaq1CU93kBKSqzHETtbXlbbY
 fYgFUpr7/pvo7pBiH3BvQZ7I=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id cc5d6d6b42a8116f;
	Mon, 21 Sep 2026 09:27:04 +0000
X-Mizu-Trace-ID: cc5d6d6b42a8116f
X-Migadu-Flow: FLOW_OUT
Date: Mon, 21 Sep 2026 17:26:53 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, donald.hunter@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	liuhangbin@kylinos.cn
Subject: Re: [PATCH net-next 4/6] netlink: specs: rt-route: describe lwtunnel
 IP options
Message-ID: <arD4XbtvSt-bo_8a@fedora>
References: <20260917-ynl_rt_encap-v1-4-fbbe6e680571@kylinos.cn>
 <178997269588.2160803.17770495644903940757@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178997269588.2160803.17770495644903940757@kernel.org>

On Mon, Sep 21, 2026 at 06:38:15AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] New `lwtunnel-ip-opt-erspan.index` attribute in
>   Documentation/netlink/specs/rt-route.yaml is declared as host-order…
> - [Medium] The new `lwtunnel-ip-opts` / `lwtunnel-ip-opt-geneve` sets
>   cannot represent multi-option Geneve tunnels.

Thanks, this is a new inspire. I will update it in my v3 patch and post 1
week later to make sure v2 have enough reviews.

Hangbin
