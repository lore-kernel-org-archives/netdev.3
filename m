Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A0A448B90
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791360018; cv=none; b=uJx0ruHVzOqSSZsO9Qjqjsn0tEPOgYb9q+Y8AHJxHXnvxf+PE8sJ3qrAFjQxbS1DhT243Tic/S5i7bTEzybmcVsHdFillZQ2oYJ/QqBjONPAkGZNR812AlGTw00u5bcJEXH7Nrjm9hgYVBFNnMRRQMmoa3GY8xelUGYw8hZKfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791360018; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLBzuugsX4Dku5JetX2D3R1hwBABHuNlEmVRO8fPEQfph6H58/2dxEdVtwm1moS/z2hLdGqmWbcuBUgxaDAsFVPEl4TRr8Vk3uAvEePvHTieprvBU3q05nZtrMBCRAnCMumaMQItbjQjb9cbH6d7WPVZ24ZoWEkfC0EQXmBIoDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc0ad8X0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc0ad8X0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0621F0089C;
	Wed,  7 Oct 2026 08:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791360006;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kc0ad8X0fWIDMmpNyTS5mqU16vh4yvt/3BDHZ87YtK02pEvM94XFd8BAwmg5Aanly
	 ZL1lx06U1AmQqvi0WTyGir+4xNZsZuGxfah1mbRhSRLBiddgfqmXY66ukuXal+7uA1
	 oqZaWF1KVpOwJPTt6D7OmvFZi9MnKCwAKj1fSCs3+HDdFjVT6/f0bnXj3CKosExj/L
	 Bnr3KdPabkcu1vkHBzYIT5gCb/f0/hFrfdnpSefUMmxmzEThUUaHEDKGmPKoCOo2Zu
	 dCjsKco9eOVsyekfG6O45Pni1GMPRbtqwC2fGXcEijkz9/dwteZNO4/VIKGW4jWJSx
	 8NtEr9X69yVIg==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Vikas Gupta <vikas.gupta@broadcom.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net] bng_en: pad short frames before sampling nr_frags
Date: Wed, 07 Oct 2026 08:00:05 +0000
Message-ID: <179136000505.2527009.4150714017109192356@kernel.org>
In-Reply-To: <20261007075649.468033-1-edumazet@kernel.org>
References: <20261007075649.468033-1-edumazet@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
