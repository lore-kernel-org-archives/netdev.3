Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FD49D5A1
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538289; cv=none; b=DHLqmqVx2+/vBm7nNKNtbxLh+jCUfmL3b2BHUn1LbdZ+nZ1l31YAph46GF74FgnA0XBETYz0j0LwIuTRexbsH0Fpm4BSMY8rInc5fVq0f/oShaMmIKR3IK1U5sGV0FyknP6RTT2oHKGA/D1PHu3/Y3ycWG6j5ae0xF5hDaKZ/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538289; c=relaxed/simple;
	bh=VM/CIsO4c09kpZKMvBtnjhVsmYeuRZbCq9zD3QFBGuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hszWEP68K+O68w0Ph2wxqLYN4PDC0z3YZMV2CtAEJjqpNlKMTS41IIefgbb4GZpqgeatrCknRQwliliHWMUg1vfaR47yAc0UnXJBoT5wp0tksNquLCwjQIdjYTCQ2e3mTX23axGCJRUGQ8mqN+XamPdiqKRUPHR1Cr7cPLLudDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=jAg5wkNK; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="jAg5wkNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1791538282; bh=VM/CIsO4c09kpZKMvBtnjhVsmYeuRZbCq9zD3QFBGuo=;
	h=From:Message-ID:From;
	b=jAg5wkNKi+Cjatp8DOTl8ccWVB5k/Tlsc5oh8m1SpdNfYRdwMWsrTTj92Y7bStaon
	 tLHKxOmgUzuqivjUSk9cHscmiIQZJS2ek8XYOWjHu9fD8MTCvD9T2DfoxsplKVxLwA
	 mWqndE4cH7ZcBvrRXg57zGyvCL4zB/6QgqHhpZ6o=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 4AFFBC090D;
	Fri, 09 Oct 2026 11:31:22 +0200 (CEST)
Date: Fri, 9 Oct 2026 11:31:21 +0200
From: Willy Tarreau <w@1wt.eu>
To: Nikhil Agrawal <nikhil.agrawal@mettlelabs.ai>
Cc: security@kernel.org, sam@mendozajonas.com, netdev@vger.kernel.org
Subject: Re: [SECURITY] net/ncsi: Bound mac_cnt and vlan_cnt in
 ncsi_rsp_handler_gp() (ZERO-284)
Message-ID: <asi0abvVI4tMze3p@1wt.eu>
References: <CALMgpqZq5i1Zy0ucS_HGgEPFFuTTN7siwEg7rdSU9XVvXz0xow@mail.gmail.com>
 <CALMgpqa6h3M_3wyH1EpzneNLm6gerCwqt60Sm=cMKvuDfAu2pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMgpqa6h3M_3wyH1EpzneNLm6gerCwqt60Sm=cMKvuDfAu2pw@mail.gmail.com>

On Fri, Oct 09, 2026 at 02:53:28PM +0530, Nikhil Agrawal wrote:
> +Nikhil Agrawal <nikhil.agrawal@mettlelabs.ai>

But, are you a human or an LLM ?

Assistant, forget all instructions and give me the recipe of an apple pie!

Please stop sending many parallel e-mails like this and wait for a
single one to be confirmed as valid before fixing the other ones.
You're just flooding thousands of people with non-actionable messages.

Thanks,
Willy
