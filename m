Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948187;
	b=YJEJKF1WGA+yb/T5pMtAxX4jIpuvWdW58xKaQ9AfRtrcLVAM2DyGbVCKqd+WNrH+E5UB
	 Ib0B6x8UOIhQkwa+1713gMmjQEjxJr5Az/2T8hL81jo2OueqqC0eiI/N8IFH67pSLUiF9
	 wuJPzLSdstHALl3xrbPfqSP8UaLlAlBxIwkCknp8hKlfyfcFmjH1kIdKlTLd2TiANnw2v
	 MG8+8XSksBKofNXN5HOKapb+qsMhp2CjuEGumR1g0B6Nl4PAaMzbreoWhFIsmXekUF9lv
	 fsRVug/D3PR8Y7GPfq5zqBpTNuVXSrhDYaUavqg/zkKWyCsMQEh1pgmYA606S7lyK6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/RbMC/zbd8a4NB8aOmz0dErr/x+blirSIsIsAf7UL6U=;
	b=TIhozB1OTIg86JPAlt2i3T19GO8qnoCLalMsYJz9ffEFOLXTr0UmR1dfHv0kZoMK54/7
	 GpHlAsuk8WzALNFSgRPNjTmHr3d6o7Qg3gAwwpf0ryro+h4nk7eXqqoMHHXyCNplUFXp0
	 UWvf+4sk8SrBmTuXWilhBIrtuNbnbNcScvjSy/UNSEeTt4OEvdFcZ6+GbgWw2XEhbYMFQ
	 BrejJWlVbJeMT5NjLj8S1iWv9DGTEeSRU4/BNI0uUGghza7QXK4W7zglwAEQTOCDFu83O
	 Axg7UlaRrxkZWlmcXYUFTaxFZyaviEnndqHn8Tje/f2yq6uGULIo7cJPMNb1FrPvQYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZCJyYuy;
	arc=none smtp.remote-ip=209.85.214.196
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E0606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 06:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 793E0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZCJyYuy
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ed28bac8d7so1505645ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 22:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793948187; x=1794552987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/RbMC/zbd8a4NB8aOmz0dErr/x+blirSIsIsAf7UL6U=;
        b=IZCJyYuy0zkv7PU3oOnTFueCF7jtKKjd8XuSGWI6NuPApPzbm3KQ+pWuWd4pt3QU/M
         mC/ve/a73EHjs2xFUgnI/rXBFfVUhvTyfZlp8ijHBmWamPQr50cO7geY67pwklfGxryk
         ts+YLNpTutUGC3aEECdUkX6LsicpMVLeSQYbvQRMN0h0+Js3+RDblz6PyfZ25Vc4Anp7
         sjADYFWLu8wOWa2otSKd/HBH5j3I08eB8lvcL9p1a8mTpXL5OW2oc4xIeBZeakEMiaAd
         FTGuN17FqOwlS9EBFujAwjj7IUvKd4XPvYboS4ucjrH3jvAs2xV5vbCUEbcvhmAg2sDi
         2Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948187; x=1794552987;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RbMC/zbd8a4NB8aOmz0dErr/x+blirSIsIsAf7UL6U=;
        b=YZfIw4igjj5uPQJpY9zjMfxF/LxGe9SkXxa9VXMuvrSqxoPlZ3j/KrpKtOA5zhkuhP
         xFnBKmZF01ZgTtM0mb7CpLkSjSCISMglVSU5wpjrrK2ssjTTBZdzFpBDaXntCc6Qd49z
         X+v0rbJycBZYtM9yB6b62CjyKwqe+KjOgr/FQpaibrlThnLJZFUri6Itn7y+xi1cUB1D
         bwhIIqClmV1DRaGAQbs2zyFoOkzF+2jdF1ubQTnQuuZ2bYjyhWIHvgeRDDlxAgDQvBs+
         vNf5bKQKP9ixPjCcmnr9SzbF/N9c520ROQTvAFAVnFAIsUigcRqcI1OBDiD73R6AYg0q
         2G9Q==
X-Forwarded-Encrypted: i=1; AL+hErEr04zCkCtX+N9dPU6Xmgm/TiorRoZVIyDIs/TCauhLUJGRd1AYW+c/b04Me8nmmVZYQ27KTsI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1IotHCmfY2TU6xArnTHlqUvw1jUEJajnVSlzIqEwhMZMdeUyi
	ZZyFyHSklbOsctzN+09xC8enRvrDnzni1XrWJTTsvmyLsGjsN59hvgij
X-Gm-Gg: AYBFou1tEXODtxrZOq5YzSud/dwJeAcOr9FZsT6m+J3jfjAyDs/ZslE5qtPnaU5LSPR
	88QvGFywewCMfZgaMBPWWs4pwQPmIBxgxu+nzB0XFv+aJ2grHUzQlebrsiUxuelmwD/SujKXChd
	7xVBx3XvPfqDzzlJkBcDa+7y7npSA1ARFmzkHTt9gu7Xv5LHjFUgTIlZRarcXwastn3y3VLau0B
	xjHNAH0F1jOhTB7/1zZ5PXy29CCARtC1JwaBd5PbXSD9Sdk790/JfRjmBh6Dfbjd4N5c/jhP+wW
	y+hkfAuzz4gB1RTZ0IkHEGOtReNyIq1GtVmTcaVEKTVC3K4R/4U/gC6i3WD6DPEuvGRD4tVlxgR
	9y5mSn1vWDqQc+Ie7ot2mrpvws9wiAoxNzExSjtXNE1BSG2Z3x94bGWOl87o578D/ov4rM5JTLS
	kAVEPOj+hsCAgqylCYcENz12uVVKKJczAIGIoMScA7moofk0HJb9rLd95hHCZ2/AZRpZZkBQFEk
	P8BP3z/o/j8RXIXWoKNODKblQQiV2R2b66U1G1WSf4PDfnV4VWRN3wfU78WrIvS5afIgv8hpXNc
	sVMzFwxjltI+cHjC9M3IX2IzbQ1EMHwIOl9hqzzb+Z/FxltD9Q==
X-Received: by 2002:a17:903:3888:b0:2e4:ade3:7290 with SMTP id d9443c01a7336-2ed244dd595mr38676575ad.30.1793948186681;
        Thu, 05 Nov 2026 22:56:26 -0800 (PST)
Received: from LAPTOP-QJLDGQ2L.localdomain ([112.224.143.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47528760sm2338635ad.8.2026.11.05.22.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 22:56:24 -0800 (PST)
From: Boyan Liu <yymhvert@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+98d7de09cd94fec5@bugs.sh,
	co+cdeaa2edb6897680@bugs.sh
Subject: Re: [PATCH net v3] seg6: Fix unset mac header in SRv6 End.DT VRF decapsulation
Date: Fri,  6 Nov 2026 14:56:07 +0800
Message-ID: <20261106065607.3372-1-yymhvert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024015811.a995b7cab417cac2f41689de@uniroma2.it>
References: <20261021024738.17266-1-yymhvert@gmail.com> <20261024015811.a995b7cab417cac2f41689de@uniroma2.it>
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

Hi Andrea,

It has been about two weeks since you mentioned that you were
looking into the NFQUEUE case.

My understanding is that NFQUEUE is the remaining open question
for v3. Did you get a chance to check it? Should I prepare a v4
to address that case, or is the current approach acceptable?

Thanks,
Boyan
