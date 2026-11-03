Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793727229;
	b=ZBRsaOutA+fDI2EhKasGkYGGzNApQJW6tDaOWEtgRS2wVEu26xzrblJxUC2GJU74AGY+
	 eqk8NRjznPBVLnfXWQKWPza0azVDIUX6L153uQMOrK9SSyDf9z2Tdg25n+u+h3MTgoriK
	 uUl70mybYPk+8+1GeEJ1DMbYF/y+lmfaoHmbM94lv/S3i/z+0BkRXZ8lFVirOElylgJOU
	 XRSPvz37vpRzkV2p88DEGFrI8JrvsP6H+IBwjc0PtwPstFmT/qLtHKumNPKttJcbjjYZM
	 0muzQom4byEL1E9haKhepZti/wqxIJfE9XIUq+hAtw0TCFBXVe83ZP6mVS+tfscwMgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7kvZc0WwzYck+poOQJ20Zoq10UgCXsTI0hx1dF0SoGQ=;
	b=HgalnLDkDDkxksrUehch5Nu7FlyuFoGI15RYIe4s1auN1GQHv6GTlj55pXW1yyO5M0P+
	 RDD33i+73TK9yrRMQSGyLrMfTjqq/9GrC5KaqNEisVkP2NF8PohS1P5Noy5/1YnxUKTTN
	 BvtIvfhouLRKQ+SoN/cZVfz33M7NjSIp9JyczLdgZcartm3XWRjXYJYQC5Q+C4bM/dFTm
	 dkJTy9iDvfkVuOLr1uC45Qmgyi3UpC2yhFojYMn2eA4xgzbwOSaN2Mw3wo5IowS35AMgz
	 ezE8Ty0p6kav6SfcyYjr9vYDq2fNYu7wDfPI9yrlqykpug2xwVZTzH88sNGRlZ/dlUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE926606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE926606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36661f953e4so6695856eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 09:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793727221; cv=none;
        d=google.com; s=arc-20260327;
        b=OnHME41f7zoLwaqcjOiiuwIBTpvoW9Nf02VlaPcQiM1ycOdYV6EF0yH3x2GXP2JgM5
         ksdtHbMEkkDWKM9eoCoM6pGNqUbwVadyufaokts2+cR92a/Nc+rfofKdDPOQgFdCBKZj
         Cx1MJFkPjHVg7HqplqacLp/fyX4xEU2yrbCfzjKsjshpE1Rq/56U23s77lvBFKeVEG00
         B0VdUttqTqDQN9eROaU1JoOXeqmzhGW2Nt8/cnsevuKfzPQWailKNvEQJIWKE7M9VTj6
         knOKMbQd3jxPhd0N3IEzXb6Tt/Lp1Pqd3r95WMuNPbIalq03IhEuUV9FPq6h52lXSQbv
         PDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7kvZc0WwzYck+poOQJ20Zoq10UgCXsTI0hx1dF0SoGQ=;
        fh=Je/0tNnthMTYZbOCwhaEQnHzzf3r3DoL1bGf9DkiEA8=;
        b=WeVttFIqUI0opNvJXrwbwVReYhJYMjl5n4lis2R+sGOyNQ75s9fKdFbzy65I7rR/m/
         O626nqNLYueGyk/HOTcazbWIokoSGsuxQMG0OzowH8mFbG2oPm7bzoDk3RAWlXKQ54Hd
         FDt+bGbo1ZeKatUXmIEEqjPglNU36boMnFIBH96SlCO5afTnf5W9wvmWmLhnaHGTwQt5
         4caX95TkPCqZQO+V6FhwGmf1MzS3NTUr6PJZdSPmch/NMpfUJ2LLFc6FcIJSUFLk9Fr5
         gUiFm9XIYMKB4T+j7ilyn6kqmLvivilq1Sp6EWePFCc1t/2Hr5jQCRwup65/4CgL3bvc
         sD6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1793727221; x=1794332021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7kvZc0WwzYck+poOQJ20Zoq10UgCXsTI0hx1dF0SoGQ=;
        b=TFRBLPbhchxEjVic4OjH2G6TlzzzBV6v5GpaZQ4uYVPNG0kcoMKN7kt+p6Jbnbd1/a
         kgiOYnLwfmbMm8v835wlejip6icnD9TlGNpoqTW3NHEUjwkFHJwTqWF+3PxRKxvJFeFN
         qkK46HVPevdP1pD3nFt89lP+7SGf/tC1eS4BzLQj6UOC+akMgDFV/XKbO8eK9NlovlS5
         D49H+w6ot8+kcl4pQvm0uW2n3OmsrfyV3Ooh7iFlbllHQrLeTqWzgzCUy8k7FxOQvlmt
         OReAu8HbDKY33eez0l3l/naoXWGuJavhKDrR1tKj1oXXaDGRMXy4rG1BNP+F7seHMOZT
         jnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793727221; x=1794332021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7kvZc0WwzYck+poOQJ20Zoq10UgCXsTI0hx1dF0SoGQ=;
        b=a6FJ/cOsrnhlOWSpz89161GDg3a+kQ9f7rvv9NuCD5T9My4shCpY021bPVwItao/Gz
         bo0OWZTFYa6MtxVap0EY8c8x0pWqAdXDeZxACTNm8r01bfPEaVu3njn13YVw8A+K2ZV8
         uUVbjIL/SqlCKTMZJmn2eMbY+yS1pxMLPTkHdmfORMdGsMytpMu4FKNZquJGZSmDzKtP
         ksaCMu2XWyes5jot1Q2wo4GL8pKIhVHggptxHzEuswtyDKnSZuaXII/zxZKAsgjS7GcP
         IohBMg7rNyy7KLPd0gPMLZqs5kVVFfuHeT7hoZWgiEtaQr11nBAcQadgOXXkRC5HMTqw
         tD1w==
