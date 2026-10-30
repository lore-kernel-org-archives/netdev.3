Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334620;
	b=RX8GtLAZcuNtDF0m9DvAYXqbZ4r6PTAM4rW8apTuylViJf6RNvmQ/0C4Cy0wdQU32o59
	 bmJCDsqVtWryVPpiK0car9E63K/ogkfb9u+kWo17IS8gGULmuqKwBjUDdnI1pKE2gVdyN
	 vht9kcNKe48gP+z/GSynI4otqoWZAm5WG8DmC+OmBzIjXJR6/tuD9Oy0OK0Vuoq7Qd3Xn
	 tJ6dFK8q1xFvKHPZuDU7xlEiKIDp+9GX0qmEWEGZKboikuT7TEKtQhdyXovQMAbZBeGAA
	 fmSDygXsIgMMx+2fHjmtEcXjibVVau+Rqbw6m3hNxfQU4BTTHgOO1AhcY35fPDhKJ+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334620;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=sAOAli8pV9Y/8PGJiwwCOFuhk3Ma8BQTgB02/4KTS62s5f7czKC1Naa4dQ/qjMZ7JHEy
	 f8wYAyfiUBAZLcBS4GSkRbv7G9e58YuLDDAzraLc5uOz9XUic5aC+XzjNBmh1xFrdBTyl
	 B3k1+1aXmJ8Q3IoMpqLlFQFXqA/sV/mjxUOy8bpUwgAiB4M2RTEm1iBy1xHb9J6EkvN3h
	 88bPUsFLqqW9GuMU8SivWXJI3KJjGQJrXvJNYgsKWt22SPsVkxW7EcSo+4CUh3nxDoWn9
	 cF1wDRJvOUlh31hLd1WrI0soygj+3a5f/6UKwZS2MxhnYWJLgH/X37RnTHb5UxdN/bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+AoBS2l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55D606A332;
	Fri, 30 Oct 2026 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+AoBS2l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD0F1F0093A;
	Fri, 30 Oct 2026 04:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334619;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b+AoBS2lFeU3/ogVWKQqkX0oC8WM3Mao/pgwH8TkbdRDEXHwB3KxYz/FXGlHGOF+X
	 z9KW+g0CMSOmjUbe4MlMMjzL3VorCkc3ydeN50Cs6ajMmxw4Va6lN40I7NSO6gmIeF
	 3mPDzqM21CktJuhetaFLhl32XfJsFW2dxYw6uoOU029YWrTi5hnB7dWQyWDcQv+xXs
	 wRgaewXL9ygaxekmy6Zjfd1CLCTR54MnPHYC+PquZBycvYFt9a3MO9VNFo+GAilMpY
	 GyHGP7Ba9SIcl3CVwB3KNObmZHC6WUyS7mKOamHPSxZa0FKrJW8ZKLX7ThfrEgc07v
	 0Luaw0bfsIGHw==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Subject: 
 Re: [PATCH] net: skbuff: preserve fclone lifetime when freeing stolen heads
Date: Fri, 30 Oct 2026 04:30:18 +0000
Message-ID: <179333461860.3327.16305814275171840682@kernel.org>
In-Reply-To: <20261030042329.74461-1-kylebot@openai.com>
References: <20261030042329.74461-1-kylebot@openai.com>
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
