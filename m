Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124934;
	b=K5qhJpz7a6nM87dI6grFPrexlbo6mI8Jz/6czfv7A+55nv6UcsYPEi1UcDHwyTIgECv2
	 seDb2bBjy+eLY1VF1uK/9Mgggy0onVA3qVhDWqETnl+cNBGh9Y8J+RhDz46BBV607MHZO
	 eVGlpYByIRM6AkH4D8BFYeYkrB8j0daRIW2F6Jn3zSBkVxne5CW4vc8IsOFttQEoH9+/q
	 t0nukNqbdy7nZRfRwShQvYUCyoHRwYEQWdweNnyNLn2s1N59GxAUZcUZIBu5mMLH6PH2D
	 CKnQrOFbpueDjtrRIi6ZLt4jykn9yL+D5JEtnagkQS70kxO9m94/i0sRdBIeT/1n0xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124934;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=G7e3FuZq4/8OF93a4/so+xdeuoYvTeqm5XcXxChO7GVJqUgMgfXTSd2QAZ1OLB9aDa24
	 zP2WpfjH+PU1P/HZigqXeGMbmaqYrKUzmS9uU2NhNCE6e7FKP+++xPW1ubsUuMquZ6Z6W
	 90B8/rmJ0Jp4uGoIGYq6FzWG2d2Nf/PR3qk1FZ0TGwurLUlMI7PCEFnzeDcD4xu1imKQN
	 PRQNPI/oU8XKfhh++zntggzdbuV02YTVPcM0PztQeF8iJ6u9ALqYCGpyQJx98mdOLUxCc
	 Tc8Vpf0Y98w1KPSAoh6UT8acmanRbc7lqQo4yy+Vm0Fyni9FgLJHw5p/NEicIVQWGFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olXIfxts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0676606A31C;
	Sun,  8 Nov 2026 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olXIfxts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A1D1F0089F;
	Sun,  8 Nov 2026 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794124933;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=olXIfxtsIpIypzyzwMEazQmlvB8+AbHfBTMjtZG7U+7U6ihcqU3gJCFSwBgCMFMQO
	 am0blj/EkRDSSrp5VgsB8ON6UjseoLpR3t0q/jCXDdpojIUStZcut0ic6QqqHwKiln
	 VfN9RybSgT8liglCmjOf2DL9wkNdoW+qr+oJWzfLBcjkEJ0zxqTLQc5Y+BsTZbvyr9
	 5ykiJdHgU9LJKRt94BErapr5asijdV7xw8rh887PLtQwjBQhYNE/FM6eV3z9DvNfkH
	 S5l/oMtAlaOelJPzJdtAkGlFh55HAEFnOEWqB0nvO0u1xyfz/qfKc1cik6+yIFSq7K
	 4SQ2UxcBuMkXA==
From: netdev-bot+sinfo@kernel.org
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Cc: sean.tranchetti@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: qualcomm: rmnet: Update MTU handling during
 format changes
Date: Sun, 08 Nov 2026 08:02:12 +0000
Message-ID: <179412493254.488859.5909018726402609409@kernel.org>
In-Reply-To:
 <20261108075727.2031331-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20261108075727.2031331-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
