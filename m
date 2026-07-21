Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0110F1;
	Tue, 21 Jul 2026 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594160; cv=none; b=TkhJg35MG2+ZTOi0g3If4u2mt+66t8gLe/ZYEC1+UL3TSJ1UQ0FWQbeF3dkSo8lZ/0zVP18q632zEHLRq75nxoDt87/z+S7aS27YaX7U/IKsbxV3Gp0vPAShbbe4Mm6QoAhlWt2IC9cXJysJ3fsjsTjRM2yKm1xsZSuJ56H5Bf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594160; c=relaxed/simple;
	bh=MDok9KVHR618PzvdBQVhmMe2pb6jbgGSXxiy31reXto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncTEeEsgPBj9Gygsd/7Vuj2a5+YMjtxH3mYrpu0rvOfxW9YYSXRd1tjwR+sAo++ExuhgbZxCZxFApm/PcUGMSmbsr0yz+aJdR9R3vb5KvGAPKUiHTyW/0EdXW0YuB1UdlCSyPKBAQ+NqpDho0QC3DTg3cRWtbEQybyjDa/rXySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQb/sXUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQb/sXUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286641F000E9;
	Tue, 21 Jul 2026 00:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594159;
	bh=MDok9KVHR618PzvdBQVhmMe2pb6jbgGSXxiy31reXto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nQb/sXULONrq2MhnnT3rxKO1eVgBqWrmAdNUa+6bbxrA+JzIeUWW6s9FaN8aecH6X
	 EhBKWQf/7oJb5dqEMcC8UucfCNql494zhvwRrhDfTdgwhTqaZkSCzfFLN94Lp2Q7fh
	 hX8wxg35rbOLNIHsQYlssOBRXVTK0R+ZAzyOpRXPHz4ymRwnTrr7cdNksj4E0qNawY
	 hiK4yX6xzf3i5NO1l5wniO7Wo7k54PRByBsMYic9zrvNBsJalA26tek0ETjcmTbbFa
	 L162G62ZfGJgK9clRw1ESppty99fndoezVtAVvwF3es6tkcEquLqG2Ccf0mSFgyvSo
	 rmlJ6qxsGXr/A==
Date: Mon, 20 Jul 2026 17:35:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johan Alvarado <contact@c127.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Jose.Abreu@synopsys.com, pavel@ucw.cz, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: raise TX completion interrupt at the
 end of an xmit burst
Message-ID: <20260720173557.09e322d7@kernel.org>
In-Reply-To: <0100019f35ea26e0-42ad009c-01ab-4a8f-b126-fa65fbacae5c-000000@email.amazonses.com>
References: <0100019f35ea26e0-42ad009c-01ab-4a8f-b126-fa65fbacae5c-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 05:32:45 +0000 Johan Alvarado wrote:
> The TX mitigation logic only sets the Interrupt on Completion bit once
> every tx_coal_frames descriptors (STMMAC_TX_FRAMES = 25), with the
> tx_coal_timer hrtimer (STMMAC_COAL_TX_TIMER = 5000 us) as the only
> fallback. TX skbs are freed exclusively from the TX completion path,
> so any flow that keeps fewer than 25 frames in flight has all of its
> skbs held for up to 5 ms after transmission.

The netdev patch queue has overflown.
If these patches are still relevant you'll have to repost them.
