Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294749;
	b=zQo7fh870MbiERKlJeq4NEbbUgdHhJJt9aH9pIgoa9JbV5yQvhGzmNqB8Sg8BIAemwRZ
	 ggMNrMfHUXPw698/PFShKL9MvCuA4PhGSXnwR2fl0wlAs4L9z9l7wRcy4jwJAz8A1Pxs9
	 WdPXmOR1WG+vnkGBeG+2E6VX8uxy5qQkMV+7P4SFkSg6//r1R6jel9QYsMYKuBEk+606v
	 FuZCU4xuXDBhsfKM+y4gEzSJeSOvn7NKz7FjcoH214kkLtcV31cyMer0GeSm2Os+kHd7/
	 MHap1ZlqXPJ9sb/OvPiWRGfou2FR6A75+DN2uNiz6C3PBWkNScgWZRC5VOghTK4bBNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=wrQtxI2doXBpXx5SleQJkW8bPQKIxFnYohBM9XlQ5o6tOLVCZPfRKu5nsPtNZpRHeAue
	 FSSBOdXfHwxSE84Pa/MJuCYgKrB85QJ2RgF3MjfSs2+BTvsEBOqvJOvKb+C0EXgIjpjk/
	 N2R8U7gTNhtDB/4X0FeVnS+hNGlmHj5mFOsvVPxBGQKedq0sxVE3tjGw0fHSeLWSG7iCJ
	 4JMHN3QAdZYHwtD7+nPGKklQPKVQ1Zd4Ps/5Dj3HoUtJFBCimDeThiFt3QL4skZffcoe8
	 OhWbe2j1HTbzEmuSFw5PNTkBtDpxc+V/RSo9mmRNOvvGcjl9RUNc3OmJkH1Aon5VilQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VTE/rhP2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE25606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTE/rhP2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E911F0089F;
	Tue, 10 Nov 2026 07:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294748;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VTE/rhP2nWPLpAKuD6hzSm6H3gMbad5mncMZx4MO/k3OM6GNu1xBOTedsuhWUdIm0
	 j6Geylj/7oO5PGzEXHsbPMzBLUZP8rv7Q4diK/CCoCUpReLYIYtvzZcG9gQdzKRGvr
	 bM9WfgTEetnKE7IaoGcm14B6aHolqPUiwmFYvjAwMdzYTGirKkedaGkGLAmTC5A3Z1
	 h9GJ0x5+hNUiIUeDzNl4vNqTZPFiGDO8uglUvpXzxlT2GsVSPm7dbXvbj2qlarTM14
	 c3IcI+1QGyVuPq3rcWoD8RAf+QNCt/Sxk3vQsGE1u7SIq29cXOs5iyALGymR12PFoJ
	 Xk5OujLPDMzVQ==
From: netdev-bot+sinfo@kernel.org
To: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>,
 Imre Kaloz <kaloz@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 0/2] net: ixp4xx: fix OF node leaks
Date: Tue, 10 Nov 2026 07:12:27 +0000
Message-ID: <179429474746.488859.11095401722001153896@kernel.org>
In-Reply-To: <20261110070803.1099-1-zhaofeng2@cmss.chinamobile.com>
References: <20261110070803.1099-1-zhaofeng2@cmss.chinamobile.com>
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
