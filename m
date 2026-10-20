Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462433;
	b=M2/N1qbMG/PMM42HSrXRR7tD0cRNCZ9b//bsakYfgShOr7nkC8xAa/osrMHQkmRIB9Nl
	 i9MoYsIeNQI2JQRcSdGy0/dhJu6hI5P5Gt9eeRzBwh7rLHoK1evuOj+MgwhUhsLQOBNpN
	 gsfxsQOq8siko3316TiymzjLvzY6r1BB0B04dfexhD7AP1j4Arpx+7VUedXor3spf2MaU
	 WgOv8GHA4Mf0BncykE07ffiDjgZmg7bxs/875LQPNk6Sco0qYdYQTQS1KmxV2ERh2905E
	 DypkyfBPONAeY+5E9BC7tKUcR8WVuEy8tbemDc/UNwEcAGEy0Ehve+5L+GFoGhDA78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462433;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=buClxaF9rs1YDQiRmr5MkuBm083F4dxwjbJyPOf/zQ8=;
	b=yuO4GpRGKN3fW7iDypffhgJMQHozgjh2T4NZDe1sPCw4wBoxl+CD+sLC7AMrCWCpHoA8
	 beQPrT6ajqmJh0PfKdC+ULsdFG6/78f+8vnEYqWhgPY3S30w8sKfV/RAWqqjJD99mOWQV
	 QbK0I4vLTh0i+LSy/Tz2Jpa44bH/XMA/lqv95xKI58IFvsfTx8t2V597PQibLo7AKIeMu
	 LffE6Jkau9L0lCsJcF65q+hfOQz+4gbkXCl07NjsiDkyJ2b6EAlOV6Xg4qefgiMiF61c5
	 s1bxAcNNZy5YrAwpR76vq17NC69/kdlE7lkCZcvRsYwJi0sFCcQSPT3mGGBKNdWwGMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8+7tcla;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5C606A319;
	Tue, 20 Oct 2026 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8+7tcla
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E371F000C4;
	Tue, 20 Oct 2026 02:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792462432;
	bh=buClxaF9rs1YDQiRmr5MkuBm083F4dxwjbJyPOf/zQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P8+7tclaRzJv0/0S9T0FHEH8oL3xRsQLBxC6EMBRgv5s0JB+5UbSQm37X9o5LvVy/
	 RMdTb2hTBU4r3aw3EXxZMsDKf0cqsc1koPRaMYwZi3ozxD0kOWcPcCtPGgsAILzSI5
	 MiOaDJCVRpifw/IgOFLe8ucTjofgdxe4YDrhj6hLQ1R2wKmbx1yh4fQ1+5ZyEnIFSF
	 oh2iVwLXJKomF50RQeOqZfIL68Ojgwymqg/3feic3H5nBUpN7t+B2DIQnov0lJIpTk
	 1+yZ71G+IPDWa13/rMJz+JB/RgEGzRx+fjTf2q1Bm130H8XzzEzIQD1mq10V2WWGLC
	 UwnvCu5NUdXSw==
Date: Mon, 19 Oct 2026 19:13:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: shashank Jain <jain.sm@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, Eric Dumazet <edumazet@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] tcp: keep the route window metric when
 SO_RCVBUF is set before connect
Message-ID: <20261019191351.0719a13c@kernel.org>
In-Reply-To: <CA+FWx=mA0dsOSopCNBiA_8BrYSDYD7=jxMO7uLpxT1OOU-BkWw@mail.gmail.com>
References: <20261012132622.48550-1-jain.sm@gmail.com>
	<179181183946.2527009.5855837780305581870@kernel.org>
	<CA+FWx=mA0dsOSopCNBiA_8BrYSDYD7=jxMO7uLpxT1OOU-BkWw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 19:04:27 +0530 shashank Jain wrote:
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.

Could you please confirm that you read and understood this paragraph.

Looks like AI reviewer has some comments that need addressing.
-- 
pw-bot: cr
