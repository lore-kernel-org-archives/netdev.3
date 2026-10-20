Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455487;
	b=y2N2wHYzjIuNXmIc1veSL9uuNwJl3m0i60km81zTRRA265ZRPC+FZuBr0mhdR9Hys2fu
	 TXMtP3T1KVC44y/PB1ephM2yBfiz4OVjqnDbNSz/jxWYjdgOH8+/7wWNduiYbLCi0w01C
	 Ho/v3kdqFEMXGBplqWT6XYfeM5hFo4YYBBPxBffObYW+JuR1PhZd/M5XA9N3Ss3QYEyhe
	 /1QErrIToCdLZaqHThlqku2vgKkNHY+3+glcAl7RZsJwS9iY3iRzvT8VypZfcyWOhGOkt
	 d+L9PbmLo1HltYePtMxmT0MbPKpVFkhKN8idXX9kI0GlmQ5OlNI9EzyRzLsIOkIolRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455487;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IEvaIyhXHXEZCzlzSit2T9T6bk8kSwVa4Br1EuaLx3c=;
	b=FKHay+oN23wVmfpoX1GzUYqahy3lvpR/8c1qjctGW4ndGBX9btOqMeA6v06+wi0PIww/
	 kSLCL+4hvLIQOejWviOokcwKc2Bur5uK8qPBETVNcio1+aBd4hWykYUJTua1UUfAOx3wQ
	 RYhZX72r5YDINMajMJMuLMU4HpW3E+zqvauxkfMknHNAL+Ax+7TtCZC5Qe4pCU8qKKEQd
	 4dhbTiIIzGRM6qLwkEB5pkqOY4/rvCUhzS+2MtRGP5bdWf8O35jA/5QxjrL360iUD0UAt
	 zNhmK7jxwvPcRHSiV8tOryx0Eox8NgWRfN42PKsi4yuGnOcHcoLyOozIpcvy95rx7Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAgv4K+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C49606A319;
	Tue, 20 Oct 2026 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAgv4K+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5002C1F000C4;
	Tue, 20 Oct 2026 00:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792455486;
	bh=IEvaIyhXHXEZCzlzSit2T9T6bk8kSwVa4Br1EuaLx3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FAgv4K+1kT/E5gHVL2jgLK93rJVamNF8UOIr0ShvcCTp/+J+yPY9KaR4x5ZhsUFG7
	 cPd9LaCNYTN/Z7kdWDwrclTUbob3U7rUMHxCNN3NMpdHmcnldA9K/MNq0zaHozdMqr
	 7qzu8iBxvyaHs/MuI2ocfwOFKhIIIkyHlH7/dj3QSpV8VnHeRFCHSS/17Mh6lVN/bu
	 2gl+lE2/DaKhTf4UscwIepesmvg1nBPOonCZpNlCmgmkVzEfiLiWicEnAHBJ9vgHtv
	 jgs/beWsBur8OZXHdW6Uh7D80KYpLspIWn4QLw/yd9COYLmkKkic6EPO3M8nv4wbqc
	 3SJwvT5hz9yaw==
Date: Mon, 19 Oct 2026 17:18:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: sashiko-reviews@lists.linux.dev, linux-usb@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jianhui Xu
 <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v19 01/13] phylink: Add phylink_mac_interrupt
Message-ID: <20261019171805.6aa3a7a3@kernel.org>
In-Reply-To: <acada24c-903e-49ea-be04-879fedbfa08b@birger-koblitz.de>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
	<20261010-ax88179a-v19-1-7475173cfb56@birger-koblitz.de>
	<sashiko-outbox-167008@kernel.org>
	<acada24c-903e-49ea-be04-879fedbfa08b@birger-koblitz.de>
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

On Sun, 11 Oct 2026 07:32:52 +0200 Birger Koblitz wrote:
> > The function comment notes that SFP modules do not support interrupts. However,
> > when an SFP module is physically unplugged, the electrical link drops. Could
> > this link drop trigger the MAC interrupt being handled here?  
> 
> The way this code-review is done by whoever handles the AI is absolutely 
> not OK. The same patch was considered to be free of errors in the 
> previous round. Now something is brought up that has been discussed ad 
> nauseam before, including an analysis by Andrew, and found correct.
> The minimum I expect is that emails relating to the patches are being 
> looked at and also understood!

You are responding to the main Sashiko instance, not the netdev one.
Due to infinite wisdom of some MM people these are not even CCed 
to netdev (I guess CCing the USB list triggers them?)
You can ignore the feedback form that instance for networking patches.

Unfortunately our instance didn't run because patch 4 breaks the build
(patch 12 fixes it). Our instance tries to save tokens and doesn't run
on patches where basic CI checks fail.

drivers/net/usb/ax88179_178a.c:691:8: error: use of undeclared label 'err_nodev'
  691 |                 goto err_nodev;
      |                      ^
-- 
pw-bot: cr
