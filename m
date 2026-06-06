Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53722652D;
	Sat,  6 Jun 2026 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780710741; cv=none; b=WFGkB9i9vfwAaxfo6bipPKpgzlhkYSkO66o1GiVT1GdCiL3upY3ulDn5mujIsfKxJ6d0aQXeceajkxNF9KQKbJ8gzbAfkcmwSuNYsLcSBd0//cgOkH6cFuRXj+UE4KelxLb+SGCaQ/s6BDpczrfuixHyQ7m2GjN2NK5ugRtwxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780710741; c=relaxed/simple;
	bh=jXLqk39dh4GV1IdGH9oPuxNRXEMm3xhvcmetcpw2qVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViBKxfRGfqOqu8CbXYnDPAAe69aS0w9pOe/nVhkgTkWVzXkuxo5nWW9w2enM2z1KBfZ696MPls6xZ40TAPGy7+PN8VSjnMwjP22o0eDG5qP+9j+OXbqUX9Iy0ngKcTLUp6i0r/A6AEY20f6wiMLMfPuzcSsXn/1i0BtHsf2BJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgTrE6ib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgTrE6ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A459D1F00893;
	Sat,  6 Jun 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780710740;
	bh=/W0oQZsffucYpGt5qBYJAQJIKuz+GVFwN5UOc7b7C/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VgTrE6ibXZHllNn4+NZgaKEnvjF1SMvqamT8enxNXi8nBQPMuNEdrTlMzFsUJyhbu
	 HI5DAoIRu+Svjzq7pzJb45Q5Db+WuVc7uFCcepJmOljFn1UF/XxzhsfPk0Rq+YGjXg
	 ARd92imyLa7wpUP7CF7JfaVfwcEWcUOZi7ZXQlF58h/BgTx6xMu3uk8e+bmUTofMJJ
	 9VGewpzWormaaCKDK6ziXQ2ik9T96GWXcwZ1D3taDry5eWYfVqys4NDayt95q5HrP0
	 Be9qU0ep7P3NjP9iQBaH6cHYeJAt+ezdzjwexlyaW9efXnbmxKXSalCIsaV7L5xMej
	 udsnUN36AoPhQ==
Date: Fri, 5 Jun 2026 18:52:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: <edumazet@google.com>, <davem@davemloft.net>, <jiayuan.chen@linux.dev>,
 <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/sched: cls_flower: reject ETH_ADDRS match on
 devices without L2 header
Message-ID: <20260605185217.23858c32@kernel.org>
In-Reply-To: <20260603101135.1954370-1-yun.zhou@windriver.com>
References: <20260603101135.1954370-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 18:11:35 +0800 Yun Zhou wrote:
> Fix this at the source by preventing nonsensical filter configurations
> rather than adding bounds checks in the hot classification path.

That's obviously preferable but we'd need much more code to make it
work. The TC action blocks can be shared between arbitrary devices.
I'm kinda surprised we can even get to a real device from the block,
but either way I think the check you're adding is meaningless?
-- 
pw-bot: cr
