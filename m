Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793410312;
	b=H1jbuS71JbvjC+HJziYsAdRyiwTKmlsh74q8yXILQ0crctrSWaq3UjDAFwNA4vtv5grT
	 8OsGhGcwVIX1I+KOCnoJF+yQqky8siJLTD7wJXp/3+JO6K1tfeWLVwtPiiCVG0zDkG5hG
	 YX5Nlzu3a8epOd8H7DgILziI9O2QlQbxGYNxaZPUf1hOrgQE+EPdHtbMb45m4t5fs5l65
	 h5YOlmVRJTvvfCnBSFxpfAroJ6UO9SxTy795lKx3MVNxIisW5S20BUG589XUQoFExDxRK
	 KMvY0EFZ8hiyOSSgfW7Fqoq8gQtjHr6ZVwNo93VdbfC4Mmm+iy5h57yrp4PaGlgjjfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793410312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nnMXVI7pxSqYqYmr+cJgAyqTawsiLp5YajS+zEQksOM=;
	b=LkmZWv5xTWbbNkZ0T71gEQmFp5rCLIZUQE9a2Sk7+71AztDuTllm9r7uLctlg8KmTxeE
	 o+lRZMojwQMJZE3Y4BqeCRlpT/4DUtcYivcM/YnKYv9T47SLESZo/gGB13jMW19YV/H03
	 Qf3q9htXazajBusbM/0ziaFRf3HMENfPQWjVlXbpZpteQNBnRRtTZILynj0eUfAY5qU7A
	 QPpDdZJO5fkMoaOBnGGmVQXAjMLxghcEDYOA22hX/jo5IGVEl5eJ8/JOv1xRec8gUteuM
	 28ve6k5oGK6Wuyl2PkTemzfIht18gjYqraFseI3n+3oZan2vgZgj/hWujs+IjWiyEqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VpTC+yCU;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504C606A320
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 01:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8504C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VpTC+yCU
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a24f47293so718110eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793410312; x=1794015112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nnMXVI7pxSqYqYmr+cJgAyqTawsiLp5YajS+zEQksOM=;
        b=VpTC+yCU71DBdqXgz1LKbQNMOo+CoTVfbjagSAdjMqu/UezP7IeaVnTLbj+D8DT64a
         UgpIB/AoGz+QTWDXKQGu5eBN53Ah4U3OyB8xG/N4UtjGnTTAIK0698FSBrMBFrxeGUWW
         dcxhyrkWPDAlD055uHgNpHcaWdSU631DRHO8KUI/NjLmtA5C6YY62CoVuu41PEjbUR0w
         9yMpK2Rs0cVaYZTrJ6hOV4KrowM3q6fE44FlnK+e4WVWcaLDUFryb6sQP5InEHohby/Z
         TgZmnqsMovDi8VQmWkxF9tt+UpGJDOKDk8/JAOA8TqAZAgNpbI5lnV5R97otEtz8uMJy
         TddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793410312; x=1794015112;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnMXVI7pxSqYqYmr+cJgAyqTawsiLp5YajS+zEQksOM=;
        b=x7igoz2WfWtPw37xvNe3BWcpA/0hyxFQg+q63JmKHGY3ELonvx+mE3dupNj/ao0ydT
         SjomvwCetJBQuXiTePzXarOjbAI5nTRo8TKdHtK4yT0Ie2iZxpU/P9Cxccz/aZdOyBCj
         j+SiXdkw7LiR6/15mhBuMG5yE7hByZVmTgRtvextm2j0sJhgc6GCZ6QVrhb/wtmks0XH
         r0IwSnfxvm3YuJOn2QDM6M1F3SQGYwKK67f1731KlPLt0TZmiSKCnl/LyTDkXguBTpV0
         s5n/ZH7izlZhlsyvDyRTsTHgpHckjRddjEMiSQ8TYnbfDFXuE2PsOnq+WXDmc8jElZ/9
         Zz8w==
X-Gm-Message-State: AFq9FYKoJbOm501OuZ0Wk1rcHrvP0qwbds2FXhOwakiRRa35ku5tE+kv
	hAGpD8oy16cIgdfbXNAltc59Vej55+JbNFx4o6IIwCnq2sSm2XEB3Ehj
X-Gm-Gg: AYBFou2F1tNC/4IeCagKzJ9KGYLoWWCRCoTl1QsZzbUYWGHQeMdsluZAPKrHkFKe/FS
	VL8P17fmqArc740scckNS8lFJ+BTxJKNt1LyNSC6/Z2FEPN4TsjjyEAVlFEhlQ0vYqwNb7kHBod
	CFT7n1DSt97al2Ui+tRXNZUHzUs4y0aGTZMtHT+FoErtCPz763d64kryOFmqET3PgFQw/ZYoqV/
	v9Bs+/JTdq+/oYJQZvzNYBc40pFLipBA2eJzuYDIMxAcd1peRwrzJtjw3ylT36wfHha/jkuWb0y
	GIdecnWUnXZorqchlgZXckeqNBpw0QcQ0ImI6jn90d8/nxQatxYXAHTsDfmUyRFRRaZSaxsdPmT
	9cYDejpBKXv8P+Cf9NeyL66k45TnC0U6KDGh5dt2lgyrCB8Ks8Rkf+LNES0mV3R3255jVHT+n5W
	ihmzIYZ551l3elzaRrMsDw2vMy3d1qv2D7cYECEZpFEj88GF/jURP9l4K1QXVLa68Q+/8gj3LP1
	jg+bSEvyi6LpqkuGNOJb9uJaxS5nA1PQowjrHoweZ1Dn8dhPURT5BJC2y2FUOzMxjHlQr2/PKXG
	Oash906k66cmSzBLChLC1zmt+yJveUwxfgAl/vvKUeq3HAk0YZxE
X-Received: by 2002:a05:7301:1927:b0:369:f419:e7bb with SMTP id 5a478bee46e88-36a4260caacmr5280670eec.39.1793410311487;
        Fri, 30 Oct 2026 18:31:51 -0700 (PDT)
Received: from 192.168.1.3 ([2409:8a1e:2331:2850:d40c:1fcf:6319:8524])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4294419dsm11009649eec.18.2026.10.30.18.31.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 18:31:51 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Sat, 31 Oct 2026 09:31:43 +0800
Message-Id: <20261031013143.42509-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-3-testwrzwrz@gmail.com> <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Any reason you're not reading the real value from
> /proc/sys/net/core/max_skb_frags ?

The test wants to exercise the maximum supported number of frames, but also
needs to run on every build. CONFIG_MAX_SKB_FRAGS ranges from 17 to 45, so
using the minimum (17, i.e. 18 frames) gives the largest bound that works
everywhere. af_xdp.rst documents the same limit:

  "For copy mode, the maximum supported number of frames in a packet is
   equal to CONFIG_MAX_SKB_FRAGS + 1."

xsk checks MAX_SKB_FRAGS directly (net/xdp/xsk.c), not
net.core.max_skb_frags. I also set net.core.max_skb_frags=4 and ran
xdp_metadata; it still passes, which confirms xsk does not consume that
sysctl. Reading it in this test would not tell us the xsk limit, and would
only reduce coverage if it is lowered.

CONFIG_MAX_SKB_FRAGS is compile-time and has no userspace interface, so 18
frames is the portable upper bound. That is why I used 17.

Thanks,
Rongzheng
