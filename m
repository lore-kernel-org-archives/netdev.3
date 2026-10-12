Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9793CCFCC
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828897; cv=none; b=H3UL0y15u1/y4RK0FzNFeXSHmCoyUkTHkq5p7Q9mDVVt7YUfPzkCV/cpcnnJPyxzASiJJ02lABBc/TdWJpSWxszDQbll+XciBDjPUrvxYbpJchiaqTSCrlIGjoa7yaJm3G0j2XKixXWDX/HgsjTYsqidzVDxnlvU1PsyYlIwqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828897; c=relaxed/simple;
	bh=QmmaBmlJVo5FdvqhyuBn14AUH7EEO+X0T1K+iasYDNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMAqIjLpc+4nWN2ZrtiRnUce48kbgpFpsEb1+cGE+k2Jc8zeCKL0LxcVXfAT6qs5biIvHUhli+YUPaMQprU8KD3lEHrH8wUaKTnIMyUHXrSYPyKqw3grg4kpcSMaCtNxpdoLsomG8stT7P8yzAb9AnwZ0cg0sT2KitRFFO6CUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=CuM3h/+9; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="CuM3h/+9"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-675617e81f9so2111609d50.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791828895; x=1792433695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jiSdjWiO6CP6czxAtbTP6DSzhB/PYb1mZmzJGcgFfYI=;
        b=CuM3h/+9LU7XaeR+xoTNf+sgxUzQrQSWBaIA/BFftBOeOr40m9H0beCVLbJrp7F60j
         0DBRgWAh/PMbQPFUNtukqB7S9hcZpuadWv+1kdLOTL+rWaRXQilsfo2mX+KKVOLKChi6
         HgHnLLD7X0d53N52RW/+B/l5mVZ+2iKb/jXez0auS5+iBf/04mczW44jsZerMcIv670T
         rqOpWEVYb0px5zi/+uZW9ysnc93BsbWKChqvvYAcafl+e/gEqUMpBfaI0kKg1tMvK7C3
         MSrFo3cNfmWMmVSrrIbgvJBiCsauAsI01bTSQclALrQR0gzQ9fnTm5lvUcND6EgkultL
         xVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791828895; x=1792433695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiSdjWiO6CP6czxAtbTP6DSzhB/PYb1mZmzJGcgFfYI=;
        b=jTzIRiFKnpQDCtcb6zKvm2nn3H2YigG8I0wY6+DmOHdgp9ty3wdkqpAkNuxTRFNrt4
         +1JSKTbX/gAOOwSGip/toW4TiL5jObgpJ/3i7G0ETJE9WiuCtVDyraHSbWiZHggqxQuW
         eTYv4966gafv+/hLchWNm4XtcT5Z2g+dtbJfPx8X7EikEAvOpYisseWAQiJ8xJoXeM6I
         nNezTQ2ym/jrt85zdKUcNWMzUg5eDYaV27HYxBsgKesk3JGb1eyQpHQOqqHayv9xKLps
         fn8HgK9L/r2fBC+Bg/zto/lmLJ1Zn5L+Imoy4fJI1bXUs+AKbmr/4m7aDdpNSlZLEJb+
         yBfg==
X-Forwarded-Encrypted: i=1; AKwUvBz0ikEt+QsDtLklJhJa2dyQgV/S19p+2RQqEaef5jd7dQjSQuR0ZkeqHYNse20hSUA+Vv1ZDvk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaqnW4Cj3dWXQOWr7xQG4gon3mV6S9tFdAEvF66r1wLY1qxUQo
	ojE7lhO4UExMCZmGH5a9a7O0fCrGF7OsET4qKbEIxHG2ydEPxyO99PAn6C57uof/qttt
