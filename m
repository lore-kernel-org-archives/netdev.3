Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74A372B57
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463290; cv=pass; b=FzZ3kKc/JerFZkViyRShZJYPEv9jDFWfi08esyM6Bq4/w94EnVFP+glN3iahCFMEf3cT4f4SJY2TmCZpXCf5ylRilG6er/oDb6FlLeYFHLAuUMRhCNgeLd19la2y+R+Ru7Na1mv4pScb8zmlGukqIUw2RcnYZt3BReKQ2lHUD+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463290; c=relaxed/simple;
	bh=YhxPKw+0F370XaAgA0d55WGySacBzLz8rZGCOhUWrTQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OVnRuRz0/N9wFK6MKGjebRZuFpzLJiGfW4MR4lqIU8I98Ww4plOEgHfZvBzawLlNMm61FW9tZr7KXulhElfTxxtIyh6Wds5MBG4vZOKAPqUu4DUUgtcDOAD39zW5bWiBERptscuwxhm2K92qMFvqrI8CPnfsWi54v1Qi9Fk99M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEvFEbcL; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEvFEbcL"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201ebso2541269d50.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789463287; cv=none;
        d=google.com; s=arc-20260327;
        b=dDA4bdA12B8C0sXSnHpfOOIf4fcTRYFMOi2i3AtALwTIEN5WJFahXX2wef8BDxJKn4
         Z+gI+Q8i/3uQd1qNX95TYdS8JA4+TFZNvQbwRmQ0Q//VQCpPmFbFjs1GXhlQ7fRrkiCT
         yt/hJ0UkIUf4BkByMN8zrBhV822UHcMFY4y3fwxcEmiOOcNWmAAq7AN5aukAP7n5TESQ
         WbSrnCLz+UITMgWO1571N7PGKiF98kc6YYded2hcB4nwqrgF13Xd47QJqhWIgJ7ROPOa
         ECLWr8ip1vVD0Ns9B0NptpmBv5lksMHSvi357j5RQINUEpHk1YRq+elzqWWzV6qHMU1p
         iOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Gu8o41I2XXzRYGs0+w6OrfrzhP1q+smJSphMsWAZ4Fg=;
        fh=GKJ6JCd4i2svkIYptaocrjxsZvydyGlQWPwlcJTz8Ww=;
        b=MBL4eMT0DAXNV/sMALtW7Y7FxU9JHMKUifx3WV/HERYxdsVZRdC/sJ0wAT+HQf60EJ
         mXCMFfs4LQ0mdyCRvLiDcMzLtjJsx1sTVnllc1pnzJ5X60MzqED/jX1OSm2OzoQOhc1F
         5SgUikDsT95rZlq5sKamsKPQOLvY1/lw8kSel6KjmsAXyjoEEsTlvy4U9fKeQ9KIjopT
         ic3IKCMcCaLKsOvO+wzahkUks50AeW1ngx8Kc7RV9ZfUAU/tcFedBrVV2NKSNNTWAa1v
         SK1lwD+8oL2wtTs2QS30X9f1TQcXSykYxCjqXhGoxXPB8GRIkjmQ10ku0iZJcnNAOW1A
         ROZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789463287; x=1790068087; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gu8o41I2XXzRYGs0+w6OrfrzhP1q+smJSphMsWAZ4Fg=;
        b=YEvFEbcLWIsnob2/9wr685FW1dGze+2VREXNlBQybzf36JsG1h4CDQfuXJh/JZP6gc
         pyHdx/lB5lhPtBjkZp5IXHJq9+toAyxAaN9AvYBcJSKMqT7foJtb50nasP6/F4QV+LXf
         8JPw70YWYxi+oGy8h5379uJHXVxyb8pOCrR3D9tveMfwy42ku62mubvkEuwUmRpzF132
         SqVUg8/EvgMkAMjsr/5MRhUWRndKxHu8JVY/DflKnG6UrlIrf7JKSeNwBnyasmp1lzAv
         HJGQQJWKrF9AotNosfq/AYmXsYmU9j255NNLaz4XdSPx0Ch5GD+TIpHHmZClblmOX6zc
         L6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463287; x=1790068087;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gu8o41I2XXzRYGs0+w6OrfrzhP1q+smJSphMsWAZ4Fg=;
        b=T5/3u9cS0zi5HZAQOp4pM1PS5U3/EMDUhClBuaYsnrVlWVNVf6osut79bYhgUilRr0
         bTmUrwS0VyFyUG6pE3EU1S/zhi6riHOt0RwH1ACxpLEUK4jH0ukQN891VtnR5J1mcJ/d
         LzrBkKG8Oho7SiF9OK4v1lixdl/KPbdPomPoB27QCbKEPiiLpU6zjOTj+NbMJVXvMZPe
         uF3Rzfaapgy50XjkYupoCJSBYiXR+3KGtydEoiJK/1N7yhNL6yq3iNfKYQ01tUBffKuT
         UQ+8RpOGfHzppGdYAhHCpe7Mt496XhY7Kwia9B7qWjee8T4fq2iCDGhc0aCUCVu/+g+t
         XFJQ==
X-Gm-Message-State: AFuF++mnn5KF0Egdk9vNc/kRRNezCZvXXo8RFDvOA4YcNmY1nmBG+Acd
	+6xQeAUIIr5HtIjJhKRDXi2iGt3Jbkr4pH9q8eQiJMnPdRI8ihCEy0NX7yDbblAcACV4Ovuzwm1
	FGqc2XyZXpAR6voIabHfhl+HfYJjENyX3CqRqGgE=
