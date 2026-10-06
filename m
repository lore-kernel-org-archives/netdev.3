Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5D3DAAC3;
	Tue,  6 Oct 2026 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326961; cv=none; b=cYtsPlDoiVXMK1xX9FSLCBRj6ywzYHoMyCnNgK1Hd6F8XiNI+hb8K1w5suX370Bh2JHByGhp6z4jdez1cqSidO+DVPCeBTGFm7mqzObtD2AbsGxvjzes1NTqdjnguL/rD4xE/qqih3LrHBz5vxXnw0YUpO3VW7UxC9l3pORc3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326961; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mQE9ipg9R/PDfBhOtq+rLnchnkGAwDijcxlpUe0G32HIzzCkKAMFlpe/+3b2HTZHCm3EFY8jk4jvPBBpuImlRTld1oiRqeYgnOSLmEFXN1s2/8fRFrHegnsSZSOw5jrOD+4TYoEJylaKuWVXKmgnVkMTdAujfU7iDAjC7PQ44DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLYh4Uv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLYh4Uv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C4A1F0089E;
	Tue,  6 Oct 2026 22:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326961;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLYh4Uv2ixBI03BnsDdEJ7tqomrboPu1hMQwqH45jV4n7suTF6m+JNDDfn02L4KLB
	 /xPrpOCCtFDail/yTdbWGj1gK5iKEOyr5klXKhb/qeoxbWDpxhDz/6ENumrHYu/fvp
	 8LmhfpRevFunsPdPKOYXi0bJURMLKno34dfaJ6bc2RZfcutLFBC1vxxPZTJE4QnzId
	 ZU00vtcSmRy0vyx3R6xzmPZZss0IIq7rgZk/XOqxB6t95NCAajM/SPA37E+wPfbsTe
	 2PTZUlvglbph6uaNCCXOheHCsCkaFRed/dQ3mC3b/qFpkHAhlG3HT9+KhD4eYxShCC
	 vOoZC7iQxAoxA==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 outbounddisclosures@openai.com
Subject: Re: [PATCH net] netlink: avoid hashing the network namespace pointer
Date: Tue, 06 Oct 2026 22:49:20 +0000
Message-ID: <179132696042.2231598.3001993287250723765@kernel.org>
In-Reply-To: <20261006224149.50498-1-kylebot@openai.com>
References: <20261006224149.50498-1-kylebot@openai.com>
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
