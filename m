Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52720264614;
	Mon, 10 Aug 2026 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398241; cv=none; b=bFI+J44GknFeNoR4P3Cl7iWwVYJjHelzfPfdAmxOzG+MByPYZW7dK/hEZzQfXg2UkljlFNEs5CjFh9C22IHkxN7G07HjViq5++DDMcbv8FAjVagzuVK9xdNIdNf7zuKyysrkuAMkeR+lHnlT8X9Cwqc4a1Sxm69eNGSW2jdOjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398241; c=relaxed/simple;
	bh=uW7lr4qGzexaWyTqqzIk3GsQPuIxHvTNNdApcrMnv3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVlikiECxePXv05+Z9Ufetz1H1smXAnl8zzMxnOydBPqiYI9I5ydN7Ip9Rr9mjiZjE/To2h5NyQA8SUc5tGm8HcVpMgyGI66RqA0JtGbckxnH9XpIpML/lHa+vCyLJoSB8gduKj1MM4yb5/fehGR74U9Lxv/3qICBayA0E/67W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYTgDTiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYTgDTiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76811F000E9;
	Mon, 10 Aug 2026 21:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786398239;
	bh=vgDJCmlcf2tIfChsVStN1RWHw4nknvUi4kuElkfPuUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GYTgDTiw0U3KCaBoYXKbdKiM7iwc5j344yxNzVbVZO1t/vfoQM5EijYMz6VrheNAG
	 loGF+S/v2J4UFdtRwY+ltT1hrX56ZvC0Ognq844nWG+kPVTdjEioQISbXRHVItp1+s
	 zkxMfLqHnDTIb1PZ9mia7XlSEsJFN/l2F4Oli5Rfe8ooM72xUY6v/wnomgwhclITeV
	 pq8Mtl6of9V/kmXw25AKuWfVMkwDFOfpXN0FHf0rh9WJT/ao4IOUI90lK6vceEeXnp
	 PinRluv3A1Fy64SBVMg1Vq8FnduPFkiM1oz3PWKU43XEVMn51GI8bf92WsdNizPhbd
	 nFbYmE7Mex8jg==
Date: Mon, 10 Aug 2026 14:43:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: calxeda: xgmac: Fix use-after-free in xgmac_remove
 due to race condition
Message-ID: <20260810144359.6e609a22@kernel.org>
In-Reply-To: <e556148b7a938f83f8470bb3bde5b856eb9ba271.1785809990.git.xiaopei01@kylinos.cn>
References: <e556148b7a938f83f8470bb3bde5b856eb9ba271.1785809990.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 10:21:26 +0800 Pei Xiao wrote:
> In xgmac_probe, &priv->tx_timeout_work is bound with
> xgmac_tx_timeout_work, and xgmac_interrupt and xgmac_tx_timeout can
> both schedule this work on system_wq.

AI reviewer reports that this can add a deadlock.

Looks like we're trading one bug for another.

If you don't have access to this HW or ability to test your patches
in general - please don't try to send such superficial fixes.
-- 
pw-bot: reject
