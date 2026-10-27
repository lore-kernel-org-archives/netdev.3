Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105942;
	b=KMw9pDnc906edq/Kr2G+FFmHNFqERLq6EfoHQb4TMEGWGHbAB6bGDY6iIhiPbRx1+5zC
	 DCzJdLeYJHb6k+AJou5axPusN8/t+fjF3gxbjECCXdP0vVL/fgq7wf1nULg2Rt0yYrw0r
	 oILjKoXCkdNRNMuGSuuQmkNYu+7LOsarrPNiaAaObcAVz0avMAhX8dsUesbSzFGCK0Ngx
	 aNqkFWug+F2yKmxpX7lOK20+UCvZZGxvxAjX60e4HFJrXEjXfRt3cszAp13QNrbj0x1Q2
	 lJ8C3Mjvp7bU9K/fBHzuKTMEd5g7elh/veicZ9BFsh6+PHegmsV4yFsWbAG3oMAMspA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=b2oJG/Cx+yrxp2tVulERESQsUaYqENiGI/N1hIw4DgY=;
	b=k5OxEamctYP8bDaJffDX+a1qjyRHcXjjfPLdZy6KfQwx7JXrgh7SRLZkxHS0KqV8GQnD
	 8m6qvI3uK+RSkwS3jXeluKy5hGUOsmQA90s7pPnnfUx9vXmQYRDhsqlvbVITN8wrMX4iA
	 yJIicE90YPX2XwjJeUPbdDHsGUPXEfV+YBHGCYe4cLwVXUfsIi5B6Np32Ve/DknkXEl56
	 a6E19xFK7ZzWfuV0Bl0eFo8Kpg1LZsgH2VFbG78Ei8r5BGzVMjSgM4v3Qb3q+xKOVtrXi
	 ebh+PVh45CDHtDuSsqu7em1CKMSWHCiBsJUBMps8/BzJogEBcvImoebYfwaEozgDnVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B2606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A44B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso27676535e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793105935; x=1793710735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b2oJG/Cx+yrxp2tVulERESQsUaYqENiGI/N1hIw4DgY=;
        b=dCSBHlqJhbxGNxDS28So5RrVfZbL9zjwyxN0BnPVQzn6xBvQNqDzN8GcLoz9swLVXy
         KW+y+lNSZIKsl81mHaSzYspKq0V+gopGCvEfclPmjL1bC+JXRzy1LhZKgMysuIP1bUNF
         1zWrlVUj6iLBuWL6qS5CHZCLctqLx6E+u/nRJp9bT3jRYNWVj0N0dPsbXSjedTXUpuag
         Y+aEcVbY0czb5Dz5mRrmKXWnjUo5kPpKnxNk+aYYzYnfWl8FD+LNLItQMWQd1eG7E4sG
         LS+jDkeHD2jpfcLzzF87vvM1S9lQO9vpJl8N6TIJXRDdtIQui4rq1xQ7KuzG9HFysfyA
         AX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105935; x=1793710735;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2oJG/Cx+yrxp2tVulERESQsUaYqENiGI/N1hIw4DgY=;
        b=iANVbxzvIzxeH0L/DtJfUkuNUWz7+0ZrviMT31oKGsWLZU96hmLElY8r2o+dMlP3Vy
         ok2MGdVUOYxQJXZOu9yP8KwWqFBJisnAjE83+fgTeAlw7T0+sqcKlwRowlTPa9OaSjcJ
         OA857qeh7PeK2uVnBs1WJro6uKvHCaEfvIAflPmCfm12prZFyhi9BO5a2voEe4oCnFsm
         nzNo8E6QNDMp97uz2cg5EU7ZdgHHeqGhf8M3YwV4QHrAsCaiFc4bGt4gWD/L91mMlcLU
         pN4Q4cKFdzhX0xuTbpQ0H3EMxZJo7X/IU7nI3x6q+4+hMcHE1FJRpCr0x7TGNhaEldMW
         aMPg==
X-Forwarded-Encrypted: i=1; AKwUvBxN9DzcVUNcvLhILAvqaU9em7pM44CGZNljorJwCpdEBig0/DDMOthCvUVLrs+xI4T/+5Awi7s=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/8GYK+qVYw2G3YpWSO5roT9hCZaJBC1aICBLSQSGqOGwksFQc
	gpq1edTBTdXmDzqWPg7Vxt7XO85bSSkUG8QpAncaq7ilxN1Iq/TAnkq3gVAXB+FNeFk=
