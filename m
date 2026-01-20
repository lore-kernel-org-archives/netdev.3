Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDE42DFE1
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919511; cv=none; b=q2vi9KU3mBDCO+NVrhmLQlpUesoUh4XxvWtGg8mizolhSaD8XRmD5aq8zKLdSP6TRG+3QpLFr61n+ZoWb4PxNpZ8vLEPxnXpvsKt/UehaUzHdDdJ1Ky05L2NPiKDuynDTXQMEZdRFbkqdAtgXTL27yQNUIGjQjv/gFf9OFD5Z1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919511; c=relaxed/simple;
	bh=f11dCp7P6vtG0fXeypBN/abvJwiZ5XOizrijrXdkHk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtncoz+slQjoEVJLP6+FSkMudhL01+bbgrpT5pywTFiZIgecqCuIgh/A8B8oOMcR22TXmSL45ynOtxAADU3rtmlO35By/PdTZ3y3LCGEwnwWvTAd/aD8IoEmDt5ut2lIBO2aWIdAr8wV5abO/eedIV752C4DvZzJgKMSP6s95qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gvic49xX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XneWbU8s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gvic49xX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XneWbU8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768919508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trifWfZ7aWYVX11q/l4Y4wctobYfLQu9Hbg9myXq/us=;
	b=Gvic49xXejVe/bxiT/clgs696U91nwrJY5iAy85VheARyGOwHl/4PUZIUsNZtWPdz28Pyl
	fL3o7b2wYiU949P9I67SnITltI0y/qJnrPS63OYpGj6qUqTfalpumF2XpSRmS2CDQUzpUl
	RsA5Wqcqcs1td08T+mqGGHAELvsQgbE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-ysKV0GICP8Ou9TcOcq0w5w-1; Tue, 20 Jan 2026 09:31:46 -0500
X-MC-Unique: ysKV0GICP8Ou9TcOcq0w5w-1
X-Mimecast-MFC-AGG-ID: ysKV0GICP8Ou9TcOcq0w5w_1768919505
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fd96b440so3927380f8f.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 06:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768919505; x=1769524305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trifWfZ7aWYVX11q/l4Y4wctobYfLQu9Hbg9myXq/us=;
        b=XneWbU8sjc4f8R59+j/S6Jsu5KCs0lj6Hvyt11DQ/X+UqO9Cj7LTwQJcFGDy1mU1gr
         Wl+Bu7Pf2IwR2bT8MqFQLu2KbBLqokMT+qK/mCDLf7jqNUyoqYGt8YCzrlQIFh6y4HuK
         uKKmXVSPNd97MliMw14Rz50vSwenu/MNY8KDUEOblfwJ0SDtMIFiSEcvhwIwumVYwFWp
         GPLqio8yCRU5yRGcjjuKAay5gH5jYvF472UJfl/ZHpL3PRhD5oeAKTby/ZR0iAL7zSLd
         FVm7JU+UZAfOLbzJiUaTei4hCKR5olSeqeRNubOdV0om3iRZby2yUID3Gs5jfpKKhCOf
         pjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768919505; x=1769524305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trifWfZ7aWYVX11q/l4Y4wctobYfLQu9Hbg9myXq/us=;
        b=WWJykxUUrgF3S3zO37rF6HIJUqO99X2x3TC6zFfNblFYxu0LWiQi53jCLZzBhjAVQ3
         L74SqTirMTC3B+U8EEoaGG1OFXOEfH7GHuU78LOnyhnnGCpMCmd4iY0Fn+znWNz1XMkE
         /L0b2QkFdEec0itjDLSisLpV3tmjMKpRh5cYU1EVMGk8jWCMGXz15rbYSJB5/74BMKal
         ruBojb941xotZPyg2kbs1HMosdxd5f/m7chqwUbV77MKlIuia8cVOfRKcFfShR3FrkHy
         UmNS7p81DRobAIw8I1m8FrRyNoDyUnfypaj48Jo8RaHGpGGpzQB67A20RdgyERJx7Q/i
         oXdg==
X-Forwarded-Encrypted: i=1; AJvYcCXAcpadnpb9eDylC1b1RX5tD4KlNRILXO/AxXkvRG/O6bt23CPuQrVU2enehQVwT5TU8URbrX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqfA3+RlAtqe4BviZSozBOqFQmle02AbP9QC0EGP/ohAUUnv0
	SWmx3g2iA6QK3wonXhP4JQrVjkRNsKGuXhviXGp1Vgllmi4npDjBdAN1i+dVwNot/ynzNFTuk9W
	ysMsjddtx/AIsG/dv2PRNibsKiM69e65K+Vn/XYLRgvMwPWvIjQhbaNrndjK8KYZCMg==
X-Gm-Gg: AZuq6aLrFag1p5sNsNw0w9TJsqlgAPXUJ3vyFMpyIAxbmNNKkIS0VgvZlMsRAgKnTH6
	JWlWAuCW3j1Go6pTrKWn25INQRE6aK6xYQmu6Sxxn0+aufuD2lSiqPpcwqX3FDWfmFs9EO4A5w4
	swNApsixgH+PobCkhXYkvn7y2V5RETI4lOxGLFKdw1jnjfI4uls50Z72b6OuNfhHEFIO+usSt18
	AEWb8deOaYG3QHhnCTp9fMJMjUZJ22s3vpoX1WcctG2dG2SXsc/edgaafU+KdphxZF4x7Fc+O6U
	Y5PQfmA1g2nJeIWd4iilwgP3d3S5WNg+3k/6+n58suiR6Dt9exPzm6bpyU+WFx69+kKFOkMkcs/
	a6C1/O6u76G7L
X-Received: by 2002:a5d:64c4:0:b0:431:488:b9bc with SMTP id ffacd0b85a97d-4356a026502mr20090531f8f.10.1768919504566;
        Tue, 20 Jan 2026 06:31:44 -0800 (PST)
X-Received: by 2002:a5d:64c4:0:b0:431:488:b9bc with SMTP id ffacd0b85a97d-4356a026502mr20090480f8f.10.1768919504090;
        Tue, 20 Jan 2026 06:31:44 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356999810bsm29866110f8f.40.2026.01.20.06.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 06:31:43 -0800 (PST)
Message-ID: <001178f3-aea1-4886-92e9-1012ea6d6c76@redhat.com>
Date: Tue, 20 Jan 2026 15:31:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 15/16] quic: add packet builder base
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1768489876.git.lucien.xin@gmail.com>
 <e4753dbdd12ca45edef6815830c1bd437bd635bf.1768489876.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e4753dbdd12ca45edef6815830c1bd437bd635bf.1768489876.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/26 4:11 PM, Xin Long wrote:
> +static struct sk_buff *quic_packet_handshake_create(struct sock *sk)
> +{
> +	struct quic_packet *packet = quic_packet(sk);
> +	struct quic_frame *frame, *next;
> +
> +	/* Free all frames for now, and future patches will implement the actual creation logic. */
> +	list_for_each_entry_safe(frame, next, &packet->frame_list, list) {
> +		list_del(&frame->list);
> +		quic_frame_put(frame);

If you leave this function body empty and do the same for
quic_packet_app_create(), you could additionally strip patch 14 from
this series and avoid leaving several function defined there as unused.

/P

