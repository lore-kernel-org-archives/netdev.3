Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10C286D4D;
	Fri,  3 Jul 2026 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096743; cv=none; b=E8GMVl5jUH70jmJKho8iJiFcD8y6d1fajzVzU1w+sGIPT3IpSs9AhGrouFbAbSgfw3dsozcFC5giKiTPPho1s6wynpQu/dhj2Ok+BkbGmBmIvNq/1omwM0jcuRULFhauwUlpYsKUT1MrkM+Uho6SCjKbJxAt3CPFv3rtdYPJp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096743; c=relaxed/simple;
	bh=5DVVBtTOW0yr5qDqr84mGeBE9GlwwdKdtKIQ4DEOBLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA9En/sNgBjeVMVN9+v8jBqOfC16xFJ1ekOxTvTaYbBmYGDfDSCf0RfzAbWVh+ogqQpgZY8+ugqv0BUntwAhUbl2W3oNIvQ37rwE8W5Fp2BA1LWozXAsjFH89Fb8+ZesUCHAPvuJZUMYG37PrDQd+V8sS95Zuw9dAPHwNPBIAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rstkdL9C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rstkdL9C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cOUbwEcbUl3Tbzt6eGApLmbeUlwF/FWkHZ2MGvOerL4=; b=rstkdL9COsd4gO3sCjGnPktLkf
	pVSuBjoTLGb0FQt8q7bZyAUqQI4OkYaDtfiThk543MM9Zv3MB1g5iPE9N36ZYmNyuHfryOUujYY35
	tLQwxT65h8QmyS9R8I22xXTWrO+3RTZ4Fni9NvH2H65H94Mi5yq9zbZUbWmm6pmfIbYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfgul-00AZoE-6r; Fri, 03 Jul 2026 18:38:55 +0200
Date: Fri, 3 Jul 2026 18:38:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: emac: mal: replace devm_request_irq with
 request_irq to fix probe error race
Message-ID: <fa4fa65e-1635-4313-a5e0-56a5208272e2@lunn.ch>
References: <20260702235045.1326384-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702235045.1326384-1-rosenp@gmail.com>

On Thu, Jul 02, 2026 at 04:50:45PM -0700, Rosen Penev wrote:
> devm_request_irq() is a managed resource: the IRQ is not freed until
> devres_release_all() runs after the probe function returns.  In the
> probe error path, free_netdev(mal->dummy_dev) and dcr_unmap() execute
> while the IRQ is still live.  If the shared IRQ fires during cleanup,
> the handler accesses unmapped DCR registers (crash) or the already-
> freed dummy_dev (use-after-free).
> 
> Switch to plain request_irq() with per-IRQ error labels that tear down
> only the IRQs that were successfully registered, and add the matching
> free_irq() calls in mal_remove().
> 
> Fixes: 14f59154ff0b ("net: ibm: emac: mal: use devm for request_irq")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

You seemed to of sent the same patch within 24 hours. Please don't do
that.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Send a self NACK to the broken version, wait 24 hours, and send v2.

    Andrew

---
pw-bot: cr
