Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA384DEC3B;
	Wed,  7 Oct 2026 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397709; cv=none; b=aF2xfpMm19h+HNIpL2DJvQX+F0I+/i91oLnK+f9C1Roy85xAdwVa6vWCh/JIDGLv99n8kcumE7huI0q/BbhHTlaKsipuKydtQnANhHJuzyGhPZuj1WuZYj2ej1K1W2vb4YbH+tcYP4YxcMVrO5yROrNzNH+kbCf+wFAqLubcWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397709; c=relaxed/simple;
	bh=3/L+IOKwxb8ZF32o4rkIPGv6tjxLmvL6MC3QIvSWyJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqfzMfveaOwz+DuIqD147GhM7f5FMvWyztTRrCE9SO7Z5wCtzFc1VD8PkOO9NucHKB8FJ7Aey6g6aQyFkmXrj0k5nRShwRLWq5RD4Q9WKTPCUlbmwGdCvWOI5Pd8ZrWXPMOQ9xBTO7GSD2E1O3/aKeelCXNnZTePm9hYB4/iIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MWoGzRYR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MWoGzRYR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d4yyvFX0D/yiaqkbb7wL7aPtxHSB64stapWDAtg2cV8=; b=MWoGzRYRYhwhwPoVQV0wGYmPKG
	5GXSWd2Fx3XSeCPqvWZ/um2OEyg92r/pNc8BhQnSSseFAf1j5jmu3SrUPOHmgZyzCB5J2LKSo+QNT
	xDAAqQBqaiN2PGWP4Tc0Uir2qzwoEryv/UqO6y3qulxSoNKKSylDS+CpRNXH7cJuH/X8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEWNK-009V5Y-3D; Wed, 07 Oct 2026 20:28:22 +0200
Date: Wed, 7 Oct 2026 20:28:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: ag71xx: Use default NAPI weight
Message-ID: <92a33bec-c409-4595-bb75-8bc83d595cf9@lunn.ch>
References: <20261007173628.657527-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007173628.657527-1-rosenp@gmail.com>

On Wed, Oct 07, 2026 at 10:36:28AM -0700, Rosen Penev wrote:
> Drop the custom NAPI weight and let netif_napi_add() use the core
> default.
> 
> The old comment claimed larger weights wasted cycles and cache, but
> recent RX and TX path changes altered those tradeoffs. Keep the driver
> on the standard default unless measurements show a device-specific value
> is needed.
> 
> iperf3:
> 
> Before:
> 
> [ ID][Role] Interval           Transfer     Bitrate         Retr
> [  5][TX-C]   0.00-10.00  sec   327 MBytes   274 Mbits/sec   31            sender
> [  5][TX-C]   0.00-10.00  sec   325 MBytes   273 Mbits/sec                  receiver
> [  7][RX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec    0            sender
> [  7][RX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec                  receiver
> 
> After:
> 
> [ ID][Role] Interval           Transfer     Bitrate         Retr
> [  5][TX-C]   0.00-10.00  sec   341 MBytes   286 Mbits/sec   30            sender
> [  5][TX-C]   0.00-10.00  sec   338 MBytes   284 Mbits/sec                  receiver
> [  7][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec    0            sender
> [  7][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec                  receiver
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
