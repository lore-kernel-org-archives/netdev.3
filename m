Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528319;
	b=dl6pV6D/UDs6Fg4/s4HvLnFBcaLiTQXBAB+rScjnM57UW+sjzV8o+lh/pQR/u0eGf+II
	 CJXgVJAUllZsZt95PROMUGN4hVY6hRCCKt1ZaAsQPfWMXZxfiCRFyc4e5msmXy9Ry3LjN
	 A8d4v1fEVc0Hrl35kwfVqr1yMlZkOm8bD3bkXQLNZlvKhT+lPrOXQ8EYDtq2PufYr11y3
	 Wt/uJuS3rswjlk0GllI7jvpwx3uV4nPgFGQpx7+Uc87GWoxVHK85kTEsMWS+mFhz6rpCa
	 mNPkoiritjUY4QdEzjv1dEK9TDVcxRat3WVXsP4J5JQZrUTurP9NjkLL20SqgATRZwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
	b=nRp5Igys+F/GL7S2iEt/f/A6eHX4tFSqdpSNWohRgnPyqGhYoM3FJLOCFjk2s779Rk9S
	 2Of0kOfHuMYiQUCSo0vSPdhg79Wi5d1KbcbSmKOo5tsifr6YoCfFrVwFmFsIpRxxPJuzF
	 NhHFeCMVWzVV8AvmeHRsZdW+yfy5wcnjA3f3ltq8V0z+/NviyCzMnGwLPh0iSxd8BrbL0
	 QQRC3BeO1Ur0mrP3TQCGEjpcPUKLg8smbCNOnnVrOXu+hWcJJGwhlaG8WONAfCgEZlLRi
	 hSJXN8INMgjPI1+p4kLJCAK+B7pQOmcdyrC9063UaSl0NNFVIe319/QdsOl+xdkld/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DmDmIqDs;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F63606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1F63606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DmDmIqDs
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7d2dbe5c4b0so97728137.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794528318; x=1795133118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
        b=DmDmIqDsd3KGpm3pYfSBm6QfRSeIJaviqKbucIixjaB2kq+0Uq/HX0AqFy02tySaaa
         Qasz/xY0ZgxEaiLqbAmrfPtK8sdbsfG9DN5C8SYcR/++KtBTGbx00Bbvc+Ak6kUYclTj
         bLBS2xO10lpVwFda9Abuk9p6yYUi/hYA005qCZtVscxZENGD0FOgt+r7Dok96HK1zf7b
         oF2K6A5jk/ZYZdCHz1yI2OlArvWk/HXMFoIC8kBl3ssryTugnB9UXOyMZvA0LIMc7V22
         JFDZmNfldjBnPKSzdsK5KnSEQdhHWfv6cpmHKJbbrqn3ZzdKZMFwBoHJMgUPy6a4AAbC
         6s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794528318; x=1795133118;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
        b=ZEgBMbF8V+oZkirofIdFY03HUju9wYcF942Rl9k4gO+8RaRJ5h3OqmemqlUjH/GkuJ
         2VlA+U6QHDeDVOk/Egj8AgqyOfXtc2DyFjNF7us4m8R+qx/9MczRMZLXauGMq8u+Z4dX
         g2VfyOf0uXA1qQsvijblQR/Um9z2Y7csA8CnsWVfui7piAHBuc75qPf6D9ZWSiHLjoOl
         xtUEWEHu95kIWvE8pae/rk3kmYIRtqET/4W69revmMjh91uweMhxMEF2FhsiKnO9cWzr
         Fo8CPfWoou/O0O4Fkk3eayWFglmuey8y2jDdPRrvWVhdOrV1xFasjweaNQMz+zoonCOi
         FHng==
X-Forwarded-Encrypted: i=1; AL+hErHpaEfy4k5BJeMbr0Oox8J7w3CJ5QIOxL/BCf2sUrSbdFcqv5z8rR/Q4fzPlvvnewHwdCAQL/k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8etG4vyi7Qr9wnti43UlH5Pe1wy0W5DNIa6kv0C2O3AK0dhPXe
	0IB4f6grAuWZWZ6d3TeIc60p2GWa9HNBJ3NnzEJF9v0mRf+T2XHzQDGz
