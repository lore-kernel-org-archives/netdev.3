Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A839768C;
	Wed, 17 Jun 2026 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698154; cv=none; b=kC4di3B6Mf5GiQFlL+nD72kR8d4Eh0cjbmSQflMl8czthuvzOQGr0ABMCYdo6grrbw/5AEMSMP/ElJUByPpJAael0mdSoULV3UBkXjeVHg+Uxq+ZCEvpLPS6TKF6W+acEM40Z+ks4Z/qDYZGeeIpg23yAxs+vnzpNiEYGlkigR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698154; c=relaxed/simple;
	bh=wBqnBcitee8JV7gnDzupHIFB3FW8gdVcvaFE0+zwCUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgwuQYD3U1mCcjUO/1cvfiyQW++oqrb/eKZdlNx1VVK/3w6BZMkKR28lcNwFXkAlJ8FdhsFiFrgm6ViIJobhb0MoOHez1RbUeoD/sJSVPwHf7bjDqKBiVlGdJm5I4ezBbnoxSvfnHnp4h2EZw4skmKfJX7DCINbcUfSVlSBYey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e2HASTpK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e2HASTpK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cpaJQgqy1zZdzgoAsATLLFIYqArblohrirHSmRmbyX0=; b=e2HASTpK6Lwck59mVzghzm3E5f
	gex0MC5+EuVF8LqykXd4szFr+Za7DqXDDjmhuNlidjh7d8OPdvuXILGNT9R2XuAbx0X77VUF0EMuJ
	Dw/k0UFetbdDIRceAb8ZtstkXg4tvSNkY6eNWZrb91cHL61n0MJX3Y9vBieNeIuqIsTU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZp4m-008BKB-AE; Wed, 17 Jun 2026 14:09:00 +0200
Date: Wed, 17 Jun 2026 14:09:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net] net: rnpgbe: fix mailbox endianness handling
Message-ID: <26517b8f-33b7-4de7-8fe8-c7dca5fa7a4b@lunn.ch>
References: <20260617083531.251119-1-dong100@mucse.com>
 <bf5366c5-88ae-418c-9c5d-b2249a7f43fc@lunn.ch>
 <0C93ADB24CB93157+20260617114614.GA273003@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C93ADB24CB93157+20260617114614.GA273003@nic-Precision-5820-Tower>

> My understanding is as follows:
> The firmware structures are defined with__le16 / __le32 for wire format,
> but the original code cast these struct pointers to u32 * before passing
> them to the mailbox read/write routines:
> - Send path: (u32 *)&req -> msg buffer -> writel()
> - Receive path: readl() -> msg buffer -> (u32 *)&reply
> Sparse only sees pure u32 = u32 assignments here, so no type mismatch is
> reported.

Can the code be changed so that it does not need the cast? Casts are
bad, as you have just shown. This is something i try to push back on,
it makes you think about types and avoid issues like this.

	Andrew
