Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015528;
	b=So9CtqZ4YhqWe+Yspwv3izpgVOZfuwIoGHfmpoDWWBtrog30mktoB9IugJukYUJ33Cy8
	 gSzH2UxcAFMEnrIMzyp7ORkO9q2LD5g0bY74ccFWfckVCjj8O63Ub3d8PoMLjvoiKenJz
	 hpM8ZbjSlpe7l00P+lUIslote1AAuWUUEPwxr8jYImDFZnEe4H0rbhUDLbspbQ46iM7PK
	 TZYcPKq5jVKis0+iq7RTDdn6097Kz6ruNvxoGpqLRZ6bq/+NKvkn/NLQnckNy4MUtNpRm
	 +bJ/OcSgS/VCBii0IuK6bTBnGIOqZRJoPgALsvmOUt9CN8b1bMYTckxqwGOtIbPf4qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015528;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oXmtbUNcpCmBSBrSPIQ5eCtMYF36AZ7qVO68tUryAUc=;
	b=FgcbaqS10Kgh0CK/J6RSl2T7D7QMbogV2wchCl/7AIQfta3GyKxzxoWxxh0KkBDtcxLY
	 ctyy933B5gTkiI02GTojAX4LMNKWiXPZC9/ov+xA9Ry9Z4pfeBMWwCdqw5bvAuMXxPDRq
	 8Swk64eXWcN1Z4L3pEsirBW9V79M4MDRh2/upDw5U/BS/IHGJN8b9u8Kgutin3G3ErnRf
	 gIibA/uFUYqz/2vm62Objr7HDqMBLUPjbyzPCGybtKmF4bYvEWU4UF2nXbgLBgzVlUR9z
	 n7/6QSEw6tjg/5EDXPzq/aCO6LeNCkGzRi7N4LdtCFRJ+NVPwyQDmH7Xc/GYEI7HU8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BjbvhTB+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eWGZbKAX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4C606A332
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FB4C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BjbvhTB+;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eWGZbKAX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793015526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXmtbUNcpCmBSBrSPIQ5eCtMYF36AZ7qVO68tUryAUc=;
	b=BjbvhTB+Fq6/W1cxCk8hB14+JRFyA/Ne9+SS9KT/KsXFroHJQQ1kRRI+exhbqTkGwGC+lx
	iIhAeaFcckwxD3eNuoPGb7CkJ8b0Ol1dIp043y/m3TEAT6fDGUztTSouVVsqcRUA5OVn1J
	d/b/IzzvOxMuJD+tIhZ8WaJ5DSLw9Kg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-Gnwn0ZB2Nf-Cglv12RI1CA-1; Mon, 26 Oct 2026 07:51:59 -0400
X-MC-Unique: Gnwn0ZB2Nf-Cglv12RI1CA-1
X-Mimecast-MFC-AGG-ID: Gnwn0ZB2Nf-Cglv12RI1CA_1793015518
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so2593663f8f.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793015518; x=1793620318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oXmtbUNcpCmBSBrSPIQ5eCtMYF36AZ7qVO68tUryAUc=;
        b=eWGZbKAXg6voSdVmFRNeRAVajxhVFt4Xje6r63u2FAH4GZOY5WZmkSaSxDO33Yik/9
         H5S2RrBbfLkpsjyZglrOmr/XBmEm0WK/7HpoLz6pIqhdvWTOQ8NoE7UZttwhgoPy1iJD
         W/ApLnfesP2NSz9ni8jsN5QUuexQTfnwduwbVIVClF6mTxs/lXow+zrQphJpg7KrbZt+
         yanZ2SDWfod3m05BGsnPn/p5CcgH7z9r9Lny4gy7IXMcG8RURTTkAtZsPcVIZuByRWWN
         0SfympnV6Dcd21ixn52mfJ2gL5Xgrr0cftJnA7V0pUKHaKKNQMjW8tSQC++9/LFCsZEM
         3gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015518; x=1793620318;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXmtbUNcpCmBSBrSPIQ5eCtMYF36AZ7qVO68tUryAUc=;
        b=CnfACzo3ykZqvieYpNyOkvVcl6QoMAQLBTky0Q1fmH/tL6pG7l49Ic+24ITDxfSrM/
         yd66RicSfRfdOgFxmkkKdP3toqGR7QzL0D5TSvaDlMfo9XI9Gti4319eeibvGiCZidmL
         TKx5CDSsX3j0lwV0Msr8k18t6MDlHtVYw40bRkB3qSd9fmwTrl1dxEr2cjg2rWRtJ1k8
         Y0jJw9GVxr2qFnpY8JbdIptG543zPEbDmTNUH274C3DtwvoBLXY+laRt25uZ4yKDGObX
         I8QtAZzW7isNkFPEt6QWimiY2Ql9IXJj8k/2p4Bj8Ur9bK0/Nw38oqkHmPmB1huYH9Gq
         FTqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJDLFycz33wHFSak2sjku+dMQ+AwqZgt9CUGBB4rYuXDkwmeexIi8llaGtlj5SAh0qxx90OHY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzFG1Wr2VI/qZ4P3Uu2PkfDKb92aEZWIsKghYHIA4GKgFFBqjW
	p/m3EjLYrAiLDUGXsrepcrrjxe3HDvH1uMh3nSThMsCKjUfl5k5LJ0w+U+9YrMj65VbcOTeYrlD
	ZcM/FQBADppFRi/lrMNgj6j3YZPoY+E5fme3qAwVxV9QQTN1kvkGIBzJ1cQ==
