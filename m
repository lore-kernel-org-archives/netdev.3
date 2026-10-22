Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792643576;
	b=ZGVjVtrhYzwjAOtIi8fgSJbCARccereornn7Lm3pz3LlSYU1SIP5tmISEfTVpAxVRWOn
	 SfpfTQ4vkHQ1A4SkGYcwhEXdf/u2gYFuzZDj5M35wLmpQNiRAWR3wDMExYufZC0AHt83h
	 K9vi+DhqxRs5+OppkHivJGET1oXAfgAqlUG3JMfIPK2tVhM4zXfrrss3Jd23OPZFJro6s
	 +o5XL23NNWnAOdIYi9djjqJltUAav15Gd4D+YjPKEm3H1OkUjk29B6GRv3+nInaDavwu8
	 SAokJz5ey53FMnQTYlqhKR6ez4AX/NlqsaC+jsKmOZIYLjw0VT9vHjEzWyhTOlBdaaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792643576;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=r7N1/XAZ1g6NXuuCmcdi0f+GMsCSpgYt4v+PtFzjxGoYFxiBfnoa6VwtUEIleggj/d4t
	 T7lnUDpKHqQ7kXePb0SDLB9HFWQbv7kADhIC9cbFhG3G60kAiUlSktwWhwC0hvoQMCyqo
	 g7Hjmvk9+d96HZl7EkmmndJBEgEEMa6uF5J/D47S9BIbNS4vCUONZIw3uivfk+2kaOOy+
	 DiHE5CKLvmUuML22l8gSnH/oTizESGfs0yfWmjR7L3bgXFRFt1pPVGpfee8KrLIwL4yQV
	 b8IgxvbdNfACFnrQC5AylnV2zNt8HnB0vvnufqkMFI+TXiCPw06MR5xaM2EodcUBWPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEypLjeE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5C606A319;
	Thu, 22 Oct 2026 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEypLjeE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63581F000C1;
	Thu, 22 Oct 2026 04:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792643575;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IEypLjeEhHEGnbNRHCWVmM012VHaCJyZPYzcRp/GK+k1GaQmTsIP3Yd5zE57DgmVQ
	 /qm+06VEqQvQowGpWORJruliV2Xl3rxGChLzDxPKZXCbVI+lvSQsYc2ORIqHiNpm98
	 uVs1xVIFGeOxVyxBMp4+PlCMeSHU+/oz4C4mg+GrYViXA/4pInsn236U8C/NMb5OCf
	 YYvcKxTk2KCdEK/VBNZqUE8XHC3l8x6+2bw6fZXd5h+gGCaA0jhEJu2MxbLmFN40Ul
	 7GEJO1IRof5+aoyqN9nP04d53sFx9p9WM5qFY8Hz6SV/Ehe7X87jyK1C+xbGvNqYvV
	 1G9nf7AHA2OjA==
From: netdev-bot+sinfo@kernel.org
To: kmahammadraf <kmahammadraf@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Satha Rao <skoteshwar@marvell.com>
Subject: Re: [PATCH net] Subject: [PATCH] octeontx2-af: fix TX scheduler queue
 index mask for 2K schedulers
Date: Thu, 22 Oct 2026 04:32:54 +0000
Message-ID: <179264357442.3290.13030103983603784553@kernel.org>
In-Reply-To: <20261022042653.2640537-1-kmahammadraf@marvell.com>
References: <20261022042653.2640537-1-kmahammadraf@marvell.com>
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
