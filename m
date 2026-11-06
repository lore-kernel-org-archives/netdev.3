Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982436;
	b=hjryKvDwxNj94VnTH1cKlkaHs7FF6+crQwJbsGGy+aF3VyO+Q601WBQY+Q+iXz90LgW0
	 /ZU8kWgAbbtYCq21XcMRa8J9pq/7ecEobIIoWnS1Qv3kb8ccCgdnm/FLkTh+SYtsbSalY
	 jz8wpzqjhi5rcZ+8luhdaeZsYKukz+iGjjZ4fyGoJab4A0aieQ44at7K5l0EHFHDhrKrq
	 UU1cbVOoM36+mwRxk3T6eUxcvBpV6Onjw3mquYQ+yRZkZw5hUhN7Y0sscEP4X1Vlh0aa6
	 /BTHSamnIDlWhTIFjZ09nrhufWMTDCFMd8csB0pz893Mse41YbYSXUXup3coX0uS4CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4C6y5xy1IYIh608izqXS5vbmigEiY4V6zQ4vIzO8m1E=;
	b=N7Z7O8Bg1aItkW9Bq4wkDZNpyMJxCKKtxNzZUsk840VXDjg7fpa3JQBWl38GyN/5v545
	 sydrTH5wQu9aIzcXKjRTEta/u6nvhya1VZMntJf9qgNO1UDtgldf0VS8dcH9QKf4uDeoD
	 4mWGUWQg+Ha/1GRNufBc/yhbm2xon4toBr8JesYGiN8fe57NYFbFVEGjQjklNS7KrQhef
	 Njigl7GCv1zAgZkUwSJN04xRFXuqmrkRJ5CejR/MsJaM0++ekIyn4KYe5uWhWd86KvIru
	 Rf/EL6VBvF51QYbnxP3Mg1IljslLFt6+hI4Pik3N2OQW6dCLnxV/kzZlvwe2ff4R68Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KZBQllmO;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAC606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1EAC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KZBQllmO
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d06763335aso279574137.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982435; x=1794587235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4C6y5xy1IYIh608izqXS5vbmigEiY4V6zQ4vIzO8m1E=;
        b=KZBQllmO21Yxtxz5zfo+UJDJRMZp11TI1KQGleYolKnWFsZsT0gyxo1u6BwGMg/rfK
         cKHvt+NQE7sWOEnZcZF0bOVFwrqHb52wQ3284jNObhLyn4+BVLhGrm6SZURa2tqKiOSL
         jmGu/pVT0I6H8ssP2S8RZoyFhTHpRzuoPe9mW17Ef2KbxDr8CT27yYGS6thXMshED3iP
         Jwpb3tlzshvHhz/a/ahy5KanD+ZoVFO3Er4zYdjiGeizCfPbrTHIWJNTNagnQveVoGU4
         a2vFTCMeU/URNS45EuFHSkLx/9NaxUwcuXF75tH2UVGKfYp6oSTL26j2oL/W3FNgq3mu
         wolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982435; x=1794587235;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4C6y5xy1IYIh608izqXS5vbmigEiY4V6zQ4vIzO8m1E=;
        b=cZ7HG9gHax5ZNtNjGHI+yDCu3fcLGaQT6dfd6gLopWSzFDftDxu74x9ra9mSLfZAco
         wT2xr74Pt1A1jFIa9BsiczoPcgbMGKDPXIeJuyH6gDyr9QcgAiGyPAd2pALcExHVWeS7
         KRDEoTeowKIwIAfQ74HkdiRAwjjlJVKbCGaCCCcPlfG7PgMOAxnADGSoktcd6F9jzSS3
         cv4vu8L7Z0tX4uKx5nzXVV4IO1bnZZ5QuYsJMSgv8IEPmFCjq1xy+1tAfkTIgax/0E78
         6wU2a6C7WS48X15+P6psmv3bONu9A8kPT0V4nQ0zpK+DMMW20tX0+Xug4TxXFGB56Q7p
         n1sA==
