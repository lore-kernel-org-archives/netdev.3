Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632E31F993;
	Mon, 13 Jul 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956879; cv=none; b=ODBZPg6Y01mVVweGujBdxdA20MllFmwiyujnrgLJOIQIOF1ukkq6CQY+OyhSJSCH4furlzQj+i8KUDz9reNxK+hXd6eze63Jb6aqa0lqqx2yfKgG1ce36Ig9zNQmmAhRnQOddDZQzf9lzX5OT1H/KEVotB6CqVUxUvbMOIxoEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956879; c=relaxed/simple;
	bh=mBvY7xkBpVsxQFIhY5AR75bbu5Wc6sPF5HRMVTXEDVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awGDt+STSIC4GV4pC0GO+LhEWAWKEYhuNb0OBuzvO45VtFsLj8FIIxpQZAeeQSwBRmlB+ERfxDZ6s0j1QkjKHArc2+S02TJgzNxKqzT9HjP0aHcFhlbbWSTpfIoKhunWHU6QKG/Tbhglw92y9dfQy9xjIC71TWpeBMpR9NkKhNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEFAMY70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEFAMY70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E701A1F000E9;
	Mon, 13 Jul 2026 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956878;
	bh=oxXkrB1X31IPJcB2bni8t3YWzboFD9USXWVcXMXuFUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oEFAMY70bsC5n+fZWMGAvgZ+T8hseF2QyWbM6CdKZizEM74TNZ94SsLqpy+iIT/CA
	 okJVNfwb2FfrEuSkm8kjOUaWUgmrDnUtfbPOp5m+l6qRbg0Cx6nD+J96iZNZF18ltR
	 EL2GHdVh+Vc3dcwrvxvn8sljgyboiCpYQ2IH/7dRRz8CrugH5+Q+60NaVinivd8ze7
	 FD1L+MSQAv0W1tUamA6+4mwXe1vrGd5Bi1w4KLj+tPHvfwXwQJrzeReOw2GdHVbPTA
	 mnLT8nGrLWf98nWECaHFUhEPz1ML9HroP0KIvh/FJNmfKMkXSNJ32w2ajqeznfK2hb
	 chxGcyGlECorw==
Date: Mon, 13 Jul 2026 16:34:34 +0100
From: Simon Horman <horms@kernel.org>
To: "Doruk (0sec)" <doruk@0sec.ai>
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com
Subject: Re: [PATCH net] nfc: llcp: bound the remaining LLCP TLV parsers to
 their buffers
Message-ID: <20260713153434.GI1364329@horms.kernel.org>
References: <20260705115607.60844-1-doruk@0sec.ai>
 <20260710134850.1615092-1-horms@kernel.org>
 <CAPdMp1omRz=vFN=CQsiXDbf+5W3SF-F8BGm3HuNeLpp1uS4UUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPdMp1omRz=vFN=CQsiXDbf+5W3SF-F8BGm3HuNeLpp1uS4UUw@mail.gmail.com>

On Sat, Jul 11, 2026 at 03:42:10PM +0200, Doruk (0sec) wrote:
> > Would it make sense to either guard skb->len >= LLCP_HEADER_SIZE
> > before the two call sites, or take the same skb_tail_pointer() based
> > approach used in nfc_llcp_connect_sn()?
> 
> Thanks for the review Simon! I went with the first option in a separate patch,
> since I believe the missing minimum-length check affects every PDU type the
> dispatcher hands off, not just CONNECT/CC:
> 
> [PATCH net] nfc: llcp: guard against short PDUs in nfc_llcp_rx_skb()
> 
> It adds "if (skb->len < LLCP_HEADER_SIZE) return;" at the top of
> nfc_llcp_rx_skb(), so no handler can see a sub-header PDU and the
> "skb->len - LLCP_HEADER_SIZE" subtraction can no longer wrap. With that
> in place the connection-TLV parser's bound is safe. Happy to respin
> either patch if you'd prefer both changes squashed into one.

Thanks, a separate patch sounds like a reasonable approach to me.

...
