Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FF264A9D
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597871; cv=none; b=IqOSJk1nMEJEaePj1ibpzazBREEua1J1+0N9QW16HqaoNVpmYqPq7kOq1LfOEGmKWlFqMXaf9thbuzl5HDKVDB2/0fC9VevA3cJjXwCZbC/ZW9YtJ13MmRCjCrzF4fTRuO0+nalzTcqRtlsxlQDBsdGX0h9azKEvYxsKJK4Lapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597871; c=relaxed/simple;
	bh=iH/p+QtR2LkX7EPSpsttq7TDnYDbp0jfIyCaRYZNvX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/mfP5VLIGpLm6eSyopeGFtUKKWpHV6ZadDSD8pywAoKbgJImHrtFn3xq5eJsu3zhM3USwnAOb4GO6P9Swx6Lb1fPrnDBRsnjrwcNgk14CiiOJ31tb03hCfUeqZn/pMdlD4xeXRnJek9n6NUmiL/H9HwG9ncbOS9mrKephEDUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjs1zysK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjs1zysK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B61C2BCB3;
	Fri,  1 May 2026 01:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777597871;
	bh=iH/p+QtR2LkX7EPSpsttq7TDnYDbp0jfIyCaRYZNvX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjs1zysKsB5u7Ub6LZJvdV9NON1tf33hwhMQ7GdozOwBN+QXknDE1Wwy9vbibNOOs
	 t/xyBX7jJmN0uGNNj4oscsFZb+JVUp4ZSDf2tsDmxtPinpCoakaV2W9rlh/5AigPby
	 L3Oumpzq5ZSiZo0//SAWrAV17vh+udSPf7Tsjr+Ywt6FYKKT/vEtzbdcLqtPAIcz+t
	 xcXXKPCI5eaAhxpT22ulz8aJH88a/xuZlRqjQvX7J2q/WKM46Rj7HEbpa55FbmKAmd
	 FA+Ha2MjzPe3gzRpQo7ihrFSSwvGUdjCHxsjbtFQ2jgO/YwoazmJuPsYaJU0W74q/w
	 UGw1BRjVAjKNg==
Date: Thu, 30 Apr 2026 18:11:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: airoha: Introduce
 airoha_fe_get()/airoha_qdma_get() register read helpers
Message-ID: <20260430181109.68c65940@kernel.org>
In-Reply-To: <20260429-airoha_fe_get-airoha_qdma_get-v2-1-909e791f1dc0@kernel.org>
References: <20260429-airoha_fe_get-airoha_qdma_get-v2-1-909e791f1dc0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 12:54:32 +0200 Lorenzo Bianconi wrote:
> Add airoha_fe_get() and airoha_qdma_get() as utility routines for reading
> a masked field from a specified register.
> This is a non-functional refactor, no logical changes are introduced to
> the existing codebase.

Doesn't apply AFAICT.
If this is because of the net -> net-next merge - please avoid posting
patches which will cause a conflict on merge.