X-Forwarded-Encrypted: i=1; AKwUvBx4mjBRD1h414frfsLK9msWD6w60rI3LyzogME5d8aifO6a5Ec2VPfC+Kr/HtieWs8/m5ogWPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9A916aGc+tjivo7xHsd2pwQ8xTlbcmjKVg/phNc65LeWaGE8jG
	1lKXAdlpXCptBS6RtupSojVoKfDhGYF/Xl79Tw2eib42ZIkY40+oTxJ057PyiTRzLz0YxY5NyOR
	ugl88xtvlYaVZfsWOL9uyzfH2qxQ9VRE4719yh8tXEmrd8bgR4iEIqqkQBIAk
X-Gm-Gg: AYBFou3TRLjT4jOlLX8X0c5jhTR4j/ygoR8Enkk9V6sZVrKakxPD7e462ePIZSDm6BH
	ul2cfmq6atL9aSTKw+jLb6hZFFdHafAr7f7YwmkUMk8avTXra4LgQod4/mdYfOfnX6A6qiMp49D
	MA6CZHZIhe314TVyYNMTMh5+QyzFPFrKy050ceIYnqNM+PJnCD/jCHCeL22lPtDZ5/9KoCQTBpl
	5bLbRickr9bEYExhcSzbSfsGb5KUfholnu8Zf53zNfHwrzRqxUZz/ES+9Tk2f1NJegPyLWGbcVj
	6emrx7USysBCVmJKcgiz7YAR/Cds3LE8l/4+ZsPUstw4g+3x2RvYAbeXm0gRhQepXK0P4WV3JDD
	PQWb0xgYt7Y+ey6fX15iHJ0Ld60vJkug471xp
X-Received: by 2002:a05:693c:69d2:b0:368:9553:f2da with SMTP id
 5a478bee46e88-36a423f5c39mr22713847eec.31.1793727220500; Tue, 03 Nov 2026
 09:33:40 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029211101.2089535-1-jkain@nuro.ai> <179365451164.3131.3767942488983292@kernel.org>
In-Reply-To: <179365451164.3131.3767942488983292@kernel.org>
From: Joseph Kain <jkain@nuro.ai>
Date: Tue, 3 Nov 2026 09:33:29 -0800
X-Gm-Features: AclHuK_PDtuEdSbv3VB2Euk4_sVkJ92-U7LaM2mWw4pMO2EN7sk9aMuBs79Bl8w
Message-ID: <CA+Y90PiVR8kdiXFuj-M3pfMgidAM8NdJONiEk0jDBtatRLHj0w@mail.gmail.com>
Subject: Re: [PATCH net v7] net: stop defer_count outliving the deferred-free list
To: netdev-bot+sashiko@kernel.org
Cc: edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org, 
	kuniyu@google.com, sdf.kernel@gmail.com, kerneljasonxing@gmail.com, 
	willemb@google.com, almasrymina@google.com, mkarsten@uwaterloo.ca, 
	jiayuan.chen@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 1:21=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> With the subtraction moved after the napi_consume_skb() loop, does
> deferral stay disabled for the whole drain?

Yes, for a full batch. The detached skbs remain charged until the
freeing loop completes; smaller batches can leave capacity for
further admissions. I should have explained this admission-window
change.

Preliminary non-PREEMPT_RT x86 VM tests recorded no limit rejections
in either variant at skb_defer_max=3D128. Results at 16 and 32 showed
mixed rejection and purge counts. Throughput and CPU cost were not
measured, so these results do not establish a performance advantage
for either ordering.

I propose retaining the current single-pass drain for now. If
another revision is needed, I will explicitly document that the
detached batch remains charged until freeing completes.

> This is a pre-existing issue, but can a runtime change to
> net.core.skb_defer_max still leave a per-(cpu, node) queue at or above
> the new limit with no purge pending?

Agreed, and as you say it is pre-existing: neither the reject path nor
proc_do_skb_defer_max() kicks, before or after this patch. Both of your
examples look right to me. It is out of scope for this patch, which is
about counts outliving the list.
