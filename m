Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317305;
	b=NBAkaT7rCzHvp4Hr5dlbwl2gSAiqFZxfCMbkL38Amu9mP4UemVizbhtVJyeWdn+WHnD3
	 WtkEo8i6OEkYBFaWiIqS/MExKHNbvr7NZvrIRvA1tlpWF6nqWWRdUgSTR1s+WqrDLS5/M
	 qSqGFl1sWJqSHAYanaI94Ic+ZOyEuVtrkpdnHC9Mr38nr10lS93/SboqrtpK4sl9zaZ1G
	 UMZXiKFvP/gdwFsakcG34Pj6YVnp5zzoxnxWHERDbu1iF0eakfR3Vt0kMTVHmxNvWZSsi
	 jMTLoGUBqJJ/fxRPnXZ9zDFQjcxp1Lnb3gl66ZyCbeP9hWBBDMYCHomKUSQ4IUxWblw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317305;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=NjKqFsYHDe0kpWvSkOX9Vo+Ww2XtDII2dnV2pSzH82I=;
	b=kIryQHNqqEIHylB/giNpMknJ8HFXVKvB6BVv9DBf/N1CTxIhs1Bqw3M4X3SfwCCpyxMe
	 3F9AVBF6joS7UquNTiW8weiG5vwSaRQ3IFh5uFL57BOYCcK3Lp7GtCAek2SNnf7ISAlJG
	 rOlUNPX7YI2dbZN7xhkDR0Cgw+nYfxvRhVgA35R+AVVCklnGo4ag2OPLjwtd7PSDBJZ5l
	 qEfwulA515vWyPsQvGt7pLzLmHIuIe7pTZaR3n7LlCsOu0/IA/9yKEpkU+JNPPRjjr+di
	 IbSZ7yXXh6v1eUAMYNCYAuEF2RcqS8d/SXz4NlO/M4D8s6BOi+fodJTatF4xm4joHnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=1wS4RB6A;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A54606A747;
	Tue, 10 Nov 2026 13:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6A54606A747
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=1wS4RB6A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NjKqFsYHDe0kpWvSkOX9Vo+Ww2XtDII2dnV2pSzH82I=; b=1wS4RB6A4qiYD3td9X5Rp0IkNu
	viUA6ZWn4P6mP0tJNNDTE3bl1YfMG2KxG8B1VeZskEhd2HK0k+A9DLs9nLdsCdOCHgd9R4hCXE0jp
	4mF5lJYGb/WK+gnUaJs0VYHFFu36MUD/xswY2MLqcj8d7POLSzfZ/R4xCt1J+hX2a0Wc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQltb-00FUEa-0t; Tue, 10 Nov 2026 14:28:19 +0100
Date: Tue, 10 Nov 2026 14:28:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: dsa: motorcomm: Report error when
 FDB fails to add
Message-ID: <4f5b92b6-7dfc-4065-90bb-3f5398b0f2a0@lunn.ch>
References: <20261108094512.1285796-1-mmyangfl@gmail.com>
 <20261108094512.1285796-2-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108094512.1285796-2-mmyangfl@gmail.com>

On Sun, Nov 08, 2026 at 05:45:09PM +0800, David Yang wrote:
> fdb_add() ignored any errors returned by the hardware. Return error for
> that case.
> 
> In practice the 4096-entry table is hardly ever filled, and since
> fdb_add() will automatically expel dynamic entries, something bad will
> definitively happen before you fill it up with static entries. This,
> however, is in preparation for the upcoming static entry counters.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
