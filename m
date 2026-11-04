Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785996;
	b=zzoWL9rfpPrrcbhs6w3dSh9yak/wy48ggHfirBuyHJPkdInW91NrOogbtvn/q3/XfkH0
	 w5Elr+dyH71sJbH141aQlAfI/cN7oBfLZdhx8LCE6NlMkEYG5sJ10cc7Cea5IUwJICGaX
	 6Nw7856l+VAxKg8nj03xKApLAgmX36fDq4Nioz8cZ8TF32ghQ0n0tJgWGsxu3ev+vXXgZ
	 oR6XpEDo+JDZ9tVKS6rxHus1bOAyRXDlUuy4C6OJYTBIhrfCMOucOzG8KHGwi/1rQ/Pgy
	 Io9KisvzWQteUIJcSfYUQQFal9cWjrSXLoINBk+M5G3id0XLUk6odJRRqO2WCFS0oBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785996;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=SODkt9yezCVJhQpkC6H1JTPUhhTZ/jZ47RZtnziKxPLP5w1ExqqGFxoDHdwaRRAKsPSG
	 E/R91GMU6wtk6ocF7Fakacuw5xx6E7ckgQeSw1hyDCld68LdxSDlaocUJjkTfoh77sar3
	 1pNfePZbG1UbinbE7bj8ckTnIhYnJaMO0pHHe3j5feKMSwTvCzDikSO3iAkw05D5iTS8+
	 0tY9mSBWNTVhH6q2zxPNkpjqHrFf6pHRhceN22WnHByBD6N48t12SwffxUSK7bP8c80vE
	 neCGwGWs7i1YeYu2EehHGMDe28rimwDIkpJ5iY0h3wTojtGn1zHdguaWbrtijeb855g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXp3+ySR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB34606A31B;
	Wed,  4 Nov 2026 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXp3+ySR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E071F000C1;
	Wed,  4 Nov 2026 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785996;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXp3+ySREkh1r6F4w3mcFr8YfJnMBx4tBSXc38UsndSWoQkrE6lJAFW6woWsdyLbo
	 s5xdnPb/91wAdNSfCQysJDU8ALdG8hFBgaOdaxxKNGdv311j/QQBPt9DUTsC1skkLr
	 BLR80OXLohbTbqZFJr/JjkABXVrTS1KXF4Rf7QFwBuT653wX5NaQ7o4mNTGCVsRD+s
	 Kta++5cLN6UpgnEMajRecj1nuzPAn1u8k4ALxpWT9iW9ybXDrftNm/h9p1UDfP+VfV
	 fKzBU9TbNCoxFzUO7vjmmATzjJAY1P76cF4tNxFHn+YCuFJ+3IL9ApXmiNzNdyLr1E
	 p5BnvhPZ3xIQA==
From: netdev-bot+sinfo@kernel.org
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, lauro.venancio@openbossa.org,
 sameo@linux.intel.com, linville@tuxdriver.com, aloisio.almeida@openbossa.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] nfc: rawsock: prevent TX work requeue after socket shutdown
Date: Wed, 04 Nov 2026 09:53:14 +0000
Message-ID: <179378599466.488859.1763688054450677667@kernel.org>
In-Reply-To: <179378590950.74297.14503648624087894519@gmail.com>
References: <179378590950.74297.14503648624087894519@gmail.com>
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
