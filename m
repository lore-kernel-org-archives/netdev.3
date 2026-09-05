Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AAF353A7C;
	Sat,  5 Sep 2026 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637519; cv=none; b=u8FCWaOaTf0w5KPpJHb9cQpw1uGhTjOcVHTJwfPK8LLlXogMyTPheh9trrx2IATDtFjTLypTbTMC9I29RwcR4wgRrhGDgNU9uPYFskMmuYy/OVfA7Pbu1SeZf3xsonfYgM5EcT3J/TUDrGMkVWfOI7Nie/U71qe589CySDBYwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637519; c=relaxed/simple;
	bh=d94TwUFpAuUqh2FGTEYSpBB6duhc06stSXMvZhodCFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcYCKk3KGdaz+1LpielonFt318SOqse0FXdJ6DgFeuXcMn25RdSgGdeAEHldnRu5oWGPKjzM8TbObBYUbmLGaKL0dr6v6jaj0r7ViDH6RP7E2eQot9f0wi42oSSz02u/EeGgL6CrQi/3YSyngn2I5lT2vhVAz+3bX3LJfhUzqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTpH3A4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTpH3A4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09A61F00A3A;
	Sat,  5 Sep 2026 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788637518;
	bh=poREzvz7c5aUS1OoQKY3QKVUwU7tl0IfykNqF/RlDTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oTpH3A4eURIKQWVfoQYoFZzoqajvNLjCsZ70DrHPkPNC7I7LsbeCXCXgx1K1AnoTj
	 u1pWCFcMjNokC2OQ24IiAK7xX90r0kvRTQfZYUoypatTCP//UflSsO+fOs+4iJlnmD
	 HrbU+TVCJnO358UJ0ac0Bj4JmJ3ND9WNb3fv5pt8odDBlHXtuAWZRIEFDRc/7nSxgG
	 9CbTi4+985xf+W6eVmbl0++EGYwIxeL7LzktzkBIJKNNoq7hhvqrWYibFdVK34FlOP
	 KMMa71l8g6NPqBmSXdXIOVvmC4aBmI+dySLyoF4jI7huDZMpEM2lR2qRT9JbuJiESJ
	 yDP9THV/iuKBg==
Date: Sat, 5 Sep 2026 12:45:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <nb@tipi-net.de>, <kuniyu@google.com>,
 <sdf@fomichev.me>, <liuhangbin@gmail.com>, <da-x@monatomic.org>,
 <jeff@garzik.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] 8021q: publish vlan_devices_arrays
 entries with acquire/release
Message-ID: <20260905124517.0e3daf69@kernel.org>
In-Reply-To: <20260902073334.397685-3-ruanjinjie@huawei.com>
References: <20260902073334.397685-1-ruanjinjie@huawei.com>
	<20260902073334.397685-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Some nits for the future..

On Wed, 2 Sep 2026 15:33:34 +0800 Jinjie Ruan wrote:
> Replace the smp_wmb()/smp_rmb() barrier pair with
> smp_store_release()/smp_load_acquire() on
> vg->vlan_devices_arrays[pidx][vidx].
> 
> vlan_group_prealloc_vid() publishes the array pointer via release;
> __vlan_group_get_device() acquires it before accessing the array,
> ensuring the allocated entries are visible.
> 
> No functional change intended.

This phrase is usually reserved for patches which are pure refactor.
You are changing the barriers.

> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Nicolai Buchwitz <nb@tipi-net.de>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>

Please put the CCs under the --- marker.

> Assisted-by: DeepSeek:DeepSeek-V3
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

