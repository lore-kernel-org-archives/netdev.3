Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF131F998
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 00:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545813; cv=none; b=Ig0j2lsFts06tbg9c+RqvsbBJcEBb8xQ5Pn8NsYPDDUOhOA11Pq4hkqYvFlI59cBObSpWRXT1z0I88IeMxlADPjsWMVjILQ2wrkOQe/32/277PM95i7n6T+dkFiKdpNVI2LoUC7v/pjtJVHk+YrGrEeWJ66GTVfKRLDxjWFLouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545813; c=relaxed/simple;
	bh=DHr4bC/NxwqygJgGhHa8ZO6SNKhNfao+aXNakuXdDLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PG4dpIDkrhg5PbD02UWJuy4pjPf9nRKGAysxz7kDyR6B9sUQemHkXn3NXfHRMP4izxd7GJsTykg4u2vDJc+57PW3oZPvp74JhhJBC5h0LAiqAhi9EmViDAo2NsZQtQ+BDU4snL9VddN8h6YIXRLeE7UXqL+uUDz86R44kxj5WnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNy+Wsxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNy+Wsxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA721F00AC4;
	Sat,  1 Aug 2026 00:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545811;
	bh=DHr4bC/NxwqygJgGhHa8ZO6SNKhNfao+aXNakuXdDLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eNy+WsxdNjXMzVa3PXiCfhgbpLgPZHOk/q7dzLCfNGjThcvNF+GVzr14GQ8NqeUH4
	 xrbXM0YJbmCvwxCKPR/EHZMY6R6BmoaqYW6WtSl6NbCEfCMGvip1KojRIa0awWqz6v
	 VE65Mk1LMPSZ79sMvlvm2vNx5dKPzXOYejDynYpvEuMNN2jfK/XX0GbY7kBeB7qs84
	 W29jHXmDjJ7dLEnJbmVDXMRzJXlG3S58l69fyirWozi9/VRfkaq93iKOddQ+ChjuZC
	 kaElEifpBPSW4g56Bum5XTghTRfWRAi/AaZfgZwFO88JOuev63RVBnGCYSYxz8gGuX
	 YWx/BGrfsP5fw==
Date: Fri, 31 Jul 2026 17:56:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, Xiang Mei <xmei5@asu.edu>, Weiming
 Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net v9] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Message-ID: <20260731175650.0ed418f6@kernel.org>
In-Reply-To: <20260730083407.14915-1-tung.quang.nguyen@est.tech>
References: <20260730083407.14915-1-tung.quang.nguyen@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 15:34:01 +0700 Tung Nguyen wrote:
> + * tipc_named_node_up - tell specified node about all publications by this node
> + * @net: the associated network namespace
> + * @dnode: destination node
> + * @capabilities: peer node's capabilities
> + */
> +int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)

Sorry to nit pick but for new code we ask that kdoc -Wall is clean
which requires Return: statements:

Warning: net/tipc/name_distr.c:151 No description found for return value of 'named_distribute'
Warning: net/tipc/name_distr.c:208 No description found for return value of 'tipc_named_distribute'
Warning: net/tipc/name_distr.c:237 No description found for return value of 'tipc_named_node_up'
Warning: net/tipc/name_distr.c:270 No description found for return value of 'tipc_named_dist_cluster_scope'
Warning: net/tipc/name_distr.c:151 No description found for return value of 'named_distribute'
Warning: net/tipc/name_distr.c:208 No description found for return value of 'tipc_named_distribute'
Warning: net/tipc/name_distr.c:237 No description found for return value of 'tipc_named_node_up'
Warning: net/tipc/name_distr.c:270 No description found for return value of 'tipc_named_dist_cluster_scope'
