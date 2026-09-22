Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A05625E2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118158; cv=none; b=rsfXs9ZQ43oqPeCHNUA/7I52X8P+NGyWxyAT1T1JRKa2HFReHE8Yu3a0jgezm9Y7FbUDbAOT+XMBzNKxR4qm/qawRvWrcbKqREDno/WkJIYRfwrfUwe7GGf5CTQ/LI7ncPq4BIBfQy6CpgyckGITCOeaQQ7QG1n7FjiXkhSPEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118158; c=relaxed/simple;
	bh=iaIamMi8MPkJ1yd2GOX8Iq4hZUSjj88CopXy/MvsCpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmHIL6TQ9ZWbIR3yWyhvNQHFNygfkjfxeZ1fuaOkjSj0ZUfZRkg9bkgKXfAwSYSDbWl208Tbw/8t6cXarFTmW+5LRTBrnQ2I+YbY6tfKAWI0Syc5/xkG6z7jglNDz0pAajz39MbhJzz+vo4rqflqie9VQhAeqaA3KJz1y5/r4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW2Bsdb9; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW2Bsdb9"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d9080b18b6so2552995ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790118156; x=1790722956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xTGlIMPYLlSzDXY6D6YOIeUy0r70YVs3+BkE+ZR4VLM=;
        b=AW2Bsdb9tIirWKjumpF8p/+EUBvifrCGMY8SIPPSMbTrbMal/dyss0s+rnEFrJXIY8
         vZoMKkK2rIB+iYgJJfLAiPdm/OfbbGO7ecq81U9PZeNGUQxYIE3AffQapbKvDmWVDH3O
         rbOTY4HERzZviCbJS6yeyQarDRiH+0uDfjm709+rrZ3IcARTV8lmeQgMGhFladVQKKgc
         3n2y3S2iqIia83gphmYz9MgnL5An7Bo+Ewegne2KjXY8SoYP/3d32N0Q00y7hIW3vEPl
         4HMO4cLbnBBFFfFG3oeUU5V0vGmQfynKp/2/gEujB0hnaF374wyGCMG0mI/Iv3REmwRT
         K3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790118156; x=1790722956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTGlIMPYLlSzDXY6D6YOIeUy0r70YVs3+BkE+ZR4VLM=;
        b=wisD1yuU8pq0LNAaqX51YrGb4IJEyPjf/GLtUC+2RrJu++Y38qhLlvhpET8ENmKUr0
         sjoHN1X+yg5818lQZ+8Kgo8lT44tpCMxVPQOpi/VotcB5FEaV50No7WgUNd4jZ7e0JuM
         3sMB1/7LNN/Eny51su8l4U1RaZgTYyhCA2cVhs4jSa5OplgtWvXI6USyNA59+o1j6lxQ
         xH/LjGjRzvka+fXWfBWCLcM5zxhQJ4TCp/uPyyL400h0RiDZOhg67O8xBZQ6vzSaAKIb
         /Sqmc0sFP6dT4TJuIwubmxwETI3tjQVgOqrzEz774mqt67MNozqA4sOMdDMk/Y0w6B1e
         dw0A==
X-Forwarded-Encrypted: i=1; AKwUvBwvKEIwmogl1L/TccOagdQJMKEBZ7j5xN2xHje6X+GKus8q497JrULLuljMJDV9e79BuPQ5jQQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l2LMRzP/zDidJw8BhLEOOv92sBM5Qy05YKl8Z93cbJJ8z/wW+M
	fYY0sSqwd+NwS3VsNwTogIlVTW8lY1HnPvT6Kg4cwVwCQfZ4OjfsI/8Q
X-Gm-Gg: AYBFou12+IVzjgOpfXTsndqM1jq+lE2c1tgmWyiTcS+33bFoJmCH01nMRqy3LrvX4sS
	S5hW0GisrXAfzflcp1Vq1RsB05ncMAWnTmNPXqXDtOScJYmBXokDFx3QXz2c16smm3y5rPiRAPO
	EyfhreDv1hNMrXNzw0hMlMqMkx/XsyU30GeR1B7y6JGVoPAPKtUlgUqicntHQh/eGGAkTBwGWAO
	FHhMBdxZ+9pj7IG9diwqsVmgNXDx6VM+I3QdtS4EYW9qdhrYMU3rGPjrGtmjsaaLKGXEKzrHBRT
	3HC0qJqTvxaa8ljwK7RYzee2KP3ZOozga+QIylY+FNmGkuoNEvl78GQ5cMFe8BjapJf7t8jfMmz
	IqhVgYk30uv1NkXP5bAhiu4B3jLAM+c1gSLZ+Wj00y8zhpbw2KBn9aJTR8m6JoUZtWQJGTY3YX0
	W5cPuAjLyJUlkFft166izXf1HQgLQL34IBfmrZmtwHoGCITscPjOUHP8wEqVKvTzhx
X-Received: by 2002:a17:902:f683:b0:2d7:1cee:3682 with SMTP id d9443c01a7336-2df69d1aaa1mr8204935ad.5.1790118155678;
        Tue, 22 Sep 2026 16:02:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm1760745ad.5.2026.09.22.16.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:02:34 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:02:31 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net v2] veth: manage XDP program pointers during channel
 resize
Message-ID: <arMI-9VqZ4_UvcpK@devvm7509.cco0.facebook.com>
References: <20260921231856.1798630-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921231856.1798630-1-kuba@kernel.org>

On 09/21, Jakub Kicinski wrote:
> veth_set_channels() tears down XDP resources for removed RX queues
> without clearing rq->xdp_prog.  If the program is then detached or
> replaced, those queues keep the old pointer after bpf_prog_put().
> A later channel increase can re-enable NAPI and run the freed program.
> 
>   BUG: unable to handle page fault for address: ffffc90000256048
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
>                          include/net/xdp.h:696 drivers/net/veth.c:820)
>   Call Trace:
>    veth_xdp_rcv (drivers/net/veth.c:941)
>    veth_poll (drivers/net/veth.c:986)
>    __napi_poll (net/core/dev.c:7787)
>    net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
