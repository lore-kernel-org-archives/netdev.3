Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BD30C157
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756040; cv=none; b=hND2qR7LOEUaCa1GlH6AKnzoA0lJJ0WOBy+0ig+otWwnloeXoSyJlcXYTq/xpekDwTRMoLqavHfxWIY9R+UVNKcuyUQrtHTd1CqeRQUdQ+5b1ZrA5Jkc/KThn/AqinwBMkXwzxpKna5jH8WRP86KJaw6d/losK1mbAwrxC9FAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756040; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QE+Sjz3pPi7JIUGizCz0rCgwzrq4rKw1Mw2a9F3DwTainQ/0gQyFbybfk8uMl0Cvd39RkzxIHdxUVIIwjUPdInkvd9wUrYEfR3RBw1z3cr3Tmx/ypmrnjmLKXlGrz6jpleSB3KxmzaN5mzHIWM5IxL5U5bqEd2FFDkHoa2041nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNgcIYJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNgcIYJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E331F000FF;
	Wed, 30 Sep 2026 08:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790756038;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNgcIYJR0zdcoDOO29aMmODsrQhNpwRkez/SejJV8DSiT3cC0oS/pMs0yRSJjSY4U
	 hNSsPDBl0PbHZ74QN4MFh1dHf46uYo/c7+dSwGGTn1KOp78jSWspyaZLqAvI2GkwHP
	 dx9VzVdRNJ2RKBvC9vsuNZVRfpJHdhD8Y2sp25vGSbMRWwYWxCa1BxjWP7+lJTdd3j
	 LmBhHJ3K0MzVjC7lfHvtydj4kSjZu/z+19AirqQb+YOCI+I8BE8LwDXLmGRlFs8Y2Z
	 2JxdLG2cKJ+t49HGl4Rno+j6G3TBHOtR+nNUExz/zjjKtaqPhUUAYXItUD0mc1zMeW
	 VX3gfvymMDUZw==
From: netdev-bot+sinfo@kernel.org
To: Rongguang Wei <clementwei90@163.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH net v3 0/3] tun: fix re-attaching the socket filter
Date: Wed, 30 Sep 2026 08:13:57 +0000
Message-ID: <179075603763.31693.8997586799818361635@kernel.org>
In-Reply-To: <20260930080746.135017-1-clementwei90@163.com>
References: <20260930080746.135017-1-clementwei90@163.com>
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
