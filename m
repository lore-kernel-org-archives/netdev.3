Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793429910;
	b=mcLrE/d5XHT9f/WRQjNYvflZnaH2HcXyLAqQmyg7ZafQlpDmNyWuQd/4gkhyjfvyfckA
	 1rpW0wZmhl6QRua9rK+xMXlCfnAvSybDAEMvsAvOjY+BSFibcsM/DAZez9p8RMq+zokwt
	 qyqC8HfzNjJonHNNGrBwsKTN28Xk3wHtgc52N77HMQtMuJLt0G6I5MmAuB+L8eW1PcWOQ
	 0kA1pEaVSf2zCJGxDZppU1CfrfzxpdsjbDJn+YsZyJKsAtWcCAGOTu8nQpeQflM9VNvsO
	 DFBzEVIQFTc/vXteOt2isgbDaRCTiZQ+tLwqTZX2R046x1PTB0D5jJ2TP5HeajWpvPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793429910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z+ERvyGFXJrTUdts7nrzpMlW3VnG47UNvQJMV6QYWbo=;
	b=Oq+aoSZ6yFiKWfzqdoZNqFhMzuy4P2uTSFTIy7Qko8WxxssWIWT3se0FeCjeopkAC05B
	 i4FyRNQZ7lJC0v9yNyln4nInxi6VTZ8KasHFhPWw+tWjFHAyHXf3irALNEa/gfcHKXsAE
	 RFwwpo5HRmM5Q0tsoIebPFaa2ZYiENS1nhWcbjg+wZ9/3d5fHgkGbhcN9NkK/Rn5xCslF
	 97Ps92dYr23U0HS+yTsKc0IaN2K/FuoP7IL+zz2lA4ysSebWv1TI5apGUkO7dYhHetj2h
	 Hd8FoexmUb3iNAHFqcH3EhmbkhY0Ci+wv8CpnIgueSnJ8ja5OXidycFuYOOQ/sOPjcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NM90WPI8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA1606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 06:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCA1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NM90WPI8
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be416e603cso1009813e87.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 23:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793429908; cv=none;
        d=google.com; s=arc-20260327;
        b=q+ehBpkJ5vHIDLIOmRIouyiOQct6gcF+AgTQ/jWFxsw15bPytq5eWh8NXnqPBItRnO
         lywohZ2Gf6fYZ6ozBFiHSuHt22tvRWR3oDR0zZeSbCdEbGhVk/VsZH1PuG/LWXV4aeRA
         Qx0l6RLw1KLaDTokCyaIemwqBb9x5zQVRdDGqvmyILq8IcIvUeBKV5gg6LHGIpxox4Tn
         sUstMmoY5MHYDlpVLH8mHAgCbXuOQKQbE0NnbrLH/2xB2S8F4/D+YxCE5kWsItaUg0vi
         WgApM0bwz74iMSJhCh1bZJu3pH8/kdQlF3jNL0LL6gK0YczZaH1w58YwWLU378X35Ud2
         n36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z+ERvyGFXJrTUdts7nrzpMlW3VnG47UNvQJMV6QYWbo=;
        fh=/p1fSTA8ErengFCREL3IPHC3omSWszYArKCmPjlUnTw=;
        b=Dz7YLpp+mXZAsO+/yFjf9cgLEHtbObOWAvwhxYbR2Gt8fJkOkCpo45+GTJYh1lI2gJ
         Jb9zKxrnK+Wr60IG+jrauilQY2lmePYNxY1kM3o/8j90mubYhiJtwRHiq6rvMsAVIjyL
         W6pXT82hxVrZ6LHjIMxu2vSngMWTo1xmrkmN2OI0TLXtIRMR68KbJsZE7E6AXEXUpuOg
         XkX8Y64EQFmBa8myua1GX7go0aBZDGGySyaQU33u5vxP1bzVgAVVwncQA4mncd+3OI9r
         6mQBfs//o1iVypAO9jRZ8FeeTkffIpgvqe1WJI1b6FoTXsfaQgZbcsti5yhZ+C0tWvVi
         pRMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793429908; x=1794034708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z+ERvyGFXJrTUdts7nrzpMlW3VnG47UNvQJMV6QYWbo=;
        b=NM90WPI8YAaCMCqbEkAT0Q+XVe2Ic6hF7MD9jz36BcAKlkd3tqG3RYwvZgK5w1kkOl
         ouAY4xgR8RAHJNda13HvjQzH1H4If9gNGS1KjZdqZIsS16QJa1nV+A6ZdxXiZ1gCTKhx
         MKjqhRePsj1yNeYOzokLrRpcSrO7DUHGM+BEWqWWN1kTpbmZVpEsx7wjt6/6j5jnGEtJ
         DLUT7WqHY4j5XC9UW3V4Y1ZjhwZInup+AMU0MqaIIpAa+3IZ6GGngfvA/i87YEpZnGB4
         wyJOLS3n9Zuy9QTpfw5y0YE5GWzhqt2c1O6m/alSiglj4V5v9U0Jl6uGX4SZLCtlmdKg
         xaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793429908; x=1794034708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+ERvyGFXJrTUdts7nrzpMlW3VnG47UNvQJMV6QYWbo=;
        b=INhXr1ImefSCl03OKPIIP6XnVtTZom7SvFJQ3sg7fpjZysnNeO44NLoq30H9BNWFDC
         m5rs72JlHw/cnUJTIAArAwzR+pjRpCC6tNXAFSZdbcz8LqaDB+eJpbbHabSeA26FnIa8
         7rcwfYCVarxbvzvnjKSOOar+GicnyOdBvz192Duvo83f0IlHDfKyHl75AUduqsblXF1i
         MVrFdHR3AH2PkJtwBOWOKF5nJbftb8UTQq5xTCxf5n4YwLThq8WnkZJ/MZJ25aGQNuys
         ufh2BpMzGgPBQ7sDJuZXdSiwCQsuX5gAXmhuRfesScJzP92MNQbaniYnhscSHtRhiiH2
         c+Fg==
