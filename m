Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B833E35D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096205; cv=none; b=u19RwzoUJDTnKKqGyLayJPsz6yRSMTTSSaZ1iZU8ohHd2QzFbbYgqiJ4uq+hbmQerWbuVFPXIJbUaHnho4Cttqwrem9hN7BB6qZaVXEXVTW/hh4GW0ab51I+YIwIF/aAP7zzf2IIlozsaFB/rtIUmDdk1/bd8/n8U6d8iLQrtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096205; c=relaxed/simple;
	bh=KLkKNXTbTdeo2MDcbb7rXz0AoJnJZRgPD47siNnfhUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB5Mo7GmrU4QhSGeETgZDwRyXFVxWQR0LgFCPe6eREfp9UXun4CSsvChpExzhmWLWcFDPD6TQ75lEoKqmr4iQQXvQ3gzgsGockqi59ySfUvFLFGuLjc24krEopdKo/4TNFJZ6gkQ8KKq4FGLNzxalZTOsB1p/q0G65Ofq5ztiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDzPzi2X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDzPzi2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3BBC116C6;
	Thu, 22 Jan 2026 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769096204;
	bh=KLkKNXTbTdeo2MDcbb7rXz0AoJnJZRgPD47siNnfhUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nDzPzi2XeXxPMBzrtvaSUf3SlCvMzUhx/3HMeeIyhElkEoDhIbiNyeuMtNBzixCYb
	 7DNPg1053YzstLlt+00ZZSj1A+rEIX2RSAbMi16qs2FpoSDPGDr82vefSwc/56wLZE
	 sjabZyCHiWiP+EszbFAeoIUjLFC2+r2V+JtlMKu0X+5j9KSzxThuvJ5TyE66QIkX/K
	 qG6vxHE50tlC7B/pzp+Ddbi1Zvzls5kO6BEt332cV8jmIlOkg5qfYNFLa0TyoebpNc
	 Zcw3EzI2+ycfIxG8tKndcqGwx/d7o80kjXKUguSmeri95a5DDXmFPTni4iLRqUPrju
	 BAlXrknJRjSbg==
Date: Thu, 22 Jan 2026 07:36:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <michael.chan@broadcom.com>, <sdf@fomichev.me>, <almasrymina@google.com>,
 <dtatulea@nvidia.com>, <asml.silence@gmail.com>, <dw@davidwei.uk>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH net-next 1/6] eth: bnxt: always set the queue mgmt ops
Message-ID: <20260122073643.4d36e299@kernel.org>
In-Reply-To: <20260122080420.GA1544331@kernel-ep2>
References: <20260122005113.2476634-1-kuba@kernel.org>
	<20260122005113.2476634-2-kuba@kernel.org>
	<20260122080420.GA1544331@kernel-ep2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 13:34:20 +0530 Subbaraya Sundeep wrote:
> > +
> > +	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
> >  	if (BNXT_SUPPORTS_QUEUE_API(bp))
> >  		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
> > -	dev->request_ops_lock = true;  
> 
> Can we also mention that driver with queue_mgmt_ops set makes it as ops locked
> driver in Documentation/networking/netdevices.rst ?

Did you check if it's already documented there before asking me to do
it? I know people don't read docs much but asking someone to document
stuff that's already documented is a bit funny..
