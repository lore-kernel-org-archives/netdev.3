Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F94657EA;
	Mon, 12 Oct 2026 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794061; cv=none; b=YLlyBMVv8pvHy+Y75qCGIsmcmr+apMaaO9w+tBRFzVCTQJycdcC8omEEy3oIi/oWQe2Dtyimfoplu+UzxB9gMu0gbD+QwTGZlIh6pwesN6hnZoj1u3qm9njIVkCG0HhHbFr/eBrRVckQ6tjF6P2rG4gIfL9qVcuR7wDCAx8gP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794061; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9M+4TzfyewQOMPFz/6QALCAwHyUmcEtkx0IjB5idq86cn5Wzp36hHJXw5hA4qaoIaKuZM8X1dbNZa1nb/Sd6ceYvy4GG5v6jkb0SxQHRv3lRl4qsPf86/b67FSsrHqlELoJ7jUCiWvqwEHypBmj2SQ1kUdVUlNo0YgHmElwrS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU1O25BR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU1O25BR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EF11F0089B;
	Mon, 12 Oct 2026 08:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794059;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TU1O25BR+UKhvp7Ujpo7e//H0M2tFSdFcAV6Jo9wfl6vZXBnsSR6BJyQCVERDHjQj
	 va32iT6qEPovrNp7FS0mYz19BBe5b45aLHfJvtgrUiIUBSfMu738c2laZNx02zitQ/
	 BuLjzDth6Bg0CYa6DyE/3ZNJUt6nr27alYFQhPkEO5VZZ7c76NxqFd16MctRMA1msB
	 BITZ+pC2zFd22Kv+c8AFbXpcWzFyFrMw2zyEH+DhUasZvqJS4sBcInbWm53pkwJLW+
	 AftFaA/il5oXFArG8lZXxZe4kWyfFSCrz689wpW9EsWqKV3b2uvMKfoQEhLDuIVdis
	 xJflm8ePbruNQ==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH iwl-net] ice: do not report success for a VF setting that
 was not applied
Date: Mon, 12 Oct 2026 08:34:18 +0000
Message-ID: <179179405801.2527009.14010952920802573492@kernel.org>
In-Reply-To: <20261012082910.283229-1-xiaolinkui@126.com>
References: <20261012082910.283229-1-xiaolinkui@126.com>
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
