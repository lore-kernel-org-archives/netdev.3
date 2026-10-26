Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004993;
	b=ppXe400yvtV/G8OWSU4eL4R7oKlgZYomGebGMLI7SWEow6VTtxCPhbOsyJptLp1CBbp8
	 UketrXBOKKOzNCYxV4ZQc4Ue2xVLptvd50uRcavoufkvopns6oaOgZIztwGHhbguMHIPH
	 EH65XnAKfPRPewfpveRmc1v/ZSh9yeQhLSkOLCSWABI3I5pOuVcPS7DGFgHaTB/mgPso4
	 R9VaoFyIPdKs5dPu9tGbdltxiz0Xd2SAeOdN9ulNq4w8XW8iWB3YA6qDegrI+FiMJItda
	 r5T2vireoS4r+fH5dz9CWqrQt7KuJdx/8uiblO9X+aZyAPT/dGWxI9d4/mta+/v81dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=xzHfVc5k+Wi4j5wWDYsGEF0xVgqRFt4YuOVi8uy3ADPhWMJNVKL+8liLnVplSVkIrnyS
	 8fLT3z2DAckzV8xGarRoxh2uknzKWlro0UHraW8A/38CMnI2RI6K1GeSp536YZ1V/sDrP
	 ksIU0jSGopyeC1tLovxaLukvRQFthwLDV+F5xtxv2/a1U4gGOZxrlv3X7Q1xBTyB4lUTB
	 ioeUirt85yhmLM/jW7a8FXgzIjHWKLagYIGuNvXcd04f6/CS83MkCAr2/DHSBvXqAXfo6
	 BanQHx16L+/U85q8bJTKJFXwxiOeHR2dKjpVvgq0EK7yiuiblxOTnzjEFNQAWXeQZVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deKM2usx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA9606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deKM2usx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4441F01825;
	Mon, 26 Oct 2026 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004993;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=deKM2usx7YptNPuS3iqVOUudK2QUDFABxD/pdlCGBtD90+xKEBUhew68XnjXLcLR5
	 5F32zLh6yFreanZKRSWZvSDmLU48FeUCiOyCW5AViw0OV0aOgslSWf3C9AMxl37f4C
	 TT838u2Vd+ZH8wB2UHlTGBXrkPnwFDeiCgeNgB7OBUeK0mzLJT9HeHZ//A0V+aEBRp
	 mFsEmoxMPcMWiNvBHXqfm2YdM/mXqns4bb/aLYJ0EdnNcD7P6ikDhITEDOX6lvAffz
	 dmMIRW7S21Ps2syK7N48C+l/SWJBOzuhEmDpuU+umlY5IXdxnMP0W4yJrkgEMkGDXZ
	 /SnwjjTWG29HQ==
From: netdev-bot+sinfo@kernel.org
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+a079f084653164a652d1@syzkaller.appspotmail.com,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net 01/10] batman-adv: avoid WARN_ON for orig_ifinfo
 allocation failure
Date: Mon, 26 Oct 2026 08:56:32 +0000
Message-ID: <179300499206.3327.5380876117216211782@kernel.org>
In-Reply-To: <20261026085309.1074911-2-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
 <20261026085309.1074911-2-sw@simonwunderlich.de>
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
