Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793852126;
	b=22dqrKVdwmxTjc/0yDwQN70SM8H5vbbU6QCGHsOIPPfhYeTa+QgtyzTG1eZx7/BQ650O
	 ZRFvQTmcHO0305C7xrsfwQT89rXBKZAfnl/n1MNBSQsopdIucj5LtJdlkoIO/+t/cjUYo
	 RRIrGgWv4nRAsT1vyQKO7X4sIVSypdLN1Lu0nF7PpAltFAA2TXSfpofyeMeWm2NRFMVHy
	 /oKMq1CDxyUzsBa50pM255e4Aebmg5QRp7HYnFJdy77k+me9tlEOJ1I89wo8qPeDz6gwt
	 Y2IWVN2trk6JvZT8esmZSK0U3Cjh/5C0+0/5krc7HiFcrYdSeS9jL3zMnsQSD5Q1x8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=v/dD+gCFKnFrY8PCehbOuNAzOY6DsEVbOoYKofj71BM=;
	b=aS6bul4ahqc/4e4A5KXpWBiicwJZR0bqbpj3VFE41zNODIDIHiXTMh1cHV485pRvdD/j
	 vus379CzxGCr5nliG5ftFqwuAhtBFohWogh6PouJq6+pcD35djc7N53f12T1sJCtAs3OR
	 cGVO5jTqIA+OTvFlbYRMnxsB7LA1U/ofUcre9Ym9zsKh55IpFAnzgPtzkBrzzN10jE+DJ
	 7OKzv3+mlhBDRhn9aXJLM1sczzpT1pOms0G92HHiNbw2poaQTd64SR+z1LXl/UjnV4VIu
	 Ocr/bFjVTivM5/iAyYADZoyrUVwjFcDDiXOZyP0cuOL72FLvg2z1aVYKrrg+DX7CuEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0KJOhIdc;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75576606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 04:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75576606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0KJOhIdc
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1217269a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 20:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793852126; x=1794456926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/dD+gCFKnFrY8PCehbOuNAzOY6DsEVbOoYKofj71BM=;
        b=0KJOhIdcNUHNh+hpMXflfbO1b2pSAtdJ4Yxe1HdD3RiIbZgv5eF9L95iNtGkRefRG+
         xhRfJsG7UPsTxI8aOUc6LjGjNi8dWWq1jJKUb8Bq+QbuLWVuvv3SrTPVVvsxPoqW1gf7
         rU4v3DCJ/luDVStaJHpRseR0cz4KnSX5ZoZYw8CwZJO6vAIKVaLfZti006GIcsBJjt/4
         jxigIcNr5xPTDyPadQQIDWPkzDfAImALT6hkCPegisUNo4pWSqdSREZ2pHjH3DEAmLcr
         it7bazSZqAVe9TWf4VDdAusFcpyIvb7/vdUTTKOphfMTEENlLWyq4UVd0crxlBGA8mOI
         9lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793852126; x=1794456926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v/dD+gCFKnFrY8PCehbOuNAzOY6DsEVbOoYKofj71BM=;
        b=S2zeeiyvHz1s5zJ4EJEEt2RsLBtuTyPknwP3axrB5ZTopPeRvvRicpuH3u396KrNPG
         /80j+AekDnhIP5a/+oyRYI7hYLJ/3dwFuWVGRaZxs3IfmyqV53AG0jN7ogcr1m/mIDSE
         Mod3gZlE/fgQzjvTj9viHmhM2idEZMNEmstdD8HDIZ5cP3h02hacMj0lQV7LxwO2OjqI
         BVj99k2SP0Lgipc3LLNsAhAL2AYHWJ51rtfA9G+GjElkvfaWrNFJG6jUihOHAbnvLeAa
         0WtQXUOttOstoI+c32hBY2q568ZCmK9ZuLRVsDqwLKvo9KRR+1qLShPZc0u6ywuH+V5Z
         J+xA==
X-Forwarded-Encrypted: i=1; AKwUvBzgW/kdFJEaPmwpqYO1pHbq0YaMVuzajdJNU9eb4l5WTpAGgfgRze8KSLeKvHp1JLTSB4NJKoo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mL9OC6GKwFg8p3tahHomUVNtLET0P6U4HtnAIx+54vd33/Z3P
	yxEzYbkq6aYWVGHnLU6YOI57Tj+ogoDI6WeUGW7EsKsydgvteFDI9byp
