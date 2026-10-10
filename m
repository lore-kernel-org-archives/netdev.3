Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAA38E5C4
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604781; cv=none; b=Tw43WPAnyKM7MYX59miwTsmlxnYQwUJRCLMiXHRN94K4JUGStIY1z2c4QrbRJgiYKJ+60LpYM0ZmFV+MXVZxg03NkylMqGe0ZxpsOMugGjfe4iCgmcRvExz3wNOAgXgvZNecrNgk67xbaWqdBvThmga7A2W4ZdlNtZMspenE9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604781; c=relaxed/simple;
	bh=9uUi7VJXnnwjCj1byg6atdUf19EY7e7jPvxXvAjDn64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcDyuLw7iQ1PXbttObscVLj20QNYigxyCySPT3p7Cvl/5C5xhQ1bLkV1ippxykTgAvJkmNuYMIuEXB07JHKNpLZ/CWWYrOoeisHMNVlUt1t2gbtYrBMznios6wGVIOsUvV4yiOxlCvFe+nifjW9QUtlbk/3HlKCyPcqeOntoSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfu5+dyU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfu5+dyU"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso135902e87.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604777; x=1792209577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uUi7VJXnnwjCj1byg6atdUf19EY7e7jPvxXvAjDn64=;
        b=sfu5+dyUDHXDvz3azDLkeRnGDawVUJLLtp6CtzXI0ROEBzfQy50IeTJ0XSHo1r6Ygr
         wJU8fypLXpYKd3Dd2y9/JHxzmM7NjULIvA7QzWVLxmjdNIz7vyxjvupPYSM7qAZFVOeF
         yvklmdtsHLR9AGwMC/SfIU5rITyFwFuAeEaBbFLGn7113sbRAvttFIBJ20GCQrDKhueA
         yjCNkjvpNKJ1XNyn2N243Ey8M5Ygu0Wqe5G05g5twflK30ekY70X6C+8w791EgGSSxy1
         Loh3xxi3v+ouwWtc0i9D6JjIQN0N6mDjzgDDL6A4tlk1H8b+OOqTxVhfOAp0TnW+4S/A
         ZLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604777; x=1792209577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9uUi7VJXnnwjCj1byg6atdUf19EY7e7jPvxXvAjDn64=;
        b=s5jYosQQhi6AsMrxPGJKNzw4AMScLE6PYBDICpZkRyx7cN3Zvm28xcjpt54L+1TaK3
         PmqIYrF9D+eswDbbytIjKIgG8N8NJsyvChW8GoyhPaSnBgfScCc+ge7Y02d7v4STfMid
         rvMO15DOGHdF3YsKHJuZb1Ajq4mU+1TSfvPW9Vgi38Pzk8tI89kmesHKDJXhQSnZeOi2
         +yagc8ZWDdMEBWhJ1aiFhzAgBoY1o0d7L98/04X0gfgjc1bp8UaJKmucYwWn/wgEfNZ8
         dBNBSiQiflm8hlufq00J1DVZ4hyPPgey3R8oYHpDKqyI4mtmLP3FYh37AJJTlxQp2wFf
         UqBA==
X-Forwarded-Encrypted: i=1; AKwUvBxttTCtz5gRhWOBje//nkocxCDoHHCZ7kiQZnpZd3DZLMQwpvuM9gpeigBX8svmjJZ01l/T228=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1+NusZV3SHIT93Dkge65gI+AbsoE77htjSxnpvcsqDiu/1ElP
	VXyhEJ5hfmTQhel4T9Mw3zPUWqG5+3gSw1UM/s9zgeM4NeCmbhWW6QR2Z1oR++DbSnQ=
