Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC333A1D02
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351430; cv=none; b=CH7u7Appl+y6ElzfCnMh+igosDEYLC1q147VHH0yy3zMhaWjiycN2U1Wg7Q8GcLqfzlBPNP2aLaw46Bon1E8T/yXmqTeUTR5DIEIASuNHqF7O8P8Gw1Uf5C/5KxAh12UIAAt5SLdkXuBKu78+ALDFSz5FGAJKDnlnk3IKYwQ/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351430; c=relaxed/simple;
	bh=h8lcoDN61XA3VNvVLLwt7QeCeFEM2hzvfdZ5NOd6MrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAWy7orrKKRbU0VHtAc0B5lZQT5ZO/I75NW6TobFTaUgsz/R97m/M9uaWs3RXQvPbMt2UWzWGSzVYPWvvS+UL7DffSZKzYm+Pf1g0vwrSvOOWvI99ZTl9bLBDD+r/dru3tTFizCuiIgxrmp6LoSGWSDcZz/zM7GIsnAH3xcqlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4Z/Nuh2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4Z/Nuh2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49553515a8bso25158595e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786351427; x=1786956227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=82TRoDvPhYlSGxJG5SsG9eW7+UxHfv5RnYX+401a0Rc=;
        b=P4Z/Nuh2zYrr/7LY/DhlrLqRaDEb4MKQluc/tw3XfJlO2Es3eNLEDL1byrGKgIqIrh
         t7XewpBGjYQsdlqrQoxTdatiULwfb+9EB+Ym9zxMCJJ8d1ZgE1QgLy2+whW/JnDg7VPe
         QEjFVINBYNDgvNhqgbLkLv0h0A7ZKwEV8dGH8rr/2wOx5g52YySUfH6wlkwVNW541d5U
         AwMVVfEh08o8RW0VIvCZs8Qc7zo2o5x7U4Jp7D3qzM+emm086XftbvlvQiNfqljupRMn
         rRdhW0paF0OUqiQiHJMER96UfYeb27FyVerRukHWAMpk94wHkPgO6aWwc75Swbr+Ur+C
         WvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786351427; x=1786956227;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=82TRoDvPhYlSGxJG5SsG9eW7+UxHfv5RnYX+401a0Rc=;
        b=e12NCtKhTa14ljhr1TDeFpvn78kQOiOlJK1VyQ26zX41EbFdNQ7YR522lMNZbJHvSB
         7D84FvFfBaacQvRbX5o+q1ah0Ugdr/3V6Kk3QbXvBiPzuXr73F0tBj3LSyk9cyQk/c5v
         bGRMdwdFAr8tsr5dmvmHw5CL70BN+/9WSK3A/pl6M9R711XLFC0e7HFbrFPuyRhM3Pt4
         uEeVz+Wrkq7T+9JKvrMVroHaCTvIAnvVNAliuRgTfqZycAxUWVwmAhsEbtDWNxC1IzNt
         8OWUzPXdv26zedu/tSVHYnJAOHAo1x7/tkZqSWag7b4qQrFPL9Iy0I6YGH+w7TB9RCSd
         OUCg==
X-Forwarded-Encrypted: i=1; AHgh+RoFSxW/3pte8J6q5HzZJmdQwcH1XJjuIt6Q1EEBW6inr9AM8g/VrtLW4ZkabaUOgQhgFTKjz4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCknGRpQ9DM8CwNvZEBSmj+OmViCa9EfCLLl/1eYw5Hys1OTY
	LvOx8jJAd+pTtZDpiaTa+D82dzGxEAKxsSRfcn65ZJKmse+saNlcmGnK9BENeZURkts=
X-Gm-Gg: AR+sD10C2zcj1C4OpjS6HAZOwxhjn0L+h/VkyiAHl6sBGXivnmtS5nrszRqj3dkLOnX
	D0T0qBUwl0Wf7yvd9CfiZTMhbMyxu6fmXgV4jjVXrA/xNT/GUK6wyca9UQ5uJs4UjUkiekSUHHF
	4RTn0We/ASTxTqvgDKv5V5uAFqHU9Cvr3Wd1yCVNBfPzOKiPIaBD7siwGv1HEn1lvKgcxs1Yrzo
	hiuAA44t/7M2fmSNN+PQuI19qsQBEWysj7x1/kVaE1cjSYXE783VbDZVx+jji49/02zk2/gr9ZM
	L1JO3ZMI8WyF+Sdxpaj5Fb3qbTJDUB0jOPMrQcfy/bB7r+Tihguu7pdtN3Bd5yd9YAdkwwr7scv
	xSY2fikI4drljss0pRcOq9oPiTooioI+qU8ZsbvmKoNUN3LkbZErsSelTb1nWCYese92HV3b+kq
	Su2geXxQ3M2ppiEHiSTf2JSG0K7/TQ6OtMSZxhd2SDzOT7dSMsA/WDSqeuKFEQ6qfWb1y4xOk=
X-Received: by 2002:a05:600c:1992:b0:499:593c:3384 with SMTP id 5b1f17b1804b1-49959e08773mr345474155e9.6.1786351427393;
        Mon, 10 Aug 2026 01:43:47 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:71da:59f:1cf4:ec2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm33710246f8f.14.2026.08.10.01.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:43:46 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:43:45 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: wwan: qcom_bam_dmux: fix TX DMA channel
 use-after-free
Message-ID: <anmPQZXKgr5AONMS@linaro.org>
References: <20260808083457.2023-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808083457.2023-1-getshell@seu.edu.cn>

On Sat, Aug 08, 2026 at 04:34:57PM +0800, Hongyan Xu wrote:
> The modem power-control interrupt can currently call bam_dmux_power_off()
> and release dmux->tx while the host side still has an active runtime PM
> vote and is preparing or issuing TX DMA descriptors. Runtime PM prevents
> the runtime suspend callback from running in that window, but it does not
> serialize the modem-driven pc interrupt with the command, netdev transmit,
> or deferred wakeup paths that use dmux->tx.
> 
> Serialize power-control state with a mutex and track the host pc vote under
> that lock. If the modem reports pc=false while the host vote is still
> active, acknowledge the pc transition but keep the DMA channels allocated.
> This avoids releasing the TX channel underneath active users and avoids
> terminating already queued commands such as BAM_DMUX_CMD_OPEN.
> 

Unfortunately, this version won't work in practice because the modem
will power down the DMA engine as soon as we acknowledge the pc
transition. We need to release the TX channel (and bring the DMA engine
into clean reset state) before sending the pc-ack (or refuse sending the
pc-ack if the modem firmware is broken). The whole state management is
unfortunately very tricky as I wrote in v1 [1].

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/anSzDNYf0AMW7U9Y@linaro.org/
