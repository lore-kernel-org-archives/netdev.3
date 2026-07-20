Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEB33B3C1A
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584185; cv=none; b=n3O6513qBJA4f60uGvA9KwIj2unkG6NreI+fHlowOm3xXym7gVIvpEKeXy308H3QC4g9xvuNdEfuUdy7dqe/bgT2WDwj+zUNLwNkejp8NGh3vxFc1Cn8p5xt993WL+KNMIZuRZtBAp9edEnbzDptvhdiBLKSdLI8WZNwDWgBqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584185; c=relaxed/simple;
	bh=jfobYvFKnqZQWOJr3CSG5DZFANlVvFt3XLmpO+onttU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3ErdVvfJuyhkglKgxHjq7RYGFpyMED1/h4h6lfWsuypLVxujvOIcvgCocFYOoC8vM8RFyT/vFwEMxRBojQ35cMjcTTsSIVwYrRX7tdV86DTUx4uroTFCkiEBWElUhzRq1bd1gIjoNPxf3id64PEVMrNbM5A/plMeYd3Q4Ivq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0SEFFG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0SEFFG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21371F000E9;
	Mon, 20 Jul 2026 21:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784584184;
	bh=a305+/dqeGqdMetl9gdzRzOZIEZNcEFzXc13nYcj1B8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g0SEFFG2bQOVF5ay6vR8eSQj8SMppWEK4zQEg54fA4wKQQL2UaNittn7FN3d1vLSv
	 yHWCyDWlKR9HYzjhqR/r6L3y+nhip8g7ojU6WYgF12ueFPCWEh0u1kLaOz70Tznwxe
	 Lvz+eZ4YgUxHwqJvWCNWxJDSd4WFK7cZw4v7z8gXnCtUG9i5dP2dPU7pPvV/9i3VXn
	 Aqu69a/YPyv1baqJO11m27b2tcEk97vSWJtuwGRvnMFkV6efT7hOUzezdaNpiIEQ6T
	 H+2/DAk7I8W2/9+v83SWkZZCzn0L4mJRPwWJxt2Nd4foa6WRO2d9t+wvhIKk+77hvw
	 qvIh1TWpgkVlw==
Date: Mon, 20 Jul 2026 14:49:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Wayen Yan <win847@gmail.com>, netdev@vger.kernel.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: fix HTB class modification offload
Message-ID: <20260720144943.0f4d1771@kernel.org>
In-Reply-To: <akthM-O5eea52MN6@lore-desk>
References: <178332096675.2250671.599544331813347302@gmail.com>
	<akthM-O5eea52MN6@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 10:02:59 +0200 Lorenzo Bianconi wrote:
> > HTB core does not populate parent_classid for TC_HTB_NODE_MODIFY.
> > Airoha currently checks parent_classid against TC_HTB_CLASSID_ROOT
> > in a helper shared by both TC_HTB_LEAF_ALLOC_QUEUE and
> > TC_HTB_NODE_MODIFY. Since the modify path leaves parent_classid as
> > zero, the check always fails and changing parameters of an already
> > offloaded HTB class is rejected with -EINVAL.
> > 
> > Move the root-parent check into the allocation path and validate
> > modify requests using the per-netdev QoS channel bitmap, consistent
> > with the delete and query paths.
> > 
> > Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
> > Signed-off-by: Wayen Yan <win847@gmail.com>  
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

ditto, please repost
