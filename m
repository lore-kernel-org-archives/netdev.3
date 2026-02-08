Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2022F01
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770594008; cv=none; b=lQIrfvUkhmoBhbh3oyq+TvDrBdRX14caer5YuwkcIajJ+GdksE7bjv/T56H7np5pg98pXHOOADJ+eOMlZDkOEeo7J3XwFqtHPDulHqSf2p7wFYHe5zLQTkSea2Q9ngKeljL106vG4hEQKXLf3rmkZwoGAco5a9d38ITewucUboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770594008; c=relaxed/simple;
	bh=S7qfvOSQK6+qtTNRAe3QOmf9EVsW3cgX393EindT56s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=CX85vfVKCRUiO8rGwWtxT49v4OKvVFpps7xny4zdegiGGgDKpqcH1IaKaE4Z3f32IIp7tY2Vxs+CaRNo0hpFRZc7QJ6+ztCLfaFxkE3eCz5yl8fOfStmZz8AdTBl1+Sck35c4hCL6W1tJkAg1qq+pZGdOn9QioQFzJXuzM7Hv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co20ukt+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co20ukt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE74C4CEF7
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770594008;
	bh=S7qfvOSQK6+qtTNRAe3QOmf9EVsW3cgX393EindT56s=;
	h=Date:From:To:Subject:From;
	b=co20ukt+bvJUYWic/Q+pu5FlG89SBq5cC+24Vqbucf8AIsLtfyUsgTNmNkCRGuAek
	 toA1nOwXIN6p868g73Ivo555lrbdpjRPV107md/wrAAeCuc5V3iHAJAHLlvN6dRhdX
	 gQifW5AcTN8kwg6ted93qr9qvrZL+0t+N5fdJ3CKzCPDSD3IoQADnetseRhaXgc060
	 XlVonB74yXzigSB+/1IekUnc3/vnsTEYbSAWlZHpbgbmvymrJoYpsXtVGw0ML0vj1U
	 F/JZaiQIMcNMV6dfiN6hKgjzZDffey4MI53oEWGHNaX1Q1q49JVOpDS4nOQ/2pZ4QL
	 tOtpv4ZqijNVg==
Date: Sun, 8 Feb 2026 15:40:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20260208154007.5edc2bf3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged final v6.19 so net-next is closed. We will look thru
what's one the list, but new net-next postings have to wait until
Feb 23rd.
