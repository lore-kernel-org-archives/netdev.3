Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5813B7A3
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745624532; cv=none; b=YCamDm2pp01lPa3DxRdjhBwVjyIzR5XxcjGZhZykOZNKb9pQneTcLA++pb7P4cnE+izX+shru82xS9eFIu7W3e2Ej71F8euuNxBE+Qxa/fcc/zeWIuYAwfOpLfDJKFxhImfgYnzC9yV6V3gOAO+mcO1WsiZWPdPTn+8HZJa2oRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745624532; c=relaxed/simple;
	bh=/ZxqSzwzmp9kZiARDUNtrnzTNDNvi+EMSLavfAKXvUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx4zG57A0V+/DI4e8AHPzR3SQcocfz5J4STTAE8VE1dOoB4Pk4drncwWU6w8p6gUGlkjX8rpNMiVMaM5dgTRAWIjfsPosvdJcdW0g1ma24h9yUHHb+iWaMbF+oj+b26gqBSwTJKwyjNAc9lLAN0kXheN/8FyvIQCei/pdgERmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7PZ1Cht; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7PZ1Cht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2164AC4CEE4;
	Fri, 25 Apr 2025 23:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745624531;
	bh=/ZxqSzwzmp9kZiARDUNtrnzTNDNvi+EMSLavfAKXvUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7PZ1ChtO6737xtc1CwJzKMWEqsZ0QNX42GFT3Rv1jHXVMew7y16+bdQi4/twdF9b
	 l9S+MzKuCIeKOHktCdL/M9jpBEyJtppUSk6snRrAxwpKLL2wav8NdjHCF++NsY6Qa1
	 ofQlerFdABZNs1Or78Oc+UrbbqSSvugjZ2xHlOblYwNYuIRvhlqBRBvV0sZjEGXDm4
	 NJWZX/W6mc0j4USUN0pdLiqPsZhKQn9LEbuXh6gw07s2Chcocu9EnjNHbTWK6+eRQV
	 BmJp0Lnb+MxHmgdqRCYZhRqXl/XtUwPTOtCiKzXwm9BDzHbxNMRAAU9QvYLRN51CFO
	 7/R0OWgDehsDQ==
Date: Fri, 25 Apr 2025 16:42:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
 jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 18/22] net: wipe the setting of deactived queues
Message-ID: <20250425164210.240a3449@kernel.org>
In-Reply-To: <aAfCIq6ktXXCOp-9@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-19-kuba@kernel.org>
	<aAfCIq6ktXXCOp-9@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 09:21:54 -0700 Stanislav Fomichev wrote:
> > +void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
> > +				    unsigned int rxq)
> > +{  
> 
> Presumably txq argument is here for some potential future use cases?

Yes, wanted to make sure we handle it all here, instead of adding
another call.
