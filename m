Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415037AA6F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646299; cv=none; b=nFJvB7T8lmAIKYV9ph9HPhDPnUNaSUelqLNTgP5LerBrIccgGc/ERESLuRf4F2PKAd8fEZoObETh7N1XFx4WIKkNEgBh11t69oppqqLNfzDlk1ByQCAvbiWbqAtS4VfEzbluYgbdKTjwFLCZwXv2hhPwMeS5o6N797cXLkVfbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646299; c=relaxed/simple;
	bh=fgYWH7HBwrxdOodX6x0w7u6A8Og//sc/xt2xpeduTpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f60o5G+nwglYIjv3mjPweZWiB7D4q6Qii/BaMBy3UedLzo3u2/pYiKmJmbKm6ql0JR/lI7WV3rDNDCUWn/THvWqK+VlpGY97Ow4X8ubcJ/3/H9uY2ARLGTMEZagkZWAg0UF3ympEwkyGxQhnU3jBw54/uOTkgBnDg9qrJbxlaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBoxsvVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBoxsvVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF2AC2BC86;
	Wed,  4 Mar 2026 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772646299;
	bh=fgYWH7HBwrxdOodX6x0w7u6A8Og//sc/xt2xpeduTpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VBoxsvVGTKJWLtQ9whxELu9fzmZjGi1uLxBDS+33+sHTQXOHkRQlCt1fCygQYI2IA
	 Mh4DYKZgaahlQabFDLdYiLx9E9dNbLmNr8YzySJ1afeGfBwU2Rb4cWrLvbyL7GiCRW
	 N3lnJ9talnc62ph2xBfz1tPJaDUFRnwcySpIkGfWeK9xunc7oMZfiCVp6Fw/7emNsW
	 3Hv0E9UFe318kPIwmL2i3Sbkk5R0TBMZhpNpcmFHrHyGmMDNzZZYfdQmD5Ut+KUzQf
	 4XTbt9K/iXJVBe+mA2PP+kGKm84GTnBCpMTfBr2jWKUeq/VEgsQCe6KjK92V2bxLcU
	 L3PHfxdDtIb4w==
Date: Wed, 4 Mar 2026 09:44:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <shenjian15@huawei.com>, <salil.mehta@huawei.com>
Subject: Re: [PATCH net 04/11] MAINTAINERS: remove Salil Mehta from
 HiSilicon network drivers
Message-ID: <20260304094457.79b783c0@kernel.org>
In-Reply-To: <259cd032-2ccb-452b-8524-75bc7162e138@huawei.com>
References: <20260303215339.2333548-1-kuba@kernel.org>
	<20260303215339.2333548-5-kuba@kernel.org>
	<259cd032-2ccb-452b-8524-75bc7162e138@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 20:17:36 +0800 Jijie Shao wrote:
> We expect him to return to full capacity in mid-March

Got it! Everything else you wrote is besides the point (point being 
the dereliction of upstream responsibilities). But if the situation 
was temporary I'll drop the patch.

Thanks!
