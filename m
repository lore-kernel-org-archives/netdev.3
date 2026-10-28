Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187898;
	b=cT62zJWbKlohCSJ57fOJ0KJqGldRGyUDu7+pYEA82CRTGAkM/KJKONMX2AeeSEJoihTt
	 FVMDxY5wgQrPC4lwc/b1VVHDS3aLZ+3RJO4NojXkIZ7m6J2NUdZf9GurqoxTRG9kIqLOB
	 Lj504IL50fZegXy8Cyb2hj6g++chW29N77gRqjwkLshITwQuNOGBAPW0ApTHfytt3fqzu
	 JBhzFqnlR1MAG3h/ZsOn7/Z/kDLKYwusrKNYm40hET4YM8AUyKZYnTjrN7VG639OECRP2
	 a2RFyCUmAFb9Cp0GUxrdgRfHD6MyOuM25qwMyCecqY53+HOXaivYyO/cbin/tXQDOoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=guTerj6OblcyJMPzDZY4qQ3gSTVMiXqm+ois6E1+oSo=;
	b=oWLTOTepsM/uNB7DjkzfhUC0zqp1g1KPUavVlu2cpAJdPWTlT6EWYF7crTKUjCRu0lDL
	 3MCrkPsIkSL6oNSqK0b4y2hwQWdWjOuyu6kKm+Be7bUomcfmU74GQwqnu1v+xg3u8ic31
	 ec6cYZvKZh+AACUqj23VOU5fvI89yNSaLEw9qEg5/JTbtsp/FPHYNNP8rG2AXHWFClI74
	 6z8vqVC/KPEG5vThUFlyIFhhAYD1hOnnW2a6tQL/QWJrz1u2elT6oZkcc2B7yth/9/ota
	 dXIW6EjYheXDEz2UY9Piqxw5bENPTebuldjHWhR/I9eEsDzGtod9c72gRTeSguC0mcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaAF0lA8;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CA606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 11:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 925CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaAF0lA8
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4550d8ab15so108627666b.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793187897; x=1793792697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guTerj6OblcyJMPzDZY4qQ3gSTVMiXqm+ois6E1+oSo=;
        b=VaAF0lA8vg3UVEx7CzAR7lXapZiYbDhEMvH5YaLKlpkw4/CzUtNlQ/rQgWjE81yYSJ
         qlTsxO+pbGZheBNG7qb+QQ/fnoxeL9f+dtPWdssr/07pZbEa3XzF/0oibK9xMm4Siurn
         DYFHq/8NXPT4ax0qAZii0Ar8/TpfP5ykww4/dCwDaMbBjJPm2Qg0TQy5vuKn3JPOqC7Z
         PS2gESYZdHA2s1Qi2oGsLWtsQYzEOAINQJme85SFYcGflqNfQs29vvRLqkIAIpkVEz0G
         re02cQYMuyvHc4JMLrtW0WWxWPBCBM7rum0ECTD4kZM2ww/TD+DrFNXSyI2cPDJf0bUD
         6CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793187897; x=1793792697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=guTerj6OblcyJMPzDZY4qQ3gSTVMiXqm+ois6E1+oSo=;
        b=EvVbywlN70gW9y+bNcHhIhfK0kWKi1I6AVHJ+KwJmGqfHMzGp1yJK1f53z/uFeEwAY
         dUgQa9LV5FMwOQT8AmkT3JtXjg/g/EnUKPodtGYjUzW/ApGBZ14jL/PRr8yUODLdegsO
         2Jk+WOj46I2BDe92rztyW9xU+z1/quHrCQSiVUSYXTgbG8Vn0U2vlUSKw7zfwjark8P7
         VYWNGj1W38Z5bsJ2Wulq5Kv4ZxVzqqYogi6VN6nRtao6XyTsIXS8v0qazlY/2+D1z9e4
         WPcpH8tJYT90aSVzdnnUswwxdYjwGjV1QY9A868u4ougMowtYm6xhTRO0eQKIBYiR2pU
         cbYA==
X-Forwarded-Encrypted: i=1; AKwUvBxbN7SYsGVNruoDkPsuICQf3R8wijVzQ4t9BhxEW4UUHbqkIha8rxD2pIS58FgigmpR9rLQ4ig=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkeUVKs6Lh5ELlR2OoFBid/rfaxzE5XEexpChKp2C1LgS0tINA
	YGQLc4aTeX34XtFVRufruf+UpUDZZ9JsuSngDX8Nlkr5YlDxvq5boYax
