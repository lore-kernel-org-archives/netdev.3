Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413233;
	b=NKUou2wH82eDhywlTFgX0UC3R3CbjeBsfH7pgWhTFo4IcuWeLyAJU5VGFmnXuAkmjHUA
	 DGL+LPMVVBx02swec3FwbuI4vRbGUVIhjKpe1vyd/39VcRd20AOebomj+dAVkxOGT9MAh
	 yOigbhpdGgzF4Hwe+iBkHZ43oaOFVnQLS/vCMImw/GpISxB95h2LbgbmfJyYADHMn1F9S
	 vuGlV7Ch0EekDE01l32tRuaxDssOSOMT50njLuaZWSxw4oAU84b/pSp2+wGkSDk5jvmjY
	 mQnX+zGS356DP9erk8vVJN4RsmNv+3YgeZ1E/jVaPH2ucES3TrQKhRvrLeLxMyXcJTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=cHFp4En/rAUFTLXScqvVUN+OZYXrUUs2K6xpAqBMB1k=;
	b=PcESHTGNZHwBsU3fOVEbHwOlX3aWolQBNsgRNX7LxwJUiZ4Fjzl1sRuVcN+L9bJmmOvQ
	 wZlAgIMUielm+B2ZmNPYoKx2CGcK0jj/YXefAiD6T+nylF8xkXl6WWOxkSXvgvUugPUHo
	 EfgpVtoo2cO083M0mr6RIXR2juLvWAAGW5VyUyjGvOQjvg45f4hzE77psDhMn20draRs+
	 5jYTrjNX9zwhvGrJKriv578hBDWuhH8SK1QoctkeXQ5GNgx+NhK6LicVa2x4LZKsJlkjG
	 xw+PHWETeRaIec6cti/ipT34aMgaXapLWM5olC2wsG/SRUUNdlQjv88XNz5yf8KKF8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mdfENQN6;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2C606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 02:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mdfENQN6
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so1043019b3a.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 19:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793413232; x=1794018032; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHFp4En/rAUFTLXScqvVUN+OZYXrUUs2K6xpAqBMB1k=;
        b=mdfENQN6t6KV2+gxpBMtlmFj7/eQL0WvXhxcEUi67SI5kUcpu18sr2Q4sn4VG6EVB8
         GHxveXJLHbI9VdULA+5pdqscgjN8ShE75yAc9iic3WULwm5MdhrvNH/Fo4KdEleXvKnK
         hG7JAd7du4V53dTHJkeDT2xZDRVB8anE3UpwdCvkKUSg4ost7tXBGO0np96Iuyp9n98v
         YE2HYvQVnk6eWBYMK+W8HQf9bWcESam4JrrfmOsRLb6ukgurcVHu7kluQ0kM6Gn+f8ZF
         fsfipu4MQGqBTBCTGVIg5Sip5WZKT7Rfhix78qxvkgKdFkHRU4DGG5p8NbzwJtD8hcjg
         Sygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793413232; x=1794018032;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cHFp4En/rAUFTLXScqvVUN+OZYXrUUs2K6xpAqBMB1k=;
        b=u2M73YJUYTkHRQPIpn4QXv1uO4iQEAWUnG8q/Q+uWSJdKpVtEglsiU0OG2ct7AYv4g
         ZsgWoTzXBnQ5Cxk2ZilnlQ7LZtNOHrHCuoQdy3OY2dgh3eJYgaDZueNXw4QJVjHwTtzr
         bmyAtfEvBsbcfGjzwif4TTSyJ5VLuCNQy4hp9J2X8L7TYt8+sa8GwDFlDVcqZ3ss/8nw
         P9Z1HNFhmavGrG2HH1I2xZABQPDwtPNpf60mUk/rViAg+8WxTGbLAm9ct9944p7rW1JW
         NIFiuDJEHo/Ijen2FEedBDKD+sqazNMGthUZjy6KhjhevMMPGbU4j3iTMSo+LLzbKyOQ
         NWbA==
X-Forwarded-Encrypted: i=1; AKwUvBxL61RVkmR9Y4YLn2qA2w50rlykoEZ0J+W5oqfs9kXssscWr7nWnFerKQT9ainIZgAITH14RiU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd6srvbBpcbE4elUzVAGuy4nTpVQwefOx4Gs2PrMhokRFN9uVC
	12SO0tgGNZ8Y0v9xHloslvztorsJGVQd7spwEOT7y89pbHqCgTHoKH8a+NXBFe5gm8gZyiyvSjx
	vIBfDcw==
X-Received: from pfbjt41.prod.google.com ([2002:a05:6a00:91e9:b0:89b:34dc:b094])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:330a:b0:84e:909:ac03
 with SMTP id d2e1a72fcca58-8a9be48c598mr3501579b3a.10.1793413231647; Fri, 30
 Oct 2026 19:20:31 -0700 (PDT)
Date: Sat, 31 Oct 2026 02:20:31 +0000
In-Reply-To: <20261030120956.3026324-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030120956.3026324-1-edumazet@kernel.org>
Message-ID: <auVQYAGpn3oNw8cu@google.com>
Subject: Re: [PATCH net] soreuseport: annotate data-races around
 reuse->socks[] and num_socks
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, 30 Oct 2026 13:09:56 +0100, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> reuseport_select_sock() and reuseport_migrate_sock() read
> reuse->num_socks and reuse->socks[] locklessly under RCU, while
> writers holding reuseport_lock can change them.
> 
> Readers snapshot num_socks once, then index socks[] with it.
> Meanwhile, writers can perform several operations, storing into
> slots below the reader's stale count:
> 
> - __reuseport_detach_sock() moves the last socket into slot i.
> - __reuseport_add_sock() then writes the new socket at the
>   (now smaller) num_socks index.
> - reuseport_stop_listen_sock() calls __reuseport_detach_sock()
>   then __reuseport_add_closed_sock(), which writes slot
>   max_socks - num_closed_socks - 1. This can be the slot a reader
>   still considers part of the listener region when the array is full.
> - __reuseport_detach_closed_sock() can then rewrite that slot.
> 
> All pointers stored in socks[] remain valid for the RCU grace period,
> but without annotations the compiler is allowed to tear or reload
> these accesses. For instance, reuseport_select_sock_by_hash() could
> reload reuse->socks[i] between the sk_state/sk_incoming_cpu checks
> and the return, returning a socket that did not pass them.
> 
> Use WRITE_ONCE() for all socks[] stores done while the array is
> visible to readers, and for num_socks updates (readers already use
> READ_ONCE()). Use READ_ONCE() in the two lockless readers.
> 
> Fixes: ef456144da8e ("soreuseport: define reuseport groups")
> Link: https://lore.kernel.org/netdev/20260902071900.395567-1-ruanjinjie@huawei.com/
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
