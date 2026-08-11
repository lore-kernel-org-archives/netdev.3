Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8978347506;
	Tue, 11 Aug 2026 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451333; cv=none; b=ehrTgj9rgyLJg7hDjFbDsfLVPsHCBtjQ+VurMQ646ap9XoVkUf3HNfTwQlZSbdw7LPxpg8yYGZeunzSZDC43ZpDoixwbkzGGw6jXKR8HrtBSAAUwUZQXQsRbjqL8HI5XN4rSZqTmnfDVUPQu490SFu8TKHOhnjylHvAQW8eMOoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451333; c=relaxed/simple;
	bh=1HJM2k2JV3t2FQTApIRUtJS3EfIQx0T4Q8RZFnZ1pCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cavm1vE85VEOQevj0kmynhgsHdjJvqItJc6o1Dr5vwYEzXHkbetUsQ8B0B8JrtR/FfHfYVH2ntey7q+qGuBzUyyr7qDkvFt5nvG2iSqSEJ5B/PRScrBlJ5t9fcrWG3Wn0SKKDCeTrNDdtLkC98UxLK+31WKjjsKssvlcBhBvYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nvnqsi03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nvnqsi03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753801F000E9;
	Tue, 11 Aug 2026 12:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786451332;
	bh=UdIsiKVFhDlUuCmo+fjPrnJmZm9dNzKypop6Jsqk+DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nvnqsi03F+RfEqUTxbHVk4abr18YXEWVCCrDXlLBMcqDVcVUMHQKjBe+rTy10zjrR
	 nvGI8iMn94HEUCE2YgUDchFhUss04at+jYO36ynOfDrqY9Geab3qSitraUVxIJTL3o
	 HoMkM5l1aDheIiTj3GbUX6kY024CeyPuo9ZQaxT5XKBFalTXyBM4hGceXIbkk5zzrQ
	 ttiZLVixvpiHINlPVQdV/gL1K0LP2E6zY6WQzbfzgLfaDOv3pPWXLkn/lir0BDo0PQ
	 jnwJwoa0tPjGWYEC5oHXzkNDLQZUHmOHxk2BorFkxci5zk0+kNXAwNhwnPAtElzePU
	 JTipzctWNekHQ==
Date: Tue, 11 Aug 2026 13:28:48 +0100
From: Simon Horman <horms@kernel.org>
To: raoxu <raoxu@uniontech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: lg-vl600: fix Ethernet header on fragmented RX
 packets
Message-ID: <20260811122848.GE51943@horms.kernel.org>
References: <30CC616506DE5BC4+20260810084435.2099229-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30CC616506DE5BC4+20260810084435.2099229-1-raoxu@uniontech.com>

On Mon, Aug 10, 2026 at 04:44:35PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The LG VL600 RX path can assemble one device frame from multiple USB RX
> URBs.  In the single-URB case, the input skb passed by usbnet is also the
> buffer being parsed, so @skb and @buf point to the same skb.
> 
> When a frame is completed from current_rx_buf, however, @buf points to
> the assembled skb while @skb still points to the last URB fragment.
> vl600_rx_fixup() returns @buf to the network stack in that path, but it
> currently obtains the Ethernet header from @skb.
> 
> As a result, the source/destination address fixups and the IPv6 ethertype
> fixup can be applied to the final fragment instead of the assembled skb
> that is actually delivered.  Use @buf for the Ethernet header so the
> fixups are applied to the packet being parsed and returned.
> 
> This has likely gone unnoticed because the common single-URB path has
> @skb == @buf and therefore behaves correctly.
> 
> Fixes: 7a635ea98999 ("net/usb: Ethernet quirks for the LG-VL600 4G modem")
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Reviewed-by: Simon Horman <horms@kernel.org>

