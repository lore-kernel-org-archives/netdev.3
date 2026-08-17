Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77F3E2740
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008939; cv=none; b=RYP2hCfdcyFPB0XpLI8J+HrHuJVX89Pi43Dd7cdsLnipH3cpPQeypHs//OS7X6XsvstwF2/0hSh7rKeZao7nveSrlh+bofyFjVdWhZO6/o3C2qt/ca/6DRWykpJu11h/ZUH4UVUrQe4nYdCGVvJGj95ZsODyOzw8HBklERcrA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008939; c=relaxed/simple;
	bh=eQOAVK/n/gL1OXSALRDiw2VfeOAyYOEGm/ss5U2e06g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARXZ4hPgn+MhySE6F8FS2AMP1UvQW4JgFXYLCTPtoJl/mf9VacP954XE4Gq5wvS5FcpGx20uphm5jI8OWUTYyi276Zk5T+40ccWt+tZX1K9j1q1CWMqdLSibLrRurae3WkoBnFfgop4cbXfnSiQTJUss124hHC+L3h09b6y72Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLg30VM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLg30VM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70001F000E9;
	Mon, 17 Aug 2026 23:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008938;
	bh=23KsDQGvL0xdayvXWAtvgwIBvLSkjxaB/bQsp+Kj87E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hLg30VM8nxSl4z/R7c2wLG2JPcz0vzYTQmQ+MF1fryn+5aM1LDbS6BXiXcBllj+jj
	 vc4paW0hZNVaDkg9YAt5DJICUPrjoQEs+qK/XU8tg2+bv+8NRiHX2NgFjPONzDdwFE
	 06UDakOBP8Ip0hG+p8sQgX4Ke72JB8Sk+RebLS/INJjF38CuSdUfJjf77MTZeCDJ0f
	 o92nkRZG+ihGO1TfPkCg36WRpqAQ7E4oEcuVx6yvm/n3PkJQhyuOgXGMGKMFBWNIJb
	 NsEqPYc0RELeSVrK3ysbU0eVdyGXVWybG+QxBlC6Vyrr/YPzkx06TDuXWqBDa8o+7d
	 d3ptMo5eD4zrQ==
Date: Mon, 17 Aug 2026 16:22:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, Andy
 Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next] bnxt_en: Add missing NETIF_F_TSO_ECN feature
 flag
Message-ID: <20260817162216.41216bee@kernel.org>
In-Reply-To: <20260814215655.2331655-1-michael.chan@broadcom.com>
References: <20260814215655.2331655-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 14:56:55 -0700 Michael Chan wrote:
> All bnxt devices support TSO packets with RFC 3168 ECN flags set.  The
> CWR flag is replicated only on the first segment.

Applied, thanks!
-- 
pw-bot: accept