X-Gm-Gg: AYBFou1xHuj781SD+fjdr7HgKDEucnsOoYVemqazYTTSAC9Ae/HwvfZzqvi/Ln9C50S
	HEYY+7NjVcY4itRSPmuXi2p99BjFGlqvJn93yEPjGsgjmdjM+YmAo9qSV18bJBV7C0wZcUBXF48
	V1pYM0BDjjkkBc7jm6HCG5h64fbZ+57KDEO6qQTZlcuXf7NjV4uJSaJoteS2DeTLcKtKWTNMM4a
	wreOtTKqDVwoizAcwgLUldwdqUENjnydnNcBakN9F5Rnn4Fd9TYehgN+ik4WRiUgH+bMSLtZvSC
	KkHBa4M08mAV4C3KiW6TnhbYlAiO+oVMp+9gOaqsGmx22+JPNHxs1kI=
X-Received: by 2002:a05:690e:e8e:b0:671:4b50:4628 with SMTP id
 956f58d0204a3-6714e1bbd88mr1691227d50.97.1789463286930; Tue, 15 Sep 2026
 02:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cyclinder Kuo <kuocyclinder@gmail.com>
Date: Tue, 15 Sep 2026 17:07:55 +0800
X-Gm-Features: AcwNN1WKYt_LA1WL9vjWYb6kVe2gAIA0jbDKfrsHzKDJpkWLSstkxuDMf5Ww6rU
Message-ID: <CAL8qZ1bxzBXReej7M-20HkBwON9L6NZKZP96bs7s-e=j-_Gg8w@mail.gmail.com>
Subject: Subject: TCP receive memory accounting before accept() with cgroup v2
To: netdev@vger.kernel.org
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	edumazet@google.com, roman.gushchin@linux.dev, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

Hi,

"Resending in plain text; the previous message was rejected by netdev
because it contained an HTML part."

While looking into whether Kubernetes can allow net.core.somaxconn
by default on cgroup v2 nodes [1], I tested how receive memory is
accounted for connections waiting in the accept queue.

I understand that d752a4986532 ("net: memcg: late association of sock
to memcg") deliberately moved memcg association to accept() time.
The discussion also explicitly covered data queued before accept()
and charging that memory when the socket is accepted [2].

My question is about memory containment before that happens:
if an application delays accept() indefinitely, how should the
receive memory of those pending connections be constrained by the
service's memcg?

Test setup
----------

- Ubuntu 24.04, kernel 6.8.0-53-generic
- Kubernetes v1.35.0, cgroup v2
- Server container and Pod cgroups: memory.max = 512 MiB
- Private network namespace, somaxconn = 65535
- Server calls listen(65535), initially without calling accept()
- Client runs on a different node

The server container was privileged to set somaxconn in its own
network namespace. The host's somaxconn remained unchanged.

The client established 256 TCP connections, then sent 64 KiB on
each connection, for a total of 16 MiB. The server subsequently
accepted all 256 connections without reading any data.

Results
-------

Phase                                     Pending accepts   Total TCP
  Container           memcg
                                               accepts
Recv-Q       memory.current  sock
Baseline                                 0
0                 8.49 MiB             0
Connected, no payload          256                        0
     8.49 MiB             0
Payload, before accept          256                        16 MiB
  8.49 MiB             0
After accept, no reads            0                            16 MiB
      33.82 MiB          25 MiB

I used ss in the server's network namespace to observe the pending
accept count and the established sockets' receive queues. I also
read memory.current and memory.stat in both the container and its
parent Pod cgroup. Both reported sock=0 before accept(), and
25 MiB after accept().

The data was already queued on the server, but its receive memory
was only charged to the server's memcg when accept() was called.

I did not exceed memory.max or test memory exhaustion, so this
does not demonstrate a node OOM or an absence of other network
memory limits.

Current implementation
----------------------

I also inspected upstream v7.2, although I have not repeated the
runtime test on that kernel.

sk_clone() still sets newsk->sk_memcg to NULL, with the comment
"sk->sk_memcg will be populated at accept() time" [3].
__inet_accept() then calls mem_cgroup_sk_alloc() and
__sk_charge() [4].

I also found the discussion explaining why simply inheriting the
listener's sk_memcg is insufficient, particularly when a listener
is created in the root cgroup and passed to a process in another
cgroup [5].

Questions
---------

Is the pre-accept accounting gap an intentional limitation of
memcg socket accounting?

Has temporarily charging pending connections to the listener's
memcg, then reconciling ownership at accept(), been considered?
I realize this would need to handle different listener/accepter
cgroups and the root-cgroup listener case.

If that is not a suitable approach, is there another mechanism
that should bound this memory on a per-service or per-memcg basis?

For the Kubernetes change, we are holding off on treating
somaxconn as safe based solely on cgroup v2 until we understand
this better. Pointers to previous discussions would be appreciated.

[1] https://github.com/kubernetes/kubernetes/issues/134194
[2] https://lore.kernel.org/all/20200222010456.40635-1-shakeelb@google.com/T/
[3] https://github.com/torvalds/linux/blob/v7.2/net/core/sock.c#L2542-L2547
[4] https://github.com/torvalds/linux/blob/v7.2/net/ipv4/af_inet.c#L761-L766
[5] https://lore.kernel.org/all/CAAVpQUDUULCrcTP4AQ31B5bfo-+dtw3H8CQGq9_SQ7d28xXSvA@mail.gmail.com/

Thanks,
Qifeng Guo
