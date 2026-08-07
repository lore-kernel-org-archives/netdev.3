Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAFA381EB7
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095315; cv=none; b=myysVAnLiKJaVYNmSi/EeElWVkuUF2DcIVMqK1GABdkx5cbt7juqjDJezwxKzPTuN/8ugs7HljETi7LIbNPuqqlGjdxDZCzGtFN3QdU2dK46QFfhxJKig72/IWcODKbBAM6A6JRrsFXSdlKBsBm944GCqGaBME4JLuFlekn+JBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095315; c=relaxed/simple;
	bh=FWknEnFGHnb8AusWnqbnQ5ip9N6W/WlkUzLqLBMY3Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLYiYUWWHgCXwgG+gUc233sfNbSZhDZS7JhsOkZzdSM+3fpZAisJglGLplkuys7xo8TPSO8rlfGKkel6n4/+ODW4T1JrGF9tqFh8MI2OyeX++TPu/wwNReSrJECug/ucHXo47wvzwnnA8y/mKBSrTx4qjEvzqAaMjHXfr9Dy7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYTYp4Hn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvbhQngv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYTYp4Hn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvbhQngv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786095312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2q74kqk26zh4EaW1H6VpmpPR31S2jVXMPD6KusRsTmI=;
	b=hYTYp4HnBFPtY/ZApZI5jezqPTiKgg9b8RirkoaKWdRhokvroQ/6+AEE4bFbECAvuOjhYS
	xKJ9c1PE1SB9XO+pZDqCGux2/WRv8SxDMmDX48TtWa0uFSVx84ClHijmBWiCuvHrGuHWuy
	68UZ2s0rpqOjG5JOCLZBujVyDrFdMiw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-6-vLcF_TPnSBCVKIZqpgIQ-1; Fri, 07 Aug 2026 05:35:01 -0400
X-MC-Unique: 6-vLcF_TPnSBCVKIZqpgIQ-1
X-Mimecast-MFC-AGG-ID: 6-vLcF_TPnSBCVKIZqpgIQ_1786095300
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-475e540a0ffso1936692f8f.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786095300; x=1786700100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2q74kqk26zh4EaW1H6VpmpPR31S2jVXMPD6KusRsTmI=;
        b=DvbhQngv68ARjywk3mAL+VKIJGwMl6MWm6uwW9MzVBAadR4yIox2/QDK9OCXyYixa2
         qMUvm9FFL9oMu5O3Hqtkk8blOxktHrOH3K3UzLhajHJ+pqSgPOz3I5+5v0gk61pZLAd2
         bREoaup6hakxYj6PFX4+a3Lz90fEwkYefcaRcas3isOve+0Ao1zx/5JAoikUfw5HvcN2
         7iepOmqQLEzUTQ7Sqr42vaKI4jbL674WTeffNS3SzbYUoG7/nMOofbkcAkbQq0uDjKjd
         vJNxSD2aQQcdEhCJLhegH6SwzdJva+cklIlQYm/NMeqcoW97T4NBLQHwWeS63gHTziYT
         Hirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786095300; x=1786700100;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2q74kqk26zh4EaW1H6VpmpPR31S2jVXMPD6KusRsTmI=;
        b=U352cNgZvBoIkkVti/h2FSCnkziBZIl6s8GGasxwVY/C9+vOVpIKN+2piVVYK2ej11
         YHsPToZkoa6IxVea3i3JWsvN/QAjobVl48AI/vEo8Vl/MupBc9GaMJTozM9AMglwTSYd
         XKhkARK4+wWaWMGdOGovU+6lXTiWvlLHh4Qme2vxf4h+8VTEPiFtYt62yuCanxLqgxhk
         1cJNW7vvnLYH+5ucV7LMnFCkUp9Uc0qDRl2VhP0/YYCSl5/2Ta7B143fzvCZKinH3cxv
         8/N5YqammkSI6xb2ft2YeLSKNPRoN4FliCN94dCitNJUscX+9yqOxCnq51WHb3kIBTB1
         gNHg==
X-Forwarded-Encrypted: i=1; AHgh+Rpo2XDJilQW5fmn6+jrQK4vEZWERG0mFMv6j5ICU98whNGSibFEVUn2jKfTtXLpcvYf+sFtKpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Mk2DKN8N7T2tPv+E4IaES5/wsyxFzY9tqr9PjqvSx1cAD+R/
	+n3NQeNTxZwKU2sK3IbBB827cUhhGucwibVkRJVfWinGcEMBViS15yxQTLjXOihxsmVBw5t3huT
	ZAGT1Ekd6Hvzfco48V/Acud2qujiyO+VXab7ajR9AVtU+RJOUiEdIDimhng==
X-Gm-Gg: AR+sD13wcGNA4Po/0lp3anmc40fw16MtXrRXP7OwyuMuCHndf8wKqz1AUjAcq1LVYtO
	K3vRx0hr60qG31YncB3Nfj8YgpN4OCcZ/zzhso1V2ddTM0qlcX89Ijmi3q/GnsoMWbycn5EhdU2
	4O5U+KJzIPDJUqfXMPDvYeJVV5R9wobEiJrg5Kx956oOACkoE9Vq3VElS3+cm4EphKRiXUbecGz
	h43B4YSng11W3OS8YIKS1hjOj5aT63uX0SVcHOeaia/6Tc4/mJzNXW22TxjqqQwxKGatwRBXT0R
	wMHL1n3xvYUuRJylGNl0reWCM1kTIllR/yhY1VabEKlJ9hgEbs8QMnZ2qwe/7d+d/MDk+O6b0Qo
	=
X-Received: by 2002:a05:6000:1844:b0:47f:9c6f:8844 with SMTP id ffacd0b85a97d-47fec4f8017mr29957796f8f.9.1786095300177;
        Fri, 07 Aug 2026 02:35:00 -0700 (PDT)
X-Received: by 2002:a05:6000:1844:b0:47f:9c6f:8844 with SMTP id ffacd0b85a97d-47fec4f8017mr29957686f8f.9.1786095299619;
        Fri, 07 Aug 2026 02:34:59 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm4651560f8f.18.2026.08.07.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:34:59 -0700 (PDT)
Date: Fri, 7 Aug 2026 11:34:58 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 0/2] Implement mqprio and ets qdisc offload
 in stmmac driver
Message-ID: <anWmwkIqEsOLFKXf@dcaratti.users.ipa.redhat.com>
References: <20260807-stmmac-ets-offload-v2-0-9ac67af92cb8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-stmmac-ets-offload-v2-0-9ac67af92cb8@oss.qualcomm.com>

On Fri, Aug 07, 2026 at 10:41:38AM +0200, Lorenzo Bianconi wrote:
 
> ---
> Changes in v2:
> - Implement strict priority policy in mqprio qdisc offload
> - Restore to dt configured values destroying the qdisc
> - Do not ets offload if there are any queues in avb mode.
> - Re-apply ETS configuration closing/opening the net_device.
> - Link to v1: https://lore.kernel.org/r/20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com

Since SP and DWRR are mutually exclusive on this driver, here it makes
a lot more sense to fix semi-broken mq_prio offload on stmmac, and
let ETS offload DWRR-only setups. For the series:

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

