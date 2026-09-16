Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C604AAC62
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573132; cv=none; b=m/wW5XEQwI9L0cnAGYso1bWYZp46+XYCtNlLotCkqDFNXrTfCA7oy1t+fMQ3AH3FoyowEC5RNHE0/j6vlUjJmHb2fWXwcItKJ0P15WfTAG0CMxSWkG8pzJM/UjwF13Xy8fUaWs8+pk/lcMhT+sbLHNHMHwC1+8yMQBMzRCDI5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573132; c=relaxed/simple;
	bh=huEs+LEHo8cFHfOkkR7JHzzpk8mAxFJ2h/PPE9NkvtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBwwxJKjqGcJ5dqOo90gA56KDBLbIziyyRmLqQDMmeWFBs9MAl1rhJ30aWlIh3pbQBU+6qmqbb4iJbNYy3CmWbf87eHEHfCffePc2GXqitP4ij9Bd9Kz47ugkFk3WxRpvMvV6qvAcC1qNlkI3NKZI9rhIYlWYxJ1ifkKKhb17J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhJDkRgu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOe2/Vn1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhJDkRgu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOe2/Vn1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789573124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJCqqA6Q4AOgIHS7UBKFb/3fKqTDi7g5pa0Z96svO8U=;
	b=bhJDkRgujq0iWc9JPmHM0rD7BoafFpOkDfsW/CHeLT/A99pLbMQp5Nj6kU18QScFiyA3hq
	PCyUu2zVOQQqC3VsPClc8/rsYy1UOgLK0SQawtWDOxKN6c8SyTY5lmh6Q1Oia8x7Zeq8cf
	ZDWskb+i1dSydTGijN0hXFlgHkvKNT8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-zgOLfIn2MQiDQe6GE1ckbQ-1; Wed, 16 Sep 2026 11:38:42 -0400
X-MC-Unique: zgOLfIn2MQiDQe6GE1ckbQ-1
X-Mimecast-MFC-AGG-ID: zgOLfIn2MQiDQe6GE1ckbQ_1789573121
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-487038bc9b8so2025056f8f.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789573121; x=1790177921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QJCqqA6Q4AOgIHS7UBKFb/3fKqTDi7g5pa0Z96svO8U=;
        b=cOe2/Vn170kHRte8QHpTEwRT0IGE6bNpHwsgcDSTrDNKlxg1DaMWVpOopu8uj/JNY2
         4q7Lv3421UqsGckKANvR3YbYA+CrzqYL+MC8vvBx8UdFQwrwDAwlpJnYTEq0Shr+0PMn
         fqtmDzko+Xu+fCdbLWSafAAWBBdx/oYBl23qCChtL72+6NFHUXMSlQxzrwfHl/l2WbVz
         jJs4vBlUMPN3lEkzmHxFTamcl0dgzXm9hSnabfXsQk/lNPVC0uuoDil59R6y8Iatw6VT
         sYHYWzQ4fzyQkEIbhK8Tllwe2Q2jzJGNaHsN4OYv8YYYE+IJ75eCtcg7KT2Lhwxz7PnV
         SDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573121; x=1790177921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJCqqA6Q4AOgIHS7UBKFb/3fKqTDi7g5pa0Z96svO8U=;
        b=MOzv/JAvFsCXctmrlBhwPAo3BvG1qX0kCFFtEXIwETRYmjcj10bUqFueOYZxQ7aJRQ
         JNz5iDeNPSINSs9eiCc9OH/OjsUpn0Mi41qhkfo7E7Be5lbbpYM6dLLfEZE/Yv9yTqsQ
         zgyDIFFHAZfhX5BKXZtEXY6MkXMBoWUff5wys7P1XjcQHJMChrl9lJ5qEkh7bEQWffvz
         nSMFpm9x0IPbc+7OkYN9Am/DzBI6pFh4JpEfwvH67VQNW3Bt/B17inmpl9R71U0Z+koD
         oz1udqiIyCudi1J/jVzdBziXgyt2/uYTTKAQTdsbxUEchTyj9rQmbFXSo5AbIKWjPIlT
         35KQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWXJIGxh3ZMfAF/+T/gc3xqFPG6n8l93ep5etBI+seKMakCpcgacNBrg09p+Lez+3IFvSEVyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ku/2n1BFvbSU++u5fJBRZSBpCzBIgfmVFwNGs0IosFhnrgC++f
	RDJJCBHk3zHrxjD7I3IqsSRZ14xGGBUMIPhC4C4ChuW+t79oQWa1pmEKGkQ3sVmTjG+EnUy7CxW
	lhLnMZQ23Sl/ZLUlBu1aYbxPP/AwkEwjH18sJ97qaG3RJoXhv98prR6X3LQ==