X-Gm-Gg: AYBFou3U0L1rUA33fFkwTlnSPzybhJKFWihWvOpGnC64wDyaPeNHGu5pOHQ0HOeqwfH
	tn9SGNSm4rdnWsTyZIhv0Agmtzdh9TRZfYOtHkJ7qrIYXgYM/CRzpiaTToJZVYApHEAa+lvdvYb
	VPVkpyu//+IBwG166othnobpzHVNTUSiwKkLtQHsZOoi4vjYzmo9hHr5HW/xvyWyk2pbZuN+IPu
	w3HuqocHfEUOWGxZvJU8+vEQaF9mNcHWQgRNVadX1h6cUo3h9+ZlAeuSOXuyBzdpia2aYFkXlTB
	t/4EsAiZVJk3eM31evb2al3IOx609lA1Mh9Hs96s2YVVVj9gnmmvfGMyFETLUBl6dCr8tsHTm3r
	zawaS5Nj4/PxLoF1XrtUUluIoEVcVV1hXM7A+sE/obaq1dz3c17i+CQWYERzoC39jYWl8ht2tdi
	GDW/dfuVy0iXNgmRGzyyxzrP2JiCLaOJnIY24555mliq+Be6KMtl+tCs6fk4Mr3fuNpG+6s2cq0
	AVCQGqfV4fYjupL5wOXwbN+1q649gRMb0SYZyWf+ng=
X-Received: by 2002:a05:690e:4084:b0:677:cb43:4b30 with SMTP id 956f58d0204a3-67936adfb2dmr3395147d50.97.1791828895170;
        Mon, 12 Oct 2026 11:14:55 -0700 (PDT)
Received: from toolbx (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679356ef60fsm3859048d50.21.2026.10.12.11.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:14:54 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:14:52 -0500
From: Andrew Halaney <andrew@amutable.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH v4 00/10] net: support thread-specific pidfds for send
 and connect
Message-ID: <as0i2WdL_T6L6_fD@toolbx>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
 <1ab71b00-fbe1-42a0-a99e-27d5cd5e5a6e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ab71b00-fbe1-42a0-a99e-27d5cd5e5a6e@redhat.com>

On Mon, Oct 12, 2026 at 05:59:17PM +0200, Paolo Abeni wrote:
> On 10/5/26 17:09, Andrew Halaney wrote:
> > SO_PASSPIDFD/SCM_PIDFD and SO_PEERPIDFD allow to retrieve a pidfd for
> > the thread-group leader. The coredump server using the coredump socket
> > cannot get a handle on the task that took the signal and is writing the
> > coredump easily. Workloads interested in per-thread authentification
> > have similar problems.
> > 
> > Add SO_PASSPIDFD_THREAD/SCM_PIDFD_THREAD and SO_PEERPIDFD_THREAD. We
> > record the sending and the connecting thread in addition to the
> > thread-group leader.
> > 
> > SO_PASSPIDFD_THREAD functions like SO_PASSPIDFD but instead of an
> > SCM_PIDFD message for the thread-group leader, SCM_PIDFD_THREAD sends a
> > pidfd for the specific thread. SO_PASSPIDFD / SO_PASSPIDFD_THREAD are
> > independent, allowing callers to get both styles of pidfd back in their
> > cmsg.
> > 
> > SO_PEERPIDFD_THREAD allows to retrieve a pidfd for the specific thread
> > that called connect(), listen(), or socketpair().
> > 
> > pidfs_coredump() now also stamps the dumping thread's struct pid so a
> > pidfd for that thread reports the coredump like the pidfd of the
> > thread-group leader does.
> > 
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > Signed-off-by: Andrew Halaney <andrew@amutable.com>
> > 
> > ---
> > Changes in v4:
> > - Moved get_pid() out of scm_set_cred() into scm_send() (Kuniyuki)
> > - Dropped unnecessary helps (Kuniyuki)
> > - Rebased on v7.3-r6
> > - Collected Kuniyuki's RB tags
> > - Link to v3: https://lore.kernel.org/r/20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com
> Out of sheer ignorance, I don't see the shared, stable tree where we
> can pull from, can you please point that out?

Here ya go!

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-7.4.shared.net-next.pidfd

> 
> I think that this late in the cycle, the series could go via Christian's
> tree only and we could get it back after the merge window. WDYT?

This works for me at least, for what its worth.

Thanks,
Andrew
