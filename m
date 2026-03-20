Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155AE371053;
	Fri, 20 Mar 2026 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995098; cv=none; b=PJZgeIgq56kMygFRNLdJZOLzG/ufaPN7XShRALQtw7oW1iXGp7t1zGhkyNqbQfXgYTb9NGETWGo4X+GhKYctaimIhnNuArmuL8tDLv8onN7UlZ7Rn1TXW6YPlBRVsgz9Z3eFooK5BrhU3NKbQBFt8Fbtkduhm3ewK1McRKEVItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995098; c=relaxed/simple;
	bh=BOiFP4GTwK9KfyYOLBsLbrcHmaO46GyQ68oBX/hGBJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5WiyNl+Fe/DAK813FDVTlIPKzV/xSCYAPPbzfKvTIUKzQRL/CBeLgfGTdrVlzGsLYYlcbmH6rCuNd6kHGGrbBBxIxUWB8gl6QqVzzy6VezMBD0r/u2mX7D6+DRk773PrpH867F34rMiebQE1Uzx6aG7KdK5xkfQTQcAM7MohbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRbuGfGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRbuGfGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFF9C4CEF7;
	Fri, 20 Mar 2026 08:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773995097;
	bh=BOiFP4GTwK9KfyYOLBsLbrcHmaO46GyQ68oBX/hGBJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRbuGfGLO9xOx3+Il1Qx7u4d32oe3BWur6zeJY4BJ6LTNMqn/wgWYXjSNfcRLQilg
	 oFHAOacmsbggrS3O5B6lGD24ssZrmu3OpxyZ/q83iPGdB2eW//oVH5L0IvR0kBceoq
	 A7CSbmr/4Mh/xpAQS/VqcB/j7fpzexZ628P8eZdwvgmfRdwqUqagnUKHZt6xPnMFol
	 RI/WY1JfoibBZltHsHQwIX6xeOLwiTq/lOjGzPXCslAQUawWp7xcU3qcPKdw1wyDxb
	 rz+qFkrCnHZ2jFfDI4C2pNp4h4R3UYxiAh+qfPTRu1AQkROr6AXyyzmUEmm7Ra/i61
	 M0dbbrzBcUMAw==
Date: Fri, 20 Mar 2026 08:24:53 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Anderson Nascimento <anderson@allelesecurity.com>,
	marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rxrpc: Fix keyring reference count leak in
 rxrpc_setsockopt()
Message-ID: <20260320082453.GY1753385@horms.kernel.org>
References: <20260319161004.GH1753385@horms.kernel.org>
 <20260313132327.409785-1-anderson@allelesecurity.com>
 <20260313132327.409785-2-anderson@allelesecurity.com>
 <172885.1773939353@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172885.1773939353@warthog.procyon.org.uk>

On Thu, Mar 19, 2026 at 04:55:53PM +0000, David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > > Fixes: 17926a7 ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
> > 
> > nit: Please use 12 (or more if needed to avoid a collision) bytes
> >      for the hash in Fixes tags.
> 
> I fixed this when I posted my collection of rxrpc patches, including this one.

Thanks David,

Sorry for not noticing that.
