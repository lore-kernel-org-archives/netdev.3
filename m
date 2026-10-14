Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C1330B07;
	Wed, 14 Oct 2026 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946221; cv=none; b=n88gNPdnd47IvCPKzWxxjPqO44Z8gLocYybCKWqNdaSGkNGqk8ZC5/y2DteSFX03W9qB7AuEvGETI4GSFMGtFH/RYLedioxpvsxPmi38+S3xNaXj7rDDcj4n6wcTP1JQW1EFhygujAFbr5XbpczbmqGdG7lKp7pYecBmUQjQLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946221; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dke3enIYZ0TlXyddVvIrU9bUdJn5icpUiTWK0d5O1RHe1k+Efi55pUc581c1VuYdzQFD9nEYqPlRDZ8fAkgjhqCe6q0/VSkpgiZUup0TN/aR7b8vR9B4F6QIAQ7Xm2Qz/mqVpRL2VuIjneU/XocypVgDNW4Tl4UUbdeduQBlBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbj17N7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbj17N7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BB31F000FF;
	Wed, 14 Oct 2026 02:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791946220;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbj17N7f+0wMOFd2V6B1Cg6uDLiJUl7GSIYyuVvA/TZrm+lsaqnVK3cQ/AmPzxGgG
	 uSTvg1woqmlNRMX1vSQEBZQADvCUX7jirloyKyL5jfBdok680jmt67tqc48sKg18pC
	 BcvCjYuDshP08IpMfakmRNGlzoU0eoq1xldM3a666Z5qmoYHcv6Gff9HW1glyLt344
	 LTN46QnjG1EG3vcJglVTp1Vjic/Nadmf9zDb+taH5WlFq/sk0Xx0wzb34Nzejo5947
	 +knsolOz/czdKIPxh5Fumqg03ClZRjYQTUPYxAIxYUEMW75GKeXp5uWf60BZku3luK
	 XnB8gyfR8UZjA==
From: netdev-bot+sinfo@kernel.org
To: Wei Tao <taowei@kylinos.cn>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_fw: allow filter replace without
 re-specifying mask
Date: Wed, 14 Oct 2026 02:50:19 +0000
Message-ID: <179194621915.160550.4770507189079039972@kernel.org>
In-Reply-To: <20261014024548.37874-1-taowei@kylinos.cn>
References: <20261014024548.37874-1-taowei@kylinos.cn>
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
