Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A948D3F484D
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391762; cv=none; b=jUUm3b7aecFNK0sKkTALpDXbhlJ4yNuXAWXXk2izJFbu8vNWNqxHydPopd3wZDlQuGFkAQZ1LmtnJD7VdRB3xLBp98Huuaqum/8TK6EEeL4f/Z3spklUVSs8FiK4tJF0T6yyFilIjgH5Ce4kSrYU2b6MmIcF9S6upsC3S3g34iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391762; c=relaxed/simple;
	bh=cpHu/Ab9hWMJF6Z4DTeDk2whHxGJNeyuGs8ZqtJL9Mw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fwZ2E0hxhPgKRPelplFqbFEiIu25WaxAPukYCzrB8VHuNHk8+lnRTwexDCngf3oqMttcWOYrs0TL1hEOnL1JoL42Hd8EDGVSv5tZm4XCH8n7+kdGrYyoIZwjgznTKi0vbvC6x525I31jeOdLZk5RWnomI5WJlNMlYS6h6L/0cNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I81WpXzm; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I81WpXzm"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8200ca16f26so1888147b3.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786391759; x=1786996559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NYi8TQhOsIhzCwDYKkiONDxpI1ONG+02WyHRLWedD7g=;
        b=I81WpXzmZHLzk5WKP+2UzeSWmDIFVJRy1AYZyBMYqEhUfdTxEm7fAWmSFqH/yFN5ua
         dTnS5Jq4M4GKV4/PBx5LOgyb5m/cDWsQRFvDZaumWqtC+IenlSMm8AVd9VTpuYbZnF50
         IW4y0WyXnMDauOc/itCVwQCvzgG7twVWtp8TSRnyb4/nNQhGEVjtpCmIX7DGZ2klUk4A
         1WHHn0eU60fM2MW+BNrKvvavEGbeYblUPfM4eovxXgURGki2w8w9jVvzI35/Oydry6os
         zH6HabGIF7EpitTfVdlwKPV4UgL3Etpi9DyzwXtDn87LNNWtdUMxGpLyd8hNBMX0qzIR
         9NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786391759; x=1786996559;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYi8TQhOsIhzCwDYKkiONDxpI1ONG+02WyHRLWedD7g=;
        b=IP1xYcUJq18CMboy222O/xxfG6xDfPW9kcnz6pPx3a6QUS0z8Zzgf2ovTLr+Wgv/jG
         5Rz5lxjz1tswMYVROo72Z63NO5kmnWj+I8tyk0T9jD3st7SaoW2vfRrxuR9fNrwQ/NKQ
         2jgsv5yO6mpDk1ef9kKdnZVtzsmS1WHcL6pjHc/J4ibZl1dOrqNrJsiwHNNGg6j5n4dH
         OyOpXllVg+HtAeCiPViv+NGLC62njxh0B4cwWZ8yeUMZrC85KvCUKN2gSaCVCPUcccNM
         rXWd6sYpWAU2ItaZr557QFuV5CgAlS0hp61EE5+UuGCXey5OA9eDFMrUrbH6dNV2hLAG
         jyNA==
X-Gm-Message-State: AOJu0Yw4tyEEZdquP8rlU3IknKLksHgORgHBb8t0hWOeqTCVBn9EKSX0
	GNa8PQ3eBmSvUQ5xhABugu5fretrLatH9hoihU1Bn8aCGj7GOyUByYXX
