Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F929A2
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327943; cv=none; b=Stf7FGM4erBsPUEXtmXdjPCTXamhB9baBOh4ypbA6/D/goUu4pC38WGj+Aopzy9wqa0RLMan5VwdUQQLX1b9JbxRWTvX0ND1iwygXL55G328N/ug8/fBwM4J1cNvO8N2KWxK/6EspAhx5JSqoRnSZol6epGrtgXsDf+38oaKFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327943; c=relaxed/simple;
	bh=94p9HcHmzvwsEu6ZPRC9z2qylyGtm8OPSYzrVcMilLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oe8PkqXO0Qo9NumMwlNAHOh70d5oXVc8hf7gmDxRhnjWjl+mXzTSPefqtcviHESU3JCkiSgnaiPd+OsLQjvZdBjQ6HZMY6z9ev9MvsBPiKakzQzUSD0SpJ++zdT/ahaZv97Bkgxufci1BCstrRkl5nHz8Zvsw/5mj9bgRIvuW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwyojebg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwyojebg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75510C4CEF0;
	Sat, 20 Sep 2025 00:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327942;
	bh=94p9HcHmzvwsEu6ZPRC9z2qylyGtm8OPSYzrVcMilLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fwyojebgLJ9vtMqM/Hm0+ONJfAUyQqCfeofU9svvvhX1KLI8/5YgbI+2S7+Apbqf+
	 SuPw1mkqP2Y0UcyLIaW40koS1TXEt2vmATmQPtZIKV9VnSy9FbIoDorRPM+CWMbnA4
	 5YjhViBAxr8ZEBPtzuBlH494otmbsq/B6+GLklS1/FOs9SldJwV4fz+vaxxZ8eMztl
	 7ZC5iMuWBajN54kVOdn4N7B1ObZlMYA9azfTMQlv7XO0AW1pYj+uYmQ2+pVwPHRQW7
	 +grgt3QUnBx62DQUbr2sIPJO9ur1fOZDckK+31hgKqf4JaGtrFvy67QFJVHZ5uJNSe
	 LTw5kRSIR5P/g==
Date: Fri, 19 Sep 2025 17:25:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alasdair McWilliam <alasdair@mcwilliam.dev>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v2 2/2] rtnetlink: specs: Add {head,tail}room
 to rt-link.yaml
Message-ID: <20250919172541.488c461d@kernel.org>
In-Reply-To: <20250917095543.14039-2-alasdair@mcwilliam.dev>
References: <20250917095543.14039-1-alasdair@mcwilliam.dev>
	<20250917095543.14039-2-alasdair@mcwilliam.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 10:55:43 +0100 Alasdair McWilliam wrote:
> Add {head,tail}room attributes to rt-link.yaml spec file.

Not sure this makes sense as a separate commit.

Squashed and applied, thanks!
