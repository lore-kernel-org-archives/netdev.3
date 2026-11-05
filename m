Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882679;
	b=oEAchJ0/j+tMJlMYrwOI3Lsjcx8csMfBD+isW3oNL53y5MQBB+yAFMN3cAGrgQP1Mpf4
	 WbSLyRztcysDpr3ERMvlRwanSvBHThs/qJGtUufRIu+UUCN5szo/+xZeRz418iUM+KJsV
	 gobMy+xPiub298JMUfYIG8L8u/81sG3iOVoPXbai9hY5B4efz9jHIm9IIkVn9g/icpPyM
	 XG8zHvqTNrFFrju3Y1e8e/pRSqm4764DBtKvSITuZ6U9Dcq8KffRUWoSWT37WGGe+jPKI
	 iXa7JH9p59gGD0TTWCjwcQ36D7r+/FhEqQrT/Nme+D9yZqCpZus7y8LWouVEXz5jnPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882679;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=CxKXCKHnA5sLAKxALo4IsH0tziPDMUtiAeU8wh6EgB8H2Ly8i+opiFkZBetJawBWuZzU
	 B+5BAdPHKRlx2jI0Dy79rRPb4EiAzZY7SNGQtnh/X7N1EsyJZuppPnKzWRT7Yc7Rfr1bk
	 E/DNLmFPtA0kLu/7ixGcZtt1Z4MOmEWw5U30Mav3N1oYhFzsRDhZIvqWpZeLe9PSdmb/+
	 BqiyLAVlnSTgWn03GRyStxmJ+TOajx9DPdw6snzuOX/nnC3/bgzkRD0Zdw4EtgzI2qWNa
	 FPrnb1Hshn+V0oYudMUXuncqRKgf20yGmjBVSeQ9YMpXQ8einuPi7MuyB/LqZH2WXVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaDRIUJl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730A606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaDRIUJl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7333A1F000C1;
	Thu,  5 Nov 2026 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882679;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PaDRIUJlLDUtALDi/sOxgwLWN0XDrFcnCs/LxVEgpPz+rFRm+q0fbJeMFBRA/Qsw7
	 Udm5J5SVdro7cf6e2PAHUthga+pRrSsLbSw5A6VOjqINWzR3aF+PKgMCFFomMgLCYS
	 DfLEmUTe357d68Vtba/EhnlaoNiN0LcRKPspBUfGTdexqjjUW/fdwAWRPjNExpSgF9
	 xJkb0e3ofhOydF3xB12tNcgc9Q+jimcg1ot/UhkiHvaKRtfnce9S/WCeIS44rNzf2t
	 /WjNPX8R1PKzeiGHZC0LBOvYMp68QKhwgX67Rbys6P59tekA+6MEYrjbhp86wiRnak
	 f+qTIQoiz59zQ==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 Chris Mason <mason@kernel.org>
Subject: Re: [PATCH net] tcp: rate limit receive queue collapsing
Date: Thu, 05 Nov 2026 12:44:37 +0000
Message-ID: <179388267794.488859.8339496273369613629@kernel.org>
In-Reply-To: <20261105124043.1543405-1-edumazet@kernel.org>
References: <20261105124043.1543405-1-edumazet@kernel.org>
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
