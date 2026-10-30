Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389954;
	b=aIoX4uWa+ObTO2BhY4FdAnYysZ2lSn/fJuo/xGBzdJHFLYShTwfzGO6iixKoOvhGVaBF
	 fe2m3u2L17wsuvT2dh4TDIrjpoQpltdcO9ZZwTopRB2VF0rcjD8KxS/Ijppt4Kmv7JQKk
	 OV8XLlJHaOPhWIObQwqXlwMYTL+FCaoZII7TwL9pkGYIOHXK38n8HP6pZe8dRbzGHfmK8
	 CREOg6UNbLxcnITEYggN4gInaAhcJzRTekDjS2hyz2jnuH8FG7E3S7B3yrw0ijEQjtkLy
	 qP//2Osoe1nErzWsouZ34/BwrUkYI7G+6LmxdEircw8X+orR5naWt++fNVE8HP4q5jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=J2FNx9D7Jgf8hIvN2HsGFMpO76oeiBS4WlAa4ihS6JU=;
	b=BXa/RSj0kw/3qsjgBhvtS/NQvQXsRPctmnxRtBfybxDzAXy9aH+cUtFGkiRZXhyuoyWO
	 UJcUqK3rvhDH064wP2O0642RhJWfkEwg2sYkPD94iyRxZCvGshTgsD32+stMt4gRvC94J
	 lbPauFh0TA52pNpkK9yZN6MJIRT2lLqe/VGLjwuRYyeZu/Q3XLIM/vXyzIbeZ/xVDFA/y
	 HUXDKwFVvLORwdnntsWqKRKK08Vi4g0ezUM5CSxAmzj4VxkQoetN2PoSK7ZZZmORNSyba
	 GX375T9vGP1YAMltVjftw6GdvalmznlJmkzWClSeB00/jneorNw8SMxXktC65CFFKnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=seQZx+ZI;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9432606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 19:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9432606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=seQZx+ZI
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso5799415e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793389952; x=1793994752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J2FNx9D7Jgf8hIvN2HsGFMpO76oeiBS4WlAa4ihS6JU=;
        b=seQZx+ZIbtq0KWnnRxo4qAuwbIfTV5M5Tt0hFEfcSZpVC/4qfxmXWAlgHkvqs7Fonf
         JP9ViFl0pEjC3CgF2HUO/WCVpmZY+4xvkwXY9cPeunqWxhvuyDIEWExuK2UJ9XZHsB7X
         PDv7KIS+vlLZU1gFWI219gYmvfDLiyVupNSrvHopLA/QfLBv7T0XmQvLIAVp+djwD5TH
         ftdz9KJ7ZJzUPr6GsdJniA5JJ+WDGjkb4enwdnu9d0Dn7D26fpf94Xjl+44GXJcWIRJX
         HeXegDYhhwLj9FqGAtu+EzOKHIf70/D95SuRDpU/wFukrpVI4VUn5VkLvVTKg65k0l+M
         /aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389952; x=1793994752;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J2FNx9D7Jgf8hIvN2HsGFMpO76oeiBS4WlAa4ihS6JU=;
        b=GnACsCp8AoSIjLUaXwy97a3OP0FURSdcj99NE2P8Y1E11lyiB7M8edUr/NdCpssWBW
         AWiUYhoZZ0k3JcQx/8qxudMrkwBGAozINcu7JE5hglrtoIosFev0PP4dSDqUc0HmQbN7
         4SfaMDwB8RGFMINIJF2LMvKfOccOZ81eIn9UfPYXoM+WHAKUYAYrXRGFr+oD3trJSWNQ
         7hFskZ2JkMHpdKZD2ZHkFHf6abjS7M+cp4mqHv/yCcMuaaaTfFN86nst7rVaJHfio0Fj
         0xfZaI8cBz3sz9bR7R8lrFjb+PnNbUuEIsjZIqsiPcRjjtxcfEZai9BhxE1D0ed+seJg
         KyGg==
X-Gm-Message-State: AFq9FYJDnPELHK0tXfPh1rPW1ZPuRzVRakI0JY+T1ZP/m8DnTTuHoWVb
	6o4ASCCEpHyBqqj1t7f5eWnmUxLBneu20tjRleFSe4Oq/S3c09ZVYg4S
