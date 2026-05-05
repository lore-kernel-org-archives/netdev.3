Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5DD2744F;
	Tue,  5 May 2026 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939858; cv=none; b=WwJAgZYhsznWfQ0pkh6X1dPlraITq+OQ9Yx0FKCcW9Fk+Z2/OqL9KR7GPb46R7kGj7AHfhB8AARIBPehSbB0Ui4PES6kYx8KNyI312BS/xkl9wwjZaV06+d2jPpF7pru+QNXPjQHvvVWoMFLkOTWBPxDu4OARmqcbbRrFIILe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939858; c=relaxed/simple;
	bh=/ylHvhECoQmKS/mVvR8TDKSZanF19cxrk2pYpMeYbKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOae62Eays+ceSpB34C2ctuUHtChEYgfpenYzVC7V9bBJOOkDz17MqP93JA/mNkUmLB4KLBjv7RY6Nq3zBiEWif6+fjYwi4Mir9YNuYvUbubgaVP0RSeL2w4/XwAkZOPF6kYNlvBZFAt4fMb3OsVr8Ou54+svLSSyh3yCvtZbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tB+Kd711; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tB+Kd711"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF437C2BCB8;
	Tue,  5 May 2026 00:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777939858;
	bh=/ylHvhECoQmKS/mVvR8TDKSZanF19cxrk2pYpMeYbKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tB+Kd711ScTkE9PbrY/UmMfbYhujRX8TBUgK8prEwdxpxPDvI6knQjFVzENFXDpwJ
	 vQDBYu1BE7R846ogETFlpaktEUBPPUK0vIhWY68nK9at3le9TJw+sIQdMIaiD4d8sl
	 g9QXfuH71HKKXTo8/diK9BrsLNsH5p4435N7NvyfW0qt6tB65EtvjaY1KgDJV2RfTq
	 t34QJD3Le2d7seygeEHdUvest3OTcXySrDDpVVs1itSu2aUYT90WyVCl1qIWhu+7Ak
	 d+TwOIVyj65rXS0wskPIgO8LTKd3lqmhN7RojU3qc1tZNNmPO75YHvWt36bbOnB7Ds
	 xt4u89+qqhaLQ==
Date: Mon, 4 May 2026 17:10:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <marek.lindner@mailbox.org>, Simon Wunderlich
 <sw@simonwunderlich.de>, Antonio Quartulli <antonio@mandelbit.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie
 <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu
 <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>, Ruide Cao
 <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>, Yifan Wu
 <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>, stable@kernel.org
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Message-ID: <20260504171051.2b3e47ef@kernel.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 03 May 2026 14:22:33 +0200 Sven Eckelmann wrote:
> While reviewing the fixes submitted to batman-adv in the recent weeks,
> further problems in similar or adjecent code was identified. This was either
> noticed in the manual review or reported by sashiko.dev.

Are you CCing netdev to get this reviewed by Sashiko?
Please don't..
We delegate code to sub-sub-systems to lower the patch volume :(
