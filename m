Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748B42E415
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110791; cv=pass; b=OQZCM3n37K5amMxg2tHjuU6+H7tf/5C/AFeGGRbRc38JFIoPqHNmQlBLywjyOwNY6qJShJfL8noKTpEOteoHzEQ5NqpxqVtjvvfunth1yFnhBB6AWUbluiPZ8jiW7pIaqZakAC8NExL7WdNJ+w6hXlhNrr0M9gj2z7dqxpDHAf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110791; c=relaxed/simple;
	bh=wIRXXuVsUSpgf3xCZFrSJzI8xByKVKMD+dC+JD/lknA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1OiLms8F+cP+o1giMfpRaw9KBVgpWapOpEbs70AX2QWPIVTtcpv7F2Yi2i3ipfC9vEbGzYlXPxfTJJDWQ7RkXkm5XKvkVJpNGil+oMfYotZYbYR5c2kkIpNrzpy0SbbDkV652phNn2dz0CeROIQT/zWjfjM1/KbSouO/QNRy+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ957hYx; arc=pass smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ957hYx"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6b1ae72186eso164087eaf.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790110774; cv=none;
        d=google.com; s=arc-20260327;
        b=aQ9TZlgMSXT5LaAVxLI1D9e/fbqProQ4kM/B2yVKYV3WpPg9CJbN70JbICVjn/KCvl
         2HVRaNhj05lColQIoZoKU0TDxeN6vskzX4HLDxdsSke/lmhMGfuXVdTz3aS2/l8pZHn2
         h7TT13tD06Tcam4b3KVH5uBYQCsqf6uPnnWHEGNnDH568iXxWaCfrRd9YBKlC4G+iiZb
         XWKrjkLtnDuc+tw1xf48/B0jb4VrBYs/1Qwe9OkLn1RNJLfbe+aommf9seR80lkUFSrt
         vxwIb+YeTKAzj83sievRsjFjgFvfIPRqDFClE2f0gdfiMVXBeAHys6sptWw825lwh0Kp
         rJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=btBRPiBOdcnMWIsPdftA9/JWuQ65VWOKgdruB6cHU6E=;
        fh=I+0pXuPdiXfSyXlAzKm3G396S7BCQrWS5a6UnpNpjv8=;
        b=bODMKvvuNHzi0YhsfxS5NWcUhFccvCUDZ5YatF+B0Apzw8lc7hmqCqTzqIsPlRZKOH
         5b6pfImrQsNCrjG1MwCS8qFJRCH042jPKJxGb7NVqHPuSgQJggmfnAuqjkFO1gnRiMKB
         EK8SrqnurH/tmu459D2pxkjNG5YMcd3DDCindUJmMo8CPvHasDyfsAlFtBWvB9W8bGWj
         7wicFnRw/eo/k+3+SBYQ9l94m1RZ25pg++5DNQji3uSmyUTtHT/DrCKi1BYY18dQhqQv
         cxWcGoDIbLKmJSxgaYA0hrH7jp51aJaXErPr7uAWzNqVVgdEHFElMTMVOz3eeZoJQq6Y
         WyRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790110774; x=1790715574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=btBRPiBOdcnMWIsPdftA9/JWuQ65VWOKgdruB6cHU6E=;
        b=XQ957hYxO0xTPlSDJ03IKx+MxcfN9kAIo219ZRQnIdxUHeHjn60pEZfNyWpmDD1Qoo
         2SOyxkkyc8URH3VVGoabUl79PMYw3AW2OgD7gGK2gD3Ov9T90wgi/0AgqSvQ+kFeOC65
         H9BaC0QWkuyu+iaCcafG39ntqttCf8NkDsXsvDHs55OM9MRz75ZjJpPJl2TFeDZMPZ1Z
         k3y4f7P+61kq6pn0Cy/RGnhx/PSkJHCaRBg/bR8T+xWUJb6N/Yy1oqoeoFnFdcONj2Fo
         NKnqtBfMJrTmWao4y45iz/7DPlaK2bIQJKrtXExH+N+9yElj39tE9nMNfCsgvWmBQ47W
         jfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790110774; x=1790715574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btBRPiBOdcnMWIsPdftA9/JWuQ65VWOKgdruB6cHU6E=;
        b=itOHTEFlbhQoeqOAu7yczS0/mDV7QiOat/XcGC6s+GkMR25nS7VWaTlZ6lqvIJCwaV
         1k2rFDIsPJ2Fnh+pp+ZkGLllhiyjiXrcA1QK7f+9DTkZ9fhEOshY+L8CLCBcsJvBC9zp
         WiXCcE7PuxEr7AiFh1J39AMdDwMvQ8gNup55GSgpDrO0u7QeUp+aEYr0J/oqWhAn+/Kn
         M3Nl8n3JmK5bGJF7jJZZpra6B7tliN4rl2tfXq3X4FSgL4wyMe0PWTdj3qezW+pORWIb
         dUrANHVrbsAtyRoBV8JrY+4sGuGGc3MBkGPtRcMKO1/W46yjMdfZl1yXpefIAcYckklZ
         gMWg==
