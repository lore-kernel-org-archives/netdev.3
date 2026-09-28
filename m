Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7194D0CED;
	Mon, 28 Sep 2026 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603134; cv=none; b=WIN6O3Q2vL3FoU2gvjs8fUxKzMKJ4lsyidur8MSiVfVt4HqP2/V68R0DigmVTCom1ON/+vTM8v/UqflXFshMdCVpAYTRS7HMKXcJ5ZCmFFW8hhVPFtcXkQmaLfQXGqjBYupBr7lIUPqXYXxJ6UYPtUg2ddOTax8PRNQXHEGTmWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603134; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gn+EBRYCfwMzhHmKq1v9Gm8vrs5HSgiEgd0qkdOPLHxv8WEbcad/Ck2tpWjfhr6wqDLdNE3H1/adojXEFG+eyAY8B7ZKs5jK38QAOVnspLVvv2kdVdjOZt6MTDNwNQQv95XB0dObss4K3LODYTrxQ005dAueuVuvD408SLSv2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0mpjVrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0mpjVrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430721F000FF;
	Mon, 28 Sep 2026 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790603132;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0mpjVrQcqeeJW602rZX8ZSx8MBKd+qxhWmZ0465bdo05ZQsd5wfifAv929tacCmV
	 mIYOD+8Drfk0nmf+9FdeLu3GwHJt7jHWCQEgkr9PqkVeUuqAeeOnwJVGppaFbEegzN
	 OTbT60hDEC14UHBA9xWqmq2mkDAlBHbCcUiqoFYdhQOGaNy7jKzZL1TSDZF8Hci1c+
	 bxZwpHHHouCrg5SWVptAYmjaZ3jkNVaGg2EG0Qjdoytcd0XqhaFC5v5UAvGtM//iOQ
	 ARx4TVPlAGrBDVapCHebHnLwmx5+7Z9obMIGG5ycfcJUs5xjCKEPvsecfA7+01iykZ
	 vtjDZi/6zqyCQ==
From: netdev-bot+sinfo@kernel.org
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, o-takashi@sakamocchi.jp, kees@kernel.org,
 u.kleine-koenig@baylibre.com, bhelgaas@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: 
 Re: [PATCH net] net: calxeda: cancel timeout work before freeing rings
Date: Mon, 28 Sep 2026 13:45:31 +0000
Message-ID: <179060313181.31693.1245077268553282942@kernel.org>
In-Reply-To: <20260928134115.1957-1-getshell@seu.edu.cn>
References: <20260928134115.1957-1-getshell@seu.edu.cn>
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
