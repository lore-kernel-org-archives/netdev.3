Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BC383C8D;
	Mon,  6 Jul 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350866; cv=none; b=s1TahoALDjx2B0pptmN6Hr3H6OqKMOq7vE+osqc8j3rVNd3BW3TXijNuxjnVemsmmr1Wo95HjACN+XWb6NKhfkiIFBnBi6wNexfs2WLbCmL0dQ1CoExhvlOXQdWkUzrik5H3cAzAjkNjk4XNcV8wVpC1WMfTAGuqTpf5nhzvUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350866; c=relaxed/simple;
	bh=mrlxGSjj9QqNo+lP5Xdb3XGmfRsPsv7mmKFtUSLE6yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty4dJoiKa1Np0Wt/DM2nreqaheN1Wd47MmRis6PkoQBlk3JBSQMTIyec5/ZVeDirEdjKfmWqkr5WFF0WMm+LcGhQiMPSLjhqlXO4FceD0n6rJrm/sdwFKlY9pHSGgkJqJ7tj4f6cltrxtXsuExTaQmvyextxfmM/jM7KbCE1xnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oMAXZIfX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oMAXZIfX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wNZE3VgZ4LBQ32jJECYzyYgXQTt23JxegdPIx4PiGAI=; b=oMAXZIfXtOyR6kd/mqs8q2lLz4
	Z4xwwtRpWKp59t2Fh3tVaxij2cLpoZPu8rLjgnQTkkOAp/g7SbcUs6ME5CEoLoAfUbHIgypoGIWHO
	bZ70hYWPPTvegolzdSUJ1YvjSEFTPvX2MNKLmnXn8Gjurzxqhfmrr5nJdE6+TSoAGuVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgl1X-00B0jy-Vg; Mon, 06 Jul 2026 17:14:19 +0200
Date: Mon, 6 Jul 2026 17:14:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: solos-pci: validate DMA receive size
Message-ID: <8ef7d67f-c47c-4342-a411-4ac126abd757@lunn.ch>
References: <20260705084504.54281-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705084504.54281-1-pengpeng@iscas.ac.cn>

On Sun, Jul 05, 2026 at 04:45:04PM +0800, Pengpeng Hou wrote:
> The DMA receive path reads header->size from the RX buffer and uses it
> to extend the skb with skb_put(skb, size + sizeof(*header)). RX DMA skbs
> are allocated with RX_DMA_SIZE bytes, but the DMA path did not check
> that the device-provided size fits in that buffer. The MMIO path already
> has a similar size check against card->buffer_size.
> 
> Reject an oversized DMA receive item before skb_put() and drop the
> invalid skb, then continue through the normal DMA RX refill path so the
> port is not left without a replacement receive buffer.

Subject: line

    Andrew

---
pw-bot: cr
