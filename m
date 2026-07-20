Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F554400DFC;
	Mon, 20 Jul 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565682; cv=none; b=UTJeQEcfccomGbzrY5NPrYmxI6y+Ux+hBi+JYnHwnUl8+Av1hu83qHt5RiOcVTkJUSf2sTD/BvssWM14msdbsYaxYPveNiSTaeOT9I5XeUTF7SKGxbymjx0e6HVDrPtymDsplESBvadaqCCBqyRquy5pfXkIBlOldUzf6YaYLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565682; c=relaxed/simple;
	bh=pScZLB9Tn+gBR7iYan+L02fL/2LbwJCcUfXQLiE2lIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmbNt3dfQXnHro/6tWMvjvIABfoZu7rEOrwl27MR1f7LQxoYAxH8OyO+OlG8uyP2loX7ulvhudIlJtD58QN0agS2kAyt2f8qtiy4wzyHYJa10qtWMMiOKnHp4SNowQIaij8rxJGetYqboWMkQh04eufz9ns+2TtE/u4TWL9I19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViKUwgP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViKUwgP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB311F000E9;
	Mon, 20 Jul 2026 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784565677;
	bh=TQMFte7ZvFjzNO4g3+cooiPeV9FPBgvcM2Yqfi1n/y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ViKUwgP3x4cOfuA3pKhU/k6DCnGP24n/OocnIFpG0L9kCoRKjRxjxkYsTTI8mUvla
	 vpHiLw3tomoo4v7QwLvztdpHW8jGqA7uYnq1Pycf1v1IKpsBBvMiiFsuHHUaKjH4Hy
	 F3af28yNdDzsYhy6X4x8qjzQ+42gDqVovSI7Dfo+78hy5SV9UX7rFCLuR6kCNZffdw
	 0+zeMYaslzFVpTJNreU6/BZHKdhgT4cMxPxY+fCy8UYQWG05XSHC+CR+o7iEHCOwOx
	 5rNGVAa75a5NOflJyFpk3kzodLe33o0KLJgCuj4WNJa21omnvwjzgOcp4htWt+btiB
	 jm/+bMmFy3x9w==
Date: Mon, 20 Jul 2026 17:41:12 +0100
From: Simon Horman <horms@kernel.org>
To: Harshaka Narayana <harshaka.narayana@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
	edumazet@google.com, linux-kernel@vger.kernel.org,
	guolin.yang@broadcom.com, sankararaman.jayaraman@broadcom.com
Subject: Re: [PATCH net v3] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for
 Geneve packets
Message-ID: <20260720164112.GG19108@horms.kernel.org>
References: <20260713140915.3381715-1-harshaka.narayana@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713140915.3381715-1-harshaka.narayana@broadcom.com>

On Mon, Jul 13, 2026 at 07:09:15AM -0700, Harshaka Narayana wrote:
> vmxnet3_get_hdr_len() assumes gdesc->rcd.v4/v6/tcp always describe the
> outer header, but for a Geneve-encapsulated packet the device can set
> them based on the inner header instead, signalled by the
> VMXNET3_RCD_HDR_INNER_SHIFT bit in the completion descriptor. Since the
> function never skips the outer encapsulation, this mismatch triggers:
> 
> - BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP), because the outer
>   protocol is UDP (Geneve), not TCP.
> - BUG_ON(hdr.eth->h_proto != ...), when the tunnel's outer and inner
>   IP versions differ (e.g. outer IPv6/inner IPv4 or vice versa).
> 
> Check VMXNET3_RCD_HDR_INNER_SHIFT up front and bail out, since the
> function cannot locate the inner header it would need to parse. Also
> convert the remaining BUG_ON()s in this function to return 0
> defensively.
> 
> Fixes: 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2 (fwd)")
> Signed-off-by: Harshaka Narayana <harshaka.narayana@broadcom.com>
> Reviewed-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Reviewed-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
> ---
> v3:
>   - Combined the two early return-0 checks into one condition
>   - Replaced stacked Signed-off-by tags with Reviewed-by for Ronak
>     Doshi and Sankararaman Jayaraman
> v2: https://lore.kernel.org/netdev/20260709201654.4108084-1-harshaka.narayana@broadcom.com/
>   - Check VMXNET3_RCD_HDR_INNER_SHIFT up front to catch the Geneve
>     inner-header case directly, and convert the remaining
>     BUG_ON(hdr.eth->h_proto != ...) checks to return 0
>   - Reworded commit message to describe the root cause via
>     VMXNET3_RCD_HDR_INNER_SHIFT
> v1: https://lore.kernel.org/netdev/20260707165248.1859188-1-harshaka.narayana@broadcom.com/

Reviewed-by: Simon Horman <horms@kernel.org>

