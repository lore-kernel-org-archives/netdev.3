Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A411331EC3;
	Wed, 30 Sep 2026 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760854; cv=none; b=So3zFILPSiFMoIirEmbqOEYPcAb2qNgqJ1Id/1YcGUL7nHyIwbtMr1GGtc5hTL4BBnHjGVqSAIF0qUwywuaogYltxaIekoCJqeH4SGXFm87ugSRnUdDgEZwu8l5v+OD6lWFEGj5D1BNHiJOZJ7v/p8SGtQSJ5TSxcqqSZoajLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760854; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ex02UMAT/RcMIgFk51LoOG7sMcvePI1QOXeJGDOLM7b+wSeqIOKGHaDOVtkeXDW7hvVRMMr5htq5A70ppkEOs86zdalV2oA0lJQggYRbJTgjg4L9VLoAhoAXCfe/6qbZYyhjjUxaJ7PrP8Xhc6VwB+VTLMwTiAYraANm6Bnhnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bylQy7L4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bylQy7L4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965931F000FF;
	Wed, 30 Sep 2026 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760853;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bylQy7L4yaqxnXTN6Gm+mkuTs9JHEI+zqWf5WZhJfepvLDp40RLh6zEtrHY3IOF+d
	 UMytG5RMM2qdhllVJZF64bN0HAmvU7OspDmqoc3SttlHWWtSY/R0IdSElMiTtNrmaT
	 +0kuJkAbpGl+Zs2KX2PMVVmdL0xfoKlxKjlMRBwZ01r/WbJs4ZtzjyBroFaxyqelVs
	 uW52KmSE9VRlMMeJx+gPL60Tm+p+WdNl5E/gNbBf56ZZefIhcliQqwoUBUXDFVo5bu
	 vPk3rJIWosU6eX34p76VYnezA2ybY0GKFCn7t1ZlCXbJYWMDjkt4DpQA56cHo3Jp8b
	 UyeR7Sq0t3ErA==
From: netdev-bot+sinfo@kernel.org
To: Shubham Antil <shubham@octane.security>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Giovanni Vignone <gio@octane.security>
Subject: Re: [PATCH] xfrm: zero-initialise km_event in replay-notify to stop
 stack disclosure
Date: Wed, 30 Sep 2026 09:34:12 +0000
Message-ID: <179076085219.31693.12550494226015833851@kernel.org>
In-Reply-To: <20260930093137.7163-1-shubham@octane.security>
References: <20260930093137.7163-1-shubham@octane.security>
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
