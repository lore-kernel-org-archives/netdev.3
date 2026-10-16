Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081B3E7BCC
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144442; cv=none; b=iyf2ASptfJlAkkMEDbavbBo7anoukP8SQZct3lh3FI0HAuzZMBZJ0PkCAHtJod1kc7lB53wxLjBOuJgILKV3NR0mKcWCygVNUh5qZv8I5Gz8FkTwoIfU8NFly7fEYqHQeBIrZJ35wQSyUzEuRzYRXiDmNXlwY8eA5TUkKMw9fdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144442; c=relaxed/simple;
	bh=GZNsXghh6SZMQS0etCLAbkbM/Gi10aQpjd8kmsWf+hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruMcG4FMXOykezWLUKRGaRPjJcs+V2EkrGlIb8KVvNMH7626qPz7e7KRbnaVA4W3eckOSGvzwriCYi1fIbrZxNGxJVsFQ9b2ULaX4xP1sCVkGJ1Kav1Qy81lQVfIzc7slucVCgn5HrT/Q5EjXkLQ9QqaOk2oGyAJtiyzxPeSGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ur5ved8E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRsinRvl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ur5ved8E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRsinRvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792144439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr7WSuKask2p1j98eCEcwTF9HIf7GILCC9to1Tz+WQ4=;
	b=Ur5ved8ESuVlro1vNpLLOqn0DmMNhW3MzcwxgTEQlZ9oWcpYjN2Wf12nC8uulvHHrlQqB5
	PeTQD+4BbOiGGKl3GPqC6rQhwvGrKt7dEcFrJ5b7LL5jAr/3vwzkSh0MqBY5ixVUra5zj3
	66IqGl26U8TWNgWUch3d/iToqRc/mc8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Q4YhR3GaNvaCcu4l6Y4PVQ-1; Fri, 16 Oct 2026 09:53:54 +0000
X-MC-Unique: Q4YhR3GaNvaCcu4l6Y4PVQ-1
X-Mimecast-MFC-AGG-ID: Q4YhR3GaNvaCcu4l6Y4PVQ_1792144433
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e00f3929bso188319f8f.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792144433; x=1792749233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rr7WSuKask2p1j98eCEcwTF9HIf7GILCC9to1Tz+WQ4=;
        b=KRsinRvl36/aCM68UzJnt7n0CLzZfPDUy+IrjVbn5lY/RYeuQpi1H7/IoG340uv0hA
         Lj5aEd2tdE8jkW0xA3tGxDavnKGI9wQPBH6VlnC2msoaNNoRBbvrBzZsk2/ndPw8B4RO
         4lYk+VbLyDRthfEhu2S4JTmjS3Rbe/WQ9UfhzpQ2NCBmh+vP5JNcxra2577b5ZwV9il4
         vjB6QsPxCYUeWuOA2SuHDsMHVWtx3XcdYxb1wi8EocQELljwXUPJBdCmV2gB8KbT2V/l
         2j2OHcG8OPfrKJVD44kQ5XgRh60lJuv6u7pNQ+HqMFJLqma/OxY0csfljO1I3EXkm7PK
         RHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144433; x=1792749233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rr7WSuKask2p1j98eCEcwTF9HIf7GILCC9to1Tz+WQ4=;
        b=UwgckZpE8gSCDfbFpgHu9kPvWesiT/dDWSFUfkQq8bMAZb6TzVONuAhHKL3SFjwNEV
         jEzJ8SkVcKNlO98wNXCLhjNPE74QcJmv0ApqaPRwj31pNhg6Ft1BNiz2fC8yP0hiUVPK
         C39TNXbRkbnrhwuHHkvgmTFq7jT8npFRmOe/SsVZ4E1X7I4qcYxyyPA+p3Xsn3Ph5I6d
         9kqWAQ4xdv7gU3FDmi2g8QhLdLnGa+tjFYdIMgp1YKlAGeZDqbvt0g0+Kk1yB+SROpzL
         OpGwKEXmK3pnQx9MnTsbp5KS7+2weiR4wzGik2r0grRZ6zWlTGoJbB7EDIXz4LcQdq3g
         5k0g==
X-Forwarded-Encrypted: i=1; AKwUvBxSn8KWsncNxgSp0saxs0A0oNSq+EikTyYyO/JaK8Opkv85RcyLBoQ+uWSDCtXYuf478K9h+9c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIha27NnjR8OiZ5EotvYqHe942zXFQhNfuhEqTmllUtZVtcCSMy
	JSHAIDS85CePjfcHtjvzjL39mBgBLOeFH879xanAJZRr+chTOW+YQDhasYLyDZ2eOgX7Tjr7+yI
	iJghuJSLl79bfzIoflnUEn1N9/LXPNWwJwYsJwX7SNUvTTegOtXNUvLl8EQ==
X-Gm-Gg: AYBFou2nVx2wJhisBOKL6LgSL9T3vUnSwXqNaTI9Lir0LHc4HudlzOJpwAmIN7pUZB+
	w3nlZT2EMMxzpkTZVZvgTDpoAGZ7qUe6r5w5Ykf9KnzD9yU3Tmk5neWRi/cStEBkyekD1y9xmui
	SXWbtjvshGhw6cjT0P7V2gMXtL2xwwPoGb1d6zCXtK+ajubToz+nvyNDUcBXZLMD+KUMgNgsRA3
	ykBcLZyaqmJLSOeNDddLOqaZmE3bqVHv3FiKD+zcNBzUM50qdd8rzIfximTwiEH7UJr1+w3bzvw
	K5dOBjf+atCVOOV9na20m/TWqsETS0AFCMBjQfwLJFlTiOyEvMOjXL4rXu6amcDQk6jrmA==
X-Received: by 2002:a05:6000:26d3:b0:48d:f4ef:62e7 with SMTP id ffacd0b85a97d-48dfaca5f59mr6434748f8f.0.1792144432666;
        Fri, 16 Oct 2026 02:53:52 -0700 (PDT)
X-Received: by 2002:a05:6000:26d3:b0:48d:f4ef:62e7 with SMTP id ffacd0b85a97d-48dfaca5f59mr6434697f8f.0.1792144432170;
        Fri, 16 Oct 2026 02:53:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a72sm4456837f8f.4.2026.10.16.02.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:53:51 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:53:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261016055312-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
 <20261016054142-mutt-send-email-mst@kernel.org>
 <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
 <20261016054558-mutt-send-email-mst@kernel.org>
 <77e9eb61d0e81ead5d5840abb95ffbd695a4e513.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77e9eb61d0e81ead5d5840abb95ffbd695a4e513.camel@sipsolutions.net>

On Fri, Oct 16, 2026 at 11:49:14AM +0200, Johannes Berg wrote:
> On Fri, 2026-10-16 at 05:47 -0400, Michael S. Tsirkin wrote:
> > > > 
> > > Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
> > > and -ERROR on failure?
> > 
> > After this patchset, it can, to signal slow path software checksum.
> > I'm changing callers first so that changing the function itself
> > does not break bisect. I should mention this in the commit log.
> 
> Oh, OK, that I clearly missed, but also was only CC'ed on patches 2 and
> 3 :)
> 
> johannes

Right, I am trying not to spam too widely.
Indeed, this is why commit log should explain.

-- 
MST

