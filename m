Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B33B8956
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723098; cv=none; b=YfOLS/du7fpRmDUYbIiIw9m7BnwoQqKSiKglSk2dRaNongMT4Dot0yFz6JVdxAIgK68UDm6X04D9frDvtvdAlKjDZu0h+BtA9ah96WqfZgeNQ5HVEjeUuqcL0Dm9w/KGkYiKYQUug667XJ+GupODWLnojvFnOxvOxm3IE9w8JWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723098; c=relaxed/simple;
	bh=74iaf1dmS6OGwNXg3PQN1/EndfQe6Kel3XepmWjKFLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOvARx2kuF5DW8hyzahdDfL4FQFY5oM9gvoKshsZBLUjdedWGuu7ZonKAoQMDqFzTss6ygCb33AP2WZ42w68zTxeQ8FYs6yRRboKC6zqda6vZt+5FwUzHmPSZKd23IYE2auMwTAlTD8DQZ0x/mIFCCftI2NUNhvWQbsQa8HrArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsMaib02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsMaib02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D04C2BC9E;
	Thu,  5 Mar 2026 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772723098;
	bh=74iaf1dmS6OGwNXg3PQN1/EndfQe6Kel3XepmWjKFLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RsMaib02+grLCpw4oDMSHvzSH/93r3yf4tfOp6AxeglCXNTShUlAFHyg6oBMUkLu2
	 Gq7jsIigrvstE9f4mwdgGn0k/7kZU7byyWkPPvPrBsQkh508AAmuVpU8oYsAZ//Ivb
	 6J5BhPVLdvAeIo0muePDMNHZlFqKidbG0Uiv08wi/AVGRV8NKmuFvlqYeQ1QXOYzG/
	 uRmX05DC6N5skjquegmrFUiSVcLrAgS9p3XUrXDg8ttm9MoIvJarnYHke3pxV2xuTa
	 XD628dB9lT3bEgEpyuKHaW5rwDvAPE/oAWO31K4HgK23+frYiPAJ5Cv0hhh5b1p5X+
	 oTL+BXnb3eluQ==
Date: Thu, 5 Mar 2026 07:04:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ralf Lici
 <ralf@mandelbit.com>
Subject: Re: [PATCH net-next] tools: ynl: add uns-admin-perm to genetlink
Message-ID: <20260305070457.6b032e92@kernel.org>
In-Reply-To: <m2qzpyik31.fsf@gmail.com>
References: <20260304141020.23270-1-antonio@openvpn.net>
	<m2qzpyik31.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Mar 2026 11:36:50 +0000 Donald Hunter wrote:
> Though I see that genetlink-c is not actually referenced by any specs
> today so maybe we don't need it. I defer to Jakub for guidance.

I think it came up in the past, I'm fine with deleting it.
