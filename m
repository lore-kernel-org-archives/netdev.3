Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0D1FF1DA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397845; cv=none; b=qXdo2Ki6MuHkoZrB8YBxUZb1/T6NByIwBmsDg93Uf7/FdRgLTkqI/8g6fzEbkvaEfzzjiHZPhLfy63jT8XiYqEXLNvdmpsaCpjMwKeVUq0LUofzbULqIrm2LKqu5CyMRxNGMatslLrzqIKxX5M6fsYNDjH5HbZs9s7iVws4x+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397845; c=relaxed/simple;
	bh=UEUgM2lBwpERgAnniyNvv1ngePEQKoQXBkVUakGfSc4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uhUyMYoECxLchSxfUea5TGHhQG3H4p/IZPoIP0F2UZCXUirSMlUiKHs6Gsx3q09nj656dgtPq+S4T8kFULkqVGkTaXoOp+Ctg9q6AT1bfXxOhxfO0calqmjRUOPO09kCZF0RqjXJvkZdi/HE+z5amSLKiafwrz7Fmmyr0Pxppdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=CwYHVEs/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="CwYHVEs/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 197B9A0334;
	Tue,  2 Jun 2026 12:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780397837; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZLNiQwa6NPELSwHq68/eDSos8DQKmn62qGnHQChpUL0=;
	b=CwYHVEs/KQN/ovba/Oyy56Fkq8rYfCwzgJDIkQ6SG+884ROX9WOqjWsxu/dC+LZESY9mQo
	57431q77UPoupKi/UhCuDP33L6HnghDdkHTAQNWDUr8VuCiuNlsuPx9P6tRiW3UgMie7KN
	e9ays5qQlybsUr5WYDbzUcFURJQfgtuMyHW5H0swKwGSn+7V6WImd+WFWukChF0n0mzsFY
	HzjctVXnX7nI4tXzQjZDa+WmqusF6eATVsBLUEkWycOFeuWBdPpy9WZnkmB6OVCskb8/eu
	nQ88Gk5bn1y87kGElxySalL6G8jH4jI6HLugwWzCF3XCxgV5UAFnp+FQi+OQeA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 02 Jun 2026 12:57:14 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, joshwash@google.com, tariqt@nvidia.com,
 haiyangz@microsoft.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, willemb@google.com,
 ernis@linux.microsoft.com, sdf.kernel@gmail.com, kory.maincent@bootlin.com,
 danieller@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next 14/14] docs: net: ethtool: document ops-locked
 drivers and op_needs_rtnl
In-Reply-To: <20260528231637.251822-15-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
 <20260528231637.251822-15-kuba@kernel.org>
Message-ID: <ffbd0e9caadec54e8cfc6944ed990353@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub

On 29.5.2026 01:16, Jakub Kicinski wrote:
> Catch up various bits of documentation after the locking changes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/netdev-features.rst |  7 +++++++
>  Documentation/networking/netdevices.rst      | 17 ++++++++++-------
>  include/linux/ethtool.h                      | 10 ++++++++--
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/networking/netdev-features.rst 
> b/Documentation/networking/netdev-features.rst
> index 6293d47e5b09..f9e1f3921f53 100644

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