X-Gm-Gg: AYBFou0CaHTTshAsJXDrLNEaB9ZpEFNNMupGwLOWoK+eTm3zs1bN3bXr8g+n+vdlrY2
	n98IWpOZEqAcDV3fY0G+J2Kv1b0wROl+yU/1hiSiOXp3iPrUnvXuHXpzbHWrQuIsfYka2EVsdBe
	WJsSnWLqw+Bc2C+eRI+xNI26IeKw2GcPvOdY7sx+GxIyT+TjwU35M5IOh5FvGo9tE9K5Q6rv0gu
	rdPnE8AdfokG7eFUs7mYrjxFU3JbQoo8qeIfflCLxC2aPbYWCLAFB24rpwgGW2gXuaKivkmi6+d
	eP5j1YeQI1ry/1fLrjlLHTnASnOxMKr45kGq7pIdiK7vcNBtC+Fozqarivk0KsRoemj4BEyWw1M
	VmXbyZJ1QH4ZPKJgBb9drV4NuvMSO/Xb2gDKbtp4Bio6UbGL0d4AkGOf2Hy4f2hwfl30t4T2O2k
	lOQKfX3zfroDUombiRkM/L7eDtbnssoaXItOGc0rqOH9g1VWIcS3KjzxNwCgrR3xFfYgX4q7XJH
	U+N0tI9s4WHz6RRtL2zSDb/Y/jxv9p1DbuI3V6AkwlOK+yh634bXdp8HUNiSfNPmUqshk2/1PEV
	PD2T5bD7Qgg3IS7HRaY7Cg==
X-Received: by 2002:a17:906:dc89:b0:c2d:d019:d414 with SMTP id a640c23a62f3a-c49bdf1a26fmr190348566b.29.1793187896594;
        Wed, 28 Oct 2026 04:44:56 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4eabadsm602548766b.14.2026.10.28.04.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:44:56 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] lockdep: Keep dynamic key hash nodes in lockdep-owned storage
Date: Wed, 28 Oct 2026 04:44:49 -0700
Message-ID: <20261028114449.161185-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at9eq_3YUIL1ACEK@tardis.local>
References: <at9eq_3YUIL1ACEK@tardis.local>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 26, 2026 at 07:07:39AM -0700, Boqun Feng wrote: > Yeah, I
think if everyone call lockdep_init_map_type() right after >
lockdep_register_key(), MAX_LOCKDEP_KEYS will be reached to the limit >
before MAX_LOCKDEP_DYNAMIC_KEYS. So technically it's not a new >
limitation. Honestly you can just make MAX_LOCKDEP_DYNAMIC_KEYS = 2 * >
MAX_LOCKDEP_KEYS (i.e. without introducing a Kconfig), "2 *" is needed >
because a key can be in-between lockdep_register_key() and >
lockdep_init_map_type() and pending_free can be delayed, so "2 *" >
provides a buffer for when active key numbers > class numbers. > > It
might be worth checking whether a lockdep_register_key() is always >
followed by a some sort of lockdep_init_map_type() in the kernel code >
base.

I went through all the callers (36 call sites). Mostly yes, with a few
exceptions: ath11k/ath12k register a key for every SRNG ring id (170-210
per device) but only initialize the rings they set up, hugetlb_cgroup
initializes when the cgroup file is created, and omap_hwmod, ucsi and
jbd2 skip the init on error paths. (omap_hwmod also frees a registered
key without unregistering it on one allocation failure; I'll send a
separate fix.)

The init itself doesn't take a class: every caller uses subclass 0, so
the class only appears on the first acquire. That matters for qdiscs. mq
creates a child for every TX queue, up to 4096 per device, each with its
own key, and a child's q.lock isn't taken until the device is
deactivated (or, for qdisc kinds that take it on transmit, until there
is traffic). In a VM with this RFC, four dummy devices with numtxqueues
4096 and an mq root, left down, went from 214 to 16384 dynamic keys
while the classes stayed under 900, and the pool ran out.

The class table is already exposed the same way, though. Deactivating a
device takes the q.lock of every TX queue's qdisc in
some_qdisc_is_busy(), so on current tip two such devices taken up and
down went from 852 to 8192 classes and hit "BUG: MAX_LOCKDEP_KEYS too
low!". (I ran both as root; from the code, the same commands should only
need CAP_NET_ADMIN in a user namespace.) So the cap adds another way to
reach a limit the same user can already reach. Agreed on dropping (1),
and I'll go with your suggestion:
MAX_LOCKDEP_DYNAMIC_KEYS = 2 * MAX_LOCKDEP_KEYS, no Kconfig. That is
16K, the same as the RFC's current default. Should LOCKDEP_SMALL keep a
smaller value? 16K nodes are ~384KB of bss on sparc64.

If the qdisc case should be narrowed anyway, net/sched could skip the
key for pfifo_fast, the only qdisc with TCQ_F_NOLOCK in its
static_flags, as it already does for ingress, clsact and noqueue. It
takes q.lock only around its requeue lists (gso_skb, skb_bad_txq) and in
control paths, never across a nested transmit, so I don't think that
brings back the mirred false positive from af0cb3fa3f9e, but netdev
would have to agree. It wouldn't bound the count either, since the user
picks the qdisc kind.

Does that work for you?

Thanks,
Vlad


