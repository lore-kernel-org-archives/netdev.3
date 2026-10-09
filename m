Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44E33DEE6;
	Fri,  9 Oct 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511207; cv=none; b=EXS4ndESptkXVm57wETzAjE7bWglFEFMPxVbvGapguJmwC5+wB2ZpsJaKppe0QaCuci6/ComP4UzXWfEGR33Rn6AQ40gVpine41LFPT9grcybMXz5B5EI2tnnhC4xxO3TZYY1TvZFOBw+woT5ZQsfIfkYLx3VNPfDZF1CNbpmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511207; c=relaxed/simple;
	bh=R2m3QZ6hkoY0NHVl7KQDVBxqdMytc7MYQ6OIRnTfglA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ln1ljpwO9MobkfuMUg0fduSdgnB8xEDoyuP1KIkx6irZgJFoM4xWQZJfRWLQzIfhtqbGfUphxsxf66c4B2or5iGn6ihlWnsss0PogasZcuz3AJkah3EDeATdjupxSXZzFnERp0VTZI9aCsM/eJ5sa8oghWve+f1NIOQlBlB/mcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNeB+ufj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNeB+ufj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E01F000FF;
	Fri,  9 Oct 2026 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791511206;
	bh=ZBdnt0dr5Vo0ey6jKlPaKDv7WXk3zlN1BpBABNQDneY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VNeB+ufjqu8/B4RkQDR1PL2l0P422ITe7F5Bq25xae5GnkHdR78Dimy3N9Qly9CXU
	 rQgI0aIPMzMljuJAnNTw+FhUwQ8kEWhWKM41S2TuDPc3hkQF4cavrycJW1Bf9zhiZf
	 OX0r9AQF/upR0Dbkro5sndnR+rspofZCeRnSGns+KT7uTlfIUtFxAgsMikakUesPxN
	 K9MwNkLnIHw0iqu3pOLy4NvwEOMHilPaEJ1bjfSuHMMVPKhcgml4+9IIefgaKEYAIO
	 QxIEOw+1r1M/eYjSdRMO4dRb98intx7CghuxRsvws42xwPdYV7HmGQU/YCHiN7A+Q9
	 BZTpA6JgFgT9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1431380AA63;
	Fri,  9 Oct 2026 02:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: oa-tc6-framework: Fix typo in SYNC bit
 description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179151120478.517180.17431403278807567875.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 02:00:04 +0000
References: <20261005194135.64584-1-jayarajdmit@gmail.com>
In-Reply-To: <20261005194135.64584-1-jayarajdmit@gmail.com>
To: Jayaraj Devaraj <jayarajdmit@gmail.com>
Cc: parthiban.veerasooran@microchip.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, kuba@kernel.org, corbet@lwn.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Oct 2026 01:11:35 +0530 you wrote:
> Fix a missing space in the SYNC bit
> description: "bitin" should
> be "bit in".
> 
> Signed-off-by: Jayaraj Devaraj <jayarajdmit@gmail.com>
> ---
>  Documentation/networking/oa-tc6-framework.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] docs: oa-tc6-framework: Fix typo in SYNC bit description
    https://git.kernel.org/netdev/net-next/c/758fe10f83a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


