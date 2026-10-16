Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5C372661;
	Fri, 16 Oct 2026 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153997; cv=none; b=M78xZc40U1Yd7s42FTHQ8pPSmBm/lZ8mLeTTkxZZmnDZob95QYaJ9E//jV/U+4hB3ccz9m0HmDia9TREzOrFZcaB3y5MXu7uJ5uaj/rZf6zb83iJMaAUwpQAAW00zVcEWsv2b4HnoBemf7XyLXC8vWiRQIIbPuKjIxSExVO1m0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153997; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UCk2oPl6mYru13Yz1n+iI5fy6vvfiKIkLBYnFN5tVglMAhUtNWjmsiYT2v78tgbq8eOq7V2/L3cJtuWgSd3KM+961V6+94zwc/zmQboU9TEEmrBmuOpEVe7FS5imCjjEbywZB8SQTL3HVI9dMNlEw3M5ely0aB0TXSXYpTNHnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OruoWfqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OruoWfqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B331F000C4;
	Fri, 16 Oct 2026 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153996;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OruoWfqZER1Y2T+X+X+XuXTS1uINJ9BmN2+2SLwsQso8J/bwoEmyD2Fo9OehxASi7
	 qmXNE8UJFwhqo8ZMfMGTYvqxBXZKUPX3oYvND08/TO+Ve1Bf5cJd+pdI69KfC5drx1
	 fUWGV7DLen22QOIndJcda3LzY7Il2OHtlVL3VArSWAW0E5cslv+02tNoZrsqqvpb/n
	 g5ixxJ9/vPur/uIP0YIRo5ljQQIJZ5O4e4eZxhW20MZGgS6e4/43y7G8tjDfaQ8xjh
	 jtlUd3MgxUqqtrfJZmYK7mR/Nu+8H1lk5BZgSoZv0cP0SX3kTodyA7RHawU9H950U1
	 yESwKZ/rnarmA==
From: netdev-bot+sinfo@kernel.org
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com,
 jakub.kicinski@kernel.org, andrew+netdev@lunn.ch
Subject: Re: [PATCH net v2] net: usb: aqc111: fix set_mac_address return value
Date: Fri, 16 Oct 2026 12:33:15 +0000
Message-ID: <179215399546.408196.15392554197182186644@kernel.org>
In-Reply-To: <20261016122944.1889622-1-hanson.wang@ugreen.com>
References: <20260703073936.462231-1-hanson.wang@ugreen.com>
 <20261016122944.1889622-1-hanson.wang@ugreen.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
