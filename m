Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5148823F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431622; cv=none; b=moYtGYd9hREXWyjY1HVoLdAiFfHdavjBpyArsimbazUEW15aqiIDkXfWggZyj4PJbI0AL1P0QYrKlqiqfjxoBGq/Mz9jJjDLBzWhlyO1wa18hPTCBLKPb2pOyeh7t04G4hyvDSVpDt3QogbLj+UYcQeLEzbbQPGqSXR0h2bE5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431622; c=relaxed/simple;
	bh=INC/gMQ52XGV0tXzKdQk+QdM6fsrXDjrQLn6+41iXMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrfa5Wh2BPn86ULhqpstM88aPTLnOKyCcRrm+7dvlRwN3eW7bSFMOcr2AUetiqIve4UAWnFGSdfdQHeU9uhkj7LpGUIJEvm4ZV2oXglTYM1k9E2EMODhFqLG8ZU8Y7p7jExDWx32yNFQw1COxGlXSj5E9oNEe2P5C3nDdVWRnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIwgx7R/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyuDZD9Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIwgx7R/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyuDZD9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788431609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJZUMdrfC+SOHHgYZ50yWaWhgHW7YjmLUKRHwooHUww=;
	b=YIwgx7R/YxvbrtRYISA8z11nIGy2Qnv0gffwY4JftuErIFBUhuAW8aBAQM0O5Kp78mys6x
	SXfCKZIbrsDv5qMvdaG9KX/r7MIEdGWhZ4yOnYkwJi2TnlT6n78Pa8uKuC5BCYcIV88yqV
	IAGEh7r25uUPfnJr65cv6nlFbc8o4vs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-0FTxSeUAPOWAqIEKrH30HA-1; Thu, 03 Sep 2026 06:33:28 -0400
X-MC-Unique: 0FTxSeUAPOWAqIEKrH30HA-1
X-Mimecast-MFC-AGG-ID: 0FTxSeUAPOWAqIEKrH30HA_1788431607
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2542cd4faaso254571266b.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788431607; x=1789036407; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJZUMdrfC+SOHHgYZ50yWaWhgHW7YjmLUKRHwooHUww=;
        b=gyuDZD9YPkC0tx/a0gdvuXXQOEfFnzbLBB+kFvCG8Lpbvm7gntq1Mwiu1pM/ovE/Uk
         OnDA5sP6+5wBW3w2Cdy1GKTGcFxPl7N98yIpEX5zqmjymjmy5q83xPN0TjTKI4+1wfQM
         8ELBokR9UnSP54MhNGFWJbNp228OSIgZciG9f6LlQmLJy80MWwZO+AXemyO9Tdv3QqUb
         4QCbhCrNeTRfGUo9cV3SrOKyro3JTamWob8Wpzhz3UdPVE33qxRYeRx8vUZkHP8m/02e
         TB5SnuaEj3tq92A4NNAMlLbdADFc16nMrwiS1EgTdEaHlVhDne58tPngodi9kHsaMg30
         otuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788431607; x=1789036407;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CJZUMdrfC+SOHHgYZ50yWaWhgHW7YjmLUKRHwooHUww=;
        b=dK2xM0hacm+cDS9KlVNxG0snNRQjVCleCH6Xesa5623OdEe+9Fls61XTV2S8QQ7sjq
         3UHesiUNQLZ2faP8IMCgDSQhJcF67iScHgs4HYpwmQMRZ6E4NxWsYDpM/eLJb2X3t1xa
         Ave26N9Lcg/U9V7UL/4Bwm8WW1XgIV/W3gnMVzMF/Glp80XUx19Jnu9cv9j9vPxiu+dk
         7qenQrJcf+9bEpcxCWX4PKTmDnzzB5pOXnLGfkQnehLvTr9qGKbikS+O58pFE8Bhk8Ao
         GzBMv94/XMhhogRd116O4WqxeL03xEn/yPioZc7kQcufpgZw/YcC3EblLhs7g5TeWD4A
         cmGg==
