Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117F43990A;
	Fri,  4 Sep 2026 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558893; cv=none; b=kIVDI7O3jg6b39ol4PlIAFUiynMg9tkKKcHMrxEoq0hfdqZDcri3L7cm6lriY7u2desQ9TKxRttkNJJ4G3GOKHhV8s/Dg9UcEm15y3RoIi7dVs/5mFklQDdQEX6HpmTmZnm/RGLnSx79g0VJ9P37INLwOGWg0x53jTiA54xYRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558893; c=relaxed/simple;
	bh=jc5KLmdbEeqKAxzWuIjtKSCfFeVzdde+sbrEwzo+c68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGvEJsN/oEWQfQWKnBFodmYQevNDaXQJnWMu2AHQka4EuxU/wNjlGHthzAn0fD2hH2+1AqLcC2339i3YXZz3o7Qr9EEUdDmzlKmpxamaRcDIi9jVTR8xtd+XSBLzwwATJkm79sUW5IJ41gnREUJ/X0ajKlTxZ5S8geN27Ai+620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/vH8Ab5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/vH8Ab5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B351F00A3D;
	Fri,  4 Sep 2026 21:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558887;
	bh=mOhrz/9vkPCR93fARE91jSZwA1blZFaeBdMu//53gUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L/vH8Ab5uzwt7eRi8yQP560Ixj5sh6UuY2AYzSPF4vEyDtO2MCJSrEpc4Ee7B4v2X
	 s/RFkQQbWLH64RmCHiWDdauylcTjWXu9+6hidztt2+qkSJP2+6WA/CVgEJ5rOu5yOV
	 YeiOPS1YpzclfAgQwwIT9WHfk2qSvf+3BhKzBpSERQM7ooLtYd7gjMa1abIFMf5xYZ
	 QI9/RhWaDVjgSlg/cdUAywx4wzVkHj9hU3W8vhLZDVklS1hT0d5h20uDQw7cZ921h0
	 gLFaqs2ENWTCXLEbmVgSxLHMr2DkX+Km6Rm9xpeMuWmog7WPx6qx7ehVmKynCoEWsK
	 VSAn9Pr9G6zgw==
Date: Fri, 4 Sep 2026 14:54:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, u.kleine-koenig@baylibre.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v10 0/5] net: rnpgbe: Add TX/RX and link status
 support
Message-ID: <20260904145446.5e5f3667@kernel.org>
In-Reply-To: <8DDBCA0431A75B45+20260831073608.401988-1-dong100@mucse.com>
References: <8DDBCA0431A75B45+20260831073608.401988-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 15:36:03 +0800 Dong Yibo wrote:
> This patch series adds the packet transmission, reception, and link status
> management features to the RNPGBE driver, building upon the previously
> introduced mailbox communication and basic driver infrastructure.
> 
> The series introduces:
> - MSI-X/MSI interrupt handling with NAPI support
> - TX path with scatter-gather DMA and completion handling
> - RX path with page pool buffer management
> - unicast/multicast filter.
> - Firmware link-event processing and carrier management
> 
> These changes enable the RNPGBE driver to support basic TX/RX
> network operations.

Please make sure that you correctly post the patches as a reply to 
the cover letter when you post v11.
