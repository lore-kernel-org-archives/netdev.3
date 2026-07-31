Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB527A476
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491386; cv=none; b=oMLH3fGQ0csucX6FI5BC/K723ZiYLGuobbvpmJw5fsz8Q3LFDvM0DSBQcDToR1mtjMW+sRwXduRkYqO18zAxyPndV2i6bSCwboHKEh7T5p/uuyLykXtxoxD1wYl79kHJP2M0hpy4T9a/bKJrfKcTsoIQRAhNnhhO6fZofDXTUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491386; c=relaxed/simple;
	bh=cxtM0TrUZk/WQiTNZ8tQhCNiR6fxbr3xY69JWkzYOLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+DWYxCSRXqUWL6MMkEneJV7GiR20XZaAAyEsZ51YCtuGox6I78H3sPVDSOKjk72/nicvRSfjwPz6MPszZ3KK7CyQRLYvyjDP4acLlHqOY+NMbCYGVd37blFfMWeGRVCR/k0tEdu/RCMsSLyq6ISMzUs8lQQCtUkUYl43JzEOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=0lZIq0nI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="0lZIq0nI"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso892705b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785491380; x=1786096180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CuzlOpCASXq9qmuH7ELnKsdr/m0wIpH+QKEgpKF55Fo=;
        b=0lZIq0nIDzWjBLteJnVGGuABp9Jc2cpgXQb/H4Ui4Sw0e6O9kMvHaWCDO6bpzErdY5
         XWOunFwLbmDoPeVEuexVxPWJ7l4H90wGUkZCV1ciwhTVtxxcVRBp17O9Jry21YYB86nV
         GXDSjrG+k2LBVqV04dsdQpyeg/R5RaqDH2ClM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785491380; x=1786096180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CuzlOpCASXq9qmuH7ELnKsdr/m0wIpH+QKEgpKF55Fo=;
        b=kwmfCjXbRUtFXlaKt9BdNEBlzat4faB1Jbjv1EY6yKljS8zAMdY15rmSYghw8OJAV/
         XXHb/9gqONQY4P2ERdrEj04rgIH5jkzPa0ENfq9yMzxmoUD2fz6blbsUO9enGX6oMMyZ
         W+P1gqtAQFDRz3apQ91NQZ0RTuuCCy/1f3ECgKvBwBKKLbocSZ40yQPK9B2ehhzUMHFZ
         Dr976ptHfpAFIbMJ2PEA5TBEQU0tHpTw1sjpCsVX/lpBgfZTBSm/Rh0G8wn2SSleo27K
         KUIFyrOIFpIaZJgG7lsfHk39TvLaDjk/AMd9YPoiLjtG7bKsYaDs7UrLIlmWPsjWQrcD
         IfFQ==
X-Gm-Message-State: AOJu0YwC3/fMcnIuxJmdMwcCXd5wGZMKLno0aI6SZUjWjEW8kFutIMvb
	+BVGwGA+3HGfni6MmxnAYxV5V71zQGtWxp/U/PgBNgGMoiLS6mA/AWJx5enHbo2pfOM=
X-Gm-Gg: AR+sD11joJ95qggmJzF+ohu9KFLIOoGEJEa+oSZeSjkOq3k2Tx4hfZ6+mABsqnzXksx
	UnfR33ZGpOZpRprYWihuL8P4+B5kQIdEtnSxj1wof05n5ikoDNW4RXSoJpcXZ5buHfbFwAx5Hqa
	VZDPZJidjYPzeSorIdHszbapmThetlxsZiJwHRKV6WfJYKETGbTDz/cpl6NvzbFT/zJKRMFmN8d
	kwBS3nPzT0JeBpSbpvDcJHu13+9ghvf8mpYrmA8t/llM/m0FtD3ABeG5KLzuEAau2hbj0zXy5vX
	5rWFxJ/dKGmuqhcsyESEkqYaXd1OzZ/ci14wb65LMkJyRGa1OHum4C79J6E3KobD2xw/TdiXzwe
	vdFvm+MTnV4F41FrVZuPUbBPsmSQcPJYQJ25CwHIcTDiKs5VE758gxGIjmtMy1O9JBCXrX272zO
	0dHVjZHC8xfuyQ8rxOs1oD9pos9BVdZRd68IzsEkfuLfeLmiAtMJAbW40c5ggMveY7/32MTDcYX
	9AU881ju50=
X-Received: by 2002:a05:6a00:9289:b0:848:7a8a:48c4 with SMTP id d2e1a72fcca58-84ed7152106mr1229290b3a.40.1785491380262;
        Fri, 31 Jul 2026 02:49:40 -0700 (PDT)
Received: from DESKTOP-3RV5U90.localdomain ([211.234.196.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe566a6sm243292b3a.15.2026.07.31.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:49:39 -0700 (PDT)
From: Kenneth Lee <kennethbwlee@snu.ac.kr>
To: atenart@kernel.org
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	rhkrqnwk98@gmail.com
Subject: Re: [PATCH net] net: ip_gre: use checksum-aware trim for ERSPAN
Date: Fri, 31 Jul 2026 18:49:12 +0900
Message-ID: <20260731094913.16473-1-kennethbwlee@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <amxPmrfUFbSUNmgE@kwain>
References: <amxPmrfUFbSUNmgE@kwain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antoine,=0D
=0D
> Can you include a description of the MTU and kind of packet that=0D
> triggers this?=0D
=0D
The triggering configuration uses the default erspan0 device, which has=0D
an MTU of 1450 bytes. Since it is an Ethernet device, the trim limit is=0D
dev->mtu + dev->hard_header_len, or 1450 + 14 =3D 1464 bytes.=0D
=0D
The triggering traffic is a loopback of IPv4 TCP SYN. A tc BPF program=0D
grows the skb with skb_adjust_room() before redirecting it. ERSPAN=0D
subsequently trims the skb with pskb_trim(), which does not validate=0D
the CHECKSUM_PARTIAL checksum location. The checksum metadata therefore=0D
points beyond the new packet length and later triggers the following=0D
warning:=0D
=0D
  offset (4516) >=3D skb_headlen() (3730)=0D
  WARNING: net/core/dev.c:3600 at skb_checksum_help+0x47b/0x7c=0D
=0D
> Wasn't pskb_trim called before this commit?=0D
=0D
You are right that pskb_trim() was already used before f192970de860.=0D
That commit only changed the MTU and length accounting. A more=0D
appropriate commit would be 84e54fe0a5ea, 1a66a836da63.=0D
=0D
> Looks like the IPv6 counterpart has the same construction, can you=0D
> check?=0D
=0D
I checked the IPv6 counterpart and ip6erspan_tunnel_xmit() has the same=0D
pskb_trim() construction. I'll post a following patch if I can=0D
reproduce the same warning.=0D
=0D
Lastly thanks for pointing out the extra empty line and tag.=0D
=0D
Thanks,=0D
Kenneth Lee=0D
