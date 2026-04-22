Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BECC3A6B68;
	Wed, 22 Apr 2026 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863061; cv=none; b=TSE9F7INU3oGA/TGJxsFLDpzOChv3oa336U0OX7WC9iqy4J8ndAbV6wj2HuHif/yBhLXRPsoMVK6yeyLoh6MxWkeQ/Qqzhx0V1cSPXqCqjRzEuwbUXhp2RnQSoZpBJtB4L6Ydi82sk/Y9wVSv4CJMfhGbErneh+wD7tflnS6BzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863061; c=relaxed/simple;
	bh=1Mjx/5yqxJzvfAWMPjKbre75usz9DaOz1q05Dpi1Brs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkr/tBpbwhdWWfJBfDu1yJSourH8Q8ZxGF3IAA5Txft2XgLAa0b4kmsk+L2jazNxXSZ+BgGsRiHMFNakcNSF+CQIRK9mXw1LA3iH7bSuFXKOScrtqxwQf7PsEGlF8j2VMh+pyGZWa2WH95M1Vc6GQBOR9Lpg4eq/Tne+lZeBIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dyToyj4Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dyToyj4Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gyQrYLlfCfIgAcymofpWd+bDMsLMJlaiBLbk+DUsnQ0=; b=dyToyj4ZFioja9D4QO2Hsy8SLn
	9m9Bd14hK+MzP/MjxirbKUOixlgx4kuYbY1bBMr/UwsVpFyzoj2/hG4JqYMCCk8Hwtg2cdenJfkEX
	p5wA2vNtksqdEGHpEpaka4x1jZ69xAnQZU/SmdbSBa590BZji6VaRu0kLsIsbhdA+JF8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFXFO-00H261-Je; Wed, 22 Apr 2026 15:04:06 +0200
Date: Wed, 22 Apr 2026 15:04:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org,
	mingo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: packetengines: remove obsolete hamachi driver
Message-ID: <6f787c41-797a-4866-85a2-beb745fc3181@lunn.ch>
References: <20260422044820.485660-1-25181214217@stu.xidian.edu.cn>
 <20260422044820.485660-2-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422044820.485660-2-25181214217@stu.xidian.edu.cn>

On Wed, Apr 22, 2026 at 12:48:19PM +0800, Mingyu Wang wrote:
> The PacketEngine Hamachi driver is for PCI hardware that has been
> obsolete for over two decades. It recently triggered arithmetic
> exceptions during automated fuzzing.
> 
> As suggested by maintainers, remove the driver entirely to eliminate
> dead code and reduce the maintenance burden.
> 
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
