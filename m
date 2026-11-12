Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486011;
	b=dIPtGhC2FDWhr0y6eHod8embQRpNyIwgp+oy8zPDoUhptWEWjhIt6rBnha1FIgWCSDwP
	 LbCISLhVU7yjAFTQmnaxCFEJLCZSXSJxw00y8wSjTPWn1KU62qNy9X1KpBC+RsXyJDqBi
	 RqZB5GI1tQwbeWoOrgh2vQBADX37zverbF+d8wTOA5oJS52J5Z8o4YS8xVcEwcvANaqhI
	 AJ6oJV111CAYuxvwBEXjmW8xz1hQy2nIDlXYkpNGdzDGH5nZRocR6nYKralUo9wP5pasI
	 7wUtE8btBcoG5FGCG0cf62a8fas96Wy8FMAZRKOH7W765RN8lAquIc3s6lGBjmWsbvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	b=LzksKksyGxwa12t38vxb+YqnCAy1NErQVOtYTuc+ChZA6TIMJV7Mw8SIIRfzeRUfTWOG
	 hT5Xp+PlVkxYn5Ygi8+Kq9uL7oNDCR1xxsnozM9hE8eE/Z4cfmZV5FqO9W9DQ9+WM0dI1
	 y741kVqL06ObdJQQkeEDHv1tsFKI/DsltDQai3R6WN94selWzRU84ExpiyeFSNDALx1kK
	 bavPd4detxh+14gdE7MeAdy8uRUXgJXjiqh9qDdIz3OWeN9EHncantq3VkTNdOUCxpFQC
	 az32zRYQpZYqfpKMNnRmzDZ1c58wIZwNmEgckd3/u+H6DVODwDeBZV2UeNEua7e6wRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQfVpejc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E9606A31C;
	Thu, 12 Nov 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQfVpejc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A930C1F00A05;
	Thu, 12 Nov 2026 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486011;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQfVpejct8QeB9NZ51N6O1V3g3ZH9YkXem9kxeyJJoa5NC4cRIHuT9QcieiSfXDZ3
	 N+uChjN6O+l/RER049Z/eCva2FzVdiF0w6PUZSWi+b4x4pHJGivFS1B99wgp6dQ9lu
	 to0w2fUuavUq+f1LNFoc8HGk1RYeUX6BWcEzi7iVrjCiLMxkaXsXh7CGi5HDpBUh5o
	 narHMflWwgHSIRIydIgXJBIdUn7tHQJagFDCo2ccNQ44ISNPtCo99MBN59mHIuDvec
	 9ERC7m0Nip+ePwehmvVI926wgohzGg4K2zvH5U8Retj2v5jV+pISOg4A6js/kcr//V
	 7TJJzreLmwWUA==
From: netdev-bot+sinfo@kernel.org
To: kmahammadraf <kmahammadraf@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Satha Rao <skoteshwar@marvell.com>
Subject: 
 Re: [PATCH net v2] octeontx2-af: fix TX scheduler queue index width for CN20K
Date: Thu, 12 Nov 2026 12:20:10 +0000
Message-ID: <179448601020.2168702.8636848899122995799@kernel.org>
In-Reply-To: <20261112121907.2576520-1-kmahammadraf@marvell.com>
References: <20261112121907.2576520-1-kmahammadraf@marvell.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

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