X-Gm-Gg: AYBFou1Mx8nN32C+UUqPihjvhPVwm9Q+DM03cz9gcYspOgKBN9++MVOLt41YYmR1CbY
	35tsOvRIpOjIEpK9qoBEKAqxpex0SAiuLIOmitJ1XM3Qk3f0MlWR3stj7+u8vJ9JMq634oYdV3c
	uD9QKZJjgUuGbEaPl81OzObTMdhzCsWi4o84kLZHuTUgsvGgqZgY7+lo1M1GDchZWXbHPzt9kzy
	dgaN+ZX7WO6nIumnNErNX+uB1aVsUGFs77X+CW6Z+6Mzsn+Gj6jT9ybdXSu6qok1AquN13Deker
	FHE7nEqqScT8FlP0SW9XsvMVNStF8oy6uQydD31GNgdbRezQtnCqYNUMJhj9cMimZF47MuBdafi
	C4u8eFSMwn00FWxdNTulkEJJdi8MgisiqHBwy9Z/Sf6Jd2QBBsLo1I2wls4byP52yFp9r1Mdowc
	pjHDrMQng5aVE59ZAYAo4EwWGrboryD++Qvc7ROJ+7unORbkRtUhQUBDCR+FgdtJAS0utNWf5d7
	oWwR7bwRQTkGdb3+bv4pNvB4eRA7Mu48HELojMJ+J31uHcnl+Z7K1GZ/g==
X-Received: by 2002:a05:600c:621b:b0:4a2:59:f568 with SMTP id 5b1f17b1804b1-4a35ac95a53mr181284635e9.14.1793105934989;
        Tue, 27 Oct 2026 05:58:54 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d9280sm262504675e9.13.2026.10.27.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:58:54 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:58:52 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Breno Leitao <leitao@debian.org>, chris@chrisdown.name,
	Sam Crossley <samuelcrossley@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer on
 demand
Message-ID: <auCgDAzkio4RVfWK@pathway.suse.cz>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de>
 <at84qygscue8crQi@gmail.com>
 <87a4o0k3qa.fsf@jogness.linutronix.de>
 <at9qgBucVm-QHnye@pathway.suse.cz>
 <87zew0ifpp.fsf@jogness.linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zew0ifpp.fsf@jogness.linutronix.de>

On Mon 2026-10-26 17:39:54, John Ogness wrote:
> On 2026-10-26, Petr Mladek <pmladek@suse.com> wrote:
> > The "replay" approach looks like a big hammer. Many messages might get
> > duplicated, especially when the outage was small.
> >
> > A better solution might be to do not increment con->nbcon_seq
> > when the transmission failed. And try it later again.
> 
> Note that there was a time during the rework that we used to allow the
> console to return failure but decided it was too complicated [0].

> [0] https://lore.kernel.org/lkml/ZdTCZqhZww8_WgSU@alley

It seems that the main problem was how to handle the nbcon ownership
when the callback returned an error. But I think that has been later
solved because we needed to re-acquire the ownership for the clean up.

Honestly, I am not completely sure what worms could jump from this
can. But I think that adding the error handling should be doable.
Well, I am not sure that it is worth the effort for this use-case.

> The kthreads are setup to stay in their printing loop until the backlog
> is clear. Having a nice=-20 task busy-loop would be bad.

My idea was to put the kthread into in interruptible sleep. It could
be woken again by a timer and by the next printk() call.

> > con->write_thread() currently does not return anything. I believe that
> > it is partly a historical limit. Two problems come to my mind:
> >
> >    1. There used to be a global "console_seq" counter which was common
> >       for all console drivers. But we have a per-console counter since
> >       the commit a699449bb13b70b8bd1 ("printk: refactor and rework
> >       printing logic").
> >
> >    2. There has never been a try-later logic. But is should be easier
> >       to add it now. We have the kthreads. And even the legacy loop
> >       is able to break when there is not progress.
> 
> I suppose for only the write_thread() callback we could implement some
> sort of throttled retry if the console driver reports failure. But this
> is assuming console drivers can even detect if it successfully sent or
> not. The netconsole certainly has no method to _know_ if the UDP packet
> was received. And UARTs (asside from flow-control) also have no way to
> confirm that the other side received the data.

Good point. We could detect problems only on the sender side
which might need not be enough.

> Breno and Sam simply want the user to trigger a replay of the full
> log. Essentially a sysrq-R but per-console. I think that is a reasonable
> request and certainly much easier than attempting some sort of
> transmission guarantee.

Yes. I am not against the interface. I just thought about a better
solution.

Best Regards,
Petr
