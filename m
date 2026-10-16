Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42681724
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181035; cv=none; b=sYLqxf/jQvTY32a2XfSUiexh74F0L6Gu13h+9my/fd4hZxDXocKdP6pdLuwuToUm5afwB7wd0d4bYStGKIdB+TAuhkimmg+Y12DhedSLwbusEURJZOVsSpCqBYmvbnrsHLLEglXqFRCQhLqeSkhzFIqv1EOlRdq7ypiAbzFwyuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181035; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2JUo1kDsBgA867mSKBtyhlJfVyPGmWKPOavbCeAMUZdHMKWT3JziQzs+hp1uIlGGy3v0xnJqJBhBtdub6aVCgGx6lvr02MDx6KiMuyqFcSB8Vfehy87sp0PxWCcIGLQb2ELEBkqoCV8O0vkBG700A74zeqPvP4hdgQg+4Guid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEiOUCyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEiOUCyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745EC1F000C4;
	Fri, 16 Oct 2026 20:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181034;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YEiOUCydsGMmr27tbZJXrasjHshK/HpXV3jUtW+7fd0UVkpxQQ2XL7g+/YJ+9UIqZ
	 Ir2NXghtibw8AEI0J/0cWEAXsKdEWlPgA9T4tEAXCCufPfW/813eKEbYEFHVblQLiY
	 GTcDPGJkUkL+pouh8EpsLUvjyOmBpkzR9GN8/oRMSIImQAvgis7iXmSqAOm6sUtk5l
	 FwX9mtrHd0W3ym/3/LleyooZGx8tiT854t3DEBKldeuSxtGQcy43WA4EM/KGPfsfr6
	 MjZ3MCSQur1C/WZEdsJ4mhnhbl4STSGE0mxRmxiyQsZzCs+1M5IJPbdQZpu6jgIsr7
	 Af4j7b4epDIIw==
From: netdev-bot+sinfo@kernel.org
To: Zihan Xi <zihanx@nebusec.ai>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top
Subject: 
 Re: [PATCH net v10 0/3] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Fri, 16 Oct 2026 20:03:52 +0000
Message-ID: <179218103298.408196.17886596144254819298@kernel.org>
In-Reply-To: <cover.1792168462.git.zihanx@nebusec.ai>
References: <cover.1792168462.git.zihanx@nebusec.ai>
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
