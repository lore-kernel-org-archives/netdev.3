Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337126;
	b=RNgrDh1KRDjaK74jrR+5LXooj4UxCu68fevlhqhUto2xIBmuh1m193uV0gmdF9CntccX
	 nBXsdyVDuUm10XpU73Ie2ComfRf8iTOiYKW/EV88nzggWuCKO+0CqULUqF7YmhxbrOIt+
	 gM1URW3x196zTmqwrNFgHfHgL3fSIMFMozoi1er3WQgeDCowahvQduR+gCZPxjNwvzh95
	 QN3AbGm8lN+wEcpeQBNpRADi5Zeb4jsUT+YsFXBHDneBL4xcEMnMCMKle7hoBLJxzaKmm
	 /cWv44rLg7ZQWtmtJ+cQ2hCmHNA9yf6oy7MOEi/V2pAm4Y7Uq09CcKPEZX9lJ7MnTPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337126;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wx8uTcdzrb700GDPSg9JhUtReSu8EnQ0VW6OhePS7rQ=;
	b=ITuP18TsqSNMrMGio/BgmpHjGW1j89fqnC/AEaQQk6d5U1J3EPn7V/TTGNxrtpDBHfHn
	 qDmmKu/rX8WZVA1LhrtiNl/hh0RSKELCD4wO/2i9++orIK5UCjuzd7fBHGQ3h8h0dpGRc
	 8qmqIqdxJkYFcxJPo3lfimv06OIUMT9t3LxONDNOxJrGo1ijhCncVDn4HXgOW+MtUt1SL
	 XIhOybIA3i09slYzPZv4JbdPwo5G8KtXEXYlQTRM7hF2Tq8Xn6QKvxoVEOUoSL+GEMJha
	 j5O9XWo9ffKGyDpYBCKdMounOGQjmmS/x0mdHghHEIR0XnL1hit0rFSaLutmaam2paA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPSf6Hc1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF2606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPSf6Hc1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB8A1F008A1;
	Tue, 10 Nov 2026 18:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337125;
	bh=wx8uTcdzrb700GDPSg9JhUtReSu8EnQ0VW6OhePS7rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bPSf6Hc11fbNFrGyQb/bK5w1grwZuF7iEuIjtbOEJTO920jx+bK/w9iOxxK5nv3iB
	 cwR+S87d6IMni4aKFQp+PShNw4TJwhJbi27TODthbbPY/mqdDX0+Cjagy+pva1IEgW
	 IMGLGsIgXJ+FRylkCYQtQpASlN+LYtAwUa/qeJJx+jXxC/JseMhZqih/1ZAOSuFAwI
	 6mvZj/UhUOrpMBGaZ7cgdabMM6lNF3I+NNwzik2nr1O99btcwqV32EwjNI1T/Jraob
	 ent4wrBNKx7S30S4mMZRZV2jMqGAHatkD4ACXJ8/A7QobCJ6kisOox5xUe+FIcRwNh
	 X1cQtI1v9Zhcw==
Date: Tue, 10 Nov 2026 10:58:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jingjing Xu <xujingjing@cmss.chinamobile.com>
Cc: donald.hunter@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] tools: ynl: preserve non-ASCII string attribute
 bytes
Message-ID: <20261110105845.0c9faffb@kernel.org>
In-Reply-To: <20261110033922.49297-1-xujingjing@cmss.chinamobile.com>
References: <20261110033922.49297-1-xujingjing@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 03:39:22 +0000 Jingjing Xu wrote:
> Netlink strings are not restricted to ASCII. 

Not sure where you got that idea.

> A valid non-ASCII interface
> name makes a getlink dump fail with UnicodeDecodeError, and encoding
> such a name for a rename request raises UnicodeEncodeError.
> 
> Use UTF-8 with surrogateescape for both directions. This preserves ASCII
> behavior, handles UTF-8 names and round-trips raw non-UTF-8 bytes that
> Linux also permits in interface names. Do not replace invalid bytes and
> lose the original name.
> 
> Discovered by Codex-assisted code inspection

So you made up a problem and then decided to fix it?
Please don't waste our time :/
