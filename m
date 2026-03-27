Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8E35DA47;
	Fri, 27 Mar 2026 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581090; cv=none; b=OEFqJFkYlvsuQZMGe5G3SkIEw7LdTVPdwFT7cyZ7Ajkzjzh1cIF/hAeWvLngnD/Wijy2uqIwZFcAile7oiVP1VfViyiAixkhZHG5ZYLoLZThCEG8CqnUYBV2E6nvM13nWmiiw84yQ14inFWVbwoMFF2rhQlBFfy0LQTSCBTqgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581090; c=relaxed/simple;
	bh=dB+xLM5/BZobo4u+rQqw4CvliEp3K6y7TB/YZt1YJXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mamMAGEYaxjRQOalrwdm8JfPkCnVL4egMOd5PY96unOaJS5zf7rdgm9mcyu7NdLrp4y+ATqC2UKE2hLnEjzAwWOVDz/vsc4G57KKnHz5uyuMPRgsghRuI9pJAaxmqZSLiwxfFBhnk+T2y6XxtlfM6+1SwCVVMk+6NnjIdeZ2mQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnEOWSIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnEOWSIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CDAC116C6;
	Fri, 27 Mar 2026 03:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581090;
	bh=dB+xLM5/BZobo4u+rQqw4CvliEp3K6y7TB/YZt1YJXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hnEOWSIjDgs8Si4ZA+9p7wvM4GqPZOP3iTc7uW8RsAl+wrqi/G1ISlNSR6zd/8r2m
	 AMoyXNjtmJc/XfB4MD55XWgd1cjzqHMkrPysOQpyNRA9uwwO6ouydbN1/2crVs8gcX
	 lijd8N7xRyRGaJ7CWdjPlLy4PSBvBiFkdPae0PS2L/z2VFSWfdD3RgUMej/gZCq18Q
	 S3F2XxGb5ylKd2td+Ua2vL+2d2VkqfdQjU9jF4UuRj6aXLZthuT96AsgoHud6TMu4C
	 STxmABtIDqoAG/duu/F+y00rQkIqq3vx8PHaiY05Youa6GMX22jWle79r0wF4VQ9gl
	 XmU/Cm/V+nzlg==
Date: Thu, 26 Mar 2026 20:11:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH v2 0/7] J722S SGMII support
Message-ID: <20260326201127.7ceb290f@kernel.org>
In-Reply-To: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
References: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 13:29:36 +0100 Nora Schiffer wrote:
> The J722S CPSW and SERDES are very similar to the variants found on the
> AM64, but they additionally support SGMII. Introduce new compatible
> strings for the J722S to add this support to the drivers.
> 
> This is a prerequisite for the Single-Pair Ethernet interface of the
> TQ-Systems MBa67xx baseboard for the TQMa67xx SoM, which will be
> submitted separately.

Please repost patch 3+6 as a separate series for net-next.
