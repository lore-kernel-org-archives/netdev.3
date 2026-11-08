Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172016;
	b=1+FXi4YZYmL230aXO/04/P5wAZPzfPPyGlu2LI/HnovdHGLLVvhs2mYd7UHIXXsFKiHR
	 ObL53cI65GMYAHV0vA3KHNpE1DSGhbIiSTPmawi9KogJ6U9KEYh3r6mviiNBMSU/bHa/y
	 ikgaNYudxk5whWElqqYk+duaKNu0hGu8jqtb9O7V/otXvfkQI17cF9q4pmUi15B2IoOKm
	 cKntrrSYtS3Aij5HMbYhzokI5+OLqkGm/Td6dgvGn5hubxtyzfrzBMYM+woWFjczMPEqJ
	 McaNgxHwchcC1KLiThUMNa3QMBLKecyXNt0UMukq6wIpDBtm5Wq5I3Iy3V0vh8EpnAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=OSF/AeTacrWu1Hvoy/VsgZTsit4aMYhM0jPOh9lUElZvLsx3PQOVAEo+A6GPvli63CS1
	 zEW3UKXPFMzW3Z/k2t+lQedgkWFSeeyJpDhSytrpVvT/ifPbimHoCnnCLbPBs8yiHn6/x
	 l/JjmHhWKajNOayuR8wAxaeAYAg+So9PuCymgcs9Q95hS2iPcO8kg/Oq3ZPbf5cajdba6
	 RXGt8phgcf6U22TxAzQ0MB36msrDDCqVipmpJKab9sMl7Fni2+stIGJ2BR6HQEo3ipQ4S
	 d17P0vJSEQN0Qfdp/2PlOnEq99e9D96H4cNjLktsJ9ndZc6ZKgvODlQ8jqMMbK0DTHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnMIJJ9H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCE606A322;
	Sun,  8 Nov 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnMIJJ9H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD781F0089F;
	Sun,  8 Nov 2026 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794172015;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dnMIJJ9H9ByGoyMHXajOKYb303DWXe2L9oa5YXSCjbS9nnrphfzPr3hqgD0Rvm4AM
	 fDePCQjOjKr7dxtMnNBMQxMTk7Wn/AOO+i77Kf8jYxKsmOARMrcqmK3F510xCeleSy
	 CWqvCWNp8eKbn37Tkd1l/uZARw+SIS4F8qlp3w+wD0POrocT3ukp4HL0GERBScMIoB
	 O3T6aybnyrviaaPfKUGj9SvBNsck7Fgul6eLmgHbT+m2Rf0KOpagdm0+b/PGaRKYgQ
	 WnTdJX9S2pQ6iQrkirRHXMtgwigrLxFbiwpiDAQNPfucBAl2FQNVysimUF9gv+y1tn
	 qkwqlHXGmpjIg==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: dsa: motorcomm: Reread port flags on bridge joining
Date: Sun, 08 Nov 2026 21:06:54 +0000
Message-ID: <179417201494.488859.17405768719520305251@kernel.org>
In-Reply-To: <20261108210357.1633411-1-mmyangfl@gmail.com>
References: <20261108210357.1633411-1-mmyangfl@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
