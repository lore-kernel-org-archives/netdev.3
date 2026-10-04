Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975014A92CD;
	Sun,  4 Oct 2026 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147650; cv=none; b=rNMX1qJVsYxuVAqwnVe7xvZYXML128hDhGPRJ0IMtMZGaeztAMfFUIUDCileYowXEWjLPxZVxql1JWE3mPgJRUvC6/ADr+KxM7012pQ1+6uzpsOzk4SWJZPRjnDvG74HQ0M9VrTy0r0mwbgxMnwTbZ7S4opFj7TEONg4oVcKrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147650; c=relaxed/simple;
	bh=yJzxAaE7DsIPJ0sxkJdxyyLR4ki2kma1YNBAgjBaN/U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hE3vgFAeR+b1fUj/gYhY1YFB4FlIJ7MJkVeAZjAQuZMAT3DSMOSiu7wnSiYfxsaDKecj2hOHrDRQ1L5BieWb/K4wk75xbyZiQTngKDyMY+Hpa+09xDTZ+3tbaFoivrwOWtaUZbafIVPX2B7i80U5wnSdGC+QLC4jPAf5cJ+6d9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCujPkKV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCujPkKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B222D1F000FF;
	Sun,  4 Oct 2026 21:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147649;
	bh=f+nHVQcYlKCLHXteS2PIkcNKXvUVcpVr7sGKBq9dLz8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jCujPkKVfsFQ6b1lYm0lQsJ7HIbMEr4bzPQi3MIS6DaTpBmgaDYx0Eg5bYnZHwvq6
	 PL5GKc0GygmFvwrvpOL3Yepef1kXzd71Aaib+kOwb8+jf6CcnKNP6Sx/NIu2dRtCeF
	 rYx9J1M2Ccl0ZAgwEvo8Ea1qc0+I6aStn+ZWeQyx4TGaoafmF/FHzkDlclRq6qwkmR
	 1bcLdNy08E+kjJj3qEYbWMPbtAaxFgdEonZ7+toBu+d6S1Zesa2WMmJjD/0JmD0rl2
	 JkOu7RCzdJ7gy9tydbzG3oqRosZ8o4xlKmW8JoDptO/t/bNGLhxM43yip0tafplAbi
	 q23kk76nkE9ww==
Subject: Re: [PATCH net-next v5 07/14] ip_gre: add drop reasons to the RX path
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 21:00:48 +0000
Message-ID: <179114764827.434549.329518181253885582@kernel.org>
In-Reply-To: <20260930183910.3151873-8-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-8-littlesmilingcloud@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Both concerns are resolved by the next patch in the series, so
  neither is a real problem.

--

ip_gre: add drop reasons to the RX path

This patch converts erspan_rcv(), __ipgre_rcv() and ipgre_rcv() in
net/ipv4/ip_gre.c so they return enum skb_drop_reason instead of the
PACKET_* codes. When no tunnel matches, the packet is now reported as
SKB_DROP_REASON_TUNNEL_NOT_FOUND, and the kernel-doc for that reason is
extended to cover GRE.

> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 0d963f18a21e1..6f5273e16548a 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -550,7 +550,8 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_TUNNEL_INVALID_HDR,
>  	/**
>  	 * @SKB_DROP_REASON_TUNNEL_NOT_FOUND: no tunnel device found for the
> -	 * packet, e.g. no VXLAN device for its VNI
> +	 * packet, e.g. no VXLAN device for its VNI or no GRE tunnel for its
> +	 * endpoints and key

[Severity: Low]
At this revision, only the IPv4 GRE receive path reports this reason. Is
the new description a bit broader than what this patch covers?

In net/ipv6/ip6_gre.c, ip6gre_rcv() and ip6erspan_rcv() still return
PACKET_REJECT when the tunnel lookup fails:

net/ipv6/ip6_gre.c:ip6gre_rcv() {
    ...
	return PACKET_REJECT;
}

So gre_rcv() in ip6_gre still drops an IPv6 GRE or ERSPAN packet with no
matching tunnel as SKB_DROP_REASON_NOT_SPECIFIED. The same "no GRE tunnel"
event is therefore reported differently for IPv4 and IPv6 at this point.

The next patch in the series, "ip6_gre: add drop reasons to the RX path",
converts ip6gre_rcv() and ip6erspan_rcv() to return
SKB_DROP_REASON_TUNNEL_NOT_FOUND, so the mismatch only exists between
these two adjacent patches and is gone at the end of the series.

Would it make sense to move the kernel-doc update into the ip6_gre patch,
or to say in this commit message that IPv6 GRE is converted next?

>  	 */
>  	SKB_DROP_REASON_TUNNEL_NOT_FOUND,
>  	/** @SKB_DROP_REASON_MAC_INVALID_SOURCE: source mac is invalid */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930183910.3151873-1-littlesmilingcloud%40gmail.com
