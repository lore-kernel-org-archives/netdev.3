Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A44BEE3C;
	Tue, 15 Sep 2026 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432265; cv=none; b=QtNVaSVa9klfoQw0pyjoIDmF0U7rTN7vJPK2kQpdDtThJkFL/iXZF81Rg2hz9ElcdDMbHbuJH/Y73o3YAIJAryYAZb/xSlvaLs1xMYHGO6ZnW3HBU2MEzxH064R+laWfAEwNeWS/Ekr3BD7viTmXbwZWm0WDmFIhW+B+SMorPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432265; c=relaxed/simple;
	bh=ugFyOjD1fmOiRw3N3zGtWdeNQXpd9iD/gc0qmp3lf4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G41l8Huuimt/cX2b4ZgQOThk5AXgl1KDMP2yXrGM+CFqdXJanBxdZjLXVlgS9lJeHw/SWUpU7UUDopVihTEB2avXzpJC1kMVhLqbxUackjbRXTcZPzKDNQV65LiFxZB7j/MKX5J+paTLjC/3AwtS9tZ7ASIZSe0i7V66+tSYw4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCZ8olrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCZ8olrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8131F000FF;
	Tue, 15 Sep 2026 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789432264;
	bh=GGP8rEh8IVp0jgGGnFN7Axk08nM8Yj+F0I1L0vz3qI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BCZ8olrC0qq78hSJnP1dDWnDfiDwLlixPjEC4FIRjaDOVSYrJj7ioJsVm2ElN0WIg
	 ZFlq5KrKZioZwDnCHNyFBgdeDVDXswqDYhPHYv1WT8Bdz+uRuDmMUKpqPUkgcM3xRL
	 UkyKCD/QTByYf19A9UFZIVpgPOqbKoWVR7nSalW2J1jxYH9stQN/kRD0ommUdxIsf2
	 fEp+Apv+Lql+E79IWNOq6kf3amyfjm1sHewiEgkYHgbfgsEFdJr9jF3gMukcAAuB+Q
	 6RwOnlKIPdvxkhslCx/Mgb68ZbART6PjAh+NQP2OjzduyJhFBlGeMo4YaldvVum55A
	 DQV+g79F4Nvhw==
Date: Mon, 14 Sep 2026 17:31:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ali Firas <alishmery18@gmail.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 razor@blackwall.org, roopa@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] vxlan: vnifilter: limit the VNI range of a
 single request
Message-ID: <20260914173103.539d8838@kernel.org>
In-Reply-To: <20260909092645.3105263-2-alishmery18@gmail.com>
References: <20260907141001.GA708129@shredder>
	<20260909092645.3105263-1-alishmery18@gmail.com>
	<20260909092645.3105263-2-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 12:26:43 +0300 Ali Firas wrote:
> VXLAN_VNIFILTER_ENTRY_START and VXLAN_VNIFILTER_ENTRY_END are parsed
> without any bound on how far apart they are, so a single RTM_NEWTUNNEL
> message can ask for the whole 24-bit VNI space. vxlan_vni_add_del() then
> loops over that span creating one VNI node and one per-CPU stats block
> per iteration, all under rtnl_lock.

The AI review looks legit.
Please target net-next without a fixes tag for this.
Please do _not_ send the next version in reply to a previous posting.
