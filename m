Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79F2D73B6
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694602; cv=none; b=N6hTraIWgUhWTkefyqZzFT2R4Y/Trpc4dpfsmB/SeNvdpU9dDs99kCP4oLDcB7PltUjui6/fg2OWiYcJygBsHNqpj1FIXd6MHiKC9P/RYygR2XiRHNa5pYxG8F0ektAGMBlOGCdMHQbDYOr1kgC+/8w5NZisE5WwmYcbyjx19Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694602; c=relaxed/simple;
	bh=HHeqMvJVqY9lX2GcwVqCutv2t1aGFcZ2WTIwjBzKy3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhamIcNsNX6VkH7N8PBNkxkmoHQtw8ljDIsp9DKMHJr2xHwRuBGiyMUmHSYfrcwTHbmJ6+FMbmu/ue3xIurEurQbt8BPFgZsNJn2luUmkTcjr0zrHFkz+urczz5YsHc+nd9IS7Z2dQT1gy0pVHPiDYGEYi7ank8rllukLwBLyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwiAhkAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwiAhkAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD331F000FF;
	Fri, 18 Sep 2026 01:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789694596;
	bh=XC44sZHSrS/RZ1gMfgRTkU7kAGU1FVCGNxeQFDbbVss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IwiAhkAVxPiZuKA63A3RAGR00ZPwqelWu63EuTcYmqqZo20/OOBowtVSRQpT1jIJb
	 r/h0IVZvIicCPBPHFGoKpuTZ5t0/ZNzowX1LXHY9edbzDKwhHF7rN9GU4SdvJtoKq9
	 H9CJlUro4fJe6ZdgTN25239DuVxdkmWfMlIU1mY8GYCFpX4ZFQ50+A1KQR54Ct1SuN
	 R9Qz4005+wYzSfJlX6KAg5E20J4KHtt4g4k899SQwOBhrAKqzQFFnoUUIIAQMkjt9C
	 WiqgPGAeYgVx/xBJ/VuMIrPWJvthws03yN/qktR4hAZS5AUvRTHMgRwxglwTX6N78f
	 lZ050nRScx+eA==
Date: Thu, 17 Sep 2026 18:23:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, tariqt@nvidia.com, moshe@nvidia.com,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next v2 7/9] netlink: specs: devlink: describe the
 netns id in the parent-dev nest
Message-ID: <20260917182315.4997e29a@kernel.org>
In-Reply-To: <178958612368.22033.8170999467219795147@kernel.org>
References: <20260915161341.1053476-8-kuba@kernel.org>
	<178958612368.22033.8170999467219795147@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 19:15:23 +0000 netdev-bot+sashiko@kernel.org wrote:
> > devlink_nl_rate_parent_fill() emits DEVLINK_ATTR_PARENT_DEV via
> > devlink_nl_put_nested_handle(), which adds DEVLINK_ATTR_NETNS_ID
> > whenever the parent rate node lives on a devlink instance in another
> > netns. Now that we defined dl-nested-devlink subset, which unlike
> > dl-parent-dev includes netns-id, let's switch to it.  
> 
> [Severity: Medium]
> Is this description understating what the change fixes?  The wording reads
> like the switch is descriptive polish ("Now that we defined
> dl-nested-devlink subset ... let's switch to it"), but before this patch
> python ynl seems to fail decoding real kernel messages, not just describe
> them incompletely.

Well.. sure. It makes YNL work for the requests, it's sort of 
the overarching point of the spec fixes.
