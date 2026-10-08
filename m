Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0D4F4034
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484689; cv=none; b=u/yjSyXnxc8jsKCF0GSzHUiTkFQjvPn6NgrsPs8EvxsJX44PHUziVIE/gM46ayP6lJq0HNYS0GdYng10+acCsV1WebL1VsqyKcUPIRRq44AYMA/cWkCedNqcOL7Umz2lsY4SfbGHHR3m5u96VWiJtd5sdRQdmCf6WJLexDILQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484689; c=relaxed/simple;
	bh=8VvDKpA6dotf5hcsrHKWY5ABDsoYWd02qSMIZVR77FI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rRtHaFOehhg72UftF1T5VkHggsIqqDFurp9byqbUbvPH9uP/x4eKLr2cYwZIwj1gR5HYq+aZANejmtlJDW5TfihoazcVjMpq2WC8Um7o9tyjw1QmKlc8KjFOcBNXMMHYTYF8giHTqmwZ2knpUZhSx2gMj+5ZNqQqc2lWsrNYU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gM8zq9TM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM8zq9TM"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8726acc5eadso28107587b3.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791484679; x=1792089479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cSfAyRkE3uJJgtXN1l/jmkgGCZnzg8JuVEyL3Egu+bs=;
        b=gM8zq9TMIaq5JBBmpmElF7HlrDxSInrVVtQJo4A/tr+iH++QQ0+2q06qOeIP+U05Ax
         CY/t6esm9FKwtUz7P6nrJ9lgL0jmT5usjWL4Uo3+rL762o4ekVBOn7d20ViUH7igid/u
         MJCXNJhB3r9ecwPrFjtxboie7/DlnVIw/R1IuY+b0K5K9xa75jzkn4wa99+yuc7eexZO
         UV6Gx4c7p1ztedGX3HAJOBC7/fgvaHHytWwvIw6hu3Y3U5LMBuyXTZp2brXJCkAsoLy/
         vmqW+de1PZ9YDX3dQV+O58KlS0JSXwtEx1XYOTXlWfApXgR3gKvVQcbrh4Jz6Yhi3MD+
         SZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791484679; x=1792089479;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSfAyRkE3uJJgtXN1l/jmkgGCZnzg8JuVEyL3Egu+bs=;
        b=b9hV0g1zrzCW8e3mEOrI7Y8QvAmIdRVTvr3gpUeXr92QDT9SmY7tFxmwf1kvU+NTWp
         +Yh1dSjkKgxlEPROHLEAv9GVVKiAmLlgCj2XYE/XzLFsCiqXfVVAheA0NBqxSp9IG3Oi
         IvU04XpHL9um8m26Yn9xKw9l88JEu9/I0OT511u0OJpxlUCA1CPCTnMQ2VgwpADxbX+z
         1i+Y4iBy1U/IuQLYjPnRMk2tdkewEuboIMf2wi426LYsLHHfouNB58ikjzdqhOiUMhhA
         l/ayH7jO6m0r0zmhLIa3FE/VYIa61CNaO4303dt6PXRJ6Cx78Er/jatr0DpPjX1ejjY7
         oW5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwQck7N03LeDruFcIeVb+qXE/iA93W4PgfUredb8YgL97NMvhc6aC5UIG8IWdX9A13z5ho22X4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVUzfBDyBH/JQ463nY0kU3EgbQMA3a9O3/V9RZqxB3culET2hc
	OnDaZ37PRuXPmWNH9JSFXGb0IaUAG5Dhp0Srfblo6fktWOWAbRCjOa1G
X-Gm-Gg: AYBFou0JecRkTvekxfpeQsL2MQ2qq+HFNC6MHKC7GtT3iLnbtnhlVKZOMmpKE2OtALz
	AYpyA3ICJb1r1bDT3ghrH1zax7XYuU6QIvfCHLxgDjk8TNR8MKQ2CT0WM6PQXkLgfq4dWjg1QLS
	C7TefqGC8egi1rDMxXWsJDN5A/sPUAUSRLhg6u4S1A7gsfU/H6WTl6OXIjb6FHuz8+e597/preG
	aLEMRYaiOGWDA6/oEyBO7J9eyWiJ5W9pHBVVGP7gjJWnOKp8oFcN2tT5v1PXemrizUZ3gao6sv/
	FRgDBTrd/2qCeaScCzS1RNfygay2BNakkc1a1ZD74DrxD+4ZXV5K94H2P5BZmTcnYEkGd2onReS
	fWvRFq+956SmvkbuUnCJjX98KQwZA+IioXJ+bz2anrp3JqRSz+SkaFpoOdZ6UHSjonRTvKZhKr8
	o4lezk1WYmQPPl9QhXpTmOpJth43RdUppy/COYOV5dl2SVTFCy0AMCvdYb5hujxTadrGfn3aj9L
	ztpZJ6vMejcUD7oPzfbh1NxOErKUpmjx/D/CaLgF9IlG5wo4hewCAxgKvoGVWVUtKcdEgT9tODo
	wCSK94Og1GjPksqqAWR5b5vnyw/doyHt5IktAoM=
X-Received: by 2002:a05:690c:e64e:b0:8ac:e393:16bd with SMTP id 00721157ae682-8b07c90058dmr408087b3.63.1791484678848;
        Thu, 08 Oct 2026 11:37:58 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07d5f3421sm43397b3.26.2026.10.08.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:37:58 -0700 (PDT)
Date: Thu, 08 Oct 2026 14:37:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Wang Zhan <wang.zhan@smartx.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.144d1171e4ef@gmail.com>
In-Reply-To: <20261008100651.2534957-5-wang.zhan@smartx.com>
References: <20261008100651.2534957-1-wang.zhan@smartx.com>
 <20261008100651.2534957-5-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v5 4/6] net: gso: clear the GSO state of the last
 output segment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> skb_segment() clears gso_size on the last output of a group which holds one
> MSS or less, but leaves gso_segs and gso_type as the grouping set them, so
> the tail is still counted as the whole group.  Readers which take gso_segs
> without testing gso_size first, such as the ECT statistics in ip_rcv_core()
> and tp->rcv_ooopack in tcp_rcv_established(), see that stale count, and a
> re-segmented output reaches them when a veth or bridge port delivers it back
> into the receive path.
> 
> Clear gso_size, gso_segs and gso_type together with skb_gso_reset().
> 
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
