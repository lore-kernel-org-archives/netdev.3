Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CC2C0282;
	Thu,  7 May 2026 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164196; cv=none; b=Xy+/e9cTFlVgy4dO8iTKU8iA61xdYR3v4UhgWUrOusjFA4tvI93o3IQ7O5SJV428i9LwuqqXPC/ZewcSJmU3CJNXVOw+ViT5AMjhkYoLYOqq5e1nti4r9jYeHiNb6DBlUrmOAQgkzwZt+br8q4CipTbLQu51Id6t6rCeXVglquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164196; c=relaxed/simple;
	bh=LB4dE/vBK6x4eXcHtskLCec2C56PHR6Al6HWMU4idtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/nItsyuTIiG8F4flTuOHBrJ/y+BgY3SghGXUeZwo8CRWqf3Qtocs4N8nU5LWuLQGc8rV+5PbhT581W1mRnKm2lsK4zxl55cR81NttLTuNnX6QY/2juz1PjrW1DGF+81nu8MmyKpSc8XMT5fGQpcRnb8HSlA3kRaCJ7SNkL905c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfGuA2iW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfGuA2iW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC19C2BCB8;
	Thu,  7 May 2026 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164195;
	bh=LB4dE/vBK6x4eXcHtskLCec2C56PHR6Al6HWMU4idtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZfGuA2iWhPDRvEfHG2TLSGF1eYmcSxTX58MEl0VbdsEJa9d6iaOa6DD5rOmAlyC2s
	 F2du1+FzOSXb3nS+vHg9KvLY+nRYU5w8iBoT82umCC8Bkd/XalKqoOgrf2aUcKFjcR
	 y6Kpfh1yBAc24hSHp2hGnhN80knZ5HkxyEwGso80loKjxLkzA1bvxVdd9lWD5C57jl
	 rldMsGmdoBl6758roawDD+eDZymzAeOtfUzZWIQucMmeB/39f+vMkTnuNvqAqv0KHW
	 DvJCMlo3HXZ06dRkppKLEGEycH/ctTM19UIdtoAi0+tZa2R30jXr0b8XmXDY5mfkGe
	 fqcZy3kJQnpjA==
Date: Thu, 7 May 2026 07:29:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Alexander Duyck
 <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net v2] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <20260507072954.263ae8dd@kernel.org>
In-Reply-To: <20260507072453.5eec7051@kernel.org>
References: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
	<6cec0c03-5bdc-4131-9899-bc5c77fba198@redhat.com>
	<20260507072453.5eec7051@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 07:24:53 -0700 Jakub Kicinski wrote:
> On Thu, 7 May 2026 12:34:24 +0200 Paolo Abeni wrote:
> > > Clearing fbd->netdev to NULL avoids UAF in init_failure_mode where
> > > callers guard by checking !fbd->netdev, such as fbnic_mdio_read_pmd().
> > > These callers remain active even after a failed probe, so fdb->netdev
> > > still needs to be cleared.
> > > 
> > > Fixes: d0fe7104c795 ("fbnic: Replace use of internal PCS w/ Designware XPCS")
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>    
> > 
> > Note that sashiko-gemini spotted a pre-existing issue:
> > 
> > https://sashiko.dev/#/patchset/20260504-fbnic-pcs-fix-v2-1-de45192821d9%40meta.com
> > 
> > does not block this patch but could deserve a follow-up.  
> 
> fbd is a devlink priv, not netdev priv, touching it after free_netdev()
> is perfectly fine. I wish Gemini tried a *little* harder instead of
> guessing :| Sorry for not commenting earlier.

Ugh, not enough coffee. It's complaining about MDIO reads, I think
that's valid.
