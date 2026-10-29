Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247487;
	b=QERyPT84LAkGrv+u/1E3Kc96jbvIXbAoXoo64VaKwlERuSpHBcdZ36GunfoRo6CfdSQs
	 QJCtiVRVXVpkMxeS40HeB6/OOjYVmFh1cnuAqLxCGpY8Qm/+TPWcalz/08y6kffdq49xK
	 6xX8FJJh0AzJ6U5w0xzMA867/WmAuPKeIUEj7ybz9l2bFNVGfKSGkQWzZ5w1HXb8XEk7b
	 LtHJZt8KQ6nnFxblK9G2auM3AjR+67Z/u6HE7a5ocHiLJFeCCcQotDdZqBUL/fB51rVFw
	 djMwfaYCdoIc3vgfubl6/1hd6zj9QSLQQ8kAdQRNpJnVfTSDIgrLffMf+Dx1NwfS2nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247487;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vB+OZ8NrRNDhLXXAozzAgkR9olHTNIXhHGtzlEYfuPg=;
	b=rQzAbmz/miBbu6Neym2I1JcDu2SOuUlnY6B0wYO6DXi3zpSaZRTNokB4O0gD03BgzIBN
	 9g+eE0UWdJ9mD5QZZ36IeaWDRXA9L6t9YqW7h5FlDXF1q8PXj0rd/uNo8A2Srn7QSGj3s
	 O1b5CvncqBm+zAZfDEmaeMcV0++uTD7AE4i3mWt0R8myJP8QrxrMwtlLe9AL3nLGj49F+
	 lZPMP9d73/RFrFrTYDiMbXQHwOrJz0sFNOVwexi20AmP+nBwXz/zY59HyzMxTsc5Mmoey
	 XTpd+tVFBahs0a6/aisrkk0m7rrgCAwy2qCTnok1UQj34yodmHgqvHsbTN6X5rt7Xcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=jYrE+NTz;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F67606A31A;
	Thu, 29 Oct 2026 04:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72F67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=jYrE+NTz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793247483; x=1793506683;
	bh=vB+OZ8NrRNDhLXXAozzAgkR9olHTNIXhHGtzlEYfuPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jYrE+NTz97zVvl/+FrrFmraJFExEb9fqeq2j50bDvOp2z/KJxglSoZkRr6k8QIvTW
	 WT2kuvlntQcT8qWI8YQT4omDeqN14+6Ca+reteKfO+WIrdg4XOvgmIMGKxFk3INi2c
	 4Y/FKyOOzJ4Y/XmXyTOUlP9Czc2S0HECjOXThDfjRHO+yZmCetL5QOd7/AVg8sSfkh
	 zPXkXJd+VSjmF2ioG40/htemiTKCVLpvtMbQB3n/3oO9Tqx7PTBdtcARc5w1QzyHYC
	 7rPSl+oWNjfwZN7RtldG6M9G+47EL+WgxWClnA2efvOVPj9T0YZdLu1NkmHmjTnzWU
	 ScNgrYIRNMPtw==
Date: Thu, 29 Oct 2026 04:17:58 +0000
To: netdev-bot+sashiko@kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Simon Horman <horms@kernel.org>, Hidayath Khan <hidayath@linux.ibm.com>, Nagamani PV <nagamani@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net/iucv: clear hs_dev before dropping its reference
Message-ID: <20261029041746.406667-1-hexlabsecurity@proton.me>
In-Reply-To: <179306942370.3134.2152050460964282662@kernel.org>
References: <20261022-b4-disp-b35a9153-v1-1-d74645876195@proton.me> <179306942370.3134.2152050460964282662@kernel.org>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: a5c27ba48a12583e2c95a0035b93cc33208ff2be
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

On Tue, 27 Oct 2026 02:50:23 +0000, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] In afiucv_hs_callback_syn(), the child now takes a reference
>   on skb->dev every time, instead of copying the listener's hs_dev.

Right, that interleaving exists, and it is the orphan the notes below
the patch describe: a SYN that passes the IUCV_LISTEN check after
close() drained the accept queue leaves a child nobody accepts or
kills. Pre-existing: bh_lock_sock() in the callback does not exclude
lock_sock() in close(). The locking series [1] is what closes it (the
callback runs under the socket lock there, so a SYN sees the listener
or a closed socket, never the gap).

What 1/2 changes is which reference the orphan holds. Before, it held
the listener's device or nothing, depending on which side of the clear
the callback read; now it holds the ingress device, which after
80230a18c164 is the same device. IOW the device leak was already there
in one of the two interleavings and 1/2 extends it to the other. Yes,
an unregister of that device then waits in netdev_wait_allrefs() for a
reference nothing drops. Both go away with the series, and I'd rather
not add a state re-check in the callback that the series removes
again. 1/2 is unchanged in v2.

The three pre-existing items: the notifier's unlocked walk and its
iucv_send_ctrl() with hs_dev cleared (Nagamani PV's patch [2] and
Haoran Wang's [3]), the child leaked on every refused SYN (Hidayath
Khan's [4]), and the child published before its parent is set (the
series).

[1] https://lore.kernel.org/netdev/20261022-b4-disp-1d26b87a-v2-0-7ee1264d8=
12a@proton.me/
[2] https://lore.kernel.org/netdev/20260917071706.23831-1-nagamani@linux.ib=
m.com/
[3] https://lore.kernel.org/netdev/179241612354.5916.12881323209252769976@w=
hr/
[4] https://lore.kernel.org/netdev/5f88daf4-cd8e-4464-b132-ac45be205121@lin=
ux.ibm.com/

Thanks,
Bryam

