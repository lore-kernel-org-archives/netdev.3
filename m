Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79E3B6BEE
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880784; cv=none; b=fzDWi+mk/59shNrQ1CIh+AHZpvkL5fh7AVI8GYSpWihG477pB4pVWCc69N1O8xVcb2KmWp1x/f3904Kp0sD8MgZA9FU79s0HI60SByKqB7ArWcKfCuZt4r/fOli5RLJpb2rG4HAG29KMq39V41q++aHZ5J3/HUjPYbB6zsGasbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880784; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMpPXjp7Ie8EYNs/Swgans+1xwpcmPRie7PU9Y7qh6IGVw19NprrB/LHojEBijLdwZ2gq24GTe98XXCszanJyQn5oIpHiEMBdjP+Nl+xSGMtiyeUtd5g2t/Tm/MB79HkMNskhE29WclzSA4EvoHa4bw7NWP+322Lu8T6m8u9gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrwohV7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrwohV7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8211F000FF;
	Tue, 13 Oct 2026 08:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791880782;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrwohV7eYCrp9x4bHi26J08n/WJNXDBhz5D0RtG1q4sYVjdXlb37Fpbad7yg/fwgk
	 BpVwQoaJwOLLHiOqQazd7vVA1Cr8haztYYb7VsL5v0jSe9G6R2zM1tXxCqohO/6LCe
	 7a0D1KBEpNmEuB5wm7Eqdp5HbDGVLz5YgYJiDT0MU0lCYLBGICvX6NMlq85gSDnpG/
	 z3X9U12eLshKAg3Ho8tJhPIJoVWPkfQPy/mZSXO1MhfnNbgMBcG50s0SRBugFqZRwZ
	 uqR5KrwBOBfNeSk/Xq95yXMx+aRvVSI3NuGM3nQS81QTEQIw1nbGihfvook7NbMTkG
	 ZnqoeEDOxsgVQ==
From: netdev-bot+sinfo@kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiale Yao <yaojiale02@163.com>
Subject: 
 Re: [PATCH v3] team: reject CAN and IEEE 802.15.4 devices in team_port_add
Date: Tue, 13 Oct 2026 08:39:41 +0000
Message-ID: <179188078132.2527009.11908657524993056251@kernel.org>
In-Reply-To: <20261013083523.4728-1-socketcan@hartkopp.net>
References: <20261013083523.4728-1-socketcan@hartkopp.net>
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
