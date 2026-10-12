Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56D42122B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834771; cv=none; b=nayVSy1foLBtYjmQ0x8Rxw5A6v/r5h/REPpSDYFMt+RiW/9wTxEihC2G7PodNTjpXdpO5b5xbik3A7TWPesdVQOSwh6zdq4kv7EgszKxaJNL+ieY14fAeShiXG9GarePshwqcWphBWPbRSqSwVXGOBWDReGlRUA2w/GBhcLkDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834771; c=relaxed/simple;
	bh=0WMDmDH0+AbdmF3MJWOC+dvGBm3w4SCat2EYJQbaKWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R6EYd5iQmpQr/iC8qOQ7LgbwhAisDlfDplr/iaoaRJxq/DJuyrtLs0eMC5H8ZuCThd72TsbGHW4yB17Dok7jH6zzDqoRWDG6kx84td/tO4XPpmt0YVba7/8mWnvGKL3pxR0ZXTbKrk+WhZEqTbMWjqahb7exfqqeR1BXxDbTz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOhWKY8C; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOhWKY8C"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35834f72d94so3856729eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791834769; x=1792439569; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XdV4cVvwdRuNN+NpgIgGPHIIwB65z00n9c7R2h7kBD8=;
        b=EOhWKY8C5MJ+pOugonmA42JXD7lueV45oP+bz0d6QSKRjR6OFdOopmv5qriyqD0y3L
         tar5SIR2vfYuBVGcfNXJ1dV8f+4lc9BudvmRCGv8qdHBMwHVE7ZQbq4BR16KSJIg6a+U
         x818CEuJVXPTtK+Hr1pELj8eADwz3iBrfq6qI/KdjuAJOp9KfRXBqhae5RsOyG4NJ2SQ
         lScL0zdd31v0cCZL3MG1f8AK5w42ray9AaSY/SlnEQjZkQiFtrcpg2/0Jol22ZhViKzI
         zhc/iAgjOOgSSzWdkUVS/IljMsP0DVaVms3uX61qE5R72JWPKsco2LX2OHIOZZIJQWFA
         LKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834769; x=1792439569;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XdV4cVvwdRuNN+NpgIgGPHIIwB65z00n9c7R2h7kBD8=;
        b=DEPLLH1u62bIp7D9B2niweOuy56m3M5Zg3Wlk2pKqdYQwvzY5Ruwz7kUuVh53UL3aM
         LfUCh0WgUNQczxQ/1foXvIBb64dK6cVSLjgBPE3ZtuN3SzxttRdnEFgC+Or+g9QvnX6/
         kB9i75pDn/O+chWW6SE+n+aMJRakedUnqFbBuexv/jYCS3tC4AilgjhnkEUkjIBw4b1S
         qLjPnPOSzXVm+s+NAb6GWztEoJg1Ns0D6hYq0Ah0Gf1EHiliEO8eLPDPjZctCIcfe7OG
         lvbDkFjcdPHSi9jVoWKQGzxMFo0mkhOkDGiAEyu8RuZAutWb+8PNcMzGyMbBPNp1hFOd
         mJ1g==
X-Forwarded-Encrypted: i=1; AKwUvBx/2pHBpCiGKkH7kd7S8S58VPGt+m3Ut1Vl7xu7RBc2Nun7ItHRfd7Kff63IfLtxmS2CB4Vhz0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDPxTveonZgLRQ6WPyu3BehDshRX14901L7oSUKy+FPPRYtkLm
	vINSZOUy+9uJu1H2QAp6znKJ/MKH+4SNm+fnfGz+0PyWe5QgGW6REUbV
