Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9A361969;
	Mon, 28 Sep 2026 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603155; cv=none; b=IDS14V7CQ0t2r9euVZlBi6s2V9RqOQlgYZdnKzNIg0LeUi6vh26lLYC8/oeBSXD0w61cD+4pMV5PW/41FYDcAUZk+3loEnPpxUGlHr28VrgyIdlhe4m76YCWUvU2/pE26G4XEG0DvI0lC/eKY4YKfm7v/bD2PFFn6jJDlGY4a/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603155; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ctruWIUfBw8YVSWX2F3pT46LS4ZoQxlNCKUEK8s3UWvVBVBHhxzBtK6Xsg1XkX7oTDHMxKsHMjXCIk2Pe5QeQ6g6QvI2AhyM1eTbFRoyR++olB4cJett2mcFpV+oo4XM5KWIO7SKTorlFa4nk9710KZYYwE9JOcUFRWKUOVOYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqrHfV6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqrHfV6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57E11F00893;
	Mon, 28 Sep 2026 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790603153;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cqrHfV6oerB1IqFayR7kPvVek2UpX8jD5QpVjypppE1DbdEzCe8xBAyfRJ5GAtd2C
	 dsTeQLs6LWG+5XrgyFuUrXuaTisJUYYmW5EaGhtUMMSlq2Sl7Bjj4p+lTXTlhKYJhq
	 prGnIiQaC+R6sIdgv+6cJFFQxfhbD1/tf12Z+3pNVAvVJzcZlCAvdfQGOxNUnnQkBo
	 rk/leURCsmN4lEDq+VGwfldTlrezk0dijMd41O39sxfXQdgsj9UUK8lRCxeifUBA2J
	 WG5VUwX8wonLJOs6z4iOOFHKirKLLLrzhkxGFdEJ0RmWuDwGBfci81lRMNhi11i0tp
	 clhASDjKS3fpA==
From: netdev-bot+sinfo@kernel.org
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 kory.maincent@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: 
 Re: [PATCH net] net: octeon_mgmt: kill TX tasklet before freeing rings
Date: Mon, 28 Sep 2026 13:45:52 +0000
Message-ID: <179060315243.31693.15075684213044441986@kernel.org>
In-Reply-To: <20260928134125.2003-1-getshell@seu.edu.cn>
References: <20260928134125.2003-1-getshell@seu.edu.cn>
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
