Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200444C513
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241642; cv=none; b=nqwCUn1v+qYPu4t/ULNxlmvhqjk/Ss8qC1mDNHrhSXCia4qCYtqlo/RKPPP/fGUDDRPnm6k/BzMt3HVRB/0YntF2/tJi2E/uGlZ0aP0GP9h9gx8LOzw+lQFoiLw5TMUkCcr4ArbI5/8rCOWAq5sTj19mCdE314wPeSLWSDqx5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241642; c=relaxed/simple;
	bh=ID5MUzGb83kk8Rb++yvu5cXcrO865oN/cACU7edZPeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD2S9DfB56MOhsMuOztwze2/bhsY3WbSvG9Pr/D6h2R9FOidZxSz+JJWvaNptzWZa2WuCQ5CdieQFy6n4owq68mdW5damABgpEjiDh9mBJVITfit5KjTsXBFpg8ZthNGBZlVZdtb23GdkaqQUvoV2fTAdctkXx0xsUZ/TnSrS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDqag+fV; arc=none smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDqag+fV"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a772de44c5so20049651fa.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791241630; x=1791846430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAH0M62CAJFlGPhxe8liaDm5bbJ/KfgviHm6E1Thxgc=;
        b=cDqag+fVOeH8ha12uS73EbLD2RkGD6CY4kvk4I7Gxxl2E0GLrQt+weS0aWQ69nbTG4
         S5bz8aAeqbDW681FNy7AR0HkSPMxsvpI38r+o0CanCnAnIf2vJINX4jUJ0aHyoSlsCyu
         q12J+kW2sKfQaERydmXbbrkhYWK6t1EauoUQzrMADk//GTGsQElbejJGxte7yzmLX/tj
         CJAydaD6xq2+stzEN7dBrPmZALyLGuz6bKHnTHkYZFQYRyzv1P6N0hdelTNz2iH88NFU
         9FO7YvdaQfDNdd6OkXP5q4J5mKFDyY4d6N7pfJtAucr/PwXassO8xpepa32e4fNEvCE3
         9U3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791241630; x=1791846430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAH0M62CAJFlGPhxe8liaDm5bbJ/KfgviHm6E1Thxgc=;
        b=QhxnWL/mixE2+qqz3G2uX6NDrah/SFFZE6cmwKywI5WbKvUmgmKeWWiaECpFFagu7j
         el2Ji3J47mPel5CeQ96/8qT83RIhKym0mZ1GA9OsY4cJe02NASwqMWeH7gybGD18+4zl
         i4Z9kY9zbxFJDoPZDq/U12XkhhBBtM0HD7DnNUK6lqxoUx1tbV4aP9dzBymYBAY9IM9y
         Mtr3mMgNF76JktND9W55VU1+RbRo9jxrGswnarFPLz8Np5xy3zcc7UTf9CRzIfcEsVzt
         AXUbA2EY0qNnWAz7BUhV2l6j+iH7vQz7PrZidCGKFepVzypzx6Apj7neFOI/4vTnWEmW
         WZNQ==
X-Gm-Message-State: AFq9FYJjozot0DjWoWvDnWq9nzORthr0LyefeFq7kyGHW8npm+IL3x0O
	ro1qwHIUlTXnW8oS81wiEy/1Hru+KNLfY4/xN3ed02CaflzyilXe8koPsoxXOF7u
X-Gm-Gg: AYBFou07wR0d00gevZ/q7zXUU+kQJHrZnUbcRyq7jBgOtJqqV+UbKqXyMNiIksodVTg
	BHgLKErml2ImrD/VWh+0CnTCUe2yFImJb6g2JjIzS6atAsb90lzx/F14u6uh/L1XYKi04AX0j98
	6/JE50P//0qTX5r9KvjrEGSmgee/Xem4hlpuFz6Bkr7Xpz15SxXH7weVVYUItRgOXYqriyNze7c
	rHUsQaFbmb+n9VZmJQhF1T2r0nv0BDWamkzcXBzVWWuJr3cb6zk27Ti0RXezrfUWfaiXsQ5pVOS
	6q6p26Sl/Iri11ehQTaRj7vTfTl3DSs5Pxy4XqOp4A8ajCMiTEIoQsGOVVW75zqqteNTWO072O1
	thU8x+ygRpHVb7PtJQBIWHHjH8JRKZnPlrkvPV1IRnDaToomFbRaK8nw67czRAfP5TO8XRFrzEh
	FBC5TXci52MFfoJM3UshOvIguR4z+0nc3ctAGVry7ZbyamiAqEFpLOAPXbXZo6z9HkWgPV/5swf
	rSkKszOSwc6T2xcRpuSgfn+QdHmLnXrSK8KtTUmCQ==
X-Received: by 2002:a05:651c:a38c:10b0:3a6:5c75:b3ab with SMTP id 38308e7fff4ca-3a8877b9a42mr20947621fa.24.1791241630278;
        Mon, 05 Oct 2026 16:07:10 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a8990712bcsm43301671fa.2.2026.10.05.16.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 16:07:09 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Mazin Al Haddad <mazin@getstate.dev>,
	Matthias May <matthias.may@westermo.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
Date: Tue,  6 Oct 2026 02:07:03 +0300
Message-ID: <20261005230705.932167-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179121211133.434549.1381649683777834470@kernel.org>
References: <20261004145205.226974-1-littlesmilingcloud@gmail.com> <179121211133.434549.1381649683777834470@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 05, 2026 at 02:55:11PM +0000, netdev-bot+sashiko@kernel.org wrote:

> - [High] The check/parse mismatch the commit says it fixes is still
>   reachable in ip6gre_tunnel_xmit() on ip6gre devices that have ...
> - [High] One of the parses this patch is meant to protect is the one
>   added by Fixes: b09ab9c92e50, i.e. payload_protocol = ...

Thanks for the review. I measured v4 against net on the cases it
points at - there is no regression. For a VLAN-tagged frame the outer
header stays the same where it was already wrong, and either starts to
inherit correctly or is now dropped where net let it through:

  tagged frame                         net        v4
  ip6gretap with key, ttl inherit      hlim 64    hlim 64  (unchanged)
  ip6erspan, ttl inherit               hlim 64    hlim 64  (unchanged)
  ip6gretap without key, forwarded     hlim 64    hlim 32  (now inherits)
  20B gretap / 10B erspan short frame  sent       dropped

High #1 (header_ops branch): that branch keeps pskb_inet_may_pull()
exactly as net has it, so the mismatch there is not introduced by this
patch. It is reachable only on an ip6gre device created without a
remote that is later given one with changelink. That belongs with the
rest of the ip6gre changelink/header_ops handling; v5 only narrows the
commit message so it no longer claims to cover that branch.

High #2 (the parse added by b09ab9c92e50): yes, ip6_tnl_xmit() walks
the tags again after gre_build_header() has pushed the GRE header, and
clearing mac_len does not help that walk -- the first two rows above
are unchanged from net for exactly that reason. That inheritance is a
separate fix that depends on this one, so it will come after. v5 fixes
the comment, which was meant to describe skb_vlan_inet_prepare()'s own
length check, not the ip6_tnl_xmit() parse.

The two Medium notes are pre-existing as well: the IPv4 paths
(gre_tap_xmit/erspan_xmit/ip_tunnel_rcv) and the erspan_build_header()
reads on short frames. Fixes for those are queued separately.

v5 changes only the commit message and two comments; the code is
identical to v4.

pw-bot: cr

---

Anton Danilov

