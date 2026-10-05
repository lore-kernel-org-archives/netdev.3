Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C42931D2;
	Mon,  5 Oct 2026 04:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173978; cv=none; b=Kg3/2TXGlw96IbeXFCUgCqQsEw2iY6E6L5fIKPdTaWCv5wL6NlfO1zfLHuD0hGYV4QIWBMHxXmwwI5DbJiIm9vrTtGTAdzg/69rgQcdr+hLFeUcROqmBwlRDBxiVBaTf5q8OOvbgsUU+txtpR3dbtXDOr2wWqAl1KpHLN0l+ExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173978; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFzf5YGqd2Nq5kOCVhnxz+JW4YQqv0Wfv85H0sTNc7EqvEBzPitgUik4Ty3h56oK25bk3YUBsvDWCO3+w0j0rxKTpJLeP/lLv//8LJ5VSD74t1xQ8NcXzNAW0dvuA/n/XIvDodSOHM6CQ24Iyv4fCfkCxjgmEqbB5GKjHpcp4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fru/giSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fru/giSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171701F000FF;
	Mon,  5 Oct 2026 04:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791173976;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fru/giSsugjTRtgtwTHac0TT/r5A7B5so/D26YSpe31mtO1j+iYSPZPAMKXK/D68E
	 IBf6ZU65Ta0mnTFg4UmyTjI5Hh9DcL6+zWWddMFXjPryMrD2ZVDteocOFosI3zThQU
	 zFPrYLxDoXXgPocNQCBu7srw02e5sPxR+QFCsmRridEtyn4afSxUZW7sv3oi9UrqYd
	 hw7nfuFgz0XsOCegLx8Jr6kF2uu6MhctMph7YCOiHtZaljwwA0nSFc4PnwDJZo1ZPN
	 U2Te0F/fOt81zgSseURdPcGs3virEoJC6UngZ0BEVhKshlyeqgzqUeJjJdBnWm8EJu
	 xLzUnkLFykH5g==
From: netdev-bot+sinfo@kernel.org
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, oliver@neukum.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Subject: 
 Re: [PATCH net] net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses
Date: Mon, 05 Oct 2026 04:19:35 +0000
Message-ID: <179117397560.1402591.15477443356899321449@kernel.org>
In-Reply-To: <20261005041525.49111-1-xinsheng.zhu.ny@gmail.com>
References: <20261005041525.49111-1-xinsheng.zhu.ny@gmail.com>
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
