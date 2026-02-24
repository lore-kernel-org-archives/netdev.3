Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D936C584;
	Tue, 24 Feb 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925834; cv=none; b=nHBp1YTvqUfyGjZFLCN91JVqoZiSxwv/sw1mh38j5P0+1ed3oM6GV1AvGEOq6opo63bRk1tG+iRtJQEW3CAw9qHC4BnfvM7z+OX2l70avI6T67ATO0IrbGXTP+3nv4WPJqUfmMnMpv1oklpsfwU2d4acWGCNcch05SuB4ZI8ClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925834; c=relaxed/simple;
	bh=N8WmkEqhWZu+jveubVScw5voh1Ygh85+P1NCjctqWUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8UlnboeKaPL1w52uu6b34Rhgx01dC+bpXceGiT4GrSbnIVmXaXvNRCIDOn5KcBaQ9l8r0M/3ZcOIbnyi5iYajX3juW5n3r9w/N+W0T5haiQvFAMaDibrwdtgS6OS2U+Hlye9Gb1n7s2qSA9E7buiHV/Dy6OU+jj6Kry0xo9v5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjAYE6G4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjAYE6G4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6596BC116D0;
	Tue, 24 Feb 2026 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925834;
	bh=N8WmkEqhWZu+jveubVScw5voh1Ygh85+P1NCjctqWUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjAYE6G4nhqNaANz6wlNAh/8ucyxg9dDWOhivVdZaB/KWqvn7hVufismdQMNftxFJ
	 vEzzW/1/PVcmb2flcxi81mCNlteep7i5UoQxb+sMoHyo2+ZKHwKQ+mJr9y3VieP3f/
	 p78oDBm/DV+j21Z/KEazl9+ZX+EtnPQWy7Mh/RRDae9Kv3FH0A77fx7SFuSuNiHfO3
	 axivUx6iF0Y60khzkdsEpxmx5wtaUqxfCV3eEi89g9vrX39aU4/SxgLhfGoW8fJ2cm
	 +bGjQc8Kcpzaj7FZVrVcfpZ6sqcizwhirq+yOooEl3HzsTZOdEK89EdN1hCrzcSRIl
	 Wc1McD4xZ6U8g==
Date: Tue, 24 Feb 2026 09:37:11 +0000
From: Simon Horman <horms@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH net] net: usb: kaweth: validate USB endpoints
Message-ID: <aZ1xRzIJGy7c0bki@horms.kernel.org>
References: <2026022305-substance-virtual-c728@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022305-substance-virtual-c728@gregkh>

On Mon, Feb 23, 2026 at 02:00:06PM +0100, Greg Kroah-Hartman wrote:
> The kaweth driver should validate that the device it is probing has the
> proper number and types of USB endpoints it is expecting before it binds
> to it.  If a malicious device were to not have the same urbs the driver
> will crash later on when it blindly accesses these endpoints.
> 
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Greg,

This seems to go back to the beginning of Git history, so this seems
appropriate.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

That notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
