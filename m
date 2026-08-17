Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EE3F0A9F
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008908; cv=none; b=q7t/7KwI8K/jJm2zjrltLGDzoHuC0/F48EmPBaVRtnQDYXrq8TfxxsDKuS0L8g/RKy4OokpAoCEIj5pTuXr/HLbOLfFVR6ptKwRpdNy9YvFlgjKJIhpD9Hh6PyGeZKJMNq/N0kDFUQQMkRtimgNdBKYPHxLgp/xP0XeEqHfuyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008908; c=relaxed/simple;
	bh=a3jI7kcEpP/mZOh0Y/5JiDK6DHO9CQAawM8GXJTkHJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aefhSrbpF+XiJXXLFxonhh0zVTlYe9bQPfRRRXbx4ybR6hPQ4vgh7FBV8ey2o0yXLaI/Xhdd6HOx7Av2u5tp4kC7F//QMxKk2oiZDcyeJCuGbS64cPp3NK0jjyCSSkDBj1cOuleMBCT/g9o2N9CLmWYBQUTknL+ETVoB/Yep6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL1Smpbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL1Smpbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128881F000E9;
	Mon, 17 Aug 2026 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008907;
	bh=DaQtAM9F0HtMpUHnHkEDScFrzFMjcB+C0rNrL8PVYTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WL1SmpbiqZ8HYjr9anoUevEnOTrZWmWjRD6ovcqEAoxZVsjaXxWsPLmkUi3rWteHP
	 iBTF69Ag2YLGjnmG9VH99bv+QHI1Li0HKzVN+Sm9w+DZkfykeEkShBag5XcXqpvTt2
	 DD92szwhyzyIDD/z0K3gOu7h2T2vPtf3SeLJLKD160/6v30NoYjD327axnewvoJaGb
	 KoOuAaoOcVs66WrPXJPIFfl/933yX7UmXpXb6JcmkXNejL0oL6NaoZ3j265dIQLQtm
	 uJhmtSXeW1CYUsp9XLtaBoUYIMNJW0OIhqnF1yJ927X1baJ3kRSCuSpSbABkgQ5sbG
	 zVFa62QJF20Ag==
Date: Mon, 17 Aug 2026 16:21:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zhixing Chen <running910@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: keep LED device name valid after setup
Message-ID: <20260817162146.19061dc2@kernel.org>
In-Reply-To: <20260813100711.14724-1-running910@gmail.com>
References: <20260813100711.14724-1-running910@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 18:07:11 +0800 Zhixing Chen wrote:
> rtl8168_setup_ldev() and rtl8125_setup_led_ldev() build the LED device
> name in a stack buffer and assign it to led_cdev->name.
> 
> The LED class device registration path reads led_cdev->name after it has
> been assigned, and struct led_classdev stores the name as part of the LED
> class device state. Do not keep a pointer to a setup function's stack
> buffer there.
> 
> Store the name in struct r8169_led_classdev instead, so it remains valid
> for the lifetime of the LED class device.

Applied
-- 
pw-bot: accept
