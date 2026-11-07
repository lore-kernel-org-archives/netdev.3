Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011214;
	b=lgsOcjaMNXNahPx1HkbN1pYYRXyJfJFPAgK0wQFRkF15p4lVVQ2hcCvFajau3itDtlFX
	 i3QqjlYHBYO5c7NdBKA39cRo7HHc5TKao/YHxzlp1nRahTDOnYek20AiIX51xsQVgsR2P
	 SXt/DBTD/dCa8ketEgDpVCfDJml532BDvv227zlnELfFw9rWm9ljkq6B08FcZgr2VHf8q
	 rZ8q1bngB85Ern8Y2XTq1b6BRs1D8tr4QngXpBPFyyRUmB5RFyDL7AxPGRFIbyae7aK80
	 lD25Si4cRY/2ri0rmtR3zSrXDB5gBbSth+ZB6ajW+3qAcgx/1BSqcaGZnp9Tch29Ang==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=gk7mbz+OGenp3tb12Wmfdp6J0+h2Dayc4utXjQ9Olv3aAgXBLyh/isJRUXcyOkS6Q5Eo
	 ZMhCiIrKc8rO7SxxiOx9/qcpGFbWESFAtraSz3J/iNm38GnGOHLWRK5uL69KRu6yt0Qd/
	 LRcTxgyzVkwdrHaQDzI5gOohRqdjQcUNJ8b5xyZ+4QUY3Lzv35msqV9q5TueaIVcMGImb
	 GI+iz9zrRtdaHz6ERXqYlrfjqzWik92j1aR7Dz/7XScdZQ9NqQzqO7z0P6Qua6pnI65Ke
	 qsErANi13VVOiuJU2QjD2quGTuAMziNX8tP6gBpurjtL4iHxxZM/b1Zv9l13HG8dIVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGLZUjue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42869606A326;
	Sat,  7 Nov 2026 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGLZUjue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326EC1F0089F;
	Sat,  7 Nov 2026 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011213;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NGLZUjueB2uG69wyTgzwKFe+OcSIrE6ItPMdneDjOm1nNTrkgUlR82JfPsrkU1tRI
	 cYqR6p4c/wIsGimbBghYArVK9wudLhbUfg0uEuvkuXX4KAPxps8UuZGcZBu1zotOvI
	 YQbc7xxRmSMgfzAghoqZIXX88MSOF5iSt5IxEnjpKHFWOJ2lFEWD8Hy9btaOoQVihf
	 mPWnJv7yB05nN8LM+/rxVOsPUWCuvinIcKohHn2BFy1MIwNKwIPmBk+mL7zmRCEGS0
	 S8i1g7yPJ7KuedJJ56bnCGStl9y9s+jv8DrVrx2BYiD3RAG+F4Cr2o8h5grjK5kecv
	 xrVay3AP0DKRA==
From: netdev-bot+sinfo@kernel.org
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Breno Leitao <leitao@debian.org>, Eric Joyner <eric.joyner@amd.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: 
 Re: [PATCH net 0/2] ionic: fix Tx stalls on TSO skbs larger than the Tx ring
Date: Sat, 07 Nov 2026 00:26:52 +0000
Message-ID: <179401121271.488859.11853058701253901323@kernel.org>
In-Reply-To: <20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681@amd.com>
References: <20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681@amd.com>
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
