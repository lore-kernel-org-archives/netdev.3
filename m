Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678BE12C534;
	Sat, 26 Sep 2026 04:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396307; cv=none; b=OI7EZQ7GfxfpzPJXbYujbw0RXEIBYtKnBnXLIZ+8X1OEWiwap5YKzMHHn9RH4tHBQpLyAl8X9xR8y6LsL8yUtPPP4fs7Ozg8WJ2w5NqMzyugWGGQzBVlcdo4f86SKmD1xBYV24fQ42xtZD9CQVEHr0GWI3oHOxNwCBB2pTFqamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396307; c=relaxed/simple;
	bh=PRfOzZrYIdg1BcLblrEwxtGq+g0dYvoRy7CknEd4ogo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cYuLvM5JGB1bqL6uDcKZ+gRqe0HNzNT/F8piveo82zR7vKGoaKm1iF4ZmYihGXnvPbXhkXgE6UTgGjYi8OrBPln3VP4/1YKTMnFOgGfwNAMhG9p38pruQHlr+UxF1ZgnrIl9P2rZTvviK9EaqhMsWXSrPWTFKKAxvEU2RVUqPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Wtink7/2; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=NFXffhzp; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Wtink7/2";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="NFXffhzp"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68Q4HhaG012552;
	Sat, 26 Sep 2026 06:17:49 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id DC322120F5D;
	Sat, 26 Sep 2026 06:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790396259; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAXY2biKxunPrl11EaBx+857E89xXyTGFogWVcbu66E=;
	b=Wtink7/2uySDOMS/1vz1DLI9hL12TgbfnHvXobGaIVwMe0Dtp5JgRXcKh5YXezHrykKvXa
	QhIGB4ZK5TN0FuCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790396259; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAXY2biKxunPrl11EaBx+857E89xXyTGFogWVcbu66E=;
	b=NFXffhzpK20XNzzwl2Eq2ABpFeFF759Ri0YEUqTa7tIKRdeIEo/+q4MZ9U47wuSysI+pWX
	qeWWBvL+ucxc1fNQJM9w94gU+t+GOkhTmOBsN4nEhInEptjpV2nUILJxeyVf/FfbFPL9Yh
	h8omKSN8kJqTBK0tNdJZebntsXp9ntiWhXfnNTfyedqIB4p6I+kZHzy4bplpFse3bLS8wG
	BX4wVDE2WXLWRmiFNQw6WxtyubZddo31Afzypfv7FaFoEhFwteMdZ4e/l//NCJt/Er4XXB
	ZEzITB5VXmwh/tdELLbYeQj5Hpnhz0Jwb4OSM1GLqEHu9CXgXL9LP/E/wQY06Q==
Date: Sat, 26 Sep 2026 06:17:38 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        David Lebrun
 <david.lebrun@uclouvain.be>,
        Ahmed Abdelsalam <amsalam20@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefano.salsano@uniroma2.it,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: fix HMAC validation when an extension header
 precedes the SRHA
Message-Id: <20260926061738.25343ff4cf4ecd54e7f0750a@uniroma2.it>
In-Reply-To: <20260923-b4-seg6-hmac-transport-header-v1-1-3ae85dc0fdb9@gmail.com>
References: <20260923-b4-seg6-hmac-transport-header-v1-1-3ae85dc0fdb9@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Wed, 23 Sep 2026 13:51:37 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

> seg6_hmac_validate_skb() derived the SRH from skb_transport_header().
> That only holds while the two coincide, which is not true on the
> seg6_local input path.
> 
> ip6_rcv_core() leaves the transport header just past the IPv6 header.
> A Hop-by-Hop options header is consumed before the route lookup and
> advances it, but a Destination Options header is not: the seg6_local
> lwtunnel is entered through an input redirect from the route lookup,
> which bypasses the extension header handlers. The transport header
> then still points at the Destination Options header while
> seg6_get_srh() has located the real SRH further down the chain.
> 
> The HMAC is therefore computed over the Destination Options header,
> and a packet carrying a valid HMAC TLV is dropped when
> seg6_require_hmac is set. Such a packet is legitimate: RFC 8200 allows
> Destination Options before a routing header, and get_srh() has walked
> the header chain since commit 5829d70b0b6c ("ipv6: sr: fix get_srh() to
> comply with IPv6 standard "RFC 8200""). The misread header is covered
> by the pskb_may_pull() in seg6_get_srh(), so the result is a wrong
> verdict, not an out-of-bounds access.

Thanks for the patch.

This patch also closes an out-of-bounds read that the commit message
does not mention. The commit says the misread gives a wrong verdict,
not an out-of-bounds access. That holds for Destination Options, which
has the same length encoding as the SRH. A Fragment or an Authentication
header is encoded differently, and a forged packet can put one before
the SRH. The old code read that header at skb_transport_header() as an
SRH, and seg6_get_tlv_hmac() computed the TLV pointer from its second
byte. The pull in seg6_get_srh() covers only the bytes up to the end of
the real SRH, and the TLV pointer can land past them. This runs before
seg6_require_hmac is read, and the default configuration reaches it.

Before this patch, a forged Fragment before the SRH toward an End SID
faults in that read (KASAN, DEBUG_PAGEALLOC):

  BUG: unable to handle page fault for address: ffff888106304078
  RIP: seg6_hmac_validate_skb (net/ipv6/seg6_hmac.c:91 net/ipv6/seg6_hmac.c:192)
   input_action_end_core.isra.0 (net/ipv6/seg6_local.c:225 net/ipv6/seg6_local.c:413)
   seg6_local_input_core (net/ipv6/seg6_local.c:1640)
   seg6_local_input (net/ipv6/seg6_local.c:1662)
  Kernel panic - not syncing: Fatal exception in interrupt

Could the commit message also mention the out-of-bounds read?

Ciao,
Andrea
