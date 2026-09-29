Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072D3DD532;
	Tue, 29 Sep 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687110; cv=none; b=qK9ql8E7mQ6fqLIQUsrIUlifKvD0YqI5IOalJnew6AAcXpSXdwc6HRPKt5jk5yCbpQqB4RBmZYbh/rsj2iMHyVggk2Aaj5bRy2KwFp/MyxSUU3vkcp5cBK1826aG4wg09+lgllJsLr3AxcL4lxfs605vj6oFWe7l7YW7EBU2oJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687110; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lk/3y/RIebWsd7slh21dxssdhx8YhFclUbmJjeKSrd9NkTCWRoJ4wENzFV4V6FLp+O3RWbl/qreRmPuTp6/6vkt3quRQEeg5DOPhQcpIillzjFZ8wY6zhLYVdfnaImi+VqDNtOgX1z/l6zrg/G5ZN381is8LA6M6D4gsaF//l94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI/ex4OH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI/ex4OH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44691F000FF;
	Tue, 29 Sep 2026 13:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687109;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XI/ex4OHgun5pLofE7sUM1FhTfPcjs9ri40FacKHgpgoR5CfLEqpCFUp52ngD44wi
	 WGZLOiHihsYubQUz9Rvj3ebE67MtnJ7baJijtAbOunIvOzyfMGQh87Dt4GGbsv6R4E
	 WEK4sxwo83W5imovDU62CDxmdoHaZxTU73DBkd5yGoMVFampZSUyXZ6le4rQ9SJpeQ
	 weCbQ5tV7t68iUEWJzg1cYljWM8PLC+gkjrwY8w8t0kvcLF0MA924ifznhTUHbJhsY
	 kCYkk3oTFU0o22TCtP7Ugz+Udb0yv8YLNgevinMjkz14srirOXtE5u8LaOPDUOwP2O
	 xBdQuqafJIQ4w==
From: netdev-bot+sinfo@kernel.org
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v4 0/4] net: microchip_t1s: fix collision
 detection on PLCA status change
Date: Tue, 29 Sep 2026 13:05:08 +0000
Message-ID: <179068710834.31693.5197444123173344784@kernel.org>
In-Reply-To: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
References: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
