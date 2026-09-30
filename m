Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C43D669A;
	Wed, 30 Sep 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763248; cv=none; b=kK48QRrjgGvFb209m6epSue2oU0ZarnKJNVDf/yQI2IBEmLcwlikP+FN9L/qrtjvVI5HhZ7c7y3f2zWsLk1NDsDSTTXl83NyX9MRwxqJQ+S5fp1VuyOvKAgbsiMkfagILlOc81DGw/L+/n3bamek/9mSrzUV9V+DoRs/pnxtLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763248; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NdSAQAETF9wb9AptQ/Yyb98zW8XIOJUr8p6O0cRQuJl+rBTepGYZU//G36FG/dMYOHf9QJo5WWT2wvcklb1S6DKQ13xOuxHqSF4X8CRjZcd9TuwMXljs2FcdgG/TufrbQ+ZsudvKLyoBjWDFgg7EwJlK4wUwNzOa6lIWYPQzxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahIGS1cg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahIGS1cg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3DA1F000FF;
	Wed, 30 Sep 2026 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790763246;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ahIGS1cgqhrsuen0OmlyNCfXu8VVlYpSi6Qe2rwKeoySdPZqCgs+NjnzUMS80Cjh6
	 MlgTNGVzTYcDlvjPduuzn1U7p3aKr+TKBMTC1epqSmV5UUk/vnGB1Cu5FrNpfBNMkL
	 qTZX9XO6n0p0sBVhApTJro5mfLVBIpw20U69vSvLtrOqJz2g6BI1Y0QCw2/+hThhqT
	 /CKpBDOaELm+XU9rvBjbsRUYyK3osdYkN8zUFPmoCY7lBt606VzQRsJEAebi3bHfQf
	 wE91ydoqaDtRYEvA+5JkusPr/smy60DilqFqOTcEaCuuk0aMcWSQ5ksGn9BbucV9lC
	 dAAHiVHQ5utpw==
From: netdev-bot+sinfo@kernel.org
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] tcp: fix a few divide-by-zero in congestion
 control modules
Date: Wed, 30 Sep 2026 10:14:05 +0000
Message-ID: <179076324565.31693.5389224820431449811@kernel.org>
In-Reply-To: <20260930100937.206377-1-jiayuan.chen@linux.dev>
References: <20260930100937.206377-1-jiayuan.chen@linux.dev>
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
