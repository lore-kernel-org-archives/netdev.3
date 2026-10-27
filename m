Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101791;
	b=iN8sCTSRR9KtvqW/n0OYAxLszT9sBEfZ7QmdlkKOUVL5P0ZnjztcL/BWhLL01iT0wHdn
	 EnKyeCSZRiTSKq1dD+3h80gD4k1o0uAReS/o/L7/jZiaaTCjncC5Yj6eNBP0VGgKtD1wc
	 v1bYyvcx1V+5s+0XhbdPwTLIPo4valt/Zv+JPWXvMzPVujbWu51JQ3gL/bb8N3Xd5KaW4
	 XJWoVSu0uLVNC8YxDsH0trf7zyiEpFFOR3Hf9v/C0ArWp+SysRhPA5lyU5lH7UAokwVSJ
	 i2hPmGC2pqdZFClhqlXslEZXP9sg9VqHUjuar/T95I/bFkXLljcWcTCoUhbmuw7vhYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101791;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Toy1KB2l9TskJSYparsyEzIH0pnl+RyxkKZ4uTyQvZE=;
	b=FUD0iNWTka+GVHUD0GONUb8pm2+Wnal3goGU6PyFO1f81n2HFCxa1hyb35CRIaAcDqtE
	 CK70Ba5oOzN0sqSAFL8ZjaJpyzt0Grt5MIGRAZAbpPpglD3qsngNOEP3GNgBctihmHr8H
	 inrGtXupLz09QdcYOIGD7Q3q2k+bmTe5ps1hMpYgz6QyGwG2MJ/x5wUkhJ8m/3X1vz9xH
	 8g7Zdf7vJtS0K42i8YmXK+HxHB2EcS/P13KeOX0JRx+HlZRgl/nl5tgUMzourb7f/yhcO
	 qUqAIREe+H9DKmcGP++3e7//dAljtVPk4VytvWTQZeBErIQLnSSXIqOTQALMj6zFm+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CoPkQ77y;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B4hfE8EH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E5606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E77E5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CoPkQ77y;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B4hfE8EH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793101789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Toy1KB2l9TskJSYparsyEzIH0pnl+RyxkKZ4uTyQvZE=;
	b=CoPkQ77yJWHZezpTcHIG1Hng71GyQLKJBcMdJ+HiuGmjiMX2DbfrNOPnNXFNu/jkIxvW+t
	RDWm3ik2cyuLuzITZRJuVo4P3bNL5IZRuvwaOhJL1jB+HpKQsUfUbegdVn1oGFYxT0oCFT
	oqzc2WY2Uj75FypIvmLASbBasAt9OPE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-lCetBGMpNGaKqjCq_oNA9g-1; Tue, 27 Oct 2026 07:49:48 -0400
X-MC-Unique: lCetBGMpNGaKqjCq_oNA9g-1
X-Mimecast-MFC-AGG-ID: lCetBGMpNGaKqjCq_oNA9g_1793101787
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso2904372f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793101787; x=1793706587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Toy1KB2l9TskJSYparsyEzIH0pnl+RyxkKZ4uTyQvZE=;
        b=B4hfE8EH0wkRUhkNpP27oYtpTVWt/gDNXnEp983VhEtbH5Xm3IM88VENP646FWin8U
         D2NpkuPgjoqFEw3jqs0Izrvzs63Z6jsmMHpulh9afv0fyeQJijOpyFhJhwQ3cNqKh4dp
         6tQOVxUeYMLAn2EEReC9ke3bU9vszuht85Epsv/GwCreeRKbRH69as41+RpMgThoUxQV
         bdAWHObUv82gtHDNPLrqhMytIPZr9EZeX6lRMbU19h8Xo9AlEXMqjRy82gdcsR0lpCde
         ATBSHXuXJGYSqkZ1RaRAB6UanCagX+3bqSc3XU1WINKkyOPRVY1ZZifuc154T20Tq+nu
         FENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101787; x=1793706587;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Toy1KB2l9TskJSYparsyEzIH0pnl+RyxkKZ4uTyQvZE=;
        b=gz6gViiNknah0M/4r17ONXn2vQpYEt9ByhpVR0gMEFOC+c8ZKyMBv3OhovTa5YOerk
         E/chesYmu2lyQsKlexwkBINI+U8yBNoPABz7bZLRgHZPIzYZVLvVwZa4Xc48tQ4QfLiA
         nmri01se7i7x77HFFqS760y6CutNsgg6v/9IPyVU+5pI8QUBhHDgs+WmWZKZsjIetj1K
         IKlzh2jEzIopI1hY9q19FLbDtnc1JwokeXY0I/Q/2dSS0hEKFNWy/tbKqmxxvg2BWHFi
         5+9NjN21VEtfVICFGycYPoP1xiU26yCKQWogGOWAvzxPCvK8HawpFdqWJV709gpEsaUR
         R10g==
