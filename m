Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DED312825;
	Fri, 21 Aug 2026 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787281066; cv=none; b=c2LjoLu3YsQ9vpjE4N6PhJCFDIv+u1y9PjvK3CzUzV3tHAFsG5X7goS1u/oHboTy5qFwFHoZQWd29CkOa72udCtE/WV3qzfJfHsgEZKN33bv2bxqomtvnB7PBMUyNsi+kwA/OL07/qn4E8vwS3rtOpTa2ZU+9ML4o7mhjWBgZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787281066; c=relaxed/simple;
	bh=GEk0fEkgjY+24E0SSiYGexamDIWs+lb00eCoekUwfxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kqt96zKsjGRRTw0YNG8hNmbCTk04wQ5QdUi5e/88G5rZ/RFPYjTZsVn2/otZ6g7vYRdtJE87TPQY+wvTLObg2IDwIiTtyBzUbwbvPpK2CmamMUyPrvL5uVPbOlga06SMwXb2vZDCb56yyRqsdUaunAcBwKfdRD0eil8ATX7WM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mM+L9abZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mM+L9abZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8D/Sm+nEzLJIYf7fqQJMKxuFtPIASn3hXt8YdxDhwZ4=; b=mM+L9abZHPCyIfYAl65BYJX0e7
	+QYvQ1xZIBp45+XMQXYbDPYi7W4rD9kWpwiZ5BWLN/yJFHmfVlHtSAdZ3a6aDByfMwv2YUODRs3oP
	52TntOje3SUSDipF/oCOZSh4B2Ku5tktqxWBKZvG7HsCzxPv3xs5D73PsL4YOt1zuM7U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wxFRk-000sI1-3M; Fri, 21 Aug 2026 04:57:32 +0200
Date: Fri, 21 Aug 2026 04:57:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>, Doug Berger <opendmb@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] net: broadcom: Improve IRQ error handling
Message-ID: <f999c24e-7009-45aa-bf09-658d368af8eb@lunn.ch>
References: <20260820111456.97947-1-phucduc.bui@gmail.com>
 <a618bdba-c370-4f16-ac09-0f7ceb742d42@redhat.com>
 <cc18ef57-4f5b-4459-b110-b29bf2c8b8eb@broadcom.com>
 <1958a140-a3ff-4f0c-8982-9695d1dbd8a1@broadcom.com>
 <CAABR9nGr+cYmGsj2eXHCRRvN7TkcsT_bTS2LkA537Z2Ns0VORQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABR9nGr+cYmGsj2eXHCRRvN7TkcsT_bTS2LkA537Z2Ns0VORQ@mail.gmail.com>

> What about -EPROBE_DEFER? Do you also want to ignore it and not
> give the driver a chance to probe again?

Please do some git research. How long has the code been this way?

If -EPROBE_DEFER was a problem, why has nobody reported it?

    Andrew
