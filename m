Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F442296BD3
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900348; cv=none; b=a/ksSnfxCWPCDwFl4zBPqV3OASzpzQ7Rp+h/3PhcF+DD7J7e2/xSa92BHuL/1hOMPq1db62r3QjugT/TRQGT3zC0pZ+D5ktTPo7tXK2ZHPPocLXtiPz7gUunfxO1xjqfg16Ziij+shXXoo5Fj1ZRq0i888tyswhsMnsHHGYrOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900348; c=relaxed/simple;
	bh=tHOOuvQftQXv7kCz1QwflqeQnXUUIQsuBI7s7adJkwg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FiKE0+kqparRTzc5+wDtUQ2NHYRlFzNpCwKC1BITNwvk8zEIHGeiCdzJ6vMA6BFemMrggcQX/DrfUuw+EvpQklZdNI6YTkP9chSUqN6/+UK4YMupq1I7mwwdjoZTmy3jPWoD2DupoLU+brARZ/1YJasXKmvKYKZ8WZ/NziImH8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq/dt9UV; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq/dt9UV"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ae2274044aso2373557b3.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790900346; x=1791505146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=535iR1AeWRu7qsNxOz73cbrVlGNHnndMzPzdHrUTQc0=;
        b=Zq/dt9UVyCXAYmJeslfvxQyRPXIlRSMGZF3Ywk6M+VzCsjrAd5r5rf00UdS3Iapwt4
         /QhotAEQQzCdKIn0HSgKkhr8aRFwGBSM5c9iFaFf8iZwjh2FhD8zy4VC0r1gvmPwMCi9
         XOwoZrm2YPhSBSXHANzvEodiiWQ9YREXH+FkKFhL49Mog/Egt1qMfSYFUiG3YQpSLA1C
         O6ucIOTinz50hU1CVpNv1aGgG7G8da81e84hbnwlkuvb7xHWiD0PZDJ5DrFrhOHmcFRt
         OVq9wZazBGOX9Oc+BbegyhSxqS/5IG/Y0mj47cQOikFRzGBCAz6vqFouGmx/z46GLN/s
         VjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790900346; x=1791505146;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=535iR1AeWRu7qsNxOz73cbrVlGNHnndMzPzdHrUTQc0=;
        b=QN+SDpzHywYl5wfdbIm+1QXf2rIrGSm53ZlM1wVJhBbNh0FjKu9lA+VQgt/xcq6fb9
         IsMHennvgLU/IFhuqtqHnQRAcYYAsaep4EoQBwmLEFYUtREZ3T45U5Q+sHMMbOSH0u6+
         RM8TULwy+pzaWZjQaZ7/soQfvDHiBylbZPp/KAClRlbLKwD7HZ+S+mm28MH5l63QgoO4
         fNLrHk5o6Tk5ylHYpnGmuIg5nIAqkx98C0UpN7PgaEfbOXhydv9aH+j/5YFkQEyxqFxa
         ARSAzDD0ErEp5+HHrlbMnicOLxeXFZMIlf4ziCwodqNTREWJ1qaKaGDdgyyP4c+IUKJk
         RGgQ==
X-Gm-Message-State: AFq9FYKKhRC+7Uh+dyMNMqlAo8jQDmcpF6eRkxcGBUG790wOlvUxGRXR
	0g4yQ0ryCTt/wzQ7YK8SMh+tFSLgfui0upJTJoxj7x1CYAU/U33JyLJ2
