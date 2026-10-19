Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430599;
	b=S70emQvlbbxiqILbj6l4q7XTfUU40RWM/To8YroYRkVID5biX5MGCMbjM07yHWoIgZ4y
	 RzC8Qiw5iX0HQadcJ0V+k6o7pmlRZdU34mqVM/fgxL/oRVgFjicWlR7uMOdJnROhM1Qms
	 UqtFnwMEwiNcdecx6/KY1wScvVF3uyIWX6HctyDTM5bNCWfBs6lpNPJMZt9+WZVMvU6xN
	 v2IvK1tLzoG5ZQ4LKc4lnuR+uBu80C01Nd0tXnR0udREQtbaKmQAU6BBVmmSeFMBE957y
	 cMQ1bkL74lXTEgq+pqgYCWbRDmaif0WNkcQkljggfr7UB1EV0STuax1cPjVNaOighHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430599;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=EMDpbB3CxwiBF1SQLMON6Hsm8EoiYIXnJmRWnghfQ0E=;
	b=Se40F1xQDcphOfbFPPht/yEw+LVZ2qiZJDXNjoS2GtbPuom+x6LiYZ0+Vof/faOQOKwH
	 So3zgpHfhFKYXsRWfh0kfniFwGP8KBIPS+CTaxoDT8g5iUC/8O1BuTOXy5aiuGLakVtG4
	 s/Hnp/tkTOdsTtyzEbU2yoqzmnL1Ixwso0ap9BwQt7+qGriHWfVkr//63QZ3zsV9Mjqzj
	 56WciSBt63pSiaK23w0ByOurFGbPGzxV8cm3Oa2c9Rqtr82GMEjCmI54XJ/NwL+CL0SQl
	 gFVB6UjbMh5UBFimm8XH34xP4ThLMp3dO7EcW5LgS3njXNrHhWpWkvvnGEqjSkqnLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeOdFPDV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3E606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeOdFPDV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08B31F000C4
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430598;
	bh=EMDpbB3CxwiBF1SQLMON6Hsm8EoiYIXnJmRWnghfQ0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DeOdFPDVMZBLEYwsdaS9TnIsSeyizZp/upO6QGIrQMqcmEHjHC2hGxrIAXKn/5Sse
	 WHAxKDlQq3YBpT95kKuJt+31tS+JBGbGNzrVi6jdc3P8HYEYaAAwZTc08DhT8Pu5vM
	 skMim2PAvOfvcCTV8X8zfYA9BfCz/vSOgHoz0KfVpkJVzx2Jy2Ld1M1hOb5LTJj84C
	 tmgPa2XfG65/ETWn7egrCIne8VrnlRi04aXLwniAVQ7/CccbBMjUUY0MMQnUyY3A33
	 8PZyrUpI10+SUGKQJkST3TRj2icqnQdzPpmEIrCS3Y/duZ1qwh4RxPQoGtzh/1a4NU
	 4aI19BPbuFhcw==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f84a55e31aso1383183a34.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:23:18 -0700 (PDT)
X-Gm-Message-State: AFq9FYIcNzGYY5VDgBhVc4xOBhaP7XFZ7+OukPpeA1sLetshIkVF3CRr
	Zmt+iAiELpJSdd7M/aMVH+n9or20rKm4KptyS0em6Zts+5N5CfqOU/I7ogmoDmyTD/LM6YVyStQ
	7P30EtYnd1/dTJuQQwRQyLLK03dXkPyQ=
X-Received: by 2002:a05:6820:1686:b0:6d8:2f32:78f6 with SMTP id
 006d021491bc7-7035739415cmr5816509eaf.63.1792430598249; Mon, 19 Oct 2026
 10:23:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019140337.2886875-1-idosch@nvidia.com> <20261019140337.2886875-2-idosch@nvidia.com>
In-Reply-To: <20261019140337.2886875-2-idosch@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 19 Oct 2026 19:23:06 +0200
X-Gmail-Original-Message-ID: <CAL4WiioXarKu95oTB7pR74ON_sjigusorm4UE_H0VJNnF-eaiA@mail.gmail.com>
X-Gm-Features: AclHuK-LC5ucg5-98g6KunchC6Q3AzTpScWo-ZK6rWphOet6zKh0yFaGnQQZyDk
Message-ID: <CAL4WiioXarKu95oTB7pR74ON_sjigusorm4UE_H0VJNnF-eaiA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ipv6: Hold RCU when emitting route hardware flags notification
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	andrew+netdev@lunn.ch, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 19 oct. 2026 =C3=A0 16:05, Ido Schimmel <idosch@nvidia.com> a =C3=
=A9crit :
>
> fib6_info_hw_flags_set() is called by drivers from process context
> without RTNL or RCU. When the route uses a nexthop object,
> rt6_nlmsg_size() and rt6_fill_node() access the nexthop's RCU protected
> nexthop info and group pointers via rcu_dereference_rtnl(), resulting in
> suspicious RCU usage splats [1].
>
> Fix by holding RCU while sizing and filling the notification, like
> fib_alias_hw_flags_set() already does. Switch to GFP_ATOMIC for the skb
> allocation accordingly.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
