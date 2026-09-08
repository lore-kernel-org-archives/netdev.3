Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B12326D44
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841908; cv=none; b=RLC7x6nuQ7YjIbhJSG+pxTsaINGQELczU1rGQeDrxRiRmuMebFi4zQB64vxujr7GQw6BrPEH/wV7hPv22ZRhehnQ6crW/Lk0P/LBdiTdc3zWMhS0FuRBugMEKvDvQsCR3QvTgTBVUMw3vxXlBDjurx3tad8xM74ywLigZqrRv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841908; c=relaxed/simple;
	bh=4OQ5Cx+3ftOvpfmNISRgF26Ot5dchKtGdv7nihjnEQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dib0N/rWyNk/1TygX1tC0s6tij75BFwOeKcnzKrJl/ISQK6KUm/vl7YjYViNlFM8eNMepQJG99IohxzStTaWhIyY/BUtB7G7gZCtJWuoUTjnO63N2B6mXq0j+I8rG0+Jh7XzxJi5efFti9VkaRybSz/p5ohqp44xm/3qGQZh+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iislh6dG; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iislh6dG"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8e6bdso422649d50.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788841906; x=1789446706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OQ5Cx+3ftOvpfmNISRgF26Ot5dchKtGdv7nihjnEQc=;
        b=Iislh6dG97Nou0RO/aL3SQ3nf3UiyH/LdznSCK9B7Ie6prqOK0bzQeR0oVMsMpnVJg
         49HJAbiAbEpvHc+7f27wF/Yhd+XURvUOxSRpV1S4D68tY3UJMVjWjiaFSx7IkPARzO+m
         8n8cvPbqY8H6ceAw65lDvYR8E2uq7a5HxEH3RebiJN1Vn6iyDXAQJHq+yrQQSMRt8eEM
         YqW2AAEYaC9kyv4sBK21MhBUfqrTvBj9vtkvtWOddPkLWnx1VcUHv7es9LDXAcTea5+D
         7AE7TpCdzd8R63hKpeWzpgBiijsSTfcnu5OIVVTcv0BcOeOp/UcpoF8TNmiDo3jtGbEu
         gIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788841906; x=1789446706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OQ5Cx+3ftOvpfmNISRgF26Ot5dchKtGdv7nihjnEQc=;
        b=XkjCn3H+95H4rgs9H+wDe+J27RJbIoNkKIpxVFfJnOcETQEmNV7ck/ChyvNGgJLAJV
         c3Js3o+0b9vUApsr4jL9fWGoerYd6u4S8iQXgUHvb7zIziGUK2R6vex8ieG5C47aLY1A
         h2c7p2CxIBqZXowC5vUtRoCUULSLRNrWodrR5ThAv+ynOZL/FltAYwV17XMxnd9qNi8W
         QaOhgIuZ3m+Wf/AwGLVGsYwnw9MEcmAqbBaOpvIHn30hoeM3A743YAC9C/431C7O2+hM
         xL8sHnaQZZ5byz8lmrVujXd9FauCoMhj53G3fL2MUNWYYW9hO9pL6i8vPK9YftrGZlBV
         di9w==
X-Forwarded-Encrypted: i=1; AKwUvByMTxsUayF/fW0hUn03Xz7smALeHmvOBYCjvaM1RVBIgiiZ4PboQJaxmlqWkan15NOXC6fbE4I=@vger.kernel.org
X-Gm-Message-State: AFuF++kHdotTkjyfOZu/vkT5/28j5kVzovZeJNHlCafc/b/5vFuy0FDi
	E4aox8n8c8nEf2ACWxr5stuzlnDfNoymm+onWynU69zSdKxEcSp+5ipz
X-Gm-Gg: AYBFou0lODYG8ik1hKY+kpCrDCSkPGattO9PWeYNQvU3uEDKwU0+vips1EDrQQZkq55
	iUwBGP+XvsH36q4KiOdVcD5qcBeQHJyzP5SHcGR/M6ur/cFo9+HCGQ8YajJxb9fHaf2be/5COG2
	pMos/4Z7sGEM6W+3gRvR3YMsGvcSGWi4JgY8Pz+3/MjzsUAPz7sCoDix7ByGYfg+gv/wFExro5k
	yNvyEuvgDrly3hByRE0M/gwmiok62sZ2T/aZUPsvLcXik8rVXFXTjdWPZNX24Wu0EX3xK9ipYzR
	tRpgZEFwWiB9cZW5f7BvsAhclFFpdq81QooVZ3aHCabXbTHuyfMYIPDFYof3VyNo947rG7sVMQ8
	2HGrkVIcg/FhQHav+N862fF6Rqr3H6NNCIsaXbta4YwGP51Yjewt+LS+JCgsHNdPCyCuB/UkO7q
	9GqACbPhOGq+5bTAGwjeEFolWCzVhpbG7ygarHAtEjZx2pMIQtFIhZEOd3b6A47NRl3t0w3i/2n
	w==
X-Received: by 2002:a05:690e:4194:b0:66f:c1bc:4041 with SMTP id 956f58d0204a3-670f4a40d41mr814285d50.34.1788841906063;
        Mon, 07 Sep 2026 21:31:46 -0700 (PDT)
Received: from ubuntu ([69.209.117.52])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb497cf0dsm9435742d50.21.2026.09.07.21.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:31:45 -0700 (PDT)
From: AnishMulay <anishm7030@gmail.com>
To: idosch@nvidia.com
Cc: pimyn@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
Subject: Re: [PATCH] ipv6: addrconf: drop "BUG: " prefix from pr_warn()
Date: Tue,  8 Sep 2026 00:31:43 -0400
Message-ID: <20260908043143.120335-1-anishm7030@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810103517.GA2626301@shredder>
References: <20260807131300.2677228-1-pimyn@google.com> <20260810095136.GA2582170@shredder> <CAJWNTGyLJubRHn2KbqQMeV_jqexSgaLbzTe+xJnGzUw=RUtntA@mail.gmail.com> <20260810103517.GA2626301@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ido,

I ran into this same warning independently (different syzbot report,
address 2001::fb rather than fc00::, extid 57f410c9a4f8d7a441d6) and
ended up tracing it down before finding this thread.

The mechanism in my case: keep_addr_on_down is set, addrconf_ifdown()
clears ifp->rt and deletes the route for the kept address but skips
its notifier. On the following up, fixup_permanent_addr() allocates a
new fib6_info and schedules addrconf_dad_work asynchronously instead
of inserting the route itself. If a second addrconf_ifdown() for the
same device runs before that work item gets to execute (I see this
happen within a single "ip link set lo up" call, which drives both a
NETDEV_UP and a NETDEV_CHANGE through addrconf_notify()), the fresh
route gets torn down again with no notifier to re-arm anything. The
work item then runs with ifp->rt NULL and nothing left to insert.

I have a patch that regenerates the route at that point instead of
only warning, verified against a C reproducer translated from the
syzbot repro (no warning, and the /128 route is present after the
down/up cycle, across repeated runs). Since you mentioned you were
looking into avoiding this state, I wanted to check before sending it,
in case you already have something further along or a different angle
on it. Happy to send what I have either way.

Anish
