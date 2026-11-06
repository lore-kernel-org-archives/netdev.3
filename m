Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961082;
	b=4iQdCSCoyy2Lp/cJE7iQvvOKEm3UyrY4ahH9vlcKgf31scQObZW9Q9ZDGAtvdDMcloAd
	 REfWVNKCRF8iBI+lbw3pFIIgHFSUwnti+pgKRUXAwdJPulbZ0sLSmWbLTc3rSPjLeQO1T
	 bWAYqiyHT9xckY++anJMtz9mGBVkPsn4inhtNQnZosBM/BLpVKrnbKguWBmJDSp+cKIZi
	 wE4CvM6C4qZBaicMgIZrrwUKWYgGJypfBq4o1WNjTNacx3hsYSo4PBpG3Yg/vbUo7ndSG
	 pbglrReWFZPJFLMAV4dAOtz2L4aXGXqI0nTWhAMGBo7vVZ7B9xqGLeyXAtJWGuVTNRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961082;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=w12peOFymWKjUViaaf9nps9PbjYDf8OvKh2+tzPpz8Y=;
	b=zFd18NnIZhUrPmGexD7N5vz142f4fKyTMkm67OJenm/GfOToyXmYjQwVYNWN06Vw3uyo
	 G0c0SwFT0k6UEyudOGBzWKsKqIL7yBThgjmB2RenQfqXgkmArLKxppnLGwPcIyrD5nvp1
	 YRLSV6Bx7mHJQ/LQV5npD6dTXJRrNJ5v+wdvf+kualUlLtQhwpGtzztcovnG10ZMOd+Ik
	 fns/1hre3MGTERjCGAYo4WoJe/DnmrjY7sjWnVQ90YtzjkNMEQYOlQrhouuAgA4E+a9GH
	 +ho2vWQwWyu319nY/O4s3TZ8S/zuHr8vdMdVEHXA5q9YJSgOP0dz9kHTFTY+Um4h30Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="Z4/u4akj";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33E606A326;
	Fri,  6 Nov 2026 10:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B33E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Z4/u4akj
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 211DBA05A6;
	Fri, 06 Nov 2026 11:31:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793961072; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w12peOFymWKjUViaaf9nps9PbjYDf8OvKh2+tzPpz8Y=;
	b=Z4/u4akj+l7mZpAF5EZkgDjakW61Fv8tlB8qOzi7apbypm7QdD6bQOQVMLE9oKJBn96wSX
	C8/RhfSKJAAIRk6nZGFJWfRSM4SFTBr/2dDp9EKNODFQ6wBA762PodBtSWM46uExjmxLeE
	DDMUBis6NTgRoAsRvlC3z2UJ9zJaSphmFn0QRPMU2Mx4KU+2jtxEqfm/q+T84ZWWNsQ/za
	WYC/A0BNfD9D8PAtqJfWkVN8KuhXGeZlJgvnLOIMTQ4cMQNryLfB8oFqPwXmkTYGj5vPFo
	8vLzvvQ5gnetW6G41E96v/zcTmx7sSzTRHYd0WwJYAW4Y7Mw/GAONE3WjQ5H7Q==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 06 Nov 2026 11:31:10 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Nicolai Buchwitz <nb@tipi-net.de>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pierre-Marin Leclercq
 <pierremarinleclercq88@gmail.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH net-next v6 0/9] net: bcmgenet: support larger MTUs
In-Reply-To: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
References: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
Message-ID: <d6ca04a7139130ce43d6b184351e5204@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3.11.2026 11:04, Nicolai Buchwitz wrote:
> This is v6 of my genet series which adds larger MTU / jumbo packet 
> support.

Looks like clashiko didn't send the mails as usual, but I agree with 
most of it's
findings [1]. Will send a v7 with the fixes.

[1] 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5%40tipi-net.de

> [...]

Regards,
Nicolai

--
pw-bot: cr

