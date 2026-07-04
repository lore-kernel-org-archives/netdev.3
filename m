Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0E3A8759;
	Sat,  4 Jul 2026 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783166362; cv=none; b=ls6lsifEtVnvjIY1sqd+6xwNfvTSjDaqKhN+qMCLSRg9OITUldzoAIls0+UaZ2CFlvC8g2F4kXwzt4SDueO974S9ZfFBmn54nbMbBqJq86v6TpYVbFcHqFGgy8dELBYAqBv4c4FlY0OHvaOCocWOUr5w/g3MTh6Hg944XMgdeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783166362; c=relaxed/simple;
	bh=ZGQ5T5hVMk4bVsB0AhSWuwmKNhetB0SBNETEJC3CzXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLnfFfNZYesde+VJJx+qhw6bhu48P9UzRdBK02js3FSL4HCGfcvaohutBvtHCD6FaRicaJj20ZSBIvUcajJrGcCfVlqvh9y67/PT1GKrsGOZJ1eMBMsYyvS1ESl1JkclQmEkHpxlWjfDiRO3OkYTD/CqS+Y5xGAGHt2/YV2NKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Sat, 4 Jul 2026 13:58:52 +0200
From: Brett Sheffield <brett@librecast.net>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tun/tap & vhost-net: make qdisc backpressure opt-in
 via IFF_BACKPRESSURE
Message-ID: <akj1fObc_PSd4oha@karahi.librecast.net>
References: <20260704112058.95421-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704112058.95421-1-simon.schippers@tu-dortmund.de>

On 2026-07-04 13:20, Simon Schippers wrote:
> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
> when a qdisc is present") did not show a relevant performance regression
> in my testing but on Brett Sheffield's librecast testbed it shows a
> significant performance drop. The regression can be pinpointed when
> multiple iperf3 TCP threads are sending. For 8 threads the performance
> dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is the reason why this
> patch makes the qdisc backpressure behavior opt-in.

Thanks Simon.

I've tested and confirmed this fixes the original failing IPv6 multicast (UDP)
test which flagged the problem.

Tested-by: Brett A C Sheffield <bacs@librecast.net>

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/
