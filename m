Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836E390228
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257664; cv=none; b=o66e+N5al6w/ttHZ4rJbZpM9ERt/Z5RgXwcHZ6joTI9j/xoEaiK0jU+gJ2iIJloDDBHlEEmKKTCUyLC3dFc6+zZnlqg24UascPSjyXB2eMTlj6Ui67aNQqjabnio6bzJTJxUufPCYBZ1EJmJpwkoPlp/UwhLtDfswK7SYIfrVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257664; c=relaxed/simple;
	bh=DgeI2h/ZSOYagFlI4r0DuGkMAsNDlGKXaY2BuZSJ728=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC8k524g2KcrmnhR3qp9Mb9VWgQN/P3P6xztzTQVqqnfZ2GpqzoxE8wNy3AKNF7v70JB7+aHryxtPxsA+yX23F59cQdzG4viGVwpXV+oEzyjV8T/VQ6/AxvmLUyKVM5TWaQZnoubAmyecHdZQrdP4K5O+Q+3PGYQXGNfeIpnIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgRaCrlC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgRaCrlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4701F000E9;
	Tue, 28 Jul 2026 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257662;
	bh=5scje4qRsS/fgUOyF57aWDOkAz+7gsQTlck6sOxR48g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MgRaCrlCzeJtH+zKDVok4H4rWbJkXhjjiRpJjAIaCMLRC4HnL19G7NQmLRMPN1/Hx
	 KzZBj6nr4Vy4dh3C3FEVYV09DDx6ZOHaxom0v102VxynbvtEUJosbhNYBnY7otSSxL
	 /E3JBrZyJRPAj2pdwnjHcjCxU1kiQSpKo5rAiARtRqoUwS4XI6QiQxfgfOwqjf0fzE
	 JYqKD5B/CUo8ZJDVKjcw2hyoSR3rHrRyiVMS390UY0Lo1mFDbCTmIGQdmYLzx7hDQn
	 rAwRhN8ZJ368r+fxhCwma4jFV+JAEYuNh9DINnrMNeUVC8R4kw4Cs5Wm0zpXAQJxvu
	 TcvS+xf+2CgXw==
Date: Tue, 28 Jul 2026 17:54:19 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net] net: libwx: fix FDIR ATR queue mismatch for software
 VLAN packets
Message-ID: <20260728165419.GV418547@horms.kernel.org>
References: <0879DA38A8E32701+20260724074657.10773-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0879DA38A8E32701+20260724074657.10773-1-jiawenwu@trustnetic.com>

On Fri, Jul 24, 2026 at 03:46:57PM +0800, Jiawen Wu wrote:
> When TX VLAN hardware offload is disabled, VLAN tags are embedded in
> the packet payload (software VLAN). Previously, the driver failed to
> set the WX_TX_FLAGS_SW_VLAN flag for these packets during transmission.
> 
> This missing flag caused the txgbe FDIR ATR logic to fall through to the
> default hash calculation path. This resulted in asymmetric hash values
> for Tx and Rx flows, preventing return packets from being steered to the
> same queue as the transmit packets.
> 
> Fix this by detecting software VLANs via eth_type_vlan(skb->protocol)
> and setting WX_TX_FLAGS_SW_VLAN. This ensures the ATR feature selects
> the correct hashing algorithm to maintain Tx/Rx queue symmetry.
> 
> Fixes: b501d261a5b3 ("net: txgbe: add FDIR ATR support")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>

