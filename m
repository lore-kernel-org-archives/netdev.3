Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804F399D08;
	Fri, 16 Oct 2026 04:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124091; cv=none; b=d9Sst7HPTeQfzXWcLFic9hubelJBTXisfNaSRVG//3HlJh2c41ndLH2+5qAqSuCKgNi6/SB/vW2wWgoQDUnGGeRQ1LtQeN1SLtHd7g/s5ffQweSk1X07AxWmTeC7oz7QPydwUzs3QF7wwZbD3MO+dq+ScsCakLocABUJ7Ja3Fio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124091; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BejXm+nUJCmQ31DMNsYdQ8WXLfjvmXgZcu5Lsp1xTZVIj2HFcGnmhWtrSdWCbdvRG18ueKRlrQPtWqPy3x0uNODZ+jEo8/fEf8oxtqIfXa2dB3I9b50D64+IwjuQUVIPhANaKJ2W+1W2Y9wXigqRBMTyhiCWlmdJUcAVJoZ7vd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNLmKgTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNLmKgTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663FA1F000C4;
	Fri, 16 Oct 2026 04:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792124089;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gNLmKgTNXe37Ju6OkYo0KlfVWQaaqVp3YmD/RFWSmVlt8mV2MBcIBtgQ6X3KAL1b1
	 G5sfUkO2x4CHEh9XD7946MCU2UGNR4La0D5ZZ0qyDFeNGSU/cXCjflFogQfwUMp6FO
	 EoVQ4XAq0q/ZybpfWcu7PiBEwA6zEuCDnyfidRwQjJ3t2a0bW/vaLLpqIeqhkFA7Ts
	 qs6VUCtT1I9GsCW7xQkid+gjWFsv4nKYCWvJrFKsIKM5BeOf6l1HcngarTmya0/H1i
	 Nulv7fWWniIHwzFRBJcgnQnPtWHthU8wLpu+DI7CvSkWJH/yUqa4u+r+13EgnM2GBD
	 CanD2O/rvOTPQ==
From: netdev-bot+sinfo@kernel.org
To: Liu Chao <liuc63@xiaopeng.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Liu Haijun <haijun.liu@mediatek.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Paolo Abeni <pabeni@redhat.com>,
 Ricardo Martinez <ricardo.martinez@linux.intel.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] net: wwan: t7xx: fix tx buffer release loop on invalid skb
Date: Fri, 16 Oct 2026 04:14:47 +0000
Message-ID: <179212408791.408196.9351925971039548466@kernel.org>
In-Reply-To: <20261016041156.2295670-1-liuc63@xiaopeng.com>
References: <20261016041156.2295670-1-liuc63@xiaopeng.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
