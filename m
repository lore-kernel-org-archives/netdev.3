Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC6503BCC
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902407; cv=none; b=WXTk10EZrdqjIroT+QosOcyfjsQiNsXaVOBrhxVIfQHyZhBeG3zkX7HMlUgapuxEiSHXLXmIzFU1LSCG0KtOo5Css27coW8ducYQ4EBQRois93PZfZEOprvlg/zGaybc2FCSGj5lge6FFjt2SOKUlYoY5H6xtpVaJGqdSzuwiB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902407; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mwK6aYvVW5hiONkc59q4viV17WdcYK8s2d7UxvyDxBm16+Q2W7E16OFT8ZjxLfZAMPY9vLeh3qCnpxKJRhnnd7+Kjofjgsj0QIt9JRpSkCIsYOYwo7YCPfEYk9WfducPzpeYPXLXkh8DJy0/H5/kE54Tz4hQljW+05iPsi58AXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI98sk9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI98sk9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5881F000FF;
	Tue, 13 Oct 2026 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902406;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eI98sk9DJBqLjFNEwj+VFsvIxHAWajTcHPRN+Gs8VEClZdDBlmxCiaJtoPrkdRWi2
	 GcS3izmzLoljdkuGWCPTFogyx+PRQS5BBxzAPMF4bRFHzSlYmLuy03H6CoXkXGFx8g
	 EO7oWg8NiL0Y0dpl9WIE5LsCjBpgxAgUM3ReWNw30pZUx0jCygM8p/y9gan8BEK88y
	 oa4ECNsY1iFUBk6tEQIfBnWEOm6fYSAh/PSTzuJOPX96r4PhpXjY2dnLNsFGmxZ1jU
	 tgcyJAze6yrfv5MEFrFpZkxbUte2wMdxHPLeKtEVUWXmlz+nl66T8rC0bJzanad6ff
	 GlvtqAqnr526Q==
From: netdev-bot+sinfo@kernel.org
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vega@nebusec.ai
Subject: Re: [PATCH net 0/1] ipmr: validate VIF indexes before offload lookup
Date: Tue, 13 Oct 2026 14:40:05 +0000
Message-ID: <179190240549.2527009.14346495689743715035@kernel.org>
In-Reply-To: <cover.1791899747.git.zhilinz@nebusec.ai>
References: <cover.1791899747.git.zhilinz@nebusec.ai>
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
