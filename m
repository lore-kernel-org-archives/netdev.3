Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE91E1C11;
	Fri, 20 Feb 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771623363; cv=none; b=ufDZRjwL09I2WWpMPuW0UOFJNT8xnuAft2dUltyZxdyHWh6XXvvjlUi44nGCrsCupyO6ASstiDbO3pSzllC5qCeO5e8ijhKC6aeVkHntoKuUjPX9bxQ0kYHUAiHZhfDVgcUOVoYdumcsE1wirI+k84nJzGon1S14iV0Cb3SjKYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771623363; c=relaxed/simple;
	bh=JSfjltoNLCOp9NvLJKkPYMeZvep2UYhMEiGdJ9XxE4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0mRZIH/YEskWkhSkZro80vrHXFNCnmDFfK6zivzbASszpU6VO2wg0/WcXwBHPZtTlwVquSaNRVxUXmhVTRKPmxE6tdOJOBwDkVDxoTvJOF7TO3aUzKW5NmUrU9TF66aWgdozj+LVbRyL+ebGmu56VSln91NAgDzhy3iKwNiJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwyXi2o2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwyXi2o2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD784C116C6;
	Fri, 20 Feb 2026 21:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771623363;
	bh=JSfjltoNLCOp9NvLJKkPYMeZvep2UYhMEiGdJ9XxE4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rwyXi2o20JBZJ9R/UFbCZT45anUW+Y7XnrW8HJiGBlL6nNRgYyyFmnpmQbWbxPqNI
	 4SKILtWEZGXXJjXZCnOXY46nw74Wx97mNP1jkR76E8M34YRfkft++rrNJ3S9+HGvsz
	 z1//57q4H+BrZP/KRNnz8t6oBxzy+J3l1JVMDx4PeQhDVySchQofzjpwoQ1ZSCaaVJ
	 1bdfijJmdincXviVpn4jl646iLMJjOoWEpwTW2ngYy2xj/ilieUx2jkjQZf4ujL6wm
	 btNDp8+ftsUErqKKUJebYt406xS8wwha2C0ylAnb0iFqVZGRlPQkcSkh8tMd39A0E2
	 AvYARV84qdhYg==
Date: Fri, 20 Feb 2026 13:36:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jeremy Cline
 <jeremy@jcline.org>, Ryosuke Yasuoka <ryasuoka@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: nci: Fix zero-length proprietary OIDs
Message-ID: <20260220133601.53b3b7fe@kernel.org>
In-Reply-To: <20260220112536.100017-1-ian.ray@gehealthcare.com>
References: <20260220112536.100017-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 13:25:35 +0200 Ian Ray wrote:
> Before:
> 
> -- >8 --  
> kernel: nci: nci_recv_frame: len 3
> -- >8 --  
> 
> After:
> 
> -- >8 --  
> kernel: nci: nci_recv_frame: len 3
> kernel: nci: nci_ntf_packet: NCI RX: MT=ntf, PBF=0, GID=0x1, OID=0x23, plen=0
> kernel: nci: nci_ntf_packet: unknown ntf opcode 0x123
> kernel: nfc nfc0: NFC: RF transmitter couldn't start. Bad power and/or configuration?
> -- >8 --  

FWIW the last message in "After" still doesn't sound particularly happy
so it may be worth explaining why this makes the device usable ;)
If there's more that needs to be fixed for the device in question to
work it'd be best to have all the necessary fixes in one series.

> [1] drivers/nfc/nxp-nci/core.c
> [2] NXP_NCI_RF_TXLDO_ERROR_NTF

