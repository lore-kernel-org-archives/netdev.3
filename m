Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B454DD3C8
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724848; cv=none; b=TDvU3Y58aNHxjB8xxRLrMkr4N1nSziJYyEoDyjvVWZt35Hn1SEYDGG4IxRNe3kxrKJTUlVqh/aQIagVrCetaa2Kjj9jReh3XXAt60FThDdtccwSVv3H3BWaniVO1oxbtWUVpw3ftL7CCTEqUfs/0P4tT/agLbG+qTCTV58Ha6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724848; c=relaxed/simple;
	bh=pppU/o89qm1sLiO0OoAbWHZ4lhtSEjVPfFnL708X03k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwb62jrlUIRD34NtVZNSDEmA5/4pxKVS5w3hpVuPUqGTDUYkQ9RvO1YRTnAeSyhvJcG5Fmvb7XUql24PCpy4sK4ShehMCbb/LdRPs3k2TmX8OzekYWLVlxySAF/iB3gjgSiknoOTJHMEv6WTTTjjc4g4vVmcFN6uOcM2ST84Hqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWPpsaZr; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWPpsaZr"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38de693676dso2453575a91.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724845; x=1791329645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=90vGdgLltOmZQprXn366F7yU1jtNwuxzXIhmT3hWVVU=;
        b=XWPpsaZrC3iyN4IQ5PfJ4Cc9ltb26LLu6wszgkNnPmvrXU6+Di0GFJ4L4i0cizDH4f
         JtWMPGHPRzRQ3h2EJzu2nY3DbdZWBWhwPfUcvkrBjIfHli0wB6tVMten9EjGsa+BjLBN
         tl/MZwyIqL6bgos3xZ2uNHQKRLZeVPBHy7QV/BWEeQP3CDa5Q7J87vHOcY+v6qONuj+l
         kTkqQ4DXuX8ZlM2dkwdoziTMQzSdkOCmp9qN/ynaMX+CBVt3quEGMsY2RtGAzA1h0wpO
         nqc07ksW8m7HxUlqhczw4pWy4aPay4dmksMhAZsUNAo/nLAa1+vxwbVqcFj/nQWy08rU
         LoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724845; x=1791329645;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90vGdgLltOmZQprXn366F7yU1jtNwuxzXIhmT3hWVVU=;
        b=Im8dhdcTilWPKG88tC3wbRZW0wkcuXHl5gZBSAW/yIycaO0hc3Bm/TrF+fr94Zmoul
         DaUxBrrJzZ8rnnJTDIRVILB8S6ghZ7qL7CRG6Gt+V8d3Lq6lbeZXDTzACaPu03awfi2t
         efJConZrQbQdWf0JZSoFWuGZFRtLDawubP385fIJ6FsGhsTe6O6BnfgCr6kpAyGkY71E
         rt2F/KwG8UjSKqeAd3AaV0Q0m8A7EYiAaRvf+xSDM1/OF+Onu2dekmOQku/LqF4GL/4B
         NZ3YlRHEuprq2xO44Ta4dYZ1UXEJxJBJAf+hgVupLNKcYCq4FVO2bNM+wZmfqRiVkQ0A
         /GFw==
X-Forwarded-Encrypted: i=1; AKwUvBzIWa+I1H+mQPZqvt1QvtkIoSbfp9qP7p632rZ417TvqOdr6qDnS6BuBLvO4LhmYv9nRgegvaI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK06MQO7nC+ehPojkXd+maR4hhIX/vNvQ4SkULWUerHvZwtYpZh
	tJRjcmnPqHGk8ynfrRi2VrJbCXKRHDWuQDiNywfYtCfLwQ4A6ff5OYaW
X-Gm-Gg: AYBFou0CJhohloLSFFjzNKcU1SvbFdHK/eBxDXZJ7laJ9hPxpT+KJnjbPMZVVCZRLQK
	AqpCOr5QS++XHJxoP2UD8waj74NQmFjwux9+nn54yjuDJtMHibzyppVA7iufm8jPqdxOURIlMJv
	S4eyC3Mdbt1/GoGGsu9eLZ3UG6cME08PawnmLDzWgcTQhtOejCO+s0KBcbgsIfRcgZ1b9bBT5y6
	og7tufBGnl6NsTm5La+43uWabLmIAGCixDl+bWhTtgwhiGRUBmNq4SLK40xJQfnSqO0WWBT46/b
	IwNssI+LlBhHmk0YsDVBw3GdbWonFDMcGRYxhXBmkjW0PVPmui3ck26hOEUa5VItqV8y6k/UFft
	NeBH8IsWqxoKd9rz4lrVERDy4SjL/5ZgjMjuIN07fbtOQbBW7P4T8H8n6rzPVJxYTXlMLwG2r9x
	tdgApsSo6QNNoKc/tB+8SVKcIRdz0vEwEZjfVgxRr8OxCg421o88iwTbKG+JiDiFuz
X-Received: by 2002:a17:90a:ad7:b0:3a4:c673:7649 with SMTP id 98e67ed59e1d1-3a4c6737775mr195074a91.21.1790724845069;
        Tue, 29 Sep 2026 16:34:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cac131c7sm163775a91.11.2026.09.29.16.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:34:04 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:32:08 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next 1/5] net: record XDP programs propagated to
 lower devices
Message-ID: <arxKZIebRaEoMsN5@devvm7509.cco0.facebook.com>
References: <20260928223648.2739371-1-kuba@kernel.org>
 <20260928223648.2739371-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928223648.2739371-2-kuba@kernel.org>

On 09/28, Jakub Kicinski wrote:
> An upper device installs its XDP program on each lower with
> dev_xdp_propagate(), which calls ndo_bpf() directly and records nothing
> in the lower's xdp_state[]. netif_xdp_propagate() open-codes two of the
> checks dev_xdp_install() makes, but the lower still looks program-free
> to everything else, so the checks made in the opposite direction miss it
> entirely:
> 
>   ethtool -G $slave tcp-data-split on
> 
> is refused by dev_xdp_sb_prog_count() for a device running a
> single-buffer XDP program, but not for a bond slave running the bond's,
> even though netif_xdp_propagate() would have refused to install that
> same program had header-data split been on already. Binding a memory
> provider has the same asymmetry. The lower does not report the program
> over rtnetlink either, so it is invisible to userspace as well.
> 
> Install it into xdp_state[] like any other program and mark it with
> xdp_from_upper, rather than tracking it separately. Every existing user
> of dev_xdp_prog_count() and dev_xdp_sb_prog_count() then gets the right
> answer with no changes. The flag is only needed where the owner matters:
> bonding reads it to tell a slave's own program apart from the one it
> pushed down, both to refuse enslaving such a device and to let the
> bond-wide program be replaced, and dev_xdp_attach() reads it to keep the
> program from being replaced or removed behind the upper's back.
> 
> The lower now holds its own reference, as it does for a program of its
> own; the upper's per-lower reference for the driver is unchanged.
> 
> While here, refuse to propagate onto a device which has a program of its
> own, matching dev_xdp_install(). Bonding checks this before enslaving
> and before installing, netvsc does not and would silently replace the
> VF's program.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
