Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D224E1C61
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554076; cv=none; b=Tv+40EpxgRdyLrLCkXxEQZ2O5bRfjSzrYgNqQvyh95zR+uTWN7obm+sJ38aJ3q/pRJ4Xx4BSW2/O0nnSjGLecX1twCjlR4IrpJbTrA+sYxaupH2QFWVC8OeirnbME6zuAvCiYlD94553s30gPKN96wdyf4CXWw4wKSVNO11D/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554076; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qSiZE6jkYcc5KPCJ5Vj3GiP8Pfy+r4W8MUGmU5vfjT+HNgBRvfdY9RV2D9PhqyrXzLlz1xI6oWDnBelwU56uWGAF5KQsmH81Q7aGdCYfx3Ljlk+QL5fKaV3aTMxM/epqBaGbIFZpHZ/upTU+sbiAddDyVPKTwnhzmx5tFA+J+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlpNkoXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlpNkoXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92D01F0089D;
	Fri,  9 Oct 2026 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554074;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mlpNkoXwVciuEkf777ufUktHfDrtr20nCxoyiOOpWhCFf6ImTJIeL9tw3VXfkeDU8
	 jkyNk+CU3Bilefi5f5EpZfQYfVkct5cq14QUcq7aMfEQWB2BFEuRwTLwIwofhyMG+S
	 1F4QufONLEKStWaTxegs9XzR8r/zWTpm4J0s+hHtdfOCivRRJCVJDCJbWTyUbyhwxT
	 xpvhPfUcVk7GcEPO9gSfAQqJlJFxNlDmQz4jb5b/eb1SNzdT9Yft7Xcz7KdG9E7HlU
	 N6K/Xge+vjKKP8dk/v44iTi1aIl59NbD4WJWLxrzcfjH3us5DBAaJi+oAemRH1+oP2
	 3JE+1+yJwnpPA==
From: netdev-bot+sinfo@kernel.org
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Subject: Re: [PATCH net] macsec: reject frames after receive PN exhaustion
Date: Fri, 09 Oct 2026 13:54:33 +0000
Message-ID: <179155407332.2527009.17772945284795940148@kernel.org>
In-Reply-To: <20261009135109.718408-1-tjdqudcks0424@naver.com>
References: <20261009135109.718408-1-tjdqudcks0424@naver.com>
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
