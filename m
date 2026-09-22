Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E43C4B64
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101243; cv=none; b=cheNvAGTDUVtI23EehpoaYkXLpn9dPtRRXFjAL10i4yV6chCHKs3y4sQpBuDTn2E+UdSaQHN2+1CQmAH7z1qfEJ0ZirVhbjmCKAsOa4Fmnx15kpUe3e1A9lX/piNGIWQdnEk6rLRVTCgB/c9hvs51TPH283GDgU2S8tLvjtdP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101243; c=relaxed/simple;
	bh=KQZbo3AQeeUTD9ur7ycnKwwUFqoyjq9+6DvdgCGGGkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU8Zo1r7eMfCaR5aQ2atY8ydOjfmtVnEXOMQsI1TJ4ilSKusJJH2DOejt18cghmSUG+6mjud7Cob78T3eU66Mz4bExhqD7rG5fLEFASXtRRAO/XTs4Bg8y1TTbBnGOpp/jAgHs4RVlDWuYm5+jlWtrRm4K8rOaC0qNmYMDktY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqiwWOhu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqiwWOhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DA81F000FF;
	Tue, 22 Sep 2026 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101242;
	bh=KQZbo3AQeeUTD9ur7ycnKwwUFqoyjq9+6DvdgCGGGkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jqiwWOhuM1Mn3lwuKKJUzPOp+nYZI249TLP/nkobeLytJnj8qNr1ZKTJRrG5I0nWn
	 HZQGRIwAPm21UoOQlpX5onqYyvwWG6FaYaFFYIMK1jEpLI1cty15dG5ExO90Y7xHHx
	 gz8VKr+CcYY7n4fvP9iT0WFMeEfbM6LdkAAIf4WC9znJcuwWDCS53e7X7oG2vuDPBa
	 0GKwcYuEf0qW8NmfyYkl7E6VQmALuHBi+JnHs5GRA3VrMLSRIYfWaMEm9Hzay+iYYN
	 hAbtN7FNvDjUoa6w/KwR8i3TkqnzSxSUvj81qoBxSMTuIBA1x43TsZ8dcwsd2Vil4A
	 jZ6RUjkb+r20Q==
Date: Tue, 22 Sep 2026 11:20:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v6 net-next 0/8] vxlan: convert configuration to RCU and
 enable lockless dumps
Message-ID: <20260922112041.6d60234b@kernel.org>
In-Reply-To: <20260922181102.3989489-1-edumazet@google.com>
References: <20260922181102.3989489-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 18:10:54 +0000 Eric Dumazet wrote:
> This patch series converts struct vxlan_config to RCU protection, eliminates
> redundant destination fields, and enables lockless RTNL-free link dumping
> in vxlan_fill_info().

Eric, please consider obeying the "15 outstanding patches per tree"
limit. We can discuss changing that, tho I suspect it'd end rather
poorly.
