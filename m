Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619B3F7899;
	Mon, 17 Aug 2026 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000813; cv=none; b=RlrODDqbXb9dFQ5ie4kN28L6pNZEiZV20IP+9DKa5oMCyPCWybckVgaygfQZ65t9YS6F8Ripx/8ltmT4JVlBw/KliGK1113JfTOeFaNWl2gcebblZJUSJXH+hQGG4437RlGd0halZc2ZwFXa5o3Tbx9GrGinOB+SK8JNIotO2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000813; c=relaxed/simple;
	bh=WGwlXmHK+f/0a+Lo3mIkjpdALKTBfwMFwogy+BJf4n8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpYrMjwlGeZJ+i7Qmo68A5M3ZkyjYGlVjPyWHRcy4EebdoR80RAf4Wo2mlQJpaByD4Un7tcLvt/kYMwLHxxR4d7uTevg0FhvgyBpFMzAu7OPfu9k7d3A9ccVKOzubayZiQjRFv2u4ORLTffqv3tiflUwBCsi9mzTYRDAsRQYcys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPJ1eQbk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPJ1eQbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17A11F000E9;
	Mon, 17 Aug 2026 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787000812;
	bh=p0jsuj551jzsYZDAZizynpcYiKOAYxeDhczFsu6L1ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KPJ1eQbkEe1ht00VMSUrO8UI/x6AQVxwfs+PIBtwI5ZskN1o+cfRbnv5qLRtIRL1Y
	 xnUp0Q8B5WyDPVXM3NDqDdBXMXCrHF+AtDaRahyqrb9DQEOkCKz27w9kEC0alIJ2D1
	 V5twi4BuXO1PcbpR05ouB/ThUEjFYMLiJCmn8NNaT+Qks1prFX+8slD6qoDiT5QB5V
	 DvQzj7jczxi6zdJiE9Rj7nhbzhGrqj3iMb+HfxqFew/wokn++DKSmfIjcEWA2WZWDv
	 QEk62SH+1GD+4kxHYrp5WOE3xd+iHETxc9TIjUtXURW0DM+VYjkplBlGnV6+YhCnTu
	 0dEuIdqJqoV5g==
Date: Mon, 17 Aug 2026 14:06:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 00/10] rxrpc: Fix CHALLENGE packet handling
Message-ID: <20260817140650.1253230c@kernel.org>
In-Reply-To: <1843918.1786997961@warthog.procyon.org.uk>
References: <20260807180518.0287b58e@kernel.org>
	<20260804172639.2844491-1-dhowells@redhat.com>
	<20260806091511.46a2fabb@kernel.org>
	<1843918.1786997961@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 21:19:21 +0100 David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > Blah, doesn't apply or pull cleanly now to either tree :(  
> 
> I posted a v7:
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=1144661

Ack, hopefully we will get to it in time for the PR tomorrow.
I already spent 3 hours reviewing stuff today and the queue is
at 481 patches. Sigh.
