Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854523;
	b=kjl24dGGeg+ZsBZRe9kxeArY+6lfAlysHPmsQxseZx61+6QYf3B1L68gO2R9l05Q2D5J
	 uGB6ye/avYsDXfNqUZ1M16uI+dYMq3OIZdwgw4JARvif/oC5PpdRDLit9xib08Dml0385
	 g3KhDbo2G/QdVSkPtn7pdOiECPLehilwnb/LFL1FRZhkaWThJY5nUYsVE2JRLOfO4AP4o
	 rKzPNeg0JpuEk79VvzNOmJ9mMHCOXtk78wNnCClCt7bkD9/KF51BCOY2pGh97igE2ZOxJ
	 NG/DzHcwQZzilfNjPioaSMe37MhIKyjK2f2rAvWu88p1ME7sLMpFDC1Eph7ijiUDG5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0K/OpJSJDyeiHFgRi2dD4j6fShhHweBIMHEcvs+4Jvc=;
	b=FqAiWuu/OWYjFGAjVupHmTj0HnzLKuWIioUfxSyRZQVMuOO6ofu2MeGL66RK4yEz039f
	 1PdbyTvGqwReyKyOKopba+2/+sBIB2Pxn5krJfofOpycHSKZcrg4G/po6FIEwippY0RtP
	 gZUUN6knqUqC8EDz4oOVBSAdFLzbLlKviH7EHXbbgxFuiCHPv6xI4c1RDYdAAqxZ/7Tj9
	 HPBrMGy1DNgjXqbogE45w/rn5VG03U5geEGc0xiMqPVnpwBs64hvdlbBIyOAV1lYkvWik
	 vJdno5xDEnDCQBk6zQLcLYjadkEl9q3Ef9Gx1xxqfKBR8KP2elNuD1AV8HPXG0cj1eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTKYyYeV;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B236606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 04:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B236606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTKYyYeV
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae1a9e187aso221248a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 20:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793854522; x=1794459322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0K/OpJSJDyeiHFgRi2dD4j6fShhHweBIMHEcvs+4Jvc=;
        b=mTKYyYeVr7uxttrPBh/zbgdicB4GtUsAEPY7xWdW42ONQLpFWniKAVmHzgolRVnz1R
         7cGjdcpTCPUuQy/A64lwRFiyY3CHLGj3nlqbK6AEQwT2zG7biKPOWYGbyqYZoXfGRvF9
         VMNjEFP/372eFVw5FbTuSsi8X8vRwpvlmPjZMD5VyyudE8jzRBB7z6J5DpdMGoY7Hq5p
         KRhkUg8+WaJVVEcdue/XWCVzhYJgAPz+7SROTuyUkDUJZGvY0euOB/3t+nKtd4g2liXU
         30ygp2YrQxS3ncCjh2vsNdYieq6M3aMH+1rBdw0W/ieO4AuFjVJakOI9Kr5nAz8+hS5n
         ycYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854522; x=1794459322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0K/OpJSJDyeiHFgRi2dD4j6fShhHweBIMHEcvs+4Jvc=;
        b=eh3K4Del1AmZMvypkeHaVZ7vysQejWOpIYVLxaxJI1CbqxF1og/MzXATn0DFC5VUxA
         Z4sTj+5ntELnqCn8pMcYNXZCLbZIYm5fomSsWTewfiMCYi0hmZLZFYYb1eyhxrh/jiXF
         AZ7lCetG/11QLcJu/qVzeek1XdNBotRrWo63iQq+PeoMSjl80KK4lt/wtNucPXwYMKfz
         pKdVtk7/YG0dFdmOT/jAFK54KPp5+3+bwr0CRt3jFiNWLyt07wn7M8DZWijOqQOItiiQ
         7RskBqs0NHaH+bpB+Nu8SRsXmqf4N6PvJaRBg+DSKFqbQtMJAMQG4/uM9g8awvOIbsZj
         AtPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2KcoYcenPyDpRP1ymrV4pn//m/H9+oHfY5C2+MmVswFNtHq1YWbXLcXKnJjd2Ul/nrrWAueI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9wem0MSDqggWRPcPodoKZi5sIHY5VTgdAKkXTCk6ek60bGsm5
	jU4wpYFTcVb/hl1S924M0PyEAQFEcOvA9vZ6COgoOldGBFfP9WdfWlKb0KOR7DVW
