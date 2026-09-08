Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82B3CC337
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880710; cv=none; b=K3ocvY+cBQgk4xG+d+NxDTMc7RZDQb7v1BBdA0UlGNL3DYMGquMmG7DB7/8picuxIxzhd1uEj1EHBSWzd7YtcreHyHf4/TT+5VLoh3AR2gXhmPpsOoTvttGf6cHpNXA13qlfeOpBoK07EF/OEy+IQdb/TOnqX4tYxwSrPiyAEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880710; c=relaxed/simple;
	bh=AN+a+kYp6jBISAgGfUnagMa8xe4a3N6zMwCVIdeKd/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tk/5q9WiPwkgtPgibqNN3h6wezRNOzZKWI0er2Yz94TCbXxitjARpSrvbd5ZO3rapGsgrUNlUvqbF9/dWpfbmy9/0EBqBnz9x4d80P3ZuqXuJnZskECC00s0GixN3/e2LAPdAi91j1J8fEPAKlOgRpb2bfuKJ9wAHPw1h4JBNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EzbhBRx9; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EzbhBRx9"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x3xa4-00F5p0-84; Tue, 08 Sep 2026 17:17:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=AN+a+kYp6jBISAgGfUnagMa8xe4a3N6zMwCVIdeKd/o=; b=EzbhBRx94csRsvKR9DaG+hjI+q
	sPuoqH9+SbyERvR9QTCS/PLO85ARmc66v804E5FtG8g9Oikj86zB+/KdK5H+DHpc/XxinrCYNXY1+
	L3ZGuvrDL1fxvcZN+J/H37bPwB/dCuDyAchn+3Kfc4DWA8lCoU1is+4QWBm/ujuLpU25bChPjsv+P
	2XaEYpfl1I8onemIjXXaO6j8LY9igj7o7y4n5eJ64D1dXcroZH7yb2oo5hZeE6HU2c1s68lJntO8y
	k9n8ekwBnhcGBQ8Ddqx0hzMKk7Qd1zicJMGgXtgDLU9W0XZQq9kEn68bM9vOHfRwSdeSdG8PKpHw7
	H64X+W1g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x3xZy-0008Gc-3F; Tue, 08 Sep 2026 17:17:46 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x3xZe-00EdyY-2i;
	Tue, 08 Sep 2026 17:17:26 +0200
Message-ID: <4ee9a2ec-c16c-4f1a-ba81-2dcc47c1c3cb@rbox.co>
Date: Tue, 8 Sep 2026 17:17:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: do not reset a socket in connect() once it has
 connected
To: Hyunwoo Kim <imv4bel@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, leonardi@redhat.com,
 bobbyeshleman@meta.com, stefanha@redhat.com, mst@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <anzT1fREOSyHT99k@v4bel>
 <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co> <an5zJ9Uf94_L9TyB@v4bel>
 <c11d6fe8-fdf9-4b45-b291-e5d5b0ef5cb4@rbox.co>
 <aoVnp0w9jlyFDPj7@sgarzare-redhat> <ap8EBx3pkSr5Csy1@v4bel>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <ap8EBx3pkSr5Csy1@v4bel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/26 20:35, Hyunwoo Kim wrote:
> Gentle ping. I'd appreciate an update on where this stands.
Thanks for poking me. I'll post a patch today or tomorrow.

Apologies for the delay,
Michal