X-Gm-Gg: AYBFou3SR/VPhmlMXYvi7jwRqxFFp7o3q72B/UvfvbwrHPdfpRIA0G0goHZcl4ydRvJ
	icYh+Wn6ALMrh0Cm91cmQNBQ5RNCA8JNXBGgpbp4LytNyOii/Fi8C7qzfLTAqkbpzn5b2L5ZT+M
	8zxpiAJ8CWEkAs3aeLHXPQ/Fy9iCMbfvN7ENQO61soJ5MWrisbTv+lXDegmEWLy1Tx1Z+ikzEE4
	ki6AQvsYZcvT9gfxpxu/LKo0aa+v2H7HNSvc12eKivtdzDacfguhBteo+0zR/L5qMhvKLD7bxC7
	labFN57Xb///xy5eFHZyUt5DkU9YsdzJRje0JXGmzXmso7OLbnPZKXiuYIu6gs7uWLvlQA7J9Xh
	wvCcFaeUXKuS1wJASrYWaUoC0CNng++9t3LVuqiz/6koQkZrzTQJtm0I4SkNIpYiI7K483tSRk8
	8QaKX3wqt/IY1q3yHEiCkXPFTpDEXNXYJnrfJ1LS4Aa03TBvxrxhdJogjrpdf4jgCQI+Z7887zN
	D5uIlhRyyEAv+Ga4D+rYlyaqGuA+2m9XpaXZCeyEo6k6tocIo3VAw7tRoP7ieMCEMT3AzBop8gh
	f/WYveSG/pzt7n8oUF55wVnUlmsFx02cG0FLQMSCLb9XPVNSWEUIUM2/ke4axq8xwt1YLGCfxUf
	bOnUm66zAADJnBoqf377ryppFdGjF612ujuovuE9/VmWykS+x/R1Z1BgOx+1qux3Jag9NkYx2Dj
	cYBWQWUpzh
X-Received: by 2002:a05:6102:32d1:b0:7c3:a6f0:99cb with SMTP id ada2fe7eead31-7d64db100cbmr246150137.33.1794528316894;
        Thu, 12 Nov 2026 16:05:16 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c8424fb8fsm546119241.3.2026.11.12.16.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:05:16 -0800 (PST)
Date: Thu, 12 Nov 2026 19:05:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jan Koester <jan.koester@tuxist.de>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 op-tee@lists.trustedfirmware.org, 
 linux-fsdevel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.31eb7df44411@gmail.com>
In-Reply-To: <20261112153841.1661720-1-jan.koester@tuxist.de>
References: <cover.1792552161.git.jan.koester@tuxist.de>
 <20261112153841.1661720-1-jan.koester@tuxist.de>
Subject: Re: [RFC PATCH v2 0/3] uid_r: convert tun, ivpu and tee
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jan Koester wrote:
> Hi,
> 
> Building the UUID/GUID id RFC (uid_r v2,
> <cover.1792552161.git.jan.koester@tuxist.de>) with a distribution
> config instead of the one I had tested with turned up three users of
> kuid_t/kgid_t it doesn't build with: kuid_t is a tagged union now and
> has no .val, and it no longer fits READ_ONCE()/WRITE_ONCE().
> 
> 1/3 tun: TUNSETOWNER/TUNSETGROUP write the owner and group under RTNL,
>     tun_fill_info() may read them without it. Mark that read as
>     data_race() instead of READ_ONCE(). Only classic ids from
>     make_kuid()/make_kgid() are ever stored there.
> 
> 2/3 accel/ivpu: the per-user context limits are keyed by
>     __kuid_val(). UUID and GUID users share the (uid_t)-1 bucket, which
>     only makes the limit stricter for them.
> 
> 3/3 tee: the TEE_IOCTL_LOGIN_USER client UUID is derived from the
>     classic uid. With __kuid_val() alone every UUID or GUID user would
>     get the same one and could act as any other such user towards the
>     TEE, so those logins are refused with -EPERM, like ublk refuses
>     unprivileged devices to them in the series.
> 
> These belong into the series before the patch that lets kuid_t and
> kgid_t hold a UUID or a GUID and will be folded in there in v3; I'm sending
> them now so that the reviewers of these drivers see what uid_r means
> for them.
> 
> Jan Koester (3):
>   tun: read the owner and group without READ_ONCE()
>   accel/ivpu: key user limits by __kuid_val()
>   tee: refuse user logins of UUID and GUID users
> 
>  drivers/accel/ivpu/ivpu_drv.c |  2 +-
>  drivers/net/tun.c             |  8 ++++----
>  drivers/tee/tee_core.c        | 13 +++++++++++--
>  3 files changed, 16 insertions(+), 7 deletions(-)

I only received this cover letter. Also do not see the patches on
https://lore.kernel.org/all
