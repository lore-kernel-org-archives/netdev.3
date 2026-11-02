Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613589;
	b=wqTaW02VDiuNn2lxsku6sqs1H4CEtgpxuwLGouNbwbwHfdZUM2e58wxMa60XrJYXrVAO
	 vhPh6bZnhByUTnYzl4i8kvi5IgBcPP3Nh2I+jDBsnHJ1X2HHxgz+TjfC+JiWej57LugIv
	 +OJE6p0BSimvg818mULtVBytfrfvwZmCbRzIQvOTrjdW3eh1wmLYbcJJPgqbTl32bxmvV
	 zKUQrobni5RzoTRbcG3EKt+1liXcjAkGd5lyupDFOqPTPpoC99p2TTCdU4xqVrhu12Nv8
	 rNLOZKfBdxhwrnY4TOS8488lYBH3xuduRgy8DKQncTySBnppCqU3RdDghInY3inEZeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=oORZVrZEydjMA6tiBhyUUdWMWIRvqtnykdAUHYy6Rl5UjZwyqKX3rUhuHn5m5cej3JCJ
	 +2ZnvhQaQ2+QASReWnRO9GwYMInPf5/yiU7OCGQ1o9dSUxU1WW6XwdqFKVg0hyNcbDb7H
	 CTJ9FIYVeUL20cY3MVqilh5p21pJJ6U/qfR72bYZdwaXEXJtygPndcePddBmjvD4YsNbQ
	 J7JyFgZpxusmyi9b1olTeBnr8zVMdNHEbBuJSaf+E1UD/DPOqlyEPvjLWUmpQ43yfZkyD
	 W8V6xbLXy9U34Je5f4Gx8lVeL6Vc69NFzBWr9wc+BwImYMj9aBt6o7bunyad7/bO3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rpz3CE0Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAD606A326;
	Mon,  2 Nov 2026 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rpz3CE0Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F0B1F000C1;
	Mon,  2 Nov 2026 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613588;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rpz3CE0YvWkxc1OsW4Pzoxv8kaedPQnBzWqvlmSTeRxHmAJbIrGOVPM7X25Hv3eW7
	 lhStSQ3/uA7UU2fBg9dsjFKdZXc42bTSTWeNX8CqFi226aYldQwYw/+pBeM//z7gq2
	 dOSUA60aCscFCRKl13Nn2mjZFc6b1T8L5j1GEGZZC+LHwIfLa+R7vX9BxzpTwPy9CI
	 9V8rirpts2yZD6Vf94RWDqaNvbi4WZ/BsjpaU4Thez1Bkwb55wrEujjoo1Qu1y33BN
	 45mjWJgxZL9m3vjzsqiWZQuamZbRa/izHZ6Rqc8Eqc8SQaExvQT4IigFp2bSe79B8g
	 9MSHq+JADV1xQ==
From: netdev-bot+sinfo@kernel.org
To: Binbin Deng <18983559317@163.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v1] igmp: use copy-on-write RCU updates in ip_mc_source()
Date: Mon, 02 Nov 2026 09:59:47 +0000
Message-ID: <179361358774.3286.9761157750904217907@kernel.org>
In-Reply-To: <20261102095312.47767-1-18983559317@163.com>
References: <20261102095312.47767-1-18983559317@163.com>
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
