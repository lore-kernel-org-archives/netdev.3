Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B23AC17;
	Tue, 29 Sep 2026 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640604; cv=none; b=M1Hez4522vDVTcCY4abcxsIrALw2iTykc2CPMc4kXC0H3EfLH8Yjf9vOEGBX55RprepjMY2v0BU+i2VAWAKhFieSBa0ILGZZJRZ6UfNz/4hReynKK6hV8w4BtP4tsucAwBmlQv9LMBi1lOTVS50hjb1OOd/pnp28nxgMUZ4DkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640604; c=relaxed/simple;
	bh=ogWPXa3OmOemOIrdalpKhlp0GXjF8su/mbdf1pUG6gs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aldKDuV9WIZQGo4cKvTjI7owEfK1K5QR57CFwcQtnn7JZtK5jvcxXPAouKYtMNdgr14XQ361yrtChnY+LhMdwu+Nqbb1AA26L8hjNnR0lrobYzAhC6P9lA59JlgiSIHerJtPndDxEnOF9FRqLvcwa3YkT2I4ZuaZNXqGbog46Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=w9puXF4L; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Rf09jPSn; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="w9puXF4L";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Rf09jPSn"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68T09Ejs016839;
	Tue, 29 Sep 2026 02:09:20 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 0C5B81228DA;
	Tue, 29 Sep 2026 02:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790640550; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNEBx0donm4onnrz2bLETUAax8MpsLPKRrw3g7K/vUs=;
	b=w9puXF4LCcieu/DCxtfxSlv/xU60R0dC90OI4hEb4CTrYPgsghiYfs0NCgocMMecO4uY/5
	mYIBv4rzzsidgADg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790640550; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNEBx0donm4onnrz2bLETUAax8MpsLPKRrw3g7K/vUs=;
	b=Rf09jPSnWSduNJNf3R8s347YGjJIXFU7dbesS3uOeD/F1fJorxcRzz3KTxIEupeR+Xd4aX
	lvHJLYdNwDjtGWVr16EwjUxq65SnyzWUa/TOVj+D209Pd3zQK7R0xF/gn8IF+ZAXm+fSzw
	oG80B48JXaxgzf+b7/aMLWZtFc8PXWRc0pjPM9llVPC1gzQ/PfuyrwSPRw4MxB9vXnYi0D
	k8G02NariijsJ1olkRIpvIX46KR4U5sLnEpjwTG6V8Lg8qt/2iVR8he5YPqX9uoLfIjnft
	Ed2nmzX55BiG6WroLBoavRTe8gZF3TgOni34QUDf9x5f3/tE1+ggcOzekvO7rg==
Date: Tue, 29 Sep 2026 02:09:08 +0200
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
Subject: Re: [PATCH net v2] seg6: fix HMAC validation when an extension
 header precedes the SRH
Message-Id: <20260929020908.5b62f1d0e1fca1502ede735f@uniroma2.it>
In-Reply-To: <20260926-b4-seg6-hmac-transport-header-v2-1-8087b76f6375@gmail.com>
References: <20260926-b4-seg6-hmac-transport-header-v2-1-8087b76f6375@gmail.com>
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

On Sat, 26 Sep 2026 20:19:27 +0900
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
> comply with IPv6 standard "RFC 8200"").
> 
> With a Fragment or an Authentication header in front of the SRH, the
> same mistake also reads past the data pulled by seg6_get_srh(). This
> happens before seg6_require_hmac is read, so the default configuration
> is affected.
> 
> Reproduce by giving a node a seg6local End SID with
> net.ipv6.conf.<dev>.seg6_require_hmac=1 and a key installed with
> "ip sr hmac set <keyid> sha1", then sending
> 
>   IPv6 -> Destination Options -> SRH (carrying a valid HMAC TLV) -> payload
> 
> to that SID: it is dropped, while the same packet without the
> Destination Options header passes.
> 
> Fixes: 5829d70b0b6c ("ipv6: sr: fix get_srh() to comply with IPv6 standard "RFC 8200"")
> Assisted-by: LLM
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
> Changes in v2:
> - Describe the out-of-bounds read reachable with a Fragment or an
>   Authentication header before the SRH (Andrea)
> - Link to v1: https://patch.msgid.link/20260923-b4-seg6-hmac-transport-header-v1-1-3ae85dc0fdb9@gmail.com
> ---
>  include/net/seg6_hmac.h | 3 ++-
>  net/ipv6/exthdrs.c      | 2 +-
>  net/ipv6/seg6_hmac.c    | 5 +----
>  net/ipv6/seg6_local.c   | 6 +++---
>  4 files changed, 7 insertions(+), 9 deletions(-)

Thanks for the v2, and for addressing the v1 comment.

The code looks good to me.

For the record, the v1 Sashiko review noted another effect of the same
bug. A captured HMAC can be reused in a Destination Options header in
front of a forged SRH with no HMAC. With seg6_require_hmac=1 that forged
SRH was accepted before this patch. After the patch the HMAC check runs
on the SRH the behavior uses, not on the header in front of it.

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Ciao,
Andrea
