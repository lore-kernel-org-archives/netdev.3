Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730530567F;
	Mon, 19 Oct 2026 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792374522; cv=none; b=Br3AIROwfqc53SHLNAxzpjmaZIPV2VIBXJv5rJvTjLLeVKXKcwPZG+wzXqQFd+zb8NhNxD2eEpO0KJ3CAu4Px0kCekevUq8sfwyASUp+r9Xj2IK3xe5ZP1n7zKI7VX0x8Z9XlwkuWb6anEWmae/mhGNOLWedaiKkC++Is4swim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792374522; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9/xSMHoU3/RGwxU9IhJ614JXy+ERJVN0btlH2OyBiZJE716OKu3ZUBKTPSSm/ycnz5C9umB/40h6ZaHc/EhwOMxW/vtDlSkVVdAyv/4kfYJ68xe582LImc6GmLW5V3muYqAZqe8/9vQhlJJGsA/3qSVxiZSpgcuHjVq3l5FPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzFe2TbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzFe2TbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6091F000C4;
	Mon, 19 Oct 2026 01:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792374521;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HzFe2TbVFtMXuis7RIzvxMVRknSmiMT8Bisy3a1uvlcbjCCKS885ncZfKPS2njeVR
	 9dRNkndjuYqzQbxg0iXn06o0Gk2Ry14ue3ReCLrJNlU8Ork72cLfh8n27am5v1Mf9D
	 7HvAL7Kc8FHOG0OOKwf7tozS4QAljSf9bKRRGXHya5Bgm1rajAyZEUaA8NZgvj0Su0
	 o5UPax8u5HDYQ7Rz/V0RKVRRu5Ua31XxMDohPOFwok1JL/GGkGq8DHYK9AalAosFC3
	 hH02KP1+Qlh45ax7ecw/Poz9kOYxWSszzlI32t7EyvHtBSUBDlpi1JZJhjHMZrvfQH
	 6t/uB6VBMsLIA==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: ag71xx: reallocate rx buffers when changing the MTU
Date: Mon, 19 Oct 2026 01:48:40 +0000
Message-ID: <179237452010.3290.14331369140080870388@kernel.org>
In-Reply-To: <20261019014438.199718-1-rosenp@gmail.com>
References: <20261019014438.199718-1-rosenp@gmail.com>
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
