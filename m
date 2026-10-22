Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683393;
	b=mvackGjdNJVqI294Wv1HXyRDOoWw97EhDH90wqOo1jPJ+521832WlRx0ESUI21Bu70el
	 n2khz82Gm3I0D/5TMs3ibDeGFBngna2w6SQ8fwtnVnyXddMiKaAE7Q4mWkINZvDrP3ntO
	 NzAZXiW1zeP+AlU6FZCz3Nu5oHxIUvs80RF849d3ZDFMxEu1+SR7SfemlWorWAbE6wdv1
	 LkvJaS76Eweokd785T0+SjURkEfnKFlyVmSTxkly6uhrt/zvLmBja/y9Y/iTluDa9kB7v
	 4gHuimxAzdgrO/zz5i/p+NWz8zpslQsL5l1qJT5Yl4em/XuqQrx93LxhN1bdlp+C8mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683393;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=BlPHtfzLH8dsb30F83yqKhUEwXui1hXO5a4OUJGPcFc=;
	b=MNDttxobSheDW9MHb7VZK3/BS9ULNoYBBqUOlptf6sdVTRAc+AtSPJPn7y+F6YuO+phG
	 DvYyxPWNNvMINEOJK8Dc5926VCu7c3pmLpMudYNTnnRmG04exiWuH4UgwRCHHbqwBzT1U
	 rutKEiSLl9f3gDehZva0ZOGVVKjbeuaRfDXgaqDggHLY6cFxaT1VTydZuGNYpov7uhuPE
	 8uRjU/WkP327Q+MpsvTaLwJxF5jdyzyDX3igaZwS3bowCEsPi14Opk1aZ8vJVLo22WBWn
	 x04YPhRlqCmtybVxutQHkm9vRUPE6Nken4VGMwPdNGg5dZYn+q1q/egueCk7vDeVsrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=heZTRl0r;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EDE606A31A;
	Thu, 22 Oct 2026 15:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0EDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=heZTRl0r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BlPHtfzLH8dsb30F83yqKhUEwXui1hXO5a4OUJGPcFc=; b=heZTRl0r7SNZtglBRzLGDzf7jR
	6sFtHsMvhpI3sbMk6XJNHScjLhcwmoPWsLWTpyeP/F6wzdwTZ5o3j/9CMgTj7OIyPF3UGEsMU5Orf
	WZByC9txKcEpZXE1efLSs7MFOTR9bQ+M11gW0DRIzvqLQTy+TYrxh1E1ZLO79OpYvWVY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJuq2-00CHfF-5V; Thu, 22 Oct 2026 17:36:18 +0200
Date: Thu, 22 Oct 2026 17:36:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: shaos <shawnq1@163.com>
Cc: jhs@mojatatu.com, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] net/sched: act_csum can checksum beyond a short IPv6
 jumbogram skb
Message-ID: <76f5a903-90cc-4eeb-8afc-99b5cd89b75d@lunn.ch>
References: <20261022144653.60550-1-shawnq1@163.com>
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
In-Reply-To: <20261022144653.60550-1-shawnq1@163.com>

On Thu, Oct 22, 2026 at 02:46:53PM +0000, shaos wrote:
> Hello,
> 
> An unprivileged process with namespace-scoped CAP_NET_ADMIN and CAP_NET_RAW installs a csum action for UDP-Lite and sends a 300-byte IPv6 frame with a Jumbo Payload value of 0xffffffca and UDP-Lite coverage longer than the bytes present. The jumbo-length addition wraps the pull-length check, while the later checksum path still uses the unwrapped length.

Please configure your editor to wrap lines at around 70
characters. Standard netiquette rules should be used on mailing lists.

Flooding the netdev list with bug reports like this will just result
in them being directed to /dev/null.

If you want to do something useful, fix the issue. Please do it
slowly, one bug report at a time, so you can learn how to do it
correctly without wasting peoples time.

   Andrew