X-Forwarded-Encrypted: i=1; AKwUvBxONTKXTLFkickTk3U8Kqp/dnQD7HFrpq2mX8OizkDxXTD+HBB54A2pOccFC6VJ0s8iW8gpHYA=@vger.kernel.org
X-Gm-Message-State: AFuF++nnAmjw96UwvlzKEWkkug7Xr/EKTkKZbyYFIVoZmYBIwda679RL
	0lt3bkg9pyHw7vSFOXfgdEglO3/OpqosLQPo4lCBcwQKZ+K0AL46cFv4G5Hh5pt5ZpvIzTNnVO7
	QPAtdu3M1W2/XEXu2cgmOUoxgiQbfkSk=
X-Gm-Gg: AYBFou1bNWRWCCjlatHHQf1xsNEQ0BjpQmCnTV7GQfUH85MLLCJgbqVunP7J0psBvWh
	QEeQQspn1mYpW/d7m14E6vAAaGG9GuVpqIipqSsPFGK8vl0iIWgcsTDr/4Ox6VPJsTkczQsSjyD
	5n+a6bv6ExBBdy+YpIMAobjPeNFhqc/7A9zXqRWQjrBjjBwOlH5jSVj48ctdbRZbDot+xTG2bpA
	i6IwfQ/1/5wSDBS90jG7ZcZUODT+kyNa3LTExqBLXqwLQywbIXFPcsMoesL4XQK592m54ZlPh6E
	Eq5VkLZGVaDXDryi0WiofNWg32mwOGm6LhTim9g10zFD845cn+rrXBd0MQxpx6oQ9FmDwR3iZ3J
	ofMKgiZ4XYA==
X-Received: by 2002:a4a:e911:0:b0:6b4:5cfd:f381 with SMTP id
 006d021491bc7-6d2d0836a4cmr577159eaf.25.1790110774153; Tue, 22 Sep 2026
 13:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918-net-next-mptcp-msg_errqueue-v1-1-dd77e1738248@kernel.org>
 <179001595171.2160803.3670624686905872378@kernel.org> <d6cdbc83-86a6-4c2a-ad99-29cdb83566dd@redhat.com>
In-Reply-To: <d6cdbc83-86a6-4c2a-ad99-29cdb83566dd@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 22 Sep 2026 21:59:22 +0100
X-Gm-Features: AcwNN1VUII6uOcsfxfr-62vUKq7jiIrNoNXoOzhNQ-DW9bOGJNbIJXNMHXPivns
Message-ID: <CA+XhMqyGNBrd=Kt71gk2M+PC3bZxfPt7ujswBGe3pRAFiuz0PA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] mptcp: support MSG_ERRQUEUE on the parent socket
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sept 2026 at 14:30, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 9/21/26 20:39, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] The new error-queue splice is dead code for MPTCP-native dat=
a:
> >    its only accepted input (SO_EE_ORIGIN_TIMESTAMPING skbs on a subflow=
=E2=80=A6
> > - [Medium] Forwarded TX timestamps expose per-subflow identifiers inste=
ad
> >    of parent-socket byte-stream identifiers, breaking the=E2=80=A6
> Sashiko comments look relevant to me. Basically this work makes sense
> if proper support for mptcp-level tx timestamping is enabled and the
> and sk_tskey is resolved at the msk level.
>
> I underlook at the above during reviews on the mptcp ML.
>
> IDK if someone is currently working on the missing work/bits.
>
> /P
>

Agreed, nothing arms tx timestamps on the msk today. Let's drop the
series for now.

I can look into it.

pw-bot: cr
