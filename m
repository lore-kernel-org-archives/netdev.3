Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE435BDC2
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 03:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775101112; cv=none; b=DmRFs78DimwQwGhOUATSGZ5WgPLjvT+MXOwEiKohbMEAvu9lgKRpyQieJptHrQs45cEVp9UzeWkp6A5b5APAtMDymEomhFCSscxmVUI2CFET+j96Zj1aOynXV3tqavi3tlvCGQKxjdKAyFtWe5uYWckosFh38xHpYmccNKMYwNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775101112; c=relaxed/simple;
	bh=qA6Kj6cpqoYOeftKcYWa1GmiN7Rpj/QlEG7d87PZIZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHrulObLv0ChJqtZJnQKN3DVHf6xEuj8ZEh8Vl1IbPL8CtH5f86X4eRBhi2G9edYnQ8QjEr5fjvPuQs8nmzxl+laZfpZMyVyrXi0hrA76DKsmquSIZzlFrr05k4Npp+cPZPOWlzBN4Q39sjKh5LlsmJBhtQ1u8trBm682NdLL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0KhfqL5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0KhfqL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C46C19423;
	Thu,  2 Apr 2026 03:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775101112;
	bh=qA6Kj6cpqoYOeftKcYWa1GmiN7Rpj/QlEG7d87PZIZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b0KhfqL5sVlme9AbzX9/6LZMtGjjQ5wj8Z9nCn9jyHYbqYjckBSzdfLBLMeab2pGR
	 c7jz6rOti6wcifeGqpiFpNaxdSMbRT57Dp4hUZwSZEpCQkgo2CE9KLAP/trUa34qf7
	 EBFfPQW5iqoi+ZUFUWO7hecSSlJA5IFk/isPci5tl7suRULaNEeeGjsKDolgefigYp
	 VXF+U452TQbmAdRvwkHf6q3kcFVUT6RNfPURfe+XEoxfZ4TEEfezXdVpvei1ENbwm1
	 msm9rFXeAy+uDS7Y1nMexLOvzHLagAPx/CWpvLwnVv0bdGMzf2WlYhDNjXClHh+Qwd
	 ZiFSNxHRs3/eA==
Date: Wed, 1 Apr 2026 20:38:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v4 00/14] net: sleepable ndo_set_rx_mode
Message-ID: <20260401203831.6deee0e4@kernel.org>
In-Reply-To: <20260401011914.1716692-1-sdf@fomichev.me>
References: <20260401011914.1716692-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 18:19:00 -0700 Stanislav Fomichev wrote:
> sleepable ndo_set_rx_mode

Appears not to be "buildable" on 32bit x86 tho..
-- 
pw-bot: cr