X-Gm-Message-State: AFuF++kB3ZBjt63myMxA4g4tNWxdcKGx54FIPV7mVzKecXMTyiUc+Yfx
	0idGboMWOEwWUftdPu63NZu2EeHYuL+Umq261Alwow8xhDqFdXvN+J5ht+0AXwdZhvnto2BKfTY
	XRs8dKSBbp4Hirns1bcQX15K3JW5cr14+O5jlxD9IXJfR2NORfYWVViCBn7RIyI/OoA==
X-Gm-Gg: AYBFou0LChSbh6/EZGCQsUSv2YAenjAhK1ZeEgA0NCr0Ci8fPk/esN+7QmFCS+whjTC
	6/Q+eVHw/z22i6uF4j3aH5SyjgrwzN3/RziBKMPwDCqErDnQFNJk7yh1HjrKZLoSu92WfCoqm2P
	E1g7bo01GFymF6TpL35ocUL9GnCDRZcKEtJkNKw6rmak33Ox3pYnQ7yZBgRmMKKLFBxGOWOtrsw
	yGgZEnPykL5yzPPYaTPCWFAIG5OcdqnS+5ei6VekD+7BN+7b84fqMHRnz1jYm7yoIsBBpnNk1tf
	bNPLQoFRRPKkyLJgcfi9oGuHZhfrHU0CWjraAGFZ8Zn1UsEDsjR1VY0x0BD0w6pWWA5jJks99G4
	AjGxs3KSfYIU80Omatf83WwR08Yb8z1IJkfe38dYlds8uCVDj
X-Received: by 2002:a17:907:198a:b0:c21:8c6a:c680 with SMTP id a640c23a62f3a-c25d563b583mr789072666b.22.1788431607073;
        Thu, 03 Sep 2026 03:33:27 -0700 (PDT)
X-Received: by 2002:a17:907:198a:b0:c21:8c6a:c680 with SMTP id a640c23a62f3a-c25d563b583mr789070066b.22.1788431606639;
        Thu, 03 Sep 2026 03:33:26 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f3eed0a9sm82869766b.1.2026.09.03.03.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:33:26 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: openvswitch: don't schedule rebalancing if
 there are no datapaths
Date: Thu, 03 Sep 2026 12:33:24 +0200
X-Mailer: MailMate (3.0r7028)
Message-ID: <61F294D1-5DEC-4DF7-999A-3E3DC8984897@redhat.com>
In-Reply-To: <20260902203200.1416026-1-i.maximets@ovn.org>
References: <20260902203200.1416026-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Reactions: disallow



On 2 Sep 2026, at 22:30, Ilya Maximets wrote:

> During namespace initialization the masks rebalancing work is
> scheduled and automatically re-scheduled every 4 seconds afterwards.
> This is happening in every namespace.  On a large kubernetes node with
> 500 pods, i.e., 500+ namespaces, this creates a decent amount of
> unnecessary churn scheduling 500 jobs every 4 seconds that take the
> mutex, check that there are no datapaths in their namespace, release
> the mutex, re-schedule themselves and exit.  These 500 unnecessary
> mutex locks may hold off operations in a single namespace that
> actually has a datapath configured and has real user requests to
> handle under this lock.  They can also add delay to removal of other
> namespaces as ovs_exit_net() needs to take that lock as well and
> synchronously waits for the work to be cancelled.
>
> Let's only fire the job when the first datapath is actually created
> and not re-arm it if there are no more datapaths configured in the
> namespace.
>
> Another approach would be to make ovs_mutex per-namespace, but it's
> a much larger change that should be handled separately, and the
> unnecessary work scheduling feels like a waste regardless.
>
> It's safe to check and re-arm outside of the mutex as DP_CMD_NEW
> handler will re-arm if the new datapath appears.  The scheduling
> attempt also doesn't change the work or delay if it is already queued,
> so it's also safe to call multiple times.
>
> Skipping the re-arming is more elegant than canceling on removal of
> the last datapath as it allows us to not think about potential race
> conditions at a negligible cost of potentially one extra re-scheduling.
>
> msecs_to_jiffies() moved to the macro to save on line length.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Thanks for looking into this. The approach seems right to me.
I did some basic testing, and it looks fine to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

