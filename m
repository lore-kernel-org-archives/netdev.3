Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC892471CEE;
	Tue, 13 Oct 2026 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859522; cv=none; b=os1dWJx0YG0DCmp8MIafJZp7AEYDIu8lZET32HG4JFhLHII1m8uzfLoZr0/27cOp0/OoVq10ClFaBKl54afmjyEf5P2Ys7upI74ndHAtmqATr9GM2ogtr1jTXyirGdaH3/n32KJQuIhZiY0xH5Dcr+R5+Z7bCbbXIXP/TGYNjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859522; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J17M0MrKnc8CMNyfvu9Sa8IFrTQCiY4AeFI4e/hkP1VV/PaEzBgTSWrWHdf0uI6iweE6HVAIbRMkiCRTUCUl9xyVRzwrelNZRnLMgks/lIjMs9sP7rixjzN082eHrxsWLawJrFUAHKlnZ/wnsEynsbJlCdqbClupAYU44PTaVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNpEYsi7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNpEYsi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA281F000FF;
	Tue, 13 Oct 2026 02:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791859521;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dNpEYsi7mypoqxTJFWCvHUeYojSdeVC8TxfChC6yjtILgQkX35f2noKLr/H3Suz60
	 y7kXn96E1EW/qdq5YKuyf5HP7xX3OsnTQW78WdxtV45Ot2ZTWARoNhKAABweyOCPz9
	 tWG1Toepc/O5HjgY8quT6Mo0uoOWWd2qpN2IzUgcJzeC5Omt+8HAUBYMggm+rCuBms
	 jUNgYOWO//DFHFnVKvHFKH1NFtYihe4DxLBvN0Z9Z5jkvSq8i5T/10nOu7jhgCFjuF
	 APIe23QkwPJtShSQI08RK9T/8O8K4I9EdmG7xo/iMn9q8wl0+a3TGOj7myYs+Jicq0
	 o7/GPwuKD0LBA==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Kees Cook <kees@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>, Breno Leitao <leitao@debian.org>,
 Jeff Layton <jlayton@kernel.org>, Kexin Sun <kexinsun@smail.nju.edu.cn>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
Date: Tue, 13 Oct 2026 02:45:19 +0000
Message-ID: <179185951975.2527009.10474280775372209757@kernel.org>
In-Reply-To: <20261013023859.3075601-1-bsdhenrymartin@gmail.com>
References: 
 <CAL4WiipgL26xjM+0+wT-NUVx9ppjQEJj+oShdew-mbzrRVU=dA@mail.gmail.com>
 <20261013023859.3075601-1-bsdhenrymartin@gmail.com>
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
