Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004138F938
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657302; cv=pass; b=BUCRLgVIV59ShEk75EeYHPCfZsahYGHex/jh3d9LlAPZLng5cifZO7j04d8lOo2CYPV+Pfk1cEV96SSq5+hsFfBSBUIxI4BsqUCWjOhJhb/J7zEIqclphKrRoEnY3ho1OcW5iEeGm74BRGwfCHoSwaodfKdZM7wFrZK/5EVFHKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657302; c=relaxed/simple;
	bh=spqnZogyG/2WQphYtJjb2y1OzkoXPuvOjn19qiEkkqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDWvqMr2n4+v2O369DXQ5QLQfS15JZUqqYj6r4lC1Oq7XBb5ucfIIewxn9WtNKypwLbc+auGg+Cr2T/orpJb5CUehM4oaT/HApRJFQlgfOu3gMe1ww0LvpdTjzc+JpECQQpV+Sp5RxEmoS9HXGKFeBRiwqmvKBRxerJQp+1GimM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNVy8iwq; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNVy8iwq"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c9a3acd40so35232321fa.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787657299; cv=none;
        d=google.com; s=arc-20260327;
        b=Nkow40O16APkjnzMCqOvk++vf4hutxoMmYeIFm9oZCZbaACjDdgzx9fhNPGJ9p9QHe
         jf7YPStSs9Fe36uREnjHeSCXg8exOoVZdU2M7dOWAABQdEJ7x0S5eiRgOpUQpczrutKu
         fRykCZURQS6Wqm+BLxUDSptVHezuugMYByvmKWtzNGiRB6cegjxyD+zmmeEB52f53TjB
         NyYeaILDIv8BySAUa23vhsUY3/oVx8+LNEc7PA2kMm7SdPzpR9f29DqurahGEeOb5jwS
         jtTti5JMiDU3xcLR0gHur/zfbH5crSP7tVdbzUXnMze+jyBWPNmVHAyiHW++CZYdhBp1
         mAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zYSMPJBqp3uz5J4B8XfYrwpaOERH3CFnbN2pmZxUXC4=;
        fh=1IwM9Q0KBeTpL3iP3kUA5VAvrNk2BXfgco5szNGXGoo=;
        b=bRmgrm1bk6SzRv26MnAUHRD6qlOJFC9Wp5DhhnoVtANO7rfPRzgpYOvePA9FGJ9AnI
         Se2kRngp27A6LZs6IgVXUEkG9mquvQAlSQ7+yoQB3BUNmEDiSZt5vKZiUP2oygFdwx8t
         SsTMmkq36rRRU4mRLOgCGo0x+ToDFRcvsIz6hU/LS33j41JD/Nd5BXTUmDLlv2XtVdZh
         7C33OiAwzVFAj5PGxEyw0V4GkBibM8aNtrHZ6uMzhIjbpd/j6/UOaf2Smgw70gcqYx7f
         hPu/vdwjpsJ/HhRs84XfZovA+eMTSR2ML5nJ/ijpvWucy/FktiOeXyDsD319RmZwNDKY
         4Xaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787657299; x=1788262099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zYSMPJBqp3uz5J4B8XfYrwpaOERH3CFnbN2pmZxUXC4=;
        b=oNVy8iwqV4/f1GKNqZWRJ1vNATeBOE9dbr/s3vv+sAQBvF9eTJD95F0/dcG1mT/exe
         fsnCK3TFbH5oFm+9eKdYfj8HJ9CuGZ+auIVrXwIW2d9dpyeInN6csbSdg+5V1V2V83qh
         vtm6S9LbVv1PhqjsketNOUwx7jyEPwS3mMdLjBJGF6WyIdIvJDtqL1nZdPoPXqOI7TQZ
         4mZhrEkTHIDm6W3F4L7jtDYEVcHuweS4V6l2UtRXbB9nWMUeDNOTS4K8aYON7u/u4Byx
         WGoS0O0yqGntF/ntJPZyDj0eqfYs1i2b4VWBPVKoK2lM7igK9NgsW46ub+R1IkRllzXY
         tn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657299; x=1788262099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zYSMPJBqp3uz5J4B8XfYrwpaOERH3CFnbN2pmZxUXC4=;
        b=TIekBJbTVguBdg6JubQrksSq9FiJ88KJ/SHFqcuoOzrwkw2Q6lGJjG7jFY4jQRGSkb
         5bHQCBxgOZYehh3eZTMxVjY6ilx1jvAYtqibToWMN5djdxDlsopuCqF5SIS3Y+g1ifOo
         G/nL1sULMIPl5llAeDgLxbli8CzHIerbVocOcMk61yHFhItr4qfKpXA4UhL0ZWhDvfy2
         46zfhdp/RgRoH7kH/scSLoohxouKlihLD9PVd8gekHDba+QbYtoIG7N3O/8HBx1if46f
         UtkaskSYSxQ7CwCgTV7qTwEX52NQhLN3x9rrrIuoeVXSuSDKTowPSCuLWXydfp4tmdte
         bUFg==
