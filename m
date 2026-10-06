Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA34A2A5D;
	Tue,  6 Oct 2026 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327320; cv=none; b=Pr/z6VnLz5Bsw2sEoUGhpNGp2EcQeASO8dRit9Og5YWx3z8DJsBMzjIy2ga0cfKgxCy1v+autj7BJxZhoAwOog2TiKVIzxdHS5SfHD/pvg2S0c6lWVJCNZbEjNrDgXUzJPW8XrfhcBzY6Ygl73uYqSQ8P18P/E3pUf0de0wjucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327320; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZTWcbThcpMuRxNb+r6PfhpkYxwjTSWahEO/jUmGewNrSOBk7oeegh/sh8NupaU+EuG26IfuTSdZttuF9Dm+nLcMgff4wrymgOdRa/Io9c9grX/K/UozOBKBq5CEI16dcOEO2r1hqaGY8blLGutfTV0cogMxCPrUKtfazr9KLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQeEhcU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQeEhcU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36621F0089B;
	Tue,  6 Oct 2026 22:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327320;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gQeEhcU9ODmnM+BnHLWbifscKp5mFfEKzicYI90Obk4zYQii3KMW99YwuDFO7ttYp
	 8qL5aVXj4jDnaIL4ufCa4sKv24flQS80JT9nSb9WTIDgvbiuphbSeo5+VIE71cmu1H
	 YlFITN0YUfg0lnSZMWnB1cyAqFWBCxJTikBoanDU6Z/OaihHqR58W24lol8eERBBJN
	 COLFUqJssspRCUEq2KhUIU6L7snH8Zb2SK59qtPKZxHblIUujc055O0mQkOJNcQb4S
	 7aUx259TnBKvPS/o9hK7ixifo3uBQwprOrMTR9CHxcbraHdpucsCjAuHYDSVBqUDOl
	 YhvWxqAbZ+VZg==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 outbounddisclosures@openai.com
Subject: Re: [PATCH net] netlink: reset skb headers before unicast and
 multicast filtering
Date: Tue, 06 Oct 2026 22:55:19 +0000
Message-ID: <179132731939.2231598.7844526000530570814@kernel.org>
In-Reply-To: <20261006224232.50724-1-kylebot@openai.com>
References: <20261006224232.50724-1-kylebot@openai.com>
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
