Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521847;
	b=1/s1F212sKN5mzakwDDCVcxW6fPmBTq0rEV9fydQfo6rTFcGCQHV1y9f6C2GRv9KXUTs
	 DuGddkSkS1wiXiSGjI3/iXBRNf2WoFVGpJJsREgjBzerd+M886aOHfb9NiD92fvi2DM8+
	 f9bH4SYTgVjhJyU/R9g/bRqWlpwDQiS9mM7BNEcdqH9+7lOV4z5mQ89mCKQvIDBRmqMkn
	 Zwlkuht+TtqxcSVW2FZIPW3jWw44StnqOfo4RHykB1cvAEtyfFZH5qz6jxU0ab7Tb3dQs
	 uEQ/cYl6Zj5IIenZon9htdB2+zJGifhWO7nMZoIPyoH6QO5R0aeKl2xQ87vv9GzC4SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521847;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p/8qlMm3scfg8hWAkvfPyzt/npLwqZJbe6JVNXEfyeI=;
	b=lCOhuKrsgTPuCsHKbXQk9IH/5GOR+VNTBW1VCuM9GGInLVQ1Q9yUgDWYnF3yPWRbtPIz
	 8dwT0zcSo3Bjv+8j0Q+atFvkSd8R0xvGvpPFXWMgvqKCCMbZPg0qcI2Ci3hCBh3JRk13P
	 cS3Hi8WUwWYvKjWx/gpoZqtmd7s6YvRmjbantonmoumfZ7+NjcTkH2kNe4KeD2mR0Vwb3
	 3JYZ7ukpSDJhdeQw1bP7nFVyWtnK5mKO5n1Np0KTbrwLqYjSSY00doaslWN8XOoinXjCM
	 2U/hNyldtvTpMAoKXOF9DHbqC9zAlSSXDwf6opRUEgZgBbIH3N3C+1yYOUWS1fZ9lIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeoR3Boz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DE606A319;
	Tue, 20 Oct 2026 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeoR3Boz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9D31F000C9;
	Tue, 20 Oct 2026 18:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521846;
	bh=p/8qlMm3scfg8hWAkvfPyzt/npLwqZJbe6JVNXEfyeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eeoR3Bozk3L6tPetdSZr4CAlptb/RlhaBDSTKp9NTBv4jUrSSu0kDvRXLqxhDdT2O
	 6Dw87joAqQ4ZUIFueOuVvGXD7kK4wQVaPiUDoAn2EBK6T8hr0q5ajBTL65J/aZ79bw
	 9McsYJXSBboSxc7zzmrYLPbO+sKISmTi35udK55BgSFZMBXpdErIaQogPm1Icfa9mw
	 37lDhaNrv9mFXAtk+2WJEAGCaKnjU/1VHscxF5uWCOiX33rx2pMZ1vpXMOK5wpf6kw
	 nlUxlY1TTbhH3pi7CzqA5Cltr/Bcbd5HYdnW976fJrXRN4dwo7a46P+MIEWRsXGUv1
	 WO7abZV8OjFtg==
Date: Tue, 20 Oct 2026 11:44:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Hunt <peter.hunt@opengear.com>
Cc: netdev-bot+sashiko@kernel.org, loic.poulain@oss.qualcomm.com, Daniele
 Palmas <dnlplm@gmail.com>, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/2] net: wwan: mhi_wwan_ctrl: drive
 DTR/RTS via the IP_CTRL channel
Message-ID: <20261020114405.38a06826@kernel.org>
In-Reply-To: <20261016205845.503392-1-peter.hunt@opengear.com>
References: <20261013183500.261229-3-peter.hunt@opengear.com>
	<179214346368.434549.12561882856700666394@kernel.org>
	<20261016205845.503392-1-peter.hunt@opengear.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 14:58:45 -0600 Peter Hunt wrote:
> Both are corner cases outside normal operation, which I've tested on an
> EM9291, including bursts of 10,000 DTR changes ending in either state.
> I'd propose to address them in a small follow-up patch on top of this
> series, but I'm happy to fold them into a v11 instead if the
> maintainers prefer.

Please follow up
