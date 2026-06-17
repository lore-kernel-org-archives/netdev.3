Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82A3C2D
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781654775; cv=pass; b=Z4eRPPPXDzbB56utCBCKu6I3C2Mxn+VZ8JJwz+h9n2AwNEiW+ytF6g4qAbnhQfwf/aMsENYUwMqMVBRokJfgk1Xc/8lBibe6LBjHQDW/GlqxRAU6oRrVPOWulkjf0KsddYXvYZdzEmUscvajNH8iXb2etuaRyzpjlJLIZJKebEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781654775; c=relaxed/simple;
	bh=fkrCmopnIb13ipuEWVakk/KrAFvH7xz7xKtU4zl9YnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAb0ML36Jn+8ri2Vk7FDSLi5px8lxqCN5aPKHgn4s5PT6JXVooCttRHSmorBtQ7NG9uvBSGeKfn08UA90UVbef/6o34GEEAN0QvOUNuEpoKNjzpmHQDDaMLnvU7L94LGJI+FgawLYW9Ypd8mXvOjr3Tdkl/U0nryrNUjEUXDdvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyKfVvUQ; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyKfVvUQ"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304f590dd91so5930514eec.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 17:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781654773; cv=none;
        d=google.com; s=arc-20240605;
        b=fWf8vk2wXzvzhiYlucaQsq124OLxz+urvTK505kBpb8oavg0RRvfCJB4zOpcQlsLuE
         7Bj28+Da1Ww2rX6kGw6QLD5fFPx3c3x/FGj7j2TfTUfrlvtR5+091utDJwgsqc1RLh7k
         qFCJ+1tLUkE8Gn4RsMklcQHFdoguavjxmZ3zW6u8PUjgKNvc4ipELCuNTf6T+9UKhsMA
         wIF5Yg/WX9zkHdDbF9oe8Zd0Lw53S+jMy8NnKV2x8uuKxWGJyWW9zdhAhxpm3oNF0205
         yyQPtVcOmUla/Y7aCnkIQJYVKSAEzE6lsrUBtASFqfC02y7hn/hLHUNKq9BiEl+LfIhN
         K9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zN2+45z8RuYVOYkmuHkDGfc4Yz20/+fHvo1TnYpToEo=;
        fh=XEYuISFnNTW09QotMlHlZDCuZr2UPohCvL77fDWMM3k=;
        b=APQBoHxkDE460r4GZ6nePihAzC6Y67VMMQ0k3+fOkHHrR0ooSokLzWl0OrBs+5NApl
         dQoZcAqXCqioCIH+mwDJ2/rpPlEDWCqMJ9M4vV3bJBSOeaFLstjrPRu5s62rjWpe/+UR
         9LfDTfu5IVNf+PGVjGecvDMjNEMKeM/7RLkc8rycwh9BudnARXq/BpBuN3R9mRsjK31v
         6Zirn+Sbngh3LsJ7P2FqRP/Eb6QEuVHnAY2R9hBhqE378mDwBxX7srj3dmZfVfeG2U5x
         OVBQat8Lb7cwLK2OyMQnzhkrkn9s2ur0xBqRWbvnJIwTZC1OLYVy35CC1dyiSdS8UvNM
         TjBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781654773; x=1782259573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN2+45z8RuYVOYkmuHkDGfc4Yz20/+fHvo1TnYpToEo=;
        b=VyKfVvUQXBCvLPemoQfZAR1bpev/sXFbiYLvZNnkHW2QBnUmfUW5+EnR4H82tLJ5mQ
         fbIQrNhDToKOI5DMRmP4+w7EMro+mYGuAIjLLKP9Lzn3BfdQXT8za5DyMs30k5w653om
         XFNNEfczuDqsfD5hbSGTrtsSYddnbJUa4K7C4jvMEM8XSaE+n2lJ2mgjTlg98ILI/z76
         5t/97QXRzCQrAYGq/eN2YsAu909DuCkIu8zcIYY7nQBlK3P3EbeJa+Rby+lsQstVqhGe
         s/lv8vyKhwQXfYlfGqAo27FN2SyY3wnxyRwRJJSeHt0qUK6RDEP9lV/IulWvAMzMpe4T
         B7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781654773; x=1782259573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zN2+45z8RuYVOYkmuHkDGfc4Yz20/+fHvo1TnYpToEo=;
        b=TZ0P3P0s2xmB8Xs2nrZZ+RZaZ8L14K2pJC/MxIje/jZVjzvJGVfqx9Y61IV+0NcLt9
         IGOHIiQq5yFtnItf1lU9Fz5i86VU3e/D1FHdmf5OACDwngi73+s2iejRNcbD56WvJ5S6
         z/Uhf5aldKPfJ4m5Aiw+k7v6yosu32OkALuZjBfowjg8zkNjy/aHfzFxUPBH7y063H1M
         coCdW43XRhMEEI6YpsFw0HMZb4O0uKLtJsOWXeaA+32Q4Sp4ZUnBz35ERF0BXpyO/xgR
         t+dOaAxI8d1ik1gDs8h/CmvjWfKmeD5bELtuklqjQYmnP1wz2HERFGiwEKehfmXuy2oB
         +Jtg==
