Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DAEEC0;
	Wed, 11 Mar 2026 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196124; cv=none; b=Lpk1NznNJJPma7/9fl22/CSLsKf2Jf6gJZtohqXZx6J9HmpnPrTPKmWxSYjRQf+UxTBa/HPj0jw+8QZStkYNrLjUtfK6wP4jp4qnQVQv88IEQVpfIhErrH37KqZ/MCz7tAFaoZzqH2YwR9hw9xu2hQjYCXlj5cTYvy1I1e8eJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196124; c=relaxed/simple;
	bh=kHUhOKfm6EhYoR1ZSmXpxs6iSlwDqVibrXnaqUm+ZyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsRj9hDXKjEYIoqq7fnxwk10kAWqXeMOalONiZ5Pjf2LkmHLabOqLCx4QlKEUD9wHbhvdYKLIK6WqZDyFRIG7AwAhvK6KPSx5/24q+xhlP7ADzGpotOFZIE7IDHhxdPBPSjXAR8bTwu+R3gG77zR7YihryyO3MEAemkCnkQ6Scs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc9p90vr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc9p90vr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CE3C2BC87;
	Wed, 11 Mar 2026 02:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773196123;
	bh=kHUhOKfm6EhYoR1ZSmXpxs6iSlwDqVibrXnaqUm+ZyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qc9p90vrsxl2S2oOvzVknpXAtSV9SDR2xko1hMCnji/mxbS7k5EHWuejElmAT4PFH
	 2iIR4laFcFzzNGjPqZcNd9G0OEf+eoHbCUpA3Ekh3O26MqJqlEVHEn6p/57oukFLjq
	 K/fkVt81U84hfgM8qLpf/xb7NTuUEK8I+VTH+DmxEpr2Q0+eoLzefqFK/SNNp9xZ2j
	 2Yh6WGbyrfnMEb722cNDVmYh8JlUMs4AnR1k7AsfvTv7HUpdusl5Pep35rd5nDWjt2
	 fAg/t8nisHq08xsBQoJK4/QXE5rGnSMKVDitlIO5k4/vXJYOFwM/KcYPKQdGaKTLKU
	 8tWix0Wrm75UQ==
Date: Tue, 10 Mar 2026 19:28:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer
 flush frees with RCU
Message-ID: <20260310192842.3c3b2070@kernel.org>
In-Reply-To: <20260309173450.538026-1-p@1g4.org>
References: <20260309173450.538026-1-p@1g4.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Mar 2026 17:35:06 +0000 Paul Moses wrote:
> net_shaper_lookup() and the GET dump path traverse shaper state
> under rcu_read_lock() without taking the shaper lock. During
> teardown, net_shaper_flush() freed both the shapers and the
> hierarchy with kfree(), but netdev->net_shaper_hierarchy still
> pointed at the freed hierarchy.
> 
> This lets GET readers race netdevice teardown and walk freed
> xarray state or freed shaper objects.
> 
> Detach the hierarchy pointer from the netdevice under the
> shaper lock before teardown and switch the shaper and hierarchy
> frees in flush to kfree_rcu().

This is not the right fix. The shaper hierarchy as a while is not under
RCU. The problem is that we take a ref on netdev and then lock it,
assuming that it's still alive. But it may have gotten unregistered in
the meantime. The correct fix is to check that the netdev is still
alive after we lock the binding or take RCU from the Netlink side.

I'll take patch 2 it looks obviously correct.
