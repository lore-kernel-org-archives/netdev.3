Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1482E2C029D;
	Thu,  9 Jul 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605375; cv=none; b=nyE81eI/exCGc9xiw5NQnhxLsmWumASfrIvg21gptIu1SLvzxFvbTRuAnYy8y2TrD7MlPYYG41VBpnH3hjQVhScJE8vQ2A73lgiIJdg+FjZrUJ2y3qTS2jVA7IGneC8avLmQ0y8XBktDMzhVtZAAfpnq5VN7G58wYpdEdjrZuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605375; c=relaxed/simple;
	bh=i81NxTEkmydaKEAl/LkQcNPgm4/l7R5b5H1ealDfRec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrH/v7vr1kUMR6BjX77NElcK66owUsXa0pFhRGTeJOFGGY4Dg+XHtmpV3/+8Ick0x8mShNTsz8l9q9WsmvyvfcRug14RN1z3vPf1VJOmWfeyYFD1dkAEFuUgkvi66FVdYjhpa+L9L0loAl4gLbdEGLSu1K8pEgVvmSQZMUlPTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gf35py3v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gf35py3v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TyGZ4Yh2PYydxEftijgf6pm2ZKSoXc/AcJ6Hxr9na54=; b=Gf35py3v9mDSMerax+jdC1Mpla
	tvNsEtvbK9GG9GkwpaNmKQJte3VQqWwpGU+T2hwlaDWAjMAdRKQ9QVEeC/5feCLGrNLyI+SHir31T
	u/sFvqnx4T85tLub1TN5rKvRrA0k7+09eE/T68bfgtTm9JQS4/M8IkWKoP6FAD0M6uxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whpEV-00BVIl-DS; Thu, 09 Jul 2026 15:56:07 +0200
Date: Thu, 9 Jul 2026 15:56:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Subject: Re: [PATCHv2 net-next 7/7] net: usb: usbnet: remove outdated sanity
 check
Message-ID: <94418dce-1b66-4599-8c5f-6a814048427a@lunn.ch>
References: <20260709120116.1423033-1-oneukum@suse.com>
 <20260709120116.1423033-7-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709120116.1423033-7-oneukum@suse.com>

On Thu, Jul 09, 2026 at 02:01:16PM +0200, Oliver Neukum wrote:
> The cdc state is now included as a proper member in the descriptor.
> There is no point in checking whether it fits into the scratchpad
> area. Just remove the check.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
