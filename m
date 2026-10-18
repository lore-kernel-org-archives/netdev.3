Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28B3EFD17;
	Sun, 18 Oct 2026 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792296824; cv=none; b=C5GvpQPZB6mavSy8gVokRMyYQLiI/X/D5LrLesxDz8KypGjMRqsy1XiEGy5++20B0xsArZoB7/FHfeQbj3lUTKSupHLoGwHcNjAiw4HwfSkn112IZKY2HiW4u69ED2zkRkLz6hkn3n5w0utjYaBVyAbZZialDSrojyAninJ9V5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792296824; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uictahIQJtqP9u2otkgaZQuOUeaQVqQqqR8d7m4Pd5J6Kar+aT6R0w8CBeSYXq8XKPZHkfOXGg4kV9EixkONNukXK5vYcxabSwsy+fhlrLFSU/mMmhp1+iqElnVpRou8qak4m48LSPUeBcOCf/s2xzdk689CSHZGYIrHbimJXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SopHN22P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SopHN22P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5180C1F000C4;
	Sun, 18 Oct 2026 04:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792296820;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SopHN22Pk7cmZPGHHyRzX9IUicNvy/gpJ7nwk01XEGItwsVpNDDWLQ2mjsGPURNVW
	 VrzStKM4bDae7VGV2coqVlfH1gbiHfFNflYIF6Kb7KsoXNaXxjrF6bL4Glw3mAcLo9
	 iLyLGcKyajoGKw0Vgn1oEej2iGwxSSvAQrua8VXgN0hAmwLPjR7LrQ42vm4uhGIAV/
	 xKjDI+17kLg/T1rZsTcGT7U1PqecsWkbvl4iNxLKwYjJ8Tz+O1Fk5jHK4KUo9joHu/
	 +yLtTHy4HSscmNsWM15kPpgqB25TqsaBX54FoVk3EmOWOyIfjhNC4dSGSYaOcgMxoJ
	 xpAPDT9Pk+Xsg==
From: netdev-bot+sinfo@kernel.org
To: Jiale Yao <yaojiale02@163.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Elad Raz <eladr@mellanox.com>, Scott Feldman <sfeldma@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: pci: drain EQ tasklet during teardown
Date: Sun, 18 Oct 2026 04:13:38 +0000
Message-ID: <179229681887.3290.8191046810661863590@kernel.org>
In-Reply-To: <20261018040653.534066-1-yaojiale02@163.com>
References: <20261018040653.534066-1-yaojiale02@163.com>
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
