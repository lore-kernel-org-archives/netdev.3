Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161A2E413;
	Tue, 12 May 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550259; cv=none; b=e+lHdzVsZoSaz/vEg12AXtJ16P+GWWN9sxg5IeCPcSQRN57zaFM55Y7MMkrWiwYkZDDbYGfhBg3uRXnpH78aE+u3db5hJBUwpjqYSBUsCj+O+DcPkeSicR+fNIEkAEX6NcJ7gJvYNt+nYNmVbpJZMJbUZCvrnSEBnR57D3HhiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550259; c=relaxed/simple;
	bh=2oLZ9HEDZfnXFOu7F8sA78Z5EORJO9MgqxSmpKyTdNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNjm4NRjDIF5HqAV8NFE3BfAgyL76LeaLeADZ/kaGajWt2U81AB6ZX5b8xMHQuwvn2WMrY/dWu5EI70ls/CTg9knxgZIM4oKsi2Soc14Zl8DFkdhZDN80ee8eyhMJ3buHrq/17oCWQz+jySO8S+U1ZNpRQxUS5MsRRBhSj1DW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXNjczXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXNjczXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424D2C2BCB0;
	Tue, 12 May 2026 01:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778550258;
	bh=2oLZ9HEDZfnXFOu7F8sA78Z5EORJO9MgqxSmpKyTdNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SXNjczXohtXwgbXcFivDdz7+xN2lOFepOQQiZZFLMHpQEUMI2HFd8LBzcRisLQeTb
	 fGnXyt6jyyXEY9xoLb0Dyz+YqhfgC0Ns40Bd/f9LFb382m3/6eut4cDOGJ8xv/0BPX
	 qMTvnwSTh421JeES8isZQkAHMnHj9ThlOz/eUzbbpXOusO4Pl2A0mTLahuOlVsywjN
	 SzW1A46KcQiz/gNNmdYW9ktAmCLuvgdyVn/41HwTrIsw35fSQK+sk66gENCj7J+7hg
	 RUK8egVCU/YmGNC8dl8j+NmDTRRzhsrZI4tnyF8klFy//L0nFmGcN8WMTnVi2z/LN+
	 cwHdoOQ3YPxrg==
Date: Mon, 11 May 2026 18:44:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v2 5/7] r8169: add support and enable rss
Message-ID: <20260511184417.03f810dd@kernel.org>
In-Reply-To: <20260508121802.2010-6-javen_xu@realsil.com.cn>
References: <20260508121802.2010-1-javen_xu@realsil.com.cn>
	<20260508121802.2010-6-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 20:17:59 +0800 javen wrote:
> This patch adds support and enable rss for RTL8127.

Building with C=1 exposes:

../drivers/net/ethernet/realtek/r8169_main.c:5242:24: warning: incorrect type in return expression (different base types)
../drivers/net/ethernet/realtek/r8169_main.c:5242:24:    expected unsigned int
../drivers/net/ethernet/realtek/r8169_main.c:5242:24:    got restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5244:24: warning: incorrect type in return expression (different base types)
../drivers/net/ethernet/realtek/r8169_main.c:5244:24:    expected unsigned int
../drivers/net/ethernet/realtek/r8169_main.c:5244:24:    got restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5303:26: warning: cast to restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5317:34: warning: cast to restricted __le32
-- 
pw-bot: cr
