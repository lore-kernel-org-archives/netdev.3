Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211418;
	b=EXj+IVDmFlaDjAmY4URwUA/bQpkm2ZFfJpt72jkrxRnGBMSaDUaArsZ2vu/Au8PACQVr
	 R6XiHVMk8heg9FBQMue+v5LxlTrBFmvkzKG8a7AgORgaod1Rz2MIHAflLbpfBFJDYHBOZ
	 AgX0Ll7FVfKPueogn9wlGruAAZeB2sH3TSCU8v/U/YW1b87KxYLtdTfHWmYTxm2NccbJa
	 rdp7+LVFokbkuJaJb/bD4YhN4weiGiKbZFxyDTBA2sGB5cbmUxDldLQ7PAIvTNyLk5+xn
	 XKvHT60Iye2VM4VDkfwFX4Sls2xg2PUQxGPLsytTxLx/vmTTCAIL2pfxRO607wFueBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211418;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wdFo0XjI9tkdZIoSTisce9xdIBq2+GTowhw6RU8j3/4=;
	b=Ktt/bNAbNkD+/DDJhkq1F/w1+D7jsYtCgbjxpZFLzgvTmWo2HzGVng3itY7a+CxKC+v3
	 vYgdjNyS/rzW0kfwo+Fb+z8X7xWK+nMYcE4C1t114+KDmnQqn060KmUk6wbr5z2O9lgXz
	 0ibi6qCDv839rTqW6ZB5SgKikHrAHKoprOXLuZam7YIX4t0gF5d8x7JBRVrFxsH+A/ZQS
	 FPP/s6dx7xBr3xJ/dbSkwCFd56EFqMv535pAp6PS1I2Um2Cwnm7xxPDs+CVf95ES16WvE
	 mQqcGgaoppGddNLICc7cYUdFUHSDRhTv2KOLfnc2uIp1CBMoYdn9AV9bODbcVsS08dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=ti4qWwWa;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49129606A31C;
	Mon,  9 Nov 2026 08:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49129606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=ti4qWwWa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211413; bh=wdFo0XjI9tkdZIoSTisce9xdIBq2+GTowhw6RU8j3/4=;
	h=From:Message-ID:From;
	b=ti4qWwWaF1O6QRvBWIlJO8dfbHs3WvSWMLmPnCWZLDN05tHzkoZX/AZ++oOXxQKvy
	 PAZHNw5a90J9E75WlMRluS8W/NDc7r+INOy2VV8oN17LaLAlqr2DCvYD/bUH6/G21K
	 YXddq5eaZijM9jP35r4uT7Sj+tnUxWGwoNIXzv0E=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 8E998C0954;
	Mon, 09 Nov 2026 09:03:33 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 00/14] security-bugs doc updates
Date: Mon,  9 Nov 2026 09:02:26 +0100
Message-ID: <20261109080240.29444-1-w@1wt.eu>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here comes a new batch of updates for the security bugs doc,
essentially to make it more readable and to address some of its
apparent contradictions for those not reading it entirely. Some
additions were made to explain how to send a patch and a reproducer
separately, and to ask that first-time reporters send a single
report at once first.

The first patch looks big, it only reorders paragraphs to fix the
current mess resulting from minimal and incremental updates we've
done over the last 6 months in reactions to some repeated mistakes
found in reports. This accumulation has resulted in certain topics
being discussed in a somewhat inconsistent way at different places
in the document.

Aside this big patch (which only reorders, doesn't change a word,
which can be verified with "git show --color-moved", there are 13
small patches each touching a single paragraph.

Interestingly, I discovered that the list's address was still present
in historic areas of the netdev doc and in submitting-patches, which
could be an explanation for the non-negligible amount of reports we
receive showing proofs that the doc was never read, so I've fixed
that as well.

Thanks!
Willy

--
Willy Tarreau (14):
  docs: security-bugs: reorganize the document without changing its
    contents
  docs: security-bugs: clarify when to Cc the security team
  docs: security-bugs: never publish reproducers of bugs with a security
    impact
  docs: threat-model: clarify the case of automatically mounted file
    systems
  docs: security-bugs: explain how to send a fix that can be applied
  docs: security-bugs: do not send archives or binary attachments
  docs: security-bugs: first-time reporters must send a single report
    first
  docs: security-bugs: explain what to do when a report gets no response
  docs: security-bugs: reports left unanswered for 7 days will be
    dropped
  docs: security-bugs: add a section for maintainers receiving reports
  docs: security-bugs: explain why directly sent reports add extra work
  docs: security-bugs: explain why AI-found bugs are handled publicly
  docs: submitting-patches: defer to security-bugs.rst for security
    fixes
  docs: netdev: align the security fixes section with security-bugs.rst

 Documentation/process/maintainer-netdev.rst  |  13 +-
 Documentation/process/security-bugs.rst      | 410 +++++++++++++------
 Documentation/process/submitting-patches.rst |  10 +-
 Documentation/process/threat-model.rst       |  23 +-
 4 files changed, 310 insertions(+), 146 deletions(-)

-- 
2.52.0

