Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7E33FF1D0;
	Mon,  7 Sep 2026 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763517; cv=none; b=EVNcWH1nlbCAVLUkAoe4tqR/wiHCwxXWj/GgJ6F5JH6LutxHhrmoBGmPRcM/uy8zn6icTMWzP+5IovcPjw3uib0z4bqOgm9jOuKxOsa2FwKakFRwP7vYMOIAQhCT52V4bXnO2Y2UZ+dbw4XISeff0j8pqkEpSiAwQm4Bvw+5PzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763517; c=relaxed/simple;
	bh=cB6/hD3B1vZN02cLZgeXfehflv3vAkXXk3tKqut+LjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMOcSQBPHPds/8pXMqRNMH7/NjBLivfKOamVjSAdLUSCz0MSKUYLZNetSIrEnW9nGGPSkI4EZ/Vli4zTT1skjT2eUOMKnz936pW9OyYnbHPc2HX24XY0miAYDd6L13Vw5ppxXCDEht0N3z5lj+XGHUg8wMZcYqBrbK6ujq7XE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=h8zy+yvb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="h8zy+yvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1788763499;
	bh=gjhkm9agfE2zBZZ4UzLdj9EB+YOTbNviRJKFvII6za4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8zy+yvbM6SudjIbivS+c6cFAGJ9eWlEDdriqclERHEAawb8uXGf9i6JPV+Ga/QP1
	 7EU5DMsL5xyZQ2OqIpOz39hqxy71K/MbucckEANPkEbqWlirql1/9KgYR/ejiVAlVi
	 IV8BMCbHdX9BHzSsEr9WBJr5KJDXY6xgu2yhhgR/i6AjRu1TJqx2IN5BUyqH2MxScE
	 XE1YKB0AlPVqrA1bYF9WEuM6+qI8kQFCYjKXYyStmCpGuc8F4eQy4tXAJEd+MrQz9I
	 hryeCBvAnxCSaPRGf7qQ9bV6oddgUCFHMBMcz5l/zIe2VtPxTybLPZ+tSEEwzti7gx
	 kQOKsBdoCPBCg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4hdcy30vxkz4wFN; Mon, 07 Sep 2026 16:44:59 +1000 (AEST)
Date: Mon, 7 Sep 2026 16:45:00 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kimi Security Team <bug-report@moonshot.ai>,
	Weiming Shi <shiweiming@moonshot.ai>
Subject: Re: [PATCH net] ppp: deflate: validate output buffer sizes
Message-ID: <ap5dbA8dh0fT6bP-@bruin>
References: <20260907055809.3379942-1-yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907055809.3379942-1-yilinzhang@moonshot.ai>

On Mon, Sep 07, 2026 at 01:58:09PM +0800, Yilin Zhang wrote:
> z_compress() assumes that the output buffer can hold the six-byte
> PPP/Deflate header.  With an MTU of 1, pad_compress_skb() supplies an
> output size of 5.  The header write overruns the skb and subtracting the
> header length makes avail_out wrap, allowing zlib to continue writing
> past the allocation.

Why not rather enforce a reasonable minimum for the MTU?  I don't see
how an MTU of 1 is practically useful in any way.  A practical minimum
would be on the order or 100; when negotiating with the peer, pppd
naks anything less than 128 and proposes 128 instead.

Paul.
