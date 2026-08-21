Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E483BCD0A;
	Fri, 21 Aug 2026 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304084; cv=none; b=h0KZR26umxT+oOCaTBfrobS6aKXJ913XZTyZn+AdbWCkj1Y0hr0Fbf4ZR2RQjq+sjA35cKtx5wipKxpFH9jhXD9IBo2nqtEyjTUX/JNPbz8a4bib5dnHUacRSECvqtLC8YfJTG87cdkSkd+rl1XVJT3M1f8A1eJwR9A2bfTOGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304084; c=relaxed/simple;
	bh=NH0oe2ByXYiP8JNVBkVrLTsMYRcIjl/ZXpE6OZXELOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjk3C4Jf0NIADrwj3WM5hPYcdhiFkinllGIFU1Kqdp5SibOH7dOe6fz+I74RwyQnSKb+i8HnzNHkD2TKB4WCN/DMocnFWNq0rTBoiJLY8MYGMdaedq4tdYqq3sc0ZIopG0eIm/H5lS1DO+6/kAqr134AuUnD12MampwqIJP9bOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tCA5hIzF; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tCA5hIzF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=okxr4gxJuODLEEWefmNw1ScZaVroCgeFoSha5R7c1QA=; b=tCA5hIzFAr12X72UAhMrJmNeQ3
	4PwvUtVwxx2V7sis0//e+vMklWat2v9zF3RO0wAmJxOPmVDA23i35NC3jD8Sm/qrloW8BiYOtXii0
	K/74xaBjpQPcEY0osKP2NSzlNtvhkrqeRTx3UiCVJvbfU6MBWXMnE7VQtsemzW8oK3LUvqd64mJyf
	/b+iSDOLxeQW8twrKwGfphhhI6v1qMuyR8ul7YFvi8MK2nFLNlOhpLbggA5JRd6R5BVAOZcxV0XUa
	uMmFcXdXOluph3tDM3N2hLAqfItXo/b17jrrOaVyLV7gpM4OaPwYRWThQl3q5kBrjtPD42cN/DwiO
	bkH+leaQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxLR0-00BEil-1j;
	Fri, 21 Aug 2026 09:21:10 +0000
Date: Fri, 21 Aug 2026 02:21:05 -0700
From: Breno Leitao <leitao@debian.org>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tomasz Duszynski <tduszynski@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Fix limiting SRIOV VF count logic
Message-ID: <aogYNPbnqLnAvENG@gmail.com>
References: <20260821064512.2754110-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821064512.2754110-1-nshettyj@marvell.com>
X-Debian-User: leitao

On Fri, Aug 21, 2026 at 12:15:11PM +0530, nshettyj@marvell.com wrote:
> +		/* Limit VFs in case VFs are more than LBK channels available */
> +		if (vfs > chans)
> +			vfs = chans;

what about using min()? Something as:

	vfs = min(vfs, chans)
