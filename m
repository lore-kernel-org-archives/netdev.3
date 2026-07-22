Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117739E185
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748887; cv=none; b=P5QaPebTZb5eIqvM233iS9C962SgUl2z9NIoAfvnA+cQtGDbDNGcZkBZSoqCfFB9BvpOD3n7aKvllD1GBWp3kfX+8rhcunuluRoqXIJ4u6IsVET2fV0p6nQzxqeRHuhiKPj2VJssLKqtybV9S0LyMY85HRKTllLu7fGEX6z0qPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748887; c=relaxed/simple;
	bh=xUVAVoeeF/xn2t0/EmuZb1cOMQ+ryTgz2n5CrbKYi9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3kcne0sv5fCX96Z4RgWc4To5Lp8/ltNNhATwCuN0EDnBBe2XnbTFMNLZnpBUq3vEatxK45MYXll5Z9YhngkBX4f7YpoojKY3bq7+ynvDXI9USCssT/wJ9tRjz2FwR4oFXfB5ZbTpT0fW10d/YHn/9OX8jqJaBvSCy/9a3FZMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCdLAaRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCdLAaRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095871F000E9;
	Wed, 22 Jul 2026 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784748883;
	bh=k3cKZHNKkxiMPr147PoKWBfyqUlokFrq1vkTgSjLR2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BCdLAaRbUhLJZE0yjvfo44pq6kTbR5XON2H4wcewN+EtmS+2Tjm2tRLuWee60Wddh
	 HvbKJpKRdqnu7TY7jk4hAphw9smS28PAjm9/jBkfaSTg9Is2vO+M3bvvls+ErCMd+u
	 NVYaNhQQ1ovkQo0XTlw9JfDzTwZW54Lg82E10CvL5KCWmxAqMD/xw0LEeu7O0kQ+CV
	 BdrwAsPxqf331Jio+jdWyqGkGWe4yqe7QcoZM3CuoNkqVYTHe4G5IYAOqBiS5DPysW
	 wrZUsc0f3BpyeKqEhPaD2x7ozsF82Ew1pmIRf7e8lY9LkWEWIlJD72fQ4HYnhX7+vZ
	 gqiaIzQ+oEDmg==
Date: Wed, 22 Jul 2026 12:34:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Chenguang Zhao
 <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: pass eth to
 mtk_handle_irq_rx in poll_controller
Message-ID: <20260722123442.0434e14a@kernel.org>
In-Reply-To: <20260717022339.301914-1-chenguang.zhao@linux.dev>
References: <20260717022339.301914-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 10:23:39 +0800 Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> mtk_handle_irq_rx expects a struct mtk_eth * (matching the request_irq
> cookie), but mtk_poll_controller incorrectly passed the net_device *.
> Calling ndo_poll_controller with CONFIG_NET_POLL_CONTROLLER enabled
> would then crash.

missing sign-off and fixes tags
