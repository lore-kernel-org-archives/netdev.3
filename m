Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F99374E66;
	Tue, 28 Apr 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334401; cv=none; b=cs5jmy04dVWUZzkIMKQsMT3TJyC01y/cn5OTEZls81lMxlAmWZQr4QDRFHPXyb8tN98Ci2vQMVmfkiZt3b5O87RcVGAWdMgJVwvWAfgpTxHSUZbApqWjFvtHlIibKyXnIZpFq+RYI1xKavwhBggKYvpQUkEumRww3f7HUOHkaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334401; c=relaxed/simple;
	bh=jvUQNJO0CNKdhLWlL+0LO6GCDOg/e6o0Bp/wntZcfU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgfv0IlKaOBWye6POTCQkIvwaK0Gi/R9ad+yvsdf0YLhEqlObf/VUAaRIaWTr/N4kgIAoTOF3xeLXiKHL7Zb+gVToZ/VZ/fA1FjNybbE6A0FrkJW6f6sv4Hwi+FN2bXfuTBETv0M0cqeHZ0CFFt73Ho8Eviigu+ZlDI0eakry64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPXetWRJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPXetWRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3880C19425;
	Tue, 28 Apr 2026 00:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334401;
	bh=jvUQNJO0CNKdhLWlL+0LO6GCDOg/e6o0Bp/wntZcfU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPXetWRJPRC0CVrp70iEZrMRgWaCi1hjG1IVTK4hck+8afVa6mwx3Hvqdg2pkmKUh
	 W09EAnWmfAloaqpqPRGv46LtDIy8DSsj8tXRLCaQFV+lzRJdM+pMoXPTZgQGJ7wkzT
	 E3ZmZtEaOtev6x+OWK35EsMmKLOp4mNVJ2C9gyrGTk5gZHi7TPtH8qeoIoOGBEAaW+
	 fRwlvRpELrIAJTdghIrmNd4XEzxxa3a2M7/C0EseTCWGYINYOT3t9OD8Ll414YfVgY
	 xwKDR7hiAjRlx2uIsyLxaCzFhDCqXMVrzsH/IkNWmfJW5dZgLWL558m1NQBqGcm4Yz
	 HLMuf8wrEzDvA==
Date: Mon, 27 Apr 2026 16:59:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Yibo Dong
 <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, MD Danish
 Anwar <danishanwar@ti.com>
Subject: Re: [PATCH] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
Message-ID: <20260427165959.3a294f1a@kernel.org>
In-Reply-To: <20260425041816.19070-1-enelsonmoore@gmail.com>
References: <20260425041816.19070-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 21:18:15 -0700 Ethan Nelson-Moore wrote:
> +# This section depends on BROKEN because its only child item also does;
> +# see the explanation below.
>  config NET_VENDOR_MUCSE
>  	bool "Mucse devices"
>  	default y
> +	depends on BROKEN
>  	help
>  	  If you have a network (Ethernet) card from Mucse(R), say Y.

We can keep the vendor as is, this doesn't enable any code compilation
-- 
pw-bot: cr
