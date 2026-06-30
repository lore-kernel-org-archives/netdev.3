Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F621E098;
	Tue, 30 Jun 2026 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785756; cv=none; b=K20mKficjrtMZjEv8GHCEQz0gQS02OY+rAV9hQR24SU44ZyDvpQN4BzeN42meFhXgy5mLQ4f0BpR/uam/ROS+s8sAtPJ90fy7AaAum1s51cRL296AhuAVZRL542TbH2IMlCPYX2i0J+S5i0rWO9bgi+dbawjc4SlhnOY3wNaqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785756; c=relaxed/simple;
	bh=m+MxjZF7DIYbp1NRXgJX0dvCxIvrked17cofwHG1bv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bus9FrrhDOrM5tvE+SpLA1mRuBYUAZ6YSVKAPpZUU9rMst5fLMvGtZlvsIxYz6m/i0Owa8lyTqTLLc/vOCMosOxehaqOnwWBoP1MwnEsOU7MgAI3HRWrOkM57zsEXT/1GOOCJcPRQzcqPsZ50bgZuPqy0kCPaBVMGTpWfx2psKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoyTmhfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoyTmhfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398B41F000E9;
	Tue, 30 Jun 2026 02:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782785754;
	bh=m+MxjZF7DIYbp1NRXgJX0dvCxIvrked17cofwHG1bv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NoyTmhfZ1ctskO3qRIQNSiqcyAknsKoP46OAnWIHyiR53FSnlBv4o4puMd/BgVo2P
	 aKD4tT68hEEMpLGBcbg4lRK4J/f7GbJ5oOc2pO1eOpLEiZqNHzo8+WizwIjZ6bFr+e
	 DWSddJKx/wKHfzQHDp+oB8vm9Wfel0Z/vIcnOAo3r4cqKaYqKz0gt1lwBmJI9vq6FN
	 PATwsrgF21xYZQhpclrDpNStiGvdTm9o3amSUGDaLMoYwRDeXoF6VTUiPpYZkSpGcU
	 S4LoOAarksgGquBi8C/k7whMBD9C20vJFzNX3cbNjGPqRnXijLExp4GM0huwj+Shai
	 jWJgEShf2/X5A==
Date: Mon, 29 Jun 2026 19:15:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal via B4 Relay
 <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Cc: Selvamani.Rajagopal@onsemi.com, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v2 1/2] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Message-ID: <20260629191553.0a305168@kernel.org>
In-Reply-To: <20260626-fix-race-condition-and-crash-v2-1-b6c5c10e604f@onsemi.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
	<20260626-fix-race-condition-and-crash-v2-1-b6c5c10e604f@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 08:35:18 -0700 Selvamani Rajagopal via B4 Relay
wrote:
> Threaded IRQ uses waiting_tx_skb. Transmit path also uses
> this pointer without any mutual exclusion protection. As a
> result, it might leak skb buffer, particularly threaded IRQ
> runs in the middle of tranmsmit path, near skb_linearize.

Can you say more ? only xmit sets waiting_tx_skb, the IRQ
clears it. So why is IRQ racing with xmit leading to drops?
