Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085179;
	b=xn1CQfPCxzh7/TbIYAPRxfFx54Dfp6zkoqPStixKLgI34GL7o4m8kZjCJEQYPlQXEbjP
	 MWGSfA5qV3axCKvjs84ZxEuZEafmOKxYWWWjoXZ4KZgAeEm/3H2617SpUWJLx3YnjFMfb
	 ocASNyuBtiY7TTwWcF55FQt/2cRdK4IoZIaEEab0rXMdgBZ2dDstkdpRYE4ePR2hrGIvl
	 1CBFwfCnAlQ1a3qX6Sg0C/9gVc8s3XW3A+XJ2GWc1LIgS8PN3WRqQkCV8M6371Ria7fCA
	 k954s+QwAaaiuEj3seRde/ymZW6ecdpcaAUG6/9tHKBprnwiJUxoGCIa/DjoxpM7w5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085179;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=QlC1oB+nHcJs9biss2U5Td+JhsQeCba93tiXoAemIAM=;
	b=D/5XW7B22KA7huxeq2hQePpX+66fk4A9LVs7jihkXvX6ZfAlufiuTIpMaDbK5ijqT3Bd
	 r1bZyPN4fr47vAGVKRP5hVwKckHY5RhrgFgmE1WbrNj45pVoLgP272t0wvjQjnSCXwZ3P
	 fK/N/UNVL5J+SufvzUElCioe+zchfsZ6lZQ3uZH22NRX8WJ7af6QXF5plhcyUp1vStvg1
	 ZSbdRzQJk1oAUUvBJSEwjPWhcnw9D1FW6CrEYRtKctb4RJh9s8afY4Gcc/CmXLsqW0RoZ
	 Q2FR0ACNcoTmkydTZMXItb8r/yNhMuLYKCoqUDpFy6/vlILrRwqFstN4S7zfhlRkyEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="vCBQXxg/";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5596606A326;
	Sat,  7 Nov 2026 20:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5596606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=vCBQXxg/
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35EE7A1631;
	Sat, 07 Nov 2026 21:59:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794085175; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QlC1oB+nHcJs9biss2U5Td+JhsQeCba93tiXoAemIAM=;
	b=vCBQXxg//6xusQyfEQOMQXtiH/0GGiDZB34f8r2weOSDAqbde3VbyxJo5bjlSWufMTvFLu
	QIUKdayvVFfSNdZtkPJ2zdJfkR3LQfTLAXrb0i7K9urIZgPhK0PpdU01tSTc+d6cwQu//M
	GnIjde/F3I3PJuehOCO9OP1x4gvpTm4gMhKLJo0sy9cCSE/zJiizhythZ1rWMJD6tXcah8
	HpE2uHzpM1Sj8BmmauZlCt/CfrtbHsFXUnQPC6boKjXI53LgMRmUm7ZetkzGfCMroqOa+5
	kVkSD9ICe6lC6i86vsZhkzEqAQIjzKqwzwQOdvjil/v9dohe+sS2h/QWaKYObA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 0/2] net: macb: two fixes for macb_tx_error_task()
Date: Sat, 07 Nov 2026 21:58:46 +0100
Message-Id: <20261107-nb-macb-tx-error-task-net-v1-0-a2aac5d64d52@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMBAEf4Xcs5dQECX+ivGhLauexmLuqiEh/
 DtFH2ezMzMZVGB0qmZSfMVkTAXcrqJ49+kGlqEwNXVzcK4+cgr88jFwnhiqo3L29uSEzOh917V
 hP7i2p+K/FVeZfu0zlQNd/qN9wgMxb1ValhWJWI+mggAAAA==
X-Change-ID: 20261107-nb-macb-tx-error-task-net-e8a553b4d138
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, 
 Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Both pre-existing bugs were flagged during the clashiko review of my
software FCS patch [1]. These are the promised follow-up patches.

Patch 1 credits the frames dropped on a TX error to BQL. Patch 2 takes
tx_ptr_lock in the task, as macb_start_xmit() moves the same pointers
under it.

Tested on a Raspberry Pi CM5 (RP1 GEM). The bugs are hard to reproduce
and the error path never fired there, but they are worth fixing anyway.

[1] https://lore.kernel.org/netdev/d1f02ab923c0464fa73cafa75a21943d@tipi-net.de/

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Nicolai Buchwitz (2):
      net: macb: credit unsent frames to BQL in macb_tx_error_task()
      net: macb: take tx_ptr_lock in macb_tx_error_task()

 drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)
---
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
change-id: 20261107-nb-macb-tx-error-task-net-e8a553b4d138

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

