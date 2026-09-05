Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D536403A;
	Sat,  5 Sep 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641824; cv=none; b=uOaZItIz9qBVYyQknq+9nM4cB3v6k4nvAC3/EDaKSW6nYeRK+bYmCIRzo2WrrTJJwjt44qRqzNX+DKCM3Aqs4btGEG3DeajDkdo4GAU/f4irEA+Nnl9mVRDev9AvKuY+PHeoj+cjTfidF4UOrXk51fSrFKOqXXJHOdJbxjibN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641824; c=relaxed/simple;
	bh=MgqKM2YwSIXhmAfZOlcN584h+Mtx/1tabwZTb36MluQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPRrFGpU8ycijyYtxKyeAVhCvXt2SgdTg67yAPyPhBrGHAf2J2JX8iT/+FK69lfyxG4PhZ7T62P8/5njR3ufpcV7GPmp5rSsftyBSMFfnX1fsBYwrzFZWo8iiJpqzPJ0LWT5XBRyDY/C7jcTjmH0cNOMAWtTou3Scl2oy5LTcvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXzVSOVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXzVSOVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ACD1F00A3A;
	Sat,  5 Sep 2026 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788641822;
	bh=zNYLdBla73Yy0YAcxMSZ25Vynt3fCPyIDZnVeKnjdgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EXzVSOVQVwD46Gvu0N8j0P5ZK2Z/CWKrzlrunWDBcNmMhreY9fDV3hosl5yWVt/Jc
	 s9EBoCllExTRSwJJZoHN213+sAOoEwsoicM9o1PM2mtRLRx6xZz1lJtJl/P6rI3KsJ
	 kpbD5/pl7Fu9bUtoNXV41BB0vMKBxNIO87wkwl31uX67Jy8p2wIh5qNVNT6WxLioyl
	 iPZzQERC6zgnV1zRxa6qdXiAvsF0TttilFzybhmPFokl44yZTYDtxLwMpvyyKinLtF
	 VuWVwv2hWZ+r9cwXYBZGryk/Jw14cFD5r/ZWQiEhiQRhUBWB6mkJa8jfJ0PVAFKhqo
	 uE4EnibFYhj1Q==
Date: Sat, 5 Sep 2026 13:57:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, Andreas Noever
 <andreas.noever@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 2/2] net: thunderbolt: Update ring indices only after
 all frames are queued
Message-ID: <20260905135702.1af66dde@kernel.org>
In-Reply-To: <20260902082128.1148463-3-mika.westerberg@linux.intel.com>
References: <20260902082128.1148463-1-mika.westerberg@linux.intel.com>
	<20260902082128.1148463-3-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 10:21:28 +0200 Mika Westerberg wrote:
> Take advantage of the new API and update the ring producer/consumer
> indices only after the frames have been queued. This reduces the number
> of doorbell register writes from one per frame to one per batch.
> 
> Measured using iperf3 over a Thunderbolt/USB4 net connection between
> Arrow Lake and Panther Lake systems (average of three runs):
> 
>   before         after
>   ~14.3 Gbit/s   ~15.3 Gbit/s

Acked-by: Jakub Kicinski <kuba@kernel.org>

but Clashiko (sort of) hints at lack of proper handling of transient
memory allocation failures. Indeed the NAPI path seems to call
tbnet_alloc_rx_buffers() which flushes the ring completely on
any sign of trouble. (a) aren't we freeing buffers already handed
to HW; (b) if we flush Rx free list and there's no Tx won't the driver
wedge Rx and never schedule NAPI?

I'd suggest fixing that first before making any optimizations :S
