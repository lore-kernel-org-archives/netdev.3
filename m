Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727854;
	b=yPPlFzBmHh994JRL/4vcbT5Ny7yZ8jGr6uaH5MwOIdWjwoJ4iG0Rrtm1/VqpRhcr7fQB
	 yRcsEJo5N9OET8Y5jRnei0HHMqi5flLKuI/1GiMiE5B2p48wJiLhkC7TGlyLwdw9allb7
	 gsiPiunAoLd48zgw4Oa9Q7/3AQ90oZP+YJIs8ROLUYWwMW+YHr30bilIGglyqRXEjdvuI
	 legXLTegEzMkAG6iBA1RWAttE04QpjXy1qU8g2sXSAVVf4gFBLB/raeATvRTnWdAZirNk
	 aUIll+cugvItoms/5dnc1AJ5F4hvvecU31vwUN/lVJRKoxUULwuuzDEADGQdzLvLsrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727854;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=PB8US+s5Y8oD38ettM++WK0Ovqh22tgODymvHj8NAUfHFLsF04foQM6XXfsQUGPEiNfu
	 BVou0lk7H7wkwkIMXuF7YRSVmm0EZiFfRjes8VwxybHnuWVWMTN3CFaCn8vxxHKgIo/Az
	 xZR8ZOsa7ufM26jgRbU8+6YfN82fWoeoihxeu37QdOOPE/PhubAL5QOKleVbo38YwGOHm
	 zkV3+j2ZPqrCgPV9WJ3AMtawaXyT+G/bt93ZV5JsPeyzFE0/is8wBEPZaZV60LBMlZu23
	 Afe+cnEjs0VtWS6bsOELiMwkTiKiGLbCxxnsN6rtawlcnltwTFugIGMBBnalqizngyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwxt8o3R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA23606A328;
	Tue,  3 Nov 2026 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwxt8o3R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471971F000C1;
	Tue,  3 Nov 2026 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793727853;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cwxt8o3R7OLYDcd6xxQsHs+ZBPLT1kIFunZPL0YSBGeGDD9VonAF295A9O6y0em0L
	 D40pEhfDB3bGffr728YXMSW0VoeUKLR1TDb/BM/s+BiDpdxdYruaBVr31536490xXL
	 fYhwCR84vktzyGgcn48siIdhkieq/NWiLOCXc6GQRXPuMa0UxBZJn/932wGxaw6D5N
	 OObubVsEt2S5MgVVpFi0EOQYSu2gFp6rE0Z+sPhFSsr7h4VnsKZA/cWFD93vfWr8+n
	 JEBECLlffSYU6dGS+l2vH/832OFl/1nE3I9jCdeBd6EiDtCUOFRFzzbQwTYyBwJ8Fj
	 KPrzZCvbrBOlg==
From: netdev-bot+sinfo@kernel.org
To: shaos <shawnq1@163.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: hfsc: clear eligible node on reset
Date: Tue, 03 Nov 2026 17:44:12 +0000
Message-ID: <179372785287.488859.9916775747763937349@kernel.org>
In-Reply-To: <6AEA1C23.11E1A6.00008@m16.mail.163.com>
References: <6AEA1C23.11E1A6.00008@m16.mail.163.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
