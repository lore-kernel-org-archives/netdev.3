Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B311DFE22
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485256; cv=none; b=O0C8yZ2fNAr63NdOMZooOHw7QTrgFStbWMExDZ4nTkHQzx8drC09Bj2OygXLHZEGRfYVi27h60G0NB+ISX1eFd6EK58qs6uJxdnVM4vb/aMMsPgwFXUO7MCQ+rpeXKeJ4LTmHdvQBMt/zhKeLb/y/ceFY4JgUtcjn9rOTeDKaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485256; c=relaxed/simple;
	bh=SgIK6ZAnwPzLj+u2xM4wEQwVXQdC+Unq7P5ZEg3Ma78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI+lDjLNKCiWSPgoHanvlwcu5QN8TyLzvcacl6ZXh8FWdVEA7eoaKkowheP6Metq8HqMSYeeamtcmSCCj3i09Q3PetzR3NwsvErhD9KrGWM1HTNd2vgqsEt0qWH8LPTA13L86yY3lHb3QpRX8ZBz78314X6jQa9V+MBm5U8FqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoCeYUGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoCeYUGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43483C116C6;
	Tue, 27 Jan 2026 03:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485255;
	bh=SgIK6ZAnwPzLj+u2xM4wEQwVXQdC+Unq7P5ZEg3Ma78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AoCeYUGLCt4litSTKl1mDx+2aoWFNrZBfkOmLJ8gCCwsNVQFCmS9W6qdo6w7syLXY
	 V5UAY2V32ssf56ghxxHni/OFyS+URcjhoPuU8sjdtu6ZW/rrHaSryDN2lRBSQ5sd7N
	 vzkmfCe8YgMDD8OZkQQCpq0WMYrHbJBnFqDwIeA0lObBuFR1fdQa2VUeo+xBw+da9G
	 k58BnuWRLICYwDRAnn9oSYbIZkeEQBtjgDLhxV7u/kkpXYXf5RoVkYRYiONfLc3Z66
	 L82ChN4DZpl/oEAsSyd8E7bPdr7ZGB2dtS6/oh7jMJiNaw4LqEIAVD1XuxeFRz8ZTq
	 KZI70BguJG4dQ==
Date: Mon, 26 Jan 2026 19:40:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] declance: Remove IRQF_ONESHOT
Message-ID: <20260126194054.79e6f56d@kernel.org>
In-Reply-To: <20260123110616.416384-1-bigeasy@linutronix.de>
References: <20260123110616.416384-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 12:06:16 +0100 Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> Remove IRQF_ONESHOT to irqflags.
> 
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> lance_dma_merr_int() does nothing but a printk() which means if it is a
> level interrupt then once it fires it remains asserted and that printk()
> takes over the machine.
> I guess it never fires and is just left over debug.

have you seen 0fabe1021f8bc9cffdede4ddad0dd04d43c5166c ?
Sounds like it may have been a hack local to MIPS.
On a quick read indeed your changes seems fine but it would give us
certain warm and fuzzies to have the commit message refer to and 
reason about the patch that introduced the flag..
-- 
pw-bot: cr
