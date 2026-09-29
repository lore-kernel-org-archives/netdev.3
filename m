Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992B2B9B7
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691129; cv=none; b=anuZmvKCvQUppHDACS1azggYrA2Zlw2vLLdqFyG7vWbXwriHPdtyoUilBBV0MkXaKhfP3KhO5GsXB3EoGOB0jN2n9fSBoAcwpMb5kiDib7ud7d6ncfSrwC9lMyZgxAYAloQFYr0i4d0MHbTP5Nj0f4+bqlMa7sNUkRHpM/pL6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691129; c=relaxed/simple;
	bh=GeatX/mSgt8EYGKrJweaQ6M1vHW/l+J78fDDVRnanZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G0hC+vI2K6UbGm8+1PajY9bxr7Nrf7u574GhB47Bb+6MuY4tWvr6X94dxDAOsxG3y63NmMHbtLx+B5Dht+hUGV1rFND0E5n1MEDJKF2qPfH5KhQqG+H7JmJuzjeibIh8Z3q5rwI2dGwl+3/1/pIWbUCXoIbM1rjM+evGeEoPcys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tn5bU1Be; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkfMBEbQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tn5bU1Be";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkfMBEbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790691127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2p0mpabVoWXtlpkN0tOfNpGONGhlkPF/zvbxue/ki/k=;
	b=Tn5bU1BeiPisUTcUA3452F2MrcYVAbayNC+yFntxW75PELjWC5aOsyZPjAl9sHgm6Immlc
	Sxzkkta3bhuyRZCsRURIcopUPH1iRwy8soUzZf2QdkFVDrCla7GHaBWcZGjUecAMM0AKHL
	u3brMMZw71Tp/m8MrxbyJOSGzsXEZk0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-4R7sEYA2Pue6JM9cYaajIw-1; Tue, 29 Sep 2026 10:12:05 -0400
X-MC-Unique: 4R7sEYA2Pue6JM9cYaajIw-1
X-Mimecast-MFC-AGG-ID: 4R7sEYA2Pue6JM9cYaajIw_1790691124
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6683d48fso46150815e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790691124; x=1791295924; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2p0mpabVoWXtlpkN0tOfNpGONGhlkPF/zvbxue/ki/k=;
        b=YkfMBEbQrf6BdVVZ4feI8A8i1jiQcRaDPObyAwKTaohvmnqhJuEGI4l5b6hCIc8kI0
         fSZwUG9pt6ZWozcGsMRzp3miSNlImyiNI+Hr90r2i5+OhZStUw2ZDyw3RFbsjAGknsFn
         08YpOn6FkgE/SVxDbnfMHCNJpvK13LBq0mGx3jK1ZJ8Nm4QeVw4nEa/1QEaIcrfz82kq
         ayPmfulXTMcCEyeLVTx5FY4ubhrIxFFFpivchcIlWf4pAc5dODTppJUq8Kl+THtUNjBb
         hFyLei3EekM/SiWPqZO/SS/eJD3T71TOA7Q2m4fMKY0DezU6XBzImdwOdCDfwaiQUJHJ
         VXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790691124; x=1791295924;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2p0mpabVoWXtlpkN0tOfNpGONGhlkPF/zvbxue/ki/k=;
        b=Yf83A3FsZsILrl4tGcT7W/oG8EiYmvyGeA205ryL/FCcq7Q2UCLtnpbORQvG+UXSSw
         UdBCMqd68jDn6jPxeHiLQSt8DTzE9gkGio4yV4QmVhOBdDnHoKP6rkzMY8aqQG/7ysAj
         ME4S4C6aYH4i1ToSIjXdjnnVUeuIxePyHIHrvxIqFEZhPNaukLx+2l0sKeHhGHl739tn
         6XDnZkIy7vJQQMPo+nsu1kfzqcDWswmslpjiS0wbJLURrSPCAsn4WAzfvN3GmG3aO8op
         hps7SbMmDG4TcV/JBZZXscD2rfHzN/20YOb1yZTBv81s0KR4GpKZGfVRD5TXg2st60mY
         Fvnw==
