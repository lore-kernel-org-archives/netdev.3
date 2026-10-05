Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD9367F58;
	Mon,  5 Oct 2026 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207208; cv=none; b=crYVggdg8RMTv5yUzmef4nIcCGB0UaEmL8f+QXkA2rp+mNOMl2HNwqVvYgOCGhnaRS99P7a2COzmDovNL4JuKa7g/IvkzrabyrvieQanzZMpEXjcoUOUkpLmfKQcmObiDEq99iugJy6LG5sOAiv2VoMxAqhhfxSr6OC6tB20vSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207208; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJO5F9rpC9tGjF4HqSDf3zjvOrPxWGveD/MFDQ1SuP5gcxGkqelU+ocq//a26cnB59ZWd1TKPlg60cpZkoiR/W4ZqGrmIJf7YLSKWVInHGCzB+sVp7aNYoBJjj/nwTB1TXCCg6ymTQl5NrJVYCdx2rGvKZn9Jlg+qEPcDQhKLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6hUQZTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6hUQZTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3729C1F000FF;
	Mon,  5 Oct 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207206;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6hUQZTmy582RZL+XJZs4XU8LYvv6PeOlMdPaHw6dKHyMbe3gG96a/oXatFeG/1+f
	 aA3U6dLtYE/r3nFLP7KB07mjn/1ye+sMEDaYWCDBGFMuxjg5s15cu9MnkswwgjZEG8
	 f7ikAlJjotYmFSxvW71OBIevW8eOmzhg3VwYKU3AUDqJjmjpp/okxGTvS88qhUYv7h
	 OflvNVhGM8LvcPuE1J33vtlYlmSyxQA8XySg9DVyahYcpQjavDh3crjYzWgH6GurQP
	 xxhHjtw/gvh+b3YihgHeh+uR3PBqM7HeEFBKpEW074TIovSRUoLjtVkf5FpkMzfsUJ
	 6qaGOdNfyB+7Q==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?=C3=96mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: oe-linux-nfc@lists.linux.dev, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: nci: fix out-of-bounds read in
 nci_core_reset_rsp_packet()
Date: Mon, 05 Oct 2026 13:33:25 +0000
Message-ID: <179120720574.1402591.13582434920799046722@kernel.org>
In-Reply-To: <20261005132742.324374-1-omermetekaya0@gmail.com>
References: <20261005132742.324374-1-omermetekaya0@gmail.com>
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
