Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE7155322;
	Fri, 27 Feb 2026 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159574; cv=none; b=K87T1hwyRrgwM8iQS/oy2WierzA/2ZA1EieUSqg/qMblfIek73IRZMFgdlhdkm0Jkq0R5geQhmEG9xFFBskqM06gYK7zZ+XKgY8vyNa9rkpn4qQAtTuvYlK1VMN2GBcp0KZZPzDHOnoo6zpouYf8pc3cDz61iHqo+EANaMkFbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159574; c=relaxed/simple;
	bh=s4VqgOlh50jP0EyqtYbvYmU0KxuxxueBDh7dIzhJNfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GN9o6vcrc+pPdjo5TJhjOzJmpj31kSdiqQjxgDouaCESs19EGQjbNNxfpDKa0S7rtW5TuAYW6MbfWUmGQTOCzVQtG8orYun2d3ooHv73xtidXN/VlygaXGYxbXbQj8HI/GIdySc0eM1Jke9rLmip5PeXhoFEza34OGuXyqZYNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNV2x/kM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNV2x/kM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4385DC116C6;
	Fri, 27 Feb 2026 02:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772159573;
	bh=s4VqgOlh50jP0EyqtYbvYmU0KxuxxueBDh7dIzhJNfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qNV2x/kMC16I1tgxMq1/FAEA6jcumBTmWBP0mF08elh3Vll1FWLABfp1XwHzwvvFT
	 z4Mn99BhV7peYDji6vymUXEGXq549rkmsvbhls/W6WrGIXHtxu3z8a1bY3fbPSsy69
	 2kRl4Eiy2T/okuUZ3Dm3LUZLTii+Jt73vJqdjZm8wU41KIhLK0XyQn3gsL4gdRsF2N
	 ykDMb4CbTMro91MXEphZStuQLg539EaymecyxjsvKz5H9s4G2zVe06w4kBpdQlW1nj
	 X+xtgfhgZOKwz/Y4DZBRPb0fDOsyA/e5d7Jujm56C3+t53cLMcYRNv/4h2n9ZiRgvB
	 T9lpiZ25h7+sQ==
Date: Thu, 26 Feb 2026 18:32:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [net-next v31 2/2] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20260226183252.10fb6003@kernel.org>
In-Reply-To: <20260224231055.393329-3-admiyo@os.amperecomputing.com>
References: <20260224231055.393329-1-admiyo@os.amperecomputing.com>
	<20260224231055.393329-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 18:10:52 -0500 Adam Young wrote:
> Implementation of network driver for
> Management Component Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)

make sure this builds cleanly with W=1 please:

drivers/net/mctp/mctp-pcc.c:133:27: warning: variable 'outbox' set but not used [-Wunused-but-set-variable]
  133 |         struct mctp_pcc_mailbox *outbox;
      |                                  ^
