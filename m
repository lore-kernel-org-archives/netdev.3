Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE75187E1;
	Mon, 21 Sep 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028111; cv=none; b=eo1WLjmPfRV/kuNOo4d2teC0KwQFD69aU24TnuyCtekTqAWoRfPoKZkkjXBMfgYRblV8RTolm7b3uuqy8/6X3tEFN6Z5f0MjgQlELr3dcis+zO/pxaAPnTAWSn+lfdWfLEhWuOCD1Quij95STt7F0V6tpgJ9bs6jv7IDIIi8MPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028111; c=relaxed/simple;
	bh=InAx6qtfw/9lD3C6nt0nIObURZjNCE5Xmi4WiQsiBCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChoUCHs7M/Tez+jpHLSq2DXO7B/eGuSNQ1/CNSsm8aj7mUSXkdlGaIsiMOMSlL5Q8CIc9ZcRvUiLOdAH600vBCu+XsB7rfkaFsSDuYU85RvQgL0fzYZptYQtHD3/C7dPLcOfN8T1OilSe6OXQRWWAv7S6FDmLRu88Oe2NrWjjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAsf01fq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAsf01fq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5061F000FF;
	Mon, 21 Sep 2026 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028110;
	bh=jOGHfkooEADLL8UQSObp6hOJnWO0Agvh1vXoe5BayNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XAsf01fqbsxpgWxLz4OyawkHvAw5uRg3psECuBlHlnaeWKTPxz5aenBqvHHouFCqr
	 Oe9NjY6/oJq65PZp3tAQAyjBYQ85t6QZgttqMFzTE0D/DwiWWox1tlG4ggSebTbD2P
	 xa3RUqre8XahCx43593XsHVRdtpXTXJ+sKIg8DsJW+lI9LKNKicQ7RNfyV7NzLcpDb
	 fSrMvkcz8gAwEY2rQaC1gTU6Daoo9bQIdvLALwLylV1Ww7KFe6+5mTs3BC+WflXQM1
	 az0SoXE9O6onTxy1WIzXGwLvxSbQh+ddpfIuTbP4jjzf3JttSrU6Y+QVxuOTJJfaaX
	 9asDYE4JJH/tw==
Date: Mon, 21 Sep 2026 15:01:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev-bot+sashiko@kernel.org>, <davem@davemloft.net>,
 <gakula@marvell.com>, <lcherian@marvell.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
 <pabeni@redhat.com>, <saikrishnag@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: guard is_pf_cgxmapped() when PF to
 CGX map is absent
Message-ID: <20260921150149.1af94192@kernel.org>
In-Reply-To: <aqzSYu6KduRWM42T@rkannoth-OptiPlex-7090>
References: <20260915022952.886639-1-rkannoth@marvell.com>
	<178970941782.22033.17901214089531533321@kernel.org>
	<aqzSYu6KduRWM42T@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sep 2026 11:25:46 +0530 Ratheesh Kannoth wrote:
> On 2026-09-18 at 11:00:17, netdev-bot+sashiko@kernel.org (netdev-bot+sash=
iko@kernel.org) wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
> >
> > - [Medium] The added `if (!rvu->pf2cgxlmac_map) return false;` in
> >   `is_pf_cgxmapped()`=E2=80=A6 =20
> Will modify the commit message and will post v2 to net-next as a hardenin=
g patch.

no such thing as "hardening", please don't add defensive checks upstream
