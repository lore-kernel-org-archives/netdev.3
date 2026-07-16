Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EEB3A257A
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195725; cv=none; b=XQsGw3K9t1jU7cI+JaOp0ZxNogCqRQVSHTPo6T05x52yIT+iRnIf6bMtfm7LYWmczx8Z1xi+n9tHiHtjla55zCdzsA82+OWkPGWdSs8wvqBlQc8b1lG0QT8xs8yK37oGpOJyeAW5Sa4GfeGBHiyL1n2kCo+K4XwKaP2rdRj/JLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195725; c=relaxed/simple;
	bh=e/86d3Y+T1TvDuF888ASiXCScYdYULhpStKUV2/XMNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfIW7mXmtZSINyQBekF0Ye+RnVL7m7NtcA2quaisk7MNq1jAWbjdk3dpKpToioYrYThyLBe1a351TNPclkVfWDjof+bqHS9jRTQBBeKzdyn26ZXHsQvarsogyIJsSzLLVHDjB82xwgH9ukFtj6f0I68q+bYDMEtme1WpQ23xRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4qnQXXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4qnQXXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741B01F000E9;
	Thu, 16 Jul 2026 09:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784195723;
	bh=eUtjek2pWVBqAYNVaFoiCBkMTXMKzn/r0XVyE/OpaG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N4qnQXXGwDWRzHx3tQ9poDR8MdDJZxRRx3wj/5We2KM4+SrHF5oswAMWeKWh3Htnq
	 h70QZ1/vwuyV8RpoVb3wQB22T3yd1DxBjhwvabSInd67LAjCWjHuygy4lPUJfukxFs
	 JLCxDFXLyDD+SN1RypMMyyMfw4hSu0IOYcgsn2vZ/idhuT9qorxO+t/Jcg8q0v0OaO
	 WHXA+XwrX8oAWsBmjEaF3barNZn7z4f8vtfC3pmYXGnsBKCauybSeESICWQxNo46an
	 A51i5BEhbE5HH7FpYYSqUXphnj3An0h9sOgFsreSdUqwSCZ+pbkdDQH8wg/XRbPspb
	 G5XBd8EJKIXZQ==
Date: Thu, 16 Jul 2026 10:55:20 +0100
From: Simon Horman <horms@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] geneve: fix hint header definition wrt endianness
Message-ID: <20260716095520.GF95246@horms.kernel.org>
References: <20260709124801.140632-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709124801.140632-1-atenart@kernel.org>

On Thu, Jul 09, 2026 at 02:48:00PM +0200, Antoine Tenart wrote:
> Bitfields are packed differently depending on the endianness, take it into
> account in the GRO hint header definition.
> 
> Fixes: e0a12cbf262b ("geneve: add GRO hint output path")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260529144713.780938-1-atenart%40kernel.org
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

