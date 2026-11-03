Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706830;
	b=cf5JIitp3IC1eb+Hi9un6UuyJVp7epImNCNkp/+dCashYuWpdVQG8i2gafCOkvNtvP3i
	 u8hQGAX602MzITxTnhJiwrJbeb0eBxTjsx+cZhHfwP3IJwyWbeJEGXFsRCHNZN+HLPJki
	 umZNlUOYj/qPeZz68sqbHBdKaF/hyovGcXf0zkSTtu8nrmXPyGdubyfD4/Q/KiUrZdzWo
	 xi+8Du55zOEG88au39c/l0cKLOk/aRq1ASWx4w9YTjRvTu8cYC4EEi80Hviny372FRgGk
	 FaR0gmXwiGq+JcN030vxqX20IPslEX9bktR1tnnfiO1dMc8tq+nSIakViQ/M6a/10Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=vO+tfNz9oBLgaawkQfvSqGvnLa08mTKBztLYezUzMxf/Rj8wvY6uVdPpmr/ocPCC21yp
	 gqshK3jb/2vaMSCRUW85G2FammrOyjgPyEGgULQqMlKYsVz/7gOlNvxwbXXSF7gDBV+Gg
	 KrjTxSEC3t4RR0cbqizxJeJls2i84eKT3f1QvYGG7Wel9MNLiGHSxsv0Dkl6bxSUba2vG
	 hc3VTOGA+hkxdKYA794+H/0zQh9Gg9giEpjsB9srKQNvPmS+o7zNP3OqBa91boyBxCrkh
	 oKDcoN7xvkrljcnRd/tcUq4FIlGeeEDyWpGNxt8Yn0PPt1b3k6HBCKV3bRYIjnRAnrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCth66kd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBCB606A327;
	Tue,  3 Nov 2026 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCth66kd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B4A1F00A16;
	Tue,  3 Nov 2026 11:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706829;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eCth66kdqFP+g5VjB6QG2hx/b5DY4kt9VX7oEF3dmEAVoOQBkfCrkkSAKH7umkDCa
	 hGkDvEdvxJpAMC0ASzRV+wSclhy++hlkerd3hRmy31x1hUsHiyA0IJWPCCDk6KB+IQ
	 QDpSzoS/X/FjdtiMhmjYOVnXdhXlIf5poYZC+iqzgNZXQgGH+eJaQoiXsu6D9khBnU
	 6KVVmh9f+SVuxKm5Tam8JU5xOGm5Wtbp0h6wennhsfYDmIMlTHp587dTGpclj5fE7B
	 j6LVCSLwaq1aOfzGU7IslvS8xGst54dVAJQz1mhDxU39Od0Drizcj3amWN0b1jIsnv
	 togv5108aQiBg==
From: netdev-bot+sinfo@kernel.org
To: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, alexandru.tachici@analog.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: mask the RX IRQ of the
 port being stopped
Date: Tue, 03 Nov 2026 11:53:49 +0000
Message-ID: <179370682903.488859.10553739131009732027@kernel.org>
In-Reply-To: <20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com>
References: <20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com>
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