X-Gm-Gg: AYBFou3fkp4q2TuXZ97AQ3P0FiZHnx8YDTpbH+oCdlse8zihK8JDgtOJ0nFbLb9KtOO
	NUnPU/carLQvi9dDPYKP8BxyWg5NSnTAhPrG4bFyDk85Q0oGz/247GqvssRxmKRpVnbMYr4ps3o
	iErLUNWmAwXKtEK5nRYSI1lns9f8BQh9L/iNbxPYxsd9B9SuTR23IHgENei/WRRVVzTqdAeFFm6
	+qe3UJDVUr6BLRL0zqShXcc+Rh+zA8yZgOX4MiYJswseGRr2iXDB/ElMX9PNc0VbH5hMT2Y07VG
	35jNGDbyx9bTeJghiptDpXcsb19eInKfu6349vv43l2Vm9aSvh+p42fq1lPIZPPEqstXq91+bx5
	7wvihSnvvztbpAktL/n7LiMfqZFNt/GTx1hdKxIk0CxbcLzkAGJJ8l+e74B2wOZIF0L9P4/VWj/
	DPntIjHWCPM32V8PFtaA8ScmJ/LjtuJolYP6MjF5b1x7/KJ2onCJSQ3thqEbcSATWEcWKbwa6lF
	aPE2ZLHRU+a/0aj88DeHx+i2RWegNNkwOIw9eOoDpircdLm909B7sLZyeDIF0U=
X-Received: by 2002:a05:690c:c3c4:b0:8a4:e89e:5185 with SMTP id 00721157ae682-8acdae4a24fmr17253507b3.9.1790900344396;
        Thu, 01 Oct 2026 17:19:04 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae330e89ebsm3300567b3.30.2026.10.01.17.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 17:19:03 -0700 (PDT)
Date: Thu, 01 Oct 2026 20:19:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.7eaf3a38aa5c@gmail.com>
In-Reply-To: <20260930-psp-defeat-v2-2-f266e7447129@gmail.com>
References: <20260930-psp-defeat-v2-0-f266e7447129@gmail.com>
 <20260930-psp-defeat-v2-2-f266e7447129@gmail.com>
Subject: Re: [PATCH net-next v2 2/4] net: psp: require an established
 connection for association setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> Check sk_state under the socket lock in both the rx-assoc and tx-assoc
> handlers, and only allow association setup on sockets in
> TCP_ESTABLISHED. Also, fail connect() when PSP assoc state is already
> present, and remove the dead PSP MSS adjustment from
> tcp_v[46]_connect().
> 
> The net effect of this commit is:
> 1. PSP assoc state can never exist on a listen socket.
> 2. The upgrade to PSP must be done while the socket is in
>    TCP_ESTABLISHED.
> 
> This change defeatures behavior that was previously allowed under the
> PSP uapi. My justification is:
> 
> Nothing useful can be done after association setup on closed or listen
> sockets today. Listen sockets could accept a PSP-encrypted TCP SYN, but
> the child socket will not inherit any PSP state. On the other side,
> establishing PSP state prior to connect() will result in a PSP-encrypted
> TCP SYN sent to a listening peer, which in turn has the aforementioned
> limitations. That implies that there cannot be any users of this
> feature, so it should be safe to remove it from the PSP uapi.
> 
> In theory, the check in the tx-assoc path is more restrictive than
> necessary. FIN_WAIT1/2, CLOSING, LAST_ACK and CLOSE_WAIT could be
> allowed, and the peer would accept PSP-encrypted ACKs in the
> post-FIN-sent states, or data in the half-close case, but it is simpler
> to disallow those states because they don't fit the upgrade model.

And preferable to do so. While it could be allowed, there is no real
use case for it. Simpler state model allows simpler code.

> The check in the tx-assoc path fixes a bug in commit 6b46ca260e22 ("net:
> psp: add socket security association code") where an unsynchronized
> write can be performed on an assoc shared with a timewait socket when
> the socket is in TCP_CLOSE after shutdown. This commit is not targeted
> at net because its premise of preventing listen sockets from holding
> assoc state depends on net-next commit 8cc3aef0cb19 ("tcp: Do not allow
> buggy transitions between ehash and lhash2.")
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Even if targeting to net-next, you could consider keeping the Fixes tag.
Importantly the prerequisite patch is mentioned. But is only one of two
mentioned here?
