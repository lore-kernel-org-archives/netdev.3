Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560002;
	b=lbWv3NElyKD3/fAlH9xeMoJ6/D8wAPt1jfnsf8GeWFeKqNUmFAEbfn+iG8rDw3s3AVon
	 /OrWjo2Jq7t0PxU0oHmpXtQr1IWBMWmynxzS8ghjDUDbpq4mLohC0ML3EW5+cJJUczhYD
	 UMcQa3nFB3V+6fCE2qqnclVC2Po65Oo3NK5yOLg3k3aOA2t6Fgf9MOnrZCS2EMXXvkefm
	 egPr3GL+uVdL6uBjv9gZ4jcET0L791u3bdxn/DEsm2I2y3rJ9spWq8NolufflVNOvQ9G+
	 7OywSQYZLzgcTsiOhShMRueqKXQCfYEGzcxmGmlf/hMwghNvvE4UwrqY2ISb7JCeoVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560002;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=NthsXnJmgyc01bSTzRUw2Ng7eIGlb8NF8gcUsSvcI4biBw86VeNgWTuyqAVb1UXqKXfj
	 ruOHXqJZHAyc3B2LLTyMgqbIBkPWr6a9PjyTRnRyZMFXnK3vLA9R7L8wqDUfRHINzbILQ
	 h22CdwpHB89hFiU/jeKvYvSGJPDJfv7twSyxc9hPbsie5CYmFfEuNbSJxQLx4Q8N/NB0Y
	 +qtrkjPNzIR1ydQ/+gIMGayCvL71pvEe1mLlys2lq7vUAe8lTjujy4+uTYLFNvsFbsF+O
	 hLh6p6SIECqRhnVhY/3AiEBCdA/+ruIhrH30BxUACiu8PWfiLy9Cg8641IOvtQwg46g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgQDr6EM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63E606B214;
	Fri, 13 Nov 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgQDr6EM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15191F000C4;
	Fri, 13 Nov 2026 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794560002;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UgQDr6EMtQ6ZE/uDGyY5+SUO48QfnI76TDhYobRAS7x4GPpSqMw4jdoPHGd1x3l49
	 FHEJO4gXucqdRYctjUz6Z6IOcRmJ6hhea4pfVlHIq9kj1Eky3DduvtWpl5YVOwrZVp
	 cDcsP/3DEOc9kZMPfCt+2kPxio+QDXylyCs1XX/7/Kyw54Coie6nLQrS6pA0C1BrB6
	 YDYje5KcR1CMaRIfn+NscxpijnnMD7AxUXJ7dW7Q2xczcyCIIgg4QiB38t6cLMYMIf
	 O0I6FsIct4xKgmV7tYhWaJKXgOstQFGGyQXbC76OCuPwwm0nB4jcJOuhvioe4z1QQa
	 PzMcWH+1+wbiQ==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Chan <michael.chan@broadcom.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net 0/4] net: phy: restore driver state after userspace MII resets
Date: Fri, 13 Nov 2026 08:53:21 +0000
Message-ID: <179456000126.2168702.17640123049966028359@kernel.org>
In-Reply-To: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>
References: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
