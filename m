Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592D14F70
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569511; cv=none; b=rrdkPeVn1Fet6DrZ8dMz7rv/s54IDZqTsZYcsCquvwrfDK10Nnk/IZB9d4oGS7sx1NjhLtaodtVCY9EClT0Sbp8LPL40hKI2e0jbXCn6wqhhKfclRU5zAKwP1QAF6JZwxhJbVtResvFX2qIT4ECBazIZhWnLGZ9uF70+qHpmUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569511; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEeu7KjJQZ8Th630Mw3QfzGv2atrNNy3NOUChBMjh61KsH0oyH8Yny1FC2TDYcgP/oZppCUONrl6fKM4Mn0Pz7RN1nqGu5W31TGLlQGCz51BMsU7ruGHEfJkf0R6SyjhyIW/HDl6fQLYrEgulx7SdX58hC1MP+ETrhSnMUGtyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHnC4f9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHnC4f9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2347B1F000FF;
	Mon, 28 Sep 2026 04:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790569509;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jHnC4f9B3d6RF61fG++6LF1K2wQePrfhjQMI2vsO6RkkZvmyLDAsZNIezQsxUuzxm
	 9GaANt7VapG/HmSmVOmTha487OnWrfrZ5jgBYh3VB6d6Ne3Xha2tXH2gnqlQLpzPb5
	 6+KDOfXXp0+PlYXe+iiDrPiivaoSrtfUQpK/PRAsLShcBoevMSxRnPpct62H9G424D
	 vaU4R9FzGiuhdpqJlmMgvwSttN36xQy04/okjCFnPt+4irGbyBIg2udpz1D9626/j1
	 MMrAb4s676A/GAI8lX75PPVjqclC22ggQOWyau5VYLn5m6K0WffOFtfmEc/KhXHlQv
	 vQBn76flDxXsA==
From: netdev-bot+sinfo@kernel.org
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, joe@dama.to
Subject: Re: [PATCH net v2 0/9] bnxt_en: Bug fixes
Date: Mon, 28 Sep 2026 04:25:08 +0000
Message-ID: <179056950861.31693.11019543022435274443@kernel.org>
In-Reply-To: <20260928041712.3467803-1-michael.chan@broadcom.com>
References: <20260928041712.3467803-1-michael.chan@broadcom.com>
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
