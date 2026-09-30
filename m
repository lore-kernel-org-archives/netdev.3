Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB179363C43
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734773; cv=none; b=B7l4IrTFOFQ8k1pCa3VPb3/7BN87fLysyMituI0BndS1D5/HJnBT6Lu5CSHAA54fzlrtKw/K4yfFiHxqYhLbM6IkVlmC4aEfXfjpfnujRW2l309XGGqzVqCSHfA/BYLg0qjNA/vq2ii2qz9ZGmuQN7oi9JBHwNMarD3CyV+9zwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734773; c=relaxed/simple;
	bh=DJqndoBqdA1vWtEbkoy1Jt7IIra+qXNbt2TaDkts5Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAovGRKSi8SDyqf3VLDPwt8IE7q5L6Z+rHQhuEK/cHWgfkBOuEVRWc/oTKELisq3kslmIfQaYmVFmTiVPBpZDBdKg2mOwWB8JsCWgwzWOmugB+jYk9dqwQAoBV159fEchvrFA/DJAgOTIhu2ADuB+G99uVR/P67C80Zdl3BSIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnxSqz+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnxSqz+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4BB1F000FF;
	Wed, 30 Sep 2026 02:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790734772;
	bh=Uk8jnsBDHcieuf2XySgtknFWMEmG10o5od7NgusW+24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QnxSqz+agf/GhtE+3QfAPSz9iYX3s09+/8tA3qFbYAvgADbeCRGLi9XH3mcTrq+lk
	 LyaFq6YsI7AxZyThCglG0loQ7NRt03oM2siTOHthdZcG7Xc5fm9RCjL4WYNWNX8l/o
	 91QJhJQ+g+hHUjlNoA4MzORKr2WBaxP5S8B894AuB1bxK7RsZGZCkWrH7+jHbx0Wi1
	 Oxpq/MJgbfvRYUMTM+iz7w/pDobdZIQBhqezK2ycnASNlkOwFDFsXcD0Ijuc9WRIMT
	 V6qfoCrEQlGWjRSl/MbZtZarJzWgqcJMVeNR2Bl33UtPKH9DUy38mMKwLDeIq8CNrY
	 3mqYrUaEVq8zw==
Date: Tue, 29 Sep 2026 19:19:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 net] tcp: preserve timestamps across receive queue
 collapse
Message-ID: <20260929191931.303d82ee@kernel.org>
In-Reply-To: <CAL+tcoD4MmRxD_5b06u5toAmBv=6HsbetEk3oZY337DjSS14sg@mail.gmail.com>
References: <20260924152529.5689-1-kerneljasonxing@gmail.com>
	<20260929165318.6690d427@kernel.org>
	<20260929165425.53ee002c@kernel.org>
	<CAL+tcoD4MmRxD_5b06u5toAmBv=6HsbetEk3oZY337DjSS14sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 09:53:11 +0800 Jason Xing wrote:
> > I meant to also say - I'm leaning towards net-next on this one.
> > Please LMK if you disagree  
> 
> I'm okay with net-next. Seems like I need to repost.

No need to repost.
