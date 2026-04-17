Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFB26E6F2;
	Fri, 17 Apr 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776433737; cv=none; b=KVxmbZewm73fLWgzhKr3TBFaPoRjaxDAuhnOqWw8xh77LakXvmsOf53G9ELRPoWSqK1GfUeX8+kLDxDD8w1H0SLF2SqUNueCsy4snBbz08FeMB1LOELz/4DV0+jR1FJgijkW7WCs5hxpIiMVG9uDa0N+vauL30U/WM+Jci9PiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776433737; c=relaxed/simple;
	bh=XDDn2fyLEhPpiyxgytFsKVqWoaEe/Rdk0v+FGhCSF9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSpYVawy5WjKzZHsy3Z6m0WyN369N+KCqLT/HqHmUIQXq8syNY5uYkHy7L+P0eyCZnwIG3fCIkFols3UYfa5o1y1Gz8R+R81p+6LdpZkOcOlS97jkVKAmvsNbQrumbUuc9huhC9LS4aO2iKFo0fdi3YSHD8NAGgQ/n3Udqonh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Atu7NfMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Atu7NfMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ADBC19425;
	Fri, 17 Apr 2026 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776433737;
	bh=XDDn2fyLEhPpiyxgytFsKVqWoaEe/Rdk0v+FGhCSF9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Atu7NfMqfchjYEpPxZqsUt+/fus0GZD7i0BlhfDD1XB/WC+5ZUvdSh3wrwgCQHtTR
	 Hi4BbIPnd3fOWrazH0hA1lsnXQXKCZ/Z8Fsa7cUhtwC2lpWjv99w1vSGmL08nBvK0i
	 c5mQOsTWP1xNLi8hYYqjmF1PhSXJvFyvEi/XatFpPc5HcUbGFKyNBSRzU+3lIgKbX2
	 4wZXKYO3gzzQh4v4wLacY4F9mRnQTP6XusE+Ws9rUl3/pDJMTR7OQoTckH8PEObp5n
	 DKZSCl950Ys2T7VnxUomqPnM+m1WxfMIr27gb6OxjYBKlh7swp+puRSdbN/feU1MEy
	 WXdtmyqfcBFog==
From: Simon Horman <horms@kernel.org>
To: snowwlake@icloud.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	stable@vger.kernel.org,
	framemain@outlook.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 4/4] nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
Date: Fri, 17 Apr 2026 14:48:47 +0100
Message-ID: <20260417134847.197064-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414233534.55973-5-snowwlake@icloud.com>
References: <20260414233534.55973-5-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm

nfc_llcp_recv_dm() reads skb->data[2] (the DM reason byte) without
first verifying that skb->len is at least LLCP_HEADER_SIZE + 1.  A DM
PDU carrying only the 2-byte LLCP header from a rogue peer therefore
triggers a 1-byte OOB read.

> Fixes: d646960f7986 ("NFC: Add LLCP sockets")

Is this Fixes tag correct? Looking at the git history, the function
nfc_llcp_recv_dm() with the vulnerable skb->data[2] access was actually
introduced by commit 5c0560b7a5c6 ("NFC: Handle LLCP Disconnected Mode
frames"), not by d646960f7986 ("NFC: Add LLCP sockets").

Suggested: Fixes: 5c0560b7a5c6 ("NFC: Handle LLCP Disconnected Mode frames")
