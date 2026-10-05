Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3871424679;
	Mon,  5 Oct 2026 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242912; cv=none; b=usCS/xTu44uICJTt5ySzExxTHpN85SAaZHMGwhGAohw1pTdoMu+TQKHMeOR7QWQhZecam1BobjYCldQk/qUATYEWxaeBFktrZse7Mh+jpKnEQRf7bqwu1JlBnxgTjZFfkwtbHbe7CO7dnEBprZwM2aX+mKMTtUwBl8LXMzzjEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242912; c=relaxed/simple;
	bh=FVLmQjO/zyOlaCdMccgcrMrTdps/z/PXZTG8qMUt0Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVEMySmPVKWAwDGhmUnAWn63ZoYXRSkGFFZRY6bhcU7DGpaaoOld/jQd8m7pOS/Hn0i8wwC3OTLMfaSPn49Wm9orpwP4BMJ2bDB2GP7MEugnryiYTLzgOB1/7cgMF2dMG+OgSC188vLCf7kOZ9KmSIpjF6AGMc1IZiswNrJzDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rawk6CKr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rawk6CKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1BE1F000FF;
	Mon,  5 Oct 2026 23:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791242910;
	bh=MVSC1ZTOX6aznc08Ydm8DeQB4kGL9X8hXgmrk6Xf7+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rawk6CKrNQ7BPXHOfP7U9zu00LpDyCdr4+hV8K1MqN49Cbqyz4rmG42RNfewt46It
	 XJ+o/0L3QaffTyiZ6TjkOj86ejOZ9UHQaOVwKOLJqc4wieuHYLSUtFo5kDc1YvUvmX
	 XkkAfLgXvL9JtBsPHEBw6bznkiYuoZtrWHlfLVL7/gcZ/Kafs81ahXakXmzaz3LjnR
	 bX/9A32rzhe6AsZrmYiZTcilq+wbHWevWvN+8ZuE/yvA8LcoyucPlq3V1Pmt3tOk9t
	 +yNGjL/u0CCBBS4hdG5ngIpzmExSDNgzE9d+MAocUc7ZEtH9MR3WIuz7W787mBj7xh
	 QLQwjwDamEQ8Q==
Date: Mon, 5 Oct 2026 16:28:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jisheng Zhang <jszhang@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Disable checksum insertion for XDP frame
 TX
Message-ID: <20261005162829.74778c7d@kernel.org>
In-Reply-To: <f0d8c25f-96e1-4da8-af6c-3286610338ba@lunn.ch>
References: <20260929121025.20821-1-jszhang@kernel.org>
	<f0d8c25f-96e1-4da8-af6c-3286610338ba@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 22:29:14 +0200 Andrew Lunn wrote:
> On Tue, Sep 29, 2026 at 08:10:25PM +0800, Jisheng Zhang wrote:
> > stmmac enables TX checksum insertion for XDP frames whenever the queue
> > supports it. XDP frames carry no TX checksum offload request, so this
> > can overwrite a checksum already present in the packet.
> > 
> > Pass false to stmmac_prepare_tx_desc() when transmitting an XDP frame
> > so that the packet is sent with its checksum fields unchanged.  
> 
> This seems odd to me.
> 
> If the frame contains a checksum, it is either correct, and the
> hardware calculated one will come out the same, not an issue.  Or the
> checksum in the frame is actually wrong, because the frame has got
> mangled by eBPF before sending it out, and you want the hardware to
> calculate the correct value.
> 
> What an i missing?

Oops, missed this before applying. Fair, but also we shouldn't modify
the frame if user didn't ask for it. Perhaps 0 UDP csum is used, or
user is trying to build a testing tool and intentionally send bad csum.
I applied the patch to net-next. It can hurt as much as help, but the
direction seems right. At the very least any AF_XDP app expecting csum
insertion without asking for it would not be portable to other drivers.
