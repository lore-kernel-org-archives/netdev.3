Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B63B6BE5;
	Wed,  1 Jul 2026 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936793; cv=none; b=Cl3K8hsHnd5YzmquaupfWuRWt0KfUQJhI3mskerFPiF/4ZROB+Qzzkyan+HWP1K4e/en438lnLnxawC3j0z2KF8kPmTCjI68NCN+ycP1x8jEeJUKv3mV8MAn90aS1GFJgP/LoGr+2h/l+kCaJ55FO9OPAbGbMR10NEKMYijJ1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936793; c=relaxed/simple;
	bh=WE2FhaknAo4n3NtD7nj6mt9tS3GXMVcPnpy5fM3zy2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaEZeEjiGxo/X+j0c8drrHlgt03adK+Yvv7ItyxqER48ay6NQ5WqqY2g7SQl6t6zmdFBxj8UhUtgo9W+bCYAu43lILI4XjRP148vW6QeRBnvGTgCP+zlMJBnRASJJI8/c68tx8Q+S3dzRJjC+6a25tYINCT/nkQQjqO8xNMsV5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=IGnSvqBi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UxiyIjKc; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="IGnSvqBi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UxiyIjKc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4ABA37A014D;
	Wed,  1 Jul 2026 16:13:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 16:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782936791; x=1783023191; bh=jCGHChpU12
	9coDa9i63DYXYHGn52lbuQPOM440eWeio=; b=IGnSvqBiu5iFA2stJ1ltx2u+fk
	Mjgc5IKsfMKdIRHcJkQSKX13FH8OC15N8Twbg9/NXpEaeV1R31e8rZlvadr5MQkJ
	ub26s8IOjBGDwGGYJ1EmvnyPD6k0cpSMspfxzqBSZ5W8SnN37+rWY5WqFdASm3Iq
	ZAQR4ZG3wKujREzPATBx7PVvPidf9/NDGyp/dizw/judOUGz+UK3J6GKlWicJeUG
	vkYTro4al3TUJCqGKU32gI3vEhO327VBFedpE+/98sJlIbkXrI/cbQD3EYKwvEbG
	BQyh8bxytND9n+5klDnFtzoC9G10cw5yOd5VH+fGAXyp0sMULV/mDp7Ryrnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782936791; x=1783023191; bh=jCGHChpU129coDa9i63DYXYHGn52lbuQPOM
	440eWeio=; b=UxiyIjKcrjZ4KmUgfz67Yqvacr8zUbgOk4zXplKG98mtnCY2uDh
	WPkqYt8FbbcX45bJnKIHXh3ehq+X+2ijKi36iFMw8nYOIj46NzTn+nJgtF+YFsm8
	+UBnIVWlIk+tjB+1AKuoWlKs/gWE6L0bcz2Vwo76I66I6orZBN2Bxp36XZhDJSgp
	C+MRUZn4V8lDq/Jl21xbjI6niEfI30wwbk89c6+BTYvh2v/9V+1c3c9ce27QKeD0
	YjG51rziL7mJQsIa4DbTXjEw2jSrxsnDKa1hfsvhmaPeZ4Y52bx4RFVCpB5suJuY
	vOhyWHuJ7iG/xFqeMoWGPzGpE0qwo6a+LLg==
X-ME-Sender: <xms:1nRFaqCEpe7l1E0ezasOIbrZfQG7Hqt7Mq1KwEjOGa4RaTMgeMJq5g>
    <xme:1nRFasoJIIBZ4VPtsifx5tI_iZwx6Pw7ypHH11Op5ozag0IqVvBfzyqWrfHjMBoxr
    XsnvjywwRO9GqDKcI_4i24VOdHILSdckfEtNMWeN_dMzc3nUygZmUE>
