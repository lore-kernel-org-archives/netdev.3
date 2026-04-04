Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BEE625
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262428; cv=none; b=UX1F1q+4iRUTlURKx1pprUv5Gl2QTV9e2W4Iap/86NNV6W0ulGg2I0C/w7BG79iUHxg9HsfdPEoZT7HDHkXT16o5Znzojsj7KVSwxRTBZjMWTt+0Ml72PCemxzeMTS160E3d8pBIzT3Twv/R7kd4tN2USfHvB38uJ7UN2Y3cDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262428; c=relaxed/simple;
	bh=bRHjq1ptMfBOG0iKkym5PXhmrMb8RlP8drv2S4vjej0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKNqTL1fyQimeuiTYp0cKJsXpx1LYMTaWROC9jtqdXPdG3nhSL67evPOJol1QfvgECtbSMxW7bj9oMOcj1W5y3a3VyXfGWLxUUDFP8HyaaeKsHSbF1+9rUphl9hNC4fUb26z/3nJWWpdck/vzHmzArOX5kzyS/2DwTGUXCU212s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLmY284H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLmY284H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317D7C4CEF7;
	Sat,  4 Apr 2026 00:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775262428;
	bh=bRHjq1ptMfBOG0iKkym5PXhmrMb8RlP8drv2S4vjej0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLmY284HZT+YgOOhHuQQJmZMAIA9p29FQFNzL1kP6LEck3g+017ZdSYrfAsLGUusX
	 hpQcVniqXxrd+bdM2YetR2O/639Np3EW9CM6SKbjcLT0rnQ9lc04oDKhdCAiVE7OqZ
	 oS97HBNj2S486Ov+nS2muqbOC0TbEyEj3t1+qC02D36MgrEHXhGhtRQu8LTTVoqjpj
	 VsWJi+vliqP9QT/DJSJoTBpMPauOCWQrkybbgOeyAGR/vUVBZt7LqmKdwNmul+x6N0
	 40joOUKgAws6h0XJexuQ9an3hTlEKPN7DLWWzdttDiANjVsy0+dg1pQprryAsk8FKT
	 m+RkX1fLzmzRw==
Date: Fri, 3 Apr 2026 17:27:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v5 02/14] net: introduce ndo_set_rx_mode_async
 and netdev_rx_mode_work
Message-ID: <20260403172707.28e71a27@kernel.org>
In-Reply-To: <20260402225535.4124525-3-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
	<20260402225535.4124525-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 15:55:23 -0700 Stanislav Fomichev wrote:
> +	if (netif_rx_mode_clean(dev))
> +		dev_put(dev);

let's toss a netdev_tracker into this reference counting
but overall the work stealing is looking cleaner than I expected,
nicely done!