X-Gm-Gg: AR+sD123ULr9MxBJti23ZvvUee0gyDW3N+f2MHAIoLcmO0d/CvQYLCZcL0sRHR1eUKy
	vORjlUsB1EnAVGjPPkXOjjcvJI4wqz7QE39Cjrv8MjF8aH91zfINUjwUZcbTIPtviD3ePY1GZzd
	ytiQAE8w4TYqeJ89xawTI8hoe61LBp7K8KiQCIIedS7iP+ExJB8YpKoYz5/ndvkiRv19bd+fn/e
	VoEFKOS48yImO2L8kUkPQrsNC3kTdr7vJny2wyhdbBZsNobiyP0nH2JRuruZ6G+W2oFZwYUx6/N
	rAon8Jr/xFWS1BFunkgy/Ry7BzUNGq4sml1mBTdhoLXlPciy5oS3SaUvwkpE9sPdoAFvjDhKSLS
	deYt8jYj0VXe70ki7xGXGLBxKo2cUzKOS2A4eQfe72Pxcr8hpONa+RIA7/vi3Y33IjfKrqup4sm
	GecJP9bEzgfj5/Ls2P85VIxTLCom1cCe6FNU7lR6qCdobYy06pXXG3pGb28El7K4ChQ6ldVh9U1
	o1HWjfqQbkmGuMDewyMH4j6Bu5kB+k8Ups1
X-Received: by 2002:a05:690c:c8c:b0:7d0:79f:339f with SMTP id 00721157ae682-82022504c69mr289452557b3.34.1786391759407;
        Mon, 10 Aug 2026 12:55:59 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f74c7590sm62472597b3.46.2026.08.10.12.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:55:58 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:55:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kuba@kernel.org, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.4b3c3ba47526@gmail.com>
In-Reply-To: <09030f3e-811c-48a8-ad9c-6bf9432e73e4@163.com>
References: <20260807070914.112698-1-clementwei90@163.com>
 <willemdebruijn.kernel.2e2d53367799a@gmail.com>
 <09030f3e-811c-48a8-ad9c-6bf9432e73e4@163.com>
Subject: Re: [PATCH net v2] tap: fix incorrect variable used for USO check in
 set_offload()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> Willem de Bruijn wrote:
> > Rongguang Wei wrote:
> >> From: Rongguang Wei <weirongguang@kylinos.cn>
> >>
> >> The USO features in set_offload() incorrectly uses feature_mask and
> >> features argument.
> >>
> >> The USO feature was written to the local features variable instead of
> >> feature_mask. All other offload bits (TSO, TSO_ECN) are stored in
> >> feature_mask which becomes tap->tap_features and is used by
> >> tap_handle_frame() for GSO segmentation. Without NETIF_F_GSO_UDP_L4
> >> in tap->tap_features, making USO on tap effectively non-functional.
> >>
> >> Keeping the USO handling inside the TUN_F_CSUM block avoids enabling
> >> GRO/LRO when userspace requests USO without CSUM.
> >>
> >> Fixes: 399e0827642f ("driver/net/tun: Added features for USO.")
> >> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> >> Reviewed-by: Willem de Bruijn <willemb@google.com>
> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > 
> > Substantially changed patch, please don't keep Reviewed-by tags across
> > non-trivial changes. That said, I do agree, so adding it again.
> > 
> >> ---
> >> v2: Fix more incorrect variable in USO check.
> >>     https://lore.kernel.org/netdev/20260806163949.2807698-1-kuba@kernel.org/
> >> v1: https://lore.kernel.org/netdev/20260805072121.117472-1-clementwei90@163.com/
> >> ---
> >>  drivers/net/tap.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index 5d2d34d24ce8..d4ca2fee538b 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -883,7 +883,7 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
> >>  
> >>  		/* TODO: for now USO4 and USO6 should work simultaneously */
> >>  		if ((arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
> >> -			features |= NETIF_F_GSO_UDP_L4;
> >> +			feature_mask |= NETIF_F_GSO_UDP_L4;
> > 
> > Drivers/net/tun seems to have this same issue.
> > 
> > Do you want to take a look or shall I?
> > 
> Hi,
> I have check the code in drivers/net/tun.c.
> In tun.c, the tun's all offload bits go into features argument and
> I think tun.c does not have this issue.

Oh indeed. Thanks for checking.

To repeat, this patch LGTM.
