Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455906;
	b=bFiUgClQcmuPl3nDoGN3PvvIB21nuqLOXaaGY1+jfCrwe8tZVIiqLxgQgkVEUnla4Te9
	 XFZkOuzcrHBDlMgpdtA6/OGv2Q275rbv92xaAbUCLIHtouygPyGPbZjdLBv86gdD7/nXp
	 0rMmD/x6JSY0FsKkpEPf/YFlxqFL/eZKfDy4TXJi3/uZdw/ug6z3STesr65E/gdsNWXh7
	 EhDra8L0E4iy5FzDFz2JlFUmkRcltB1YgQFBKFG1hUyHf0UDGnOkm1b/+NP5Nxmm0FcYQ
	 QNXCFblYiWIWPQt/ZgJk+gB/FMzaUWHIU3rgOtwfM0AK50ex5KJU+ChfPddflMIDAIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455906;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JfQp6mBYLzM4icEFkNk0eym8A8kREkEG78YlGrzEHFg=;
	b=TjDZ4gm0s51s25kKt3qcmsQy0YhXjOkLFcDwCU4LWKQ8lgeCzri3Itj6nAOHsp6qjQ6/
	 3UJl+XS01YT0Q2W/vl0aEuGjDiYqUxFwtE1XTjiok+A2CGKBqrwWHY5lmPpgjTb4ZtOsx
	 L8ziTyANZIUBgoDAC6bEFGpxCLVhzPJNjYrU9cTHbvN9qdncP27WrYvbv++8S5H/blAJQ
	 VmECyFsdplZXYaI6PF+X9K4KP+sMqVq9Ew5qptZRDbXfXRT7dyFWzsO+3mq2bbwesDLT7
	 3hlTOGOxYpDQWoEcni+UeOfpPfCMnHpKrog96JZX+6X2gjspcpn0KhszwhFeAv3Ha+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsHoQP1G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54E606A319;
	Tue, 20 Oct 2026 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsHoQP1G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A261F000C4;
	Tue, 20 Oct 2026 00:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792455905;
	bh=JfQp6mBYLzM4icEFkNk0eym8A8kREkEG78YlGrzEHFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MsHoQP1GZ69spTdA+llZ8hbCB7h5UO6/eJLvCg8tM1tsOTyJnBi2FBI5/pY0J6qz+
	 QJaILiFfQLqSM8JHkyCd2DaXVjfbdLliIyqndPRe8dsgHgyKEX44fGubzZs9Oucino
	 hq3UPRyWXTy4OcV+1ygOpb8wSZx1UGiCV7450uA30nctxdRB2FsXdTSYzvoJPeUpp2
	 O5vQVNbayvR/3DtRg3hzbbbN1fitf//j/9t/LaVo7Yc0zobhw82cAIiAO8BQyow5/d
	 KP2hb9Z03dokeplp7YRv3Uq5pcr1VEvmQZo54eJVAW5ZsctqBXiNtvw8QZUWIsKcF/
	 JStzyoa0abUAg==
Date: Mon, 19 Oct 2026 17:25:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: rosenp@gmail.com, netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 nbd@openwrt.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bgmac: clear TX slots when freeing the ring
Message-ID: <20261019172504.093022fa@kernel.org>
In-Reply-To: <179170279214.434549.15109616376617039657@kernel.org>
References: <20261010070418.84457-1-rosenp@gmail.com>
	<179170279214.434549.15109616376617039657@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 07:13:12 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [High] net/bgmac: broken DMA mapping error cleanup in TX path

Should indeed be fixes together 
