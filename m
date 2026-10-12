Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0429E10F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791779869; cv=none; b=sK0/6Xz5MRLVQ20toP/U9Wv1epNq8zwwrv3IsEPak0O39j6v00kMFRDoTBMw8j/CfSZG2dIxHwePMvPa+aj5WKqwACVpURwioVA640StwQQE/NN2peiLXmX2PFgvx7XidJiTI8ZG1mcYb63vjb2qArWTchQf4KH7GdCoCfRk9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791779869; c=relaxed/simple;
	bh=9L3tqcVuwWT1lsikokZ8qkn9K8zI6RiafRhNL20/m3g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=P8zNTz8Mt3ufPCSpWaJk2B9aFgPjV0Q4J/KbsC0alYFESh2BqWLIf+OCvL5dBdN5ydlwftvK6gGbCiF+955O583QdPmZ0fSN7rACf4ej6ReJCaZzGSmeiHtIvqasT+DOPJVOyXnOaR+nPUzgc82vMIfw8pFbSScufcn9T/Nt04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBOWAIhN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBOWAIhN"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-88b7d853b11so830320b3a.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 21:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791779867; x=1792384667; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9L3tqcVuwWT1lsikokZ8qkn9K8zI6RiafRhNL20/m3g=;
        b=cBOWAIhNKKr0horrqDLF0oKX0DV/YZBB6l2A5kd543PLVYabo406OV+3X61XPZGii0
         /VGhn6wgoIgCNMfNBu2Ohclx7AWVh73yIsxHBApXVKAp7vVSrHmu9JCPnvVDRshIXzht
         7qd1bg19lPI/Bl74ryDn59jT1e5IarUgEb+QC/2RwreB9J95ubAubKddGJzq0l/z8/70
         9hJefnubUZK9lMLOE5vwZoK1yks05NF0eSyzrVVhlhjg1g+j76k/+KONtwje4+Qal2L1
         Ud8n8PohZ2kI4n4LeKPtKethXkkhdapDwcMiLRfzy/Zf5Uzkj/2+sI1DXpMivCpgx+za
         eI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791779867; x=1792384667;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9L3tqcVuwWT1lsikokZ8qkn9K8zI6RiafRhNL20/m3g=;
        b=v01qAWhbav5aHaQI8T9tN02cwLOhsK/nMqt4RcpICk+5mvL7er6vf6VjAPSRVKb/zd
         prVL7GuDkdAsQYWq7dL2vFLaca+ZxZKBOrH1cEnp21fCmpPeyNUtNDQ3zq7lJNnoh8V2
         T4k6dmURkTX8+PK/BP4t+Gh2fLdFFjTtG5q2CnxvNhc3+H1oA/Col0IkVJooWGZP/mRC
         2tgxa+3r36ufzqKj5TqO/ICBP+EmveWEZtL8ytuhxUQBP8YK02N1oev8WBhWvaGLM9fJ
         XY69dmxZDwrQV+LJZ4DYA9YfV9HdNK2eSxxgRMQ8qzQ6GUuqwMIYaTV0EaZiYEaZde/t
         Xv5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTQYeybVD00JOEu0UwEC3SlbszyTFjrM+7gRkaoeGDcw1FHTy+9bZoAlfzlcjOVQZt6nc4J0Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuRzxyN51dBi5nAATh0htGAEAbOOLw7grhnapO8Q0h230971lH
	MYLG2Db5Thpf+VMmNq/9X9sp0WIWuKsoU+ZWD2lAybDUH/H4RdnGw8nI
X-Gm-Gg: AYBFou1j6029GbKLgw1U2dSGXxqYvNscw3luKS5Ijpem6xPpQOzhryC0WznlbPWqBGk
	INbmdNGEBpieRjInm4+0JgQjTB+nguDTnT+i4+zueGGeZh7IJimRNBGr8eqfIdEUscHnFjyiaDc
	0hiwYZzGRpCpeCFOxYSQSYgbc1o1Qnd4CGPyQu8yYs1mYcBI3kfWe505rCsMcoh+vVJN0hyG0Fu
	z9gaRIMqoXVuCdFU1oWOg7DsPpvyx6PARJhwjb3N5YB7VKDBANwxz3UYdXV9ptk4K4UEsd3ivIE
	mQaoPvmbAnqW5TIB+C21Bi8feNpZsIEtWinLe5liItejCfjIhFTP7z1FxhtK6bb0AGanTfyteOp
	9pyMf9EfzK83OaV+OhZ4MqZzIn93tUJoP/dE57qbfBzGRbb0MsdteHtmI5t8tUTiMeCN5E3QuJy
	RpUfdI9b7yKcHTaoTkqIEELwqd/HEUb0Rzlsf5u9iY/tiDmQcI6GkAMTua8Bh1EP28I6q2d/Y=
X-Received: by 2002:a05:6a21:4598:b0:3dd:a195:fa1d with SMTP id adf61e73a8af0-3e16bf3fbbemr6620405637.66.1791779867370;
        Sun, 11 Oct 2026 21:37:47 -0700 (PDT)
Received: from [127.0.0.1] ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da05caaesm3704308a12.32.2026.10.11.21.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:37:46 -0700 (PDT)
Message-ID: <6acc641a.d3162159.e3fd8.3a5c@mx.google.com>
Date: Sun, 11 Oct 2026 21:37:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Bui Viet Dung <dungvn2345@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: stephen@networkplumber.org, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_netem: prevent packet length underflow with negative overhead
In-Reply-To: <179177924024.434549.1159457377130534867@kernel.org>
References: <20261008035656.330667-1-dungvn2345@gmail.com> <179177924024.434549.1159457377130534867@kernel.org>

SGksCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuIFRoZSBwb2ludHMgYXJlIHZhbGlkLiBJIHdpbGwg
Zml4IHRoZSBzMzIgY2FzdGluZwppc3N1ZSwgdXNlIG11bF91NjRfdTY0X2Rpdl91NjQoKSB0byBw
cmV2ZW50IHU2NCBtdWx0aXBsaWNhdGlvbiBvdmVyZmxvdywKYW5kIHJlZmluZSB0aGUgY29tbWl0
IGRlc2NyaXB0aW9uIGluIHYyLgoKcHctYm90OiBjcgo=
