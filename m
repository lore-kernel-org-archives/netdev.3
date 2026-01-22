Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EF3469ED;
	Thu, 22 Jan 2026 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045310; cv=none; b=b2Bulqxv667Eoi8PX4goTM+p+/itkYYSfin7HiVWLF09/gyzv1nRqZbL2CUkXBPY8pJys6r0jTqXPx9ESwLmG5WcMXCeuC7e2iqc7JvN7ohNUjEDQY+NHpkDqJGCI48N+NfPZLWZt75ehcaZtlEGXZiA8t4FmQYwahdTJf0yIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045310; c=relaxed/simple;
	bh=e8QcIzOBxWh8mrVPL949DtKyIX8glnZ/oSMmHHDa52k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp/wPBN2hu9N7QUcsJL3McOQamZfGWaOlD9ZdlP9FnAy23Ih2+RMHW5r6xnKSQ1uLLVZwvMEuY7mW/bYLZYRpbdwNZxul94QMLPIU8hhLedVPhcirzdJlcqFiBKviQg/6MQsp7e+EJILmDWns63ZKgxrXtp/dkdRw+3LrpwqkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD03pvDg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD03pvDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B38C4CEF1;
	Thu, 22 Jan 2026 01:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769045310;
	bh=e8QcIzOBxWh8mrVPL949DtKyIX8glnZ/oSMmHHDa52k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TD03pvDgsLjKubboUPLKbIkcly7H/P8lxLxUW7Isdwt+C0jUaJWoIfAVFqQHPUqeS
	 2vlVsfvV3RKbUTlnPn5sIG7LnOWwWmSVCkSgmbJ1GddhWspxG5wJzNTxnhAre5MEtU
	 3O8QqLGCGAszz/gmeToGnQCfxV+jyrjwhENI1YypwKvB0TM3oMX9k8vbiL55K476D3
	 lsth1dRmzRCTP0//EqL2ue+ueLKrR6fq9IsF49ZDtWyApzgePVth87oFSrTnLI1UQV
	 xllsIwHQ8GI8KjefV2AUhyGFF393Y9TM5b6IYU0/iWyXejxu82DDzvD4UV45ETO8bj
	 4gYpaBDwXGVog==
Date: Wed, 21 Jan 2026 17:28:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/tcp_sigpool: Enable compile-testing
Message-ID: <20260121172828.7207108c@kernel.org>
In-Reply-To: <aXEvOqjkMPXk28x2@horms.kernel.org>
References: <e4822cf4aa03fed067f5df7cd4f3496828abc638.1768487199.git.geert+renesas@glider.be>
	<20260117163304.20caae7c@kernel.org>
	<CAMuHMdX9J9QPp16aDD-_2Q-chWANWeTyS6Dw=xJdkm8r-sPyFw@mail.gmail.com>
	<aXEvOqjkMPXk28x2@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 19:55:38 +0000 Simon Horman wrote:
> On Mon, Jan 19, 2026 at 05:26:37PM +0100, Geert Uytterhoeven wrote:
> > > this code cannot be used today. If this code regresses and someone
> > > wants to start using it on 32b they'll have to fix it.
> > >
> > > Please LMK if I'm misunderstanding or there's another argument (not
> > > mentioned in the commit message).  
> > 
> > In general, we want to be able to test-compile as much code as possible
> > on all platforms, but not bother everyone who configures and builds a
> > kernel for his system.  Until commit 37a183d3b7cdb873, that included
> > the tcp_sigpool code, and any build regressions would be caught soon,
> > and fixed (presumably).  Of course that still doesn't guarantee the
> > code would actually work on 32-bit, but successful compilation is a
> > first step...
> > 
> > As the maintainer, the decision is yours, though.  
> 
> Thanks Geert,
> 
> In my understanding COMPILE_TEST is about expanding compile-test coverage,
> and that is what this patch does.

Mine is that the goal of COMPILE_TEST is to make hard to reach but
*reachable* configurations. Canonical example a driver which can
only be useful on a single SOC may be hiding under that SOCs configs
but we don't want allconfig to miss it. Or randconfig to struggle
to each it.

If we change a core API we want to be able to build all the drivers
that it may break.

Here the situation is different, this code is already reachable by
allmodconfig. The patch makes it also build for what I referred to
as very unusual and Geert as "on't be dead for at least a decade"
platforms.. But crucially the code currently _never_ builds for 
those platforms.

Please don't repost this.
