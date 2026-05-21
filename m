Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D5224AF9
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328447; cv=none; b=Ooc8T7u5AldErfU0idUtj94v9+vHhuhiYC/8Vqcu64jErCQJ/yJ86yYK6VKyDAfdbg8pokBqUli6zR0RnuZ64JIGAXTXwVaFvg3rdSjMiZjtDKurZxrTiliXLDsLH9m3gk+7uR3t6Zydk54ZnHbAdNdvCTSVU1XjIs0cn2hF9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328447; c=relaxed/simple;
	bh=aWfyndTJX3y6pSsqJEUbRQvGUUlr+/rzRaWGrFeXFnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgPGZh+I7BH2ie11UVHAQlPRZOUP9TyTsOB7Q5wG1qrZFX5f9F7lbLrACzqB2EOnlloo6IGROivP9olvrS9mYVXHa67p4SNpVT8ybzeK3BCkABDLKy/KKTP+SYtrM67/AlNKBUtaO20+T4SLEiqakb8OSPdg878xtB/c68ASxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LddX1IPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LddX1IPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682671F000E9;
	Thu, 21 May 2026 01:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779328444;
	bh=/Zgh7mOvA+lLAlwM7pu1S/Jyi7/0cpyXP/uqR23SZ4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LddX1IPPzEBLRiBQynuHO06Va6ujJ1BYGdmqDKFAf5zkC4eobusEDJRhIWvO5kMN2
	 mZNT0u1x7NxLPAY4rIVE+MXU38ZHZfeecC3NhN0fxxeATHj4kmBlqxFpsA2C0vXpWs
	 W/65vxzXdwkc5pdtT5yk7TxZFZPP2wO19m9ISl3A7WktGK0/97IH/qdEoQNodSDaxG
	 zlfuqgwdKVmsEtPqdmSwLSA4KCftwnRudyaKt5h+LVvn5+c9OXRlw1gyjGTk7gyO1h
	 8ZaWvR3ZWrZA/T6AJ/ivij1LjKNxm3Enwc2/P83VOazQiyi3MerY3xLxQ81Oi9YBl5
	 juNoUxsUAoWIQ==
Date: Wed, 20 May 2026 18:54:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH 4/7] net: arcnet: expand unnecessary I/O abstraction
 macros
Message-ID: <20260520185403.5c8bb7b4@kernel.org>
In-Reply-To: <CADkSEUhBOh2XQX+yvQ28qxyKONHsSRHasBEOzvHhk0H_5YdUDA@mail.gmail.com>
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
	<20260518010739.80979-5-enelsonmoore@gmail.com>
	<20260518182220.78a9ae80@kernel.org>
	<CADkSEUhXU7f+k+yBO2Y=eonch2k7YmwbQe6o9RP9osRoo1KFBA@mail.gmail.com>
	<20260520152330.699e2ee7@kernel.org>
	<CADkSEUhBOh2XQX+yvQ28qxyKONHsSRHasBEOzvHhk0H_5YdUDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 17:46:51 -0700 Ethan Nelson-Moore wrote:
> Cards are still manufactured:
> https://shop.sohard.de/en/network-cards/sh-arc-pcie
> (This card has Windows 10 drivers that were updated in 2021 - see:
> https://www.sohard.de/en/sh-arc-pcie/)
> 
> And so are COM20022i chips:
> https://www.microchip.com/en-us/product/com20022i

Ack, thanks for analysis!