X-Forwarded-Encrypted: i=1; AKwUvBzXvGRXBxVUkC1uMTUnEXG02suam9bPbzIJqvkqllumMefO7AmiCuQeHHSpzFzB/rYebWR8xyQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYISOlEoteWydzujxfWUoODqDOHx1CfuqdHgpq6kgXLk2c2X77sA
	/nXdn9M+PAp5X+Z75oGdOUaPOaIk0qr9JkI/Ra3wVHSLEkt5CGk9IuMqxnHGj/mlLtsCvbWHxH/
	bBDhFrv5yuqGCH0kPW2EsN6CpSiVqZ00UnMqJYkpzgv5WaaIxb+yzSWfVTQ==
X-Gm-Gg: AYBFou1mVWe9M/K64f07qALClmgqgBQeRlxHx5llly7nQ8mvLambX+KAhNzWCVSekp1
	YxPiXb3C00AW9QM/DhZRIxmMfbnCRLkGKzaEosuyhTMPTUk8YQszLv8KWrOAtPUVDSF4MsecBvd
	6SZN63eIcb0C+VHaOJM6VBBhC1oKIUVD2UHHG4WQkXgSmTrzQ9QxR5wRB8hf/yfd1tp74idqrKZ
	pti+sXCuu5d39x/RNwX/QI5gpJc/SU5LHnAaZtxwnkXzwP/GU6xkvGG1fLVkTLhGg+lXVCyFnR3
	mY/FfEjZKdigHzqDk5g3TcevOZxSiGvP+HDAHqBCsY/9jEsGECGAOf4+BduawMyB24Zgw3QXpjC
	vd+QfsaFuUg6FdT649V9SQzawkLbPEeAR8oUsrNsyCNyfArpteOzOCcLVkOvQa2dYyhQpamM/UQ
	==
X-Received: by 2002:adf:e00e:0:20b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-48e3eb75a46mr12581585f8f.10.1793101787241;
        Tue, 27 Oct 2026 04:49:47 -0700 (PDT)
X-Received: by 2002:adf:e00e:0:20b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-48e3eb75a46mr12581524f8f.10.1793101786725;
        Tue, 27 Oct 2026 04:49:46 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece14a1sm23040422f8f.57.2026.10.27.04.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 04:49:46 -0700 (PDT)
Message-ID: <cf0a87b7-1039-4688-85eb-9efc8a25dfe5@redhat.com>
Date: Tue, 27 Oct 2026 12:49:44 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] octeontx2-pf: fix skb use-after-free with ipsec
 crypto offload
To: netdev-bot+sashiko@kernel.org, nb@tipi-net.de
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261022-nb-otx2-xfrm-unshare-net-v2-1-5590c9325bcd@tipi-net.de>
 <179296218017.3134.5170259489302207876@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179296218017.3134.5170259489302207876@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 22:03, netdev-bot+sashiko@kernel.org wrote:
> - [High] The fix only partly covers its target.

I've mixed feeling WRT the above points; it's (borderline) pre-existing,
but it's IMHO bad enought that should be addressed in the same fix.
Thoughts?

/P