X-Gm-Gg: AYBFou0f0LE0jY6KLS2WP5TDCy7ENXx5VLMhL55TLPLRWIk6nzJ1VpTCYzZxS3Fy8lY
	BHNX9L7CfL/EXlwTptqfKdLw4n6JD3YgcBSDqTb0ZBsqlSz4njHuL6JTbrlUjxuTnd8L/MZbzKS
	FwrfFjBmirB0Z6U0faCL0kOOb1z2HhWNsXg2oCF2uQoR1l4LgdLHC4tfpviN3MhAF3qJEasrTzS
	k79ljUXllHRlXHaRY8unvsaXyokkyeCJ95vdFGmPvWk7QLQRwwXDjqgM55RLrQ2j3AxNKiWM0r6
	PW+79E5UFH5CJmGE7hVH1ddUfm/zIJW28ONm75ojJSayTcvWig2D/j7XlKOBks1/HYsIRsP4tkC
	WBMfnjVGOfD0GTEdQPYTffOPLInQd6z0JttOP7W5eVJ0HWw==
X-Received: by 2002:a05:6000:4711:b0:487:fb0:9ff with SMTP id ffacd0b85a97d-4870fb00af5mr2913402f8f.22.1789573121090;
        Wed, 16 Sep 2026 08:38:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4711:b0:487:fb0:9ff with SMTP id ffacd0b85a97d-4870fb00af5mr2913360f8f.22.1789573120615;
        Wed, 16 Sep 2026 08:38:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fad3sm7165977f8f.12.2026.09.16.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:38:40 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:38:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	Luigi Leonardi <leonardi@redhat.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] vsock: ignore empty child namespace mode writes
Message-ID: <aqq3t5p0hN2jsSpT@sgarzare-redhat>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
 <20260915173050.3176344-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915173050.3176344-1-qwe.aldo@gmail.com>

On Tue, Sep 15, 2026 at 02:30:50PM -0300, Aldo Ariel Panzardo wrote:
>__vsock_net_mode_string() returns success without updating new_mode when
>the transfer length is zero. Its caller then reads the uninitialized enum
>and may permanently store a stack-derived value in the write-once child
>mode.
>
>Return before calling __vsock_net_mode_string() when *lenp is zero so
>that the helper is never invoked with nothing to parse and new_mode is
>never read uninitialized. This also prevents an empty write from
>locking the current mode.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>---
>
>Changes in v3:
>  - Move the !*lenp early return before __vsock_net_mode_string()
>    instead of after it, as suggested by Stefano Garzarella.
>  - Add missing maintainer CCs per get_maintainer.pl.
>  - Add Luigi's Reviewed-by.
>
>Changes in v2:
>  - Return early instead of initializing new_mode to the current
>    value, which would silently consume the write-once transition.
>
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd0467..XXXXXXX 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2879,6 +2879,9 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>
> 	net = container_of(table->data, struct net, vsock.child_ns_mode);
>
>+	if (!*lenp)
>+		return 0;
>+

I would have moved it even before the net assignmet, but in any case, it 
doesn't make much difference:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

