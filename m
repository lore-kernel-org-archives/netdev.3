Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF333932C2
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574823; cv=none; b=as3POLt84tcatBR8hpkdOSRPI0xoI4fQWnGWzFO7JaVoxrFZNCFoEBUgSUKIgxZ+aKA7Bl9Ckioy+DhHDzGI2t6+7RteXtiSxHQllJufB0TXzvr5jejePO3/sVv5SyZYyd38xkDDSw+wSYYW8ag5m9P5nIFwV4qoJQcF1OnGKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574823; c=relaxed/simple;
	bh=NhVrjoUHEnqgnvq9OBSW6rdlyplSSVdxwipryYRd/TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWLX8A20xAM6hQgQvsetJP6KFo5GkC+f1KL1L5RAbWNVtqrMuEuyZMR7b1wkhFaSZibb2QM9TVTK6CNjHMbyVTXo71h0yItWVQeOe8YPnKFgnLZgEU0cRRr1fVT48ijbMwKXXs5NToeaook9UNUsKb0n1Wlmc39y1n9EVAnT9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2Ca7nwB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2Ca7nwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974C1C116C6;
	Tue,  3 Mar 2026 21:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574822;
	bh=NhVrjoUHEnqgnvq9OBSW6rdlyplSSVdxwipryYRd/TE=;
	h=From:To:Cc:Subject:Date:From;
	b=D2Ca7nwBFPhSb04gHxq9R8AcxobaWKSMXnaQbfvJ/FF8YafM4jrFonTqLDEaD63oX
	 AEIM0djpqscBFFeoszwWEohUdL71E/TL/LkCwY5rW0yFDRgqTQzV/stXli8nttbhqy
	 fNNlfbwLHG8YzASjpk1Ls6owuT1OBDWGitSnaFqlq/I0w6UytDIqDUE6P6PE3SozGg
	 EaOr91Um3BRaLUfCfgGKIbrgXbDmPEwDgDrUqk+vGMG+4ZMJ02sfNKuYwCPvGE40Bx
	 b17Cp8Dnm0d83SZuqUBBtxtZ3W7MO9It1LhL8Xf0DmAExp0LMPZLHDoNiOrWtA5cZM
	 ubC/cc+dL0lxw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 00/11] MAINTAINERS: annual cleanup of inactive maintainers
Date: Tue,  3 Mar 2026 13:53:00 -0800
Message-ID: <20260303215339.2333548-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annual cleanup of inactive maintainers under networking.
The goal is to make sure MAINTAINERS reflect reality for
code which is relatively actively changed (at least 70 commits
in the last 2 years or at least 120 commits in the last 5 years).

Those who either:
 - were the initial author / "upstreamer" of the driver; or
 - authored at least 1/3rd of the exiting code base (per git blame); or
 - authored at least 25% of commits before becoming inactive
are moved to CREDITS.

The discovery of inactive maintainers was done using gitdm tools,
with a bunch of ad-hoc scripts on top to do the rest. I tried to
double check the results but this is mostly a scripted cleanup
so please report inaccuracies if any.

Jakub Kicinski (11):
  MAINTAINERS: remove Johan Hedberg from Bluetooth subsystem
  MAINTAINERS: remove Manish Chopra from QLogic QL4xxx (now orphan)
  MAINTAINERS: remove Jerin Jacob from Marvell OcteonTX2
  MAINTAINERS: remove Salil Mehta from HiSilicon network drivers
  MAINTAINERS: remove Sean Wang from MediaTek Ethernet and switch
  MAINTAINERS: remove DENG Qingfang from MediaTek switch
  MAINTAINERS: replace Clark Wang with Frank Li for Freescale FEC
  MAINTAINERS: remove Jonathan Lemon from OpenCompute PTP
  MAINTAINERS: replace Taras Chornyi with Elad Nachman for Marvell
    Prestera
  MAINTAINERS: remove Claudiu Manoil and Alexandre Belloni from Ocelot
    switch
  MAINTAINERS: remove Thomas Falcon from IBM ibmvnic

 MAINTAINERS | 18 +++---------------
 CREDITS     | 12 ++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.53.0

