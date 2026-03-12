Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8463264DA;
	Thu, 12 Mar 2026 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274684; cv=none; b=hScM4otiqJM6V6y/Lb614uEd1Ecr0i9iCGQDX6qk/mkXrsTVgfsmgTeCK8f6BMBS8TfZuDck8UH5cmZiDq1X7o509tJhBtoBoHyYfX57X/2paAn/OUK3tOTMaFepKRIsy+GhLeHoEc5FAa0Kvt4Kqquy92pOSNAtigCDMtbHpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274684; c=relaxed/simple;
	bh=oXJuXH6/P2N7CrrDflKZ4v8a7t5AeEjyet4S/pnkMrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcOsetuBfWhrbOmQodClFm9UocoxB+X/9qVJqvGXkImbPzn7PX3mTBUKc8kBtyerI3AB1j1ziKVkHCw6l4Fh9vI9CkNwLTdj+oyHe6Y6qQM0w1Fwqt6FSVxkmV4NrkVhfW/m1ajCY728KG2tcKEIkOnLO8pMLKHQnT5EHQunGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGmCJQMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGmCJQMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB79C4CEF7;
	Thu, 12 Mar 2026 00:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773274684;
	bh=oXJuXH6/P2N7CrrDflKZ4v8a7t5AeEjyet4S/pnkMrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JGmCJQMJD12ELMVZ1zv02bQMMzNDtdvn2i3H/dcblSZpCmBwN3RUNccEHtxWUwFKS
	 qq1rGQ2ITh5HiWj/llPV1ILuitYvC71Y9Vs0v7x5awWU2KDhg+kr7Ge/QDbRW2tXI+
	 LQPUoc4EX5Q1Dq/26AaOYhxXHD3Zroy7iOSQcRPVTvpffoUOCjgqas7HAoDYjuk8tt
	 I0qSg5sIalmvbx4HAQsfsJqcZUYIk3VjpjPjIC10ME2GYnHqJqI5dWTShhh0m+3kvW
	 LKOjw8vtmJW+N0Um698pyINeBdAKLUa1hgmEp6L3dNAe8AciBenyS3RdXIh8lZe+C7
	 zpdRV1lfPljcw==
Date: Wed, 11 Mar 2026 17:18:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer
 flush frees with RCU
Message-ID: <20260311171802.2d8a4d45@kernel.org>
In-Reply-To: <cjiUUrQ73CJYWcTmlHQVSJPUJlxVg4kSZAnqkHKnU1SKeWoyy4F2qtIw7wuFRP9qz6Ra9ax0v2EQKsgdiRRUQnnuMweGbv-n08lgvXSTTG4=@1g4.org>
References: <20260309173450.538026-1-p@1g4.org>
	<20260310192842.3c3b2070@kernel.org>
	<cjiUUrQ73CJYWcTmlHQVSJPUJlxVg4kSZAnqkHKnU1SKeWoyy4F2qtIw7wuFRP9qz6Ra9ax0v2EQKsgdiRRUQnnuMweGbv-n08lgvXSTTG4=@1g4.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 14:04:54 +0000 Paul Moses wrote:
> The reported UAF was in the GET doit reader path.
> 
> GET doit enters rcu_read_lock(), then net_shaper_lookup() performs
> READ_ONCE(netdev->net_shaper_hierarchy) and walks the xarray locklessly.
> 
> GET dump reads the hierarchy pointer first, then enters rcu_read_lock()
> and uses xa_find() to walk the xarray.
> 
> Both paths rely on RCU to keep the hierarchy and its shapers valid during
> the lockless walk.

RCU was never intended to protect the whole hierarchy in shapers.
Only individual shapers inside the xarray.
The struct net_shaper_hierarchy is allocated lazily but it is never
freed during lifetime of the device, only once the device is dead.

The bug is that we are accessing a dead device.

(reminder: please quote what you're replying to correctly during ML
discussions)