X-Forwarded-Encrypted: i=1; AHgh+RoqcW+a9LNPixCiMdZ3NAMjBJCyyuFB9oIPM1z95HBzier+Tpt2VdF/pu0SHfri5DKpzqxb9zw=@vger.kernel.org
X-Gm-Message-State: AFuF++l3eu6t1S7E7FYay1iBsGoqxtk4HDKXxv1S97dZrOMa/02bu69L
	RRY+oYN7HMfHbV3+Fg9wnmcveXuYXA1Lw29AWY+lyzBAIldhDal4lts/Vt2TeY6GKvu++Z74GWe
	tkwMUGA2ZlsESHXZrwXPsjiYWoFd0h64=
X-Gm-Gg: AR+sD139QtmTiy8Y8UzUO2eOkAxoCSdSkM7ayxrE7zQPziIoyBB2OMi5E2DVD5Aewjq
	T32nyMAx86vySAACxunO+w41sjx7q0869yEFW/Ud/lLjxi3petiyHNgsInO80WrUZt7cNyj3esx
	/GPr2GE8CThTMY5XrElkkt97NxabxUa6fxK3P6lEFXxiPXxg0Z0NtxvjHmfVTqKHzbvW6ps8CHN
	rjfok3B2vDcYZwAfLgLK4TG5/YDCXqlfJAKEh7PZN6sXMKXq+Lj9EzDq+IVWLsNH6Keg1v/Mrbd
	WquZgjx1k3111QTEX6HP2+cgNKhbHM1ee3jIoboG8WzTVjBlJmb7+w3rTAqk7RPj5FjknYdhvRs
	vNblRAUQz+AzmEJFX5HnrOSWLz/7vs7W1m2lFH/ZWrYVJRrtBp7zS2IysMsHgwDCa
X-Received: by 2002:a05:651c:a111:20b0:3a1:edd7:340e with SMTP id
 38308e7fff4ca-3a1edd73821mr11074191fa.0.1787657298591; Tue, 25 Aug 2026
 04:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825023614.1228551-1-edumazet@google.com>
In-Reply-To: <20260825023614.1228551-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Aug 2026 19:27:40 +0800
X-Gm-Features: AcwNN1UO0Qh8N-j974RwtXo2uo5_d8iPHbH0PPzxO1a5_ocm91JK1fL6jV-w2u8
Message-ID: <CAL+tcoA5Ux1VrTJ6SfNgg9JhXmQQCaNqgCQ7UiF+jN_UBp1dLw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:36=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> tcp_send_active_reset() can be called from contexts where gfp_any()
> (in tcp_disconnect()) or sk->sk_allocation (in __tcp_close() and
> mptcp_do_fastclose()) evaluates to GFP_KERNEL, which includes
> __GFP_FS and __GFP_DIRECT_RECLAIM.
>
> Allocating with GFP_KERNEL while holding the socket lock (sk_lock) create=
s
> a lockdep dependency:
>   sk_lock -> fs_reclaim
>
> This causes false-positive lockdep circular locking warnings with storage
> subsystems (such as nvme-tcp) that acquire socket locks in block I/O path=
s
> and invoke tcp_disconnect() or close sockets upon teardown:
>   set->srcu -> sk_lock -> fs_reclaim -> elevator_lock -> set->srcu
>
> Active resets are small RST packet headers that should never
> enter direct reclaim or block while holding socket locks.
>
> Hardcode GFP_ATOMIC inside tcp_send_active_reset() and remove its
> priority argument since all callers now use GFP_ATOMIC.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
