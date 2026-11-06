Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008302;
	b=O6H+YDEQbPULUYdEfwGMla2tobp4y6r7CuE/XKwr1gLdqVscrmpWjqcVLimfL6Be8nN3
	 BwhPCB3KvCmHyDAQdiXvlK8OxDqNSKzSLV/xBizGrgoQoZxGhPQ62iYrXkThjDUfzz8XG
	 mC/mkQGpR1HJybaeUnrXd4xTyExfT1yKwtc6rYWke9tjNFP6zFTPrNob8IW2zmkMKyT2r
	 OIYnVyNySv3kfyIXXiw2AW4glAGCh5u+Th/KG9ulaAuf+fd2v1CaX8zFQIiG0vrh/A3+A
	 6iFPju+yLtlEJZcLjKAe9UH1cVQqcRjxGyHPOj5YkJXUSCa7vLotdS5xcq6NvXt87dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N4DPvPiEv18XL9E0HU5NSnRDXM9pLl3JEb1r3sKAKNM=;
	b=hKIOBS9O+7meERttjCWCmEjeqwj+d0W0GEC1YCVZ1zRUTZZfjQ2DUtiTzsKZy309Jg+v
	 L4HgtdKNLccxTCT6eBKwBh61siDWatqAbtiF5OxvQbKpPNEH64W473yhG5L6phJt8LILy
	 MasQKwEtENRz2YZkNFsXQDoq+gJnrH35REQulIPYZHkcmrmZFzxrcOBluo+tRMEXo6jlt
	 PxFZW4aCKMRB/WNBECo0VGsjTBGbi9ReXD2FW+Jv2MRJClE5tXiIgWy2uGgr32/8lZ19s
	 EzLKjjk/TI3RFr8VnOyYzK8d8BkI2aQqOa72lKTZ+T5rl/Y51tYntwDbIdgkyFerG7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b="uft3M/kZ";
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB03606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 23:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EB03606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=uft3M/kZ
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso569345a91.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 15:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794008302; x=1794613102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N4DPvPiEv18XL9E0HU5NSnRDXM9pLl3JEb1r3sKAKNM=;
        b=uft3M/kZNtWMfwjzHoEKEfcv0xeGY1LFpaLGdGijed3dylbSlMh+emOTfhlOLh9Zq7
         nRMyZWZfjTGaYcPX06pV0RViMhCeTv8CWuIbhw4/6gVn/bAtaz2dytdvNQkNPQzEi1eR
         KJ1vTeL5wSX8wMJkHUrNB2uDIaD4LVcxIZ1D7OVRGudzTX6qPX4I8Pnihx7TY6G9gs2K
         yj4u4DHfb7ZVkZS0LemR7LfNMhynMHLYil9YIsnRFPzFo5/usB1LpGMPhb+jwerJwIBk
         zqFTppoT9BI3Qz2q7fEeWTnYDxr8eHrOxbhwyV4M3Ui4UKUawhy/7UkCMCGBFotUEzRz
         pfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794008302; x=1794613102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N4DPvPiEv18XL9E0HU5NSnRDXM9pLl3JEb1r3sKAKNM=;
        b=UrJwCPu2nhZbhJ0DmCJnwa/NpWpEXS1jZIaqFfArzyeoGWU+OuSA08S48tl4xufZQe
         iDVQhSnbc9cjwRlz1ZakIaMF0D23q5fd3BUyq0WpbQE22F0JMo3khHvs9j0BAeXllidl
         QwTgXPvtCLT2K6NL8p4jtrbWGhxNQT8l+RpSyt5qlZlSPZm9XvASbHy7qwZD19gUVFTP
         EPx5BXDcCl+egKeDXOod2shgXh5JPja4vCb/zKk1tCXJatYDxF2yKzVR21+SVcCpcwq9
         v1ykvAfDg3LMJztEiW3CFPDFsiSB0nr9nIBQkcyhJc0mN2sO8EynbPd6Kk/pQq5+jgVm
         a3Kw==
X-Forwarded-Encrypted: i=1; AL+hErHDfxVqujSICI6olS6GP/CknvT+pkCLderB0jZjMShTEqFU//HUIwNnlmWLsPsGH6cKq3OEPO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hr5w27CgUiGsUBg6xi5GlwCpdFEy4JOlhe3YpSlr73vdLsPs7
	G7jwOWC3wQi+DPNM3Yi5krmNq0I74Zxn/YBAqEkz5f1gWzOI3fUEDukutw5CCD6BsA14wFzI4MQ
	nlyzUf1m+YNLizWCw5q3FxeW+dlz40ZwWPno6
X-Gm-Gg: AYBFou3omRRQ/rB2Ym8UglU1fdPPIuR4edEi+3IQ99SOVnuCZ+JveQHUFHk4y1S9csV
	UqVh1tQHSFOrvbjLK9yd6ENiSCRMcuiqWwqzLM8iZl4skA6ykouGzG1rXZc9V5hSxwuY1dt8Vy/
	3aUql7hVURWQGy+tTA9hefJ3O05KaQHsG2TC20Tsum0ZeWedNsZsQAqemhl5UOv300hpZuIEXyp
	JKGw5sWkTSYZ2rvY+lXclSLGvqg5xyfXL4gl4NvwLcp1fc53k8Wt/XZvGHzj6nPJJE5YsxlMJEI
	5thkTMgWJEL0YvsKdxf4nZbgjlBDWC0Lc1eKF2qxg9cMMGflBlqXW4KXF8Nvg6/43e8e6I4Ymgm
	aNWD0BjR7H78aWaXgUj92Fo5bEGXt+FzdcOtfSxk=
X-Received: by 2002:a17:90b:1c0f:b0:3a4:b8dd:1447 with SMTP id 98e67ed59e1d1-3b0db6f69aamr3787723a91.34.1794008301864;
        Fri, 06 Nov 2026 15:38:21 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1058d66absm412329a91.4.2026.11.06.15.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 15:38:21 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 1C11634039C;
	Fri,  6 Nov 2026 15:38:21 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: cel@kernel.org,
	ebadger@everpuredata.com,
	jcurley@everpuredata.com,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	slingappa@everpuredata.com
Subject: Re: [PATCH v2 1/2] SUNRPC: add request-scoped disconnects when cancelling tasks
Date: Fri,  6 Nov 2026 23:38:20 +0000
Message-ID: <20261106233820.2182993-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105170653.3200815-1-tmenninger@everpuredata.com>
References: <20261105170653.3200815-1-tmenninger@everpuredata.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Would retaining the request/connection-generation scope, while removing
> the additional unconditional lock acquisition from xprt_release(), be a
> reasonable direction?

I've posted v3 with the additional unconditional lock acquisition
removed:

    https://lore.kernel.org/all/20261106232844.2176820-1-tmenninger@everpuredata.com

There is still a broader question about when we should cancel I/O in the
first place. This series does not change those cancellation decisions. I
still think the narrower disconnect scope is useful independently of how
we resolve that broader question. Where cancellation does require a
disconnect, it should not also tear down unrelated transports or a
replacement connection generation that did not carry the affected
requests.

I posted v3 to put that narrower change forward for review, not to
suggest that the cancellation-policy question is settled.
