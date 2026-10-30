Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350795;
	b=XCuho3YtZCOnEzFbhsMNlnjbSMty8x9JQrYqTaRFiK5AFqSyVVLq0Pbbz7j58zI3ByXR
	 zJ7+l2o1YNy8g3xXsqWC0OlTr+yaR5A6KiWXZHxW2/wtgHVfYCa7iPwnCtnQ4S5LQlNgC
	 WZesFz/oaz+3dQudanMQGVs1OQLHirXJVb3ISNZjaTt+UyYRY2opQW38PDOVtiGazVg1Q
	 BVISz5Wi610izygOJeRZJhEQumPZKwqRZvxMrrFHZooeVyLUccoqpOOTgdGMPkSxkbvm6
	 qwXp+NvAu13WZlSaZEPnPnLk1yU2Bogy7vMzT7VxAai2mHzjbjZqYaJCZj9+z/pJR3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350795;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=WKRtgV5H3z9uTW9lHuYA6LAH7xaSFMnSYgzxqU6KjCGuq+E/Ir5EyoHZCCrllYWjWbx9
	 RpHF7dfS3AVDmv8G00n/GV/K/L3WTf4yeFl3YvwCv5A/8pRzn/1FJtXK4gAGPb6HTCol9
	 qPsQhpvNjm1B540PPk6WmqE0+1JsDZZ3tiUbcqqnwL563rib74Kotk7DidXTIlfFvHjil
	 XGEUyULaFPFK/LOwXR4uNusft5jK20EnGvskzTWOSR7sLu7Z1Wp2fukep+VyQGqgGLyW9
	 mHt2y43jJ3BtKxUlpL+oyQkJ8FC8ToAjRY/g8FksqrRzZk5DRYJyiUtE10qeNdx3m6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ee2XFck9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2709606A31F;
	Fri, 30 Oct 2026 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ee2XFck9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35C21F0093A;
	Fri, 30 Oct 2026 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793350794;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ee2XFck92ghLQJ/xoxzjJpa+wZ7UI2slLwzMGCMndaEypPc/80q94MugQiGJSS1a7
	 Rv/lJDlB1Y8i5i+huCKmAORAqyMGZNK4dpUadtmbLLBe0EkrG17ihRk0yaSwIuFiJO
	 hKBFK7bN2bHzOP+aQPLqgWcPYW0W2474VM0p82M7LT7m0CF9K9zFZriIDUBvXO9Bw/
	 QSEh0tpoADP1qZHXMFrkXp9+nQLrNbfYUOSoNjYHIYJY2D8k3ADKDeZn8Eb4c9EQoe
	 cIXjI2UIuxh5LFMWWruNPEf7+r6FgMJFjHoU1oiM3KH0xY2vz9f4dK5lzH2zUQYSAm
	 9AHHq1tQW/rew==
From: netdev-bot+sinfo@kernel.org
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix device_node refcount leak in
 prueth_probe()
Date: Fri, 30 Oct 2026 08:59:53 +0000
Message-ID: <179335079339.3327.14537748743173383861@kernel.org>
In-Reply-To: <20261030085651.1944-1-laixiangwu@cmss.chinamobile.com>
References: <20261030085651.1944-1-laixiangwu@cmss.chinamobile.com>
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
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
