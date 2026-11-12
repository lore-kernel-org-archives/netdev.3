Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489017;
	b=IqjuUCxSOIlHNDhhXYFdQ5P02PldSe+6MY50MjMiW9pSbR9zn4yslwxE+My7cCjGZMJN
	 2mGWVRQewX14Y5ryuAKOqR2DJeLKoc8mDwih3p+VfTe5b4hoNTd1mU+QDCHnPMNZtXXen
	 APWKx76Ne7RtTx+03dX8jto9Kng1sJ1pf4A0ad9UFGWYnymGLD5V1jw+1gDQh2MhfRAyL
	 HElyMF9LtewgL8cfHMSTu0VU/8jDQYEd7Rqf4Iry0BcMqbUORuNOTYYz/oo/ud99LXA4o
	 BS9//b/E3kH6P9cwHu4m7KKyKJKA4AG/7SD6C1YN2KgCmq0bvO3WGSn2P1CslZsLGyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=gcTdH5fDTFPn8jYCkBAvgxzEXHvWqw4xHNGaeEiJjabmIv8RcF2de2Tn6dFbjJqVKvQo
	 xwgj1RPk6l2edO6nBM+WtmpVBymLsmUJ55nuhO6r6cY6wfZWyTA52etmTx1R8YJA0RAXp
	 pT3yhu1zzoNrgLhj8pi6drOCy9xYO9gDjI26hDXfKpO0qibv9Xs/pHGNTzdK2IkQazies
	 BUelpnCxUNBaB0MxjNr1AD/kM0wVIkymd88EFAolkM7SeDvPRoAdIqLuhlWIezPWl/++/
	 BvCqKeMkJ/XEFXWT8BQCBvcXqjZP3FNwABy9n41lWroWL0iEIXHoAQhRCV5lxqHDDrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxYVUuYA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C0606A332;
	Thu, 12 Nov 2026 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxYVUuYA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ECC1F00A0A;
	Thu, 12 Nov 2026 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794489016;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MxYVUuYAKmeGNr7LH7dlub4crKyb10O6m1oEZEZAjnckl+2vnbWelnSqghZYQiNa0
	 JlVHOLuSfBXu2XPNzWABuxpD4h7YQH0MDn6Ud5nOClPYO+KoonloBRzoxkCGMvtiV8
	 x9zyeOIoVL+ewtfYSri2+ddi3iIvyYItqbXhy7pZIY+nLgw2T8kX5ntBs9H4HdSLR+
	 DPkNmm8fVIJMKqSD6zXp76WvpRTzXiPkwRPdv1SVUuBNpUleilyEGJSF0rCmSkhMEX
	 4K7D6y684D2+7pC/8EPM+T9QEcs+tDJC0t5pQ8X1Sc+67+qtVh2upQqS3pWodeuWLs
	 FpiOz3RuK/DIg==
From: netdev-bot+sinfo@kernel.org
To: Kalpesh Solanki <skalpesh942@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>,
 Jiale Yao <yaojiale02@163.com>
Subject: 
 Re: [PATCH] bonding: reject IEEE 802.15.4 and 6LoWPAN devices in bond_enslave
Date: Thu, 12 Nov 2026 13:10:16 +0000
Message-ID: <179448901611.2168702.17174519811846942598@kernel.org>
In-Reply-To: <20261112130833.233208-1-skalpesh942@gmail.com>
References: <20261112130833.233208-1-skalpesh942@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