X-Forwarded-Encrypted: i=1; AKwUvBye3dilxqg8qzWloxS/PgIWKBFXggH+K1YPpTXBC70h2nB0bHTzXwxN7iJR+lRCvpr001faM1E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwlibFghLX2gR2w1N1r0p7MVs/yxJPYF5QbDLrXr1/JOSv07Lv
	xqVD23ABgIgfKiraATV9+Vnqnl+8Q4CraP6C4GrGqdIuic7OZ1VsMnydh5qJYiGJxr2eWRI1LNw
	FvKyUR26dynxbW3awfRxkvaKUmcEtwQI=
X-Gm-Gg: AYBFou3ajBZtbqxuPZbmZxfg75NAdtaRRhXGOOIzrAx8h+rdHagSBpMcbKGU/YXmXWu
	QS82N+DQavO6kZMa9ZyOROt6Lyt/1RhNrp/blC1NgCDJX4b1WekMpPY6dunMFMFMzR1+8Uf+o9N
	H7ml+VyYLKo9dGR60JdiXBx+DQi0C9z7bMgNGBE0DKKVmxT5CAKDbzn63P4uo+PCvBoi+85gaSm
	xyEmD1RtWhdhilNPaDNDvAZBX67U830UElz3PeFIm1sXBC5ebIyLeG/KExOUDpPnNf9mV3pP1cB
	Fkxiaogr0g8ySx2fAGZ3JmPsZZipCQfZdJDZPUPJ1+wQFay4sCdUH0L1Cl+29UIXYPa2lnBVv1g
	z8N2rZWXjHNhvBIpOtUK4gKXkkRZ4vy6tJEJUk+MaEmi1knVSdhvCLAYw1UfB2jqAV70aIh5e6o
	TMhddBXHr592YFJbtAI84cRR3+NtXK84iEAVJPSEwpWR60ArUj8X5nU1+oAnH3cOXgNkO0hJi0p
	ObUZacUzYQ=
X-Received: by 2002:a05:6512:1087:b0:5be:4792:82ac with SMTP id
 2adb3069b0e04-5bfd956f142mr1539518e87.41.1793429908173; Fri, 30 Oct 2026
 23:58:28 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029054200.97234-1-gyutae.opensource@navercorp.com>
 <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com> <CAL+tcoAmq0WfSzo01xbAQ=g8OtE+GpJ5+RGs1G1SdNPdHx_eZg@mail.gmail.com>
 <2026103018-gothic-sheath-5c34@gregkh>
