Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085003112B2
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813790; cv=pass; b=fQriBqXfhlGPiFf0rXHravJQZjSRtt2jgkGRjwEtHAP+vE/9AqyGObABvlHQwG7JA6I3vyXNfvsGqngERC3z0EYj3Wy5+t80qu0NxYspuNcq3G7vA67bh738aANio7mdwW1+xhkNRixiGZ6e4qbU81e08zY/rFSu+Z6ua+nNgEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813790; c=relaxed/simple;
	bh=g//GFZ9cM0kV6wz/WYWiImy9dNDXGkjbp+4scPbPmBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLODbv5YJeeKzoXXFqO+8d6Zjz3mXJnjI5UfckQ2MEy3pZNfP9hgwvr4aPzPMZiE07lvij9+yxJI3pe4ApqRGETEzRDSR3RQdfl0bqTUtPsbIcl1zNQky1crXbIG68awK7IWOqKiRjvy4ybKVGaIFYKLs7fFUeA2azxjOEh2PEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LL9OAQQq; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LL9OAQQq"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52d590ce5cdso2742821cf.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 23:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787813787; cv=none;
        d=google.com; s=arc-20260327;
        b=oEXAy4u6JalfUNKzOFWggFuAPk8SierruRNITfAe0scIU6MVLuIfgFRqF0xiTLqQOE
         c7wWJZo7t0cZ0a5F3Q7q2/OhVs5V+Mglgd0hFw+zXpGLdu5zXD0UPXvCC9d/qdsq4nbC
         IbTXiW9BxC7Ss30GFRpqyA5UYrqeP65VSHpu9zvFXpx8OJ/v5KiPNkVNyu3b1pxhKyk3
         W9exoS55JPIbGL8JMqPekR137J1SaKOdOUEor9eu4EZYHzr1oCAIme2Dpcm4FkY04mOa
         WKUqneb8BfIQnv4WLXkYDkJXjjnuhLrFzgN64sj2Buqa22IODN6l6VZ0TV76VT32UiRc
         Cp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AHX7loaDyxgrVmCP38AFUSPhLffvrEaHlcGJr9fqpWw=;
        fh=YXX96wKeuqAX6PlMem0j0pCDuWyXN7EBt4RZn3CZjEU=;
        b=coMU5vsJpJ5vYclCDczMdZX4iA6hdAq+PNIEFkTHqlVJ9eJ7CQ9euy+D1aDo6DBa+C
         CvWZy2h+a8qEO1aX/V1wnta7yWWibBzttqjAFVM6wq4U4hlPeLrAf76HGn5lobUU5OM6
         UNGijwmwNI/iKFqcgi2vDlCmqo89zJvV1qFTcqPewgVd4WvDWqKQdor+zIUJ6CPRooaY
         UYPWHAlaE6TEIQ87zzoP2Fnv0HAoIuFy11bbeMYk0AFiY6C9aJeu/L9KuZIGM6b9HreR
         X/6Bgju9E/Pu8tm6KBgMgoXD7kh9s67CUwCRqiAUDgEv10kvN1Fo5UMpyNGtOwUJ6GaA
         sKkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787813787; x=1788418587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AHX7loaDyxgrVmCP38AFUSPhLffvrEaHlcGJr9fqpWw=;
        b=LL9OAQQqnjIBWUSB0tffSHhLoQ3IB7f2bL234mC2VHKOZABoPofaB7BVVw2R5lUeVb
         xOMLTUD/2+p9LS1+lWvtR6W0oLJw3vVNpgtccpbflGmE8wYf/7v83HPU+VQ0dA7S5Zu6
         zr0WsR69chaQu3hQoLDYnm3CukTXrekULWo6cFR//jtTVfjQL0h05kiT9WQjxBcZRSC3
         /JZJ5qr27dw17TUqMkYfV0aWuFE30Yrbz401eGCbHyXwU00MnumXxrNkNqnqUhcsqOzB
         qymwQ30+IahUOingeDllRGh5/q+L9ZGh9a9caZn3bUEpJVqZX3/hRap2XgsjlZKT+MFj
         5IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787813787; x=1788418587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHX7loaDyxgrVmCP38AFUSPhLffvrEaHlcGJr9fqpWw=;
        b=kX5lc64zCa3ptFrnQ3ogF5pxbmwld8HPgm/3nRYMB9D1dJYLkiJ4QViiUBH/8ZQBHw
         pydUSPui3BWuLVYnCu4dyPrj5rgzFt9UwT7kX9wpxLbhoFHY08/8Pxn9TL+Uyy7AUHl9
         FeDUQYQSWdzOx6tBgiSOQwkOrqcr5+gK+oYMaOaEejIuS5zv94vF3De7/BDS6xIRV5Ro
         J7+zVeNJohlEjq6EdLpSy5hdGJe3Gct5jA8xnFTRqS20BENxz8Mm4q58jI4e/8GyBqQh
         8a8skqCe/wZXhLQ0TqQ4aKh7wt72P2wrM6noNQy7TWt/5INo3QoisJCEHhv5qDU6iMu5
         qGrQ==
