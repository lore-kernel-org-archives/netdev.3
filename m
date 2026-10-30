Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793328212;
	b=D0wS47cGe5XA18vxT2YGMMhSaU2hz3Wkaf8raVoqWMsqNxGoVdvRPI/GBMbloDSOshGw
	 7Xx8BRHVwnE5aUxOoE7Z6kbG16yUXXD6VwboIA8rf+LGGBlSyd3tXc0n57ZmL4hcFZVz/
	 OUVPnGDcxOc9CPYbfEd1pGbbdYSUeOq/kOmk3PUV0wK6bIWHE5Tgek9X57JOSTvV3TSiN
	 VY6+EnNSGSCXW3DeZ55KAi4ZmM6PuR9Utuq23fTt4cV9PvPwMO52rPvSPF2MbWganlLkh
	 GuCpsecGhOeSpr+EmZoiB6vhvNzoYmngS1p0nI6fc85i80/E/C+Ou1ltcO9ZR70+P2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793328212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=Y2dThDf+Dn0lvUnvp5/AConneAEJqsCfGQF3wE0S0JPGJL5lQ+krMwDZdCpwy23SZqY8
	 aus1sI3oyXJ4+89tHGU6SrbzLIJM54JrTUhN2pGFPgs6ZgOSOcKUR7aaDgKvyJBVHT/Db
	 lUggffzgGgdhbbFZaglbgHZBjNTTbKnTwi31nQztRS0DbUwdJ0cWxBaO3z/zmurjJlct1
	 5p7HgfRf3gg4OhDXqjYQQzuEEyK3UjTnmoRg0qxx6Zli02HoT6bzHg7rYYEb5VojhrfNE
	 ac89Zt3plvy2ksrEJcEN84k8Z0OMM5vgywlqm9P6SsfXhtPe4RH+ct83tUIWUt7KxKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDqpk42V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C51606A322;
	Fri, 30 Oct 2026 02:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDqpk42V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA161F000C1;
	Fri, 30 Oct 2026 02:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793328211;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDqpk42VhY+VPvP9KIgpQkENZDNwpE1VryhHgMfuCkfSSgQ1sHqpqy8qGHVcXu5nZ
	 M1Fug1zXed7UDbVgcj3b3/l4d42yN61lWpD+T0a4rh9ktWF19sL3oYNrR1bxDS0kVj
	 emY1vIOp45ywM+VJe/JknQmGuIfkRGwMth7Kkdoc2JMkJqgaavoFLzytJoo90CbstU
	 nmPuvc/Cos8AgIrT91zj9mF86F/xQDSn2GL5sEQftuDBs87SJuwYMIAA+pQWlqZ/06
	 +X4WXq+n/pcp3ixuzNGhhyK6C467tXEGRunMTK2vDj0X/QbMaDN9nSdbiFeKMLrJcI
	 WCTuh3Rn0TAWg==
From: netdev-bot+sinfo@kernel.org
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Krzysztof Kozlowski <krzk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: s3fwrn5: validate the firmware image size
 against the firmware file
Date: Fri, 30 Oct 2026 02:43:30 +0000
Message-ID: <179332821053.3327.2621510890857714130@kernel.org>
In-Reply-To: <179332800288.52644.4206885352837613064@gmail.com>
References: <179332800288.52644.4206885352837613064@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
