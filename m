Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E6378823;
	Tue, 13 Oct 2026 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877784; cv=none; b=KGUvBli5xCkQeOKgPK5rwIgocBPgy4dUBKwKKDSpyBFSAAE17kEloZVni6A6v3r3ejOkTmJvVaq4OD957fyAp+Kadpwm+DWhETGes2Gkk8rkgzDQ4VwR9dcyHMDdwHheVNT59JbhgZ4SjfjDbyhw8H688h6qqQLQtO6kHv7oIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877784; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CWbYtykoxVJM5jPYPmkh5j+9iwpFQ/xIS/jblW3U5T20OcYmmm1kXxC8KFTps9Pwd16lz2Ox3P4kUQa9djvrxivic/us7tIXQ5l547Ecoi1XBkvuHuDpa0h5uYG5KwNFhkeOfxG/vj/cYMXx7aAfhL3LVcPJ19QlOdDuPHCZmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaJnHVMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaJnHVMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142541F00893;
	Tue, 13 Oct 2026 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791877783;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FaJnHVMMSaahifdiv5SRF2Y2K2pTRc7WJiVbdbJLfqmRKMU9QYOAQ55kRPca6KiKa
	 aBD5rip9fqsBfWt5aqA83kWt2vbUYUwEFsivnuI9Bwgv5DFNwbSKOzTp3wpsMz2UDy
	 Y9mv1PNjfz9ovE72WOrfyhC6p5suxSj92QqF+3Ay/yZvCwM3sC8n1mL32EOTsJFi+b
	 xs3rckl6aybic+yn5YlzX1GJTZemqGrYwn0vtuHL+Ja64jcvDnY2TA2yKiwi/r89v4
	 0izX99PcXNLVl6lI5ASGf6Vil6GvFfCyZ0gOhZy4A2vAlE/NAhyWdWQpAraRLDM29K
	 9Y5Ola7my1ZeA==
From: netdev-bot+sinfo@kernel.org
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Christian Hopps <chopps@labn.net>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] xfrm: fix vti tunnel device use-after-free
 across async crypto resumption
Date: Tue, 13 Oct 2026 07:49:42 +0000
Message-ID: <179187778258.2527009.10982365894361615689@kernel.org>
In-Reply-To: <20261013074610.17808-1-q.h.hack.winter@gmail.com>
References: <20261013074610.17808-1-q.h.hack.winter@gmail.com>
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
