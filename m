Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1012367DF;
	Wed, 30 Sep 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728639; cv=none; b=NIeZmm6jB6NZOTQfWkdg1n1jbj43CVCI/gz0leOXrkVoIdsrZ1WWDTn6iDmhHe/SEalJ3RbC9tVPtZITR7A99YayxDsBGHnU1oPxnQONkS8Vwnr/PjMwpFfjxiohR1i/xNzINvT78a4U3a76vN+aMKiphsYD69VvgdawTtYUZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728639; c=relaxed/simple;
	bh=D4rD/uX6VXvG92bfiCDlgdWexhQ8VUQcTMfiAue+Dbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnQd9MweRbM2DrELrnnOiBysKvzMG6iJeM//ubKu9kSCP/cFxKSWMu1TdRedfwjLVYbkaZ2ICW3W55UNQe5p2v5E6z2A2Ovs4+rHErxbQWPnUqcPFCncbHtWxTZ/E1JAvKXHfk3b437En/LM3ThV8KeqNsJM0JWsd5XfHpgHUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O14eqA0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O14eqA0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76C61F000FF;
	Wed, 30 Sep 2026 00:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728638;
	bh=Ug+1pz2fr01wkwkby8BPGePIFb7OnTvmgzRkMe3VLlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O14eqA0EDabIHnCtToudAXuxfKloQoHYtn8fs0WaUXHdKB/gNr8GwxxkyihW6KKkJ
	 KUOGger54BCMS647tmmFvWGatfGqAvnLT7l4xvg8b8EpAGDgIbVSqPoeoz2TC3/l7g
	 If9RVNxuVYc9XaUBTjxc/G9J2H830pXrG5aDj6YSk+8mKCWZQ+Ex1UT8h+JNI+Q4Oo
	 AFsWzLeXM3YKF2yWiEG9+U//dqrQwb9EjBB0wDf7Mwjo1N1YshxlAhHXMpNvsTm7Pe
	 mRu5HvE+hhsTcNiYpYz3VXLRc6mVmWR6LkXeRSLVqF5hs8eXLzqA69i1KtUSiTs52p
	 qqhwBgooY2hkw==
Date: Tue, 29 Sep 2026 17:37:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>, Suman Ghosh
 <sumang@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-af: add tracepoints for NPC MCAM
 entry programming
Message-ID: <20260929173716.55820fa1@kernel.org>
In-Reply-To: <20260923034858.1764461-1-rkannoth@marvell.com>
References: <20260923034858.1764461-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 09:18:58 +0530 Ratheesh Kannoth wrote:
> +EXPORT_TRACEPOINT_SYMBOL(otx2_npc_mcam_alloc_entries);
> +EXPORT_TRACEPOINT_SYMBOL(otx2_npc_mcam_copy);
> +EXPORT_TRACEPOINT_SYMBOL(otx2_npc_enable_mcam_entry);
> +EXPORT_TRACEPOINT_SYMBOL(otx2_npc_cam);
> +EXPORT_TRACEPOINT_SYMBOL(otx2_npc_action);

There seems to be only one module calling these, why not add 
the tracepoint to the module that needs them?!
-- 
pw-bot: cr
