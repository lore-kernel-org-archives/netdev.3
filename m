Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BE49362C;
	Sun, 23 Aug 2026 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787522151; cv=none; b=Rw/CejqGGcAA2ZPBQLfH3+XDpTq3QzS/HOaArz/Q6xUxpqpnlO6lojgwyoYUFC3YdYHN0y/VdwQtjYRd2A9RsL9QFEnRdTi86uFGWsCDPKB3Xxt6Ye/lcchz4TPeRLQBTHs4qXMqvvp8TV7zQ8TsoT9SHfH86YLVL+DoecMZbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787522151; c=relaxed/simple;
	bh=3KvJ8+Bwjyps+xuXkAyjhUtzIvopXgo4PGJonHH1fM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaFTM29nSwLXTS1ke3hZyd8EBm/QyTND2MlXGzSu+iryGumHV06x4Dvm3GYB82ZtMxtZyZBGaSoIYOVWFx2r932e8FALMwM5aSpr1Z9iShcx/A2/voFqM0tGacvZkrtJ2b301819PpKNHqNibWBKlZOLyKyzEtPTh90D7MMGN98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tJjg3izP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tJjg3izP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fRqciaD/8FXYX2jJG8z8NPikSLEMdvWGdMt/Y3+8HL0=; b=tJjg3izPDVfFVbAqeCWuwjNyKW
	jdURSlFo2vxW+/UrL35s4/b6U2t2r7OWAWsLx0/00a7WktCRmmqg2BOMhBK92hnsFxEycVCrime0C
	3/ysw7bfGVpC+LHMOPK50smV08zU2IfDyoHDINTrs5DbUdKzHmh8CNmlWrY/khhWH0OQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyGA7-001A1Z-93; Sun, 23 Aug 2026 23:55:31 +0200
Date: Sun, 23 Aug 2026 23:55:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v1 1/3] dinghai: add firmware version check and?
 RISC-V readiness polling
Message-ID: <8e4d0c3f-0483-40cf-87d4-4a06bccf558d@lunn.ch>
References: <20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn>
 <20260824033538020rXU4GiMrh05w37DWs5k7v@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824033538020rXU4GiMrh05w37DWs5k7v@zte.com.cn>

> +	for (i = 0; i < ZXDH_RISCV_READY_TIMEOUT_SEC; i++) {
> +		if (ioread8(&hb->riscv_power_on) == 1)
> +			return 0;
> +		msleep(MSEC_PER_SEC);
> +	}

Please use one of the macros in iopoll.h

	Andrew
