Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403BF22AE65
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290622; cv=none; b=o1fOcaaZ8AQtuS88PJf85S5HAs2OJ4yphpeB1fXIWzFy2pFxPR8SLLiZhLrv8FVvM3oEH21PSZFYp6Teny0w97366QzfV+F8wT3wtwSyi6ma9MOl1e9goBL/afoAJn8sKGKeIW0yi1rfx7ETX8RHdyixCKO8zvTLGyYWnx6M8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290622; c=relaxed/simple;
	bh=hxFCBPZ0NE4hwxo++1RdW2SD4j7D2zu8igEJ7cJdV3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVNUaXXhxHHV0Ru4YLJAFiMVe+sL4ILz9a0f86/FVkT79KVtTWg19F3s3wB1DJJcyrgrAJA6wYx2AGetm46ZTfO4S5y5j4SIpKCivC4rZePoICmo49Tzzdlg/FEs1oSdkdOubCdqCnOwCeo0Uy3l9Vl4MrC4MNmBPwiv6XREhcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZIs+KGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZIs+KGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995621F000E9;
	Wed, 29 Jul 2026 02:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290621;
	bh=hxFCBPZ0NE4hwxo++1RdW2SD4j7D2zu8igEJ7cJdV3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WZIs+KGkw3r/4t87c4fioFHAWKDJnyqKtgTW+6QcXglW0wOUVp6RTyp2gfaiXyJI9
	 +k/wRJBJQzlX3SXaxAOub8AGqLov0nLJlKA1WXW9OOzNogWzyVueuDmKkI9nBm+GjA
	 9BAfmCDXeoUI7KDRzJtanXnmdtUdjhx5+Y8FWZEm2wsDP2rp00YgDLh7BRMORPMlMm
	 EwAUSR1hlCayEzUMPKeodRveMf76FPqax7WaIG7NgGXDgf9rzvhxq3Mn3lPkVD4xY0
	 bSZjWS4CsQv1C8zqACS+5Zjd5ZcKw4UeoJPKsw5n3QqX7Jm4CxohNADGPoMc/m21/T
	 QHo51RPoQkJBA==
Date: Tue, 28 Jul 2026 19:03:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: richardcochran@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] net: phy: dp83640: fix per-bus clock lifetime
Message-ID: <20260728190340.780d3f63@kernel.org>
In-Reply-To: <20260724023532.14583-1-xuanqiang.luo@linux.dev>
References: <20260724023532.14583-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 10:35:32 +0800 xuanqiang.luo@linux.dev wrote:
> Commit 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
> removal handling") moved per-bus clock cleanup from module exit to the
> remove path. This leaves two lifetime problems.

Isn't this sort of shared PHY resource problem supposed to be solved
using the PHY package API?