X-Gm-Gg: AYBFou0c5QGYoqOuYaa8VUtju/CIXV5USXyBdAww4ccDlriFxYf85zJKm/s4biwu1Cp
	OPz6UBmTb04diaQascJ8XVXDBBX99L6hwGBopk2ITLm+A2G1jG8xjALj+Ou09+b5+cdXQOK+/Wd
	L8nIpJ54yo5cjh3PdsfCvRoXGMlRnff1EFITpwsIrvIpyhSgakbGmcHMJ4rTNrDNEclbfdlNeBQ
	RtZnrFlWDmcPcnViIlsMXfx3tVbUnCv7r8RSkQ1rz6EUuxpDSE2ta8rGeDhhtss5dHO6jLzoJLy
	UQiWZyG2G0pNoevlY0LPeOU+5Y2E3DpzhKL8QBnV+vfG+WhDxjpVCNwWpqUGCNDe8oFnIysGuio
	GdYoBG8CiGNh/ntTa0G50eqfp3JobLEw0Pm8wXgbtiTb3efgCkgB+c6TR6TAwLuqy0FVK4vo/XR
	Tftppw4PJ77ChzwJPpfMhYF0XYizjOD4sF3evxMyQA1PTxN50tAv4AIhVAkj46YEncdV0BXnRD6
	pjXFYKvFyTkkgAO2oYti7109gBjIWV7fE98kpQof72vdf72nC5/jmJ/7gGq6X/UV59o3DH6QHrc
	nARV3kw0NVhIbqkkk4OSxSdFXRtfSY7yqt5T7L46AHDdwciSFeosy1iFot5u5Y/0/Ufz
X-Received: by 2002:a17:90b:280c:b0:3ac:9669:846b with SMTP id 98e67ed59e1d1-3ae895746f6mr15584115a91.9.1793852125571;
        Wed, 04 Nov 2026 20:15:25 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3163383sm1625591a91.7.2026.11.04.20.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:15:24 -0800 (PST)
Date: Thu, 5 Nov 2026 13:15:19 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, ncardwell@google.com,
	kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
	horms@kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com,
	weiwan@google.com, sd@queasysnail.net, jiayuan.chen@linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
Message-ID: <auwC161B4g61ptG4@v4bel>
References: <20261029214219.1035176-1-imv4bel@gmail.com>
 <20261029214219.1035176-3-imv4bel@gmail.com>
 <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
 <auqJOj7RVCWn7Ucl@v4bel>
 <7f8bd24d-7538-423d-b2a9-f5b0eae99d41@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f8bd24d-7538-423d-b2a9-f5b0eae99d41@redhat.com>

On Wed, Nov 04, 2026 at 08:59:50AM +0100, Paolo Abeni wrote:
> On 11/4/26 02:24, Hyunwoo Kim wrote:
> > On Tue, Nov 03, 2026 at 03:49:40PM +0100, Eric Dumazet wrote:
> > > Le jeu. 29 oct. 2026 à 22:42, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> > > > 
> > > > Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > > > of refcount_t"), default builds implemented refcount_inc_not_zero() using
> > > > atomic_add_unless(), which provided full memory ordering on success. The
> > > > commit removed that ordering on weakly ordered architectures, allowing
> > > > accesses after a successful reference acquisition to be reordered before
> > > > it.
> > > > 
> > > > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> > > > lookups and in inet_twsk_purge(), where the socket is validated again
> > > > after taking a reference.
> > > > 
> > > > bpf_sk_assign() can receive a socket pointer obtained through BTF
> > > > without a reference. Use acquire ordering when it takes its own reference
> > > > for a refcounted socket.
> > > > 
> > > > Use refcount_set_release() when setting refcounts in the SYN cookie,
> > > > TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
> > > > TIME_WAIT smp_wmb(), which separately orders the refcount store before
> > > > ehash publication.
> > > > 
> > > > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> > > > Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > > ---
> > > 
> > > Lack of links to prior versions is rather annoying.
> > 
> > Is the cover letter alone insufficient?
> > 
> > Should the changelog be in each patch?
> 
> Ideally the cover letter should include a very quick/short overview of the
> changes, and a per patch changelog should include a more detailed list
> (no entry added when the patch is unmodified).

Understood. I'll do that from now on.


Best regards,
Hyunwoo Kim
