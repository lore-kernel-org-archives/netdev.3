Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740879;
	b=IZMWjpVWTkGY+h9EpPBdRq34PqYnCEKty1FsupvG0bvvKy9OQiqPUSY6N/iwi+oCAHgU
	 +lQNHbFBlqkNJcPUZVWGrv6jjPWw5KcWpowceuubi+1Nh41SYnsRa7ipbxeCRDlBAvvaF
	 V1CmJu4VNbNt4jOBFnuS4sQYJRWMJ9ot0PM9f6CxVUvuiv1cKbGeubSO8hzhTSh2Ejpvo
	 gE9C9XzgUMm3bvZ/cuhUIWXWAXuB7jQOmcAd5rEjGRzDBYSvBC+i8QYQxfLhzRs1goqCe
	 UjIX57FV6p79yY2osQTUgVlWlCegrncbthg9QoPgbEvOnNoY4K8vnTl8bMiMTTgZdsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740879;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OIX7l9JSAlMqQr0Ju+ts9cEQxL6n0uf9RUiDDUXeVNk=;
	b=Ch4Y87cNXJ4hw7QPmdcftMkH0pNrYUNN/Np81LDnxgU1WArV87L34H+ae+R6Db9D4PfN
	 f1YDzWtsgcT9JwXvIipuYQoRKFTDc1oOe2/ALWJ+eR2U5Lr1RM7XcSn/ymNNAo6lpbGCZ
	 GSKzXOrm97kBlQZAwbci/w/uPXOWTU9YrwSY6Hoqaw0F2Xs2ZDJSGhteqYv0D8U63ue+V
	 nR4zUmrzMAk8U0WAC05YZjw5BLz7AwIjZL/FgkoJaqnCW8K6Rdjqh/EAeSM2Db8p/S6SM
	 TmICmoncJeJr+RvKprzkOTP1f8OM4cJbN+pFMm67aLkLKtC9Lu0QLK0kSqq+SevHCAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ct3RZzN4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D2606A328;
	Fri, 23 Oct 2026 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ct3RZzN4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E3E1F01828;
	Fri, 23 Oct 2026 07:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740878;
	bh=OIX7l9JSAlMqQr0Ju+ts9cEQxL6n0uf9RUiDDUXeVNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ct3RZzN4FJzAgCV52jbDVDNq9GVv8I51XFFJHPXlHaFYSdf36kkOA5pWMm9a6Twnt
	 moism0coMV3XQTlXilR3+WnBaYjky98vNdZeH9T+VYV4NDmnKNoLl7BKOl3C5Xgvdr
	 xXnZRnhRvap+mS/jSkfMbC/4ld0F90kOYqOCTiTbuDn75BRT5KrT8sdEaXi5XYcgLJ
	 GIaiNccrKFRrgs2tHq2Rx5sly+0lGsa/tkkGUy16qXyv/mWv4dUtAUfSl19Eiit8Nr
	 JwcnEkQsKulvCRRSoOzy9yrTp37ptNuJuJW5WlKfAIFDuV4ozP2YAQEM+K1aSX76e+
	 NF1dRo6+GdNtw==
Date: Fri, 23 Oct 2026 08:34:33 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sparx5/lan969x: do not read past skb->len when
 injecting a frame
Message-ID: <20261023073433.GG708417@horms.kernel.org>
References: <20261021-sparx5-inject-tail-bytes-v1-1-7dcc035c8ddf@microchip.com>
 <20261021112533.m6fh7xoqp74uevho@DEN-DL-M70577.microsemi.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021112533.m6fh7xoqp74uevho@DEN-DL-M70577.microsemi.net>

On Wed, Oct 21, 2026 at 01:25:33PM +0200, Daniel Machon wrote:
> > sparx5_inject() writes the frame to the injection FIFO one 32-bit word
> > at a time, and pads frames shorter than 60 bytes with zero words.
> > 
> > Before this patch, the last word is loaded whole even when skb->len is
> > not a multiple of four, so 1 to 3 bytes past the end of the frame are
> > read. For a frame shorter than 60 bytes those bytes are also
> > transmitted, as VLD_BYTES marks the whole last word valid and the
> > padding starts at the next word.
> > 
> > Write the trailing bytes from a zeroed word. The number of words written
> > and VLD_BYTES are unchanged.
> > 
> > Found by an AI code review agent, and reproduced on lan969x and sparx5
> > with register injection: bytes 57 to 59 of a 57 byte frame were not
> > zero. With the fix they are zero, and traffic still passes on both
> > chips.
> > 
> > Fixes: f3cad2611a77 ("net: sparx5: add hostmode with phylink support")
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> I somehow forgot to include the target tree. This one goes to net.

Reviewed-by: Simon Horman <horms@kernel.org>

