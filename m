Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2712C3245;
	Mon, 17 Aug 2026 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006402; cv=none; b=n9P5xN8rm+dOOGUSXAvtoEogzlCKEx/uYju6LvnqiqHuutngG3LJ2vqC8YKrYbHbFLYGM3+sCSucm6YVderg+AlyQo5dSWyPIV6khVlVde4yLMttWDXQ6jSspHxkRyOIYN0AzcyhgU+MrWFr9qOkqcyVIiSFcTK4euGMpHuOEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006402; c=relaxed/simple;
	bh=aGCSbjh7LNGpQK69ZJzYWk2DP5P1ztKGbqp3mV+u1uE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ulsmdbae9VfXNnDwdr5DqJ3OFY11YZjxv4ZnxYZVegQcDxZ+FQZgeLye7P1UyaQlY2QwBRUc+TO98qiyp5vo2veMuAyTnGJCkVQFPskrNpgioTRIUvQ9JbvevTRm3s8Gdy87rWm1zeTgVsg+pgbt09gQ9SgaCQOGfvvzCUR/JHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQHiLBMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQHiLBMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9C41F000E9;
	Mon, 17 Aug 2026 22:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006400;
	bh=udONfB0KqPlNsNyooEvhiKK+MK28bo75R+x50okB03I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VQHiLBMFGQCgeoew6Cp4Ows756OkMTcKte3toNPglY/bGSasnVZuHKMz8eXnxbElh
	 jsBGBwsL3xfxOTdgVVpOTDDU2C70vLO5VTYBveLAOTn8yG/FNoeanEwmfEDd0peSw8
	 7CsCsSF0+XSukhQmxxssL1Sly8Ixga9t1wvzsXXwhuj3kGtIpCuHEdMypW4KOpaBaX
	 XAu0FMlO4QQkI3hO6viDTnZPCS6YhpoVyK82jTwb1uLmVC8SwU5WWXN0ITiBkwvwJZ
	 aKpy5RJNdPbI9ZbvayusP0l7sPqUN6YOJqvwCcAU6D8YF54bDafqh6+DiNPEfsiJJY
	 Ip1r2Gyhdzlcw==
Date: Mon, 17 Aug 2026 15:39:58 -0700
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
Subject: Re: [PATCH v6 0/7] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
Message-ID: <20260817153958.4b120ce9@kernel.org>
In-Reply-To: <20260811-t9xx_driver_v1-v6-0-2c969fad57c6@compal.com>
References: <20260811-t9xx_driver_v1-v6-0-2c969fad57c6@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 15:14:22 +0800 Jack Wu via B4 Relay wrote:
> * Core logic - Contains the core logic to keep the
>    device working. It includes:
> 
>    * FSM (Finite State Machine) - Monitors the state
>      of the device, and notifies each module when the
>      state changes.

This FSM exists in the driver, even tho you call it "core logic".
Please provide more details in the patch description of patch 5
and consider whether any of this logic should live in the WWAN
framework.