X-Gm-Gg: AYBFou0/q+Hgb5figVEyu9k3uozcuGEGu3GZNW55KuFtEafYtz/QpdsAYYqf3Zt0IKn
	UjwpWtRALLs5v/55F/t7wLHUA/qKM6Z6WFH2jkpVM2ylTytFGahTvkmjPYS9ZPgRKNXeds7Owgi
	WWgWCYr+d/k3m5tOqWEGphxKj/7jCutI+F3EOXVQ5qRfBFsxkfOnUfNDHC3b2WF1b0gep4K2eMf
	u2MtFftmj9PkQY4mc2KpYgohHKrdmXlr9UCyRda+rmRgP3V5vBYug30t0abmQMFsPHmzKEDoYMw
	daLj5Rw5452DqzDluFPbHJXsT8IxZNC2ej8AVTQoB11di1zBwLd/Ac8+BU9gi+y5oxSQyKRhYD2
	ib0qCBvrThWYv0ZDIHK5guRetjYRfcm9+zF+0IOnHZckYWFGr0MGa/SNaKQx+0OdceKRdApQnVX
	9y38YP1sMnZfenU+8HoLfhVwp2xkF9fQ9JF4dvb1VorL+mzJXLQEen058AFA1EuvRqhDmV9fGxp
	kSxyNVkEa1Hxr+TesiAcpq/y3MPp+oIzFjbxMh2baRvQllvD5qIU4zeyJ55hTd6AdjDyq3jfqo=
X-Received: by 2002:a05:693c:415c:10b0:351:1133:8780 with SMTP id 5a478bee46e88-3537dfd18cfmr16191364eec.25.1791834768938;
        Mon, 12 Oct 2026 12:52:48 -0700 (PDT)
Received: from 16.15.168.192.in-addr.arpa ([2804:1b3:a2c3:c9ff:4955:83c2:2c3a:5e7a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358ee8a3387sm25389529eec.15.2026.10.12.12.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 12:52:48 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 Jon Maloy <jmaloy@redhat.com>
Subject: Re: [PATCH net] tipc: raise the minimum bearer MTU to fit tunnel and
 crypto overhead
Date: Mon, 12 Oct 2026 16:52:44 -0300
Message-ID: <179183476436.33769.3426656354326870760@gmail.com>
In-Reply-To: <AM7P189MB11375A32648F33B53BA95A4AC69F2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <179155039490.29136.3966310214361645960@gmail.com> <AM7P189MB11375A32648F33B53BA95A4AC69F2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Oct 12, 2026, Tung Quang Nguyen wrote:
> This approach is not good because  it uses hard-coded size of TIPC crypto
> header (32).
> The size should be calculated based on tipc_ehdr.
> Could you please test below general approach ?

Hi Tung,

Agreed, deriving it from EMSG_OVERHEAD is better.  I tested your
approach on 602042bf29f6 (arm64, QEMU, KASAN), applied on its own
without my patch:

- Builds cleanly with W=1 for net/tipc/, with CONFIG_TIPC_CRYPTO=y and
  with CONFIG_TIPC_CRYPTO=n.

- Same reproducer as before (node A with 40 cluster-scope publications
  and MTU 1500, node B enabling its bearer on a veth with the MTU
  below):

    config            peer MTU   bearer on B         link   KASAN
    TIPC_CRYPTO=y        100     refused (too low)    -       none
    TIPC_CRYPTO=y        171     refused (too low)    -       none
    TIPC_CRYPTO=y        172     enabled              up      none
    TIPC_CRYPTO=y       1500     enabled              up      none
    TIPC_CRYPTO=n        100     refused (too low)    -       none
    TIPC_CRYPTO=n        139     refused (too low)    -       none
    TIPC_CRYPTO=n        140     enabled              up      none
    TIPC_CRYPTO=n       1500     enabled              up      none

  So the floor is 172 with crypto and 140 without, the same values as
  my patch, and the KASAN report from the unpatched kernel is gone.

One limitation: the reproducer lowers the MTU of B's device, so it
exercises the bearer-enable check.  The max_pkt negotiation path in
tipc_link_proto_rcv() uses the same value through
tipc_bearer_min_mtu(), but I did not forge RESET/ACTIVATE messages to
hit it separately.

Would you like me to send a v2 based on your approach (with your
Co-developed-by/Signed-off-by), or do you prefer to post it yourself
with a Reported-by/Tested-by from me?

Thanks,
Joas
