Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6835CBCB;
	Wed, 17 Jun 2026 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729650; cv=none; b=ga2Qk4jQTNOdt2X1s8zCmobd0qXblnYAzWAN1dM6ha3DSj5xKpZjn9YCdRbkH/btXDWQT07H+htRvfjXgrK3nYUsvrDc6Oty5KfHKc+dUukLBXYAyYpcv+kXz9QSLo3Whf9grmt0PgmiLQcqQoI4Jt8amhaPk0aVayMQgxBnxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729650; c=relaxed/simple;
	bh=Xgdk1TChEBhiU6wHakx3KuSeVSRenMLj/qJLY5mNXwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwFdXO1t7c5YyTzQAd1NmAB2m+/UIddgKHBkmLq5L5hFdHc9eVyLTLthS3QlVapGerFW+zYHRQvy4Cx00yPL7YWQD89N8tKUvF5p+4m27B88sICsp8Y+xyCOv5/p9HfpZJDE1w/i6a8pdkmIagboZ7qEPQr8WTbezVqStiDULpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djxb4RDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djxb4RDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412D51F000E9;
	Wed, 17 Jun 2026 20:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729648;
	bh=yI7oWojBBWCFZtT5GkeyArJgGoTs0Iz+VhD0IZ6tAKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=djxb4RDrAOu/bmeS3G3q6kZTONzLdub/v3XZ89XiXHCBOzxwATOUPjT4qECXrAI56
	 Ya1wiMu1Vt7fRvp1K/PlEeoJW1cTkZ71S5HdpYAx15KXUR0wKbzrkM9YfDXY/vEKcR
	 4AZt7u/WdJM0zPEdE5zAfudRpdKVDyVXtZrKfC4fnuChVldPp0ofY14Rcw5RDX6zKf
	 VIytAwUMoq7mEu0S+DEZ5CbUZnB7xqJ0xmWUQcFKBRakMEmPiWEf8bR5kePKfS8qXo
	 ISTz3SYznNKs02+YwNdn/8JIvoBF0UhKDOTuMQCZyY/aitBGP1bW3is3i1EKkc5za3
	 H7KFZf93vQC3w==
Date: Wed, 17 Jun 2026 13:54:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <keguang.zhang@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 <linux-mips@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: loongson1: Use dev_err_probe()
Message-ID: <20260617135407.6ff54e27@kernel.org>
In-Reply-To: <31630db0-85cb-421b-8ebe-bbae07521533@intel.com>
References: <20260615-dwmac-loongson1-v1-1-cbcf5bc01d9b@gmail.com>
	<31630db0-85cb-421b-8ebe-bbae07521533@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 16:42:18 -0700 Jacob Keller wrote:
> I'd probably also argue this may go against the desired goals of
> net-next with only wanting such cleanups when in the context of other
> larger work. Of course that decision ultimately belongs to the maintainers.

Yes, feeding const EINVAL into dev_err_probe() is pretty pointless
so if this helps it's just by "saving" 2 LoC. I'm not sure it's worth
it even in context of larger work, let along by itself.
-- 
pw-bot: reject
