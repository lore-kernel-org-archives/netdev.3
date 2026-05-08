Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9937EFE4;
	Fri,  8 May 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247438; cv=none; b=kBavF/NihFS+FXbP8UxZj6TavpbBFV0SP6Os1BamEcP8pc21Je5bZgUom4YsFEkVSS9hvU6ac8fsCHxrDHaSOcK2wtfRWVL3Fpzk5pWtljxgB38CB71hTjZ8Dv45YKMqhC7L1PHh95F0evp+G5kf4Xs+K6Q9hgD0V7n3eW5L6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247438; c=relaxed/simple;
	bh=Wcg0OgXuJMdKm3CR/bGkPKmjMN6Bnif6Om6bjkUDSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/W5y1Q/kdk0OM0K/aW+ne4m19/v9JDauuO9FJYuWHIkEgsBwN8kESHzDihmpCOKIpiYGnJXScECd3R+m14Nrsrpf8/0LFG6kZQvsMCgu8sE95OfKHwa098Pmr7aXHCDSKksOs1byywZ/LPCabz1A0ynu/VAjJr3jSERO768YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7lMVD+W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7lMVD+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D013C2BCB0;
	Fri,  8 May 2026 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778247438;
	bh=Wcg0OgXuJMdKm3CR/bGkPKmjMN6Bnif6Om6bjkUDSA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7lMVD+WF2ahivQ+jAwOtNNvlfV8t5KWANbBLWpsLKHJ4deaPoIT6lF/HOZH3QOUk
	 zFn9MrM3RZGpEe5ovQ60bczf0qyF/zikPxEsKfLEOmCHLWrFBcZa5bucmc1yitLPGf
	 TvcshGsCCBmF81nrdJ6gYdU0TU54PWVFfulPvmLRW6Ptu8nh7S/nMm+uqKwgEufXwW
	 0aTksTYabomIkMIu/LGlnVA06oOVlOdU4ZmEMR6rSAWp2yctcGByczQ2xzSn/+PRDs
	 9pxoPPxqfZosJy7FjGENcZvNytv+7YJnqZWBSpPSfre3XS+P4IsngFSF+5HyWDpsFm
	 ehoAaJrVicX5Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLLOG-00000000Bzk-0CSK;
	Fri, 08 May 2026 15:37:16 +0200
Date: Fri, 8 May 2026 15:37:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Jan Volckaert <janvolck@gmail.com>
Cc: bjorn@mork.no, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: NET: usb: qmi_wwan: add MeiG SRM813Q
Message-ID: <af3nDLa1A1JcTftq@hovoldconsulting.com>
References: <20260508133159.564206-1-janvolck@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133159.564206-1-janvolck@gmail.com>

On Fri, May 08, 2026 at 03:31:59PM +0200, Jan Volckaert wrote:
> Add support for the Qualcomm Technology Snapdragon X35-based MeiG SRM813Q module.

> Signed-off-by: Jan Volckaert <janvolck@gmail.com>
> ---
>  drivers/net/usb/qmi_wwan.c  | 2 ++
>  drivers/usb/serial/option.c | 6 ++++++
>  2 files changed, 8 insertions(+)

Please split this in two patches as they will go in through different
trees.

Johan
