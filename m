Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF64C10FD
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081390; cv=none; b=aarVAKZ1LKmsTONxP3v5St5rC311yf8eplUOdGaIobEtP7KsfsMguj95ygL80YY1fFSnYSNzqyBRDzcvmylzt9dmq6MDvsWj60SlHkvKdFTd6Uk6jNgK4MGhdqZE4+MYSTM9ZsI9SpKrc7XSnb1mkX0eQRj0gQ3K3kTtCb3g7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081390; c=relaxed/simple;
	bh=H77B/1XoUbsQHeqCDGjv35YwEIvkYUiwrSWHUSL0kKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izbRjPUocTnqYeWHn1EuhuT63kr5hgzbp+X6Ilw8EF49sERjkyvQjjgNmh2XLvUUPRtgmKaVXG4Lygd2FeHowKvB3+xwbcSd5fQ7a2wQlZZMRTecVaCkrqm+CYg/uNVVIa16DN4DY4gh99kLIF/bphrB6yzkIiI9oVJMo4YMnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8LNTFsj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAKPTNG7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8LNTFsj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAKPTNG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790081388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMtW18PYGgs3eeFoZyurBYg14pG+Ej8vE9R6o+NDZ70=;
	b=f8LNTFsjBBwprx81ljPz0eqAFJ8weo5xB6IsBL4zcBVh9rj+BN7P3vIe/70y2UnHaGoAHu
	M0u68Gn42shPOY/0kxqaJcT6TmGju42DPkBaeWaGSDU8KiexuBLgu4tGWvEkOPEsDh79JA
	I/sHLIS6C5DNC5jKou9BUzA9ten+jl4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-FuD-xYiCObWyI-QMFHOJDg-1; Tue, 22 Sep 2026 08:49:47 -0400
X-MC-Unique: FuD-xYiCObWyI-QMFHOJDg-1
X-Mimecast-MFC-AGG-ID: FuD-xYiCObWyI-QMFHOJDg_1790081386
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-487038a4a88so1355582f8f.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790081386; x=1790686186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BMtW18PYGgs3eeFoZyurBYg14pG+Ej8vE9R6o+NDZ70=;
        b=NAKPTNG7JdTsB6Bxm9bX3sdN5LtnyRqQRgd9sST3DNWU/CQME57S0/v0WwCOBbfKua
         zCJesy6cqYJd9svn1R/c9cJr2XYzZH6aDwWKtZ9n+fmtarn2doDbfZ+uqq2MdSRTJTJ2
         CCX2VrQ3uVm3h0d9uq44pgXcCdjdnesXb+zinP3OamE2eQX6NGazRdV8UCdYOi0JNjkM
         EkAD+Y5Tf4Y8T2AxfkdswCiyIZegK/2/khJ9XEdWSYjm1hU8UYYtNOSC7Nuw0FrSgdE9
         KDL3ayokHFzp6SrnlLqVQJZgBjDpcTmOrxSqumK7oCopNgBjXKpErkdKZD5bq9Fs8hCw
         DbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081386; x=1790686186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BMtW18PYGgs3eeFoZyurBYg14pG+Ej8vE9R6o+NDZ70=;
        b=rAvrMJ39MJvLa8+/7tn5DooRl1SWmhUro7kLK78EmtSmPD8N08Dj/+qY21XenRTHQ+
         rnCCADDelItLrchqLHt61lzv+391UGvVOVjHCHvRx0vK53PEyfzhTkFmW2l3xoJ56pEX
         QsrkMXCa3MEovQP1HQtjBmHWaP57Auwf01bCG8WpCKfFc1rLKiOpPQM+KXRnvTOjrwMO
         MriIY+OzSvRzznAM2Spt6BxsZRJQx7Q5MRjtofWvl1bdg4DIeF9jvY8JI0Ce0qiM+V70
         4N+c0Sceq8/27FXXl5G2Tuen6BBF7zIEaiBt41nDq5lfVI+DC//2pHbXROGKpS3KfQqo
         cnFg==
