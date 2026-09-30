Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9B4EF12D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781129; cv=none; b=IAKQrfP6PWnYRR1nQuFGt4GCmafNWLhr2vWObTqf+5HMtFh3M0KjdQEFwwwfwyxGnhaSITN0vIsx1EzwkmQS9j62eBnZFsjuZh+AR0JnFkCg81mHLxiqZnyA4bgqOEyhqllJ7OiOrsccBKs2s7yTZequ+JhPFh5zPdhWfuOQTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781129; c=relaxed/simple;
	bh=lrUXHmEgpwpBZg1KeYIXnQS9kDbSdqnOAW5QRXGFF4k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CyiRAiBW9xMAL2fSSJmA0reiqx5/n4TbA14QdE77yQ/VyKmZSPF7hLV9RkwgQggYbBKG+KqRlHoe3rI9b7yJNlQ+vo2bBfd5Yz80iXJdswqz2NdE4rGZheC6lT8DPZH2NwspIat52kpaQ7syjB3EG1oCJ9DqEIH9Q5z2g4jGQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5RaEByP; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5RaEByP"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf31683so54834877b3.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790781116; x=1791385916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sosqBR5ZBFyG2T8A8R0bXKUurIKROOtHmvM8Qp3t9Xo=;
        b=R5RaEByPBzZFN/mRjGZ5udhV4yo6Z1L59wLvtHYCbb/ymikYB6HXvLWa1bloe6KzWQ
         shu38qDuUf10SlOyPOdIKKfN+vEBLQN2CPobXAsQG64RrH7+jND/8oEDWxrasVIZOz9V
         w7/jEkaf3dbBrD4QfDtMH2EaYPjfL8rRSlKIKF55ZMGGYIGdyyywNHTdxXmpH5RvUZUr
         tQ7bIDF7nfnPZBZnjXhLzhQHv6tGjo+eMgnBl17Pelu2ZLLhk0me11LTcS2v2bBMFqgS
         B9e4vdCr4TjMhqpOQriRMQXZ9XKagPtGGls9L/qObYwfzCtH96lhpK5c9o8mNx7tTVkV
         r1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781116; x=1791385916;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sosqBR5ZBFyG2T8A8R0bXKUurIKROOtHmvM8Qp3t9Xo=;
        b=KAzklmmD6VSWkv6WsetoRrJ6zDoegwWPAdZe8231LqVHKxJ0C0xtCi+WmQ+K3lX9Zj
         Hjmkz+HwMjYugbmzppCZd19qwZQGQUtjRTwxlDmM2OXhXA7iimNN6UQncHHzxtpmysf1
         FBYaanHKOWnVT579nXRr59PAvpeInupEYAjBrvrrgkC0R1M4bEqnuxdzUy9LrYxUn/az
         R+MDpQWmSjSrQmz++tOJKc4HbpQanUS1YYiuWKIaJNlmhcMDA9yRitMLgoPr+chfRDRq
         IuuikE7XgvQYdyQa27Kb2PiClAHIl+ik0VCag2dX+BZ4yO7/6iGr5qHkuGip+YJtbJNp
         nAyw==
X-Forwarded-Encrypted: i=1; AKwUvBzPUR4P/8DL8vf8mqhxTXlRmqPfl0pmXANH41un1VrZFPWrnkf6Owl74+NTgLUV8AOUwPE3fKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzgeZwffm2jlENZ7Mcq54QS0YTWDhQTS09/kbJpXgju2iAkcDU
	I1DP/Mu1NbfwEfU3Xi+oy/GIPLWGjASv1YgxMsY7T5NfQsZiUNvkTRHv
X-Gm-Gg: AYBFou2kl+2TcuYNPgCxEsP/8rR5Qp2iEcD8xHmrOSMH/VSLjpnTZkBjiH5d3DO01Fd
	fs4Fd4u0gEi48rlFHr69QO3Wdv9KREhBDbKOnGfKu8tn9WrYhZO1RTc4UpTMSVXLT18R2k0dhrC
	Xc1MCUmbT3h/7ayYaBd3zeopAVwrB1uTkSfIrDEj0oOpNzlbktVa4XvfXl6D1c7Hk9NCPvxr4CP
	PBUqKapaHX+JLov5kR3dfm1OOFwsi35uSDd6SihYYTWWak/hxvT9KoyK0k6B7xUJwvcQlz7nr3A
	DQAsuJnIZ7TM308ZHD3KXHo1xhsuK4LWvac/vpNUd6Qki9+gloLoLO3mGq2kytf4ySxy+X5LxRR
	G9IcPO0hTnH5iqDf2Ioej5invgkl/nR/A8DNZFaaGe/xqN9psqis5ByvhPjxtH27uHcs3pQAq9F
	4m6v2FY3FPp+CgGbhJw6osEMIfKm3/aUPCZhBoRwpbUPrPV+8LSzeHzV9rYmmo5gqxbh0neg1kR
	d90YKvh7icS1KY/Wu2VKUz9k93o4UletfziXRydJwCfhMD60CMhAVnlFkxMaEE=
X-Received: by 2002:a05:690c:12:b0:8ab:415c:d70a with SMTP id 00721157ae682-8ac9341f66cmr6852817b3.16.1790781115966;
        Wed, 30 Sep 2026 08:11:55 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ac5408d2b2sm7727067b3.37.2026.09.30.08.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:11:55 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:11:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Message-ID: <willemdebruijn.kernel.39a4c29511f@gmail.com>
In-Reply-To: <20260930144018.1174068-2-edumazet@kernel.org>
References: <20260930144018.1174068-1-edumazet@kernel.org>
 <20260930144018.1174068-2-edumazet@kernel.org>
Subject: Re: [PATCH v2 net 1/2] ipv4: fix IP ID reuse in
 ip_select_ident_segs()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> ip_select_ident_segs() must put the first of the @segs reserved IP IDs
> in iph->id, as GSO assigns id, id + 1, ..., id + segs - 1 to segments.
> 
> Commit f866fbc842de ("ipv4: fix data-races around inet->inet_id")
> used atomic_add_return() for non-TCP sockets, which returns the first
> ID of the next packet instead. Consecutive GSO packets can then reuse
> IP IDs.
> 
> SCTP GSO is affected. Other callers use segs == 1, and only see
> a harmless off-by-one (UDP GSO has a separate, older issue).
> 
> Use atomic_fetch_add() instead, like the TCP path.
> 
> Fixes: f866fbc842de ("ipv4: fix data-races around inet->inet_id")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
