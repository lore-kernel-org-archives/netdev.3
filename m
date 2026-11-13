Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607763;
	b=jK0NaOUGz4mm7DaqKFt0ATkM28s5aFP/AZe87Un6vj8MEwtmu6OMAQ1L2cEVeFTRKMb/
	 /VTOe/8gobuUjvdnKmNlXeKqPUy7UDHeTGXkblmOTWwr95kTCo8/5m5NN6bSWZtHf7nfq
	 qvioGKPGxngGYj9OWzy6PEFYkNO0we9tCl740Mb4S/bP/Il3tq0+eNpekgvaVCKDkXQHC
	 2jOe+2i1MZPPjeoJ54LbcC0Q7DvrWtA/L+LfmDKqozWKJvmlxyYZuj27Nl5PgOd6LjflM
	 rFhO2MTctGKCsPK8h3cThUAfMAioSDyfpVKad7YITEFFlQcv56Y3RKu8lZa1ySRcS1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=eAX2A50EYtJkcTfS6TxnLukDj/BxU0JA6j0fOn1wRUc=;
	b=yDou2fl75YOem13ssNRgaFuBSr0DRHyuJlzw2oriVONz0oiQiZy5IjLr4Fx6EHEFn9Fn
	 PdA/WYZpqztYa9o0uVRTPWwUGPsS6n9Hlt7FtJiYcjY2XrhShfLFFvN1RrAoW49tqPAsQ
	 elADnpkvxsxbe4nLpFaEB97H50du+qL0dzEQGIlWYAc3j9fB7AV7rFtxaw2U2ur/XttnX
	 nRecv3MMQV6BYLaeB6aQIAPiE67aAlx0F5xAzU6pluH8k/NtdHlm73z8jEUnIMnT/qQuU
	 PyCyToNZPcTFuhKDAFVHPodFjz/Jg9KwDsfM1GH8vTN5JPKG1y0SacS+cRH9f8hRiSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zpg9buxU;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C95606A332
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 22:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C95606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zpg9buxU
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso8249255e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794607761; x=1795212561; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eAX2A50EYtJkcTfS6TxnLukDj/BxU0JA6j0fOn1wRUc=;
        b=Zpg9buxU1o9Z00Kb2GMN6SokzoV0WckspdEtudVGjsdPuxxztrLFHlgFEK4077S1LF
         ccK+FcYkH7eame7BwYSCSrZ+SgmKHGC/3iNuq7d9gn9wKxrxIW+a7SnzDJqBQlQhX0So
         CeQ12FKEM8mxDAXAMrkcl+d6nxHoJ5uY1T6LOVMUs4w+NkhZb+staBSHcC2nq8dIyQu4
         j0K2apJ6A4pXs5/IbwuijNV8E7saOQp4Olm4ydtRDqFS+YzxUX2WjzoVyR3Pi8IfAyi6
         o3C0r3dg6abjkmbW4hePM3Oao+mR9cDm00xLf5mesAGxXVA9XQBev+D7OZN9Gwh5XwlR
         nA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607761; x=1795212561;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAX2A50EYtJkcTfS6TxnLukDj/BxU0JA6j0fOn1wRUc=;
        b=w3mESPiQbU57Vfy4t8nZH0GIv4i5u/l7KFe0F4t5d/q2i6YySiqI1UYcv0KDqfeBp+
         YYeMNb40Ph21RFGM/68wbe7j+uTRMUomJAOPJSip9p6Cfa3VTjZ7+g7G9LjQUdLvglGS
         Dg6GkWvDkxLQG+g0t6l6NCtpQd8T+KQ+r2LKHN1g2qG3acLnBef4hZhZ/ks0kL9eVoi5
         s8p/fiU1TwX/IwOjHgP7AwU6WipmFMAHVnH2t8K8EqZw9nSw/nsblIpq0zqCG/TJg5VA
         6VgH8j6xwjZ/2bBarzI02jbW8McNb40VgQIBw1nll3txy2Evq9lx3jEoQQ9kZcMubsV7
         Httg==
X-Forwarded-Encrypted: i=1; AL+hErF6WoGXK7MNxcreTRXTKH8WO4oYlzfnOgQRl+D0+QASVcTduzF2QrGI50ke6R8/L+SPOuAY40k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LCSGzK3NgFEot/b4i36/K59kAGLBQcsRSiVrrlwUj96MXfF4Y
	3B1LuR9RQrccsfbcngLDAYFPVjr+55C3VMID4/zfsVDL82WeLEp6CbM=
X-Gm-Gg: AYBFou0f+hm6z+NAVrTVh/odAUBmxISP546EL66A8yF6vuKSrfK2aFRPIQGFuHbtT2a
	gov9OUg14Q5+JEsqUSiqRK/ZLATk0/Wn0X/uVGPt25Hn7bbnsqRgl2kn4OQfkf4VhAw5SLrYZ+m
	YS/MlGUzSS6OS5QzG3ftfsPxv/Uz7B+qE15744cKjclfIbepWySyxpF7G9R3w4inMSbxpRTDO6+
	Xa1oPABEXXnowqoL6ml7NFexkSKoScF2VN8MGHUCpn/ZPYyC00CrrLfegnloCbA1yYDWBO7PAXs
	TAkomDM6lKIbg7BjWro74cXBGDpNladnTuZMPgfopEDgc3cON6TSLoeHLHsWd22yzEsZeL8NvGM
	2gc9cCNrPMKY1yD9oMli0LvOH9JigI4SQh6GkU7t/ua+LXMmrTn0Vnx6LtaKvzYRA019qdCnCSt
	2yYho+378WdbB9wNzuavQPgF0/UzAM3lRedIeo+SKbsV+YCnd1XmEBsoNOxa12KBr9YmT+gh9sE
	6iAakE2NAUd2zbaB67BxeZHQ/rRmrGMceoT9v8QORgDKQ70zYQm4eZhX635LWlhROXk4fo=
X-Received: by 2002:a05:600c:8b8c:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4bb609ae053mr20773075e9.7.1794607761393;
        Fri, 13 Nov 2026 14:09:21 -0800 (PST)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae5299sm102617785e9.11.2026.11.13.14.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:09:21 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 brauner@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_flow: pin file with get_file_rcu
 before reading f_cred
Date: Fri, 13 Nov 2026 22:09:20 -0000
Message-ID: <179460776060.2603197.3619232752332382972@gmail.com>
In-Reply-To: <179441146372.2168702.5462633106767625518@kernel.org>
References: <20261111153106.580776-1-tristmd@gmail.com>
 <179441146372.2168702.5462633106767625518@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

These were found by manual code inspection. After commit 0ede61d8589cc
("file: convert to SLAB_TYPESAFE_BY_RCU"), I audited callers that read
file->f_cred under RCU without pinning the file with get_file_rcu().

The issue has not been triggered in practice. It is a theoretical race
where a struct file slab slot is freed and reused while netfilter code
still reads f_cred through the old pointer, but the race window is
narrow (a few loads in softirq context).

The same bug class was independently confirmed and fixed in eventpoll
(commits a10fbbe74e1c7, 0d8cd9537c641 in v7.3), which validates that
SLAB_TYPESAFE_BY_RCU file reuse is a real concern for unpinned readers.

Thanks,
Tristan
