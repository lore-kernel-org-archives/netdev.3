Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329819;
	b=oYWJ7jTJgsr8B9Y6gm6osQ+vsK59wypbGj+N9M+VctVRXKkkAXUjq9XgW8HEGupI/HcY
	 KLUMD7Q4czf4AQwmqHzEo+zHWAp1QpGSsO3Fy3tACjswrNIAoYCmhMUaCjmupcjJjRpic
	 4xtyNo2yAY/WDL9HKtZIH7E0HqJz/wnbdD4nLbuQVUN3Ek8TXyrAon0wHHR0DeDbvnHaN
	 J6sawZ2heEa4vPRb+8G5Rcrp41DGGbOQaczwffFTJ+j3m9d70QGqMBmy8DKvx8bNCxNmf
	 pQVqKpOie8k4lrqotEzbVvYcFuXbQfLVWRys7yO1/sgF25p/T3JiHn2mWWF+wtQvjmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329819;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X+GudDoszaGkaaekdu1G8hSiYG4pS+4g5ZGa7GfDq60=;
	b=0eI+3PkqFuWy065psJ4a7XFY+ZlhCGRBFDWfshDOVFdbpNR6nWmCVpkYadCzui4+wBAW
	 ZOH+KpioBx9HTjxULc8BE2LwTaoLLoDKAtiArIOZbRW31tbCndRTualrN8rlNW50GG/ix
	 DKfy+XOxpCoIuxWhePYHf1N9IBXYbRDeR1hH7ovv5tUGYin5JhTb3/3ltHnekeafUDENh
	 t+pajqYqjkTvNlfdjPFSpw1v09Q7yN/vjUzsO2CGVu3Y7PCAb0lQekSv8U2rlKMwf46j5
	 GYnnHMLhKMwqr5HQpmhBTCVWqgP19E7X656kIOLcKdgZKLrmsJwxfx81Os7n8B72lBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=VU9PdmUJ;
	arc=none smtp.remote-ip=74.125.82.104
Received: from mail-dl1-f104.google.com (mail-dl1-f104.google.com [74.125.82.104])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD05606A331
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD05606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=VU9PdmUJ
Received: by mail-dl1-f104.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so51621c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329817; x=1794934617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X+GudDoszaGkaaekdu1G8hSiYG4pS+4g5ZGa7GfDq60=;
        b=T4paw91FU8LqG+sfYp2yHAI77pLzttSF4w2rNYazx32L87fKG2UFu2DiZWSH3cJ5mS
         oj6esWyrCGnKfEKhfwelixCetDbwVz0qofqgDnaEyRoypananI9LyKy35YFo0dxDCx80
         +cXuySFhtU7BudHCf9F1bkfNNUjVfeQNH4W0qeyIYBZFkY1CtlpfPnK/Cfgrqd1LkA+I
         yLk0kQJ/ov1GoY7XoeJ+K5x27lbdQdcMZNvXUmx1eK86vMCezLayusz2aIVrFuo4L04z
         bmgBtKvUF1tJvEGf3CCKsPFxoo7has7Xwds/QT4mJIBkaRcpcyx/sYNwMgW9Ve4hr5FZ
         dmtg==
X-Forwarded-Encrypted: i=1; AL+hErE+PwVKO7T44yC8IwKZUqRr/3W+YrFF/sighoPa1c3sPx4SiaNMLHPA6O6QxWWW0J/5TLw0rcY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ra0EY0LI5ez7jPi9WSiGFnYdqdhtMVIHI8ssBIdo/R7qIQXCx
	J2wTNxGTdq8WR/+BHVJ3BFa8F2XCa50lavtHqV8ZPRsCIhqHkKIgHQeJy8AxaiJy2bNc09GE3hT
	6w01ueT/68CfAQ8KspWCOdLJTJFmOz1g8dyCmkdo=
X-Gm-Gg: AYBFou28v6WXcUxak1FP+XB/XiYSaCNva6E75/9XNLKj6Pixba3OmBb+RECIz54XtVd
	C1B07sT1+0vkFhfkQhGfAJdIrtMtY5whbFaIhPpOKWooYPxVy0NqLTlJ4/KVt1JcDmx2CtMu+sN
	Nj1QS17RfbBCnxo7gNoKpEPdHDwhCuE+5pobtIrZ67B3daalIUxVFyOkGL0zajykGZnzeQy5ju/
	gEXEWKkOEB6wqRJXz0HCtrLLWzcLOkjMbg1osjApl8JvTtk4Qyp04IG6u8GUsFsxe0or5/ZvtDH
	60K/J+Epl3fEWz3WwDkC6JlC0bau4Gsnn/lIAs8CM0MtIpAYb6jgnZTVvAS2CCLU2VPGRFD3lt4
	P3w==
X-Received: by 2002:a05:7022:e884:b0:14f:8d59:edcc with SMTP id a92af1059eb24-1b3b605bbb6mr4811146c88.12.1794329817371;
        Tue, 10 Nov 2026 08:56:57 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1b3b5658ebdsm138363c88.13.2026.11.10.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:56:57 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794329812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+GudDoszaGkaaekdu1G8hSiYG4pS+4g5ZGa7GfDq60=;
	b=VU9PdmUJxykaWZZSvejhXpmGHLHwalpORgKW+eKYQ29RLeIlDVStYP7vi+u1iI4TbNdVwU
	XayctaVpwOCL+9im7vUTfpqro7jTSU/D3r8GNKnLL1sIwGfCMHSKi7gzC+dhKalCJpYYhe
	u3ie8uMBbRtzNiQfONjeUmnlYdAWslA=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id bb134f9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:56:52 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:56:49 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jun Yang <juny24602@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org, TencentOS Corvus AI <corvus@tencent.com>
Subject: Re: [PATCH net] wireguard: flush endpoint dst cache when a peer is
 removed
Message-ID: <avNM0VAw0fpqzpgv@zx2c4.com>
References: <20261106081538.69465-1-juny24602@gmail.com>
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
Content-Disposition: inline
In-Reply-To: <20261106081538.69465-1-juny24602@gmail.com>

On Fri, Nov 06, 2026 at 04:15:17PM +0800, Jun Yang wrote:
> peer_make_dead() removes a peer from wg->peer_list, but a netlink device
> dump can keep it alive through ctx->next_peer. If the WireGuard device
> has moved to another network namespace, wg_netns_exit_rtnl() skips the
> removed peer when flushing endpoint caches for the original namespace.
> A cached IPv6 RTF_CACHE dst can then survive ip6_route_net_exit(), and
> its later release from rcu_release() accesses the destroyed per-netns
> dst counter.

Can you explain this better in your own words? I'd rather you do the
work of interpreting the LLM-generated output and making it
comprehensible. If you understand the bug, write up your understanding
of it.

> Mark the peer dead and flush its endpoint cache under endpoint_lock.
> Bypass the cache for dead peers in the send path so an in-flight sender
> cannot repopulate it after the flush.
> 
> Fixes: 20ae1d6aa159 ("wireguard: device: reset peer src endpoint when netns exits")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> A KASAN reproducer for this issue is available if requested.

Yes, please.
