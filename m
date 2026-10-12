Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950736C0DC
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785429; cv=none; b=H0J2y+KEW6eFWIZEJxrVgJ7dirwEAVWKPHB+zAEU7WL5JzoI05J1Ktf7oexEv4v3H5R7dVSaO062Hj5eudhZFe7iYWwefRhv3dqxza8MmNQAHSLW7sLKdckcQGzwjDM4AA5LpLzjOiR5tFmvrcEenlBO9gtF722Hfngp7ThEavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785429; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=irY1KMBLPud3r2x4gIx0UcbGJjS670nWxx11peUAqp0PAQYep8UesrdipntYdmlSFSQQOEBZd3vq92cdQ89NezA/3VuXw9vjdwUncmtJm8xVmPDdlYiSnLYDOLxpeWlKhWZteD4Z7aCD39WsIxH5iOAk8bd1Dc/syX3uVFOWiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6tc8Ftc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6tc8Ftc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405371F0089B;
	Mon, 12 Oct 2026 06:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791785428;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6tc8FtctAZrrhTaKaYepCSpPEuhtLt1X/PNV0JY5L6uEkONZpmgvwTVlTlC+D2hT
	 cSWt/xaibJO5KqMvLOnS/IZgvNZgzD/WlMihOobXBOF9P4LdJR7wvJKecwH1GHT3AY
	 b7p6qoh5DgZz9NrAB5F+2zPVqV2nGt7ZubG/9kkpI8lxpWuKNxxkxRRhw15vyk7muq
	 g24tUM4n8ZQCAuVfcY+6I9h7WGqmYWCSmndf5Yxqbt/S8Vn3q5E2RzaKYxYmGxelEP
	 9+J6BmcKHivWa3/C3oBW40F8TOI7qHjfYR3q1+mnXQh+iMMRgS2EHib22+kBIeWoxo
	 jDvKK90RXmQQg==
From: netdev-bot+sinfo@kernel.org
To: Wong Boon Jhee <wongboonjhee52@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH v10] net/ncsi: Fix use-after-free in NCSI teardown
Date: Mon, 12 Oct 2026 06:10:27 +0000
Message-ID: <179178542779.2527009.10417347837736406555@kernel.org>
In-Reply-To: <20261012060434.1974740-1-wongboonjhee52@gmail.com>
References: <20261012060434.1974740-1-wongboonjhee52@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
