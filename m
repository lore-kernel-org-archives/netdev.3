Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1244BC91;
	Mon, 21 Sep 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023181; cv=none; b=ct77YMaPfuGuV/tUkdNySTic5U57uQq+wxuR0czO3jhDmy2CEceOoqP+Ugh9TJAioOckDXAEULPuS+uCqKzSx+Dbw630O16pw+wSdIkGB9e7wBEPmOakXZ6OUt7krwlQXwB81HhGw9r/2B6Ne9N1+X2+l4SwVGuFH5a9VuIvvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023181; c=relaxed/simple;
	bh=/4Gqlt90VL1TypVBsowbQodJE76B3pcG0Ed3lf3e5UU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dq5t9LxYqzyeAwlQZdzj/zg5uLJD0dkCRrIaM9CgJQDb7MUuLwqVXJczgmErPKaBcjzckUtDzYp+T+pvVCCgVipnbt2Ailrsqepr31zihDCdqH51dygUp5g2TLCN4ZS91sk4pngz9lWvd5BIHESwrCDSYAN3YhvWyxV2AhkcXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5bqOBoi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5bqOBoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BB51F000FF;
	Mon, 21 Sep 2026 20:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023180;
	bh=dittuI7Jo/Uhew1jMl8JLGUl5/koRCSwkzAOXH6YsVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A5bqOBoiV0iFung/gNNn0OXJDT+OpJ947kSAPW5YwL8UXBtg8U4WVecDtbGOGnc7E
	 /7JzcmUTugW+5QTLMxMF1k0E/WZHataiZXGeNHsMsOvmyFnr9VAUXaRWg/rQmjbC2E
	 +ihBhIxYm/QOL3Y8ncEoR/fwW8PgX5cEBygEimw+qdtwP30Da3y3ZWTEbiC9DI2WIy
	 rlkZLG7Ojv3nQQIKjw1aNhSwCYEWwzyR7B9zSmxDjrlg1xJbwSCodFfzN0G7v0GT2B
	 mso2UPRTM0H3JrPnkfhvxP6m1HxGY2pasFARkMF0tRYfleF/9NLDsT4pXjgPmzH0tG
	 TRl9HgxOO77qA==
Date: Mon, 21 Sep 2026 13:39:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Add Agilex5 SoCDK TSN Config2 board support
Message-ID: <20260921133938.003a5a19@kernel.org>
In-Reply-To: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 00:05:53 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> Subject: [PATCH v6 0/4] Add Agilex5 SoCDK TSN Config2 board support

This is about to drop out of patchwork, and we need acks.
Please repost just patches 3,4 as a separate series for networking
(if the series is still relevant of course).
