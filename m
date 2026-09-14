Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE1495503
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408286; cv=none; b=YaLxtks8yneL+GwnzQhGb+SmTBLoX5fP5C15aarfiI+5mRjDJA74wRb2bdvPVOQZTmYBSAkQBWSSFDSkf5AjBriTT2wrAZ+uIZu/LO2iuvH8RpVLoIh15tXVP00tFV6qosiw3ZFwkXjxGK34zcmQicZjn81O6DFpEgNcHet5xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408286; c=relaxed/simple;
	bh=0S/VnnyBN6clM/CG5bIG+4tPD8DP6+R84iGaP4VoZGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJ7a89Qy85h0mRTNf7VjeVLU+DP7iKBbBqQ9CMrkobaYUQbbSSKIQY4NB9sRwEGWl8VzKlNXtpnvfRipu1hBZkg0Gvd6c+qncCvwqo3BigOpRoqwIQipm8O+2nEbCxlUYlZEMbuaMCyAKEg+PAZ7WwdRQzOreW1oBAllkIWrvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVSjaNSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVSjaNSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862111F000FF;
	Mon, 14 Sep 2026 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789408284;
	bh=GhGu6rWbKPCgPjo9EkxE0Lx0X+lS1VgrJVfs53aDKeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kVSjaNSzqA5oyfNLpSlB+VIDoi/GBpPtOjCHuNPxKXjpCtj/Yi5V5rcYnGQVRi9jH
	 FpLX7wti7RNXRY8Kve7JQdoNIdVlXLUtYjWKAk1iglJuttMVv+oV0sH2iFwLGmTmai
	 pgyOjoa6IjYTv4LfU2i16pcF66INvLkfpAvr3WMAbEbnQ21ZTGzQumeDQxgi/5vsB8
	 WJ4rdGJIT+DaMQ4hckz+lV0dG3JOgBVrjRa6nkQX1PyibgrR9btLtjTPb/Xsq3zP0A
	 E4FaeHyHoFROLFPy+XVbZ3exWl0wNXVEorU1xE45wt3POfBumVlAS72QufmoiY4z85
	 o4TK5W/QuBTvg==
Date: Mon, 14 Sep 2026 10:51:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Quentin Armitage <quentin@armitage.org.uk>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: net: parsing IFLA_INET_CONF broken since 7.1 if NLA_F_NESTED
 not set
Message-ID: <20260914105124.4a3abc1e@kernel.org>
In-Reply-To: <20260914174307.GA450786@shredder>
References: <49f5ad9f2a4c1f2178f64383b4f05c21106fce7b.camel@armitage.org.uk>
	<20260914102108.788e700f@kernel.org>
	<20260914174307.GA450786@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 20:43:07 +0300 Ido Schimmel wrote:
> > Please explain how you discovered the problem.
> > Is there some open source or closed source SW you're aware of which
> > breaks?  
> 
> FWIW, I sent a patch to keepalived in the past and I remember Quentin
> from there. It seems to be affected:

Ah, thanks! I was (of course) worried it's an AI report :S
