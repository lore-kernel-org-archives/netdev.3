Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328336074D;
	Thu,  7 May 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166129; cv=none; b=QmovFYPjmgGuL8NCKi4wRbKOJXh3G/EhjZ+b+e2aHin74qGswYmSydK486qRK9rhe35sLjvzJ4pokpYpIHPCVMz/+xVZhx7eiYzFZwqk4JKOhpuHgfqiQr2sDfdLKhMJcwT2W9emosjP+Rpn2ZtggLic3giT5XtYUJRtTuGcgIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166129; c=relaxed/simple;
	bh=Tz3+n40bgUG+RR2d/vMtyETTE33zvfbgEfdQx8bGd2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uxgW08S+rcPCQMEYuPTgzLYH+F5ryqQKZXpkAbUOmoL5YzxIfOi5om/8QyI+eRnFK72eiccRO9mi9ib8i63HTMhwZSYPCh9xjAREiOxO3UqfKmPHq/aZyjwX11+oxNewOCWqSb1+o5FFfnq0lGVesORfRe4sMqiZHfyz2dNJP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0n3VZCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0n3VZCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26920C2BCB2;
	Thu,  7 May 2026 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166128;
	bh=Tz3+n40bgUG+RR2d/vMtyETTE33zvfbgEfdQx8bGd2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r0n3VZCr9h7LVE3CaM4E2eKku8mvjhkCIj9BLBf98qKaBjQbrdPyH1hTJKT3JnBDk
	 CGNOTnoCc0W4LrRvTtYcLzmzN1DZd4E4uIR/t4pt8k3jX8WwumDYe5Kmvnp2HFSWqq
	 EFHuIZ75KfQR5k805akEoQSV20Q3ey7i4j7TOUjpOcHSz59WD8+X4MywERGvyrdnai
	 /I869y+pM5nkMN9e5RZn0uzHscXFdS0JZXGiL7r2eqLCG4eznwTcJfZ2n13atqnAja
	 OmoUueahJdw+QNWsFjontQ8HZG32ZBiCwBG2GbTgFmdvJoEmXOA5ZjQjUM4/BCaH2C
	 qsN/VfWIkQk6g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Min Li <min.li.xe@renesas.com>, Matthew Bystrin <dev.mbstr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260429072047.1111427-1-dev.mbstr@gmail.com>
References: <20260429072047.1111427-1-dev.mbstr@gmail.com>
Subject: Re: [PATCH v2 0/2] mfd: rsmu: fixes and new IC support
Message-Id: <177816612689.1928138.2810599453250571292.b4-ty@b4>
Date: Thu, 07 May 2026 16:02:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 29 Apr 2026 10:20:45 +0300, Matthew Bystrin wrote:
> First patch fixes Renesas 8A34002 SPI driver.
> 
> In my setup 8A34002 is connected to VisionFive2 (via SPI or I2C). I've
> discovered that upstream driver does not work:
> 
> [    4.728771] 8a3400x-phc 8a3400x-phc.0.auto: 4.8.7, Id: 0x4002  HW Rev: 5  OTP Config Select: 0
> [    4.737389] 8a3400x-phc 8a3400x-phc.0.auto: requesting firmware 'idtcm.bin'
> [    4.744462] 8a3400x-phc 8a3400x-phc.0.auto: Direct firmware load for idtcm.bin failed with error -2
> [    4.753547] 8a3400x-phc 8a3400x-phc.0.auto: Failed at line 1273 in idtcm_load_firmware!
> [    4.761576] 8a3400x-phc 8a3400x-phc.0.auto: loading firmware failed with -2
> [    4.769411] 8a3400x-phc 8a3400x-phc.0.auto: No wait state: DPLL_SYS_STATE 0
> [    4.776374] 8a3400x-phc 8a3400x-phc.0.auto: Continuing while SYS APLL/DPLL is not locked
> [    4.785206] 8a3400x-phc 8a3400x-phc.0.auto: Unsupported MANUAL_REFERENCE: 0x00
> [    4.796930] 8a3400x-phc 8a3400x-phc.0.auto: PLL2 registered as ptp0
> 
> [...]

Applied, thanks!

[1/2] mfd: rsmu: fix page register setup
      commit: d65ff90be2c1a09e9e477e6f7493fae21b31e59c
[2/2] mfd: rsmu: add 8a34002 support
      commit: c8e94555a15fbe0925a9cc424118ca10e3b5531a

--
Lee Jones [李琼斯]

