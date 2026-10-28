Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223723;
	b=wlCP8sl90aoL770P+5+5Zz6rMorl8Wr66PKUG7F7aQEHeKIZLpjJAMMx+5ho+kIrxAHW
	 t6h82zwzHmuAMRlUZbLrCNhIYWyKGUZehWN4+s70XAQW1J81U/B/v/AK3nhJXgWjb/GZC
	 5/eGEH8venHP/qoUPYHQOHuiaN5+5pbKGI2NUtpD+vYkD+9Go/setx6p4L99Iu6HvCPfJ
	 xiPSRIQrKMV4EH/uAj5axIRP5O/gKwMLD/sw6MiYRjOaIZchsOiVlQytm33vwkHcAiNB+
	 min2/WAcXXuYv42OWiWKYMBFOiCOFT8hymFP4fRc9Dc9hrsVwjYqcBr92EXh1+S0NOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223723;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=W7So/lRdTVrLn/Sl1zbOO6fdoCoXYaKM0y8v7NQC3LX08yTsKNN+GTeYiWuxtJ28PQNn
	 o9yI0/77z0fjJ8uRwxpjMZv+xtnk91xOdfcVRXIT0kmn+Uk+wu7gfETsp6WhQEg6k9du5
	 wx8SbRv0pPLz0Qo8OMSMpxiG3sGBKeMoLEiJg04sFDNDhJyHS4+fu3MHn58icJWx6S9fx
	 qBZVC7PJD5C1DDKd1NTiItxx7S6HLACYpzhvxelPq3PSE4QOOLENwQu1ejJ+l2nlZxYaZ
	 9ydSzbemv2ZXqnVxvRGWx2vwR+8Xpk2A1rTYZ7uJllwB91TWBFdmwaGzFNBlv3plHag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUyADnVr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE726606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUyADnVr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0481F01825;
	Wed, 28 Oct 2026 21:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223722;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUyADnVrOv9ljhfQJnBaj1uWF2jH3xkXGkcYxnFASh2sqBVJF9u78mT8CzmAA/JCm
	 dF4Ss7tz7XzcGZzrDloxSC8nShJiZzQ2eTmKcr9Iv7culSQ6kVuoXET4f+Au+19Q2q
	 1e6jxcnJZB4z5W9piYtjARsty3TI1sq3n/ioUQaQGKdGb2pC9SkwoVr8eSvpBqj9nN
	 bPZ4FSseXIyTxKLKqheQ3Pr6XW82WPtHgX63aRmLgxs5iXJ3X5kRLPAJrkcpPngXDW
	 aobtfdsjCzjTGCxUMgfQzSMJ0NahQt/jD7SvCL0JeqX+SNeGrla11RneWS93PvQf8K
	 /m+9Zll/3ozWg==
From: netdev-bot+sinfo@kernel.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [net PATCH 00/13] fbnic: Fix BMC filter, FW crash restore,
 teardown and Tx flush bugs
Date: Wed, 28 Oct 2026 21:42:01 +0000
Message-ID: <179322372169.3327.17262999729300923799@kernel.org>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
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
