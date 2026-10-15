Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DAE4DA9DB;
	Thu, 15 Oct 2026 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068608; cv=none; b=ZWbpzM1Tw4N7WX2owavVYyuctIIXONTOAFr9XLdnXVSpwdEXOumXVuiGXLW0HCrJOw8vKLQT0XkXgAluThLiXLiEwuWjNwoX91Bfy8vIRnMkHDaPyT9WBdHZGSQszptxVFdKxbL7PKCE/w6YYrIYSA9na2+3qZiqihongj8JKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068608; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7WF3PHNulUIo2+Q6SWmKqBv9iWutmBR+TskhTykfX9zf8Ve/7rJiTKSDk+IcR1qurjzVWji2cqLUUDexy0EBx17geBTljypVPPOjrfzz+uOtc6LJW9w0kXvSYwDe/3XIP7zET0jbZsWw717t5Jh/E6vg/B0YhGvSf4VYYtzuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHTc2BWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHTc2BWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919FB1F000C4;
	Thu, 15 Oct 2026 12:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068607;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jHTc2BWD3DSC0BgqxK/XktvZz7FvBSYKN+wRNPT6Hqu1meh2yVzMTh53PQPwhyQiG
	 nkGSm0tmeaMTZ8CGEqWodPona9YbxgCG9SzcFSN/xVtPYtDerpa8qyVOEaoaU6qDFU
	 CsY2XA7BdUAfH+MHNaw67Ht2FyIIwmr86arFi6l0GNQA7C7v52uyUhTJ7jS/eUgLLI
	 0zWHJ9kbL9Gn7s2pzI3H5gDNrxMOn9jpP0YkjYW1RusCL+xhicjMs74DCmBUQLYOxp
	 H6sf3m2WKIw/akHPDy7m4YHn8R5L1AA9m77hJ90dSClAiwiQ55oDPvJxKsWsfKHvNl
	 /j4FAlAW52gHQ==
From: netdev-bot+sinfo@kernel.org
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net-next v2] drivers: net: xgene: Fix dma_unmap_single() size
Date: Thu, 15 Oct 2026 12:50:06 +0000
Message-ID: <179206860614.408196.2469714113425981382@kernel.org>
In-Reply-To: <20261015124547.29996-2-fourier.thomas@gmail.com>
References: <20261015124547.29996-2-fourier.thomas@gmail.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
