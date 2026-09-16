Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F83911D3;
	Wed, 16 Sep 2026 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521773; cv=none; b=ki9tlL0i0iKfpn1gu5M1xz7Z8ovPkuIgguc5WpA/FLTZBYJfbczNkN5d9bniv1twFIgfMeUMGonOGakEvzvfoMBMO5WyewRhwy8xU1FbEuXKdh851/+YcH+nrer+K55k2mlHHccxS8WlAMcJm00PjdeVtQRYZTI8k/Y4Ls6rtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521773; c=relaxed/simple;
	bh=mRxMonjcviK7H/X52PurqTDfQtiFcWIZbl6uILTVceg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsKfm1stzM7X3Cr3LymRAv6biel+0sChhgldFoclmF55/mte1yTx8LgWlXmCuKbq+4vxAY0X61wes8m0PX0lRKFjerdtSZCFZzqZpm17FrcHl1SYvy6V6oeagPgbqjME0O8ILvepBxG/cx7J/Gai0xRjdOrhZf6r2yncX86gs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW/FjU9U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW/FjU9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFD51F000FF;
	Wed, 16 Sep 2026 01:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521769;
	bh=mRxMonjcviK7H/X52PurqTDfQtiFcWIZbl6uILTVceg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FW/FjU9U+5cXE1INJEjIgoTBx2FRB19bshq3JslLg932k8bcJlWfedEiX9MhT+5VM
	 csc8u+Lpb/jxNO1glzlWIHmCABEKTSoc1RaEQCN/yEFRP2YEL5i0HTnTW6o0KAjRob
	 KZEaItufluVQ8x3mSTbJuN39nlJ7LuUEZJeABKuHdXil5Y2MABh0jXx2iHEbCvqPE8
	 mnBfMQrvR5jlzolf0qGkZXm8kJjcFpoFTDQRVkFzSDhwc/IBc4orV1BeZe3PzW2rjy
	 uf2g9euehCUsLXasZN80o+kU7EylKpUbO/kYFD3GlL08mkqwT1pt9eBk2Wr5oEs511
	 XioOAVYSnzCiQ==
Date: Tue, 15 Sep 2026 18:22:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: dsa: motorcomm: Add SerDes PCS
Message-ID: <20260915182248.0a08a3f5@kernel.org>
In-Reply-To: <20260909190541.466476-1-mmyangfl@gmail.com>
References: <20260909190541.466476-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 03:05:28 +0800 David Yang wrote:
> Support in-band negotiation of the SerDes ports.

Sounds like there will be a v2 to address the nit on patch 1
Please check the AI feedback:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909190541.466476-5-mmyangfl@gmail.com
I broke the emailing script on Friday, it ate its send queue :S