X-Gm-Gg: AYBFou1tj8UygRJfq+ZRrGq+S0Op4ELo7jewP0EpoSBB3qoGszTCUFXJSgcJixamAdB
	l5TOXPaD/s6tpMEMk7SqoIC0M1w7RZKabN1sdXlAUtG5ZonzA2Qtx8q4t8BzAsrfJAgbozLcM2c
	6IHGrVpvuELbn4/lV6cJed9tuN+YcbM9Irs4qKj6IroqD3BiN3FaU6BO3e1GdRotnf7ZwrlP+7T
	ZlOLSxtwx2A2SflkcM2arrq0XzXOCdQi/kpo8w7sIWpZVXQms47l3xZa2EI8LSiKXeJPyOj3h9F
	+YcPu8lyvogEkjBBBc8tBblGbqOjwAXP1kv9UUbVYMewdQ60sFzTbtFzpRJAZ7EtXTKZnt/QBVN
	zV578pm4yAZetyClEiv491My+C2bt83wkwh0rKqTpVlati6fiHjA70w==
X-Received: by 2002:a05:6000:430d:b0:48d:ffcb:28e1 with SMTP id ffacd0b85a97d-48e3eb780b0mr11518117f8f.11.1793015517824;
        Mon, 26 Oct 2026 04:51:57 -0700 (PDT)
X-Received: by 2002:a05:6000:430d:b0:48d:ffcb:28e1 with SMTP id ffacd0b85a97d-48e3eb780b0mr11518084f8f.11.1793015517438;
        Mon, 26 Oct 2026 04:51:57 -0700 (PDT)
Received: from debian (2a01cb0580324c0086a938fffe1eee25.ipv6.abo.wanadoo.fr. [2a01:cb05:8032:4c00:86a9:38ff:fe1e:ee25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48eesm16004691f8f.30.2026.10.26.04.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:51:56 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:51:54 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	jchapman@katalix.com, tparkin@katalix.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] l2tp: only return sessions of the given tunnel in
 l2tp_session_get()
Message-ID: <at8-2mFyrmPxfu29@debian>
References: <20261025145831.2133617-1-hengyul@cs.unc.edu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025145831.2133617-1-hengyul@cs.unc.edu>

On Sun, Oct 25, 2026 at 10:58:31AM -0400, Hengyu Liang wrote:
> @@ -315,10 +315,19 @@ EXPORT_SYMBOL_GPL(l2tp_v2_session_get);
>  struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
>  				      u32 tunnel_id, u32 session_id)
>  {
> +	struct l2tp_session *session;
> +
>  	if (pver == L2TP_HDR_VER_2)
>  		return l2tp_v2_session_get(net, tunnel_id, session_id);
> -	else
> -		return l2tp_v3_session_get(net, sk, session_id);
> +
> +	/* An L2TPv3 session ID that has not collided may be in any tunnel */
> +	session = l2tp_v3_session_get(net, sk, session_id);
> +	if (session && session->tunnel->tunnel_id != tunnel_id) {
> +		l2tp_session_put(session);
> +		return NULL;
> +	}
> +
> +	return session;
>  }

The original code looks correct to me. L2TPv3 sessions, unlike L2TPv2
ones, are global to all tunnels sharing the same socket.

