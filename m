Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5C26F293;
	Fri, 10 Jul 2026 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701310; cv=none; b=n6SIK0QYDpk7Ri+9vFNLSyARLE2rBU/4kk6/mMQjQhNv9ngm7RZn04AiTQy0vXNs9boZCL7KgDIazDc+vpM6bOhZErlYyaJu76wnalxlYZ9RGXIVb3lyQdCGHWfVvP3ubobKjXKK0mqbe/0WCX3RORyeLrZqaaE0ZUz73kHw/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701310; c=relaxed/simple;
	bh=QRl5+SWRonZygH8EGrKKbgj5UpBB1S6mijDUwycD9vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrM7CJBvvvjMLv0Fn56RmGra9SdeHGDUHPKdUiTlh4iqLirtRUO0QSXr8C2QaceqZPTQ+RDXpLKt56CqVZ5yuOyVnHy+tesFBAfD4qdSY/+MWMNveX4OewTmNOY5rqs0Memfh/gKmtv66Pj/AO37yU82+t2sLGFm+VnOyecOC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f31374gC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f31374gC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mKoA++2FvpRfbjJH0g7fyztWo+KTteketPfqtWfa26U=; b=f31374gCPEiuOGhG/A6F8DXIz0
	z2Jzji9FI6+p8VuCbTHThMZlUrQcMYPVmc4AtoOcHeLZUSJXPjdHZ4wT6GBUkNSqY6l9ymWgcQ+30
	zlk5RJq2tqF+lXPhZsQE8a/PRUa45+ltdYlq2oRObwkWDIFNsoC+IL2GzdYNB2hlO+UU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiEBf-00BfWs-LQ; Fri, 10 Jul 2026 18:34:51 +0200
Date: Fri, 10 Jul 2026 18:34:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
	tung.quang.nguyen@est.tech, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer
 MTU validation
Message-ID: <3ec7b01a-270a-4b57-af9e-bdbf85313da2@lunn.ch>
References: <20260709211649.15623-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709211649.15623-1-blbllhy@gmail.com>

On Thu, Jul 09, 2026 at 05:16:49PM -0400, Cen Zhang (Microsoft) wrote:
> Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied
> MTU values but only enforce a minimum bound, not a maximum.

I don't know the tipc code at all..

Can this be piped through netif_set_mtu()? It will call
dev_validate_mtu() which will validate the MTU against dev->min_mtu
and dev->max_mtu.

    Andrew