X-Gm-Gg: AYBFou317OcJRiA57hlIPaF6zowNww74YceSUFsFlndpye17nG9QY+HI17O0AbhAAZu
	NvH8IOAeiOHS1vF0yp1ZTZmKatRbymwinAbAhJljQQXkbxslv8c/JUw779ZMbKWhpPoLkE2PU2m
	teZPLqkJq8AcR/FRJ5+tcqJro9NHXisoseDU546QBXaSUKV8v3WJ1lFj2kfnkkVo326qe+ztYTd
	naoe87e54JhC16geFsqjg0XYNVVXvAK4Nq0KelD7vYYJKA9LgRuzpWs2nVvgSwdT2mnuXeGo+2S
	6IMDFLDizx0BxQdKE4SzIi55Q3VI/uH8Tiqbvgq53XrKHUziJpesSjaI7psPf62thIxZQR+A1it
	EgCLnSQ18/Bbg8ZT9uwZJiShlUNH4jqHXI6Kg5bh3beYq5ExhIK4eUYLNpFvW2ILlR91NdVZH/1
	X60XcrWIe4Q8n1Qr/ILBIUC+SjmxsUEwlLsXUeejwR2szHw/H+hq86RYxo/zYUj799LDAE9Mw0N
	AKlwbOjXwyoHdvJ6MDqRrncRz/7EbQQ3GHPI9tagWA=
X-Received: by 2002:a05:6512:2315:b0:5b8:f955:29e9 with SMTP id 2adb3069b0e04-5bce01aacaemr904126e87.7.1791604776835;
        Fri, 09 Oct 2026 20:59:36 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde91281sm1164909e87.19.2026.10.09.20.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:59:35 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Rachel Menge <rachelmenge@linux.microsoft.com>
Cc: stable@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: Request backport of bf5a54bc0e3d to 6.18.y
Date: Sat, 10 Oct 2026 06:59:27 +0300
Message-ID: <20261010035930.579535-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <899bd843-fd19-418e-8913-91bfb6e760a2@linux.microsoft.com>
References: <899bd843-fd19-418e-8913-91bfb6e760a2@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 09, 2026 at 03:36:42PM -0700, Rachel Menge wrote:
> Please consider applying the following upstream commit to 6.18.y:
>
> bf5a54bc0e3d8962474fcd611f1266eba036232f
> doc/netlink: netlink-raw: Add max check

I see the same on v6.18.55: rt-link-user.h fails since 6.18.53 and
rt-neigh-user.h since 6.18.54, and the in-tree cli.py fails the same
way for both families. With bf5a54bc0e3d on top, make -C tools/net/ynl
passes, and the generated rt-link and rt-neigh code is byte-identical
to a build of the same tree with the two checks hunks dropped.

> I also checked 6.1.y, 6.6.y, 6.12.y, and 6.19.y. Those branches do not
> contain the rt-link.yaml and rt-neigh.yaml checks.max additions that create
> this mismatch, so this request is limited to 6.18.y.

6.12.y is affected too. Since 6.12.111 it carries 45ca9f59b6c7 ("net:
reject oversized tx_queue_len at netlink parse time"), which adds
checks.max to rt_link.yaml (the file name has an underscore there).
6.12.y does not generate C code for netlink-raw specs, so the build is
not affected by this one, but cli.py --spec rt_link.yaml fails with
the same ValidationError.

bf5a54bc0e3d applies to 6.12.y as well. The 6.12.y YNL build has been
broken since 6.12.93 by handshake.yaml, so I sent a 6.12.y series that
fixes that and includes bf5a54bc0e3d:

https://lore.kernel.org/netdev/20261010035116.578385-1-littlesmilingcloud@gmail.com/

One more thing for 6.18.y, not a regression: conntrack.yaml and
nftables.yaml fail the schema check since v6.18 itself ('labels mask'
and 'set id' do not match the attribute name pattern), so cli.py fails
for these two families. Upstream fixed that in 1adc241f3940 ("ynl: fix
schema check errors"), which renames the two attributes to labels-mask
and set-id. It applies cleanly to 6.18.55, and with it and bf5a54bc0e3d
all specs in 6.18.55 pass the schema check. The C build is not affected,
these two families are not generated there.

Tested-by: Anton Danilov <littlesmilingcloud@gmail.com> # v6.18.55

---

Anton Danilov