In-Reply-To: <2026103018-gothic-sheath-5c34@gregkh>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 31 Oct 2026 14:57:50 +0800
X-Gm-Features: AclHuK_yKmoKPeylNNTwvOCcmLXjE5Vpfta5mEI4e24EAoe6XTOkLL75-ZO1HLk
Message-ID: <CAL+tcoASLs8jfPgs+OSbjy=aEJjor_wK2qPWnOvBAD1vuroT-g@mail.gmail.com>
Subject: Re: Backport request: Revert "softirq: Let ksoftirqd do its job" (d15121be7485)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Gyutae Bae <gyutae.opensource@navercorp.com>, 
	stable@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Minsu Jeon <minsu.jeon@navercorp.com>, Jonghyeon Kim <jong-hyeon.kim@navercorp.com>, 
	Siwan Kim <siwan.kim@navercorp.com>, Gyutae Bae <gyutae.bae@navercorp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Fri, Oct 30, 2026 at 02:16:57PM +0800, Jason Xing wrote:
> > Hi Paolo,
> >
> > On Thu, Oct 29, 2026 at 4:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On 10/29/26 06:42, Gyutae Bae wrote:
> > > > Please backport the following upstream commit to 6.1.y and 5.15.y:
> > > >
> > > >    d15121be7485655129101f3960ae6add40204463
> > > >    Revert "softirq: Let ksoftirqd do its job"
> > > >
> > > > On a production 5.15 PREEMPT_NONE node, long-running overlayfs
> > > > getdents64() calls prevented ksoftirqd from running.  RPS IPIs
> > > > continued to arrive, but NET_RX processing on that CPU stalled for
> > > > up to about 3 seconds.  Over 15 days, the node logged about 1,000
> > > > bonding ARP monitor failovers, with no link-state changes recorded
> > > > during that period.  The failovers stopped after the workload was
> > > > removed.
> > > >
> > > > On a 5.15.27 PREEMPT_NONE test node, we used a livepatch to make
> > > > ksoftirqd_running() always return false.  This removes the same
> > > > softirq deferral checks as the revert on this build.  Under the sam=
e
> > > > load, we measured three 10-minute windows: before patching, with th=
e
> > > > livepatch active, and after removing it.  The number of HTTP reques=
ts
> > > > taking more than 200 ms was 17, 0 and 11, respectively.  TCPTimeout=
s
> > > > increased by 25, 1 and 21.
> > > >
> > > > We verified with patch --dry-run that the revert applies cleanly
> > > > to v6.1.190 and v5.15.223.  Both already contain the related RCU
> > > > fix 1dd1eff161bd.  6.6.y and later already contain the revert.
> > > >
> > > > The original commit was intended to prevent user-task starvation
> > > > under a softirq flood.  The revert's changelog points to threaded
> > > > NAPI as an alternative, but it is disabled by default.
> > > >
> > > > The revert was merged in v6.5 without a Cc: stable tag.
> > > > Syzbot has also reported bisections to this revert [1].
> > > > Paolo, Thomas, Eric: I would appreciate your thoughts on whether
> > > > this revert is suitable for 6.1.y and 5.15.y.
> > > >
> > > > [1] https://lore.kernel.org/all/000000000000a249880603717c15@google=
.com/
> > > IMHO such change should not land to stable lightly. It's a behavioura=
l
> > > change with subtle side effects. The threaded napi feature is disable=
d
> >
> > Technically speaking, yes, it's actually not a bug but an optimization.
> >
> > > by default for the same reason. Also the revert has some soft functio=
nal
> > > dependencies in napi threaded cleanup and improvements landed into v6=
.4,
> > > i.e. 6bb218b5a6e3f3c5e2e76faf8fc976f3f6f72496, likely more.
> >
> > Maybe I have a slightly different thought on this: since I really
> > received/noticed there are not a few reports showing the 'issue' in
> > the older kernels. It's not easy for some people or company to upgrade
> > the stable kernel. I'm wondering if it's still possible to land it
> > with more careful consideration in the patch if Gyutae volunteers to
> > do so? Please feel free to reject the proposal :)
>
> Given that 5.15.y is about to go end-of-life in a month, that's a
> non-starter.
>
> For 6.1.y, you better be planning how to move off of that _now_ given
> that you only have 1 more year before that is gone.  Anyone hitting this
> issue should be moving now as that gives you an incentive to do so :)

Right, it makes sense to some extent.

Thanks,
Jason
