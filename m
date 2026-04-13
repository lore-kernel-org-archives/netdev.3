Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363E314D26;
	Mon, 13 Apr 2026 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102920; cv=none; b=LrZLy5aXlO9D/8ti6ObYDcAr6IGjOEuFFLzKqWIKLGySdlzU2JiBweOvBjR4HyY4dlZm5qHCCU+vqs1O1suwBwkJlNTkOeRLIP96DoqRAIc/dsAvN8UmYDSsTdm2//VMfaIIMfpBsRjFpDCMzAPFdoGJnbLuYcGKX+jDVuXNIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102920; c=relaxed/simple;
	bh=qjtcliPuj+Sf4X/8T4jxiNwuME7EfZALkdK3CKDwtOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBcHEANdmIOfNgxVBwpp9ng2CGIrHiXXkG1fEJxDO6zLbTjseDw7RUYCkCe3Shv2Urv+u34391bfnU1yYikJZnIXrjyDlYEKy8qNlFpTE0b1gg/O1xBESj6OK9MUxhi4WDbbRoadb234iD8vh4w89ng6aXmw72webq8TuJKLyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPBr419h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPBr419h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C822C2BCAF;
	Mon, 13 Apr 2026 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776102920;
	bh=qjtcliPuj+Sf4X/8T4jxiNwuME7EfZALkdK3CKDwtOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MPBr419hJhlMgyqQ2Nju2JPLtSiV7jD5RQmEV9pGGUwYWfp2uYegVHPgSKJ8QSms9
	 wa/rGiMda5vKryx8nbwmTiyf9le5qsSd4B68KclzzdDYxgzqkbdbC+cAEOdP2FApuG
	 c+4x+y83df7O2LF1aVL8nWxwfYP8Dg2fnDWOoo+TvXQoDg3DNWuTAhByBJgXksOBVA
	 arQY2uKlVFJCM1y1I5KojkYxhHjSeU/8c5U9mBWjS4joiy0WoVnRnp6mXK0Ahe82aK
	 xsQJPh4OD4na2FZY0pP925m+crCQrp8++r/OOL2WYdZybMumQG5qLWZrOfSvi27LIo
	 wW3p8GbtVx3wQ==
Date: Mon, 13 Apr 2026 10:55:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nfc: hci: fix out-of-bounds read in HCP header
 parsing
Message-ID: <20260413105518.349c93b8@kernel.org>
In-Reply-To: <20260413024329.3293075-1-ashutoshdesai993@gmail.com>
References: <20260413000627.3273477-1-ashutoshdesai993@gmail.com>
	<20260413024329.3293075-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 02:43:29 +0000 Ashutosh Desai wrote:
> nfc_hci_recv_from_llc() and nci_hci_data_received_cb() cast skb->data
> to struct hcp_packet and read the message header byte without checking
> that enough data is present in the linear sk_buff area. A malicious NFC
> peer can send a 1-byte HCP frame that passes through the SHDLC layer
> and reaches these functions, causing an out-of-bounds heap read.
> 
> Fix this by adding pskb_may_pull() before each cast to ensure the full
> 2-byte HCP header is pulled into the linear area before it is accessed.

This is missing a Fixes tag.
Also please do not post new revision of a patch in response to the
previous one
-- 
pw-bot:  cr
pv-bot: fixes
pv-bot: thread
