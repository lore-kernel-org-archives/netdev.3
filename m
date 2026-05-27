Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB521770B;
	Wed, 27 May 2026 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847256; cv=none; b=ddz5O1tWIJ2qKnb/W1dltdy+XGG6yBcQBinZ1h9bwv9sq/B2CuEZT3PdTyF/jxaz84OUhc2WJ1GVUxxYAv8EOBKUWIrbeaThvL09Aba53zezqbN8Gg4iGR4Lngk83e1czuxa8EIBfPFrOW0Nfd0b5ofwQ9MzXocWQlHn9XxADOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847256; c=relaxed/simple;
	bh=fNPGm87JYOuRysvIxk0i4QUnV04al7jKYQRCCdmn7KM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRPCPN7PCuXTT8Vaomnc/YbS+zDLrnYBsZpI4Y6SPZJBUW/R8hsOWobexL0WyGABpxg5su9sspuvsE61+d8Ez8k5pzX0wb7u+s5RoKFvupEIdgg/07b9cenYeOegOpKTfIA64551mMn6bxVY4NCv1xqO7RlPR+rk5gg3R+btX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv0wbfZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv0wbfZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD271F000E9;
	Wed, 27 May 2026 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779847255;
	bh=fNPGm87JYOuRysvIxk0i4QUnV04al7jKYQRCCdmn7KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hv0wbfZgcl3743R5rr04LdFIlxkL+ZJLkSpK8SLXFjsBWn+mgz0CgXSoBK/0FPbzc
	 ASY2oS++EsJhUzr0pNhaD6MiYHOMNko1AbmTJXUWxgJdxEE160ifTr/fggRonsMaNq
	 e8BsUM2u3VyNrKTQ2MdqkNm2FthzQXNhhQIqRseCuJQtYGk8PCpiviAo5CoKdQR92q
	 IxEf+PsiSk8enj0hBOwa2KyawPzV79EODeJaRB0YZw05PmOE1+93od8OFy2El1crpW
	 tCVTSrC8A2gXaN4oYBFjGd6qOk2AUd81wItxEYUDVJVDRWcdbbonDDzhmikUOYYHju
	 xDO8N+PWRQuZw==
Date: Tue, 26 May 2026 19:00:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gustavold@gmail.com,
 asantostc@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 0/9] netconsole: stop charging every netpoll user for
 netconsole-only state
Message-ID: <20260526190053.619cc53d@kernel.org>
In-Reply-To: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 09:12:16 -0700 Breno Leitao wrote:
> struct netpoll is shared by every netpoll consumer in the tree:
> bonding, bridge, team, vlan, macvlan, dsa and netconsole. The non-
> netconsole users only need a per-port handle that lets them transmit
> SKBs.

Are any of the Sashiko reports real?
At least one seems legit (parallel device and target removal).
If yes we should probably try to fix them before we shuffle the code
around?