X-ME-Received: <xmr:1nRFatG0QFJRC90hFEOeWVp2X0QboxCum91aI86FMaYTYipBdtZBS04vyaOErcOwRWkxFXN2S9uLUAzCnSmt0c20__b->
X-ME-Proxy-Cause: dmFkZTEZbVOxDPnjRXk9Jolm0zM8tJ376mD7n0z4jEuvXmetA6u4xgxFraMcQpBuokYgYE
    gfKpESA7rVxOlz2JOlYChS7myFJxgDI2zarWa4P6dXCDU2sjqUWYNUB7X+sNiqANe8sz0+
    o30hrfy951XjREWF5lI/WirjoRkD1UKo1bzTCrVuoDRmLux5I+g6mqp+ufvvffUW6b5bH8
    E8fsXwwJ/ozU1JRVvOBQlpvpXqeraSyHhyzAaZHizi9u8yIrJwbUuehRh5nlqy3tn7brns
    63JrH2w7a5gXrX4P8kqt4wEdc8NS7S50rzbC4TDYxPijaG2ItjjU5EOqYbUjbG3UpchBjx
    WRXeySrNPF9iEh+NoGP504oULVAnguxO8xWTALtbdRP58DzBcgvxqIBy7TQDVg//oWcwwa
    pgpOqCDYVlZeylbt3HtE0rgi9m7LuHfFHDzGqREkSO88Q5Nu/sIPxNHVuj0UFBU/7QHaOA
    Wxiybh6swYZxpR6CV8WBCXf1V7dkOKsB+P16hika6/TwgB2bu4iDtZBH6wdfZ7YRLi5v+r
    gq1poE9xRXUB1ClEc0PNdUxEPgVF4zfjmv74xOGsJoYvw+IQa6DRa97oBAAikhrEptBTcg
    orDQB70dNqeOGlKLSiSkXmp9j6mBKPhI6vrcEwUH8qJkty3EJK90DUgqOx6Q
X-ME-Proxy: <xmx:1nRFaotBF2kDn7We0o0raGLo7m1zT0VcHnppOsYmNLS55y1mF7NehQ>
    <xmx:1nRFarbr3RZhoyKJEJatQFtQwy1Cbw784khpez1WQB2ctXMuchrlrg>
    <xmx:1nRFag6AeKOYdvPN5wd9GCPspR3m05OpitIX_HXUyFqD5WUbRVbnNA>
    <xmx:1nRFar8kLaebuUULj0nTMm4eBbOAjsAhOSXnf-WO6U6K8YfjvhLf6w>
    <xmx:13RFajIw4OyQ_2dATO3LXpJ6RwBn3u7GWp9GdIMIuTRnhITqWO5ZrjW2>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 16:13:09 -0400 (EDT)
Date: Wed, 1 Jul 2026 22:13:07 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Birger Koblitz <mail@birger-koblitz.de>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, hsu.chih.kai@realtek.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, olek2@wp.pl,
	pabeni@redhat.com
Subject: Re: RTL8159 firmware
Message-ID: <akV008yiRidFHu62@archlinux>
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
 <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
 <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>

On 01 21:29:20, Andrew Lunn wrote:
> On Wed, Jul 01, 2026 at 07:24:13PM +0200, Birger Koblitz wrote:
> > Hi Jan,
> > 
> > On 7/1/26 19:13, Jan Hendrik Farr wrote:
> > > Hi Birger,
> > > 
> > > it looks like the firmware file rtl_nic/rtl8159-1.fw isn't in linux-firmware yet.
> > > Could you send it for people to potentially test?
> > > 
> > > Jan
> > > 
> > The code to create the binary firmware file is at:
> > https://gitlab.com/koblitz-rtlnic/rtlnic_fw
> > But I cannot submit the firmware itself to linux-firmware, as the sourcecode from
> > which the binary data is extracted is published by Realtek under the GPL.
> 
> The obvious work around is to not convert it to binary.
> 
> 8152.c has a clear GPL-2.0 header. So you can edit that file, extract
> the two arrays, and it would still be GPL. You can make the firmware
> loader in the driver parse the ASCII array as it is. It also looks
> like you can .xz or .zst compress it, and the kernel
> _request_firmware() will handle the decompression for you.
> 

Not a GPL expert, but aren't those "binary" arrays in 8152.c a GPL violation?
Unless they created them directly. But I "highly suspect" they are
compiled from some source. They have to provide the "preferred form for
modification"

Jan

