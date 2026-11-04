Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759599;
	b=Ike3Ugbigm1bz17zaoyXwy+UUP4FnvZ63SjjGph1IPvm9MlYbcMRnyiK02knx0VhOTNi
	 3T6vmEYL+nwGrvP24CU78pfGmA0eSCUvQJZk2GG5KnWqvw2RZPnFyw65EHd1d2gOW/oQc
	 NjouKtCtSLRPigLLU0YbHLEh8GwhK9sRSbZx+s133nJz1bEIMd8JooU2enq9Z0lIa0yrS
	 mIKyeW0jPc/Z4Q/OZ0fs1gDjqX1aodN1kWF5Td4SWZ128mr3K7DZ2NyRFJRIyFkV/tXum
	 +QxxWp8zCkTcpTF1MdimNZ5rQ+WbsNowQDfpwCeD1isPYO/Pnwe6Q/GF0dWFcgxfmMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=Cci7rBkcGNSR8q38XGVpziICkjSlBqAkfA1pCTBepMIMfAvKEXp/896F8wRgtL1jaiVu
	 wBXAxuYZ21niOeVZhtoy/c3Dg/kjj2+YDuanZT4Ub58iF+MFhgbr65GdpW86VEeyPN1S7
	 WG+P9T1+XhXv7yT9Tpua699fZTDhFzQoeleHQlenL1jCMShUtA5iryvtR+FbSk+Hyovon
	 G6zoaz0rrmgMKFb0vPvOTVXtO/QI22SivgBi+ZZvzqyBCyXoSl/7FzdR6DK38IE7cbTvH
	 iqNt15lD0Do5r5N1aAdy7JSi2BNQW3ZNdSOFY7LBYbGVZ5by98F+sxXiKI4DNZBa19w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5vIdDvx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB68606A333;
	Wed,  4 Nov 2026 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5vIdDvx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6824C1F00919;
	Wed,  4 Nov 2026 02:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759598;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5vIdDvxRFXKD+yDDgUuH4neDN251eEZUffzRoppVvSIK2Xl0588XZR0BObReEvs5
	 1OCUUXcFJsGegIhWcWQo7TbF4gi4lauzrSP2TjtOzkSjGPjoEnWQVLd9yILdPW+5C5
	 SyO4jr5psIhA2OxnEsEdmcCXkb30hkMvU6+JnNjc90UIOv8erHfNBMwZtcXg2m/iss
	 rz8oQTj4GrbQW0uAnX+qQmt6+5ZrJAQ11NzoNRJ31RKgY5zc5t/37zwBuibckJR3We
	 WR+ec1vN/Fkl4gv7V1X9d/0pPoXGAbADSkAjco4u2BWewNqB3Zk++aspE3R6iw9vtu
	 NTH3FyxPm6bGQ==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org
Subject: 
 Re: [PATCH] nfc: llcp: put the socket reference on a refused connection
Date: Wed, 04 Nov 2026 02:33:17 +0000
Message-ID: <179375959796.488859.12096524912848885147@kernel.org>
In-Reply-To: <20261104022811.1484216-1-vulab@iscas.ac.cn>
References: <20261104022811.1484216-1-vulab@iscas.ac.cn>
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
