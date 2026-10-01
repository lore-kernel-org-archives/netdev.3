Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5746AA7B;
	Thu,  1 Oct 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879340; cv=none; b=DVcn+urQVV9j+4oS2Qkr6jMW2XUl5IltCZVSyuF1+F5nbTcIj7QjbBG7uA9qfuOroffn70dJcqxfLs9KCjR8+nefBYE56voYnIsMs8u5k+CzZ+FLwgk0NLgq6/klCmumarj5uUZQmxWuH1WehQMoU74d6JGygvmO2H1Sug++cFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879340; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z84zYh9FOJPJ4kI5p4472UL9U0mGDtQekV3L/sW+vLHraPGYvlcLMnNXha7WJCwrFj7mpEwDFWd4Zx6p6f4xM5PeyZrVSk6gLR/9XVMTiDBqnnLX3744EwnfaFusO1om+OHEM0AQjz2jTuurmSlT2MH7+IwvejFTTaz0R42As2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mceZk1oq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mceZk1oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD57A1F000FF;
	Thu,  1 Oct 2026 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790879339;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mceZk1oqdA9cZEUsXdhuOw/yAq7wkO47Qvr4QQj5Zew26DtGnQMbslXyFm7qN6LuO
	 Tpin55Gto7dWbh61OJLuJpGD1aWQy76viYyh+nSSmTCN5xnveNX1F8x11iNrce1G+/
	 S32vmMWj/efJlvKnYZ18Ym7KNpavqVhNCj5HJAOaPEwiaZvUtAos7L3V0sTAYnY7mj
	 +bqL2FRN+5IB6EHqqxdgmZUbLzLib+N/y06kH0ymA++/81GycZjSpiqWOr88PuOwmb
	 BkVQpQ/JTG98rz5k79XAWpPN8J5iP534E9Qv2yO9NULv8p9Dfg3LM58R9m9a0Z3iWx
	 +eJtc9BRqKOqA==
From: netdev-bot+sinfo@kernel.org
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+2cf741c3005abc20@bugs.sh, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2 0/2] net: team: fix transmit skb ownership
Date: Thu, 01 Oct 2026 18:28:58 +0000
Message-ID: <179087933843.1402591.1386346329582858474@kernel.org>
In-Reply-To: <20261001182326.572045-1-bestswngs@gmail.com>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
 <20261001182326.572045-1-bestswngs@gmail.com>
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
