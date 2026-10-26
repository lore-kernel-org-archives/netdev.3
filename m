Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012770;
	b=3CsO9tezRAD8aOPY2JBnr4yN/6dG7ipc6vBUZN21q3yXwxQmKlfaso8HgAExwzKtb4ri
	 ieRPuCLOxMTfCGvphO4kr9EtNtDfmmt6KpcQIlZQfSpaKoNjzQcIxtokjqkLidYwGp3Xp
	 /mt3tDv7h0BTctW171KEE7HNKnqQOTMywnfRjqjxHO603wT9wvac8nQMc5dPXb4XMcwUe
	 lhujLBBgVmlRN73DZRcF2QtkugWNSEZNefgBe7ico6DcsjCthkb4K5GKLevGYBB5h912Y
	 TakmLRa8ZeHrBBQKmUPfgCzCtrK6NiZd0YKk/ILXUHAxtNjjgYJqhMFxPoZudGHimjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=tTUSlvJBt7PDLOQ/Qfve+QTEq2GZ/zMWuOJTMyxeOhE=;
	b=u9vTFwUrtxSxKK2Fq/Zug0e/Z0W6A0neo7r0HbIzv/O6R8T65zUyyDghculwLSVK2X2t
	 Sao+aC4W6x1Jq3MaEVPMMcxFUcVyACJ+WO1e49ue04Q9QZX7IZHqxr86nWBxv58uFNx13
	 G58qBkSdIqC46X+6UQKlvDMqvA1RjLKIRZVMe8nf68FAd7/HR2BPB+5yXUmSk6n/c+Tfv
	 J8ZStc51I1L24oPzwDcGtfda4bQvb67Rqh0XYsDY3pis1uW/NiAqaFlC1Wu6q5sGi4+j1
	 RX9bthcLu9BHO6FacJPhBomwpvW25vI2WEYv3Qh7tP9Tei/amXHNfxBW+CQJCSTPZTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="h0HS3DX/";
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E7D606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h0HS3DX/
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f560af6aeso298331885a.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012769; x=1793617569; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tTUSlvJBt7PDLOQ/Qfve+QTEq2GZ/zMWuOJTMyxeOhE=;
        b=h0HS3DX/AajEdG8H6zqVr5GOPIWtpAgYkOty4YtE1JUciY+UMFTUJyAw9+cv8fZl0R
         9DdUcy7w9DLvg/C3OSv266oOwaX5VzADbsTw7QMaLPCdFPcKa1Gg9YiRT5LLJQSKMFZP
         KguCMUVMrFs66LBezyTBn6l1yac7pEO263j4ZD6yvV36lsYlYFd4rlxzBnMNu+aN3YMN
         mmL7HITYGnEVmauzhPaCYlj4ud5mg1qwTtiOj9llVNQy9dAX2IRLPgxxP6UqTLrKPTFM
         X/O5g975nCh5irO6R5iusXMahvBxLZyApeJ5D7NtlZkR1TKDBsKIFSUQokfHQadp/rGW
         30eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012769; x=1793617569;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTUSlvJBt7PDLOQ/Qfve+QTEq2GZ/zMWuOJTMyxeOhE=;
        b=sXClQVn2j/UBeNGB8v/kspzFHyP0Njfr8Tfhv74mLJhZdv2Fj+Ujlfuv3ZlW+Dnb6E
         +PpGk1XHqm13ICtYpAIWYLM/lh3SVtiJgsxJ96NEU1LrCPArpYonAKst7KcMnkN0jrD0
         uIErGRPXoJvNGRjh6u0Wdw94iStnamnxBFSMGai8b+W6rkofezSJBrwHIs2Tatdw1nqg
         2Q6CM502Efn1CBRv5qyCv9NSgkROOKWriEfqf0j9np+Q9el+hx1hDxHGfelV1X9hyjFv
         Yu553qXBuHdXwlKqLhgfJpsL0Z7J8AfnV9SDuCaULFprG+5TW3DRydShxqq1c2iOLCns
         wuyA==
X-Forwarded-Encrypted: i=1; AKwUvBxcZpaEpH8MxJEXEyJ0arS3LPN+K9QhcQWtf7KZUmF6PK4tzKrBNrVWGFf2z7245MFsP9oUlOU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLryHd1ivCE1N79Dn0Ywaiw/tKvepSNwH5PIb+hh1y0kWE5WOET
	DMcoyH5fSviMv1ZJFd1d3moeQg5l4SIiKleKxvEEmgX4zeQ9KmmSPQ6h
