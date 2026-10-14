Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8058318EC1;
	Wed, 14 Oct 2026 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990769; cv=none; b=G2EWmRVqJhmglZM4cZMRp5B1eX4YO4aJuF/PWKfh/0CD7frUMTku3/7A6OIIWZ7XZq4xXnTHn+QCTlpEgAVJID1xjdIKPEFlOHcpD/ZRznghpSe25KA1Ir83zfTm/LOArJvjJV6BhezT4jtLm8qljIT3qsC6v+z/dtYXcuSmpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990769; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b4z8rjSQDypjObdSbh41IiGac25uPO0FAuSPQUvBnVRqw93CPdlXTRpRu6Aqr1dfWtoz1BtiIPXK6cIrWxWlcFrmKA2J2ZWuckb6gM0InSIvvHFblaLeAEoPgsY8ZGFgyBqO24Umgay7YZCsNTt00A0qA/ImRlwEz4KCy5wfFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bk8Q20yI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bk8Q20yI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D021F000C4;
	Wed, 14 Oct 2026 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990768;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bk8Q20yIyNo5kG5rdz8OFJOYxT0iGkJjAbNCy33IR7ytZQ1nCJmUjw4qjEVhWP4NF
	 1SgQv6NjYAH1VtEdzJ36+Dym7Viyj5jbunKCLwHtJW+7sYWFk5ECZHWj+GKo07RWbh
	 FrmjMZJnXX9M4KMwYg1c1IpRJUK61pf5NMXO9jSsAhhlQIivuNMyrELUDmdrB6Dx5V
	 lwq6U1neqn6DODYTC0iKszN0X1PHy5qkZxKbdkT/UWjnaFoVLN84BXa4MeG9KalUGW
	 K/CF/+SVIpo6Z0Az3ih0hqiaT305jofPPL6YhWmD6e7sXmOHqruSNRk8jmeN/en5Yb
	 WJLHOnoGVPEsA==
From: netdev-bot+sinfo@kernel.org
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, deeb.rand@confident.ru,
 lvc-project@linuxtesting.org, shda@confident.ru
Subject: Re: [PATCH net] sfc: fix NULL pointer dereference in
 efx_tc_flower_replace_foreign()
Date: Wed, 14 Oct 2026 15:12:47 +0000
Message-ID: <179199076705.408196.17037934984445050727@kernel.org>
In-Reply-To: <20261014145800.726-1-rand.sec96@gmail.com>
References: <20261014145800.726-1-rand.sec96@gmail.com>
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
