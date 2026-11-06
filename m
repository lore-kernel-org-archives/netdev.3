Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945889;
	b=ufJFpD1f8oG9j0Zn4x1XOMBcV5fYGu6I6fqVF2BLzYhqiWJ1wM5GfqqTaSWfXhVjMkuZ
	 nRrPKibMZrdrT0JQ+zN5YnP9Rx6ZYTgSpSntEcK3XVlE4ZZ8K7+cJZF2PqLnIPJEw78ZK
	 SfUlEJ9HFQBZKmltRfiENAIYefiTsmhIeIY6kijQtogbdgID2QsHv7F57x+/D+cr9vmN6
	 xafgbUkY9z0UG5dti+vt9b/RvwWVrzt3Patd3+tunYtw11ufBHSFcHBQaEJfqfcIijegs
	 i/kqqE/hy0G1xWrw5mWxCUNa2jwn4bqL+4Kd0Mpe1m1m90C59T+ywRgjmdts5YPfi9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945889;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=IgK88CFwAxb3EJNEWPjrcmCoYDCSlXtyqeEKeoPMhV9HR30IA4l0wVUrxXSTlYOAn8WS
	 /W1m31P3lGGBvu+YSPtbtuOhmRk8HY2dM/P0KNp+uRZOYhIYb/b8m57lN+4hipSwzxx5d
	 j4maq5gvUD1Vca8VORdPtYaUQmWNeDxvw7sS5O29ooTCuojf+bEAk4edQPL/MTBcpMljf
	 gC7bT9kZ6MwkkJ+dDBEfjLAKQVmyxyX3t+ifhkHb7ZmLb7HlHtKSNiEeA1EOcyPTE9n+6
	 mrtXwzL7BfiP+hT55/cZaeTPEI136u03evsbkdDDa0zETsK13peWCzlJBk+iVqH6JWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UnL/Z1Ur";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF5606A326;
	Fri,  6 Nov 2026 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnL/Z1Ur
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879761F0089F;
	Fri,  6 Nov 2026 06:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793945888;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnL/Z1Urfj4X76rNw03knXm01F7GGoLDKgmB4JrzSJr83GzPyGBnQklsnO6OQvcbi
	 JUBMG6QFXaAStUtQC+EuGCx13pHY3kYX4G8aOH4I1TZQnRBljivrR5BlGF/TiOiv4l
	 TnHMD3NVCpxHjZ2yIw9qZX4/vaNtajt1q9/DQZLy5BpGyzXfyFcQuHxWdmXzt+zb90
	 x0EemoZtZP0rEjkwumElPRWoVvOeEIbkgbDdwir4mSi+bsbl/Ir4ApEt+rHV4jL38X
	 N5vWebA/VXmwdwj4tv4bu5G5oLC+2/QqosTZeindJF7rdk+iHZMMng7vxq8Td2EQSq
	 fevy20UDRCCAg==
From: netdev-bot+sinfo@kernel.org
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Zhou Shuai <zhoushuai28@huawei.com>,
 Wu Like <wulike1@huawei.com>
Subject: Re: [PATCH net-next v01 0/4] net: hinic3: Bugfix for later patch-set.
Date: Fri, 06 Nov 2026 06:18:07 +0000
Message-ID: <179394588711.488859.3460474784447366028@kernel.org>
In-Reply-To: <cover.1793946318.git.gongfan1@huawei.com>
References: <cover.1793946318.git.gongfan1@huawei.com>
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