X-Gm-Gg: AYBFou1hF/LeS3jKj1ws0nQTBf5uKF936jWySTNI3QqooaQE5t0UBNOKt5ACfWkplKM
	FRoTYrNL/fibzoxQIvHWqa4OE1j23zj7Fxggf4afQv+DSdonWhfa4fPopDmtD95Ixskd7CEIGTG
	pC6vMcZ/8HEipK+Y4wZZ4pTC6an69yed4c0BB7l76jj+bCzkQR7H6ULFfePu3y8e7MhRtwqyIyq
	/nSqIqe8UQ6zHiuVagwFDu3kpNew/wL37tk8VZdgcYinUqpMUqTTjTchTkFlweSLNSeLXJemE7C
	aFeKXoMfSkbrhmRxlqZzUmo/r+SomwKKQlwkPb4zriMSyp5fbMeWUdopY827cUBfR+gff7RMwhO
	bpPhtCibKrkeO7joo7r4XFnStaV7pPNSBLO+TqH7g/thA5Tjvarh7QSoP6EjnzQt3M010Jcbzn8
	+P5CK22kOTASptDxEIol4BA//VuCfMh+FGAdh5orLRIZOmwqJavJU5/MgMzvDMyprfZdfUuvY2T
	EKEWVEJWnLV3/oCdjrNiCi6hNbuv9+KWpKiTrdtIgDG7eExNBR5IImSRAMsaGIEiFAy26eWlX6m
	Hxe4dphW5M24E7nrz5Wuxu55lTnyMpgCQ3IOisTq4tMfV+7c/aVsC9DwXQcVVnGRu264hzkyIpS
	Uh2YoxD3QZ3E=
X-Received: by 2002:a05:600c:630d:b0:4a1:fae2:a8ab with SMTP id 5b1f17b1804b1-4ac150b38abmr73624505e9.3.1793389951966;
        Fri, 30 Oct 2026 12:52:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm179193345e9.5.2026.10.30.12.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:52:31 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:52:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hangbin Liu
 <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
Message-ID: <20261030195229.50841726@pumpkin>
In-Reply-To: <179338190237.9376.13820542101227461550@gmail.com>
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
	<20261030160532.4832d994@pumpkin>
	<179338190237.9376.13820542101227461550@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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

On Sat, 31 Oct 2026 01:38:22 +0800
Zhou Qiuyue <n0ps1edzz@gmail.com> wrote:

> Thanks, David.
> 
> Yes, in the redirect case it passes the old rt->dst.dev, while skb->dst
> has already been replaced. That changes the NF_HOOK outdev, so it
> probably belongs in a separate fix.

Does that actually mean that it doesn't matter?
Or has no one every actually used that path.

What holds the reference on rt->dst.dev?
Something needs to stop the interface (I think that is what it is)
being deleted mid request.

> A bare rt6i_idev or dst.dev pointer looks unsafe, since dropping the old
> route drops the refs they rely on. An explicit hold/put could replace the
> RCU lock, but adds per-packet refs, and doesn't avoid the deferred route
> free. As far as I can tell, that uses the embedded dst rcu_head; the
> temporary rt6 in this path comes from the existing HDRINCL lookup, and v2
> doesn't add a new alloc/free there.
> 
> I'll test moving the RCU read lock before l3mdev_ip6_out().

IIRC the rcu free happens for every packet and uses kmalloc() to add
the item to the list of things to be freed. So an extra reference count
may be better - especially since it should let you do a not-rcu free
of the temporary rt.

In the non-redirect case the temporary rt_info would have a reference
count of 2, one owned by the skb, the other be the sending function.
That would mean it could safely be freed at the end of transmit.

I've not looked today, but I remember this code always allocating
an rt_info for our application that was sending udp using raw sockets.
The app uses a different raw socket for each thread that sends udp
in order to guarantee the sendmsg() doesn't block anywhere.
(There are associated udp sockets, they have to be unconnected and are
only used for receive - monitoring 10k of those is 'interesting'.)

David
