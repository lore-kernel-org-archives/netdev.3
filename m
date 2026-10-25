Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896402;
	b=5i28k5L9rV96Lg5rN02b3VGVshC/bRUCZRqKTqu2msAMv2lKYxYf/1l7jz76EqVXZQxT
	 dO/RakXbD2H+BWEHzh+Mx5KP+ur7wjyGSYJVSPxMxyv8Qa9UqcolfU5GkKEfiLe1D1Nkr
	 atSLMjLOLFxC90z7yWUqrRxNJ2agYrY2kofp1IxzP3ry113bpGgRlLPeEMI56d3tgQkCI
	 1tcWdOi+QGScXDJqLmKoz0BwJIKgOur/W4v/Gd/Ly7F7pVVbclMqFzkKmfkcQH1V21qpo
	 7CbaazHxES7YmL9hLVnG4JYt6MhvwARfWs1tpn83Bol+X4oj2cczVeRsJfgYMLUlv2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=m51RTbqXi6UcIYEEn2oSWec0LQle1Gzwzd47Mx7KGJdfpmRl3vEq8h1OZwRCuwKfkoEL
	 xFCQvEKNrSy00wTSYsrOOrXOczPNU40bRDJ/inGhHvt9l0wTUTjbWZLVMxjpQ0Y+eGJps
	 vTKcehpoZi8VJyM+v3z3KgiyBTATGr+Of6YwxDLHHpDyv5fj7CvGS/4DZLviTg6ZBgnt2
	 Nhbl+nlt0HurSGybJI8kNo/IFfuKv+pXfePHk3LdELJpKuLXIk6Ygu+hiFkObfQ0C/sXc
	 JqJ723Nz8AfkqZ1ZFCBQ5Y6INFVXaxgL/KWW1R1iR5+5lmQKWOOohkWlc9Brz0IhamQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAjRh5AM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD086606A31A;
	Sun, 25 Oct 2026 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAjRh5AM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4A71F01825;
	Sun, 25 Oct 2026 02:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792896401;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JAjRh5AMSNdJc+ZRP9xigtKjUF1yLP54itCBL2szlO0JxUtmCdX/85BImJ+laSTat
	 /JoWD+bOo83RPLDpecvd7sVnFPuDLwUI+7JmJfGU8oMlG5H8UCzqxHkb1MDVbFKxlG
	 LsutyKn8ghcKlbY1oBlJ7zGuj7tvdirSxAh9wTLMdjYVeDWEj5fjWSumKKkR/lTvsh
	 v0HeIHSI+Ondad0cD9jPzFvwaWincnG0+CwAopQcw1z7QnMCkMW/mLVjNYxPp/D1tp
	 FQE1/9eCKm5nPizueWvNYfNWYhTenSmxUrZJaS3TveDAYXGnqxeNMYLAN4pAldROIe
	 VMAannvt1bROw==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: dsa: motorcomm: Report error when FDB fails to add
Date: Sun, 25 Oct 2026 02:46:40 +0000
Message-ID: <179289640033.3327.16079802308694610287@kernel.org>
In-Reply-To: <20261025024114.1955782-1-mmyangfl@gmail.com>
References: <20261025024114.1955782-1-mmyangfl@gmail.com>
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