X-Forwarded-Encrypted: i=1; AKwUvBwlnGwIMYqLYIfnnITg6pp8v83hHrIfGEGEAWnXoxnFqNe4jiyyyXBMvXOHB3kqBSTdfSeJdTI=@vger.kernel.org
X-Gm-Message-State: AFuF++kH5ckWsjFZkkSZhKFpQFDeWvzjZ5VUQIEKu+1Y7uqgaalVkwba
	31jXXHO1ww2l25cjPXii3qeI3WztiXPg4vx8L0Uyp6ugz2x2qWG0WhtXon+HDVPNnCEfqkMee6s
	V/i0ETNFUalwdjVXOJ4liz6ZuvEohJvAfVkE6Y7QnFbovIrGu9LGq6uUw2zsrQd4dug==
X-Gm-Gg: AYBFou3gnSm9AOjTi/L+UK0LjvH0VaaXHXHIh4r5sLyM4WRlZyJK6eOq2pUwp9tHleD
	y5SBYVTj7f67sfNOeU5PObAEOcW/cXxNPQeYUpHN+ILFpLf2bBQHnD2WpysSN0pQlEXL5HjW5Mg
	ydlYBZVGfISqFJhNEaMAW8mmShGkmBYc4T7u+ppSK5/BbSAk7nqVK6lycfeG+6jAUanSE7TGd13
	jskg1IgtWBKWPtCZcHWHFKG3cpYTwQ1OEDQpZrMN34bTS2vQdAjt6cnFsb8YeS+4D90mlhRYO6x
	dfMuPVKH4/vHSno3WzU6JgjoIvUCDE1kgOn40RXIcGi43MXRZwr2F+4FmdPNY09lbhl9ShTxspx
	axsMu1jKWi37BMPSI2w+Z8fcmCWCfxgZ+LgBEHtRf4Z+g7afKl/4=
X-Received: by 2002:adf:e19a:0:b0:486:fba3:b95d with SMTP id ffacd0b85a97d-4871e2161fbmr20532339f8f.7.1790081385775;
        Tue, 22 Sep 2026 05:49:45 -0700 (PDT)
X-Received: by 2002:adf:e19a:0:b0:486:fba3:b95d with SMTP id ffacd0b85a97d-4871e2161fbmr20532296f8f.7.1790081385348;
        Tue, 22 Sep 2026 05:49:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862774882sm5070366f8f.13.2026.09.22.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:49:44 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:49:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vsock/vmci: enforce per-netns mode on the
 datagram receive path
Message-ID: <arJ5LVnY1y0MELJF@sgarzare-redhat>
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
 <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>

On Sat, Sep 19, 2026 at 02:31:57PM +0200, Bartłomiej Dmitruk wrote:
>The send hook vmci_transport_dgram_allow() refuses datagrams when the socket's
>netns is not in global mode (vsock_net_mode_global()), but the receive path
>(vmci_transport_recv_dgram_cb() -> vmci_transport_allow_dgram()) did not, so a
>socket bound in a non-global (local) netns received datagrams from peers it
>could never send to, defeating namespace isolation.
>
>Add the check at the start of the receive decision, before the
>VMADDR_CID_HYPERVISOR short-circuit, so the hypervisor CID is covered too
>(matching the send side).
>
>This was found by code inspection; I do not have VMCI hardware to test on
>(compile-tested only).
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
>Assisted-by: Claude (Anthropic)
>---
>v2: perform the netns check first (before the hypervisor early return) so
>    hypervisor datagrams are also gated in local mode -- the Sashiko AI review
>    noted v1 left that path partially bypassed.
>v1: https://lore.kernel.org/netdev/20260917220225.56200-1-bartlomiej.dmitruk@isec.pl/
>

LGTM, but please add a cover letter to a series with multiple patches.

Stefano

>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -532,6 +532,14 @@
> static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 peer_cid)
> {
> 	u64 access;
>+
>+	/* Enforce the per-netns mode first, symmetrically with the send hook
>+	 * vmci_transport_dgram_allow(): a socket in a non-global (local) netns
>+	 * must not receive datagrams it could never send (this also covers the
>+	 * hypervisor CID).
>+	 */
>+	if (!vsock_net_mode_global(vsock))
>+		return false;
>
> 	if (VMADDR_CID_HYPERVISOR == peer_cid)
> 		return true;
>

