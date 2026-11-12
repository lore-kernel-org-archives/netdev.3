Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480734;
	b=LP4E6bI6b0LPWv7Kt/laDDA3jqWyo8X2AoHhG5WFly+z5xVMkLW2TxOVcaz6CXpfjqdD
	 kS2BIaLJGC4Ym3Ke+ptVLzwOK0YDKCI/BgQlGUE1BZ6b8aSLgCTRi+sh7erteK5nvEkC1
	 qJTHmqp9Oc4ajlkWQ/ueE0wPw6sS6Y0wojbzmvV71oXdbBD9pMK4doqCqrPPBaKTpuiq2
	 zBuVOSMNZdTDIqbPNsfJ2z27H8EvB0UBh5PV0pNBdZStuQIdLqUMo+M8nr29MlJnMrH2a
	 td63B3ydYY+n/V28iqT75aYlCalvVUDq3CBXHv7cplIqz2fILa5a8n5XILJLupQ+2yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480734;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=UAR9Mok3qJR6W5b68Vq5QX+p+yYNUAFD8Q3OFbWUFVpi22XB329x/Hbtq+Ez1JyO2erq
	 egAouVbTwuKQYXlujypbnQmslJZjeIAhf3xcFWOvPya9bztRPUDGMHdI2uPio7/Ed91lU
	 zLoNVA16DeJsfJRo7tXXPWaCdydpJOJM5eJn8CKQTymdHTfglwprMJH3m/4WxpCVGuO3g
	 /RpRHTNeVbKt4EIYMM5Xxk7Q7j1UTz/3BTyn0yu8w4iH3ZlUrCTg8ggyYcIzPPOeqkoyo
	 Ji2uDykkUtsRgHGYu5mh3NTBxHN+iLoh+u4vIcm02tWEr4LnTQYwg74q7aeFs/tYvtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILoPnSCZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AE606A327;
	Thu, 12 Nov 2026 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILoPnSCZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7A71F00A06;
	Thu, 12 Nov 2026 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480734;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILoPnSCZ8ezUlOQMPaDPJ9qt4gjX4oZWcYaCSSD45ED3OkNu7KGDLsGA1qe1N96hv
	 MLRcqtsI4jesABSeVfJERg+Uo5DJDiAMGlzxrmOLt8HKNXr7v4d804xcAwCw31yIkd
	 tGKGrFJ2kyFQOPB/QYWOydU9aKWI8tGyiT6DJ/T6dXgxj4uRQnf01gA+Rzj1oNJ72f
	 4RmXCIDVw3xkZsFqH3yC+QAI1rmhAS8kP5/U9ZD0GKCXZg1jMEnHitqpZQZhDCoEvP
	 +rwYA86rjsdKfCyUjWns/iOSbOT/vky/aJkByH8TpP5sQUGQV9Xq3L1eCCFlKVJ+GA
	 3UKsFqpqLcGTw==
From: netdev-bot+sinfo@kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net 1/1] net: usb: rtl8150: break cycle between tasklet and URB
Date: Thu, 12 Nov 2026 10:52:13 +0000
Message-ID: <179448073312.2168702.13029326266334825765@kernel.org>
In-Reply-To: <20261112104548.693456-1-oneukum@suse.com>
References: <20261112104548.693456-1-oneukum@suse.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
