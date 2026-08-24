Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D242124D;
	Mon, 24 Aug 2026 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577170; cv=none; b=k87syjoutbSxAjKAkcbhg96P/3v/w6E2U8l4ATuJesrqMwvGUBW3LCk9C6Edwd72qC8gsfvNAVmGyBNEGcGZh+kTDEVK+yqXIEd/KPw1kcxYdViQ6QJu0dIjm7OcG67yPMPzVmKae0i741/MFNNdj4uijCr5D+NlRAG1WHuJ14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577170; c=relaxed/simple;
	bh=u9SlXrfDOHq1Nj4+daTPm7pCwXFGa6NhLZQJmqreZKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W12s94iBSXnF9C0eMd1Ux6/ZE6YgvsohUMwrMGu0d90AYZgrmsR/HQ9me20ojZxRwncTh08OpOx2NBWG+vNb9E9WQiOOXTJjZtBtcKI+EyuS8cfNuGnF3tHaIbaoiyV3dxIcGL6nRBrnJp510fUgeqGEY5O2Tw+/4uVRe7DVyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QOY7plp0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QOY7plp0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yrahLtGXocGr+XcQPK2B9R3EUhFrQtHp4fiYHBBJDys=; b=QO
	Y7plp02Mrw+9BzSbPTYSyhaIFj+hdhopFTEVR+nONXmlXuyVvUYiuQ5tTq0cpZfgPbeL12i80dQRa
	G9/0vWzgOdLfR2+12gig1K69o+241jMo3GPrHtVhKzA2bXLlaMqcKOv+rKVszPe2jTK/yZT8zD7GM
	+hxIxg6j4RyQ7ew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyUTd-001Ejo-O6; Mon, 24 Aug 2026 15:12:37 +0200
Date: Mon, 24 Aug 2026 15:12:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: manushprajwal555@gmail.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Dege <michael.dege@renesas.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Message-ID: <d76baca3-4ccc-469f-82e2-477f3aefad4f@lunn.ch>
References: <6a882352.ee10049a.267d65.7a31@mx.google.com>
 <92de3894-3511-4f13-950f-60b3f6911504@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92de3894-3511-4f13-950f-60b3f6911504@web.de>

On Mon, Aug 24, 2026 at 10:15:15AM +0200, Markus Elfring wrote:
> …
> > Rework the function around for_each_available_child_of_node_scoped()
> > instead of adding a manual of_node_put(), so the iterator's reference
> > is dropped automatically on every exit path. Since port is the
> > function's return value, take an explicit reference with of_node_get()
> > on the match before breaking out of the loop.
> 
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> 
> See also:
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.2#n145
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v7.2#n34


Hi Markus

The stable rules include the statement, the bug being fixed must
bother somebody. Do you know of somebody bothered by the reference
leak?

	Andrew