X-Forwarded-Encrypted: i=1; AFNElJ+bpPN2iEsMTnapcDFT+ZiDsW6qVNqEdkDtHzNg8efn4vVJtWS3rodCosQ+bi+dV/vujM/eLpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1yHPtMknjPfHIJ62SgsLmki+xPFSJe7WcjK/x84qusdJk2CHn
	TEnT8agpM/7AuB1nAECk8IfFur4hmrLwlJ7WDuw2+L0T7amr0PyD1KliD2Mb0Ue6xeiWfpKSRaA
	1gY5GzUxbd+Iu/Wy7bazPMWCtR0kvjnIORTtx6UEB
X-Gm-Gg: AfdE7cl0K4kUr/XRb9IP9m7Fyc0i6HDqZcWC0nxhf7FirkiZNshgnkeF7j6ICNBO/0i
	mxnmI5gDOev5E2MvP9rqdDsapI4ZPLoNy4m+a4JSf4H1ac3+979ix+jd/TghWS9p+RopqxEljz+
	78usS4Img7vLSdSE2TrCSr23/oycXj6UOKMzB1Wk97B2zJ+bvU780uSYdZcg7vBJC3eL9SlERQz
	7sJHOOkPmIirmVBqkxOv2C6wjp6Z/Q3q2v2dd83qOlBo1BNOHurkVHi+zGCxXNTv5nkc4a077pD
	/mT+vDAh9xp8Dpvg1AGjYC2faLo98mweLULKsI78bM9OVDc+Dp4GJvyUmWVvLOh2cO4v6GBWyMP
	FZ2y52YhMn6WGhOODbnekWIDpRWX4ykaR5i+8Owa+wqVlJ32W
X-Received: by 2002:a05:7300:6917:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-30bc992c59cmr985150eec.5.1781654772212; Tue, 16 Jun 2026
 17:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616143020.3458085-1-jkoolstra@xs4all.nl> <20260616143020.3458085-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260616143020.3458085-2-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Jun 2026 17:06:01 -0700
X-Gm-Features: AVVi8Cce5oIkQ6o0SM96_tTZrEuKWAAnxCW1BPbsireeIZuVvbRqCN_usM_TBAY
Message-ID: <CAAVpQUDqPsRXdsW31prBCDart-LGsF2EmFVN31gB3Nx6WPT2kA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net: af_unix: Useful handling of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemb@google.com>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 7:29=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> highly problematic behaviour, because it leaves the receiver
> wondering what happened. As per man page MSG_CTRUNC is supposed to
> indicate that the control buffer was sized too short, but suddenly
> a permission error might result in the exact same flag being set.
> Moreover, the receiver has no chance to determine how many fds got
> originally sent and how many were suppressed.[1]
>
> Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> truncating the message at the first blocked fd, keep every fd slot
> and store the LSM errno in the blocked slot.
>
> [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm=
-denials-on-scm_rights
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/file.c                         | 48 ++++++++++++++++++++-----------
>  include/linux/file.h              |  2 ++
>  include/net/af_unix.h             |  1 +

net-next is closed during the merge window, so please repost after that.

a few comments: please

* add cover letter
* separate fs/ and net/ changes
* do not touch tools/testing/selftest/Makefile
* use kselftest_harness.h and system()
* check other local rules (reverse xmas tree order, etc) in
Documentation/process/maintainer-netdev.rst

---
pw-bot: cr
