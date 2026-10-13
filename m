Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A563CA483
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888801; cv=none; b=rhF+Thkwhddy97A7ZG/8Sa/1Iux7ukBxAhTdM8Mb/GlPcrJd6Q3ClXkZruU18sZJypcDJ5fbRaMQJJbL9d8tBLRwTY1zaL0y4Lh1dnIJY481QdsFVKB6ZkDa+7j1OdIrKBlR05zua2Dg8Z+QV447kDIJyVilK8Z55QRXTjPLKoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888801; c=relaxed/simple;
	bh=OeqZFh2AYWYR7ltZDBpLKceGFxH4LNQaJv7496x0jRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmGoz40i9MU9+rMPdwuLqztuP3vX1SC7lAa9/bBU9QYZLUIKNn4/g1gN3rEG88xQXWCZdx8K3GmNaHgkYSqd9snX39pN5qNIRLhJnVSTpLRrO5/WXx/Cwh68dJp6oZrx1m/JKq3OaDbd9pGhAKYxPChdi2Yz+bWqRyG9jiAtG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIrt/bvi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIrt/bvi"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2734918f8f.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888798; x=1792493598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weAsaaLz8bOtBYNYCdIRoGplN8xEUwEYdEIJVgSddI8=;
        b=LIrt/bviJxfsvKM6143rYC+2KkjxJ8T9A+LufpnasZYVShIj/U+suM+7r8v8TFekwG
         P6ADJd8PK93PKdUBDHaYgBrBeqipIlR2aD/E7Hf6xc1X2b96aJE86EZr1OG9k+hcGf+M
         cMn+zq5/Or7okg66GhzkWsCvATRFrEivWxe+lD8TCTamnGf+OZZgoOznmtDbTgqCI4zc
         WUT72SPO30beijLx42R5yFax2OlTUQ/dRoVTZBPnixTKO/QGfzpbRkC8oGNWUvD7Dzr/
         2c42XKvaOZxUMZuAliL17/rGunUwJGeb9oiPXHhZwFcCG/wuVzmCnePRr85lnGD0QNSL
         G1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888798; x=1792493598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=weAsaaLz8bOtBYNYCdIRoGplN8xEUwEYdEIJVgSddI8=;
        b=sijVL+2ud7bjleats01jZNKuH3j2P+I9rRTLSJHDU9aKLmv1lYgc23bxkyxvr9xJtw
         9lKeoKVzyfxk1njvEu08/JFiRNAaTQ1Tymt5T5TJFP8ig+nR9UdjeYAiQltqD78hE1UT
         vLwzOc1Q7SxOPuTIgugKksJyXq8H4InwRHZrWHRCskebCCZrbtWFEipB/Qq80uJWm91Z
         7XfrLxwQh+A6GubdMaYrJPG/4zrSVVOYCntFAVGEx6hqVI+s2WrdvipGXrSR0DRM+At0
         3913REo5D3tAcVgHwDFir0BLs0yvJWNQ6gadziffY5L8ecafJqHkPiu7a1wzseiAALBY
         RIGQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7CRJn8inECp6HCJM92CuzGo5916WVQLIb0ZPsVGynA3hRL9L+Ie4RKF9R1XdDS10S/irQF14=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqaCHkjUCneRCtcIFkEPwHqx81oDm9ua8z71WizPnOgtAtQSxi
	bkMj/H35vuCZk67Ri+1uQg0Ql5v8VhURJ3e1usiRpuXbq37Cwwqbgt1z
X-Gm-Gg: AYBFou2XXo88PlDr0/kvviv+DBzdQ1X1MXIjZeY03U03mgpy7N8tb8Ee2i1y54C8pUC
	GoVDsZuWCLBcb03iWlo2deYUj71pah4HaHCuTzNmEBXNALTCDEohwN3d878+l93ygKEpCz7KIvn
	PhDITZT+zfjvdx0mtGS2yVZMbZ8Bc/EMBEq6NfrrQm7K0rU3Z4n0Tm/sTLFyQxprMlHdSCw5jyL
	rKWjv7cms53U+1Xe3ZbqIOuIa7DcTRlqYumxfyKIjI6ALCqOpmOsi5Txb4Kxq1PJd6rr3Rw3hd+
	NFxCzpquFJEb/qKdoLIGYF8CK0zcx+q327DSgBdJMRP4G2ayN54iTtT5wbmw6yFCCcsnhk7g/GE
	IYVDqZlqW3t78ykuulon4sUnVVuJxCuWo9idxWLsCIly5wEYdWei5OJmNz5XmbiIumF9EhoTOEY
	6TzH+0X4Uoc0bImoCVUXXcLjHxFFtyYO0KlU7WB+zfPSAUvWopbVx7MqkMxKmG4Awtk8sxdQ+zj
	HI69J3cJqR2SYb5dXq/LI1SQ8LRSXPjgIFG9kI9tecA/w==
X-Received: by 2002:a05:600c:138a:b0:4a1:7bd4:d07d with SMTP id 5b1f17b1804b1-4a18e4c85fdmr257515105e9.34.1791888798168;
        Tue, 13 Oct 2026 03:53:18 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be96549sm507133205e9.6.2026.10.13.03.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:53:17 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: comment the RCU and SRCU waits in unregister paths
Date: Tue, 13 Oct 2026 12:52:58 +0200
Message-ID: <20261013105301.9037-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAAVpQUAd4QzUDK1wZYpuHJbMSg+PwAGCcaTzayR40DTNkXdwQA@mail.gmail.com>
References: <20261008124423.11543-1-parri.andrea@gmail.com> <CAAVpQUAd4QzUDK1wZYpuHJbMSg+PwAGCcaTzayR40DTNkXdwQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 12, 2026 at 06:48:22PM -0700, Kuniyuki Iwashima wrote:
> > +       /* Wait for rtnl_get_link() callers under RCU that may still
> > +        * dereference tab.
> > +        */
> >         synchronize_net();
>
> More specifically, this only applies to callers before try_module_get().

Right, the later lookup in rtnetlink_rcv_msg() runs under RTNL.  I'll
name rtnetlink_rcv_msg() and try_module_get() in v2.


> > +       /* Wait for rtnl_link_ops_get() callers to call rtnl_link_ops_put(). */
> >         synchronize_srcu(&ops->srcu);
>
> I think we don't need comment for srcu as the relation is
> clear via the argument.

Agreed, I'll drop both srcu comments.


> > +       /* Wait for RCU walkers of rtnl_af_ops, including rtnl_af_lookup()
> > +        * readers that found ops but have not yet taken ops->srcu.
> > +        */
>
> this can be simply /* see rtnl_link_unregister() */ instead of duplicating
> comments.

The two waits cover different readers, though.  Besides
rtnl_af_lookup(), the synchronize_rcu() in rtnl_af_unregister() also
waits for the RCU walkers of rtnl_af_ops that invoke callbacks without
ops->srcu: rtnl_link_get_af_size(), rtnl_fill_link_af() and the
IFLA_STATS_AF_SPEC paths.  link_ops has no analogous RCU-only list
walkers, so a pointer there would miss them.  I'd prefer to keep a
local comment, reworded in v2 to mention those walkers.

Thanks,
  Andrea
