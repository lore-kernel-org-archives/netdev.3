Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABCE2264D9
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516187; cv=none; b=s6rTPIQL6zrD8ofPaVimW7NLwyqiKctHZna+Yb5dGgy93X5C7f8orC0GC6M8nlHy8Mdj3oR11QBPRtTZbd94+VLnlT/5gkvFpHUJgOSpjcfLmDzNevz7mpciDAfSyBO844dIIepu65Z+BQcZbN8r8yQrgElDj4Xo8koDuXbgP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516187; c=relaxed/simple;
	bh=4FZpVxoEWDYkYuvpbqLoqxczZmsrs8xg7gJvHJBfoxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2wLF7xEcpCn7Q/7GnbHZsDrK6tP5FWKw35gGDGjRE/lQ5Et4r/kc3I7QmMYlJM+68jDaHKwSqv9vPDf9Y0QQQe4L+8A9LBdh/+huDREc7Ufjr8CCOTP+LQQ38o7Lcg0utZ3LVIK2wKyhdYQUyWqj2d4gZJBQfdaKQB2I9CU/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KXO3mZnf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KXO3mZnf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dMmuhRkxaLQyPoTjQq2ZAlR+iVMtEU8LK3SXzFXTqyo=; b=KXO3mZnfg6E+504tfrVKtGVKPT
	If+H7IJnJIkW+5h7Eiiv5b+WGxJ8ndMmK98KZyLMG9qtHCPXB22YXbzlVXEH7bDljRCNBCxZdavV3
	Dr3WV7bge6+Q/FvxfDZZrh/MNUpasoSdyahzVCn2HHzxZvJ/SI7bvNd2FcoPGniuvhiY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wleAp-00DC5C-Hs; Mon, 20 Jul 2026 04:56:07 +0200
Date: Mon, 20 Jul 2026 04:56:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: bh74.an@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH 3/7] net: sxgbe: handle descriptor ring allocation
 failures
Message-ID: <9a552a88-f034-4a81-ba35-f76de8e08ce5@lunn.ch>
References: <20260720024747.504493-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720024747.504493-1-chenguang.zhao@linux.dev>

On Mon, Jul 20, 2026 at 10:47:47AM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> sxgbe_open() ignores allocation failures and proceeds to program DMA with
> invalid ring addresses. In addition, an RX allocation failure leaks all
> TX descriptor rings allocated earlier. Check the return value and unwind
> both ring types before disconnecting the PHY.

You are fixing two things here, so there should be two patches. We
want lots of small patches which are obviously correct, with good
commit messages. And if your change breaks something, a git bisect
gives more information.

    Andrew

---
pw-bot: cr
