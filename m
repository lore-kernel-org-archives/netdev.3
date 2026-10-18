Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB63630B2;
	Sun, 18 Oct 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314584; cv=none; b=p8fHPYFSAYgA1ZHPh57xltMjXAmsblOw4SukE7ykwv1Xd6b51KjGiOvYGO4nmvidekZZjIaPBC9TFNWzlNtOY60U450QhFH6ywddkwvb4PvKY8cre1+pG4HtMXfYsZRWqkDrqlJWRnxxOhVSgsjcBVH5KWP26D436EJMg67HkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314584; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkg9mehxS5Irone0IfLLiv2uKoM0VEyNw4KQdsJd9TnjFhyh5lzBdGAcoba+S3OI9PU+obqgm21OGvT4p1a9qq2CHTXLdxRuyiFcMgStrztsH50ayMFiOH+F2uFnVTE4wRcrz3ch+T2zU6NxEf8ayUs6U8Tug31JvJiB+/5s+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T90bL/+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T90bL/+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11541F000C4;
	Sun, 18 Oct 2026 09:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792314583;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T90bL/+nrwFKf8pB0h+LQ2W57W7PvDY1t00AMcGAEABukoYrSRkkhzRpVMaIe9h3W
	 BCQJnme/N5RJSXdTsG2/hzhI8iEAnD2wamtFXBVgznArJtGzffcIcG7sk5s2m0IaMw
	 trAnrlKSdsh7kA/0ZixcFWk3vn24MvpZLdGrwEsSN7dRIxZh02PHIfVZVEsWlN3dMJ
	 8hp4YslX2KvPM+ZizgNmuTxMJvnFSluu3VvKlO2SlysClyeCOFBv8D8qfQEb7jd+s+
	 35q/PQmNuv/hlgaRWRNgNQzFDM56UDQWbvzwiOA7l6T+G58jpLF8zmhtOfDgtCxFAN
	 UQCyC/Ii8z70A==
From: netdev-bot+sinfo@kernel.org
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 William Tu <u9012063@gmail.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net-next 0/2] erspan: fix two header parsing issues on receive
Date: Sun, 18 Oct 2026 09:09:42 +0000
Message-ID: <179231458223.3290.4475639659000401117@kernel.org>
In-Reply-To: <20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com>
References: <20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com>
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
