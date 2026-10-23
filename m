Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716123;
	b=39vzU0FveOUBjm/7q8Blg2433KSfknLs42CmSqxKyC/5Pr78cMs8Q76B2z5Q4vpuS32M
	 LRGP/8nLs8uoWVDAEoQx5gVI39MobVUfciHE71TDkl0lrLSyy0dfOd3wwW77USZO2JJa4
	 xJg+nF93JDpPwjJN/bgQZIcfjiu32o8RdhorHqI9aAZRan3o6ebnmeuMA/ak9JMRN7ihn
	 BsVIBBPpXz8R16Dkk/HmoxNzmMHOGdj4oVXWeZt6iKOI/qqmRiiLGXTjxk+IJGDXPEFKo
	 OPTvRTtjhH/JxxdQzinbTGCXc/BgnYb1yiyhGrxtNhyJh95cl7SXNG5MsFSOm5cWuEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=ESQrmIG9CoQ9oSSjjDvq2KLhfq9BkcyU+uWA29p+tcE+08Z3/gHVKBSzh0tXVM7PW5KG
	 hMtCWc5Pr/GxBGVAKTjfLMR/vee6bGgefloWWLnrKCiL58/HCEFxwMNe8ksgVL6l6zhU5
	 tPfxNilPgR9vs8iDBFbGqIKTplLAT6zvHm2wKvKasSiN6l8tKGJ+ZNqgZ9bGMQS4+hL3A
	 V3lHIAc+XEG/Hn+LtcopqvUUT9bWIohOCefGPq30/swOqYDbcJE4qAlFNTzvESjrWGJYv
	 0n22TQz06/pb3kFkezYV2tV6HS+k+qAgpBRYdvU8XblzBc1BhHnpqa1cbV7tQ1Nm0bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqQOe4Hg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6A606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqQOe4Hg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E881F01825;
	Fri, 23 Oct 2026 00:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792716122;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqQOe4Hg+akz4Fr9/wBoQ5mYKkqm8E6Es/4itoj5EbFCmjEhyJNl+4Xl9bQzHu3Hf
	 S8x5vPywiSujV/TE6qQiKjwcbmvrTlHhEkMYrXbHNd7vnlFEbr2LcxVGXvgh0DwyAj
	 SFkdwgzvvrqJ7e70JwWHM6AaYkZ9BGLUEcbywaLddXH2ev9cEw3Zpwk0M3tKsHRR3Q
	 7FN5S3VTgfmyC/CsXP8pxiZg9wJzVP/JnrJwTkdfM8drc/j4tviTp95nvDZxHHmEKE
	 /4Q3M7zRoqJ4rwRf2Gn+/VPLQ9kmsQvdcjxw0Fl3uAYRj9s0XEcq06o5G4blBybEzP
	 dAk54jHKoyKHQ==
From: netdev-bot+sinfo@kernel.org
To: Kamil Sawicki <user148783812897@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net] net: limit priority VLAN untag depth
Date: Fri, 23 Oct 2026 00:42:01 +0000
Message-ID: <179271612168.3290.1364379199118760958@kernel.org>
In-Reply-To: <20261023003750.1133904-1-user148783812897@gmail.com>
References: <20261023003750.1133904-1-user148783812897@gmail.com>
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
