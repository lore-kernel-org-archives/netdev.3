Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574A35AC09;
	Wed,  6 May 2026 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778108065; cv=none; b=mxfpuK0m11sRGAd7s5dm+halSLobVfLfbxV/lfabdKXrb/OU+47zaFTMZ7xu80986KmFPXvM1Oo7Lhh5gA/39QHn38ct3/Kq1lQRwCeyc9uFGSrIyIx05nXjqdfsopJExe1mj/461x/UA7WhMq/JHXB8/YJLqK/gRDtgV4vB1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778108065; c=relaxed/simple;
	bh=/emLRXQA9E1nZaqrBD/krxsRuN04zRUYp2LeLko9BIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHWY9WdSa8MwkWACer3N9NCScTvgukY6IVkXGXVJKpri57Z+iTPL0R9M7axURXZuozyyamAxAx5abLLGV9B80vY6ZR12vxSSOcxYUJIExNyYrs3y8i34R/bW0CcjzbCjZYppULzhopJnUAWNDhqpUkvWeoVsqQKgNAnvSD6N0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=to4a0KeS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="to4a0KeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50953C2BCB0;
	Wed,  6 May 2026 22:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778108064;
	bh=/emLRXQA9E1nZaqrBD/krxsRuN04zRUYp2LeLko9BIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=to4a0KeSa/ffM04UUSebotzp6bbNtq3MHg07c59whAz5KHcWd6JK2VTA06BYrHOJ3
	 mYKd+RvlnW9zBUl4JMeNtbNYGq3An9z6xOgt9abzojO/wCGPKzwMzCmSimSAq60kTe
	 9nY4wWVnJFLibRFVrdbAWzZf9qsmhV+Kr07Sksnb6eosdYAn5JvZw0KD9b3JY7NBzn
	 x3VFnrWNiokZ5HcfSnRrBQYqyyE3aqajj5myRSShxi+weMt/5fLLJY+1/LgduGE3ZB
	 8uiWY7x+Mxd+YCc5j0lHe7/O5+BLyrVDJu45Fmx6IfO1+yGMoJjSMwZZ+qsqyJKiHM
	 dgbCRjYrupdjw==
Date: Wed, 6 May 2026 15:54:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v1 2/7] r8169: add support for multi rx queues
Message-ID: <20260506155423.56a1ffdb@kernel.org>
In-Reply-To: <20260506081326.767-3-javen_xu@realsil.com.cn>
References: <20260506081326.767-1-javen_xu@realsil.com.cn>
	<20260506081326.767-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 16:13:20 +0800 javen wrote:
> This patch adds support for multi rx queues. RSS requires multi rx
> queues to receive packets. So we need struct rtl8169_rx_ring for each
> queue.

../drivers/net/ethernet/realtek/r8169_main.c:4994:16:    expected unsigned int
../drivers/net/ethernet/realtek/r8169_main.c:4994:16:    got restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5032:26: warning: cast to restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5046:34: warning: cast to restricted __le32
-- 
pw-bot: cr
