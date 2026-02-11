Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C72B665
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837386; cv=none; b=UGuuCX6RS1QnuD+xSG92wQtw6emIwC7L8kteun6s2cj1eP+aqZ5d7IUs6eVJT+/866Kf4QBLa/mcoAIYgKvqnFRkP2PFHW2aEWOxUqlcH24lJPIH7Uzp9GRooQQBIry0T9S+NAft3wV3b38SHtRbVmV2DAnirR2Crn8BJjRKy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837386; c=relaxed/simple;
	bh=5fC2CJdkzF+vtl8B0WGN8aSl56I0h0qXLCkEIFNNYSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDSUqgTRsGF0HeYDHXCL6gvR56/DlyCN6Sh6eczdGhbMW3SVD02DsOaTk68Tdnqg09bZyWgB0HAapmtbMEsBITGlpj7/wtEXjfCWoSCU5eCspHyk1oAE0TViGiEdrEUCOH/q91tNTvazMH1PSk19ICy7Ie4Qa8LCDKmBGiiE+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFDG0L7E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFDG0L7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEABC4CEF7;
	Wed, 11 Feb 2026 19:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770837385;
	bh=5fC2CJdkzF+vtl8B0WGN8aSl56I0h0qXLCkEIFNNYSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QFDG0L7EW64L5hbBtZ0k4ChUmAq6lmtI8Dqvo6/2kWAqIp8z072m5QIYqkEmxQI92
	 6Mp3tC9qT1L+WSZ0wIidqvYUh2WcbQ6Ma8tvC0yCDcWelCjGvFmm7pG3lSVS4rWgvY
	 Kva0SdIFIH3fjZkKYpoeTfIEr2Kq0dSnVsXR02Yf7Aksurb+IDVSQ8kTC04EerWeqK
	 aQ+AGQdW6K+mcwEoCESURajTSvc6VMOONZ/SCU6dXMZDNek5eS6fVLP0vIDQXV5HdF
	 58RC0H1Ov4b3SEFjBUrSUafLDRqTEigNW3xb0zCFriBxGmS+Zn+Gw1TQLK1E+/xyAb
	 vpAop2ckm3VzQ==
Date: Wed, 11 Feb 2026 11:16:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, justin.iurman@uliege.be,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v7 00/10] ipv6: Address ext hdr DoS
 vulnerabilities
Message-ID: <20260211111624.54cca578@kernel.org>
In-Reply-To: <CALx6S3576DLyd18BnFRkaNMhxb-Y3bsy8YJXy3-Q43EQVppEDQ@mail.gmail.com>
References: <20260204225154.58245-1-tom@herbertland.com>
	<20260205184512.306ec46b@kernel.org>
	<CALx6S3576DLyd18BnFRkaNMhxb-Y3bsy8YJXy3-Q43EQVppEDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 13:46:27 -0800 Tom Herbert wrote:
> I resent it. If you would like me to resend the series let me know.

Looks like patchwork did not merge it with the previous posting of 
the 9 patches. I'm afraid you'll have to wait until Feb 23rd and
do a full repost (net-next is closed now).
