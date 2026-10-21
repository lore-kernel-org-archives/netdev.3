Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585203;
	b=i0nPKhr39W1YfC28eWI+HfhxuI919K9w93UnNPV5/Jiy6XBaGuzfMcIaxwse08/Yc+8H
	 uNzoNqF/doB0LU0wi2uFrObKhCCxTj+jzfPmlYemgxmpVr/lZwRjP5xmEc3urQq3zRko1
	 yk/nYbgiL1kfJeIsLVDSGTdRLG6oV+8726gHXVDVk82+3PvU5JgLj9hlJ8zqEt+VwW7kf
	 nZlsuVKkl/uFmu9sHu0BCPnvhZgFNog4zdKfCgIDf/vN7xovdxVixNYdLJwsUnEZdJqZp
	 hE2Cn904DUtFyX/fzV7cHtBQr+TRdCu8WEzKgG/6zSReH2Qn6kXnvigl1pEFaoBI+lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=1uTc9TmOc4Is/5wWhtZa0heYhwtrLLP+laiU4UTmzayeVNhrpOHMpePMklDlF4uYQIyF
	 lK0tXmQOVJtxJ9IPCVfFYXAuWgtyk/AOL0GcPgAJUcFPu5T/htVqdVCnnKkw4dawnd+4h
	 2N6Gg59pPphIM1jK/LBmlk9G7E84KATQXB/i5djSGpfGav4VDIESwe/kmH2M8hvt8J3ih
	 9M8rJ8UnBFZYRNm9/OxAJFD0MnJ7ISMpuY3ms/Ius4HzumVRGTmY00I7dhqPhrMXnRSBR
	 Tfwg0cwXHC0iRtbSFTWbNl4Z5e7ihR3vKhGzzxbBZYxy0mcGfIxU/frfkJRf5MClbiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhXTfV4O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3391606A31E;
	Wed, 21 Oct 2026 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhXTfV4O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8F91F000C4;
	Wed, 21 Oct 2026 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792585202;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EhXTfV4OSNL/DJj8wOrjKR0QjhUD1mubLlEXJdQMSBpIGOPlF+Zg4uUtBimUX3+T0
	 kpUu6SkumaP0NUo4EX2lI/nYXv3LTZHPRDhHGelU0FkrlaHIDI9AYq/sh23b6WN9yB
	 0/npTH12uJJj5j9PVBlFJzB6zOKuZ9pZCPmC3dCGyKysMgE8LH+LuvLM+gC041drCX
	 c/iUOiQhm/VpopK+Ob787kxv95KAnjdATQUPjbg17fy+V9OFwFLBl8nnCKQrrbuFuc
	 FOPB7/1PmtTjSOGQX9TCPQfgu2hCXjt0ULpXnRnTBllpEI1Gy+clUqMuVb6RcPZBtt
	 mLiQ1RJfsxzWg==
From: netdev-bot+sinfo@kernel.org
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 0/3] net: hns3: three fixes for hns3 driver
Date: Wed, 21 Oct 2026 12:20:00 +0000
Message-ID: <179258520087.3290.6496269232236757723@kernel.org>
In-Reply-To: <20261021121426.3096838-1-shaojijie@huawei.com>
References: <20261021121426.3096838-1-shaojijie@huawei.com>
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
