Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA98B502D70;
	Thu, 15 Oct 2026 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063356; cv=none; b=LRt2VrWXEN9XD/NAibVpRDgUAUMEBbrx0Sft2bkMLcBmPeTTGkrfRRB5SIxDcVur01M2HxhOY2gVJi1Bdoi/c7p2NHtbC3kB601fIhdf4iJ5OFTmO091XGhtebvEQs8QLzznadYqFNxeoapd4HI03RgzPonh9mralWN7jIUNHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063356; c=relaxed/simple;
	bh=aMxJHIWlVQlSshgv/y9UUCL7CLcqpL9m3f0H/p2ZYsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V50rbMeuc6wzkKpfrc65jZapVOzgFW8+Vcww8p8NCWpc3nmgUIu8TgeLXRaFGpWThWoV/ak7lEJ1C4pX0tyLtSq28QDqCSQo5jgYjD/tDpxn/3A0vWa/VawjAYEBYLtdOx5lwYiWlN2YSKjj0c09lDha36fD1f1POz1nfyA8W7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce0UlVOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce0UlVOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE041F000C4;
	Thu, 15 Oct 2026 11:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792063345;
	bh=0bZqwPG1wq/RthV+cWbRM5Z37j8aa7pr5Ny6doQT6s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ce0UlVOratY16ZBAbkQpvDIb2sdp+racO2JI7oiOCzsN/+AmqSLEit7LJutDcTmlJ
	 XOJWIB69NqilrTxR5TwojHtZPqk4UQYU+HdffWOoGN4YMIxrQ1k61AqS8uxNjqaWvx
	 0AWGJ/GFo44vQkpkh6ZRTmLIZG+SitDzJ1Bey1tnGFVbJiLkVyNzsjVMRLatBxlRBY
	 VLfLHFG63dCVqhuW3Pn6GVOzDvrSx+rQGCaBvfWjBgY7i25ToxYB5wH5FLp8Y0JmVl
	 Mf7Wg4SlwZwFmDjmSl2c65Z0lOK15Bv7PqKD45TWymoXzsj873oNeYa/iwzabH9gzp
	 /qb9I6VPYhiJg==
Date: Thu, 15 Oct 2026 12:22:21 +0100
From: Simon Horman <horms@kernel.org>
To: mail@gmelikov.ru
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bnx2x: fix header length calculation for
 encapsulated TSO
Message-ID: <20261015112221.GG83879@horms.kernel.org>
References: <20261009-bnx2x-tso-fix-v1-1-1ebea422422d@gmelikov.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-bnx2x-tso-fix-v1-1-1ebea422422d@gmelikov.ru>

On Fri, Oct 09, 2026 at 08:30:18PM +0300, George Melikov via B4 Relay wrote:
> From: George Melikov <mail@gmelikov.ru>
> 
> Commit 80bfab79b835 ("net: adopt skb_network_offset() and similar helpers")
> replaced the difference between the inner transport header and the outer
> network header with skb_inner_transport_offset().
> The helper is relative to skb->data, so the new calculation incorrectly
> includes the outer Ethernet header in fw_ip_hdr_to_payload_w.
> 
> On a BCM57810 transmitting TCP over VXLAN with an outer MTU of 1500,
> hardware segmentation emits packets declaring an outer IPv4 total length
> of 1514 while the actual IP packet is only 1500 bytes long. The receiver
> drops these malformed packets, severely degrading TCP connectivity.
> 
> Subtract skb_network_offset() to restore the original calculation of the
> length from the outer network header to the inner TCP payload.
> 
> Reproduced with plain kernel VXLAN and one TCP flow on kernel
> 7.0.0-31-generic: 50 of 200 captured packets had an invalid outer IP length
> with the original driver, versus none with this fix. Disabling TSO/GSO on
> the test VXLAN device also eliminated the error with the original driver.
> 
> Fixes: 80bfab79b835 ("net: adopt skb_network_offset() and similar helpers")
> Signed-off-by: George Melikov <mail@gmelikov.ru>
> Assisted-by: LLM

Reviewed-by: Simon Horman <horms@kernel.org>

