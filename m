Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792468219;
	b=VTAnHb2CM4TscR/+U6nea+owKdj1emGaAxeIXWYrXFZsvBtOKyfbItoiA0B/UU8qP4HQ
	 4LwRdhMZn0++uV/8z0kkRTrgncJZ83n0SKDR06BmLT2Tw1uRSp77/+RIK11ydpm2/lKEO
	 +59kE1JBjD2lV3l09ehVO+SjtdviuII36Bl1SQ3kuf5Sct2g/riQX1lk4bNdP+QWIbs4X
	 nLxgJqqrSobJTODGG9Z+TUQS68sD87pkAl6930wz6jUZGfrhZpDA+v3nirXnyF+Evit5R
	 xPDNQi1Ice9VAwV1gqVOWFEk6RHTLB4eohuspcQNVRwYB5B2IcWT/hxpZFbolxayr8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468219;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Zs7TQJ1QMl5/wgAW6DMgdgeWAnLtRic9HtSTpoGlsjY=;
	b=3bk+V8yLwxPEhb/R+KVYubID+x4USL3pQnI2Ye/Dk775wYaDIeN+SLUQWZ3sn4QvFPZ+
	 CETAk7Zr1J28eFpW+XR3OUlK7ClH+Sn03NsaH204b8t6dGq97cRQiMJsOLn4SxYjmlNRX
	 CuBHe1jZgFVGpvT89bjSkt/9HiJ2j3GBXHlpvMwE5zshTV0jNu0yYmgT0pDG+bah9eTNL
	 h0y9IICX0wV7FugM8sfXvfBsnQMkfUy4Cwv+ZFjgTRTVzqL0Fc+JiV0VqNQ4I2ws0fnnI
	 JD9Dnry2s5sa2BufCn/71wVjyd/KW4BLJB4eiP2AXtbo8zE+kG9b6+FOITZ5HT3+PLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=sKH2Imjl;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=qR33jShD;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF733606A319;
	Tue, 20 Oct 2026 03:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF733606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=sKH2Imjl;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=qR33jShD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1792468211;
	bh=7+K4+AX/RtVusBYoHVcrrKKwlzL1owrS1ons4OCjTgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sKH2ImjlFrukzax0bdrGDOvPEsAFx9elkdNoKqJZKlGqbNf+uH7qj/b7GE8mEfVWV
	 XcoImoyp1DRsRlLh/26L4WsDZSD8TTgMQfYwwPBBQ8qPM41QMcgd48gDSs12K0uDWJ
	 Pv26Qc/C8pUaoiCE7lmKdCn5URJwbDBYjgM1YwTQr46Z4D1RmebVfzL1ekMMc6SqOp
	 TIEo+0vr0+29E84PTjQISkB6tdJm+MEZHtHAhPxtHNLVIxr10JlMIAPlV3jkHt5YVa
	 H2PzWW3B7poS7FZ5mBG4yLim5/dTsr8+OZ25vBIronmWZDras2jR1cbr3T6V/tNQfD
	 AW64zrDg8ut1w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 07C14491A8; Tue, 20 Oct 2026 03:50:11 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1792468208;
	bh=7+K4+AX/RtVusBYoHVcrrKKwlzL1owrS1ons4OCjTgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qR33jShDxubnpWGjAKP4snVpA0kPV8kHg5LEng0IY0Ov2UqnwZGLV2TjvCxhsi4EZ
	 eTPRk+16geu+Gqr5OYqYtMptFgEvTIVixmpkBLPTHp5vNm6e/iJ6+lGiv7IqAYcG7q
	 epmL/R6S67VxftIhBhuIgDeoQkW+Yn4yimIJo4PEb8XwG6d1/V/tVoEjlYOQYn/cN7
	 n/VYoc3xE8jJzDP9GmytVn4pdR+SymFVNoKgZM2DoBYt40d94rJFbe8fJLsGxZpepO
	 uJH6p6Tvgi/T/Z072Y/WzcyFERdEtFqbSP24vuUhped3cFgwl4wdlQTqjNw5AVVENf
	 5HCxYfSom+LhQ==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9D16F491A7;
	Tue, 20 Oct 2026 03:50:08 +0000 (UTC)
Message-ID: <d2b9c51d-2f82-49d9-a072-aa47959d7242@birger-koblitz.de>
Date: Tue, 20 Oct 2026 05:50:08 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 01/13] phylink: Add phylink_mac_interrupt
To: Jakub Kicinski <kuba@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-usb@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
 <20261010-ax88179a-v19-1-7475173cfb56@birger-koblitz.de>
 <sashiko-outbox-167008@kernel.org>
 <acada24c-903e-49ea-be04-879fedbfa08b@birger-koblitz.de>
 <20261019171805.6aa3a7a3@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20261019171805.6aa3a7a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Jakub for the explanation!

On 20/10/2026 2:18 am, Jakub Kicinski wrote:
> On Sun, 11 Oct 2026 07:32:52 +0200 Birger Koblitz wrote:
> You are responding to the main Sashiko instance, not the netdev one.
> Due to infinite wisdom of some MM people these are not even CCed
> to netdev (I guess CCing the USB list triggers them?)
> You can ignore the feedback form that instance for networking patches.
> 
> Unfortunately our instance didn't run because patch 4 breaks the build
> (patch 12 fixes it). Our instance tries to save tokens and doesn't run
> on patches where basic CI checks fail.
It would be nice to get that kind of feedback immediately from the CI 
system.

> 
> drivers/net/usb/ax88179_178a.c:691:8: error: use of undeclared label 'err_nodev'
>    691 |                 goto err_nodev;
>        |                      ^
Interestingly, Sashiko did not even complain about that. And the extra 
error handling was in respect of existing code. Should have refused to 
do that, I guess...

I will fix only this issue, then, and re-send once the patch window 
opens again. Thanks again for looking into this,

Birger
