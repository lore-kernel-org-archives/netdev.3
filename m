Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271130;
	b=fYtQdur6+EI8SGxfP1bU5d25CEkNhfk6hq5pZpSHWlDMnf67C3kdyAfG0PwazDGQ9FvZ
	 BnMfDGXG6iMcCQeLcHz7F42Nqv2Sw9f+vNKLngkfUXSHm+jjef5y34dZgOO5Ff/Nw/7ek
	 lrTVdf/FuO10XQBHLx1saOYd3tPiXI0wUbxc5s5/y1BtyfeAIrqqRXjCYNF6p7n7liLx1
	 zGNWrtrLCVwe6WNz3Tvw46yhs268BFeG4G/JPeAYCdFbH8EBLBPXxO0FZZQLPblZRSbxM
	 gGuGGcLajbf+anvPN64rjE31QnT/PxSL9Kw/o3i7+TYfEtWXmtgFK018DaprcNj71aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YJGyVP59UIBEumPiJG+nyeTNgoOkuxJ2PfWkUy2HMTM=;
	b=b59pvQ/XAUgqi8K8soTBZrP+5B6EmcuqO2/gfAyG1pIvmjxquBBI5U3y2LP0UjAnnkbn
	 8yfIjAKLrJygie+b2F6A4myTCLq+LOWMrL+K6fonPy31fgFmJseFBhPg8a5uYVqL3KIVM
	 qUjBDzrrIhoMp1B+ffANE4UqJeRQ6W3QzJ2lTalRI3BvrHSMLF55vvYUIIrpc4CSaC2a4
	 fG4WIYvo6Ly/sHXKcJaXdcrHlMHDfjx8f1mWCaPf5czUlUeLWdxPcJDULchw7t8dD6bnn
	 eS5oHEkd95F07gpN3C/G6xDgGwOYbn7FSmg2nQ9ZPxrRDdmpliUywowo+6cV3SB2tbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XW1nzIQi;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C5606A33B
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 356C5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XW1nzIQi
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14fc585291cso1762913c88.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271129; x=1793875929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YJGyVP59UIBEumPiJG+nyeTNgoOkuxJ2PfWkUy2HMTM=;
        b=XW1nzIQi4H3OuoU9THImPRKoMX39uKEa2/UmpkhhWUjm7EAeJ3Adb5D6ulc47NdL9y
         PBfxdvqQykobWATR78jKBnTxW2BoqtbN2mlkcu/98Eym8KoX9Hz9i+9GPgdgUdvRx7nh
         Df8q5C3sHVHkDmxTFfIgn/QjWjPSfh098Ib56d6Jt5QRw/nxfTdRBiuaG7Z56rNy7qdV
         /K5qnV+0RaS2HCFdHzNMmxg52y3rkcTCndb9slcH/OoGh/hfK6G/ishCVpFATqOTLX6Z
         T1Bwrs38pdoI/4HR185QyfFDn2AdJQjx8WjZd4396IhKTqfMY05x07rkO2m8F/jHBF/U
         6n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271129; x=1793875929;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJGyVP59UIBEumPiJG+nyeTNgoOkuxJ2PfWkUy2HMTM=;
        b=N0kslWd+3fIsB3BpMzrfOviwEKnvTOGJCcDiKU++648x0VtU/A+ej4K1QgmVGMkVxY
         ASz1D6XNEUEDrXrGj/aPIWuSxExwlKmUXcUv3QUUemK3ZxrQehFqC8gnGwwOFgLf9408
         nd9VGBmD6mXxhWseQedEQ6uzNajZKOaVdMJrjJe3vhcKJ1pAHCkHnP4VlrjpWgjzuAvR
         R+bTq0W9lESmo/49rCZXLVzJ+PJbF90skn1eiNH47UCcSuvPfTXndAsBsOMN/sPjqtnU
         x360451IimwMnqX/4kkdjV6OA3CQIWDx265wcw0VNTo9t35L8oLkuXpafJKfo45UI5Ob
         EMig==
