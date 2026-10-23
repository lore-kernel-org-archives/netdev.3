Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733530;
	b=X11c1zB2leGwU0B+NKBlRHilq2iiz/++mKvRw0PJYxvhechz7XZa1Rd1ihyn88avpESp
	 wyxwU+aI9cAzsoT+Ts65Y8NZ0fKQZ5IVPxpYiyp3BgYfj3vnmSpQlBZzKyMFwTLepO2/5
	 /WoRLBfu/HkZnxue0hYeI0zgzO5kg5QoE+l6Dyic99/pEP/iV7PBAsTaf5Mz5Wsrp/E5v
	 UAPWJNy3tQ2gqJW08kytjEpXtvyFQ5gkF6Kj1G4nGB+LQUCg5IiIbGGwGYzJQYQncMJia
	 su05MvJMLoc0d5+x/QPdpe/kmPS+12etXtTx2trvuYdwelZa2OhDD8X3or7RJPzPNNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=hjOHaqWQ6sDJ8wgH+DMaZcxbzn+Rl79vV6TakIKumJToMYdgP4j0NsiGrjFd5b+BihSo
	 EaL/ISa47/yL7pl+nf7p+W/PeZxKk2g4STlgzFZaUuXbj60CsZyY+QNmSxQ1i2Uw0DdMR
	 Mu0t7hrTZMsSQdz74xl4koU/UF2R1EQC6i4ljRsJKgP5eXfSLSUvRUQETopBjUUvU9juN
	 zYJEIkuEp67ZnF7dGekogNm7j+uzTOgj1jqgEDyJ8utnF/YjK30DShWW05rxJcv3gFSqY
	 SKYb1KTz4VH0hG0IUdTsQEYqYv1sCmBlIjPoTVuuCH7X1tfaSpk55epmJVSNnErwp3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6lnQyWC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C0606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6lnQyWC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984D41F01825;
	Fri, 23 Oct 2026 05:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733529;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y6lnQyWCQQ9jJR6zjMHmvTUEl5f0cPt6tvMHnXBspJbwdZHn1A4TFMyH6ZGHVkZ6u
	 b/t2wn95+ohTR6AwkPg6MkouV133hRICyFbhujmtbaZPF1J7DGI7ZnfhAgowJGlvoP
	 V3uXVcTIK/k5U1eXcGuxs/r109Ew3F9k12R9W0pDMc6H+NTsKC7RJbpc22fNyJ6vKb
	 XPIPNFqGRojLuCHdcTSZBw/O7CYeoHp2Wdtj1+0Yf2YlqSCMyyem+Vx/MOZb2qFRDE
	 evtFvdycnL5+bD/65X6lqtxPv+hddF1FUpy8AcXTSDmNH6SAbSeTjX/uxUZCq1pXMa
	 xWSV8KueP2pFg==
From: netdev-bot+sinfo@kernel.org
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] inet: fix established lookup races
Date: Fri, 23 Oct 2026 05:32:08 +0000
Message-ID: <179273352815.3327.7331304760385467089@kernel.org>
In-Reply-To: <20261023052542.3505250-1-imv4bel@gmail.com>
References: <20261023052542.3505250-1-imv4bel@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
