Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2681493626
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788122; cv=none; b=gpJ3NU2F4IUZkEXnnV0tDO7mIckLhDTUz1VZjdtZQLIV8UMOXxTMKVPIx6Nk5r8aWM28GOeNzh/UNCAMkbcy01hRjDHnhf5MEPiT3Gw4TZtUkVxhLr5fnAooyvGdxo9oDMJ0FkMpAmHJ29/ZFup7ataosVqKLKdbqkUFHvIewPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788122; c=relaxed/simple;
	bh=LxVaiSZFYdCWw5o76jR+r64eg9BGglyX0nY8xxuVmIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK6skgandX1RQ+MFF1gcol5Baa06oryNgMccN9w5qWP3zWlwCUZI4ucQkt6NQHN711iTGBLqCpeeAUEUGKWN7xDE3d9DwpHneQ75vju5iJpMB+lPmEP3D6+DNC3OrRl3QCnvZvOGWhyzu+T7fHcaa1bViU0L76xoEHLITF/32Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtJnl2+u; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtJnl2+u"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c9a3acd40so28836341fa.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788788118; x=1789392918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxVaiSZFYdCWw5o76jR+r64eg9BGglyX0nY8xxuVmIA=;
        b=OtJnl2+uUwYrGV5vEaWnRan7LSiJIURCfjaSr45iywj+2sgPjJFq1ZkU12O0uHH2FY
         Wz841iricYDNt6feFhS5RT7n8Mcq1CeI80bUkGr7t3Qrx9q2kcS/CoqlK8abLL/rTAoD
         L3Ezrx/Ms14IVcyvRB4HMY2TEeztUoM11gPoLSdmiGnOOW/7q5UjAeCBfWa/Twd0Tj/G
         LwxnF5C9wnAvwhIH1smPFbczFyNiYlpu2fAp8lST0tFrYumP5O6ypn5/THaskhUCL6OS
         lZjwI1cziPuliHexngWrgfPV4cIRXLAEj+LddTffCb0E4I8+upCjoCBQsx0PSpxdHpjh
         /cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788118; x=1789392918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxVaiSZFYdCWw5o76jR+r64eg9BGglyX0nY8xxuVmIA=;
        b=mto+yN5fH6OiGO4t93nUY4kyPJyd/JpDM2J63BAx7jY7eUuht8gLwoPGq2TereGigM
         Tkz/iXS+TK7DbjoYDuU6LVbSp4akWYv5/FWdnUVe2HPbBm3nq/RWbMlDMimZ4MZ5Aawt
         QGfxKymNypTkZGdYNnqXjoBlzmwePXCqsQopqkKn8sfqKWeAT/4XdzoxobxICE22T+eP
         /yaBkOhTTF+1+l6CbrzJA8K3QI9F8kQ3Mqscdi4p+hcECnAYFliP6VyJTTEeWLG+s+/5
         Dzt9dJxb920oRvshxjmBDu71RFdRncYR8sPjtVUrbcK1svPDJ1HfKCqeTcjEVcQxAvDH
         9U9g==
X-Gm-Message-State: AFuF++l0QVBaKq+QskJ9rNVBj3r4Zu5t/zoY7tP7ayGcCQWVTO2sexUt
	OkvK3Tu2r1kos6J1tewxIi7NOJbgPT0EDyy62NuSTlFOW2jwYMWzrfd8
X-Gm-Gg: AYBFou0AFBMQJ3wdi+0t5W5/OQHsA0YB5vgubdBPgQAmLhESQ995j0pZwpmY1GYphfm
	hATI1Q7zapphvDLe4JRqXiZGCbRwM3Lpy1+YIbV8ktWuno4vZHkvlidrNdeJmFBDGEjfWtvUDT8
	mvEGenya2jSMcRojKVzKtorrlddWD0f3IG/LH4to7kMcMRjTYvowkWJGscgH5I4U++3lCCuQNf7
	up4HhZZkG95RRgHMMP1qm2yT7Cmba/LbZtpSpg2Kv1l1GSoVfbasqjPguFRED9Du/0bvoJdTI6j
	2/ux8pyiJq6GEzb56tNZdZGThkEuYJz/moUjZZRRKgUyV5knenLt1AqEdELaG5gmplrcBuL/4ol
	qif1Lzumf/WhxHgnBWr1fKBk286Pr7VzRBg+NKcazuU1KOjl1zV7VlSYl0OqS6+JPLP5RQStdxF
	DL6FgapldOQ+P/OtLGO/6T8m62rSq5ebPy9qAMlg8mpHbOhNk1fjZBIjspzhb3bqrAC1NRyNOh4
	OHI43YSINS06zkqi50Xh/dgSTrCn7nLaLf81N4QwnHWSOSx7319/Lmi0Q==
X-Received: by 2002:a2e:be1e:0:b0:3a1:edd7:340e with SMTP id 38308e7fff4ca-3a371995b91mr42775031fa.0.1788788118329;
        Mon, 07 Sep 2026 06:35:18 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a37058669fsm26853201fa.17.2026.09.07.06.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:35:17 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: bridge: bound the port VLAN lists in the IFLA_AF_SPEC nest
Date: Mon,  7 Sep 2026 16:35:04 +0300
Message-ID: <20260907133505.5291-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ba2dcdb6-923d-4fc1-9c92-7a77c0b61a09@blackwall.org>
References: <20260906224246.21719-1-iprintercanon@gmail.com> <ba2dcdb6-923d-4fc1-9c92-7a77c0b61a09@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 11:47:24AM +0300, Nikolay Aleksandrov wrote:
> I prefer a more explicit path - return error for both (RTM_GETLINK and notifications)
> you'll have to plumb down extack but then user-space will know there are too many objects or lost
> RTNL_LINK notifications and it should resync (e.g. use RTM_GETVLAN to dump the vlans if needed).

OK, v2 will do that: br_fill_ifinfo() fails with -E2BIG once the nest
would pass 65535, kept distinct from -EMSGSIZE so the WARN_ON in
br_info_notify() still means what it means today and the error goes to
rtnl_set_sk_err(). For the dump, rtnl_bridge_getlink() can turn -E2BIG
into the extack message itself, which keeps ndo_bridge_getlink() as it
is; or do you want extack plumbed through the ndo? The size clamp and
the doc text go away.

Artem
