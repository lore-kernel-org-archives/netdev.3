Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB453DD87A
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653224; cv=none; b=lHs1jmPyhQpe+SOw4WptQapOic9+LN3qFo43pOCmGhLuARr2/INBbULge0GqiJdUuD1vdR07D7aaEnFBPf5rYWiGMHNWPo5e3PFz/zqw6xLxITy7uKDG3UmBaqlAHyYQYBdAdKXiaTSUeMAvkOtLm6zJ34l0Liawzd8B1r6z+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653224; c=relaxed/simple;
	bh=VwnCPhwqB5g/Gfq9pegelUvx5vJ+9qzrhPFnEoTLFj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aw9WUgfsMouZgTD7YTYFH6cpsQuvMROsRQLpuT9PgwMIWOuCGoo9Knwg2lwYfJRI2os9pKkXcyarmaFu0v8w8hFFlsLE7Si9CRUeuvy+DL1iVSKXwyfvQHyR+CUo4V0hRH6VRLgR8HpZz9KatAUumSuuXP7kmvWnKBNoPVZI+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVk1IN4v; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVk1IN4v"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso636985b3a.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653222; x=1788258022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQ4oewLEkWKOXaZHzg/gCiDZkRqq6di8ok5MYz3oEVM=;
        b=KVk1IN4vGHMnMCG97XQpXbTHJf98y3+I4dqJVHQwU2E5X7AhUmL7O4b8y137+of94N
         RDg+PRMsqaj/jPBmTzrVs7GvenCuuQ2avfcGeHyah0FaZA6QH64zdb0jzM0MOk30QwTP
         xmhVtUzVsMMVgSgZC+iLWsxo15AQkeOBXeHiRsqbnqnMPfQfJhypOc4KV+655Rbxj+ix
         0u2IXLvOIXpdlukahiBQDdcP23v0ct65f8lseWWfnckCQzYon4oK7rb4FWQ1H1xiJ6ej
         51gJfsUYwDh2qxAhVGl37gCX2z7nOG7Gsk8Pw6YovXH+KlNxvKzC9zFqQnVHSsXKK2LL
         wm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653222; x=1788258022;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQ4oewLEkWKOXaZHzg/gCiDZkRqq6di8ok5MYz3oEVM=;
        b=arj86gFBZJnG+yaymvbJMfQkpsD5lhik1duoIVJgPkKnaCz8wEaqUVxt6rtty/Jd73
         xLJ8JC0NqB3E8EDwpvr/mcuvr1HmYUMiLvo8IPRtJfVklFJ9SQxNo3YqwzJI3pJZG388
         S0DHDEw21BnUoEV9K7IApqOuAJ0okYmLrq04Mqx1C0c1oDVh9tJy43NDg/2y9efZntSG
         LequbhwV6JD4GVo9HIVKKOeEqsDoEuM9H10KIv+kpcfOUzHK4j821ilZY8weHAcWC3sY
         UwXFK3ahhltxU0liNd2iNkv0ofC2oK4STtPsois8f/tCKcR+abqnt9sO20GIWiiq+ZPi
         nJEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7PoOA9WQ0T5E6VMwDwtIbj3IogNtOn2awqz8qNhj9ThyP8w29mhrqRGpbYvxEZB29pJWfAhk=@vger.kernel.org
X-Gm-Message-State: AFuF++komtcHn5H47OAxKVsSZmMRIBJFtgWcB8RlBlIfnLcYHWGCv+pq
	Iz0gQrYjrRZbaizwgUfy6zTDxobhFb44LZGGhiqJWzAFSL6pgJd0TBNF
X-Gm-Gg: AR+sD12Km87rMzI7BRN8nErdT8IVnfFKeCTGjt+AyoIheiiYu/n4lSPDXqU6dKpenIK
	UfE5j3R5K6NDjcog8Vxp7EpUHVxTeTzgngIds5Vc45YvoCb9RSu6BVuXyZGn4sUwh0GnINWpIUo
	MZRfpoa4dSoOG6sOUFqQvmcfWYLyrUx/P5ckJ4FOlXjiW81oq2scZLqZ/fhW/YC9g9ZZ4szXSSn
	flbrTN9DfOSnWIFBegq8n1zfpwBGWJMXLaMJLEimNhpfShxntodTIYW2q8J+nciY2xpbNh1JmBO
	drENQbzbqBtsCkPqvkXUcSSxXqO1gqxwIaf+5rzIXgGcjmD37vXo2Y6L37A1BnCIrLVjHVP62Za
	1lIvO3HmJOQxqIfS9GyVLTzsaBD16x7VaB7wm+mZ6WmqCQKHqP9/DOVjQ1TmYtbIqxiBjPAbSxf
	EsuOWGxIsuaKtgUq070pjH5MN3FtZ6jjdQo8xv4guXDL+Iiqx60lE5lGzuFbf49EI=
X-Received: by 2002:a05:6a00:238d:b0:84e:242:4bb2 with SMTP id d2e1a72fcca58-8523baf0f3bmr6228246b3a.4.1787653222346;
        Tue, 25 Aug 2026 03:20:22 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ed495c5sm2834862b3a.0.2026.08.25.03.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:20:21 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
X-Google-Original-From: Jun Yang <junvyyang@tencent.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jun Yang <junvyyang@tencent.com>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: mcast: don't truncate the port group walk on
 teardown
Date: Tue, 25 Aug 2026 18:19:51 +0800
Message-ID: <20260825101954.3799675-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <19b05984-d67c-4c30-aec6-ee8e8be554d9@blackwall.org>
References: <20260812113435.1854275-1-junvyyang@tencent.com>
 <5fddb18f-8ead-4680-ad7d-82123966cfa4@blackwall.org>
 <19b05984-d67c-4c30-aec6-ee8e8be554d9@blackwall.org>
X-Unsent: 1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/08/2026 15:21, Nikolay Aleksandrov wrote:=0D
>> +	/* use _rcu to preserve the next pointer because it might be in use */=
=0D
>> +	hlist_del_init_rcu(&pg->mglist);=0D
> Just to be clear - I'd expand the comment to include why it is safe to do=
=0D
> so and under what conditions (multicast_lock held)=0D
=0D
Thanks Nik, that is much nicer than the restart/checks dance.=0D
hlist_del_init_rcu() works - the UAF splat is gone (7.2 + KASAN).=0D
=0D
Before I spin anything: would you like me to send a v2 with your suggestion=
,=0D
or will you fold it into the open-coded-list cleanup you mentioned? It is a=
=0D
UAF with a Fixes/stable tag, so a minimal v2 now may be the easier backport=
,=0D
but I am happy to leave it to your series.=0D
=0D
If you do want the v2, here is the expanded comment I would use:=0D
=0D
	/* Keep ->next (held under multicast_lock, freed later by the GC work):=0D
	 * a port->mglist teardown walk may have latched this node as its next,=0D
	 * and deleting other groups of the same port must not truncate it.=0D
	 */=0D
=0D
Thanks,=0D
Jun=0D
