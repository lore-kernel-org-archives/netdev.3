Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA13E1232
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196682; cv=none; b=tvNdKHaZb5zT8T6M0CUJn45n+CGR/ieMBTvd8fgAeCUUukkT6oVSxTTj2vZTK8s/A+ehLwFfHxsuk956YmPR2xoJmiTKfyOSIne9A8b+KaCjs1RB9SFtneei/3tuK3YjwJkTifsh9oQcC/rC9jM8EGaIDSS6nA10lyknndLnhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196682; c=relaxed/simple;
	bh=MebRA3IPOkLbiiudAMSaMzk4hES8USy9SNFpzXqZypc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ps1+WT6E9AGS7v2gI2tjWXMvpZ4ZI686WAgSxk+TTldkKuevttN7sDIL4iFEr90dZROunZ1AGo9Oa/L4YPJ86bZuK3eXMhXg4Iew8LNQkO9u5hJErvz5ATl+hLi/M3r6rFJwytqIDqQqTzT38peEykdubqF51gIUjFom9oQ8+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFkyS3j9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFkyS3j9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F14B1F000E9;
	Mon, 27 Jul 2026 23:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196680;
	bh=cOZxClJe4FC7hlKq4qnHdcXDeoC1nvsMBntkcurCEnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aFkyS3j9KDfml4xC20zXLEfVHeC5taKN9ay7gxL1C0H//ie1vTWu6l9P0w4+g5+sZ
	 o4dg6/yRVj5cVwEJNkqKMnJrtJwX1gph11f9nLaF4oMGk5kG8igOaKmrkYIAS1d64U
	 8c58nHH+scmZJidUjZBXlXZPvB4BKLiYS0+131aQpc74Q2FzpkESwRBzNbvwSv8ioD
	 tHkEGohbLTjACYDchhZcHt+GSjyFeY72MF5cayKc6rpJ5GEcINNs4Me/9ASg9f+TVb
	 xN614xBLvHupXxM/SGUkqUHksuUGITHMInEE8FUvs69kQ9tUFLyIEuT60xhFhhgN+W
	 uxwqKd4ru6rbw==
Date: Mon, 27 Jul 2026 16:57:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 mohsin.bashr@gmail.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3 0/7] hardware pacing offload
Message-ID: <20260727165759.092b3bd6@kernel.org>
In-Reply-To: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 16:28:44 -0400 Willem de Bruijn wrote:
> Enable safe hardware pacing offload on a first device (idpf), plus support.
> 
> - Add ethtool support for admin control over the device feature
> - Add device support to the idpf driver
> 
> Besides the main feature, also
> 
> - Small optimization to FQ offload: avoid unnecessary ktime_.._get().
> - Expand so_txtime drv-net test with hw offload testcases.
> - Expand pktgen with txtime feature.

I'm not gonna spam the list but Clashiko has a bunch of legit-looking
comments.