X-Forwarded-Encrypted: i=1; AKwUvBwmbffJ0kcZAadCZOBjqnUGqQxlu3KYkaOOEkGnwUK8OKvC0X52MEIOxYA/0NS2OPvn0YykB/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKM1XHYGjNDP4PoIynmCyZLKKUDMQcUG3kR7qMGUSlaBCQ6xb+q
	lwyULqgqy3sJSmsgwMOdDw/Gf/Xm+nEgfDMWz1ufXVWpI2Ea/ZHOeTJt
X-Gm-Gg: AYBFou3p8O+etMVE6C5zgm8Q/ZQ6qqA1iGAhjUPzBQlxEnc6n/NXWvMwO6bLXQ/bqck
	8/MY0ZnB7x83uPjS3ru1AL84u50Jy6iPFtnPWHDDiE71Q0JQDXM4Pmirz7uQCH5jnICAYmFk1bh
	AH8KwpeJQwvoE62gzDy/9bJPC1B7PLyi0IfsSNZlW8zk6iRl7MkO3KMdZnmsY09h67t36TxH4Ol
	E8a6f7vnkEV0CK7F8S/R9gBHcaEsmnqLNFI5N5+6N0o5peeDioA9UA4W5diG7Ild3PC5rPrrN1F
	RlPyz9LFSodLM41YkCQ34/8cMwwVkbjCFtGL3fvNulRGvs2jRVwKLdyqRTrX60yE1SgDEEsKUh7
	Gj1Rte0ZnZyqEJotZ5/9kA1FaYec9kCl2mGg2Dcye8UHGuJFOxgADpBrZq3+FgitJjzEpd5nyj1
	R4Nd41jpqk0bC6q2cZ4YifAHBFl3ZNo20HNqXM4X5Hnjx/BfJkN+ltURQYXK3fHdiOvRmb++w3w
	OSDds0s0j1GNLyomZEz67Ep6cPceTgOEmnAItPLmGwMGyhiRpLlMb8eKAhyqwkGP/RkWmTJP83j
	LXyqys6IX7ywexTurRzgFEjAYG6O2vmAZoEsN2uKq55LkpxmIIk28V9mnuN+WUwTGQ==
X-Received: by 2002:a05:7022:622:b0:14f:8d59:edcc with SMTP id a92af1059eb24-1a6cd3a116cmr8983973c88.12.1793271129261;
        Thu, 29 Oct 2026 03:52:09 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75fdc1031sm14304398c88.19.2026.10.29.03.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:52:08 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: mani@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qrtr: announce local services again once our HELLO is sent
Date: Thu, 29 Oct 2026 19:52:04 +0900
Message-ID: <20261029105204.2577-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <179303637610.3134.6464335759134048296@kernel.org>
References: <20261022163116.1042-1-26rote@gmail.com> <179303637610.3134.6464335759134048296@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 26 Oct 2026 17:39:36 +0000, Sashiko AI review wrote:
> - [Medium] In net/qrtr/af_qrtr.c, qrtr_hello_work() replays the HELLO
>   once and never retries, so a failed replay is lost for good.

Agreed. In v3 qrtr_hello_work() reschedules itself when the allocation
or qrtr_local_enqueue() fails. Once hello_sent is set it skips our HELLO
and only retries the replay.

> - [Low] In net/qrtr/af_qrtr.c, the new HELLO replay in qrtr_hello_work()
>   is not serialized against qrtr_endpoint_unregister(), so the replayed…

Agreed. v3 queues the replay under ep_lock and only while node->ep is
set. qrtr_endpoint_unregister() clears node->ep under ep_lock before it
queues the BYE, so the replay either comes before the BYE or is not
sent.

https://lore.kernel.org/all/20261029105142.2503-1-26rote@gmail.com/

pw-bot: cr
