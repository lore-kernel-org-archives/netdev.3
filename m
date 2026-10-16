Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187C33F594
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119288; cv=none; b=XRpO7gXgyQgloypSMCmIwvO69vs6AMq/sRk211KjRE8sglcSbVH/vatomEYoD3TRDC7getxnP2dRtZPqoWBWMARWyGDrhNV5eEA8qHWf6njks9rNHzaIQdvcMTnzszxsL+M8yPEGROuhxvblx6M+tZzHVdBLYBuIGgGj5O3xjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119288; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qgMATSzvbb6uNnZOdcU5TsKARIIkxTA3KSle7lUbpyZ1mj4t1SsylZ5f8JGCZYyYX9jQ5M2mrtHLRCai3iS50wvGAE1k4ukR6dp6TgJF3AgNT/Fb6MmMMr6ygYwWnsH4HZxtjH+yJOS/QaAlvO3XffcQN+mlsgoGe2JMPkdGx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyNw7/x1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyNw7/x1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82931F000C4;
	Fri, 16 Oct 2026 02:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792119287;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nyNw7/x1PSKkGNy9n056OVuJpJ+066NNqSRzcrg2IjCoXkH0wQWqYoGC2Z4IhKsgx
	 DtlhDYHrnLMAGResB1n1nzcY7FoQvqp6zPCltOEOeQFeQ0xoDLCa52DJI6mzIjpDYY
	 o/8Gu4u92dEHXAz5AKuQGDqjSjX7LiOeq0ZJFN5pqvCqXgbsXQUVtaCTf0d3FLsB5P
	 jCi80dnd3IPuD+OG1V0E2s/Ln0Kf0PUOnK1ck9XDlDWE4DSau6HrFI/R1S8OTf31/5
	 VzmVGfkfyLxi/3fhTfUQmo9CaFs2MA3Tl8i6HbarqwF78tkrx9w2Oxo+Gpwf3hEse+
	 fab3SeVAry6AA==
From: netdev-bot+sinfo@kernel.org
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 0/2] kcm: don't sleep in softirq when the lower
 socket uses kTLS
Date: Fri, 16 Oct 2026 02:54:46 +0000
Message-ID: <179211928626.408196.11462572316325227032@kernel.org>
In-Reply-To: <20261016025059.289202-1-rjethwani@purestorage.com>
References: <20261016025059.289202-1-rjethwani@purestorage.com>
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