X-Gm-Gg: AYBFou0jdvNhGHo9iPdYKhW1Tyi4OivlxrlE/N4eAyap3o/4GwTPJC/q9+ZoBwQ8ahp
	ti8uk6+WkF4N4yVvLCLDfEAzxZHpUSxpabxGN1QgTs9kKXg9SR9TGf5TREj0N3eyyxBTQn4bDex
	5fSSkK8MJ+It6sEa3rTtp7BLVVJjwlZ3HgWeFcpOgd2l3XC2/rDvfVz82mSVRbgytQdnB8J6txM
	nzUSCw6lB33J00dfHGIl+Pu+PpEIbzoH4mNQAVJKuERR9TE9y95S7BX3H8uP6L4PmZiYSQpAcyw
	NoFV5rgSwzwCN7umVReiooGZSjBQBq0Qgqs+Vp3+WosL5FARNOx07vXZMSGMrDOJGWij0+M/MAb
	KkL8iTONRHMgyOowWbJrRlUZGRJaXE/KAiqzxxAFz1egJ30IVrrxCfwQY3I2RfGhuxy2/ZMdDO+
	Nm/DtgwJni1sOesNBvaACYiJ5xdvF0MMvtB71s4gWhwq9SJe/nLURxbnGFVdXueIApNSW4hc/jz
	csZl+fGNyClEccxLtimB7p+vSPGT4jqwnOo/hAfkbVQiD2WRyJ4WwzMtZnU
X-Received: by 2002:a05:620a:280d:b0:93e:c12c:f147 with SMTP id af79cd13be357-940ef955f06mr896905585a.81.1793012769242;
        Mon, 26 Oct 2026 04:06:09 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067f330sm660111485a.24.2026.10.26.04.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:06:08 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 07:06:07 -0400
Message-Id: <DMEPZAAH894H.2LX47UFLJTCQW@gmail.com>
Cc: "Daniel Zahka" <daniel.zahka@gmail.com>, "Alexander Duyck"
 <alexanderduyck@fb.com>, <kernel-team@meta.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Paolo
 Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Eric Dumazet" <edumazet@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Jakub Kicinski"
 <kuba@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
 <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
 <20261019215405.OCzrrKYw@linutronix.de>
 <20261019190543.419e70bc@kernel.org>
 <20261020212155.47v0ot4g@linutronix.de>
 <20261020145038.4f7eb295@kernel.org>
 <20261026101117.YTmp0eu2@linutronix.de>
In-Reply-To: <20261026101117.YTmp0eu2@linutronix.de>

On Mon Oct 26, 2026 at 6:11 AM EDT, Sebastian Andrzej Siewior wrote:
> On 2026-10-20 14:50:38 [-0700], Jakub Kicinski wrote:
>> On Tue, 20 Oct 2026 23:21:55 +0200 Sebastian Andrzej Siewior wrote:
>> > > > Is there any other driver doing this?
>> > > > There is ::get_sset_count() and so on for the per-queue stats. =20
>> > >=20
>> > > You may be mixing up queue stats (netlink) with the old ethtool -S
>> > > kitchen sink / garbage dump. =20
>> >=20
>> > The statistics is folded on device-down into a global counter. So on
>> > device-up the statistics is still available. At least that is my
>> > understanding. This means the per-queue stats are lost and global stat=
s
>> > don't match the per queue stats anymore.
>>=20
>> Yes, that's intentional and recommended by the docs for queue stats.
>
> I guess this is Documentation/networking/statistics.rst that I need to
> study.
>
>> > So if this never happens, it might not be needed to preserve this. Tha=
t
>> > force-RCU might not be needed. This does happen on down and I would
>> > assume that the device is no longer processing packets.
>>=20
>> The (old) ndo for stats reading runs under RCU, only.
>> AI will immediately point that out if we remove the sync.
>>=20
>> May I ask why you care? Is there another driver you're trying=20
>> to implement stats in? I'm not sure where you're coming from
>> and therefore what to explain to you.
>
> I tried to be useful and do so some reviews and this stats part is what
> I did not expect to be "expected". I would expect per-queue stats which
> are folded into device stats on query time. Anyway. Let me study what is
> recommended before making noise here again.
> One last thing: If you replace RCU with SRCU then the logic should
> remain the same. On the plus side you would have some domain separation
> and the "synchronize" part will not force/ wait for the global grace
> period but be limited to the local one.
>
> Sebastian

I do appreciate the review. Thanks for the SRCU suggestion. I hadn't
considered that. Optimizing the writer side performance will become more
important when we implement ethtool ringparam/channel reconfiguration.
Another idea we had was to heap allocate the base stats and use
call_rcu() to free instead. I decided against that for now, because I
thought it was more complicated, and the writer side is limted to just
ndo_open/ndo_stop for now.=20
