Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C547CC79
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201802; cv=none; b=qozxPWvZ9Bj8jOdSVrbDopWWmhVvgs4OH8WeWbwGNUlUfeA9GJJkjADcYNMORJ8Ja3aAHpr9yx7BE3LNOq2NLj3QYG0TgWyZCsNm5z3eMzrF4/vu0Q0gZRGl1HxStIXPstYq37Kl/kq1tPXvnvUvc4tUIwyJStghTCmSqis/kog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201802; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3X1Mf308t2aZ41jGVFjO2h9hCPnP2HaaOBDo+fQvWB8U9UqSkHQmvjLr6d9VomwFobi7n/oLRSxqJetZLBGv027MBNS/sUD/qv1V2hAVEec9jvOg8tS+XnIX+nXxHJItkPKumXU7JHijZScf09Fl1bfTI4WyqiOvuo6WsbrVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB+12Qjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB+12Qjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88751F00893;
	Mon,  5 Oct 2026 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791201801;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dB+12Qjbu6vC8RzQP8wFYvOM5b6jS1I9mm3vMIYl4bnJ0CPx0k/wjAW/kDU1stF9N
	 +OBZiGVYG72ilIYq/NfdH1E36cbordfRvpFqCdXmgiWqd4tJTqKuFBhra5iTCZEbjJ
	 rtvPFfoSuCfsJSHia8108FoVhxkyOSGs/IeiYFRGyzV1nU+D5Nz3UJwpcuS9mgC7Hm
	 fKoz6XZxVDR33D4jm3etdZPiMCwxA1p1prOPiL+ucG2V61tgKKge1iEVZEejNaJAOn
	 KzLVnkZZs+OlMg2HkZC19CD5BHgJ74Rf4EyaNSdmUDFudR63cknV86oUg6WVEV+/6o
	 oK0X6WWIic9/g==
From: netdev-bot+sinfo@kernel.org
To: Wong Boon Jhee <wongboonjhee52@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH v8] net/ncsi: Fix Use-After-Free in NCSI teardown using
 synchronize_rcu
Date: Mon, 05 Oct 2026 12:03:20 +0000
Message-ID: <179120180030.1402591.16737776211267867543@kernel.org>
In-Reply-To: <20261005115944.1397670-1-wongboonjhee52@gmail.com>
References: <20261005115944.1397670-1-wongboonjhee52@gmail.com>
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
