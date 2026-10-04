Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B884772AD;
	Sun,  4 Oct 2026 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791137596; cv=none; b=n+tZIIYbprWEBdWs/z3imC3QR0rAgZUflzoKiMJHRH8G5YnzTicXGrsLaNY0tp3YKqnM8hz5h75IFTG4pACQSF+zVRjPZirNHuXmGqboJdfNGtRoXoEqwjNIpJoovOAzAh/4oiLRPDZdQesQTRVQ2tLkCnsv4JMXkST2az1SU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791137596; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R+4hDQoxg4qR2IUXJ7uiiEiBAPsKAZh30KHaIUVci4r5lKrHIU+ROmh/T9P/iUUqqdWLs1ECDzdfeSIj5m2Nn3K93wZEtdPzO+J5WJNrXiRGbNTSA/y44elGilnyFh4ZUqcBfgwDxjkCyallNnTC05cBvQeTAsSiZFHktan5Jaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpJmr8CT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpJmr8CT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7892B1F000FF;
	Sun,  4 Oct 2026 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791137593;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cpJmr8CTE0PdWh06MbDRHqKw5+t5tZbi5D+A/Q1wY/Zg6sjFoYDF63fAHdyyWTs9Z
	 ApJchU1wtNxHVbp0dS7RQ2Kda3P6ebvRNOlxcNyaWxf3/O+am9cBkr5vYuH+oVIwgB
	 AWmqmXd57h4fVWU+Cod7YD8MhVZ1FmFXrNGwH75T1FP4C8zH+lYyTaCr7JNYRwtoyR
	 DFZCOcVZPW+VuEW3el+R4zuGh32kkNjFTryKC3S0qJUtP6fCBI7bCiWl5m993LPnd2
	 jj3+D/Qt7GbdskNDPbd8Gb4ZQkfu5c5GgjmdY8guMJyvjrTT74dmxP/6AfBV0d/6Gf
	 D8bf+YKPFEivA==
From: netdev-bot+sinfo@kernel.org
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, Alan Brady <alan.brady@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Phani Burra <phani.r.burra@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Date: Sun, 04 Oct 2026 18:13:12 +0000
Message-ID: <179113759201.1402591.11539090671130836335@kernel.org>
In-Reply-To: <20261004180954.163789-1-oss.patchbox@gmail.com>
References: <20261004180954.163789-1-oss.patchbox@gmail.com>
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