X-Forwarded-Encrypted: i=1; AKwUvBxRNa8n899qejWzS9KRBJ/LTVhROCmQM6y9+PPXn9RR1tKoNoSzhItTKZrMpnsV3x8Jr4sqkME=@vger.kernel.org
X-Gm-Message-State: AFuF++meOKPoG1Ah89Tf5okNiKEw557FgICrwwgBIVNuiWiBBn9yuRNo
	MENlT9GUhy5eGZxVcoMq2t5kVgZBQ2hXAI1IQTMeQxiOl6CQp6QlcHaBM4t4Uif4/8a+XrTaiZG
	NTnEiMBCTfZI0mLmoqGrzvlGYu62sApESKjwV8knXonMETdsC9oOTM9zmpA==
X-Gm-Gg: AYBFou1vu37Gs70GlWdROzYuve6c8+Ynm5tKnfGQDvAyLyNXvIIBU0N/NkIRIRzCJ6J
	sSVBN3zpF0h/UOMxu00K7G5RCdtqVapgvEfctsyd3qb370O2kF6J21cnyQUHtRYISqd5fJnZ6lW
	InZlJ8p/pSQr5H3wnwMqkTUUxwNwbuTsSRpMQ8dR51gkUSFiOuZ7dTEtoO/TSObPCnV0HurHyBt
	M79i3QQ2A6N/vZalxlWzgijuKD/JqmTBLNFhmmFvo9hxO/voqOt/bue6G/ZSJr0zQ0rlJqLGK72
	aWneN64uj+3u+sfri9RFmgCKLpsbQ6lw1NjXnvqyzyyNXjh067iGuWILufjYOHUfy8032lPmkzL
	qDBGyTX++5umHYAuV2DKs/AKKDscSUGo=
X-Received: by 2002:a05:600c:46cc:b0:4a0:857:a3a5 with SMTP id 5b1f17b1804b1-4a00857a46amr82578645e9.16.1790691123709;
        Tue, 29 Sep 2026 07:12:03 -0700 (PDT)
X-Received: by 2002:a05:600c:46cc:b0:4a0:857:a3a5 with SMTP id 5b1f17b1804b1-4a00857a46amr82578175e9.16.1790691123350;
        Tue, 29 Sep 2026 07:12:03 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([24.151.142.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013c64fecsm6760665e9.0.2026.09.29.07.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:12:01 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  kernel@xen0n.name,  chenhuacai@kernel.org,  tsbogend@alpha.franken.de,
  deller@gmx.de,  razor@blackwall.org,  idosch@nvidia.com,
  ardb@kernel.org,  tim.bird@sony.com,  loongarch@lists.linux.dev,
  linux-mips@vger.kernel.org,  linux-parisc@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: drop unused LLC-related includes
In-Reply-To: <20260928190800.2521749-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 28 Sep 2026 12:08:00 -0700")
References: <20260928190800.2521749-1-kuba@kernel.org>
	<20260928190800.2521749-4-kuba@kernel.org>
Date: Tue, 29 Sep 2026 10:11:53 -0400
Message-ID: <f7tpkxw405y.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The bridge and the openvswitch code include <net/llc.h>,
> <net/llc_pdu.h> and <linux/llc.h> without using anything out of them.
> parse_ethertype() is the one exception: it wants LLC_SAP_SNAP, which
> comes from the uAPI header <linux/llc.h> pulls in, so flow.c keeps
> that one. The LLC core has leftovers of its own - slab, string,
> interrupt and net_namespace - which it has not used in a long time.
>
> None of this is new, the type 2 removal has just shrunk the LLC
> headers enough to make it easy to see.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

The openvswitch changes look fine to me.  I guess it's just a minimal
header adjustment so:

Acked-by: Aaron Conole <aconole@redhat.com>

NOTE: I didn't review anything else in the series.

