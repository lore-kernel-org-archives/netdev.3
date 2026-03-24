Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F363DB636;
	Tue, 24 Mar 2026 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334918; cv=none; b=KCNNIHseJLMQ7oj2FGJsg8cpyHOJv24kAx04iYWAAUwWXYhHj5YwIGKI5MeqD64wEu66xdlrnv9AlW5IiCHPDILL8CxOWMRsY0NiW19wtZjZSVOnQPvYxLpQ7+bD6gIoXvcRaUhonOncroqUFrznBqEF8Wmevb5a+Dpehfspmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334918; c=relaxed/simple;
	bh=odvQZT5+RQNdWSOpTEVg/D+eh/9ZL9qJd+SCdaLEbWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grCpdFUkdIRbMLieMF74IePyKJh/v6SLLXNKVJ8DiTTE8XV8fvZxNwo4ye2AapVJCunYqsWZbrNgVsKszPaDWYiYbCzHRBoo0LEerdR302JTl0xObKeepINrea5OomnCJ1U9ZolxcRjTjzniLiWRgdEAv3pb416lEpdhduhODQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzsvAMTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzsvAMTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE76C19424;
	Tue, 24 Mar 2026 06:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774334917;
	bh=odvQZT5+RQNdWSOpTEVg/D+eh/9ZL9qJd+SCdaLEbWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzsvAMTtHq02M8vTpvj4+z3C//6/rTk0CvNXkWZfWGgDXl+UthVLSfzAUgytZFmo0
	 xx/36ErRwBTVzMPxLlJPNLzKK0sMDldnKRHqOvVtgPzEP6E0UXd+ctxTVRcluCM6AX
	 KccT28tnAz3SJXQyWHQMPzr/AkTVjPVDKBgvspu+PuWH9vLKtaDcvoLQ6TFCSDpYUh
	 BtBLWc0iCQUX/C0uIv3FD/uCGQkz8fcuAZII5ng7U0tr/zRf//8jIJTvDljaR0UoKm
	 burhCtW/stTZv0rw+RxPXM1yGj39USxc2hvcmGvQFVh/wCL2yBS5gutEYnvsIdbaWT
	 OXs+ge+SE25Gg==
Date: Tue, 24 Mar 2026 14:48:33 +0800
From: Yixun Lan <dlan@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5] riscv: dts: spacemit: Add ethernet device for K3
Message-ID: <20260324064833-GKA736590@kernel.org>
References: <20260324063714.750428-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324063714.750428-1-inochiama@gmail.com>

Hi Inochi, 

On 14:37 Tue 24 Mar     , Inochi Amaoto wrote:
> Add all ethernet device nodes for K3 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Looks good to me, thanks
Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
