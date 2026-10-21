Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548520;
	b=yaSyJmeC06oiql04DkpSeGleJDysoWdomFFPx5Glqs1nekSqbl5TepQtKaKtC+I5bJWW
	 GKMcC4AvOLe1MTXrKWcnSlZi3VoRbX/4YqVU1QjnaHvup02tWu4Iqes+44Ar99Oz2JW+A
	 Y+/qGpWCR1FWq/sJuqQRBNgm2hI0n6/kYAn6FEFK7nRMaYR++R0biLH94K26q21ytnmgU
	 DLUoPpax/UoCrd2sadKOso85deVXp8OC/m2BSYQGj8xf3B3D1Pgi7dSf0neZsPS4Lor0F
	 0jwQzfLfVY4W8bzqN8BA6P/wRj8Z+3XmsJFv4wCtYAX9Ucfc4APRDfQOCBq1/5JjUEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548520;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/o+ktcXtgylGbQbhfzImy/2UDYuWyqTPPta4Wh5mK34=;
	b=Xv6CC324tcSq/9RNBwHY9F/VDyUgXmWO3BxFMnTrbmI8N1hcpAad+u2apAdgUwEPs5PA
	 WWMQ189uudezvdhBn35CsLNsIzp0vRLviVYNFXjlS3MAnlYlPWlbkYQyxcGtvOw4nS9/u
	 kpNqWbw2N5Adx02DQDkobCpIWvwMFdzKKLYCAGV9okZBKm1q6VFXZ9euQWpfk82yRYxpR
	 8q7zguuqiGT1Q2wu73fC6x4Zpde95vD3M+Bi06We5GnvFlkIeubU7aKGmgkg7we0GZLBI
	 ZdH/u+YUAJyx2O0yEQ4p7FakevjZSNqFk5RbzzZpXv6trG1/EikBus/3ptSKbFyg7rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NXw/DiN+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B5606A319;
	Wed, 21 Oct 2026 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXw/DiN+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17131F000CB;
	Wed, 21 Oct 2026 02:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792548519;
	bh=/o+ktcXtgylGbQbhfzImy/2UDYuWyqTPPta4Wh5mK34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NXw/DiN+sjBq0u8sbzgvYB/BWnFhuxmE2DOCqWrYyIYGZw+3vLzEV82Fp/Vhoxb8k
	 zM0x/XjjRgG68mNYlYm3l8jq3a9P/LV37zcpAsvR/cOTa5OOKMu6fwz1Yeu2H43Zlq
	 GBmLtrfIjwTFxQtsSN4Lpp6PPED1C/rzID1mrzD+V8vs8LlsSFfSLDfLUl+3y/uqBi
	 ftkOb27wzmEZCuOTzu5o6lft46NSRenRnNhTzCJIa1xNP9OApq65XqInf5ojVxY1N1
	 8s4UU0nIrkDaAEyAuRbxlgWJ9HfmIhXkUMwTDyyiMGywsSLcdCDdLa/KEQ+m9pJelq
	 WdyVsiG6dS1IQ==
Date: Tue, 20 Oct 2026 19:08:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Cc: jackbb_wu@compal.com, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, Minano Tseng
 <Minano.tseng@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Robert Yu <robert_yu@compal.com>, Jeff Chang
 <Jeff_Chang@compal.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 0/6] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
Message-ID: <20261020190838.6f5334a7@kernel.org>
In-Reply-To: <20261014-t9xx_driver_v1-v10-0-4d0dde3613f5@compal.com>
References: <20261014-t9xx_driver_v1-v10-0-4d0dde3613f5@compal.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 10:50:58 +0800 Jack Wu via B4 Relay wrote:
> T9XX is the PCIe host device driver for MediaTek's
> t900 modem. The driver uses the WWAN framework
> infrastructure to create the following control ports
> and network interfaces for data transactions.
> * /dev/wwan0at0 - Interface that supports AT commands.
> * /dev/wwan0mbim0 - Interface conforming to the MBIM
>   protocol.
> * wwan0-X - Primary network interface for IP traffic.

AFAIU AI finds so many bugs in patch 3 it overflows the output token
budget. Please see the review for other patches here:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014-t9xx_driver_v1-v10-3-4d0dde3613f5@compal.com
You gotta feed patch 3 into some models yourself and try to bring
the bug count to a sane baseline before we can proceed :(
-- 
pw-bot: cr