X-Gm-Gg: AYBFou192ghlK4dEqRHgWPa+AnNISb+bOjhRwNyDAD5UVr3YVq4kkfpyZwNvYDgMhd4
	5S+OwT/02t9tJXALDYscB/FouzWAfP+JNW9ZumXWA5/Z++JKXdhrE7MO5L3BvVxtbcBsf/K18Kz
	N4BIblswYh54irhy8DuWkz8KT3K0sHDbo9PzsDrTZ2kI9pQzs7NtaRGXW9o/XvxxdbJ8k/Yc01W
	Aum9P9wTUTK+NDLSofDOkG2lkQNVJYKiyvsTbn7TThK5IlsNiy3xpD9jvIT8yH01krnSOk6Ajp+
	LwqcAf3qaqiZqnPSewvHvv23VV21qEF804I+iOsCsSy6Caqb2CduQtbawp0AasQYIL4Zgz4wVqk
	iCOjO8hdPDHG6rtDnO1GKNjkS7XDBy83YMWttvBBwqv4v78rheZnrXhaqPuqkQuOUapcBKtQ6OL
	kFvHDd2SNsmOTmcKbE3QQjuPeZZR6VANcPdaavPlNoRrEnJ4zOZajU9dYefxZOPCIUwLyBCGWxq
	XeWmwzPOsYe3pfo265+7Wgt6Y9KBn3JFK6YPXvzJxN6aDTLbKH6N52xaV19EaK5q+4rQQScS3sa
	a2lvW8SPlsDJ5r9AQIAm5bR7yOG5Blw3F9RRZOKKh+LDxO6g6BR6cDsPVXiV
X-Received: by 2002:a17:90b:4487:b0:3ac:9c37:9422 with SMTP id 98e67ed59e1d1-3ae89626108mr25602011a91.2.1793854521680;
        Wed, 04 Nov 2026 20:55:21 -0800 (PST)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm3726000a91.0.2026.11.04.20.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:55:20 -0800 (PST)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: fuchen.dust@gmail.com
Cc: coreteam@netfilter.org,
	fw@strlen.de,
	kadlec@netfilter.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	phil@nwl.cc,
	stable@vger.kernel.org
Subject: Re: [PATCH nf v3] netfilter: ipset: fix double free on kernel-side delete during resize
Date: Thu,  5 Nov 2026 12:52:10 +0800
Message-Id: <20261105045210.1179991-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026102957.5530-1-fuchen.dust@gmail.com>
References: <20261025090609.v2reply.4093.fuchen.dust@gmail.com> <20261026102957.5530-1-fuchen.dust@gmail.com>
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

Hi,

I discovered the same double-free during ipset hash resize
and confirmed its exploitability by successfully exploiting it
in my test environment.

While reviewing this fix, I noticed two remaining issues with the
deferred operations in net/netfilter/ipset/ip_set_hash_gen.h:

1. Failure-path replay can resurrect a deleted element.

In mtype_resize(), cleanup clears orig->resizing before reaching the new
drain path. Packet-path operations can then modify the original table
directly, while earlier operations are still waiting in the backlog.

For example, starting with A absent:

  - During resize, a packet-path ADD inserts A into the original table
    and also queues an ADD in orig->ad.
  - A bucket allocation in the resize copy loop fails. cleanup clears
    orig->resizing and waits for an RCU grace period.
  - Before drain replays the backlog, a later packet-path DEL removes A
    from the original table and returns success without queuing a DEL.
  - drain replays the earlier ADD, inserting A again.

The final state therefore contradicts the later successful DEL. Before
this change, the failure path discarded the queued ADD, so this sequence
left A absent.

The set->lock around list_splice_init() protects the list, but does not
serialize replay with packet-path updates under the region locks. The
RCU grace period does not prevent new updates either. Could failure-path
replay preserve ordering with those updates as well as within the backlog?

2. The new deferred-ADD branch can return success without queuing the ADD.

In mtype_add(), the new branch for an existing element sets ret = 0 and
jumps to resize. If allocation of struct mtype_resize_ad fails there,
the existing "Don't bother" path goes to out with ret still zero.

For example, starting with A present:

  - During resize, a packet-path DEL queues a deletion of A, leaving A
    in the original table.
  - A subsequent packet-path ADD of A, without IPSET_FLAG_EXIST, takes
    the new branch.
  - Backlog allocation fails, but the ADD returns success.
  - Replaying the queued DEL leaves A absent because no ADD was queued.

This branch relies entirely on the backlog to preserve the ADD after
the pending DEL. Allocation failure should at least return -ENOMEM for
this deferred-only case, consistent with the deferred-DEL path.

Validation of the two review findings above used a userspace harness
containing the extracted add/delete functions and failure-path replay
code, with lock/RCU stubs. Both sequences produced the incorrect final
state with v3; the corresponding unpatched baseline cases did not.
The baseline was mainline commit 05441d697f7f ("Merge tag 'cocci-7.4-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux"). These
are deterministic control-flow checks, not reproductions on a running
kernel.

This review and the harness were prepared with AI assistance.

Thanks.
