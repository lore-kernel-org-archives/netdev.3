Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295584;
	b=fMXTvEdnQwzt9S/eSr6exWu47T9d/X2GdLdRW6u4szLgKHH+HD7HxuSiimmgjRD0QslS
	 t3Rls0ngA3FM48pFGIfwkwrRinuJ3LDbXAE3b83PwajIOfAlB4rl+9DSR3R9uARnI+dsr
	 xtcT813f5vA0m6JSOdUUKCiPFdKyrEkBn5XOVNUgzMIjScdAyIaB2O1E1oAZ3xTjrL7K0
	 4XXjzoNpz+JKczTQzU51QpSly8AXMts1K6k8pqabYkWkBNQOoYI0HRhiqVsXeaZHK0uSK
	 6b0ICskSt6cjKUw5uxOfxQ7bxnmb4ZWTGM0AYuWshXhkcJx3PwymTVQ4CLDuqMFIFJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295584;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=KcQCSoWUsqhtH4oZRIUkp+1SLMOyovEgQ1hsRHq2HuYR+q5U/xjUKxevaIvvMpORvSB7
	 NJqFBhiYUdfEom91qzXvhcX8kkLmfkqW78nKOlfmgiPbWo4ik9BqFDT8GfYPwd+4ck7sh
	 mrJiuO322IeR8cyppe8OZtGf0D3Jr6YEYu5Zfz99qtEcCmHvLF3EDjtarFKHEP+M12b2k
	 IC8V0EfvCy1e0t1RuHdQBoJtol8CON+4NTehElzEA3fJHwO3RY2N6ybLeaYPBZSwCUuPF
	 PD2e3snWaalJNhIGQN0bqpffNNwytUoUy9tBA2GQvSk+7YVR9TFqtziamACRkCxglVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6OyKl3z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9D606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6OyKl3z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50DA1F0089F;
	Tue, 10 Nov 2026 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295584;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V6OyKl3z0PDI7PaoruCO1+uMQTqbYbeQD3nFgrEBdGj80dzvMUakvmcXeZn2ffU8v
	 WSiDRtDGI086F5xWIbm6urSV0EmBsOZEnIpIVBOIS2a6Uvs+0M/GEBc/SURM3EFIDB
	 YgrbPXIatyu0oqEGHj1Fin5x97V44HG+H+02/nmHw7XQefHsQ31iGZ6dEeUwentbaS
	 RzFay144DTYbZXraD5dXd/VD/cAD9WRdPSUs/hObNpMdrgJ9qqP3motLXqugvWOe3g
	 Y4WqCeJEQtWlHNf6+HGOxEObApyAAdz9c5aA1HQ5n61t/H2eEiiZi3lJT8WPWjnesl
	 lFH/Zr9k/Vjmg==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: 
 Re: [PATCH net] vxlan: annotate lockless accesses to rdst->remote_ifindex
Date: Tue, 10 Nov 2026 07:26:23 +0000
Message-ID: <179429558345.488859.16534342073147950836@kernel.org>
In-Reply-To: <20261110072208.3273638-1-edumazet@kernel.org>
References: <20261110072208.3273638-1-edumazet@kernel.org>
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