X-Gm-Message-State: AFuF++kVN5B+S1RbWhwXPYh8XtrD9XyTL+8U2Hd2em1uSgYXv7xja/e1
	7R6hFVf6Bj68hKhYkBpsF75tgXgBPVZ6Jvz+yLh8QlQzI6rMN91Olzr4WM94InNGOn6tUgcX9A0
	8g0qiC1yfDnPhLj3H7ihQ8qiuYiBCTjSi/Xb2tGAu
X-Gm-Gg: AR+sD12e9IxFAndpAkWP6Z4+u8g5NpGqG46d/O4686kqVvzMm7e5U0zVtUzWagXbftB
	GIuOBFNcFfBetD4k6rPjDwsHmCouKaf67uhnDZw2R2ARbhXawgQ0WkohlYKuR0vB5J8Xh9H1kar
	w9TwcOmedIBO5v/o/3V/CqQP5K0MrUh7Bjbdt+dFs12UCzekIEP7LkcJlnYFMjsxGa8Wq1IqvIp
	eQGApDcuYAViB5SGONQHYnoLt74/V7McDefZq1trr4YmDv7s4F/a98Iy/Gn0wHTX2zlbtgN+JFp
	pv9puSEXGSAHU6IajSignEBPtB9D9t7fncZ4U4h/mxNd8ISEcry0vPeaboStgVlj2O2VPXTbiD9
	HVUrIXykF1gG/9Rn5iIutYOOgp+OsL44GHWuOxTdJYricKHo4yL9Xo2GyY90=
X-Received: by 2002:a05:622a:11ce:b0:52d:8256:ac33 with SMTP id
 d75a77b69052e-52e42338b0emr122054891cf.28.1787813786180; Wed, 26 Aug 2026
 23:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827052219.290380-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260827052219.290380-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 08:56:14 +0200
X-Gm-Features: AcwNN1Wwd5VXxt_7HGZPZSSG3-Va1mnw1t3Mzy5OgF_-m8qrD1p8495iU6XhNj0
Message-ID: <CANn89iKK5jxVa34F7QMPjp5wormMQrZgoK4THJCqVp76Tw1NNA@mail.gmail.com>
Subject: Re: [PATCH net] net: fix refcnt_tracker use-after-free on netns
 creation failure
To: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: netdev@vger.kernel.org, 
	syzbot+d3f912a2e30e2079a512@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Jan Kara <jack@suse.cz>, Qiliang Yuan <realwujing@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:22=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> The copy_net_ns() error path tears the net down via net_passive_dec(),
> which only exits notrefcnt_tracker. refcnt_tracker is exited in
> __put_net(), which this path never reaches, so it is left alive.
>
> Since ref_tracker_dir_init() started registering a debugfs file per
> dir, that file must be dropped by ref_tracker_dir_exit(). The missing
> exit leaves the file pointing at the freed net, so reading it walks
> net->refcnt_tracker.lock and hits a use-after-free.
>
> The missing exit has been there all along, but before the debugfs file
> refcnt_tracker was just an in-memory ledger and empty on this path, so
> skipping it leaked nothing and did no harm. Only the commit below, which
> gives every dir a debugfs file, turned it into a use-after-free, so
> Fixes points there.
>
> Exit refcnt_tracker on the failure path.
>
> Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debug=
fs for a ref_tracker_dir")
> Reported-by: syzbot+d3f912a2e30e2079a512@syzkaller.appspotmail.com

Missing `Closes:` tag makes analysis cumbersome.

> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/net_namespace.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index a91d2b58aadd..0c3f169d9afb 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -591,6 +591,10 @@ struct net *copy_net_ns(u64 flags,
>                 key_remove_domain(net->key_domain);
>  #endif
>                 put_user_ns(user_ns);
> +               /* setup_net() failure is not routed through __put_net(),=
 so the
> +                * refcnt_tracker (and its debugfs file) has to be releas=
ed here.
> +                */
> +               ref_tracker_dir_exit(&net->refcnt_tracker);
>                 net_passive_dec(net);
>  dec_ucounts:
>                 dec_net_namespaces(ucounts);

I am a bit confused. I thought this was already discussed and fixed by
Tetsuo Handa?

f85dc137aabf ("net: add missing ref_tracker_dir_exit() to net_passive_dec()=
")
should be fixing this?

Tetsuo also followed up with 3220b62fbb8a  ("net: fix a resource leak
in copy_net_ns() error handling path").
