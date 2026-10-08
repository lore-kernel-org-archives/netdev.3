Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD473ABD82;
	Thu,  8 Oct 2026 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478550; cv=none; b=Q1FR5Z6j6/AjcgBmFRi80eQtPLy3zUG80QNyLN8JmqzM4R6byZPJOUijlrWy9Jh0cPxAjJ15mjASGHEgsQiEf8nvyXcMf3d58H3MjQgBf9UE2pXS1tXac6Yn4Cvh0CUUmxdsdd0dinctQYZSIlMBpxY6IMASsFxMvGUx14OnPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478550; c=relaxed/simple;
	bh=r5pTeXtoGmILx2vCFJoRaJuWw6ziwqGO2Zvw2fGLP6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifnobDaS0Ex/HUQfY/lZY0sFqnAjvR0HhShm1SbLSexmGWxuA1STsy28zc6z2deVkFQKYzv1R+4ZACwk20CE58I3vO64UGCV35AB3BK3TCocIlyBixzjxjOjQo6t7UpQnG8sf4T/m7hVQ+QTn9hm64chnj+iaCjnYLUhlXoHwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuQvn5oq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuQvn5oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A91F1F000FF;
	Thu,  8 Oct 2026 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791478548;
	bh=sISNpZcPe6lT5r/ToETeX+ofwSBrJe4Ww5pF//kWQH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iuQvn5oq9ewiqe7NFLqK8p0ShUtAcXrttWGHZLKvGc7VxFWD7+3PWaelBGzsyLYQA
	 fHqXgfP//Y5WDMVpR43LZ9mstzfStHI4NywHHljKXgMGFytE1IJQOGQT2I0WVFKqvo
	 5uiP3GYsPD8Vo/zuXt9jGnQKLsEiwnlryBF2Rojp6vCp6eo7MfX3m9ALwsoq8huvej
	 EBhASl93JX4rDSEdntrBj/RaYn5YCFEcJKQ3HuhODHwRy80ths0uOSJMPpw9ta4UVb
	 zODfN3KSqUoKt0rIuAH5g2kOgajNMFldCx+rW1ySD+M4WNqD5+KpZQi7NQM7KW0/gm
	 6l6xtivvBR6Lg==
Date: Thu, 8 Oct 2026 09:55:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: yongzhao.derek@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, george.moussalem@outlook.com,
 hzyitc@outlook.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: phy: qcom: at803x: Apply IPQ5018 analog
 settings at probe
Message-ID: <20261008095547.6715b24e@kernel.org>
In-Reply-To: <179106246893.434549.12601361985639254046@kernel.org>
References: <20261002210408.730-1-yongzhao.derek@gmail.com>
	<179106246893.434549.12601361985639254046@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 03 Oct 2026 21:21:08 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] ipq5018_probe() (drivers/net/phy/qcom/at803x.c) calls
>   reset_control_reset(priv->rst) at line 1135.

Please answer the AI feedback / question
