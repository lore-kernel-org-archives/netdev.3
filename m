Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172AD47F770
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885512; cv=none; b=aAiKUpMaj1NXSMOpFnOjkg3KmwVNGFfs9mDPr4EMUd+1+3x+QRf6rkEP9JaAqoyrjWtYSuNKmUmf5TrHatdvu4bRXDIHs/v3qsEUQeSM+2uL1+ojsQ6AKlvn2aHQ1p3ZzGuUg1dUJLGawhZlS0YLu5z6Bs/V0UML81Y3pQw07U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885512; c=relaxed/simple;
	bh=+p4s3K9XQ+oiv6jlNIiUN+3JKQnMoNvq1fPu9lDzRqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el+ym1kQTKYMGfdMYNPuToGdfwj52rBxWXGaDdBSX9SgW3H36CuIkaSGYzJHg4FJgLdfaIH3+kVhA2YMjzEnPGtUOqoCqPCFrClKvnBv+sgQ0TOjenVMCEVxVo2rbLw0kAEAGGuHShVn9soAxJ/8BNMEaFs8cuT+YvxsTiW09GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u2oKYqNr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u2oKYqNr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5C9001A11F7;
	Tue, 13 Oct 2026 09:58:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25E1B60362;
	Tue, 13 Oct 2026 09:58:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3EBC11D7017F;
	Tue, 13 Oct 2026 11:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791885506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZEa+Rdu9+EfuAYgmCjCGvhNSYahtyd7A0zbUlfTjoks=;
	b=u2oKYqNrsffIJJl9wdO6pP/oLGOSIm88BphtIbxi6xl/dc1yLIvFx3d6uBPLrpl3xLiyY8
	YMNp00e9oq6fCGZvI2EbtEcbkUbQDQC0bdocHGz+vjAYbX4goO22X1a/hQns/CnoTGgP3q
	Ji1UIObrKcCPvqF75TRQhOEEVCjFKSu4tycAXvxKxZ+HwQMSgxNfkXsu02NhOYQB3Y2sUW
	RSZNPMmJd71HAHVzawjz2x+vlQB2eMW9Kf1g9eqr3YIMVFqeZ00VE1LbA9KM0iGS0TLo3q
	AJcehyb1E6hjDeRzado5DSWFAAmdLKrDWmutZtCv5bV42gwlDtAiuHq4gpfXQg==
Message-ID: <b3cc2212-c6d4-4e28-9181-6f8a474f5f31@bootlin.com>
Date: Tue, 13 Oct 2026 11:58:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: fix mqprio and cbs combination
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Daniel Thompson <daniel@riscstar.com>
References: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/12/26 23:14, Lorenzo Bianconi wrote:
> The channel-mode mqprio offload and the CBS offload can currently not be
> enabled at the same time. tc_mqprio_validate_chan_mode() refuses the
> mqprio offload as soon as any TX queue is configured in AVB mode, and
> tc_setup_cbs() refuses to enable CBS while the strict-priority scheduler
> is active. As a result the combination is rejected whichever order the
> two are configured in.
> 
> The strict-priority scheduler selected by the channel-mode mqprio
> offload and the per-queue CBS shaper are independent MTL settings and do
> not conflict, so drop the checks and let the combination be offloaded.
> The following configuration, which was previously refused, now works:
> 
>   $ tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
>         map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
>         queues 1@0 1@1 1@2 1@3 mode channel hw 1
>   $ tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
>         idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049 offload 0
>   $ tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
>         idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296 offload 1
>   $ tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
>         idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419 offload 1
> 
> Fixes: 47891d501e34 ("net: stmmac: add tc mqprio hw queue priority offload")
> Tested-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you Lorenzo,

Maxime

