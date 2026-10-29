Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308395;
	b=tSa7lmaCqsr8CXipdpsCPdg6KW0zoOBaozdhX7IJpR/WmuC1ZMTneTygl6EhJet1tUBK
	 bsTa7lIYUH/xPnrpclr4By60cfNfeysW3eqrH34JldJoGSXIYmjesRNkf67OwydMmy/oM
	 fPfOi32XIfPDc00QT7IqW5mEuosUGNGcoye5DsWJJNB8nNb8Pnn9IC6ujm1jeaI00Hanj
	 C1E7cUm/xCRnKkZFJa2WQ9qFGx1jMEv7/YalxE/dQANiZ1cbwYn3IUkszD/tigwKnljtx
	 QurYX12NVMmrm1klXGgOhzinfGVVV0Ibodghxk0AuOdiNv7o982+eD+d9WEFk0w5T/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=HPThWvgxbUD3ds1cYzd/L/KJvxhH6jcm5lqOl/YrvQA5Jp45hwr8IBCue/HtEtSP9pdX
	 eRE/T17ZHMF/PeuhmOL7T4rpp6cMJGjhOye/f7e4dq3uMJn53egmwqqpo/AANd/NagVt4
	 ekiSeBa360Yu2QKPGq5WWhcwUyGHiy+a1nnt1TNazxJ6ua3r1L30D2pHTpiERtwqSVpAl
	 4mrCM1V51O6ftsFfI0DLzz+WY4dI7NAe2wBW5lhrNpEuRRFODMfhbWBdetpF+bWAGvr34
	 qxjuYSUn8PzpItFniR7IaTZxzbENOzkZYqAqXAAHz/D2qsmCkfjHeKX2Rc53tWTKUEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3iFnWyJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DDE606A31A;
	Thu, 29 Oct 2026 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3iFnWyJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F83B1F01816;
	Thu, 29 Oct 2026 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793308394;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3iFnWyJkY8vxNCYw7OeFJTJ41w0vyJvNvF3zVLgeNRn9cgPOBPxnPXtR9ma5fi/y
	 MTmULlBE/xb2m15sUJfg0oUY9mSqYw9eCviK4xi95PS8Kr/QIcaKxqXPAMUM7NJeOO
	 bWyTI4YPRG7UFP3/dn+esbUsuaTW8aSngaBUbzIi1rbudf3QbOfHT20PBQX02716Zy
	 PFtafJx+jHNcsGHX/lczCc2+soaQ4kWsEHzE2cdjYjus/7iUuIex3viNtzxo3J9Zmj
	 IvFCJGwL3kN8a9Ucbt4Zxd1XWiUOjxmyucAZIBU/JaRjwRz4OHFkoe9Ifm2BIFDj0A
	 oux+cbojPQ4SA==
From: netdev-bot+sinfo@kernel.org
To: Joseph Kain <jkain@nuro.ai>
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v7] net: stop defer_count outliving the deferred-free list
Date: Thu, 29 Oct 2026 21:13:13 +0000
Message-ID: <179330839362.3327.16138152744448390378@kernel.org>
In-Reply-To: <20261029211101.2089535-1-jkain@nuro.ai>
References: <20261029211101.2089535-1-jkain@nuro.ai>
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
