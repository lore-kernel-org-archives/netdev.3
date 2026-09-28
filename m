Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BABC4D17AC
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790637012; cv=none; b=I5WyMqiPm+czFiFVzYMopCFitsA4KBcZ49QyQDQyUUJHlTSAX82OmwM0lQ9qxpPQPNoM06tksoawCVXqV6RZhM5i58jBPUur0JvEvl6o7o912wDeeZzV6UxsrirFX2fQRzBMCSFVFiowcFyvhlb2nIcqfMOO594dMoDWyaGZwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790637012; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIM4FXOZyqNE5r7A/Obk7UlBQFj+953b5molrPj5HgCJ7+xFPYi3nKJZ90oHZbWPx/51l+UUjK1uN+tdfHNiZyP8iN6UP8WcWzSEv0Daxdb5fP/UFepavdrUIoVXR57qEhNWJueDYmriYaXtxXlVfUHcrSAPe0GFj1V4mcNzU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+ymKqyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+ymKqyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAC51F000FF;
	Mon, 28 Sep 2026 23:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790637010;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j+ymKqyM/eODd9fbIykeogimiJKfwf24+KDafud5J8e/ul8qzHOzDiE0/oBg7NlcS
	 k/rjiMSfNcf+3cEwiXF4cKR51GAL7WYDt/FjTPhSyc4YWzywn12M4nTIlGA+mq1Nwd
	 pQssBhO7qEbtAdC71lAOVv5gna4diDx+4LdD+UunQTTd7PMu0BerA3HqNqM1FTSwN+
	 c9JLDBxFqQaadQHrke6+5fXRd+plW2MAruEf4jgT1L9Yi64SHae7EWU2y+qMdBN2Nn
	 +wXfBe6mAPJ5CYJzI6bTujkbCS66TwhUkwfXIFIUuUv9QDniY/O2V5+X/vW4Ha/w8Y
	 wi3rjnpyBoNFQ==
From: netdev-bot+sinfo@kernel.org
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 emil.s.tantilov@intel.com, luoxuanqiang@kylinos.cn,
 bryan.fraschetti@canonical.com, tristan@talencesecurity.com,
 tomasz.lichwala@linux.intel.com, david.butler@appgate.com, horms@kernel.org
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
Date: Mon, 28 Sep 2026 23:10:09 +0000
Message-ID: <179063700944.31693.1912265472568249345@kernel.org>
In-Reply-To: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
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
