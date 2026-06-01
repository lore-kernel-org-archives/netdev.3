Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFE34753F;
	Mon,  1 Jun 2026 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297723; cv=none; b=koHxs1nGN+u+ycvX9mDId7tACr0S0/A5WL/G158loNsIocs1JA1X4jpQ3U9N6C0rThnabVCW6YWLKaXcPp6cmXucLVeE82k+qAj9bJVRKBN+kwDn6BsgjSJhLR83H35DiDOyvpQxnHvT7PICXMdA57DX/IN+SyV1fkOwfRicEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297723; c=relaxed/simple;
	bh=rWsuciZeawwMUwyRFuFy+QcMoXAdRYH3Ac6BVPJVJa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEWRxzJm+Q2RjcbAge+ggESZORHMaq4ApiGw4KeZs4pPIXZJ4fDpBqhRv7SIQfv5IpnUpNzfGS5fqFr5N9wBKVJDz5Dd1Py1Tyh4PnR/o9K5WiTfGyRzfk6XrUpdICeRToFsPNgKli3Ux5gxcETv45tC9+pgcfrk50M778I+uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nEhXxRHp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rSYf5CXT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nEhXxRHp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rSYf5CXT"
Date: Mon, 1 Jun 2026 09:08:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780297721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0x3Ic0bcpvqvC4Mz9UQdIoh9w18Wwn8oyv/kgdUJUk=;
	b=nEhXxRHpnfya6wCaY0GOxFIciWYMd8r/Jz29yf6UMqAYivZDcGMR19JixQDnMGi7+G8MEM
	8T6+htk45loofwRJr8aEGpD9I1oWlGsQbtJjTV8B5Z+cMDPNKPeDACfulnao9+zxI62T59
	fFYLMlmgG1yr17D0I7Cerve8jutgPX79ITGgWKddbVa6Cl2UBmJsY8bN5AnzUD038ofz4e
	zgx662y/BseABp3Zo5iA05X9l/Ou2GO7w8gRJC3V6MWDH8BSPGIm+5rCxZqEp68D3ur6h4
	FgaJmn05v1m9sQqYsLBaTV1stJKAmiWslLE9h717kRGiccvIHzvIlKarYotnVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780297721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0x3Ic0bcpvqvC4Mz9UQdIoh9w18Wwn8oyv/kgdUJUk=;
	b=rSYf5CXTm2KiLFddpTUmRbgP/zppA2ebX7xOGp5CjQf7AOqH8vNlLpAEoT25wR+MpDZVEC
	EvhK9G+5XzSnvMDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: fec_mpc52xx: add missing kernel-doc for
 @may_sleep
Message-ID: <20260601070839.4UMhibIg@linutronix.de>
References: <20260531000042.369043-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260531000042.369043-1-rosenp@gmail.com>

On 2026-05-30 17:00:42 [-0700], Rosen Penev wrote:
> Add the missing @may_sleep parameter description to the
> mpc52xx_fec_stop kernel-doc comment.
> 
> Fixes: c35a0824e88b ("net: fec_mpc52xx: Replace in_interrupt() usage")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
