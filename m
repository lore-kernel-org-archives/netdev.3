Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D736402A;
	Thu,  8 Oct 2026 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448200; cv=none; b=KZ8f+mg9OHL2sVmlE9z4NQJu1K2ZF+mUjjwnOS213YQBBFsLzmXXzOh1M//GDZknhm8oDd2y2sdWMLcvisV2Gx4LtutL9KfjMnC12VOnJBwARTATzY2lByB9TLj4TWDXxKP9aI+Uhr7Nv/swWTLjzC3gGVTWVcqBzym70fARGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448200; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amGHjpBmdMvd+pDs9O5+6pFBkZvtFNNGhdrFPgP9MCavMA2UYt8cWVAp7kBbjSUSYThqiVutxx18K41XZE687p/g8y6QW9I3kOTv8i8c3v6ZMSXSxLCtw0Uzb1ln8hCKHDi3dRaiDaIjHNw2vO99PMTJRLbWzMppcVN36WGX98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGy7/jkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGy7/jkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6BB1F000FF;
	Thu,  8 Oct 2026 08:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791448198;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MGy7/jkCKx8n6nQl+gRUkSmzPYPHnnbMhShj/V6kFKD7V3OOxBMSN1Fo8bL+I7dCf
	 sShYjCeZ1E4DvonOfj36XcYQtN4n7EYKpfWFAtydGz5dn+0szFfBDfipq2KvTmJv8S
	 9ZVpBFpt5sdMwCldsDEQd4sX7KPfzF9x4PC8FEeLxgr/6TZtk+ooj8oG41vrLofUhl
	 aTWqGGDrF6lvUQYYemE4o2BeBGdocwtl6OgZDz3LaJkdTPDdWsX5PsLoj7dppkETvB
	 kM5lGTJP2m2xisN/MhI/l8tjRYEl2eIqHgV658PFpwoXpLFHWUIfRrT4jH8+Whf+/f
	 ZBGgsbL+Byfhg==
From: netdev-bot+sinfo@kernel.org
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org
Subject: 
 Re: [PATCH net] qrtr: make repeated lookups from one client idempotent
Date: Thu, 08 Oct 2026 08:29:58 +0000
Message-ID: <179144819826.2527009.1542482431321559008@kernel.org>
In-Reply-To: <20261008082518.347350-1-tjdqudcks0424@naver.com>
References: <20261008082518.347350-1-tjdqudcks0424@naver.com>
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
