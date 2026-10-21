Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603697;
	b=PUvaB0Z+R2+vuXO5Rn2RDsynkSd5YJtpSLDrLLgn0L1vrp6d/VX/IWdlt8lVsafvutrC
	 46+WIUsgL3MB309ryKB6G4vF1cBI5Mb0TMe4FxN2tlZV/stgqHls/qBX/k6DtIFikdrua
	 NqE4/z9NGvIbKO13AnGTLQ6ELPoPz0ZBtBU+0L71BlGK57c/sLLE434/y5cXsIz8SMzqi
	 VmevR7uiPWXK2RBnBkPOCALWPf3P29KPKJtFEGnlWzTNABjtHmNfrpD3vImS49UNhjbSW
	 4bilQYSaMUBb2MDOYklW7uX58xXUhgowCBRiJ6FKyRZQEiWRqDUM7fRZuna7uV95F+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=NjpVoVcTZLatJ7H8Gbsj0VD7VsdY6QpB1mTNbhfBMQ+es9rZKdbxAS5VhI+2x2W99ZNb
	 rFrn2QmCyrap8patDIKKgalyNdxYKoqVODaY0iB8z90yUCXEmInw8qFbCpUbmCnHRVWFx
	 qQgpDSpvZe4SQn9iyXRQ7/SAjWiwZzNtHzU0khkD3dzcD4lLHIxjtJ/KrRiGzVKDgLlEw
	 ickt+QF2hYd81v55pblMHi5YOmDxn4nEEQGBflX+GLjCmcR928jFAGtnY5yau5j035fXo
	 3AqR+G5wOZziHngbVY6fTcnJm94PvPLMVOyjZMAt1PNwUsMGUEQcrQPnn+WGhuZRIog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=froEoZ03;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8D606A320;
	Wed, 21 Oct 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=froEoZ03
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BAD1F000C2;
	Wed, 21 Oct 2026 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603696;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=froEoZ03zTppp+aKhpMvSlBPf+HsR2A9atm5IWnbIjW8zsEjza2oWV+DQVuDNcZ6X
	 1Mj5myfCKdSHD/Y+B0jPskcFU4A4kYAEabMiCNJUWpYumq8Db2mxQREijeLubcz/36
	 OHfsqz3r/w4sFrtn2v/9tjxPz2XqquywP8kSGUICm06cGx4Q9QLFwNx0lMjRuqLxk+
	 ocYnCcWAH5jNZzQGlPYiVJ8RhLNotrOGRlcSKnMTJsDerYkieSZ3o0caOvF5HRzHKm
	 cRMNTQjDXL+hvgfxh6U1IGO/SSTFBk1vyRfC8wGl6lOTu5nZ92DyY+G2ptFAmblrcH
	 cfXPtHlLzYRSw==
From: netdev-bot+sinfo@kernel.org
To: Tianyi Chen <hi@tychen.cc>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] ipv4: igmp: report interface group allocation failure on join
Date: Wed, 21 Oct 2026 17:28:15 +0000
Message-ID: <179260369547.3290.16027925616028773376@kernel.org>
In-Reply-To: <179260356668.911829.6576504063198285556@tychen.cc>
References: <179260356668.911829.6576504063198285556@tychen.cc>
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
