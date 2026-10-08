Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D04470425
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448217; cv=none; b=Xfx++C2uv/tVgWfKFtgHJjfSJaI6Y9bYdudqvkni8Tci/EAA/PCDUx0vGEw4itgCDuRkbmMxk0TY3QAz5h4tJY/8xHWgQVEfzS2ShSy5qqPNuU09SVLUyzTxZwoDszCTdXJQZ+sVioh+SfyArymQxyc2w0FdKjJnVCXLAhUNWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448217; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o7pnunWVnxO8XRunrj58lKnVCWSoCYFl8u8CRgDIIvNxRKy4tkJ/hgTH83gGpqC1jwlAFz9l+gDGpKWfxYIPClj/0pCRFm1usqoGp3gpug53wB+t+M6RQ9iJStfcHCDZNBEaYiF/ioooWUX12VA6yPj79VS0r7q1HN2ddmAXuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdnKbry4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdnKbry4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C091F00893;
	Thu,  8 Oct 2026 08:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791448215;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NdnKbry48EcZfY0u3+K1GIN7ZyEoWJnQKVLZHx1SLqFylK5utNqaQArag4IakF3OP
	 915S0T6wSImRPqd7GoQkNIxBdDsG3bYIkkitv31M3kVNnLbOvd/CB4nmykKmU1mFkG
	 H7rtnqcd6xFFk03tzt9VUShQ3MGMroNGH+hDfkn5MBDb3eZLaQcvGgjbyWKcp+288k
	 9hiWbdk3Odu54Q6cQf7NhzJBDLPU6nofLrx4j8rPIrHCLKycvbTQeiB7Fdjp0mOO7s
	 bo5ZQhZLrCPG0n+adPUpapfY4k3jIU2/SLTOUQlIh/LLQnDREN55o05HWFlDKajJJA
	 0PnDJKEEeW7BQ==
From: netdev-bot+sinfo@kernel.org
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Subject: 
 Re: [PATCH net] macsec: reject replays after non-XPN receive PN exhaustion
Date: Thu, 08 Oct 2026 08:30:15 +0000
Message-ID: <179144821519.2527009.9630064777060740854@kernel.org>
In-Reply-To: <20261008082550.349487-1-tjdqudcks0424@naver.com>
References: <20261008082550.349487-1-tjdqudcks0424@naver.com>
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
