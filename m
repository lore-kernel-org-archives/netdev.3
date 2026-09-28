Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AF4BE456;
	Mon, 28 Sep 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603148; cv=none; b=M5k4xvfcyDzpgZxiZgInkSGrEhIFFC3rGve2LoNRPuKbq3/VRhlkBGT2EQ52f7hG08N0Z6LU6pPXDmLvwDjjFNKqIldWHSQmicwmF3eN3DLAQqrbVx4gYQctDbV1FKKXJ39Os+ULQoLqKmp2iNvwfHome9eEnn+1SziyZ+qf4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603148; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpNV/1J1uS539ijc1RH4cRUZ9oGHGRsno8u75nrqFrd3sx6efFjbzo7hcg83gBzU6IdjuK5ScEb1m/EHKKlBD1yItf/E3jBg1dNfRjTSPfr9QqSTVb5MONjsqwpDvkZy0QK63+8dqDf63S/PhB9OWo6M2bqzTIKP/38JGzhSn8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKQN+XVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKQN+XVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DFC1F000FF;
	Mon, 28 Sep 2026 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790603146;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cKQN+XVwQ7UCa7EZC6kUj6mdDWB+hQhAfBNO5Nfmfmdh66dQKbPvE/znUP6VtZlex
	 hl/+Wkaujhw24epzUCk+BSn/zlzUKIMKHYhGJIU12qlez++CPFcyfKnkvnCrNd6Lw8
	 RqxcxNmsywmwUrRJDpTO5iTLSIoAMKJPLFlMsk63oAx1Vy5wMwp2t6FKchS9rS3rhK
	 hpL9DkakzAEW05a3y5nBgPlcsPY8utsfG+T6qafh53jaDVOY5T43y3j1A4+yVcIJEt
	 SVTojjjLeyEx4pmm6uP+DTYSc+835nRYuCH4VK/hOVbxNwb+Le6EnxJDD084uuDJo1
	 6rPm820UriOKQ==
From: netdev-bot+sinfo@kernel.org
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net] net: e100: cancel timeout work during removal
Date: Mon, 28 Sep 2026 13:45:45 +0000
Message-ID: <179060314551.31693.4640700550731578626@kernel.org>
In-Reply-To: <20260928134121.826-1-getshell@seu.edu.cn>
References: <20260928134121.826-1-getshell@seu.edu.cn>
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