X-Forwarded-Encrypted: i=1; AKwUvBy+A2291T4Q5wUrdQG63whAWP78yxsu0QrKr9lPiZPq4WpUEqZq4HOg1MX/68k3TuVfOIk4v54=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uyg8fu3Q+DWQ0XAZpVNxkO0r8c2YRvM0dgZ8Ux1HzoE1c1ZJl
	naMWO6XKuCa+V7hsr+xKfh62iYs9gxdmUVCTCJgDMkb9yVgEqiZKwFFl
X-Gm-Gg: AYBFou2Cd6ZHpjwhuDJv4MoiVxV8Ob9TfiatxuPzvVtgumfJPpLPRSI7ZJ8Dl6ycmn6
	jZasXHGK8vYEA97rV9WHvzGQD2nwJzzyEjDA9rlCQz7bq4RFrJ0WeVNjtTrJ3ST9mOcaRhawl+Q
	6k2TLkVYw9Opjbar5Mp5dPPT0sLNMkdD3ZnjuGpjm/RGkQd3MMWQYAoMKA2XvQ7/Q559eihETNo
	mtNGs/4ULJc8UoAk39sn2s1i5JsvwdAY6lCTx8Kh74SyslzoJq/hwQo/7Ka6eDDDowTfY0SAbe8
	EGKil8qAIVeecbNCgSn+hf9muKxK+/8KWSJaUwWnfe00dfDV/HpoOvhDo5H/JW+pf632UXKcjjP
	MiiWN1fC3zT/5Fs6VdlHyskCvdJAVq20MmeGyA8l/JksUsSz2xdMbn2MevfRCNCh+yIJNHi8kqn
	at8OqBNjjBaRk4Lr8IvxC58BLVOaGpuFm1SAyrsx+T2vL9sqInn2u/4Wl42DIdJQalYNyIzibub
	QWt0hfks1M9Hx1B/bhI1BrRdOadjBm5wlZYekez+0vfBh9Rfo8EhQIyAbnYSPoDYuAZCSlWYrn8
	XOJGxP64gNeb205bzbG/DSYbW60MoR29hZt08z0xfOgtEwjwCY6WFzgfBiLBEm5pkMtn/+l6h+Q
	j2JIDK+0ta16oNb5MVmVZeqitpxviHaLu6fg6WUygUeBT3acegVpBxyXcpMRIev0YznIIo3Q=
X-Received: by 2002:a05:6102:f11:b0:7d2:8cb8:dbea with SMTP id ada2fe7eead31-7d2a16a52d7mr1445747137.36.1793982434779;
        Fri, 06 Nov 2026 08:27:14 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a8b52ca9sm1476808137.9.2026.11.06.08.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:27:14 -0800 (PST)
Date: Fri, 06 Nov 2026 11:27:13 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Umang Pokhriyal <umangpokhriyall@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org, 
 Umang Pokhriyal <umangpokhriyall@gmail.com>
Message-ID: <willemdebruijn.kernel.388036bf83dca@gmail.com>
In-Reply-To: <20261104174240.138491-1-umangpokhriyall@gmail.com>
References: <20261104174240.138491-1-umangpokhriyall@gmail.com>
Subject: Re: [PATCH net] tun: delete the flow entries of the moved queue on
 detach
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Umang Pokhriyal wrote:
> When a queue is detached, __tun_detach() moves the last queue into the
> freed slot and decrements tun->numqueues. The flow entries that point at
> the old index of the moved queue, now tun->numqueues, are meant to be
> deleted, but the call passes tun->numqueues + 1, an index that never
> exists, so nothing is deleted.
> 
> Until those entries are refreshed by a write on their flow or age out,
> tun_automq_select_queue() returns an index past the last queue, and
> netdev_core_pick_tx() sends every such flow to queue 0 and warns:
> 
>   tapq0 selects TX queue 3, but real number of TX queues is 3
> 
> Found with an LLM while testing how a VMM detaches tap queues when a
> guest lowers its virtio-net queue pairs. With four queues, 30 flows
> learned on queue 3 and queue 1 detached, all 30 went to queue 0 with the
> warning; with this patch they are spread by hash and no warning is
> printed (3 runs each, in a guest booted on net).
> 
> Pass tun->numqueues.
> 
> Fixes: 96442e42429e ("tuntap: choose the txq based on rxq")
> Signed-off-by: Umang Pokhriyal <umangpokhriyall@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
