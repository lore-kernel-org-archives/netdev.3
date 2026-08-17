Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9462C3245;
	Mon, 17 Aug 2026 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006304; cv=none; b=eZB9D63p23qSNUC84Mlp0YgH+kEyP3K2hKOqmmv+Rm1ZYqlNHBsOZeaIXWJJcJN8E7VKe6BA7j3nfAHds1KH82UJtm8Bg9lsHRcBNW5OEBCl74pFqL/PLrWTdSZ5BDKrfgEuLJOng17AluykAtweLW0e/79y067XUkQdTg/m9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006304; c=relaxed/simple;
	bh=6MQDmmi489+J32O1Hp2TCiuVBnz9rSj/w+MrSjdNOg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAYgR2MDSmnV4fIkowvYfeKDS4iYCTTfRErf06pTQ6ymNp3ApMmbWRjGvqmBoGORXGV63lW34UVqJ8ybIRKKrg2DS5MSKpKDQfwF3aIgwEi53TVoyYB10vhpxFQuZ1NnzO+cH0Qf9mcnqokEPaqhDxA+9k17OhPIRNOn6277Kl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4aAyeZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4aAyeZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330CA1F00A3A;
	Mon, 17 Aug 2026 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006302;
	bh=6MQDmmi489+J32O1Hp2TCiuVBnz9rSj/w+MrSjdNOg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B4aAyeZOXY+TB1DjdqVF58uXzHkWLQC9Fp0dpoPDAc7Y56bIobyPeLrCk7q0O1xK1
	 AYHbv6V1REHbq0WQQO66qeQJnhFcdx7nIuLiLEXMBdv9vdGoLIXYDmXTt/Pb//QPv3
	 WMrM9pBF2EM15AJGLni2ZuyxzmRR/ABnxo+Iq+ESJgbphrzxrkUWocg/Vt7YxmI3sb
	 AINxwZnrDuv34xO6dKWZdr8YHJ2nezXEwpuSIXrNa4fcQUYShxsE0gBBDA9aeLgstk
	 +26DidBbp7m0dIG7MqfhbAynQu2tCDA33RlZV0yYiNHc7qG8O237OwhbesVGOZBHy5
	 PNqm/OdjvVyrw==
Date: Mon, 17 Aug 2026 15:38:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Cc: jackbb_wu@compal.com, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, Minano Tseng
 <Minano.tseng@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Robert Yu <robert_yu@compal.com>, Jeff Chang
 <Jeff_Chang@compal.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 7/7] net: wwan: t9xx: Add maintainers entry
Message-ID: <20260817153821.6ee1b4a8@kernel.org>
In-Reply-To: <20260811-t9xx_driver_v1-v6-7-2c969fad57c6@compal.com>
References: <20260811-t9xx_driver_v1-v6-0-2c969fad57c6@compal.com>
	<20260811-t9xx_driver_v1-v6-7-2c969fad57c6@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 15:14:29 +0800 Jack Wu via B4 Relay wrote:
> Add MAINTAINERS entry for the MediaTek T9XX 5G WWAN modem device
> driver.


Please squash this into the first patch
