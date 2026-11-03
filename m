Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681294;
	b=07csFdZm1PyKfkxs7hICVcb6DDKMIAhtPbEHv0TF98LpEGN6wQjqKDi3ahjzi04xt+AL
	 JWWEHGPho/u39bX0/V3b1DQWHYIgmDrU/Q8J2qnSwcE6IpIFFLdXTXodauZX4s4OiGHHX
	 xRVIEUaYJ3EldP9xPCMam9Lw1ENcEjCV5WCW/Fcpl5VuJs6PQykMPgFilwp/ROyuBjZx+
	 QRiyLJzc8VOmo/KQjyK1BmB4Nvu0PNooubwqsy6Vz7DY6D0tmiJH6XLV2gst9nYTS0Csn
	 GTkbGp8OsLLrIff1iVa1a3I6sR7DJRqBSiWQAFYUUPbOQnrAeFEfUG65cmkPeY55Ewg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681294;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u9aE0kyDPpbMxcU9KpJkb4709+D6SJWWfljxcbO7ZeY=;
	b=5SHtK4qQDJgA/nJJS4ignL+JYeTM9tLIOhkgOSDOnSddpg0fK08A6e8cz9xcLP68is9J
	 nFCoIF5lm9QXVj6A9Xmcp84f/AyTMr7TcQdrzK9tfOX+M7NX3sPI6lQVXzhWapRMgjpn7
	 ZBHYfwpDYjCeREw2HYPl8mTagYDzBw0DBddmB40b6XjFcQ7msP+foj8fiMjaVo0c/T+PZ
	 ViGvgCkNe4Ecs8oDHBx4Vy94IG03S47/2GB4ZF5ktb1JqXpEWV83BfRtNSasXG7CZlefw
	 pYBtXaVbPdoo37/FiyS0RZs212i64VpmzkkYea60dcGb/l1EL8b4RVY8QtxJM/24gqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEQpDlGk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445E4606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEQpDlGk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C384A1F000C1;
	Tue,  3 Nov 2026 04:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793681293;
	bh=u9aE0kyDPpbMxcU9KpJkb4709+D6SJWWfljxcbO7ZeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DEQpDlGk5AfwwDou9VXIkVttUcNuTmRqPQ3xe/cnwrJxZpzBXCifq9qu+rLcksLf6
	 NrwkzqOdh5ckMhB+FOPjIOK/zz/RCxtUr6lpTE/9kqvBCDtRgUINaBXaPIvaNgDI1X
	 g27pFesheG197cnUZlaFndk2TTY5A5woYCliyBjJjO5D4BAp18Mapb4PRDOkbnfAEc
	 vQjHbAq7dHmi9R3Nr9xNdpae0kqgcm59ugCYgimFzrCqaMHAq6aZTgXTrIH6AtYLsX
	 TVpUN0AcmrFGUBrZ1arKc0BTuH/uE9PJwKJhhMaRjzImHxE/1B38w5tV06Q9w6pxKE
	 dWXiyDijzXJ6g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com, stfomichev@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, tushar.vyavahare@intel.com, kerneljasonxing@gmail.com,
 zuomao338@gmail.com, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 0/9] xsk: ZC mbuf fixes
In-Reply-To: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
Date: Tue, 03 Nov 2026 05:48:13 +0100
Message-ID: <87ecd24j1u.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Welcome,
>
> Nagato Shiratana reported that duplicate fill ring addresses in aligned
> mode let a driver pass the same buffer to xsk_buff_add_frag() twice.
> This corrupts pool->xskb_list and can lead to a NULL pointer
> dereference in xp_free(). Patch 1 makes xsk_buff_add_frag() reject
> such buffers.
>
> Inspecting the rest of the zero-copy multi-buffer code found more
> issues:
>
> - i40e retries a freed frame, or stalls the queue on a duplicate, when
>   xsk_buff_add_frag() fails (patch 2)
> - ice leaks the buffer when a frag is empty or cannot be added (patch 3)
> - ice and libeth free the frags of a frame still being received when
>   a multi-buffer XDP_TX frame completes (patches 4-5)
> - handing out a duplicate of a frame's head clears its frags flag, so
>   its frags stay on pool->xskb_list and end up in the next frame
>   (patch 6)
> - ice and idpf leak a partially received frame on ring cleanup, and
>   its frags end up in the next frame (patches 8-9)
>
> Patch 7 is Chenguang Zhao's fix for i40e building broken skbs from
> multi-buffer frames. It was posted earlier in an IWL pull request [0]
> and is included here unchanged.
>
> Patches 1 and 6 were tested with KUnit tests based on the reporter's
> reproducer, plus I verified to-be-upstreamed xsk.py test suite passes
> on ice driver (back-to-back setup based on netns) with this set applied.

For the series,

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
